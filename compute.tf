data "aws_ami" "server_ami" {
	most_recent = true
	owners = ["amazon"]
	filter {
	name = "owner-alias"
	values = ["amazon"]
}
filter {
	name = "name"
	values = ["amzn2-ami-hvm*-x86_64-gp2"]
}
}

// Resource referencing from networking.tf
resource "aws_instance" "ajay_ec2" {
	count = var.instance_count
	instance_type = var.instance_type
	ami = data.aws_ami.server_ami.id
	key_name = var.instance_key_name
	tags  = {
		Name = "ajay_infra_ec2"
	}
vpc_security_group_ids = [aws_security_group.ajay_infra_sg.id]
subnet_id = aws_subnet.public_sb.id
root_block_device {
	volume_size = var.volume_size
	}
}

