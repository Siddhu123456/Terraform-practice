
module "network" {
  source = "./modules/network"

  availability_zone     = var.availability_zone
  vpc_cidr              = var.vpc_cidr
  subnet_configurations = var.subnet_configurations
}

module "security_group" {
  source = "./modules/security_group"

  vpc_id                 = module.network.vpc_id
  ingress_configurations = var.ingress_configurations
  egress_configurations  = var.egress_configurations
}


module "ec2_instances" {
  source = "./modules/ec2"

  ami_id            = var.ami_id
  instance_type     = var.instance_type
  security_group_id = module.security_group.security_group_id
  key_pair_name     = var.key_pair_name

  ec2_instance_configurations = var.ec2_instance_configurations
  public_subnet_id            = module.network.public_subnet_id
  private_subnet_id           = module.network.private_subnet_id
}



# S3 Buckets

module "s3_buckets" {
  source = "./modules/s3"

  s3_buckets_list = var.s3_buckets_list
}

#RDS
module "rds" {
  source = "./modules/rds"

  db_subnet_ids        = module.network.db_private_subnet_ids
  vpc_id               = module.network.vpc_id
  db_security_group_id = module.security_group.db_security_group_id
}