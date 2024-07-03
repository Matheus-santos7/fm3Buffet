
var config = {
    dev: {
        url: 'http://localhost/',
        port: 3000,
        ambiente: 'DEV',
        database: {
            host: 'db',
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