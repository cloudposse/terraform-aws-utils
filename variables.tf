variable "elb_logging_bucket_resource_arn" {
  type        = string
  description = <<-EOT
    The AWS Resource ARN to use in the policy granting access to Load Balancer Logging.
    Typically of the form `arn:aws:s3:::_bucket-name_/_prefix_/AWSLogs/_your-aws-account-id_/*`.
    Required to generate `elb_logging_s3_bucket_policy_json`.
    See [AWS Documentation](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html#attach-bucket-policy).
    EOT
  default     = ""
}

variable "elb_logging_region" {
  description = <<-EOT
    Full region (e.g. `us-east-1`) where ELB logging is taking place. Required to generate `elb_s3_bucket_policy_json`.
    Must be known at "plan" time.
    EOT
  default     = ""
}
