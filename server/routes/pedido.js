const ct = require('../controllers/pedido.js')
const UsuarioTokenAcesso = require('../common/protecaoAcesso');
const Acesso = new UsuarioTokenAcesso();

module.exports = (server) => {

    // calcula a taxa do delivery
    server.post('/pedido/taxa', async (req, res) => {
        const result = await ct.controllers().calcularTaxaDelivery(req);
        res.send(result);
    });

    // cria um novo pedido
    server.post('/pedido', async (req, res) => {
        const result = await ct.controllers().salvarPedido(req);
        res.send(result);
    });

    // obtem o pedido por id
    server.get('/pedido/:idpedido', async (req, res) => {
        const result = await ct.controllers().obterPedidoPorId(req);
        res.send(result);
    });

    // obtem o pedido do painel por id
    server.get('/pedido/painel/:idpedidostatus', Acesso.verificaTokenAcesso, async (req, res) => {
        const result = await ct.controllers().obterPedidoPorStatus(req);
        res.send(result);
    });

    // obtem o pedido por id
    server.post('/pedido/mover', Acesso.verificaTokenAcesso, async (req, res) => {
        const result = await ct.controllers().atualizarStatusPedido(req);
        res.send(result);
    });

    // recursar pedido
    server.post('/pedido/recusar/:idpedido', async (req, res) => {
        const result = await ct.controllers().recusarPedido(req);
        res.send(result);
    });

    // Relatório de histórico dos pedidos
    server.post('/pedido/historico', Acesso.verificaTokenAcesso, async (req, res) => {
        const result = await ct.controllers().historicoPedidos(req);
        res.send(result);
    });


}