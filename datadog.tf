##-----------------------------------------##
##           Create AWS IAM Role for DD          ##
## ----------------------------------------##

#Call the AWS Caller Identity Service to get AWS Account ID
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "datadog_aws_integration_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = ["arn:aws:iam::464622532012:root"]
    }
    condition {
      test = "StringEquals"
      variable = "sts:ExternalId"

      values = [
        "${datadog_integration_aws.sandbox.external_id}"
      ]
    }
  }
}

data "aws_iam_policy_document" "datadog_aws_integration" {
  statement {
    actions = ["apigateway:GET",
                "autoscaling:Describe*",
                "backup:List*",
                "budgets:ViewBudget",
                "cloudfront:GetDistributionConfig",
                "cloudfront:ListDistributions",
                "cloudtrail:DescribeTrails",
                "cloudtrail:GetTrailStatus",
                "cloudtrail:LookupEvents",
                "cloudwatch:Describe*",
                "cloudwatch:Get*",
                "cloudwatch:List*",
                "codedeploy:List*",
                "codedeploy:BatchGet*",
                "directconnect:Describe*",
                "dynamodb:List*",
                "dynamodb:Describe*",
                "ec2:Describe*",
                "ecs:Describe*",
                "ecs:List*",
                "elasticache:Describe*",
                "elasticache:List*",
                "elasticfilesystem:DescribeFileSystems",
                "elasticfilesystem:DescribeTags",
                "elasticfilesystem:DescribeAccessPoints",
                "elasticloadbalancing:Describe*",
                "elasticmapreduce:List*",
                "elasticmapreduce:Describe*",
                "es:ListTags",
                "es:ListDomainNames",
                "es:DescribeElasticsearchDomains",
                "events:CreateEventBus",
                "fsx:DescribeFileSystems",
                "fsx:ListTagsForResource",
                "health:DescribeEvents",
                "health:DescribeEventDetails",
                "health:DescribeAffectedEntities",
                "kinesis:List*",
                "kinesis:Describe*",
                "lambda:GetPolicy",
                "lambda:List*",
                "logs:DeleteSubscriptionFilter",
                "logs:DescribeLogGroups",
                "logs:DescribeLogStreams",
                "logs:DescribeSubscriptionFilters",
                "logs:FilterLogEvents",
                "logs:PutSubscriptionFilter",
                "logs:TestMetricFilter",
                "organizations:Describe*",
                "organizations:List*",
                "rds:Describe*",
                "rds:List*",
                "redshift:DescribeClusters",
                "redshift:DescribeLoggingStatus",
                "route53:List*",
                "s3:GetBucketLogging",
                "s3:GetBucketLocation",
                "s3:GetBucketNotification",
                "s3:GetBucketTagging",
                "s3:ListAllMyBuckets",
                "s3:PutBucketNotification",
                "ses:Get*",
                "sns:List*",
                "sns:Publish",
                "sqs:ListQueues",
                "states:ListStateMachines",
                "states:DescribeStateMachine",
                "support:DescribeTrustedAdvisor*",
                "support:RefreshTrustedAdvisorCheck",
                "tag:GetResources",
                "tag:GetTagKeys",
                "tag:GetTagValues",
                "xray:BatchGetTraces",
                "xray:GetTraceSummaries"]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "datadog_aws_integration" {
  name = "DatadogAWSIntegrationPolicy"
  policy = "${data.aws_iam_policy_document.datadog_aws_integration.json}"
}

resource "aws_iam_role" "datadog_aws_integration" {
  name = "DatadogAWSIntegrationRole"
  description = "Role for Datadog AWS Integration"
  assume_role_policy = "${data.aws_iam_policy_document.datadog_aws_integration_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "datadog_aws_integration" {
  role = "${aws_iam_role.datadog_aws_integration.name}"
  policy_arn = "${aws_iam_policy.datadog_aws_integration.arn}"
}

##-----------------------------------------##
##            Enable the AWS integration           ##
## ----------------------------------------##

resource "datadog_integration_aws" "sandbox" {
  depends_on = [
    aws_secretsmanager_secret.datadog
  ]
  account_id  = "${data.aws_caller_identity.current.account_id}"
  role_name   = "DatadogAWSIntegrationRole"
  filter_tags = ["Owner:Aron.Day"]
  cspm_resource_collection_enabled = true
}

resource "datadog_integration_aws_tag_filter" "rds" {
depends_on = [
  datadog_integration_aws.sandbox
]
  account_id     = "${data.aws_caller_identity.current.account_id}"
  namespace      = "rds"
  tag_filter_str = "Owner:Aron.Day"
}

resource "datadog_integration_aws_tag_filter" "lambda" {
depends_on = [
  datadog_integration_aws.sandbox
]
  account_id     = "${data.aws_caller_identity.current.account_id}"
  namespace      = "lambda"
  tag_filter_str = "Owner:Aron.Day"
}

##-----------------------------------------##
##   Create Datadog Synthetics HTTP test   ##
## ----------------------------------------##

# Create a new Datadog Synthetics API/HTTP test on storedog!
resource "datadog_synthetics_test" "storedog_api" {
  type    = "api"
  subtype = "http"
  request_definition {
    method = "GET"
    url    = "http://${aws_instance.app_server.public_ip}:3000"
  }
  assertion {
    type     = "statusCode"
    operator = "is"
    target   = "200"
  }
  locations = ["aws:eu-west-1"]
  options_list {
    tick_every = 900

    retry {
      count    = 2
      interval = 300
    }

    monitor_options {
      renotify_interval = 120
    }
  }
  name    = "An API test on Storedog"
  message = "Notify @aronday"
  tags    = ["owner:Aron.Day", "env:development"]

  status = "live"
}

##-----------------------------------------##
##      Create Datadog SLO for Storedog      ##
## ----------------------------------------##
resource "datadog_service_level_objective" "bar" {
  depends_on = [
    datadog_synthetics_test.storedog_api
  ]
  name        = "Storedog Uptime SLO"
  type        = "monitor"
  description = "Storedog Index Uptime SLO"
  monitor_ids = ["${datadog_synthetics_test.storedog_api.monitor_id}"]

  thresholds {
    timeframe = "7d"
    target    = 99.9
    warning   = 99.99
  }

  thresholds {
    timeframe = "30d"
    target    = 99.9
    warning   = 99.99
  }

  tags = ["owner:Aron.Day", "env:development"]
}
