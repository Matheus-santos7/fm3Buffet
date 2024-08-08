// Importa a classe AcessoDados do módulo '../db/acessodados.js'
const AcessoDados = require('../db/acessodados.js');
// Cria uma instância da classe AcessoDados
const db = new AcessoDados();

// Importa a classe ReadCommandSql do módulo '../common/readCommandSql.js'
const ReadCommandSql = require('../common/readCommandSql.js');
// Cria uma instância da classe ReadCommandSql
const readCommandSql = new ReadCommandSql();

// Importa o controlador de imagens
const ctImagem = require('../controllers/imagem');

/**
 * Função que define os controladores de categoria.
 * @returns {Object} - Objeto contendo os métodos do controlador de categoria.
 */
const controllers = () => {

    /**
     * Lista todas as categorias no cardápio.
     * @async
     * @function listarTodas
     * @param {Object} req - Objeto de requisição do cliente.
     * @returns {Promise<Object>} - Retorna um objeto com o status e os dados das categorias ou uma mensagem de erro.
     */
    const listarTodas = async (req) => {
        try {
            // Obtém a string SQL para listar todas as categorias
            var ComandoSQL = await readCommandSql.retornaStringSql('listarTodas', 'categoria');
            // Executa a consulta no banco de dados
            var result = await db.Query(ComandoSQL);

            // Retorna o resultado da consulta com status de sucesso
            return {
                status: 'success',
                data: result,
            };
        } catch (ex) {
            // Loga o erro no console
            console.log(ex);
            // Retorna uma mensagem de erro
            return {
                status: 'error',
                message: 'Falha ao obter as categorias.'
            };
        }
    };

    /**
     * Salva os dados da categoria.
     * @async
     * @function salvarDados
     * @param {Object} req - Objeto de requisição do cliente.
     * @returns {Promise<Object>} - Retorna um objeto com o status da operação e os dados da categoria ou uma mensagem de erro.
     */
    const salvarDados = async (req) => {
        try {
            // Obtém o ID da categoria do corpo da requisição
            var idcategoria = req.body.idcategoria;

            // Verifica se é para adicionar ou atualizar uma categoria
            if (idcategoria > 0) {
                // Código para atualizar a categoria
            } else {
                // Código para adicionar uma nova categoria
            }

            // Retorna o resultado da operação com status de sucesso
            return {
                status: 'success',
                message: 'Categoria salva com sucesso.'
            };
        } catch (ex) {
            // Loga o erro no console
            console.log(ex);
            // Retorna uma mensagem de erro
            return {
                status: 'error',
                message: 'Falha ao salvar a categoria.'
            };
        }
    };

    /**
     * Ordena as categorias.
     * @async
     * @function ordenarCategorias
     * @param {Object} req - Objeto de requisição do cliente.
     * @returns {Promise<Object>} - Retorna um objeto com o status da operação ou uma mensagem de erro.
     */
    const ordenarCategorias = async (req) => {
        try {
            // Obtém a lista de categorias do corpo da requisição
            var lista = req.body;

            console.log('Inicio');

            const promises = await lista.map(async elem => {
                new Promise(async (resolve, reject) => {

                    var ComandoSQL = await readCommandSql.retornaStringSql('atualizarOrdemCategoria', 'categoria');
                    await db.Query(ComandoSQL, elem);

                    resolve(elem);

                });
            });

            console.log('Fim');

            await Promise.all(promises);

            return {
                status: 'success',
                message: 'Categorias ordenadas com sucesso.'
            };
        } catch (ex) {
            console.log(ex);
            return {
                status: 'error',
                message: 'Falha ao ordenar as categorias.'
            };
        }
    };

    /**
     * Duplica a categoria.
     * @async
     * @function duplicarCategoria
     * @param {Object} req - Objeto de requisição do cliente.
     * @returns {Promise<Object>} - Retorna um objeto com o status da operação ou uma mensagem de erro.
     */
    const duplicarCategoria = async (req) => {
        try {
            // Obtém o ID da categoria do corpo da requisição
            var idcategoria = req.body.idcategoria;

            // Obtém todos os produtos da categoria
            var ComandoSQLProdutos = await readCommandSql.retornaStringSql('obterPorCategoriaIdSemOrdenacao', 'produto');
            var produtos_categoria = await db.Query(ComandoSQLProdutos, { idcategoria: idcategoria });

            // Obtém as informações da categoria
            var ComandoSQLCategoria = await readCommandSql.retornaStringSql('obterPorId', 'categoria');
            var dados_categoria = await db.Query(ComandoSQLCategoria, { idcategoria: idcategoria });

            // Altera o nome para "Cópia" e insere no banco de dados
            dados_categoria[0].nome = dados_categoria[0].nome + " - Cópia";
            var ComandoSQLAddCategoria = await readCommandSql.retornaStringSql('adicionarCategoria', 'categoria');
            var nova_categoria = await db.Query(ComandoSQLAddCategoria, dados_categoria[0]);

            if (nova_categoria.insertId != undefined && nova_categoria.insertId > 0) {
                // Percorre os produtos e adiciona na nova categoria
                console.log('Inicio');
                const promises = await produtos_categoria.map(async elem => {
                    const idImagemNovo = new Date().valueOf();
                    var ComandoSQLAddProduto = await readCommandSql.retornaStringSql('adicionarProduto', 'produto');
                    await db.Query(ComandoSQLAddProduto, {
                        idcategoria: nova_categoria.insertId,
                        nome: elem.nome,
                        descricao: elem.descricao,
                        valor: elem.valor,
                        imagem: idImagemNovo + "-" + elem.imagem,
                        ordem: elem.ordem
                    });
                    // Faz uma cópia da imagem para pasta
                    await ctImagem.controllers().copy(elem.imagem, idImagemNovo);
                });
                await Promise.all(promises);
                console.log('fim');
                return {
                    status: 'success',
                    message: 'Categoria duplicada com sucesso.'
                };
            } else {
                return {
                    status: 'error',
                    message: 'Falha ao duplicar a categoria.'
                };
            }
        } catch (ex) {
            console.log(ex);
            return {
                status: 'error',
                message: 'Falha ao duplicar a categoria.'
            };
        }
    };

    /**
     * Remove a categoria.
     * @async
     * @function removerCategoria
     * @param {Object} req - Objeto de requisição do cliente.
     * @returns {Promise<Object>} - Retorna um objeto com o status da operação ou uma mensagem de erro.
     */
    const removerCategoria = async (req) => {
        try {
            // Obtém o ID da categoria do corpo da requisição
            var idcategoria = req.body.idcategoria;

            // Obtém todos os produtos da categoria (para remover as imagens)
            var ComandoSQLSelectProdutos = await readCommandSql.retornaStringSql('obterPorCategoriaIdSemOrdenacao', 'produto');
            var produtos_categoria = await db.Query(ComandoSQLSelectProdutos, { idcategoria: idcategoria });

            // Remove todos os produtos da categoria
            var ComandoSQLProdutos = await readCommandSql.retornaStringSql('removerPorCategoriaId', 'produto');
            await db.Query(ComandoSQLProdutos, { idcategoria: idcategoria });

            // Remove a categoria
            var ComandoSQLCategoria = await readCommandSql.retornaStringSql('removerPorId', 'categoria');
            await db.Query(ComandoSQLCategoria, { idcategoria: idcategoria });

            // Remove as imagens dos produtos da pasta
            const promises = await produtos_categoria.map(async elem => {
                // Cria um objeto da mesma estrutura que o método espera
                const requisicao = {
                    body: {
                        imagem: elem.imagem
                    }
                };
                // Remove a imagem
                await ctImagem.controllers().remove(requisicao);
            });
            await Promise.all(promises);

            return {
                status: 'success',
                message: 'Categoria removida.'
            };
        } catch (ex) {
            console.log(ex);
            return {
                status: 'error',
                message: 'Falha ao remover a categoria.'
            };
        }
    };

    // Retorna os métodos do controlador de categoria
    return {
        listarTodas,
        salvarDados,
        ordenarCategorias,
        duplicarCategoria,
        removerCategoria
    };
};

// Exporta os controladores de categoria
module.exports = controllers;