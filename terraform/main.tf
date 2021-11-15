module "instances" {
    source = "./modules/instances"
    region = "${var.region}"
    app_ami = "${var.app_ami}"
    appserver_count = var.appserver_count
    instance_type = "${var.instance_type}"
    project = var.project

}