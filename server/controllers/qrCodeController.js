const venom = require('venom-bot');

const qrCode = async (req, res) => {
    console.log('qrCode function called'); // Log para verificar se a função está sendo chamada
    try {
        await venom.create(
            'FM3Buffet',
            (base64Qr, asciiQR, attempts, urlCode) => {
                console.log('QR code generated'); // Log para verificar se o QR code foi gerado
                if (!res.headersSent) {
                    res.json({ data: base64Qr });
                }
            },
            (statusSession, session) => {
                console.log('Status Session: ', statusSession);
                console.log('Session name: ', session);
            },
            {
                logQR: false, // Defina como true para logar o QR code em ASCII no console
            }
        ).catch((error) => {
            console.error('Error in venom.create:', error);
            if (!res.headersSent) {
                return res.status(500).json({ status: 'error', message: 'Failed to generate QR code' });
            }
        });
    } catch (error) {
        console.error('Error in qrCode function:', error);
        if (!res.headersSent) {
            return res.status(500).json({ status: 'error', message: 'Unexpected error occurred' });
        }
    }
};

module.exports = {
    qrCode
};
