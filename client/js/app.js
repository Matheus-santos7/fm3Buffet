document.addEventListener("DOMContentLoaded", function (event) {
});

var app = {};

app.event = {

    init: (home = false) => {

        app.method.validarEmpresaAberta(home);
    }

}

app.method = {

    // centraliza as chamadas de get
    get: (url, callbackSuccess, callbackError, login = false) => {

        try {
            if (app.method.validaToken(login)) {

                let xhr = new XMLHttpRequest();
                xhr.open('GET', url);
                xhr.setRequestHeader("Content-Type", 'application/json;charset=utf-8');
                xhr.setRequestHeader("Authorization", app.method.obterValorSessao('token'));

                xhr.onreadystatechange = function () {

                    if (this.readyState == 4) {

                        if (this.status == 200) {
                            return callbackSuccess(JSON.parse(xhr.responseText))
                        }
                        else {

                            // se o retorno for não autorizado, redireciona o usuário para o login
                            if (xhr.status == 401) app.method.logout();

                            return callbackError(xhr.responseText);
                        }

                    }

                }

                xhr.send();

            }
        }
        catch (ex) {
            return callbackError(ex);
        }

    },

    // centraliza as chamadas de post
    post: (url, dados, callbackSuccess, callbackError, login = false) => {

        try {
            if (app.method.validaToken(login)) {

                let xhr = new XMLHttpRequest();
                xhr.open('POST', url);
                xhr.setRequestHeader("Content-Type", 'application/json;charset=utf-8');
                xhr.setRequestHeader("Authorization", app.method.obterValorSessao('token'));

                xhr.onreadystatechange = function () {

                    if (this.readyState == 4) {

                        if (this.status == 200) {
                            return callbackSuccess(JSON.parse(xhr.responseText))
                        }
                        else {

                            // se o retorno for não autorizado, redireciona o usuário para o login
                            if (xhr.status == 401) app.method.logout();

                            return callbackError(xhr.responseText);
                        }

                    }

                }

                xhr.send(dados);

            }
        }
        catch (ex) {
            return callbackError(ex);
        }

    },

// Centraliza as chamadas de POST
upload: (url, dados, callbackSuccess, callbackError, login = false) => {
    try {
        // Verifica se o token é válido antes de prosseguir
        if (app.method.validaToken(login)) {

            // Cria uma nova instância de XMLHttpRequest
            let xhr = new XMLHttpRequest();
            
            // Configura a requisição para ser POST e assíncrona
            xhr.open('POST', url, true);
            
            // Define o cabeçalho da requisição para enviar um token de autorização
            xhr.setRequestHeader("Authorization", app.method.obterValorSessao('token'));
            
            // Define o cabeçalho correto para o tipo de conteúdo sendo enviado (multipart/form-data)
            xhr.setRequestHeader("Mime-Type", 'multipart/form-data');

            // Define o que fazer quando o estado da requisição mudar
            xhr.onreadystatechange = function () {
                // Verifica se a requisição foi concluída (readyState === 4)
                if (this.readyState === 4) {
                    // Se o status for 200 (OK), chama o callback de sucesso
                    if (this.status === 200) {
                        return callbackSuccess(JSON.parse(xhr.responseText));
                    } 
                    // Se o status for 401 (Não autorizado), chama o logout e o callback de erro
                    else {
                        if (xhr.status === 401) app.method.logout();
                        return callbackError(xhr.responseText);
                    }
                }
            };

            // Envia a requisição com os dados fornecidos
            xhr.send(dados);

        }
    } catch (ex) {
        // Se houver um erro durante o processo, chama o callback de erro com o erro capturado
        return callbackError(ex);
    }
},

    // método para validar se o token existe. É chamado em todas as requisições internas
    validaToken: (login = false) => {

        var tokenAtual = app.method.obterValorSessao('token');

        if ((tokenAtual == undefined || tokenAtual == null || tokenAtual == "" || tokenAtual == 'null') && !login) {
            window.location.href = '/painel/login.html';
            return false;
        }

        return true;
    },

    // grava o token no localstorage
    gravarValorSessao: (valor, local) => {
        localStorage[local] = valor;
    },

    // retorna o token atual
    obterValorSessao: (local) => {
        return localStorage[local];

    },

    // remove uma sessao 
    removerSessao: (local) => {
        localStorage.removeItem(local);
    },

    // método que limpa toda o localStorage e redireciona para o login
    logout: () => {
        localStorage.clear();
        window.location.href = '/painel/login.html';
    },

    // método genérico para mensagens
    mensagem: (texto, cor = 'red', tempo = 3500) => {

        let container = document.querySelector('#container-mensagens');

        // Travar até 3 mensagens
        if (container.childElementCount === 3) {
            return;
        }

        let id = Math.floor(Date.now() * Math.random()).toString();

        let msg = `<div id="msg-${id}" class="animated fadeInDown toast ${cor}">${texto}</div>`;

        container.innerHTML += msg;

        setTimeout(() => {
            document.querySelector(`#msg-${id}`).classList.remove('fadeInDown');
            document.querySelector(`#msg-${id}`).classList.add('fadeOutUp');
            setTimeout(() => {
                document.querySelector(`#msg-${id}`).remove();
            }, 800);
        }, tempo);

    },

    // método que exibe o loader
    loading: (running = false) => {

        if (running) {
            document.querySelector(".loader-full").classList.remove('hidden');
        }
        else {
            document.querySelector(".loader-full").classList.add('hidden');
        }

    },

    // valida se a empresa está aberta
    validarEmpresaAberta: (home = false) => {

        app.method.loading(true);

        app.method.get('/empresa/open',
            (response) => {

                app.method.loading(false);

                // Se estiver na tela principal do cardápio
                if (home) {
                    document.querySelector(".status-open").classList.remove('hidden');
                }

                if (response.status == "error") {

                    // Altera o label de Aberto/Fechado (se estiver na tela principal do cardápio)
                    if (home) {
                        document.querySelector(".status-open").classList.add('closed');
                        document.querySelector("#lblLojaAberta").innerText = 'Fechado';
                    }

                    // Exibe o menu de loja fechada
                    document.querySelector("#menu-bottom").remove();
                    document.querySelector("#menu-bottom-closed").classList.remove('hidden');
                    return;
                }

                // Se estiver na tela principal do cardápio
                if (home) {
                    document.querySelector(".status-open").classList.remove('closed');
                    document.querySelector("#lblLojaAberta").innerText = 'Aberto';
                }

                document.querySelector("#menu-bottom").classList.remove('hidden');
                document.querySelector("#menu-bottom-closed").remove();

            },
            (xhr, ajaxOptions, error) => {
                console.log('xhr', xhr)
                console.log('ajaxOptions', ajaxOptions)
                console.log('error', error)
            }, true
        )

    },

    // carregar empresa
    carregarDadosEmpresa: () => {

        document.querySelector(".nome-empresa").innerHTML = app.method.obterValorSessao('Nome');
        document.querySelector(".email-empresa").innerHTML = app.method.obterValorSessao('Email');

        let logotipo = app.method.obterValorSessao('Logo');
        if (logotipo != undefined && logotipo != null && logotipo != '') {
            document.querySelector(".logo-empresa").src = '/public/images/empresa/' + logotipo;
        }
        else {
            document.querySelector(".logo-empresa").src = '/public/images/empresa/default.jpg';
        }


    },

    // cria um id aleatório
    criarGuid: () => {
        return "00000000-0000-0000-0000-000000000000".replace(/[018]/g, c =>
            (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16)
        );
    },

    // Função para verificar se o email tem o formato correto
    isValidEmail: (email) => {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    },

    // Função para verificar se o telefone tem o formato correto
    isValidPhone: (telefonecliente) => {
        // Formatar o telefoneCliente
        telefonecliente = telefonecliente.replace(/[^\d]/g, '');
        if (telefonecliente.length === 11) {
            telefonecliente = `55${telefonecliente}`;
        }
        phoneCliente = `${telefonecliente}@c.us`;

        return phoneCliente
    },
}
