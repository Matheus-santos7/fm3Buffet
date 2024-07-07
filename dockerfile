# Use uma imagem base do Node.js
FROM node:14

# Defina o diretório de trabalho
WORKDIR /app

# Copie o package.json e package-lock.json para instalar as dependências
COPY ./server/package*.json ./server/

# Instale as dependências do backend
RUN cd ./server && npm install

# Copie o código do backend e frontend para o container
COPY ./docker ./docker
COPY ./server ./server
COPY ./client ./client
COPY index.js .

# Compile ou faça qualquer configuração necessária para o frontend
# Exemplo de construção do frontend
    # RUN cd ./cliente && npm install && npm run build

# Instalação do cron e configuração da tarefa agendada
    # RUN apt-get update && apt-get -y install cron
    # RUN echo "*/10 * * * * /app/docker/backup.sh" > /etc/cron.d/backup-cron
    # RUN chmod 0644 /etc/cron.d/backup-cron

# # Exponha a porta que sua aplicação usará
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["node", "index.js"]