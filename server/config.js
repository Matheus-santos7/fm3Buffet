require('dotenv').config();

const config = {
    prod: {
        url: process.env.APP_DOMINIO || process.env.APP_IP || 'http://localhost',
        port: process.env.APP_PORT || 3000,
        ambiente: process.env.APP_AMBIENTE,
        database: {
            host: process.env.DB_HOST,
            port: process.env.DB_PORT,
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            database: process.env.DB_NAME
        },
    }
}

exports.get = function get(ambiente) {
    if (ambiente.toLowerCase() === 'prod') {
        return config.prod;
    }
}