#!/bin/bash

# Construir a imagem Docker
docker-compose build

# Iniciar o contêiner
docker-compose up -d

echo "MikoPBX está rodando!"
echo "Acesse o painel de controle em http://localhost:8080"
