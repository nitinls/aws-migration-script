resource "aws_instance" "Bastion" {
  count	= var.bastion_count
  ami	= var.bastion_ami
  instance_type = var.default_instance_type
  key_name = aws_key_pair.deploy.key_name
#  subnet_id = element(aws_subnet.public_az1, count.index)

    tags = {
    Name    = "bation_0${count.index + 1}.${var.project}"
    Project = "${var.project}"
  }
}


resource "aws_instance" "DBServer" {
  count	= var.dbserver_count
  ami	= var.db_ami
  instance_type = var.default_instance_type
  key_name = aws_key_pair.deploy.key_name

  tags = {
    Name    = "dbserver_0${count.index + 1}.${var.project}"
    Project = "${var.project}"
  }
}

resource "aws_instance" "AppServer" {
  count	= var.appserver_count
  ami	= var.app_ami
  instance_type = var.default_instance_type
  key_name = aws_key_pair.deploy.key_name

  tags = {
    Name    = "appserver_0${count.index + 1}.${var.project}"
    Project = "${var.project}"
  }  
}
