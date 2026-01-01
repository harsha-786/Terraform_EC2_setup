output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.instance_one.public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.instance_one.id
}

output "ssh_command" {
  description = "Convenient SSH command"
  value       = "ssh -i ~/.ssh/harsha-key ec2-user@${aws_instance.instance_one.public_ip}"
}

