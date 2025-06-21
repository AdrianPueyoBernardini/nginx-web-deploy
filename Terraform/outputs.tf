#OUTPUTS
output "instace_name" {
  description = "Nombre de la instancia"
  value = aws_instance.mi-instance-deploy.tags.Name
}
output "public_ip" {
  description = "Dirección IP pública"
  value = aws_instance.mi-instance-deploy.public_ip
}
output "public_DNS" {
  description = "Dirección DNS pública"
  value = aws_instance.mi-instance-deploy.public_dns
}