# Common block to create instances

resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_pair_name

  for_each = var.ec2_instance_configurations

  subnet_id                   = local.subnet_id[each.value.subnet]
  associate_public_ip_address = each.value.associate_public_ip_address


  user_data = try(each.value.user_data, null)

  tags = {
    Name = each.value.name
  }
}