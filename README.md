# AWS Infrastructure Automation with Terraform

This project automates the deployment of a highly available AWS infrastructure. It features EC2 instances distributed across public and private subnets, managed by an Application Load Balancer (ALB) and configured via Terraform and dynamic data scripts.

## 🏗️ Architecture Overview

*   **VPC Networking**: A custom VPC with public and private subnets.
*   **Public EC2**: Accessible from the internet, serving as a gateway or bastion.
*   **Private EC2**: Secure instances without direct public internet access, receiving traffic via the Load Balancer.
*   **Load Balancer (ALB)**: Routes public HTTP traffic to the private EC2 instances.
*   **User Data**: Automated shell/YAML scripts used for instance initialization and package installation.

## 📁 Project Structure

*   `main.tf`: Core infrastructure definitions (VPC, Subnets, Gateways).
*   `ec2.tf`: Configuration for public and private EC2 instances.
*   `alb.tf`: Application Load Balancer, Listeners, and Target Group settings.
*   `variables.tf`: Configurable parameters (Region, Instance Types, etc.).
*   `scripts/`: Contains YAML or shell data scripts for EC2 bootstrapping.

## 🚀 Getting Started

### Prerequisites

*   [Terraform](https://hashicorp.com) installed on your system.
*   An active **AWS Account** with configured credentials via the AWS CLI.
*   SSH Key Pair created in your AWS region for instance access.

### Deployment Steps

1.  **Initialize the project**:
    Download necessary providers and initialize the backend.
    ```bash
    git init
    terraform init
    ```

2.  **Review the plan**:
    Check the resources Terraform will create before applying changes.
    ```bash
    terraform plan
    ```

3.  **Apply the configuration**:
    Deploy the infrastructure to your AWS account.
    ```bash
    terraform apply -auto-approve
    ```

## 🛠️ Usage & Access

*   **Public Access**: You can access the public EC2 via SSH using your key pair.
*   **Private Access**: Connect to private instances through the public instance (Bastion) or verify web traffic through the **Load Balancer DNS Name**.
*   **Load Balancer URL**: After successful deployment, Terraform outputs the DNS name of your ALB. Paste this into your browser to verify connectivity to the private instances.

## 🧹 Cleanup

To avoid unnecessary AWS charges, destroy the infrastructure when you are finished:
```bash
terraform destroy -auto-approve
