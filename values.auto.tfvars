
project_name         = "ugl"
environemt           = "test"
vpc_cidr             = "10.0.0.0/16"
enable_dns_hostnames = true
enable_dns_support   = true
nat                  = false

azs                  = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
db_subnet_cidrs      = ["10.0.21.0/24", "10.0.22.0/24"]

common_tags = {
"Terraform"   = true
"Project"     = "K"
"Environment" = "Test"
"Developer"   = "Siva"
"Module"      = "VPC"
}