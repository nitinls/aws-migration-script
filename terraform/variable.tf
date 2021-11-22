# variable "AWS_ACCESS_KEY_ID" {
#   description = "AWS Access Key"
# }

# variable "AWS_SECRET_ACCESS_KEY" {
#   description = "AWS Secret Key"
# }
variable "region" {
  default = "ap-south-1"
}
variable "project" {}

variable "vpc_cidr_block" {
  default = "10.10.0.0/16"
}

variable "avail_zone" {
  type = list(string)
  default = ["ap-south-1a","ap-south-1b"]
}

variable "public_subnet_cidr_block" {
  default = "10.10.0.0/24"
}

variable "private_subnet_cidr_block" {
  type = list(string)
  default = ["10.10.2.0/24","10.10.3.0/24"]
}

variable "private_subnet_db_cidr_block" {
  type = list(string)
  default = ["10.10.11.0/24","10.10.12.0/24"]
}

variable "nat_enable" {
  type = bool 
  default = true
}
variable "default_instance_type" {
  default = "t2.micro"
  
}
variable "dbserver_count" {
  default = 2
}
variable "db_ami" {
  default = "ami-02d47a75bafe6e320"
}

variable "appserver_count" {
  default = 2
}
variable "app_ami" {
  default = "ami-02d47a75bafe6e320"
}

variable "bastion_count" {
  default = 1
}
variable "bastion_ami" {
  default = "ami-02d47a75bafe6e320"
}