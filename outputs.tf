output "instance_id" {
  value = aws_instance.grafana.id
}

output "public_ip" {
  value = aws_instance.grafana.public_ip
}

output "public_dns" {
  value = aws_instance.grafana.public_dns
}
