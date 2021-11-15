resource "aws_instance" "AppServer" {
  count	= var.appserver_count
  ami	= var.app_ami
  instance_type = var.instance_type
  

  tags = {
    Name    = "appserver${count.index}.${var.project}"
    Project = "${var.project}"
  }  
}