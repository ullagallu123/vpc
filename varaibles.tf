# enivronment vairables
variable "environemt" {
  default = ""
}
variable "project_name" {
  default = ""
}

# common vairables
variable "common_tags" {
  default = {}
}
variable "azs" {
  default = []
}
# vpc variables
variable "vpc_cidr" {
  default = ""
}
variable "enable_dns_hostnames" {
  default = true
}
variable "enable_dns_support" {
  default = true
}
variable "vpc_tags" {
  default = {}
}

# IGW variables
variable "igw_tags" {
  default = {}
}

# public subnet variables
variable "public_subnet_cidrs" {
  default = []
}
variable "public_subnet_tags" {
  default = {}
}
variable "public_rtg_tags" {
  default = {}
}

# private subnet variables
variable "private_subnet_cidrs" {
  default = []
}
variable "private_subnet_tags" {
  default = {}
}
variable "private_rtg_tags" {
  default = {}
}

# db subnet variables
variable "db_subnet_cidrs" {
  default = []
}
variable "db_subnet_tags" {
  default = {}
}
variable "db_rtg_tags" {
  default = {}
}

variable "db_group_tags" {
  default = {}
}
variable "nat_tags" {
  default = {}
}

variable "nat" {
  default = false
}

variable "peering" {
  default = false
}

variable "acceptor_vpc_id" {
  default = ""
}