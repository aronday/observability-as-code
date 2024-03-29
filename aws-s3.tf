resource "aws_s3_bucket" "datadog_logs_archive" {
  bucket = var.s3_bucket_name
  force_destroy = true

  tags = {
    Name        = "Datadog Logs Archive"
    Environment = "development"
  }
}

resource "aws_iam_policy" "datadog_s3_access" {
  name        = "datadog_s3_access"
  description = "Allow Datadog to upload and retrieve log archives from S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "DatadogUploadAndRehydrateLogArchives"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ]
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}/*"
        ]
      },
      {
        Sid = "DatadogRehydrateLogArchivesListBucket"
        Effect = "Allow"
        Action = "s3:ListBucket"
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "datadog_s3_access" {
    depends_on = [
      aws_iam_role.datadog_aws_integration
    ]
  role = "${aws_iam_role.datadog_aws_integration.name}"
  policy_arn = "${aws_iam_policy.datadog_s3_access.arn}"
}
