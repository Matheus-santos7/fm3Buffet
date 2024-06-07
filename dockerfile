# Use a imagem base do Node.js
FROM node:14

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie o restante dos arquivos da aplicação para o diretório de trabalho
COPY . .

# Instale as dependências do Node.js
RUN npm install

# Exponha a porta em que a aplicação estará em execução
EXPOSE 3000

# Defina as variáveis de ambiente para o MySQL
ENV MYSQL_HOST=localhost
ENV MYSQL_USER=root
ENV MYSQL_PASSWORD=123
ENV MYSQL_DATABASE=deliveryOnline

# Execute o comando para iniciar a aplicação
CMD ["node", "./index.js"]
