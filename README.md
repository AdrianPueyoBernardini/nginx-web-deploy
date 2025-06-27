# Deploy automatizado de web estática con Terraform, AWS EC2, S3 y Nginx
-Si bien el despliegue de webs estáticas en un bucket de S3 están más estandarizadas, este proyecto lo he utilizado para practicar arquitectura de despliegues.

# Arquitectura
- Terraform automatiza la creación de la instancia, instalación y activación de nginx en user_data y descarga la web para su despliegue.
- La web habrá de subirse en formato ZIP, pues en el user data este es el compresor que he utilizado.
- Desde el archivo Variables, además de poder configurar la arquitectura básica podemos también editar el path de nuestro bucket s3.

# Pasos a seguir para levantar la web
1. Descargamos el repositorio.
2. Subimos nuestra web en formato ZIP a nuestro bucket s3.
3. Deberems activar el acceso público al bucket y modificar las políticas del bucket (política adjuntada en la parte inferior)
4. Introducimos el path de nuestro bucket en "Variables.tf"
5. Introducimos el nombre de nuestro zip en "Variables.tf"
6. Desde el directorio ejecuta:
    terraform init
    terraform plan
    terraform apply

# Políticas de bucket
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::adrian-nginx-bucket/*"
    }
  ]
}

# 🐞Comandos para la comprobación de errores🐞
### Comprobar si nginx se ha instalado apropiadamente
sudo systemctl status nginx
### Comprobar si el zip se ha descargado bien (menos de 1KB es probablemente error de descarga)
ls -lh /tmp/archivo.zip
### Descarga manual del .zip, si no permite la descarga puede ser error de las políticas del bucket o acceso público.
curl -I https://enlace-bucket.s3.region/archivo.zip
### Verificar si tenemos archivo html en la ruta de nginx
ls -lh /usr/share/nginx/html



