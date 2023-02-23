resource "datadog_logs_archive" "storedog_archive" {
  name  = "StoreDog Logs Archive"
  query = "name:storedog"
  s3_archive {
    bucket     = var.s3_bucket_name
    path       = "datadog/logs"
    account_id = "${data.aws_caller_identity.current.account_id}"
    role_name  = "${aws_iam_role.datadog_aws_integration.name}"
  }
}