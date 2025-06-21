# Deploy automatizado de web estática con Terraform, AWS EC2, S3 y Nginx
-Si bien el despliegue de webs estáticas en un bucket de S3 están más estandarizadas, este proyecto lo he utilizado para practicar arquitectura de despliegues.

# Arquitectura
- Terraform automatiza la creación de la instancia, instalación y activación de nginx en user_data y descarga la web para su despliegue.
- La web habrá de subirse en formato ZIP, pues en el user data este es el compresor que he utilizado.
- Desde el archivo Variables, además de poder configurar la arquitectura básica podemos también editar el path de nuestro bucket s3.

# Pasos a seguir para levantar la web
1. Descargamos el repositorio.
2. Subimos nuestra web en formato ZIP a nuestro bucket s3.
3. Introducimos el path de nuestro bucket en "Variables.tf"
4. Introducimos el nombre de nuestro zip en "Variables.tf"
5. Desde el directorio ejecuta:
    terraform init
    terraform plan
    terraform apply
