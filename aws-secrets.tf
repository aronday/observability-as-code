# Creating a AWS secret for Datadog account
resource "aws_secretsmanager_secret" "datadog" {
   name = "datadog_api"
   description = "API Key for Datadog - Aron Day Sanbox Account"
   recovery_window_in_days = 0
}
 
# Creating a AWS secret versions for Datadog
#Note this is using an environment variable TF_VAR_dd_api & TF_VAR_dd_app
resource "aws_secretsmanager_secret_version" "datadog" {
   depends_on = [
     aws_secretsmanager_secret.datadog
   ]
  secret_id = aws_secretsmanager_secret.datadog.id
  secret_string = <<EOF
   {
    "apiKey": "${var.dd_api}",
    "appKey":"${var.dd_app}"
   }
EOF
}

# Creating a AWS secret for Cloudcraft account
resource "aws_secretsmanager_secret" "cloudcraft" {
   name = "cloudcraft_api"
   recovery_window_in_days = 0
}
 
# Creating a AWS secret versions for Cloudcraft
#Note this is using an environment variable TF_VAR_cc_api
resource "aws_secretsmanager_secret_version" "cloudcraft" {
   depends_on = [
     aws_secretsmanager_secret.cloudcraft
   ]
  secret_id = aws_secretsmanager_secret.cloudcraft.id
  secret_string = <<EOF
   {
    "api": "${var.cc_api}"
   }
EOF
}