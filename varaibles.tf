# Environment variables
variable "environemt" {
  description = "The environment for the VPC (e.g., dev, staging, prod)"
  default     = ""
}

variable "project_name" {
  description = "The name of the project"
  default     = ""
}

# Common variables
variable "common_tags" {
  description = "A map of tags to apply to all resources"
  default     = {}
}

variable "azs" {
  description = "A list of availability zones to use for the subnets"
  default     = []
}

# VPC variables
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = ""
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  default     = true
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC"
  default     = true
}

variable "vpc_tags" {
  description = "A map of tags to apply to the VPC"
  default     = {}
}

# IGW variables
variable "igw_tags" {
  description = "A map of tags to apply to the Internet Gateway"
  default     = {}
}

# Public subnet variables
variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets"
  default     = []
}

variable "public_subnet_tags" {
  description = "A map of tags to apply to the public subnets"
  default     = {}
}

variable "public_rtg_tags" {
  description = "A map of tags to apply to the public route tables"
  default     = {}
}

# Private subnet variables
variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets"
  default     = []
}

variable "private_subnet_tags" {
  description = "A map of tags to apply to the private subnets"
  default     = {}
}

variable "private_rtg_tags" {
  description = "A map of tags to apply to the private route tables"
  default     = {}
}

# DB subnet variables
variable "db_subnet_cidrs" {
  description = "A list of CIDR blocks for the database subnets"
  default     = []
}

variable "db_subnet_tags" {
  description = "A map of tags to apply to the database subnets"
  default     = {}
}

variable "db_rtg_tags" {
  description = "A map of tags to apply to the database route tables"
  default     = {}
}

variable "db_group_tags" {
  description = "A map of tags to apply to the database subnet group"
  default     = {}
}

variable "nat_tags" {
  description = "A map of tags to apply to the NAT Gateway"
  default     = {}
}

variable "nat" {
  description = "A boolean flag to enable/disable the creation of NAT Gateways"
  default     = false
}

# VPC Peering variables
variable "peering" {
  description = "A boolean flag to enable/disable VPC peering"
  default     = false
}

variable "acceptor_vpc_id" {
  description = "The ID of the acceptor VPC for the peering connection"
  default     = ""
}

variable "vpc_peering_tags" {
  description = "A map of tags to apply to the VPC peering connection"
  default     = {}
}
