locals {
  // Do not base policy availability on resource ARN, as it may not be available at plan time
  elb_policy_enabled = (module.this.enabled &&
    try(length(var.elb_logging_region), 0) > 0
  )

  elb_policy_by_account = local.elb_policy_enabled && try(length(local.elb_logging_account[var.elb_logging_region]), 0) > 0
  elb_policy_by_region  = local.elb_policy_enabled && !local.elb_policy_by_account

  # https://docs.aws.amazon.com/elasticloadbalancing/latest/application/enable-access-logging.html#attach-bucket-policy
  elb_logging_account = {
    # For ease of maintenance, list accounts in same order as documentation does,
    # which is mostly alphabetical by display name, with exceptions.
    "us-east-1"      = "127311923021" # "US East (N. Virginia)"
    "us-east-2"      = "033677994240" # "US East (Ohio)"
    "us-west-1"      = "027434742980" # "US West (N. California)"
    "us-west-2"      = "797873946194" # "US West (Oregon)"
    "af-south-1"     = "098369216593" # "Africa (Cape Town)"
    "ap-east-1"      = "754344448648" # "Asia Pacific (Hong Kong)"
    "ap-southeast-3" = "589379963580" # "Asia Pacific (Jakarta)"
    "ap-south-1"     = "718504428378" # "Asia Pacific (Mumbai)"
    "ap-northeast-3" = "383597477331" # "Asia Pacific (Osaka)"
    "ap-northeast-2" = "600734575887" # "Asia Pacific (Seoul)"
    "ap-southeast-1" = "114774131450" # "Asia Pacific (Singapore)"
    "ap-southeast-2" = "783225319266" # "Asia Pacific (Sydney)"
    "ap-northeast-1" = "582318560864" # "Asia Pacific (Tokyo)"
    "ca-central-1"   = "985666609251" # "Canada (Central)"
    "eu-central-1"   = "054676820928" # "Europe (Frankfurt)"
    "eu-west-1"      = "156460612806" # "Europe (Ireland)"
    "eu-west-2"      = "652711504416" # "Europe (London)"
    "eu-south-1"     = "635631232127" # "Europe (Milan)"
    "eu-west-3"      = "009996457667" # "Europe (Paris)"
    "eu-north-1"     = "897822967062" # "Europe (Stockholm)"
    "me-south-1"     = "076674570225" # "Middle East (Bahrain)"
    "sa-east-1"      = "507241528517" # "South America (Sao Paulo)"
    "us-gov-west-1"  = "048591011584" # "AWS GovCloud (US-West)"
    "us-gov-east-1"  = "190560391635" # "AWS GovCloud (US-East)"

    # 2022-09-25: The `cn-*` account numbers are from the Chinese Language version of
    # https://docs.amazonaws.cn/elasticloadbalancing/latest/application/load-balancer-access-logs.html
    # and it is not clear if they should be used or if the new "by_region" policy
    # should be used instead. For now we continue to use the older "by_account" policy.
    "cn-north-1"     = "638102146993"
    "cn-northwest-1" = "037604701340"
  }
}

data "aws_iam_policy_document" "by_account" {
  count = local.elb_policy_by_account ? 1 : 0
  statement {
    sid       = "LoadBalancerLoggingAccess"
    effect    = "Allow"
    resources = [var.elb_logging_bucket_resource_arn]
    actions   = ["s3:PutObject"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.elb_logging_account[var.elb_logging_region]}:root"]
    }
  }
}

data "aws_iam_policy_document" "by_region" {
  count = local.elb_policy_by_region ? 1 : 0
  statement {
    sid       = "LoadBalancerLoggingAccess"
    effect    = "Allow"
    resources = [var.elb_logging_bucket_resource_arn]
    actions   = ["s3:PutObject"]

    principals {
      type        = "Service"
      identifiers = ["logdelivery.elasticloadbalancing.amazonaws.com"]
    }
  }
}
