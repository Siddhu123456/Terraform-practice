variable "vpc_id" {
  description = "VPC ID."
  type        = string
}

variable "db_subnet_ids" {
  description = "Private subnets for RDS."

  type = list(string)
}

variable "db_security_group_id" {
  description = "Security group ID."

  type = string
}
