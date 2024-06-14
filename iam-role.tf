resource "aws_cloudwatch_log_group" "example" {
  count = var.vpc_flow_logs ? 1 : 0
  name = "${local.name}-${var.log_group_name}"
}

data "aws_iam_policy_document" "assume_role" {
  count = var.vpc_flow_logs ? 1 : 0
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "example" {
  count = var.vpc_flow_logs ? 1 : 0
  name               = "${local.name}-${var.iam_role_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "example" {
  count = var.vpc_flow_logs ? 1 : 0
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "example" {
  count = var.vpc_flow_logs ? 1 : 0
  name   = "${local.name}-${var.iam_policy_name}"
  role   = aws_iam_role.example.id
  policy = data.aws_iam_policy_document.example.json
}