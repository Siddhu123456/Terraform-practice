output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.this.id
}

output "public_subnet_id" {
  description = "Public Subnet ID."
  value       = aws_subnet.this["public"].id
}

output "private_subnet_id" {
  description = "Private Subnet ID."
  value       = aws_subnet.this["app_private"].id
}

output "subnet_ids" {
  description = "All subnet IDs."
  value       = aws_subnet.this
}

output "app_private_subnet_id" {
  description = "Application subnet ids"

  value = aws_subnet.this["app_private"]
}

output "db_private_subnet_ids" {
  description = "Private subnets for RDS."

  value = [aws_subnet.this["db_private_1"].id, aws_subnet.this["db_private_2"].id]
}

