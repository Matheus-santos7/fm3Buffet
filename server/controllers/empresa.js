/**
 * Módulo de controladores para operações relacionadas à empresa.
 * @module controllers/empresa
 */

const AcessoDados = require('../db/acessodados.js');
const db = new AcessoDados();
const ReadCommandSql = require('../common/readCommandSql.js');
const readCommandSql = new ReadCommandSql();
const UsuarioTokenAcesso = require('../common/protecaoAcesso');
const Acesso = new UsuarioTokenAcesso();

const controllers = () => {

    /**
     * Obtém os dados da empresa.
     * @async
     * @function obterDados
     * @param {Object} req - Objeto de requisição.
     * @returns {Object} - Resultado da operação.
     */
    const obterDados = async (req) => {
        try {
            var ComandoSQL = await readCommandSql.retornaStringSql('obterDados', 'empresa');
            var result = await db.Query(ComandoSQL);
            return {
                status: 'success',
                data: result,
            }
        } catch (ex) {
            console.log(ex);
            return {
                status: 'error',
                message: 'Falha ao obter os dados da empresa.'
            }
        }
    }

    /**
     * Valida se a empresa está aberta no momento da requisição.
     * @async
     * @function validarEmpresaAberta
     * @param {Object} req - Objeto de requisição.
     * @returns {Object} - Resultado da operação.
     */
    const validarEmpresaAberta = async (req) => {
        try {
            var ComandoSQL = await readCommandSql.retornaStringSql('obterHorarios', 'horario');
            var horarios = await db.Query(ComandoSQL);

            if (horarios != undefined && horarios.length > 0) {
                let dataAtual = new Date();
                let diaSemana = dataAtual.getDay();
                let listaDias = [];

                horarios.forEach((e, i) => {
                    if (e.diainicio < e.diafim) {
                        for (let dia = e.diainicio; dia <= e.diafim; dia++) {
                            listaDias.push({
                                diaSemana: dia,
                                iniciohorarioum: e.iniciohorarioum,
                                iniciohorariodois: e.iniciohorariodois,
                                fimhorarioum: e.fimhorarioum,
                                fimhorariodois: e.fimhorariodois
                            });
                        }
                    } else if (e.diainicio > e.diafim) {
                        for (let dia = e.diafim; dia <= e.diainicio; dia++) {
                            listaDias.push({
                                diaSemana: dia,
                                iniciohorarioum: e.iniciohorarioum,
                                iniciohorariodois: e.iniciohorariodois,
                                fimhorarioum: e.fimhorarioum,
                                fimhorariodois: e.fimhorariodois
                            });
                        }
                    } else if (e.diainicio == e.diafim) {
                        listaDias.push({
                            diaSemana: e.diainicio,
                            iniciohorarioum: e.iniciohorarioum,
                            iniciohorariodois: e.iniciohorariodois,
                            fimhorarioum: e.fimhorarioum,
                            fimhorariodois: e.fimhorariodois
                        });
                    }
                });

                let existe = listaDias.find((elem) => { return elem.diaSemana == diaSemana; });

                if (existe != undefined) {
                    let horarioAtual = dataAtual.getTime();
                    let diaAtual = dataAtual.getDate();
                    let mesAtual = dataAtual.getMonth() + 1;
                    let anoAtual = dataAtual.getFullYear();

                    if (diaAtual < 10) { diaAtual = '0' + diaAtual };
                    if (mesAtual < 10) { mesAtual = '0' + mesAtual };

                    let iniciohorarioum = existe.iniciohorarioum != null ? new Date(`${anoAtual}-${mesAtual}-${diaAtual} ${existe.iniciohorarioum}:00`).getTime() : null;
                    let iniciohorariodois = existe.iniciohorariodois != null ? new Date(`${anoAtual}-${mesAtual}-${diaAtual} ${existe.iniciohorariodois}:00`).getTime() : null;
                    let fimhorarioum = existe.fimhorarioum != null ? new Date(`${anoAtual}-${mesAtual}-${diaAtual} ${existe.fimhorarioum}:00`).getTime() : null;
                    let fimhorariodois = existe.fimhorariodois != null ? new Date(`${anoAtual}-${mesAtual}-${diaAtual} ${existe.fimhorariodois}:00`).getTime() : null;

                    if (iniciohorarioum != null && fimhorarioum != null) {
                        if (horarioAtual >= iniciohorarioum && horarioAtual <= fimhorarioum) {
                            return {
                                status: 'success',
                                data: true
                            }
                        }
                    }

                    if (iniciohorariodois != null && fimhorariodois != null) {
                        if (horarioAtual >= iniciohorariodois && horarioAtual <= fimhorariodois) {
                            return {
                                status: 'success',
                                data: true
                            }
                        }
                    }

                    return {
                        status: 'error',
                        message: 'Estabelecimento fechado.',
                        data: false
                    }
                } else {
                    return {
                        status: 'error',
                        message: 'Estabelecimento fechado.',
                        data: false
                    }
                }
            } else {
                return {
                    status: 'error',
                    message: 'Estabelecimento fechado.',
                    data: false
                }
            }
        } catch (ex) {
            console.log(ex);
            return {
                status: 'error',
                message: 'Falha ao validar horário.',
                data: false
            }
        }
    }

    /**
     * Obtém os dados completos da empresa.
     * @async
     * @function obterDadosCompletos
     * @param {Object} req - Objeto de requisição.
     * @returns {Object} - Resultado da operação.
     */
    const obterDadosCompletos = async (req) => {
        try {
            var ComandoSQL = await readCommandSql.retornaStringSql('obterDadosCompletos', 'empresa');
            var result = await db.Query(ComandoSQL);
            return {
                status: 'success',
                data: result,
            }
        } catch (ex) {
            console.log(ex);
            return {
                status: 'error',
                message: 'Falha ao obter os dados da empresa.'
            }
        }
    }

    /**
     * Salva os dados da empresa.
     * @async
     * @function salvarDadosSobre
     * @param {Object} req - Objeto de requisição.
     * @returns {Object} - Resultado da operação.
     */
    const salvarDadosSobre = async (req) => {
        try {
            let _empresaId = Acesso.retornaCodigoTokenAcesso('IdEmpresa', req.headers['authorization']);
            req.body.idempresa = _empresaId;

            var ComandoSQL = await readCommandSql.retornaStringSql('salvarDadosSobre', 'empresa');
            var result = await db.Query(ComandoSQL, req.body);

            return {
                status: "success",
                message: "Dados atualizados com sucesso!"
            }
        } catch (ex) {
            return {
                status: "error",
                message: "Falha ao atualizar dados. Tente novamente.",
                ex: ex
            }
        }
    }

    /**
     * Salva os dados do endereço da empresa.
     * @async
     * @function salvarDadosEndereco
     * @param {Object} req - Objeto de requisição.
     * @returns {Object} - Resultado da operação.
     */
    const salvarDadosEndereco = async (req) => {
        try {
            let _empresaId = Acesso.retornaCodigoTokenAcesso('IdEmpresa', req.headers['authorization']);
            req.body.idempresa = _empresaId;

            var ComandoSQL = await readCommandSql.retornaStringSql('salvarDadosEndereco', 'empresa');
            var result = await db.Query(ComandoSQL, req.body);

            return {
                status: "success",
                message: "Dados atualizados com sucesso!"
            }
        } catch (ex) {
            return {
                status: "error",
                message: "Falha ao atualizar dados. Tente novamente.",
                ex: ex
            }
        }
    }

    return Object.create({
        obterDados,
        validarEmpresaAberta,
        obterDadosCompletos,
        salvarDadosSobre,
        salvarDadosEndereco
    })
}

module.exports = Object.assign({ controllers })