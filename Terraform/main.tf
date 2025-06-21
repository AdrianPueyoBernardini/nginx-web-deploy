provider "aws" {
    region = var.region

    default_tags {
      tags = {
        Enviroment = "Practice"
        Owner = "adrian@testemail.com"
        Team = "DevOps"
        Project = "GitHub & LinkedIn Post"
      }
    }
}

#MI INSTANCIA#
resource "aws_instance" "mi-instance-deploy" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.nginx-server-ssh.key_name

    vpc_security_group_ids = [ 
        aws_security_group.nginx_server_sg.id
     ]

    user_data = <<-EOF
                #!/bin/bash

                #Actualización de paquetes disponibles en el sistema
                sudo yum update -y

                #Instalo nginx para hacer el deploy de mi web
                sudo yum install -y nginx

                #Instalo unzip
                sudo yum install -y unzip

                #Habilito e inicio nginx
                sudo systemctl enable nginx
                sudo systemctl start nginx              

                #Nginx tiene contenido html por defecto, lo borramos
                sudo rm -rf /usr/share/nginx/html/*

                # Descargo el archivo zip desde el bucket a una ruta temporal
                curl -o /tmp/${var.s3-file-name} ${var.s3-web-link}

                #Descomprimo el contenido en la carpeta de nginx
                sudo unzip /tmp/website.zip -d /usr/share/nginx/html/

                sudo chown -R nginx:nginx /usr/share/nginx/html
                sudo chmod -R 755 /usr/share/nginx/html      

                #Reinicio nginx, necesitamos que cargue el contenido nuevo
                sudo systemctl restart nginx

                EOF

    tags = {
      Name = var.instance_name
    }

}

#LINKEO DE LAS CLAVES SSH
resource "aws_key_pair" "nginx-server-ssh" {
  key_name = "nginx_server-ssh"
  public_key = file("nginx-server.key.pub")
}


#CREACIÓN DE SECURITY GROUP PARA HABILITAR ACCESO SSH Y HTTP
resource "aws_security_group" "nginx_server_sg" {
  name = "nginx_server_sg"
  description = "Security groups allow http & ssh access"

  ingress{
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  ingress{
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

    egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

