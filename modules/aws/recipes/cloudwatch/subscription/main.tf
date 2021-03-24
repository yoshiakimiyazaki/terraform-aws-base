#--------------------------------------------------------------
# Provides an IAM role.
#--------------------------------------------------------------
resource "aws_iam_role" "this" {
  description        = lookup(var.aws_iam_role, "description", null)
  name               = lookup(var.aws_iam_role, "name")
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "logs.${var.region}.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
POLICY
  path               = lookup(var.aws_iam_role, "path", "/")
  tags               = var.tags
}
#--------------------------------------------------------------
# Generates an IAM policy document in JSON format for use with resources that expect policy documents such as aws_iam_policy.
#--------------------------------------------------------------
data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch"
    ]
    resources = [
      "arn:aws:firehose:${var.region}:${var.account_id}:deliverystream/*"
    ]
  }
}

#--------------------------------------------------------------
# Provides an IAM policy.
#--------------------------------------------------------------
resource "aws_iam_policy" "this" {
  description = lookup(var.aws_iam_policy, "description", null)
  name        = lookup(var.aws_iam_policy, "name")
  path        = lookup(var.aws_iam_policy, "path", "/")
  policy      = data.aws_iam_policy_document.this.json
}
#--------------------------------------------------------------
# Attaches a Managed IAM Policy to an IAM role
#--------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
#--------------------------------------------------------------
# Provides a CloudWatch Logs subscription filter resource.
#--------------------------------------------------------------
resource "aws_cloudwatch_log_subscription_filter" "this" {
  count           = length(var.aws_cloudwatch_log_subscription_filter)
  name            = lookup(var.aws_cloudwatch_log_subscription_filter[count.index], "name")
  destination_arn = lookup(var.aws_cloudwatch_log_subscription_filter[count.index], "destination_arn")
  filter_pattern  = lookup(var.aws_cloudwatch_log_subscription_filter[count.index], "filter_pattern", null)
  log_group_name  = lookup(var.aws_cloudwatch_log_subscription_filter[count.index], "log_group_name")
  role_arn        = aws_iam_role.this.arn
  distribution    = lookup(var.aws_cloudwatch_log_subscription_filter[count.index], "distribution", "Random")
}
