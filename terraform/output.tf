
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
  value = [
    for host in aws_instance.AppServer : rsadecrypt(host.password_data, file("./key-pair/id_rsa.liftshift"))
  ]
}

output "db_server_password" {
  value = [
    for host in aws_instance.DBServer : rsadecrypt(host.password_data, file("./key-pair/id_rsa.liftshift"))
  ]
}

output "bastion_server_password" {
  value = [
    for host in aws_instance.Bastion : rsadecrypt(host.password_data, file("./key-pair/id_rsa.liftshift"))
  ]
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