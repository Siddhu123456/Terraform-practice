
# AWS Configuration

aws_region = "ap-south-1"

availability_zone = "ap-south-1a"


# VPC Configuration

vpc_cidr = "10.0.0.0/16"

subnet_configurations = {
  public = {
    subnet_number           = 0
    az                      = "ap-south-1a"
    map_public_ip_on_launch = true
    name                    = "terra_public_subnet"
  }

  app_private = {
    subnet_number           = 1
    az                      = "ap-south-1b"
    map_public_ip_on_launch = false
    name                    = "terra_private_subnet"
  }

  db_private_1 = {
    subnet_number           = 2
    az                      = "ap-south-1a"
    map_public_ip_on_launch = false
    name                    = "terra_private_subnet"
  }

  db_private_2 = {
    subnet_number           = 3
    az                      = "ap-south-1b"
    map_public_ip_on_launch = false
    name                    = "terra_private_subnet"
  }
}

ingress_configurations = [
  {
    description = "Allow only HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  },
  {
    description = "Allow only SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
]

egress_configurations = [
  {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
]




# EC2 Configuration

ami_id = "ami-0f58b397bc5c1f2e8"

instance_type = "t3.micro"

key_pair_name = "terraform-key"

ec2_instance_configurations = {

  public = {
    subnet                      = "public"
    associate_public_ip_address = true
    user_data                   = <<-EOF
              #!/bin/bash

                apt update -y

                apt install nginx -y

                systemctl enable nginx

                systemctl start nginx
              EOF
    name                        = "terra_public_EC2"
  }

  private = {
    subnet                      = "private"
    associate_public_ip_address = false
    name                        = "terra_private_EC2"
  }
}


# S3 Configuration


s3_buckets_list = ["tejatv-bucket-1", "tejatv-bucket-2"]

