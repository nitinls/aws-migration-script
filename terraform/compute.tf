resource "aws_instance" "Bastion" {
  count	                  = var.bastion_count
  ami	                    = var.bastion_ami
  instance_type           = var.default_instance_type
  key_name                = aws_key_pair.deploy.key_name
  availability_zone       = element(slice(var.avail_zone, 0, 1), count.index)
  subnet_id               = aws_subnet.public_az1.id
  get_password_data       = true
  vpc_security_group_ids  = [aws_security_group.default.id, aws_security_group.Bastion_rdp.id]
  
  tags = {
    Name    = "bation_0${count.index + 1}.${var.project}"
    Project = "${var.project}"
  }
}


resource "aws_instance" "DBServer" {
  count	                  = var.dbserver_count
  ami	                    = var.db_ami
  instance_type           = var.default_instance_type
  key_name                = aws_key_pair.deploy.key_name
  availability_zone       = element(slice(var.avail_zone, 0, 2), count.index)
  subnet_id               = element(aws_subnet.private_az2.*.id, count.index)
  get_password_data       = true
  vpc_security_group_ids  = [aws_security_group.default.id]

  tags = {
    Name    = "dbserver_0${count.index + 1}.${var.project}"
    Project = "${var.project}"
  }
}

resource "aws_instance" "AppServer" {
  count	                  = var.appserver_count
  ami	                    = var.app_ami
  instance_type           = var.default_instance_type
  key_name                = aws_key_pair.deploy.key_name
  availability_zone       = element(slice(var.avail_zone, 0, 2), count.index)
  subnet_id               = element(aws_subnet.private_az1.*.id, count.index)
  get_password_data       = true
  vpc_security_group_ids  = [aws_security_group.default.id]

  tags = {
    Name    = "appserver_0${count.index + 1}.${var.project}"
    Project = "${var.project}"
  }  
}