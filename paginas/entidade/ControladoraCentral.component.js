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
                paginaInicial: 'paginas/entidade/index.jsp', /** Local da pagina inicial(nao use BASE_FOLDER) **/
                instancia: 'TELA_HTML5'                      /** Nome EXATO (case sensitive) do Componente BI **/
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
            this.formulario     = undefined;
            this.nomeEntidade   = `MarcaProduto`;
        /* */

    }


    /**
     * Evento disparado ao se finalizar a criacao e montagem do componente de formulario dinamico
     * 
     * @param { any } dynaform Instancia e informacoes sobre o formulario dinamico
     * @param  { any } dataset Instancia do conjunto de informacoes dos registros para preencher a grade de registros
     */
    aoCarregarDynaform (dynaform, dataset) {

        /* Checa se a tabela carregada eh a entidade */
        if (dataset.getEntityName () === this.nomeEntidade) {

            /* Salva as informacoes da tabela */
            this.dataset    = dataset;
            this.formulario = dynaform;

            /* Inicializa o dataset com os valores iniciais */
            this.dataset.initAndRefresh ();

            /* Alterna o modo de visualizacao do formulario para o modo grade */
            this.formulario.goToGridView ();

        }

    }

}