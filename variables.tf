variable "region_aws" {
	type = string
	description = "Region of Cloud"
	}
variable "vpc_cidr" {
	type = string
	description = "CIDR value"
	}

variable "vpc_tag_name" {
	type = string
	description = "Tag name"
	}
variable "private_cidr" {
	type = string
	default = "172.162.1.0/24"
	}
variable "public_cidr" {
        type = string
        default = "172.162.2.0/24"
        }
variable "access_ip" {
	type = string
	default = "103.162.65.246/32"
}

variable "instance_type" {
	type = string
	default = "t2.micro"
}

variable "volume_size" {
	type = number
	default = 8
}

variable "instance_key_name" {
	type = string
	default = "Controlnode"
}

variable "instance_count" {
	type = number
	default = 1
}

variable "bucket_name" {
	type = string
	description = "Name of bucket"
}

variable "bucket_tag" {
	type = string
	description = "bucket_tag"
}

variable "bucket_acl"{
	type = string
	description = "acl_for_bucket"
}

