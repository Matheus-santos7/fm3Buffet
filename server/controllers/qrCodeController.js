const venom = require('venom-bot');

let sessionStatus = 'notLogged'; // Variável global para armazenar o status da sessão
let venomClient = null; // Armazena a instância do cliente Venom

// Gera o QR Code e retorna para o cliente
const qrCode = async (req, res) => {
    try {
        // Remove sessão existente se houver
        if (venomClient) {
            await venomClient.close();
            venomClient = null;
        }

        venomClient = await venom.create(
            'FM3Buffet',
            (base64Qr, asciiQR, attempts, urlCode) => {
                if (!res.headersSent) {
                    res.json({ data: base64Qr });
                }
            },
            (statusSession, session) => {
                console.log('Status Session:', statusSession);
                console.log('Session name:', session);
                sessionStatus = statusSession; // Atualiza a variável global com o status da sessão
            },
            {
                logQR: false, // Defina como true para logar o QR code em ASCII no console
            }
        );
    } catch (error) {
        console.error('Error in qrCode function:', error);
        if (!res.headersSent) {
            res.status(500).json({ status: 'error', message: 'Unexpected error occurred' });
        }
    }
};

// Verifica o status da sessão e retorna o status atual
const status = (req, res) => {
    try {
        res.json({ status: 'success', data: { status: sessionStatus } });
    } catch (error) {
        console.error('Error in status function:', error);
        res.status(500).json({ status: 'error', message: 'Failed to get session status' });
    }
};

// Remove a sessão atual e retorna uma mensagem de sucesso
const removeSession = async (req, res) => {
    try {
        if (venomClient) {
            await venomClient.close();
            venomClient = null;
            sessionStatus = 'notLogged';
            res.json({ status: 'success', message: 'Session removed successfully' });
        } else {
            res.json({ status: 'error', message: 'No active session to remove' });
        }
    } catch (error) {
        console.error('Error in removeSession function:', error);
        res.status(500).json({ status: 'error', message: 'Failed to remove session' });
    }
};

module.exports = {
    qrCode,
    status,
    removeSession
};
