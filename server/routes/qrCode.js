const ct = require('../controllers/qrCodeController.js');
const UsuarioTokenAcesso = require('../common/protecaoAcesso');
const Acesso = new UsuarioTokenAcesso();

module.exports = (server) => {
    server.get('/qrCode', async (req, res) => {
        await ct.qrCode(req, res);
    });

    server.get('/qrCode/status', async (req, res) => {
        await ct.status(req, res);
    });

    server.post('/qrCode/removeSession', async (req, res) => {
        await ct.removeSession(req, res);
    });
};

