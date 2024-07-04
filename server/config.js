require('dotenv').config();

const dev = {
    db: process.env.MYSQL_DB_TESTE,
    host: process.env.MYSQL_HOST_TESTE,
    user: process.env.MYSQL_USER_TESTE,
    password: process.env.MYSQL_PASSWORD_TESTE,
    port: process.env.MYSQL_PORT_TESTE,
    portApp: process.env.APP_PORT_TESTE,
    dominio: process.env.APP_DOMINIO_TESTE,
    ip: process.env.APP_IP_TESTE,
    ambiente: process.env.APP_AMBIENTE_TESTE
};

const prod ={
    db: process.env.MYSQL_DB_PROD,
    host: process.env.MYSQL_HOST_PROD,
    user: process.env.MYSQL_USER_PROD,
    password: process.env.MYSQL_PASSWORD_PROD,
    port: process.env.MYSQL_PORT_PROD,
    portApp: process.env.APP_PORT_PROD,
    dominio: process.env.APP_DOMINIO_PROD,
    ip: process.env.APP_IP_PROD,
    ambiente: process.env.APP_AMBIENTE_PROD
};

console.log(prod);
console.log(dev);

var config = {
    dev: {
        url: 'http://localhost/',
        port: 3000,
        ambiente: 'DEV',
        database: {
            host: 'localhost',
            port: 3306,
            user: 'root',
            password: '123',
            database: 'deliveryOnline'
        },
    }
}

exports.get = function get(ambiente) {

    if (ambiente.toLowerCase() === 'dev') {
        return config.dev
    }

}