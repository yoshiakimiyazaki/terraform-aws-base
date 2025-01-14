output "id" {
  description = "Name of the recorder"
  value       = var.is_enabled ? aws_config_configuration_recorder.this[0].id : null
}
output "arn" {
  description = "The Amazon Resource Name (ARN) of the rule"
  value       = var.is_enabled ? aws_cloudwatch_event_rule.this[0].arn : null
}
