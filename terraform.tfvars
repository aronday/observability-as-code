#AWS
aws_creds_profile = "aws-im-day"
region = "eu-west-1"

#VPC
vpc_name = "aws-immersion-demo-vpc"
vpc_cidr = "10.0.0.0/16"
vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
vpc_public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

#EC2
security_groups = [{
  from_port   = 22
  name        = "Enterprise CIDR Range"
  protocol    = "tcp"
  to_port     = 22
  cidr_blocks = ["192.168.1.1/32"] # replace with enterprise wifi outbount CIDR
  },
{
  from_port   = 3000
  name        = "Storedog Port"
  protocol    = "tcp"
  to_port     = 3000
  cidr_blocks = ["0.0.0.0/0"]
}]

ec2 = {
  instance_type     = "t3.medium"
  name              = "aron"
  os_type           = "linux"
  volume_size       = 20
  volume_type       = "gp3"
}

#Datadog
datadog_tags =["owner:aron.day", "env:development"]

#Logs Archive - S3
s3_bucket_name = "datadog-logs-s3-archive"