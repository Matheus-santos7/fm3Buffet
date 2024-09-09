
var config = {
    dev: {
        url: 'http://localhost',
        port: 3000,
        ambiente: 'DEV',
        database: {
            host: '92.113.39.169',
            port: 3306,
            user: 'admin',
            password: '1101M@theuss',
            database: 'deliveryOnline'
        },
    }
}

exports.get = function get(ambiente) {

    if (ambiente.toLowerCase() === 'dev') {
        return config.dev
    }

}