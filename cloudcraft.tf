# read CloudCraft API secret
data "aws_secretsmanager_secret" "cc_api" {
  depends_on = [
    aws_secretsmanager_secret.cloudcraft
  ]
  name = "cloudcraft_api"
}

data "aws_secretsmanager_secret_version" "cc_api" {
  secret_id = data.aws_secretsmanager_secret.cc_api.id
}

locals {
  cc_api = jsondecode(data.aws_secretsmanager_secret_version.cc_api.secret_string)
}

data "http" "cloudcraft_externalId" {
  url = "https://api.cloudcraft.co/aws/account/iamParameters"
  request_headers = {
    Accept = "application/json"
    Authorization: "Bearer ${local.cc_api.api}"
  }
}

locals {
    # get json 
    externalId = jsondecode(data.http.cloudcraft_externalId.response_body)
    # run_once = true
}

# output "CloudCraftexternalId" {
#     value = local.externalId
# }

# Create IAM Role for CloudCraft
data "aws_iam_policy_document" "cloudcraft_aws_integration_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = ["arn:aws:iam::968898580625:root"]
    }
    condition {
      test = "StringEquals"
      variable = "sts:ExternalId"

      values = [
        "${local.externalId.externalId}"
      ]
    }
  }
}

data "aws_iam_policy" "ReadOnlyAccess" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role" "cloudcraft_aws_integration" {
  name = "CloudCraftAWSIntegrationRole"
  description = "Role for CloudCraft AWS Integration"
  assume_role_policy = "${data.aws_iam_policy_document.cloudcraft_aws_integration_assume_role.json}"
}

resource "aws_iam_role_policy_attachment" "cloudcraft_aws_integration" {
  role = "${aws_iam_role.cloudcraft_aws_integration.name}"
  policy_arn = "${data.aws_iam_policy.ReadOnlyAccess.arn}"
}

#Note this will add an account every time terraform plan/apply runs
#Need to find a work around to make this permanent 

# resource "null_resource" "run_once" {
#   count = local.run_once ? 1 : 0

#   provisioner "local-exec" {
#     command = "echo 'This resource only runs once'"
#   }
# }

# data "http" "cloudcraft_aws_post" {
#   depends_on = [null_resource.run_once]

#   url    = "https://api.cloudcraft.co/aws/account"
#   method = "POST"
#   request_headers = {
#     "Content-Type": "application/json"
#     Authorization: "Bearer ${local.cc_api.api}"
#   }

#   request_body = jsonencode({
#     name = "AWS Test"
#     roleArn = "${aws_iam_role.cloudcraft_aws_integration.arn}"
#     region = var.region
#   })
# }


