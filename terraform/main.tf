module "network" {
  source    = "./modules/network"
  project = var.project
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  private_subnet_db_cidr_block = var.private_subnet_db_cidr_block
  avail_zone = var.avail_zone
}

module "ssh-key" {
    source = "./modules/ssh-key"
    project = var.project
}

module "instances" {
    source = "./modules/instances"
    bastion_count = var.bastion_count
    appserver_count = var.appserver_count
    dbserver_count = var.dbserver_count
    bastion_ami = var.bastion_ami
    app_ami = var.app_ami
    db_ami = var.db_ami
    default_instance_type = var.default_instance_type
    key_name   = module.ssh-key.key_name
    project = var.project
}


