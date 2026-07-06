# AWS Configuration

variable "aws_region" {
  description = "AWS region where resources will be created."
  type        = string
  nullable    = false

  validation {
    condition = contains(
      [
        "ap-south-1",
        "us-east-1",
        "us-west-2"
      ],
      var.aws_region
    )

    error_message = "Invalid AWS region. Supported regions are ap-south-1, us-east-1 and us-west-2."
  }
}

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

variable "ingress_configurations" {
  description = "Configurations required for inbound traffic."
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string), ["0.0.0.0/0"])
  }))
}

variable "egress_configurations" {
  description = "Configurations required for outbound traffic."
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = optional(list(string), ["0.0.0.0/0"])
  }))
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

# EC2 Configuration

variable "ami_id" {
  description = "AMI ID used to launch EC2 instances."
  type        = string
  nullable    = false

  validation {
    condition = can(regex("^ami-[a-zA-Z0-9]+$", var.ami_id))

    error_message = "AMI ID must start with 'ami-'."
  }
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  nullable    = false
  default     = "t3.micro"

  validation {
    condition = contains(
      [
        "t2.micro",
        "t2.small",
        "t3.micro",
        "t3.small",
        "t3.medium",
        "t3.large"
      ],
      var.instance_type
    )

    error_message = "Unsupported EC2 instance type."
  }
}

variable "key_pair_name" {
  description = "Existing EC2 Key Pair name."
  type        = string
  nullable    = false

  validation {
    condition = length(trimspace(var.key_pair_name)) > 0

    error_message = "Key Pair name cannot be empty."
  }
}


variable "ec2_instance_configurations" {
  description = "configurations for ec2 instances"
  type = map(object({
    subnet                      = string
    associate_public_ip_address = bool
    user_data                   = optional(string)
    name                        = string
  }))

  validation {
    condition = alltrue([
      for instance in values(var.ec2_instance_configurations) :
      contains(
        ["public", "private"],
        instance.subnet
      )
    ])

    error_message = "Subnet must be private or public"
  }
}


variable "s3_buckets_list" {
  description = "List of the name of s3_buckets"
  type        = list(string)

  validation {
    condition = length(var.s3_buckets_list) > 0

    error_message = "Atleast one bucket should be created."
  }

  validation {
    condition = alltrue([
      for bucket in var.s3_buckets_list :
      can(regex(
        "^[a-z0-9][a-z0-9-]{1,61}[a-z0-9]$",
        bucket
      ))

    ])
    error_message = "The bucket name only consists of alphanumerics and '-'s."
  }
}

