variable "region" {
  default     = "eu-west-1"
  description = "AWS region"
}

variable "aws_creds_profile" {
  default = "default"
  description = "AWS credentials profile to be used"
}

variable "vpc_name" {
  description = "value"
}

variable "vpc_cidr" {
  description = "value"
}

variable "vpc_private_subnets" {
  description = "value"
}

variable "vpc_public_subnets" {
  description = "value"
}

variable "security_groups" {
  description = "The attribute of security_groups information"
  type = list(object({
    name        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "ec2" {
  description = "The attribute of EC2 information"
  type = object({
    name              = string
    os_type           = string
    instance_type     = string
    volume_size       = number
    volume_type       = string
  })
}

variable "dd_api" {
  description = "DD API Key"
}

variable "dd_app" {
  description = "DD APP Key"
}

variable "cc_api" {
  description = "CloudCraft API"
}

variable "datadog_tags" {
  description = "Default Tags to use on datadog resources"
}

variable "s3_bucket_name" {
  description = "S3 Bucket Name to be setup for Logs Archives"
}