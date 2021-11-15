# Variables
variable "shared_credentials_file" {}
variable "access_key" {
	default = "ACCESS_KEY_HERE"
}
variable "secret_key" {
	default = "SECRET_KEY_HERE"
}

variable "region" {
  default = "ap-south-1"
}
variable "project" {}

variable "vpc_cidr_block" {
  default = "10.10.0.0/16"
}

variable "public_subnet_cidr_block" {
  type = list(string)
  default = ["10.10.0.0/24","10.10.1.0/24"]
}

variable "private_subnet_cidr_block" {
  type = list(string)
  default = ["10.10.2.0/24","10.10.3.0/24"]
}

variable "private_subnet_db_cidr_block" {
  type = list(string)
  default = ["10.10.11.0/24","10.10.12.0/24"]
}

variable "instance_type" {
  description = "type for aws EC2 instance"
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