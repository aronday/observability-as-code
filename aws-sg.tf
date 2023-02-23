data "http" "laptop_outbound_ip" {
  url = "http://ipv4.icanhazip.com"
}

resource "aws_security_group" "sg" {
    depends_on = [
      module.vpc
    ]
  description = "test sg for terraform"
  vpc_id      = module.vpc.vpc_id
  ingress {
    description = "Macbook Outbount IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.laptop_outbound_ip.response_body)}/32"]
  }
  dynamic "ingress" {
    for_each = var.security_groups
    content {
      description = ingress.value["name"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}