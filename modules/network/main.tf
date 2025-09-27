data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index)
  availability_zone       = element(data.aws_availability_zones.available.names, count.index % 2)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = 4
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 4, count.index + 2)
  availability_zone = element(data.aws_availability_zones.available.names, count.index % 2)

  tags = {
    Name = "${var.project_name}-private-subnet-${count.index + 1}"
  }
}

resource "aws_db_subnet_group" "ec2_subnet" {
  name = "${var.project_name}-ec2-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet[0].id,
    aws_subnet.private_subnet[1].id,
  ]

  tags = {
    Name = "${var.project_name}-ec2-subnet-group"
  }
}

resource "aws_db_subnet_group" "mysql_rds_subnet" {
  name = "${var.project_name}-mysql-rds-subnet-group"
  subnet_ids = [
    aws_subnet.private_subnet[2].id,
    aws_subnet.private_subnet[3].id,
  ]

  tags = {
    Name = "${var.project_name}-mysql-rds-subnet-group"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-internet-gateway"
  }
}

resource "aws_eip" "nat" {
  count  = length(aws_subnet.public_subnet)
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = length(aws_subnet.public_subnet)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public_subnet[count.index].id

  tags = {
    Name = "${var.project_name}-nat-gateway-${count.index + 1}"
  }

  depends_on = [aws_internet_gateway.main]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.project_name}-public-route-table"
  }
}

resource "aws_route_table" "private" {
  count  = length(aws_nat_gateway.nat)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = element(aws_route_table.private[*].id, count.index % length(aws_route_table.private))
}

resource "aws_lb" "app_loadbalancer" {
  name               = "${var.project_name}-app-loadbalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.ec2_sg]
  subnets = [
    aws_subnet.public_subnet[0].id,
    aws_subnet.public_subnet[1].id,
  ]
}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "${var.project_name}-target-group-alb"
  port     = var.target_alb_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group_attachment" "ec2_attachment1" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = var.ec2_instance_id1
  port             = var.target_alb_port
  depends_on = [
    aws_lb_target_group.alb_target_group,
  ]
}

resource "aws_lb_target_group_attachment" "ec2_attachment2" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = var.ec2_instance_id2
  port             = var.target_alb_port
  depends_on = [
    aws_lb_target_group.alb_target_group,
  ]
}

resource "aws_lb_listener" "external_elb" {
  load_balancer_arn = aws_lb.app_loadbalancer.arn
  port              = var.target_alb_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}
