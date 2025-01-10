# Use a imagem base do Ubuntu 22.04
FROM ubuntu:22.04

# Defina variáveis de ambiente para evitar prompts interativos durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Atualize o sistema e instale dependências necessárias
RUN apt-get update && \
    apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Adicione o repositório oficial do Docker e instale o Docker CE
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce docker-ce-cli containerd.io

# Baixe e instale o Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Crie o usuário e os diretórios necessários
RUN adduser --disabled-password --gecos "" www-user && \
    mkdir -p /var/spool/mikopbx/cf && \
    mkdir -p /var/spool/mikopbx/storage && \
    chown -R www-user:www-user /var/spool/mikopbx/

# Defina o diretório de trabalho
WORKDIR /var/spool/mikopbx

# Defina o usuário padrão
USER www-user

# Comando padrão para iniciar o contêiner
CMD ["sh"]
