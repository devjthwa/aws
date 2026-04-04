output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_instance_ip" {
  value = aws_instance.public_win.public_ip
}

output "private_instance_internal_ip" {
  value = aws_instance.private_win.private_ip
}
