resource "aws_security_group" "default" {
  name   = "${var.project}-default "
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "allow-all-ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = [var.vpc_cidr_block]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "allow-all-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "allow-rdp" {
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "TCP"
  cidr_blocks       = [var.vpc_cidr_block]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "https" {

  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "TCP"
  cidr_blocks       = [var.vpc_cidr_block]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group_rule" "http" {

  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "TCP"
  cidr_blocks       = [var.vpc_cidr_block]
  security_group_id = aws_security_group.default.id
}

resource "aws_security_group" "Bastion_rdp" {
  name   = "${var.project}-Bastion_rdp "
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "allow-bastion-rdp" {
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/24"]
  security_group_id = aws_security_group.Bastion_rdp.id
}