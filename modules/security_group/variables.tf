variable "vpc_id" {
  description = "VPC ID where the Security Group will be created."
  type        = string
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