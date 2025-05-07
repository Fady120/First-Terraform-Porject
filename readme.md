# 🌐 Terraform AWS Infrastructure Project

This project provisions a complete AWS infrastructure using Terraform. It includes a Virtual Private Cloud (VPC), public and private subnets, security groups, and EC2 instances for an application server and a database server. The infrastructure is modularized for reusability and scalability.

---

## 📂 Project Structure

```
terraform first project/
├── main.tf                # Main entry point for Terraform configuration
├── variables.tf           # Global variables for the project
├── outputs.tf             # Outputs for the project
├── modules/               # Directory containing reusable Terraform modules
│   ├── vpc/               # Module for creating the VPC
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── public-network/    # Module for creating public subnets and resources
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── private-network/   # Module for creating private subnets and resources
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── ec2/               # Module for provisioning EC2 instances
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── templates/     # User data scripts for EC2 instances
│           ├── app_server_user_data.sh
│           ├── db_server_user_data.sh
├── architecture.gif       # GIF image illustrating the architecture
```

---

## 🏗️ Architecture

The infrastructure created by this project is designed to be secure, scalable, and modular. Below is an overview of the architecture:

![AWS Architecture](./Architecture.gif)

### Key Components of the Architecture:

- **VPC**: A Virtual Private Cloud (VPC) is created to isolate resources within a private network.
- **Public Subnet**: A public subnet is provisioned for resources that need internet access, such as the application server.
- **Private Subnet**: A private subnet is provisioned for resources that should not be exposed to the internet, such as the database server.
- **Internet Gateway**: An internet gateway is attached to the VPC to enable internet access for resources in the public subnet.
- **NAT Gateway**: A NAT gateway is used to allow resources in the private subnet to access the internet securely.
- **Security Groups**: Security groups are configured to control inbound and outbound traffic for the EC2 instances.
- **EC2 Instances**:
  - **Application Server**: Hosts a Docker container running phpMyAdmin.
  - **Database Server**: Hosts a Docker container running MySQL.

---

## ✨ Key Features

- **State Management**: Terraform state is stored in an S3 bucket with locking enabled to prevent concurrent modifications.
- **Modular Design**: The project is divided into reusable modules for better organization and scalability.
- **Customizable**: Variables allow you to customize the infrastructure to suit your needs.
- **Secure**: Security groups are configured to control access to resources.

---

## ✅ Prerequisites

- 🖥️ Terraform installed on your local machine.
- 🔑 AWS CLI configured with appropriate credentials.
- 🔐 An existing SSH key pair in AWS for EC2 instances.

---

## 🚀 Usage

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd "terraform first project"
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Review and customize variables** in `variables.tf` or override them using a `terraform.tfvars` file.

4. **Plan the infrastructure**:
   ```bash
   terraform plan
   ```

5. **Apply the configuration**:
   ```bash
   terraform apply
   ```

6. **Destroy the infrastructure** when no longer needed:
   ```bash
   terraform destroy
   ```

---

## 📋 Variables

The project uses the following variables:

- **Global Variables** (defined in `variables.tf`):
  - `region`: 🌍 AWS region to deploy resources (default: `eu-north-1`).
  - `name_prefix`: 🏷️ Prefix for resource names (default: `dev`).
  - `key_name`: 🔑 Name of the SSH key pair.

- **Module-Specific Variables**:
  - **VPC Module**:
    - `vpc_cidr_block`: 📡 CIDR block for the VPC (default: `10.0.0.0/16`).
    - `enable_dns_hostnames`: 🖧 Enable DNS hostnames in the VPC (default: `true`).
  - **Public Network Module**:
    - `public_subnet_cidr`: 🌐 CIDR block for the public subnet (default: `10.0.1.0/24`).
  - **Private Network Module**:
    - `private_subnet_cidr`: 🔒 CIDR block for the private subnet (default: `10.0.2.0/24`).
  - **EC2 Module**:
    - `app_server_ami`: 💻 AMI ID for the application server.
    - `db_server_ami`: 🗄️ AMI ID for the database server.

---

## 📤 Outputs

The project provides the following outputs:

- `vpc_id`: 🏠 ID of the VPC.
- `public_subnet_id`: 🌐 ID of the public subnet.
- `private_subnet_id`: 🔒 ID of the private subnet.
- `app_server_id`: 💻 ID of the application server instance.
- `db_server_id`: 🗄️ ID of the database server instance.

---

## 🗂️ Backend Configuration

The Terraform state is stored in an S3 bucket for remote state management. The backend configuration is defined in the `main.tf` file:

```terraform
backend "s3" {
  bucket       = "fedo-terraform-backend"
  key          = "terraform.tfstate"
  region       = "eu-north-1"
  encrypt      = true
  use_lockfile = true
}
```

---

## 📜 User Data Scripts

- **App Server**: Configures a Docker container running phpMyAdmin. 🐳
- **Database Server**: Configures a Docker container running MySQL. 🐬