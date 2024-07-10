const { server, restify, config } = require('./server/server');
const enviarMensagem = require('./server/controllers/enviarWhatsapp.js');

// Chame a função com o número do destinatário e a mensagem
enviarMensagem('5531983134505', 'teste').then(() => {
    console.log('Função de enviar mensagem por WhatsApp testada com sucesso.');
}).catch((erro) => {
    console.error('Erro ao testar função de enviar mensagem por WhatsApp:', erro);
});

server.get('/*', restify.plugins.serveStatic({
    directory: './client',
    default: 'index.html'
}))

server.listen(config.port || 3000, () => {
    console.log(`AMBIENTE: ${config.ambiente} URL: ${config.url} PORTA: ${config.port}`)
})