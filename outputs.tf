output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.app_server.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}

output "storedog_url" {
  description = "Storedog Public URL"
  value = "http://${aws_instance.app_server.public_ip}:3000"
}

output "ssh_command" {
  description = "SSH Command to connect to EC2 instance"
  value = "ssh -i credentials/ecommerceapp.pem ec2-user@${aws_instance.app_server.public_ip}"
}
