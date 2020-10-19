output "ec2_public_ip" {
  value       = aws_instance.ec2.public_ip
  description = "The public IP address of the ec2 instance"
}

output "dns_host" {
  value       = aws_db_instance.db.address
  description = "The host url of the rds"
}

output "route53_name_servers" {
  value       = aws_route53_zone.main.name_servers
  description = "The sets of NS record value"
}
