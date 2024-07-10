// enviarWhatsapp.js
const venom = require('venom-bot');

async function enviarMensagem(numero, mensagem) {
    try {
        const client = await venom.create({
            session: 'whatsapp-fm3buffet', 
            multidevice: true, // Para utilizar o WhatsApp Web Multidevice
            headless: true, // Para rodar o navegador em modo headless
            devtools: false, // Não abrir o devtools
            useChrome: true // Forçar o uso do Chrome
        });
        const result = await client.sendText(`${numero}@c.us`, mensagem);
        console.log('Mensagem enviada:', result);
    } catch (error) {
        console.error('Erro ao enviar mensagem:', error);
    }
}

module.exports = enviarMensagem;
