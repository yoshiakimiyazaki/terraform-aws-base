#--------------------------------------------------------------
# module variables
#--------------------------------------------------------------
variable "aws_cloudwatch_event_rule" {
  type = object(
    {
      # (Required) The name of the rule. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix.
      name = string
      # (Optional) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule_expression or event_pattern is required. Can only be used on the default event bus.
      schedule_expression = string
      # (Optional) The description of the rule.
      description = string
      # (Optional) Whether the rule should be enabled (defaults to true).
      is_enabled = bool
    }
  )
  description = "(Required) Provides an EventBridge Rule resource."
  default = {
    name                = "trusted-advisor-cloudwatch-event-rule"
    schedule_expression = "cron(*/5 * * * ? *)"
    description         = "Trusted Advisor event rule."
    role_arn            = null
    is_enabled          = true
  }
}
variable "aws_cloudwatch_event_target" {
  type = object(
    {
      # (Required) The Amazon Resource Name (ARN) associated of the target.
      arn = string
    }
  )
  description = "(Required) Provides an EventBridge Target resource."
  default     = null
}
variable "tags" {
  type        = map(any)
  description = "(Optional) Key-value map of resource tags."
  default     = null
}