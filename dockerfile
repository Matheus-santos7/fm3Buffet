# Use uma imagem base do Node.js
FROM node:21

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
COPY .env .

# Crie o diretório de imagens e defina permissões
RUN mkdir -p /app/server/public/images /app/server/public/images/empresa && \
    chown -R node:node /app/server/public/images && \
    chmod -R 755 /app/server/public/images

# Use o usuário node para maior segurança (em vez de root)
USER node

# Exponha a porta
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["node", "index.js"]