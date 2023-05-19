output "security_group_id" {
    value = aws_security_group.security_group.id
}

output "subnet_group_name" {
    value = aws_redshift_subnet_group.redshift_subnet_group.name
}