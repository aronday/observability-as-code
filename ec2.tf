resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "private_key" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "./credentials/ecommerceapp.pem"
  file_permission = "0600"
}

resource "aws_key_pair" "deploy" {
  depends_on = [
    tls_private_key.ssh
  ]
  key_name   = "terraform"
  public_key = tls_private_key.ssh.public_key_openssh
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

# read service user secret
# data "aws_secretsmanager_secret" "dd_api" {
#   name = "cloudcraft"
# }

# data "aws_secretsmanager_secret_version" "dd_api" {
#   secret_id = data.aws_secretsmanager_secret.dd_api.id
# }

# locals {
#   dd_api = jsondecode(data.aws_secretsmanager_secret_version.dd_api.secret_string)
# }

resource "aws_instance" "app_server" {
  ami                         = data.aws_ami.amazon_linux.id
  availability_zone           = "${var.region}a"
  instance_type               = var.ec2.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]
  subnet_id                   = module.vpc.public_subnets[0]
  key_name                    = aws_key_pair.deploy.id
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    volume_size           = var.ec2.volume_size
    volume_type           = var.ec2.volume_type
  }
  #user_data = file("templates/${var.ec2.os_type}.sh")
  user_data = templatefile("templates/${var.ec2.os_type}.sh.tftpl", { DD_API_KEY = "${local.dd_api.apiKey}" })
  tags = {
    Name = "StoreDog"
    Owner = "Aron.Day"
  }
}
