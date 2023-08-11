class Impressao {

    static async imprimir (idRelatorio, idOrdemServico, idOrdemServicoExterna) {

        const url = `${
            window.location.origin
        }/mge/service.sbr?serviceName=${
            `VisualizadorRelatorios.visualizarRelatorio`
        }&outputType=json&mgeSession=${
            JX.getCookie ('JSESSIONID').replace ('.master', '')
        }`;

        const corpoRequisicao = {
            serviceName: "VisualizadorRelatorios.visualizarRelatorio",
            requestBody: {
                relatorio: {
                    nuRfe: String (idRelatorio),
                    parametros: {
                        parametro: [
                            {
                                classe: "java.math.BigDecimal",
                                nome: "PK_NUMOS",
                                valor: Number (idOrdemServico)
                            },
                            {
                                classe: "java.math.BigDecimal",
                                nome: "PK_NUMOSINT",
                                valor: Number (idOrdemServicoExterna)
                            }
                        ]
                    }
                }
            }
        }

        const headers = {
            'Content-Type': 'application/json',
            'Cookie': `JSESSIONID=${ JX.getCookie ('JSESSIONID') }`
        }


        const requisicao = await (
            await fetch (url, {
                method: 'POST',
                headers,
                body: JSON.stringify (corpoRequisicao)
            })
        ).json ();

        /* Valida se o salvamento foi realizado com sucesso */
            if (!requisicao.status || Number (requisicao.status) == 0) {
                throw new Error (requisicao.statusMessage);
            }
        /* */

        const relatorioSessao = requisicao.responseBody.chave.valor;

        // Abrir nova aba
        window.open (
            `${ location.origin }/mge/visualizadorArquivos.mge?chaveArquivo=${ relatorioSessao }`,
            '_blank'
        );

    }

    static async buscarRelatorioImpressao (nomeTabela) {

        const queryRelatorioImpressao = `
            WITH
                Instancia AS (
                    SELECT * FROM TDDINS WHERE NOMETAB = '${ nomeTabela }'
                ),
                Relatorio AS (
                    SELECT *
                    FROM TSIRFE
                        INNER JOIN Instancia ON Instancia.NUINSTANCIA = TSIRFE.NUINSTANCIA
                )
            
            SELECT NURFE FROM Relatorio`;
        const resultadoRelatorios = await JX.consultar (queryRelatorioImpressao);

        if (resultadoRelatorios && resultadoRelatorios.length > 0)
            return resultadoRelatorios [0].NURFE;
        else
            throw new Error ('Não foi possível encontrar o relatório de impressão');

    }

}