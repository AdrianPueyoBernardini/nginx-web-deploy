######## NECESARIO DE CAMBIAR AL REALIZAR EL DESPLIEGUE#############
#S3 Bucket web  (ZIP)
variable "s3-web-link" {
  description = "Enlace del bucket S3 a la web comprimida"
  type = string
  default = "https://adrian-nginx-bucket.s3.eu-central-1.amazonaws.com/website.zip"
}
variable "s3-file-name" {
  description = "El nombre del archivo zip"
  type = string
  default = "website.zip"
}

#Provider
variable "region" {
  description = "Región AWS"
  type = string
  default = "eu-central-1"
}

#EC2
variable "ami" {
  description = "AMI de ec2"
  type = string
  default = "ami-092ff8e60e2d51e19"
}
variable "instance_type" {
  description = "Tipo de instancia"
  type = string
  default = "t2.micro"  
}
variable "instance_name" {
  description = "Nombre de la instancia"
  type = string
  default = "adrian_ec2_var_instance"    
}