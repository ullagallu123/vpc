output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [for pub_sub in aws_subnet.public : pub_sub.id]
}

output "private_subnet_ids" {
  value = [for pri_sub in aws_subnet.private : pri_sub.id]
}

output "db_subnet_ids" {
  value = [for db_sub in aws_subnet.db : db_sub.id]
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.default[0].name
}
