const ct = require('../controllers/qrCodeController.js');
const UsuarioTokenAcesso = require('../common/protecaoAcesso');
const Acesso = new UsuarioTokenAcesso();

module.exports = (server) => {
    server.get('/qrCode', async (req, res) => {
        console.log('Route /qrCode called'); // Log para verificar se a rota está sendo chamada
        await ct.qrCode(req, res);
    });
};
