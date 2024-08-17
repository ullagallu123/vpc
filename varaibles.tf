# Environment variables
variable "environment" {
  description = "The environment for the VPC (e.g., dev, staging, prod)"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = ""
}

# Common variables
variable "common_tags" {
  description = "A map of common tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "availability_zones" {
  description = "A list of availability zones to use for the subnets"
  type        = list(string)
  default     = []
}

# VPC variables
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "enable_dns_hostnames" {
  description = "Enable or disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable or disable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "A map of tags to apply to the VPC"
  type        = map(string)
  default     = {}
}

# Internet Gateway (IGW) variables
variable "igw_tags" {
  description = "A map of tags to apply to the Internet Gateway"
  type        = map(string)
  default     = {}
}

# Public subnet variables
variable "public_subnet_cidr_blocks" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
  default     = []
}

variable "public_subnet_tags" {
  description = "A map of tags to apply to the public subnets"
  type        = map(string)
  default     = {}
}

variable "public_route_table_tags" {
  description = "A map of tags to apply to the public route tables"
  type        = map(string)
  default     = {}
}

# Private subnet variables
variable "private_subnet_cidr_blocks" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
  default     = []
}

variable "private_subnet_tags" {
  description = "A map of tags to apply to the private subnets"
  type        = map(string)
  default     = {}
}

variable "private_route_table_tags" {
  description = "A map of tags to apply to the private route tables"
  type        = map(string)
  default     = {}
}

# Database subnet variables
variable "db_subnet_cidr_blocks" {
  description = "A list of CIDR blocks for the database subnets"
  type        = list(string)
  default     = []
}

variable "db_subnet_tags" {
  description = "A map of tags to apply to the database subnets"
  type        = map(string)
  default     = {}
}

variable "db_route_table_tags" {
  description = "A map of tags to apply to the database route tables"
  type        = map(string)
  default     = {}
}

variable "db_subnet_group_tags" {
  description = "A map of tags to apply to the database subnet group"
  type        = map(string)
  default     = {}
}

# NAT Gateway variables
variable "nat_gateway_tags" {
  description = "A map of tags to apply to the NAT Gateway"
  type        = map(string)
  default     = {}
}

variable "enable_nat_gateway" {
  description = "Enable or disable the creation of NAT Gateways"
  type        = bool
  default     = false
}

# VPC Peering variables
variable "enable_vpc_peering" {
  description = "Enable or disable VPC peering"
  type        = bool
  default     = false
}

variable "acceptor_vpc_id" {
  description = "The ID of the acceptor VPC for the peering connection"
  type        = string
  default     = ""
}

variable "vpc_peering_tags" {
  description = "A map of tags to apply to the VPC peering connection"
  type        = map(string)
  default     = {}
}

# Elastic IP (EIP) variables
variable "eip_tags" {
  description = "A map of tags to apply to Elastic IP (EIP)"
  type        = map(string)
  default     = {}
}

# VPC Flow Logs variables
variable "enable_vpc_flow_logs" {
  description = "Enable or disable VPC Flow Logs"
  type        = bool
  default     = false
}
