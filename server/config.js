var config = {
    dev: {
        url: 'http://localhost/',
        port: 3000,
        ambiente: 'DEV',
        database: {
            host: 'database-2.chgoy2ig60z9.us-east-1.rds.amazonaws.com',
            port: 3306,
            user: 'teste',
            password: 'testeteste',
            database: 'deliveryOnline'
        },
    }
}

exports.get = function get(ambiente) {

    if (ambiente.toLowerCase() === 'dev') {
        return config.dev
    }

}