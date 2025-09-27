#!/usr/bin/env bash

set -xe

# Update system
apt-get update -y
apt-get upgrade -y

# Install Amazon SSM Agent
snap install amazon-ssm-agent --classic

# Enable and start the service
systemctl enable snap.amazon-ssm-agent.amazon-ssm-agent.service
systemctl start snap.amazon-ssm-agent.amazon-ssm-agent.service
