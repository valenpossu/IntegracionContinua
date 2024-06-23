#!/bin/bash

# Obtener el ID del grupo Docker del host
DOCKER_GROUP_ID=$(getent group docker | cut -d: -f3)
echo "Docker Group ID: $DOCKER_GROUP_ID"

# Exportar el ID del grupo Docker como variable de entorno
export DOCKER_GROUP_ID

# Detener los servicios actuales
docker-compose down

# Levantar los servicios con Docker Compose
docker-compose up -d --build

# Esperar unos segundos para que los contenedores se inicien completamente
sleep 10

# Añadir el grupo Docker con el ID del host dentro del contenedor, si no existe
docker exec -u root integracioncontinua-jenkins-1 sh -c "getent group docker || groupadd -g $DOCKER_GROUP_ID docker"

# Añadir el usuario jenkins al grupo docker
docker exec -u root integracioncontinua-jenkins-1 usermod -aG docker jenkins

# Verificar que el usuario jenkins esté en el grupo docker
docker exec -u root integracioncontinua-jenkins-1 id jenkins

# Reiniciar el contenedor Jenkins para aplicar los cambios
docker restart integracioncontinua-jenkins-1

# Esperar unos segundos para que el contenedor se reinicie completamente
sleep 10

# Verificar que el usuario jenkins tenga acceso al socket de Docker
docker exec -it integracioncontinua-jenkins-1 docker ps

# 194cc34bd6ae4219a7be5256a7c4ba37