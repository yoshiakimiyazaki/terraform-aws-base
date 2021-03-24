#--------------------------------------------------------------
# module variables
#--------------------------------------------------------------
variable "aws_iam_group_policy_attachment" {
  type = list(object(
    {
      # (Required) - The group the policy should be applied to
      group = string
      # (Required) - The ARN of the policy you want to apply
      policy_arn = string
    }
    )
  )
  description = "(Required) - Attaches a Managed IAM Policy to an IAM group"
  default     = null
}
