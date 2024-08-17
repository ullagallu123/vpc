data "aws_vpc" "selected" {
  default = true
}

locals {
  name = "${var.project_name}-${var.environment}"
}
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = merge(
    var.vpc_tags,
    var.common_tags,
    {
      Name = local.name
    }

  )
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.igw_tags,
    var.common_tags,
    {
      Name = local.name
    }
  )
}


### public subnets
# creating subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.main.id
  availability_zone       = var.availability_zones[count.index]
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.public_subnet_tags,
    var.common_tags,
    {
      Name = "${local.name}-public-${count.index + 1}"
    }

  )
}

# create public route tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.public_route_table_tags,
    var.common_tags,
    {
      Name = "${local.name}-public"
    }

  )
}

# associate public subnets route table
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# public igw rule
resource "aws_route" "public_igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# peering rule
resource "aws_route" "public_peering" {
  count                     = var.enable_vpc_peering ? 1 : 0
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = data.aws_vpc.selected.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
}

### private subnets

resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = var.private_subnet_cidr_blocks[count.index]
  tags = merge(
    var.private_subnet_tags,
    var.common_tags,
    {
      Name = "${local.name}-private-${count.index + 1}"
    }

  )
}

# create private route tables
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.private_route_table_tags,
    var.common_tags,
    {
      Name = "${local.name}-private"
    }

  )
}

# associate private subnets route table
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# private nat rule
resource "aws_route" "private_nat" {
  count                  = length(aws_nat_gateway.example) > 0 ? 1 : 0
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.example[0].id
}
# peering rule
resource "aws_route" "private_peering" {
  count                     = var.enable_vpc_peering ? 1 : 0
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = data.aws_vpc.selected.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
}

### db subnets

resource "aws_subnet" "db" {
  count             = length(var.db_subnet_cidr_blocks)
  vpc_id            = aws_vpc.main.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = var.db_subnet_cidr_blocks[count.index]
  tags = merge(
    var.db_subnet_tags,
    var.common_tags,
    {
      Name = "${local.name}-db-${count.index + 1}"
    }

  )
}

# create db route tables
resource "aws_route_table" "db" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.db_route_table_tags,
    var.common_tags,
    {
      Name = "${local.name}-db"
    }

  )
}

# associate db subnets route table
resource "aws_route_table_association" "db" {
  count          = length(aws_subnet.db)
  subnet_id      = aws_subnet.db[count.index].id
  route_table_id = aws_route_table.db.id
}
# db nat rule
resource "aws_route" "db_nat" {
  count                  = length(aws_nat_gateway.example) > 0 ? 1 : 0
  route_table_id         = aws_route_table.db.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.example[0].id
}

# db peering rule
resource "aws_route" "db_peering" {
  count                     = var.enable_vpc_peering ? 1 : 0
  route_table_id            = aws_route_table.db.id
  destination_cidr_block    = data.aws_vpc.selected.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
}


# DB subnet group

resource "aws_db_subnet_group" "default" {
  count      = length(aws_subnet.db) >= 2 ? 1 : 0                    // Create only if more than 2 subnets
  subnet_ids = length(aws_subnet.db) >= 2 ? aws_subnet.db[*].id : [] // Use subnet IDs if more than 2 subnets
  name       = local.name
  tags = merge(
    var.db_subnet_group_tags,
    var.common_tags,
    {
      Name = local.name
    }
  )
}

resource "aws_eip" "example" {
  count  = var.enable_nat_gateway ? 1 : 0
  domain = "vpc"
  tags = merge(
    var.eip_tags,
    var.common_tags,
    {
      Name = local.name
    }
  )
}

resource "aws_nat_gateway" "example" {
  count         = length(aws_subnet.private) > 0 && length(aws_eip.example) > 0 ? 1 : 0
  allocation_id = aws_eip.example[count.index].id
  subnet_id     = aws_subnet.public[0].id
  tags = merge(
    var.nat_gateway_tags,
    var.common_tags,
    {
      Name = local.name
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}


# VPC peering

resource "aws_vpc_peering_connection" "peering" {
  count       = var.enable_vpc_peering ? 1 : 0
  vpc_id      = aws_vpc.main.id
  peer_vpc_id = var.acceptor_vpc_id == "" ? data.aws_vpc.selected.id : var.acceptor_vpc_id
  auto_accept = var.acceptor_vpc_id == "" ? true : false
  tags = merge(
    var.vpc_peering_tags,
    var.common_tags,
    {
      Name = local.name
    }

  )
}

resource "aws_route" "default_peering" {
  count                     = var.enable_vpc_peering ? 1 : 0
  route_table_id            = data.aws_vpc.selected.main_route_table_id
  destination_cidr_block    = var.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peering[0].id
}

# VPC Flow Logs

resource "aws_cloudwatch_log_group" "vpc_log_group" {
  count             = var.enable_vpc_flow_logs ? 1 : 0
  name              = "vpc-flow-logs"
  retention_in_days = 7
}

resource "aws_iam_role" "vpc_flow_log_role" {
  count = var.enable_vpc_flow_logs ? 1 : 0
  name  = "vpcFlowLogRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "vpc-flow-logs.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "vpc_flow_log_policy" {
  count = var.enable_vpc_flow_logs ? 1 : 0
  role  = aws_iam_role.vpc_flow_log_role[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Effect   = "Allow"
      Resource = "${aws_cloudwatch_log_group.vpc_log_group[0].arn}:*"
    }]
  })
}

resource "aws_flow_log" "vpc_flow_logs" {
  count                = var.enable_vpc_flow_logs ? 1 : 0
  log_destination      = aws_cloudwatch_log_group.vpc_log_group[0].arn
  log_destination_type = "cloud-watch-logs"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.main.id
  iam_role_arn         = aws_iam_role.vpc_flow_log_role[0].arn
}
