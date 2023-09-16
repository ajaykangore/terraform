resource "aws_vpc" "infra_ajay" {
	cidr_block = var.vpc_cidr
	// cidr_block = 10.20.0.0/16
	enable_dns_support = true
	enable_dns_hostnames = true

	tags = {
	Name = var.vpc_tag_name
	}
lifecycle {
	create_before_destroy = true
	}
}

resource "aws_internet_gateway" "ajay_IGW" {
	vpc_id = aws_vpc.infra_ajay.id

	tags = {
	Name = var.vpc_tag_name
	}
}

resource "aws_route_table" "public_RT_ajay" {
	vpc_id = aws_vpc.infra_ajay.id

tags = {
	Name = "infra_ajay_public_route_table"
	}
lifecycle {
        create_before_destroy = true
        }
}

resource "aws_route" "default_public__ajay" {
	route_table_id = aws_route_table.public_RT_ajay.id
	destination_cidr_block = "0.0.0.0/0"
	gateway_id = aws_internet_gateway.ajay_IGW.id

lifecycle {
        create_before_destroy = true
        }
	}

resource "aws_default_route_table" "private_RT_ajay" {
        default_route_table_id = aws_vpc.infra_ajay.default_route_table_id

tags = {
        Name = "infra_ajay__private_route_table"
        }
lifecycle {
        create_before_destroy = true
        }

}



data "aws_availability_zones" "available" {}

resource "aws_subnet" "private_sb"{
	vpc_id = aws_vpc.infra_ajay.id
	cidr_block = var.private_cidr
	map_public_ip_on_launch = false
	availability_zone = data.aws_availability_zones.available.names[0]

tags = {
	Name= "private_subnet_ajay"
	}
}

resource "aws_subnet" "public_sb"{
        vpc_id = aws_vpc.infra_ajay.id
        cidr_block = var.public_cidr
        map_public_ip_on_launch = true
        availability_zone = data.aws_availability_zones.available.names[1]

tags = {
        Name= "public_subnet_ajay"
        }
}

resource "aws_route_table_association" "terraform_public_subnet_association" {
	subnet_id = aws_subnet.public_sb.id
	route_table_id = aws_route_table.public_RT_ajay.id
}

resource "aws_route_table_association" "terraform_private_subnet_association" {
        subnet_id = aws_subnet.private_sb.id
        route_table_id = aws_default_route_table.private_RT_ajay.id
}

resource "aws_security_group" "ajay_infra_sg" {
        name = "ajay_infra_sg"
        description = "Security group of public instance"
	vpc_id = aws_vpc.infra_ajay.id
}

resource "aws_security_group_rule" "ingress_all" {
        type = "ingress"
        from_port = 0
	to_port = 65535
	protocol = "-1"
	cidr_blocks = [var.access_ip]
	security_group_id = aws_security_group.ajay_infra_sg.id
        }
resource "aws_security_group_rule" "egress_all" {
        type = "egress"
        from_port = 0
        to_port = 65535
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        security_group_id = aws_security_group.ajay_infra_sg.id
        }

