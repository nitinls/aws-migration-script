
output "aws_subnet_ids_private" {
  value = aws_subnet.private_az1.*.id
}

output "aws_subnet_ids_public" {
  value = aws_subnet.public_az1.*.id
}

output "aws_db_subnet_ids_private" {
  value = aws_subnet.private_az2.*.id
}

output "app_server_password" {
  value = aws_instance.AppServer.*.get_password_data
}

output "db_server_password" {
  value = aws_instance.DBServer.*.get_password_data
}

output "bastion_server_password" {
  value = aws_instance.Bastion.*.get_password_data
}

output "app_server_private_ip" {
  value = aws_instance.AppServer.*.private_ip
}

output "db_server_private_ip" {
  value = aws_instance.DBServer.*.private_ip
}

output "bastion_server_public_ip" {
  value = aws_instance.Bastion.*.public_ip
}