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

## Inputs

| Name                   | Description                                                | Type   | Default | Required |
|------------------------|------------------------------------------------------------|--------|---------|----------|
| * environemt           | User should mention their environment                      | string |         | yes      |
| * project_name         | User should mention their project name                     | string |         | yes      |
| * common_tags          | A map of common tags to apply to all resources             | map    | {}      | no       |
| * azs                  | List of availability zones to use for the subnets          | list   | []      | yes      |
| * vpc_cidr             | CIDR block for the VPC                                     | string |         | yes      |
| * enable_dns_hostnames | Boolean to enable/disable DNS hostnames in the VPC         | bool   |         | yes      |
| * enable_dns_support   | Boolean to enable/disable DNS support in the VPC           | bool   |         | yes      |
| * vpc_tags             | A map of tags to apply to the VPC                          | map    | {}      | no       |
| * igw_tags             | A map of tags to apply to the Internet Gateway             | map    | {}      | no       |
| * public_subnet_cidrs  | List of CIDR blocks for the public subnets                 | list   | []      | yes      |
| * public_subnet_tags   | A map of tags to apply to the public subnets               | map    | {}      | no       |
| * public_rtg_tags      | A map of tags to apply to the public route tables          | map    | {}      | no       |
| * private_subnet_cidrs | List of CIDR blocks for the private subnets                | list   | []      | yes      |
| * private_subnet_tags  | A map of tags to apply to the private subnets              | map    | {}      | no       |
| * private_rtg_tags     | A map of tags to apply to the private route tables         | map    | {}      | no       |
| * db_subnet_cidrs      | List of CIDR blocks for the database subnets               | list   | []      | yes      |
| * db_subnet_tags       | A map of tags to apply to the database subnets             | map    | {}      | no       |
| * db_rtg_tags          | A map of tags to apply to the database route tables        | map    | {}      | no       |
| * db_group_tags        | A map of tags to apply to the database subnet group        | map    | {}      | no       |
| * nat_tags             | A map of tags to apply to the NAT Gateway                  | map    | {}      | no       |
| * nat                  | Boolean to enable/disable the creation of NAT Gateways     | bool   | false   | no       |
| * peering              | Boolean to enable/disable VPC peering                      | bool   | false   | no       |
| * acceptor_vpc_id      | ID of the acceptor VPC for the peering connection          | string | ""      | no       |
| * vpc_peering_tags     | A map of tags to apply to the VPC peering connection       | map    | {}      | no       |

## Outputs

| Name                   | Description                      |
|------------------------|----------------------------------|
| * VPC id               | The ID of the created VPC        |
| * Public subnets ids   | The IDs of the public subnets    |
| * Private Subnet ids   | The IDs of the private subnets   |
| * DB Subnet Group Name | DB Group Name                    |

## Usage Example

```hcl
module "custom_vpc" {
  source = "path_to_this_module"

  environemt            = "dev"
  project_name          = "my_project"
  azs                   = ["us-east-1a", "us-east-1b"]
  vpc_cidr              = "10.0.0.0/16"
  enable_dns_hostnames  = true
  enable_dns_support    = true
  public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs  = ["10.0.3.0/24", "10.0.4.0/24"]
  db_subnet_cidrs       = ["10.0.5.0/24", "10.0.6.0/24"]
  nat                   = true
  peering               = true
  acceptor_vpc_id       = "vpc-xxxxxx"
  
  common_tags = {
    Environment = "dev"
    Project     = "my_project"
  }
}
```

## Authors

- KONKA SIVA RAMA KRISHNA
