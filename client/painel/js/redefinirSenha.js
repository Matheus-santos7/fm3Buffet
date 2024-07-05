document.addEventListener("DOMContentLoaded", function (event) {
    redefinirSenha.event.init();
});

var redefinirSenha = {};

redefinirSenha.event = {
    init: function() {
        document.querySelector("#btnredefinirSenha").addEventListener("click", function(event) {
            event.preventDefault(); // Evita o comportamento padrão do link
            redefinirSenha.method.solicitacaoRedefinirSenha();
        });
    }
}

redefinirSenha.method = {
    solicitacaoRedefinirSenha: function() {
        let email = document.querySelector("#txtEmailredefinirSenha").value;
        console.log(email); // Adiciona console.log aqui para registrar o email

        if (email === "" || email === null || email === undefined) {
            // Mostrar mensagem de erro se o campo de email estiver vazio
            app.method.mensagem("Informe o E-mail, por favor!", 'red', 3000);
            return;
        } 
        // Adiciona validação de email
        else if (!app.method.isValidEmail(email)) {
            app.method.mensagem("E-mail inválido!", 'red', 3000);
            return;
        } 
        else {
            app.method.mensagem("E-mail enviado com sucesso!", 'green', 3000);

        }
            // Enviar email para redefinir senha
            // app.method.post('/usuario/redefinirSenha', { email: email },
            //     (response) => {
            //         if (response.status == "success") {
            //             app.method.mensagem("E-mail enviado com sucesso!", 'green', 3000);
            //         } else {
            //             app.method.mensagem("Erro no envio, tente novamente!", 'red', 3000);
            //         }
            //     },
            //     (xhr, ajaxOptions, error) => {
            //         console.log('xhr', xhr)
            //         console.log('ajaxOptions', ajaxOptions)
            //         console.log('error', error)
            //     }, true
            // )
        
    }
}
