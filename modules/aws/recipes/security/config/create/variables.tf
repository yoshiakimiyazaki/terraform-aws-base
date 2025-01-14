#--------------------------------------------------------------
# module variables
#--------------------------------------------------------------
variable "is_enabled" {
  type        = bool
  description = "(Optional) A boolean flag to enable/disable AWS Config. Defaults true."
  default     = true
}
variable "aws_config_configuration_recorder" {
  type = object(
    {
      name            = string
      recording_group = list(any)
    }
  )
  description = "(Required) The aws_config_configuration_recorder resource."
}

variable "aws_iam_role" {
  type = object(
    {
      # (Optional) Description of the role.
      description = string
      # (Optional, Forces new resource) Friendly name of the role. If omitted, Terraform will assign a random, unique name. See IAM Identifiers for more information.
      name = string
      # (Optional) Path to the role. See IAM Identifiers for more information.
      path = string
    }
  )
  description = "(Optional) The aws_iam_role resource."
  default = {
    description = "Role for AWS Config."
    name        = "security-config-role"
    path        = "/"
  }
}

variable "aws_s3_bucket" {
  type = object(
    {
      # The name of the bucket. If omitted, Terraform will assign a random, unique name. Must be less than or equal to 63 characters in length.
      bucket = string
      # A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable.
      force_destroy = bool
      # A state of versioning
      versioning = list(any)
      # A settings of bucket logging
      logging = list(any)
      # A configuration of object lifecycle management
      lifecycle_rule = list(any)
      # A configuration of replication configuration
      replication_configuration = list(any)
      # A configuration of server-side encryption configuration
      server_side_encryption_configuration = list(any)
      # A configuration of S3 object locking
      object_lock_configuration = list(any)
    }
  )
  description = "(Required) The aws_s3_bucket resource."
}

variable "aws_config_delivery_channel" {
  type = object(
    {
      name                         = string
      sns_topic_arn                = string
      snapshot_delivery_properties = list(any)
    }
  )
  description = "(Required) The aws_config_delivery_channel resource."
}

variable "aws_config_configuration_recorder_status" {
  type = object(
    {
      is_enabled = bool
    }
  )
  description = "(Required) The aws_config_configuration_recorder_status resource."
}
variable "aws_cloudwatch_event_rule" {
  type = object(
    {
      # (Required) The name of the rule. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix.
      name = string
      # (Optional) The description of the rule.
      description = string
    }
  )
  description = "(Optional) Provides an EventBridge Rule resource."
  default = {
    name        = "security-config-cloudwatch-event-rule"
    description = "This cloudwatch event used for Config."
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
}
variable "account_id" {
  type        = number
  description = "(Required) AWS account ID for member account."
}
variable "tags" {
  type        = map(any)
  description = "(Optional) Key-value map of resource tags."
  default     = null
}
