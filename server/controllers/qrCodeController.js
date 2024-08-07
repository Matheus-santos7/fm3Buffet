const venom = require('venom-bot');
const fs = require('fs');
const path = require('path');

let sessionStatus = 'notLogged'; // Variável global para armazenar o status da sessão
let venomClient = null; // Armazena a instância do cliente Venom
const tokenFolder = path.join(__dirname, 'tokens', 'FM3Buffet'); // Diretório onde os tokens são salvos

// Gera o QR Code e retorna para o cliente
const qrCode = async (req, res) => {
    try {
        // Remove sessão existente se houver
        if (venomClient) {
            await venomClient.close();
            venomClient = null;
        }

        // Verifica se os tokens existem para reconectar à sessão
        if (fs.existsSync(tokenFolder)) {
            console.log('Tokens encontrados, tentando reconectar à sessão...');
        } else {
            console.log('Tokens não encontrados, criando uma nova sessão...');
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
                folderNameToken: 'tokens', // Nome da pasta ao salvar tokens
                mkdirFolderToken: './tokens', // Diretório da pasta de tokens
                logQR: false, // Defina como true para logar o QR code em ASCII no console
                autoClose: 0, // Desativa o fechamento automático do Venom após escanear o QR code
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

// Envia uma mensagem para o número de telefone especificado
const sendMessage = async (req, res, next) => {
    try {
        const { phoneNumber, message } = req.body;

        if (!venomClient) {
            res.send({ status: 'error', message: 'No active session. Please create a session first.' });
            return;
        }

        // Adiciona @c.us ao final do número de telefone, se não estiver presente
        const formattedPhoneNumber = phoneNumber.includes('@c.us') ? phoneNumber : `${phoneNumber}@c.us`;

        await venomClient.sendText(formattedPhoneNumber, message);
        res.send({ status: 'success', message: 'Message sent successfully' });
    } catch (error) {
        console.error('Error in sendMessage function:', error);
        res.send({ status: 'error', message: 'Failed to send message' });
    }
};


module.exports = {
    qrCode,
    status,
    removeSession,
    sendMessage,
};
