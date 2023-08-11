/**
 * Construtor da controladora da pagina inicial
 * 
 * Aqui, foi definido como uma classe, mas pode ser instanciada como uma funcao.
 * Nesse caso da classe, necessario ser usado os elementos inerentes a instancia atual (this)
 */
class ControladoraCentral {

    /**
     * Importacao dos elementos nativos injetados pelo SNK.JS ou por modulos devidamente definidos
     */
    constructor (ObjectUtils, Criteria, DateUtils, SanPopup, MessageUtils, $scope) {

        /** **/
        /** REMOCAO DO FRAME (frame de entorno padrao dos componentes de BI)                             **/
        /** **/
        /** Ele recarregara o _iframe_ do componente de BI, por isso, informe o                          **/
        /** local onde ele encontrara novamente a pagina inicial JSP na propriedade                      **/
        /** `paginaInicial`. E faremos a busca do componente a ser recarregado baseado                   **/
        /** no nome exato do componente que devemos informar a propriedade `instancia`                   **/
        /** **/
            JX.removerFrame ({
                paginaInicial: 'paginas/standalone/index.jsp', /** Local da pagina inicial(nao use BASE_FOLDER) **/
                instancia: 'TELA_HTML5'                        /** Nome EXATO (case sensitive) do Componente BI **/
            });
        /** **/

        /* Interceptadores da entidade de tela */
            ObjectUtils.implements (this, IDynaformInterceptor);
            ObjectUtils.implements (this, IDatagridInterceptor);
        /* */

        /* Modulos de componentes necessarios ao sistema */
            this.Criteria       = Criteria;
            this.DateUtils      = DateUtils;
            this.SanPopup       = SanPopup;
            this.MessageUtils   = MessageUtils;
        /* */

        /* Variaveis com os dados da entidade principal da tela */
            this.dataset        = undefined;
            this.datagrid       = undefined;
        /* */

    }


    /**
     * Evento disparado ao se finalizar a criacao da instancia atual do Dataset
     * 
     * @param { any } dataset Instancia do conjunto de informacoes dos registros para preencher a grade de registros
     */
    aoCriarDataset (dataset) {

        /* Define o novo dataset como o Dataset atual a ser manipulado */
            this.dataset = dataset;
        /* */

        /* Inicializa-atualiza as informacoes do dataset. Evite carregar automaticamente os dados em tabelas grandes */
            this.dataset.initAndRefresh ();
        /* */

    }



    /**
     * Evento disparado ao termino do carregamento da grade de registros
     * 
     * @param { any } datagrid Instancia virtual da grade de registros
     */
    aoCarregarDatagrid (datagrid) {
        this.datagrid = datagrid;
    }



    /**
     * Evento disparado na interacao do usuario ou tela ao recarrregar os dados do Dataset
     * 
     * @returns { Promise <any> } Promessa contendo um set com os novos dados para o Dataset
     */
    async manipularAtualizar () {

        /* Realiza a consulta (asincrona) no banco trazendo os registros formatados como objetos JS */
            let marcas = await JX.consultar (`SELECT * FROM TGFMAR`);
        /* */

        /* Itera sobre todos os registros, criando um campo adicional virtual */
            marcas = marcas.map (
                marca => ({ ...marca, ADICIONAL: `${ marca.CODIGO }-${ marca.DESCRICAO }` })
            );
        /* */

        /* Devolve os registros atualizados */
            return marcas;
        /* */
    }



    /**
     * Evento disparado na interacao do usuario ou tela ao tentar remover um registro do Dataset
     * 
     * @returns { Promise <any> } Promessa contendo um set com os novos dados para o Dataset
     */
    manipularRemover () {
        this.MessageUtils.showError (this.dicionario.mensagem.funcionalidadeNaoImplementada);
    }

}