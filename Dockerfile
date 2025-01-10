# Use a imagem base do Ubuntu 22.04
FROM ubuntu:22.04

# Definir variáveis de ambiente para evitar prompts durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Atualizar a lista de pacotes e instalar dependências necessárias
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Adicionar a chave GPG do repositório oficial do Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Adicionar o repositório do Docker à lista de fontes do APT
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Instalar Docker CE
RUN apt-get update && \
    apt-get install -y docker-ce

# Instalar Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Criar um usuário e diretórios necessários
RUN adduser --disabled-password --gecos "" www-user && \
    mkdir -p /var/spool/mikopbx/cf && \
    mkdir -p /var/spool/mikopbx/storage && \
    chown -R www-user:www-user /var/spool/mikopbx/

# Definir o diretório de trabalho
WORKDIR /var/spool/mikopbx

# Copiar o arquivo docker-compose.yml para o contêiner
COPY docker-compose.yml .

# Expor portas necessárias (ajuste conforme necessário)
EXPOSE 80 81 443 444 5060 5061 

# Comando padrão para iniciar o Docker Compose
CMD ["docker-compose", "up", "-d"]
