output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_1" {
  value = aws_subnet.web_subnet_1.id
}

output "subnet_2" {
  value = aws_subnet.web_subnet_2.id
}

output "subnet_1_security_group_id" {
  value = aws_security_group.web_subnet_1sg.id
}

output "subnet_2_security_group_id" {
  value = aws_security_group.web_subnet_2sg.id
}
output "elb_sg" {
  value = aws_security_group.elb_sg
}