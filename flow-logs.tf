resource "aws_flow_log" "example" {
  count = var.vpc_flow_logs ? 1 : 0
  iam_role_arn    = aws_iam_role.example.arn
  log_destination = aws_cloudwatch_log_group.example.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
}


