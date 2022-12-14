provider "aws" {
  region = var.region
  profile = var.aws_creds_profile
}

# read Datadog API secret
data "aws_secretsmanager_secret" "dd_api" {
  depends_on = [
    aws_secretsmanager_secret.datadog
  ]
  name = "datadog_api"
}

data "aws_secretsmanager_secret_version" "dd_api" {
  secret_id = data.aws_secretsmanager_secret.dd_api.id
}

locals {
  dd_api = jsondecode(data.aws_secretsmanager_secret_version.dd_api.secret_string)
}

provider "datadog" {
   api_key = local.dd_api.apiKey
   app_key = local.dd_api.appKey
   validate = false
}
