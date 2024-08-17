# Custom AWS VPC Module

This Terraform module creates a customizable Virtual Private Cloud (VPC) on AWS along with necessary subnets, route tables, internet gateways, NAT gateways, and VPC peering connections.

## Features

- **VPC**
- **2 Public Subnets**
- **2 Private Subnets**
- **2 DB Subnets**
- **Internet Gateway (IGW)**
- **Public Route Table**
- **Private Route Table**
- **DB Route Table**
- **Route Table Associations**
- **Elastic IP (EIP)**
- **NAT Gateway**
- **Updating Routing Rule in Public Route Table**
- **Updating Routing Rule in Private and DB Route Tables**
- **DB Subnet Group**
- **VPC Peering**
- **Adding Routing Rules in Requester and Acceptor Routing Tables**
- **VPC flow logs CloudWatch**
Here's the modified table to reflect the variables provided:

## Inputs

| Name                     | Description                                                | Type   | Default | Required |
|--------------------------|------------------------------------------------------------|--------|---------|----------|
| environment              | The environment for the VPC (e.g., dev, staging, prod)     | string | ""      | yes      |
| project_name             | The name of the project                                    | string | ""      | yes      |
| common_tags              | A map of common tags to apply to all resources             | map    | {}      | no       |
| availability_zones       | A list of availability zones to use for the subnets        | list   | []      | yes      |
| vpc_cidr_block           | CIDR block for the VPC                                     | string | ""      | yes      |
| enable_dns_hostnames     | Enable or disable DNS hostnames in the VPC                 | bool   | true    | no       |
| enable_dns_support       | Enable or disable DNS support in the VPC                   | bool   | true    | no       |
| vpc_tags                 | A map of tags to apply to the VPC                          | map    | {}      | no       |
| igw_tags                 | A map of tags to apply to the Internet Gateway             | map    | {}      | no       |
| public_subnet_cidr_blocks| A list of CIDR blocks for the public subnets               | list   | []      | yes      |
| public_subnet_tags       | A map of tags to apply to the public subnets               | map    | {}      | no       |
| public_route_table_tags  | A map of tags to apply to the public route tables          | map    | {}      | no       |
| private_subnet_cidr_blocks| A list of CIDR blocks for the private subnets             | list   | []      | yes      |
| private_subnet_tags      | A map of tags to apply to the private subnets              | map    | {}      | no       |
| private_route_table_tags | A map of tags to apply to the private route tables         | map    | {}      | no       |
| db_subnet_cidr_blocks    | A list of CIDR blocks for the database subnets             | list   | []      | yes      |
| db_subnet_tags           | A map of tags to apply to the database subnets             | map    | {}      | no       |
| db_route_table_tags      | A map of tags to apply to the database route tables        | map    | {}      | no       |
| db_subnet_group_tags     | A map of tags to apply to the database subnet group        | map    | {}      | no       |
| nat_gateway_tags         | A map of tags to apply to the NAT Gateway                  | map    | {}      | no       |
| enable_nat_gateway       | Enable or disable the creation of NAT Gateways             | bool   | false   | no       |
| enable_vpc_peering       | Enable or disable VPC peering                              | bool   | false   | no       |
| acceptor_vpc_id          | The ID of the acceptor VPC for the peering connection      | string | ""      | no       |
| vpc_peering_tags         | A map of tags to apply to the VPC peering connection       | map    | {}      | no       |
| eip_tags                 | A map of tags to apply to Elastic IP (EIP)                 | map    | {}      | no       |
| enable_vpc_flow_logs     | Enable or disable VPC Flow Logs                            | bool   | false   | no       |

This table aligns with the environment and variable configuration provided.

## Outputs

| Name                   | Description                      |
|------------------------|----------------------------------|
|   VPC id               | The ID of the created VPC        |
|   Public Subnets ids   | The IDs of the public subnets    |
|   Private Subnets ids  | The IDs of the private subnets   |
|   DB Subnets ids       | The IDs of the db subnets        |

## Usage Example

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.63.0"
    }
  }
}

provider "aws" {
  profile = "nv"
  region  = "us-east-1"
}


module "vpc_test" {
  source               = "git::https://github.com/ullagallu123/vpc.git?ref=main"
  environment          = "dev"
  project_name         = "test-project"
  common_tags          = { "Project" = "Test", "Environment" = "dev" }
  availability_zones   = ["us-east-1a", "us-east-1b"]
  vpc_cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  vpc_tags             = { "Name" = "test-vpc" }
  igw_tags             = { "Name" = "test-igw" }

  public_subnet_cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnet_tags        = { "Name" = "test-public-subnet" }
  public_route_table_tags   = { "Name" = "test-public-rt" }

  private_subnet_cidr_blocks = ["10.0.3.0/24", "10.0.4.0/24"]
  private_subnet_tags        = { "Name" = "test-private-subnet" }
  private_route_table_tags   = { "Name" = "test-private-rt" }

  db_subnet_cidr_blocks = ["10.0.5.0/24", "10.0.6.0/24"]
  db_subnet_tags        = { "Name" = "test-db-subnet" }
  db_route_table_tags   = { "Name" = "test-db-rt" }
  db_subnet_group_tags  = { "Name" = "test-db-subnet-group" }

  nat_gateway_tags   = { "Name" = "test-nat-gateway" }
  enable_nat_gateway = true

  enable_vpc_peering = false
  acceptor_vpc_id    = ""
  vpc_peering_tags   = {}

  eip_tags             = { "Name" = "test-eip" }
  enable_vpc_flow_logs = false
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc_test.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc_test.public_subnets_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc_test.private_subnets_ids
}

output "db_subnet_ids" {
  description = "List of DB subnet IDs"
  value       = module.vpc_test.db_subnets_ids
}
output "db_subnet_group_name" {
  description = "Name of DB Subnet Group Name"
  value       = module.vpc_test.db_subnet_group_name
}
```

## Authors

- KONKA SIVA RAMA KRISHNA
