# Three-Tier AWS Infrastructure — Provisioned with Terraform

## Project Overview

This repository contains the foundational architecture for deploying a **secure, scalable, and maintainable three-tier infrastructure on AWS**.

The design follows AWS best practices for high availability, fault tolerance, and environment isolation. It provides a flexible foundation suitable for hosting modern web applications — such as Magento, WordPress, or any custom-built app — across multiple Availability Zones.

### Status

![Architecture Status](https://img.shields.io/badge/Architecture-Complete-blue)
![Application Setup](https://img.shields.io/badge/Application_Setup-On_going-yellow)

---

## Architecture Overview

### 🧱 Layers

The architecture is built on a **Three-Tier Model**:

1. **Presentation (Web) Tier**
   - Public subnets with **NAT Gateways** for outbound internet access.
   - **Internet Gateway** for inbound and outbound connectivity for external users.

2. **Application (App) Tier**
   - EC2 instances (App Servers) deployed in **private subnets**.
   - Accesses the database and file system tiers through internal routing.

3. **Database (Data) Tier**
   - Amazon **RDS MySQL** (Primary and Replica) planned for deployment in private subnets.
   - Designed for data replication, high availability, and security.
   - **Elastic File System (EFS)** used for shared application storage across EC2 instances.

---

## Current Architecture Diagram

![Three-Tier AWS Architecture](./terraform-aws-three-tier-architecture.svg)

### Key Components

- **VPC (172.0.0.0/16)** spanning multiple Availability Zones (`us-east-1a`, `us-east-1b`)
- **Public Subnets**
  - Contain NAT Gateways for secure outbound traffic from private instances.

- **Private Subnets**
  - Host EC2 App Servers and RDS instances.

- **Elastic File System (EFS)**
  - Shared storage accessible from application servers.

- **Security Groups**
  - Separate groups for EC2, MySQL, and EFS to enforce least-privilege access.

- **High Availability**
  - Multi-AZ design for redundancy and fault tolerance.

---

## Completed Features

### ✅ Infrastructure as Code (IaC)

- Modular **Terraform** configuration for reusable networking, compute, and security components.

### ✅ Networking

- Custom **VPC**, route tables, **public and private subnets**, **NAT Gateways**, and **Internet Gateway**.

### ✅ Compute

- Deployed **EC2 instances** in private subnets for the application tier.
- Configured **security groups** and network ACLs.

### ✅ Storage

- Configured **Elastic File System (EFS)** for shared persistent storage across multiple app servers.

### ✅ Security

- Granular **IAM roles and policies**, least-privilege security groups, and isolated subnet design.
- Secure private connectivity between tiers.

---

## In Progress

### 🚧 Database

- **RDS MySQL (Primary & Replica)** configuration and connection testing.
- Parameter tuning, backup, and automated failover setup.

🚧 Application Setup

- Preparing environment for application deployment (e.g., Magento or another web app).
- Testing connectivity between App Tier and Database Tier.
- Automating deployment and configuration scripts.

### 🚧 Monitoring & Logging

- Integrating **CloudWatch metrics, alarms, and dashboards**.
- Planning centralized log management (CloudWatch Logs / AWS OpenSearch).

### 🚧 Documentation

- Detailed implementation guide and Terraform module documentation are being finalized.

---

## Repository Structure

```bash
.
├── .terraform
│   ├── modules
│   │   └── modules.json
│   └── providers
│       └── registry.terraform.io
├── .terraform.lock.hcl
├── .terraform.log
├── cloud-init
│   ├── configuration
│   │   ├── zsh
│   │   └── zsh-home
│   └── shell-scripts
│       └── bootstrap.sh
├── main.tf
├── modules
│   ├── containers
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── database
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── instances
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── management
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── network
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── notifications
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── scaling
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── security
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── severless
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── storage
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── outputs.tf
├── provider.tf
├── README.md
└── variables.tf
```

---

## Getting Started (Planned)

### Prerequisites

- AWS account with sufficient permissions.
- Terraform installed (version pinned TBD).
- AWS CLI configured.
- Recommended tools: `tflint`, `terraform-docs`, `checkov`.

### Example Setup

```bash
# 1. Clone repository
git clone https://github.com/erikngigi/terraform-aws-three-tier-architecture.git
cd terraform-aws-three-tier-architecture

# 2. Initialize Terraform
terraform init

# 4. Review configuration
terraform plan -var-file=dev.tfvars

# 5. Apply infrastructure
terraform apply -var-file=dev.tfvars
```

---

## Contributing

Contributions are welcome as this project continues to evolve.

**Guidelines:**

- Open an issue before implementing major changes.
- Fork the repo, create a feature branch, and submit a PR with a clear description.
- Run `terraform fmt`, `terraform validate`, and linting before submitting.
- Follow semantic commit message conventions.

Future additions:

- `CONTRIBUTING.md`
- `CODE_OF_CONDUCT.md`
- PR and issue templates.

---

## Roadmap & Milestones

| Milestone              | Description                                 | Status         |
| ---------------------- | ------------------------------------------- | -------------- |
| 🧩 Repository Skeleton | Modules, environment layout, README         | ✅ Completed   |
| 🌐 Networking Layer    | VPC, subnets, routing, IAM roles            | ✅ Completed   |
| 💻 Compute Layer       | EC2 instances, private/public subnets       | ✅ Completed   |
| 📦 Storage Layer       | EFS setup and integration                   | ✅ Completed   |
| 🔐 Security Hardening  | IAM, NACLs, Security Groups                 | ✅ Completed   |
| 🗄️ Database Layer      | RDS MySQL setup and replication             | 🚧 In Progress |
| ⚙️ Application Setup   | Environment prep and app deployment testing | 🚧 In Progress |
| ⚙️ Monitoring          | CloudWatch metrics, logging, alerts         | 🚧 In Progress |
| 📘 Documentation       | Detailed guides and module docs             | 🚧 In Progress |

---

## License

License to be determined.
