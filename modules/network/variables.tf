variable "availability_zone" {
  description = "Availability Zone where resources will be deployed."
  type        = string
  nullable    = false
  default     = "ap-south-1b"

  validation {
    condition = contains(
      [
        "ap-south-1a",
        "ap-south-1b",
        "ap-south-1c"
      ],
      var.availability_zone
    )

    error_message = "Availability Zone must be ap-south-1a, ap-south-1b or ap-south-1c."
  }
}

# VPC Configuration

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  nullable    = false

  validation {
    condition = can(cidrhost(var.vpc_cidr, 0))

    error_message = "Invalid VPC CIDR block."
  }
}

variable "subnet_configurations" {
  description = "configurations for public and private subnets."
  type = map(object({
    subnet_number = number
    az                      = string
    map_public_ip_on_launch = bool
    name                    = string
  }))
}