<!-- Injecao de variaveis e dependencias para a compilacao do JSP -->
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
    <%@ page import="br.com.sankhya.modelcore.auth.AuthenticationInfo" %>
    <%@ taglib prefix="snk" uri="/WEB-INF/tld/sankhyaUtil.tld" %>
<!--  -->

<!doctype html>
<html lang= "pt-BR">

<head>
    <title></title><meta charset= "UTF-8" />

    <!-- ESTILOS -->
        <!-- Estilos Externos -->
            <link rel= "stylesheet" href= "https://ajax.googleapis.com/ajax/libs/angular_material/1.2.1/angular-material.min.css" />
            <link rel= "stylesheet" href= "https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
        <!-- -->

        <!-- Estilos Internos -->
            <link rel= "stylesheet" href= "/mge/assets/vendors/ui-grid/ui-grid.min.css?v=" />
            <link rel= "stylesheet" href= "/mge/assets/vendors/bootstrap.min.css?v=" />
            <link rel= "stylesheet" href= "/mge/assets/vendors/loading-bar.min.css?v=" />
            <link rel= "stylesheet" href= "/mge/js/jqwidgets/styles/jqx.base.css" />
            <link rel= "stylesheet" href= "/mge/js/jqwidgets/styles/jqx.metro.css" />
            <link rel= "stylesheet" href= "/mge/assets/css/snk.min.css?v=" />
            <link rel= "stylesheet" href= "/mge/assets/vendors/bpmn/css/diagram-js.css" />
            <link rel= "stylesheet" href= "/mge/assets/vendors/bpmn/css/bpmn.css" />
            <link rel= "stylesheet" href= "/mge/assets/vendors/bpmn/css/bpmnsnk.css" />
            <link rel= "stylesheet" href= "/mge/scripts/vendors/fullcalendar/main.min.css?v=" />
            <link rel= "stylesheet" href= "/mge/html5/DynaformLauncher/DynaformLauncher.css" />
        <!-- -->

        <!-- Estilos Customizados -->
            <!-- IMPORTE AQUI SEUS ARQUIVOS CSS -->
        <!--  -->

        <!-- Estilização para remoção forcada da div de componente customizaddo -->
            <style>
                /* Remove o footer de pagina customizada */
                    body > div:nth-child(16) > div:nth-child(3) {
                        height: 0 !important;
                    }
                /* * */

                /* Maximiza o tamanho do modal de criacao de ordem de servico */
                    body > div.modal-type-default.modal.gray-background.no-padding-modal-body.sk-popup.fade.ng-isolate-scope.in > div,
                    body > div.modal-type-default.modal.no-padding-modal-body.sk-popup.ng-isolate-scope.in > div {
                        top: 5px !important;
                        left: 5px !important;
                        width: calc(100% - 10px) !important;
                        height: calc(100% - 10px) !important;
                    }
                        body > div.modal-type-default.modal.gray-background.no-padding-modal-body.sk-popup.fade.ng-isolate-scope.in > div > div,
                        body > div.modal-type-default.modal.no-padding-modal-body.sk-popup.ng-isolate-scope.in > div > div {
                            height: 100% !important;
                        }

                        body > div.modal-type-default.modal.gray-background.no-padding-modal-body.sk-popup.fade.ng-isolate-scope.in > div > div > div.modal-body,
                        body > div.modal-type-default.modal.no-padding-modal-body.sk-popup.ng-isolate-scope.in > div > div > div.modal-body {
                            height: calc(100% - 32px) !important;
                        }
                /* * */
            </style>
        <!-- -->
    <!-- -->


    <!-- SCRIPTS GENERICOS (_NAO MODIFICAR_) -->

        <!-- Configuracao de parametros em tela do Sankhya -->
            <script type= "text/javascript">

                /* Variaveis da internacionalizacao das strings */
                    var locale        = 'pt_BR';
                    var i18nlocal     = null; // .i18n        : buildLocalI18nVar-method : bundle do dic. de dados
                    var i18nAll       = {};   // .i18nBundles : i18nVars-method          : bundle dos defaults
                    var i18nFramework = {};   // .i18nBundles : i18nVars-method          : bundle do framework
                /* */

                /* Validacao da configuracao do workspace para escopo da tela */
                    var localHostname    = window.location.hostname;
                    var ngAppName        = "DynaformLauncherApp";
                    var isSecurityDomain = false;
                    var VSS              = null;
                    var workspace;

                    try {
                        var parentHostname = window.top.window.location.hostname;
                        
                        if (parentHostname == localHostname) {
                            isSecurityDomain = true;
                        }
                        
                        if (isSecurityDomain) {
                            workspace = parent.workspace;

                            if (!workspace) {
                                if (parent.parent.workspace) {
                                    workspace = parent.parent.workspace;
                                }
                            }
                        }
                    } catch (e) {
                        console.error (e);
                    }
                /* */


                /* Processamento das portas de comunicacao com a impressora */
                    var printerAppPort    = 9096;
                    var printerAppSSLPort = 9196;

                    try {
                        if (navigator.userAgent.indexOf ("Electron") !== -1) {
                            if (sessionStorage.getItem ("printerAppPort")) {
                                printerAppPort = parseInt (sessionStorage.getItem ("printerAppPort")); 
                                printerAppSSLPort = printerAppPort + 100;
                            }
                        }
                    } catch (err) {
                        console.log ("Erro ao consultar porta do WC: " + err);
                    }
                /* */

                /* Variaveis uteis da pagina */
                    APPLICATION_NAME= 'DynaformLauncher';
                    MODULE_ID       = 'DynaformLauncher';
                    PCSF            = "I08joRPTKIBHLGw=";
                    PROFILEID       = 'S4W8LB';
                    RAS             = "aXNTdXA=";
                    MGE_PARAMS      = "YnIuY29tLnNhbmtoeWEubWdlLm1vc3RyYS5hdmlzby5wYWdpbmEuaW5pY2lhbF9fPV9fTl9fO19fY29t"
                    + "LmFjY2Vzcy5jb25maWcuaW4uZ3JpZF9fPV9fTl9fO19fY29tLmNvbmZpZ3VyYWNhby5ncmFkZS5yZXNwZWl0YS5jb25maWcu"
                    + "dGVsYV9fPV9fTl9fO19fZ2xvYmFsLmF0YWxoby5hY29lcy5wZXJzb25hbGl6YWRhc19fPV9fTl9fO19fZ2xvYmFsLmNhcnJl"
                    + "Z2FyLnJlZ2lzdHJvcy5pbmljaWFyLnRlbGFfXz1fX05fXztfX2dsb2JhbC5ub3RpZmljYS5hbHRlcmFjYW8uZGF0YXNldF9f"
                    + "PV9fTl9fO19fZ2xvYmFsLm9yZGVuYXIuYWJhcy50b2Rhc2FiYXNfXz1fX05fXztfX2dsb2JhbC5vcmRlbmFyLmFjb2VzLnBl"
                    + "cnNvbmFsaXphZGFzX189X19OX187X19nbG9iYWwub3JkZW5hci5maWx0cm9zLnBlcnNvbmFsaXphZG9zX189X19OX187X19n"
                    + "bG9iYWwucG9ydGEuYXBwLmltcHJlc3Nhb19fPV9fOTA5Nl9fO19fZ2xvYmFsLnVzYS5hcHAuY3Vib19fPV9fTl9fO19fZ2xv"
                    + "YmFsLnVzYS5hcHAuaW1wcmVzc2FvX189X19TX187X19tZ2UuYXRpdmEubXVsdGkuYWJhc19fPV9fMV9fO19fbWdlLmNvcmUu"
                    + "Y29uZmlnLmZvcm0uaHRtbDVfXz1fXzBfXztfX21nZS5jb3JlLmZsZXgudGhlbWVfXz1fX1NfXztfX21nZS5jb3JlLmhhYmls"
                    + "aXRhLnRlbGEuaHRtbDVfXz1fXzBfXztfX21nZS5jb3JlLm1vZG8uZ3JhZGUuY29uZmlndXJhdmVsLnBlc3F1aXNhX189X19T"
                    + "X187X19tZ2UuY29yZS5xdGRlLm1heGltYS5yZWdpc3Ryb3MucGFyYS5leHBvcnRhY2FvX189X181MDAwX187X19tZ2UuY29y"
                    + "ZS50aXBvLmNvbnN1bHRhLmF1dG9tYXRpY2EuY2VwX189X18yX187X19tZ2UuaHRtbDUubm92YS5wZXNxdWlzYS50ZWxhLmlu"
                    + "aWNpYWxfXz1fX1NfXztfX21nZS5xdGQucmVnaXN0cm9zLm1haXMudXRpbGl6YWRvcy5hcHJlc2VudGFjYW9fXz1fX05fXztf"
                    + "X21nZS5xdGQucmVnaXN0cm9zLm1haXMudXRpbGl6YWRvcy5wZXNxdWlzYV9fPV9fMTBfXztfX21nZS5xdGQucmVnaXN0cm9z"
                    + "Lm1haXMudXRpbGl6YWRvcy5yZXNldF9fPV9fMzA=";
                /* */

            </script>
        <!-- -->

        <!-- Modulo de importacao do JQuery -->
        <script src= "/mge/js/util/jquery-1.9.1.min.js?v=">                                                     </script>
        <!-- Gerenciador do token de autenticacao -->
        <script src= "/mge/js/sf/sf.js?v=">                                                                     </script>
        <!-- Modulo responsavel pelo processamento do Base64 -->
        <script src= "/mge/js/util/Base64.js?v=">                                                               </script>
        <!-- Modulo responsavel pela chamada de outros apps do sistema -->
        <script src= "/mge/js/AppletCaller.js?v=">                                                              </script>
        <!-- Modulo responsavel pela impressao -->
        <script src= "/mge/js/impressao.js?v=">                                                                 </script>
        <!-- Modulo para correcao de layout para dispositivos IOS -->
        <script src= "/mge/scripts/custom-native-functions.js?v=">                                              </script>

        <!-- Dependencias e modulos do Angular -->
            <script src= "/mge/scripts/vendors/angular/angular.js?v=">                                          </script>
            <script src= "/mge/scripts/vendors/angular/angular-touch.js?v=">                                    </script>
            <script src= "/mge/scripts/vendors/angular/angular-animate.min.js?v=">                              </script>
            <script src= "/mge/scripts/vendors/angular/angular-aria.min.js?v=">                                 </script>
            <script src= "/mge/scripts/vendors/angular/angular-sanitize.min.js?v=">                             </script>
            <script src= "/mge/scripts/vendors/translate/angular-translate.js?v=">                              </script>
        <!-- -->

        <!-- Modulo da biblioteca de componentes do Angular Material -->
        <script src= "https://ajax.googleapis.com/ajax/libs/angular_material/1.2.1/angular-material.min.js">    </script>
        <!-- Modulo de importacao para transacoes avancadas com o Sankhya -->
        <script src= "https://cdn.jsdelivr.net/gh/wansleynery/SankhyaJX/jx.min.js">                             </script>
        <!-- Modulo responsavel pelo processamento da tela de carregamento -->
        <script src= "https://cdn.jsdelivr.net/npm/sweetalert2@11.4.13/dist/sweetalert2.all.min.js">            </script>
        <!-- Modulo que controla os avisos em tela -->
        <script src= "https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js">                   </script>

        <!-- IMPORTE AQUI SUAS BIBLIOTECAS JS ADICIONAIS -->

        <!-- Dependencias padroes das telas do Sankhya -->
            <script src="/mge/scripts/vendors/ui-bootstrap/ui-bootstrap-tpls.min.js?v=">                        </script>
            <script src="/mge/scripts/vendors/ui-grid/ui-grid.modified.js?v=">                                  </script>
            <script src="/mge/scripts/vendors/numeral/numeral.min.js?v=">                                       </script>
            <script src="/mge/scripts/vendors/moment/moment.min.js">                                            </script>
            <script src="/mge/scripts/vendors/loading-bar/loading-bar.min.js?v=">                               </script>
            <script src="/mge/scripts/vendors/sortable/sortable.min.js?v=">                                     </script>
            <script src="/mge/scripts/vendors/ui-mask/mask.min.js?v=">                                          </script>
            <script src="/mge/scripts/vendors/tinymce/tinymce.min.js?v=">                                       </script>
            <script src="/mge/scripts/vendors/tinymce/uitinymce.js?v=">                                         </script>
            <script src="/mge/scripts/vendors/tinymce/langs/pt_BR.js?v=">                                       </script>
            <script src="/mge/scripts/vendors/tinymce/langs/en_CA.js?v=">                                       </script>
            <script src="/mge/scripts/vendors/ace/ace.min.js?v=">                                               </script>
            <script src="/mge/scripts/vendors/clipboard/clipboard.min.js?v=">                                   </script>
            <script src="/mge/scripts/vendors/ag-grid/ag-grid-enterprise.js?v=">                                </script>
            <script src="/mge/scripts/vendors/bpmn/bpmn-custom-modeler.development.js?v=">                      </script>
            <script src="/mge/scripts/vendors/snapsvg/snap.svg-min.js?v=">                                      </script>
            <script src="/mge/scripts/vendors/crypto-js/crypto-js.js?v=">                                       </script>
            <script src="/mge/scripts/vendors/fullcalendar/main.min.js?v=">                                     </script>
            <script src="/mge/scripts/vendors/fullcalendar/locales/es.js?v=">                                   </script>
            <script src="/mge/scripts/vendors/fullcalendar/locales/pt-br.js?v=">                                </script>
        <!-- -->

        <!-- Dependencias e modulos customizados do Sankhya -->
            <script src= "/mge/js/jqwidgets/jqxcore.js?v=">                                                     </script>
            <script src= "/mge/js/jqwidgets/jqxdata.js?v=">                                                     </script>
            <script src= "/mge/js/jqwidgets/jqxlistbox.js?v=">                                                  </script>
            <script src= "/mge/js/jqwidgets/jqxbuttons.js?v=">                                                  </script>
            <script src= "/mge/js/jqwidgets/jqxscrollbar.js?v=">                                                </script>
            <script src= "/mge/js/jqwidgets/jqxmenu.js?v=">                                                     </script>
            <script src= "/mge/js/jqwidgets/jqxgrid.js?v=">                                                     </script>
            <script src= "/mge/js/jqwidgets/jqxgrid.selection.js?v=">                                           </script>
            <script src= "/mge/js/jqwidgets/jqxgrid.columnsresize.js?v=">                                       </script>
            <script src= "/mge/js/jqwidgets/jqxgrid.columnsreorder.js?v=">                                      </script>
            <script src= "/mge/js/jqwidgets/jqxgrid.sort.js?v=">                                                </script>
            <script src= "/mge/js/jqwidgets/jqxgrid.filter.js?v=">                                              </script>
            <script src= "/mge/js/jqwidgets/jqxgrid.aggregates.js?v=">                                          </script>
            <script src= "/mge/js/jqwidgets/jqxdropdownlist.js?v=">                                             </script>
            <script src= "/mge/scripts/snk.js?v=">                                                              </script>
            <script src= "/mge/scripts/launcher.js?v=">                                                         </script>
        <!-- -->
    <!-- -->


    <!-- CONFIGURACOES -->
        <!-- Importacao das Controladoras -->
            <script src="${BASE_FOLDER}/paginas/standalone/ControladoraCentral.component.js">                   </script>
            <!-- IMPORTE AQUI SUAS CONTROLADORAS -->
        <!-- -->

        <!-- Importacao das Services -->
            <script src="${BASE_FOLDER}/servicos/Impressao.js">                                                 </script>
            <!-- IMPORTE AQUI SUAS SERVICES -->
        <!-- -->

        <!-- Configuracoes editaveis customizadas -->
            <script>
                /* Inicializacao do modulo de tabela do Sankhya */
                    agGrid.LicenseManager.setLicenseKey (""
                        + "Sankhya_Gestao_de_Negocios_Sankhya-W_2Devs6_November_2020__"
                        + "MTYwNDYyMDgwMDAwMA==1f914bb75813904547879033c6de21d2"
                    );
                    agGrid.initialiseAgGridWithAngular1 (angular);
                /* */

                /* Defina aqui o valor que as telas originais setam para essas variaveis */
                    globalThis.APPLICATION_NAME = 'DynaformLauncher';
                    globalThis.MODULE_ID        = 'DynaformLauncher';
                    globalThis.app              = 'App';
                    globalThis.url              = '${BASE_FOLDER}';
                    globalThis.usuario          = '<%= ((AuthenticationInfo) session.getAttribute ("usuarioLogado")).getUserID ().toString () %>';
                /* */

                /* Classe com as configuracoes de processamento de strings de internacionalizacao */
                    class Runner {
                        constructor (SkI18nService, SkWorkspace) {

                            SkWorkspace.unlockSwitchApp ();

                            SkI18nService.setLang (locale);

                            angular.forEach (i18nAll, function (translations, bundleName) {
                                SkI18nService.addBundle (locale, bundleName, translations);
                            });

                            angular.forEach (i18nFramework, function (translations, bundleName) {
                                SkI18nService.addBundle (locale, bundleName, translations);
                            });

                        }
                    }
                /* */


                /* Diretiva para atributo-eventos de drag&drop */
                    var DragEventDirective = {};

                    angular.forEach (
                        'drag dragend dragenter dragexit dragleave dragover dragstart drop change'.split (' '),
                        function (eventName) {
                            var directiveName = 'ng' + eventName.charAt (0).toUpperCase () + eventName.slice (1);

                            DragEventDirective [directiveName] = ['$parse', '$rootScope', function ($parse, $rootScope) {
                                return {
                                    restrict: 'A',
                                    compile: function ($element, attr) {
                                        var fn = $parse (attr [directiveName], null, true);

                                        return function ngDragEventHandler (scope, element) {
                                            element.on (eventName, function (event) {
                                                var callback = function () {
                                                    fn (scope, { $event: event });
                                                };

                                                scope.$apply (callback);
                                            });
                                        };
                                    }
                                };
                            }];
                        }
                    );
                /* */


                /* Função inicializada pelo Launcher nativo das telas Sankhya que cuida das internacionalizacoes */
                    function startApplication () {

                        /* Instancia o modulo global do AngularJS, bem como todas as suas dependencias e controladoras */
                        angular
                            .module     (globalThis.app, [ 'snk', 'angular-loading-bar', 'ngSanitize' ])
                            .run        (Runner)
                            .directive  (DragEventDirective)
                            .controller ('ControladoraCentral',   ControladoraCentral);

                        /* Inicializa o modulo do AngularJS via manual */
                        angular.bootstrap (document, [ globalThis.app ]);
                    }
                /* */

            </script>
        <!-- -->
    <!-- -->
</head>

<body>

    <!-- Componente necessario para a preparacao fundamental inicial das telas em AngularJS -->
        <sk-application
            layout="column"
            class="dynaform-launcher"
            ng-controller="ControladoraCentral as central"
        >

            <!-- Componente de dupla-face, responsavel pelo controle da visualizacao grade-formulario -->
                <sk-double-face-panel flex
                    class= "h-400"
                    sk-dataset= "$ctrl.objetoDS"
                    sk-default-face-index= "GRID_FACE"
                >

                <!-- Componente do topo do container dupla-face que contera o sk-navigator -->
                    <sk-top-bar layout-padding>
                        <sk-vbox flex>
                            <sk-hbox class="fill-size custom-box" flex>

                                <!-- Div de alinhamento a esquerda -->
                                    <div class="box" flex>

                                        <!-- Componente responsavel pelos botoes de gerenciamento dos registros e navegacao -->
                                            <sk-navigator
                                                dataset                 = "central.dataset"
                                                show-crud               = "true"
                                                sk-always-navigation    = "true"
                                                sk-show-navigation      = "true"
                                                sk-show-remove-button   = "true"
                                                sk-show-refresh-button  = "true"
                                                sk-show-add-button      = "true"
                                                sk-show-edit-button     = "true"
                                                sk-show-save-button     = "true"
                                                sk-show-cancel-button   = "true"
                                                sk-show-copy-button     = "true"
                                                sk-show-new-layout      = "false"
                                                sk-edit-unique-record   = "false"
                                                sk-external-insertion-mode = "false"
                                            ></sk-navigator>
                                        <!--  -->

                                    </div>
                                <!--  -->

                                <!-- Div de alinhamento a direita -->
                                    <div class="box position-end">

                                        <!-- Contador de registros do Dataset (manter por ultimo quanto a alinhamento) -->
                                            <sk-rows-counter sk-dataset= "central.dataset"></sk-rows-counter> 
                                        <!--  -->

                                    </div>
                                <!--  -->

                            </sk-hbox>
                        </sk-vbox>
                    </sk-top-bar>
                <!--  -->

                <!-- Componente container da primeira face -->
                    <sk-face-one>

                        <!-- Formulario contendo a visualizacao dos campos em modo formulario -->
                            <sk-form
                                sk-dataset  = "central.dataset"
                                sk-inline   = "true"
                                sk-margin   = "10px"
                                class       = "compact-components"
                            ></sk-form>
                        <!--  -->

                    </sk-face-one>
                <!--  -->

                <!-- Componente container da segunda face -->
                    <sk-face-two>

                        <!-- Componente responsavel pela construcao virtual (nao visivel) dos registros -->
                            <sk-dataset sk-standalone
                                sk-dataset-created      = "central.aoCriarDataset     (dataset)"
                                sk-refresh-handler      = "central.manipularAtualizar ()"
                                sk-remove-handler       = "central.manipularRemover   ()"
                            >
                                <!-- Campos pertencentes as colunas nativas dos registros -->
                                    <sk-dsfield-md name = "CODIGO"   ></sk-dsfield-md>
                                    <sk-dsfield-md name = "DESCRICAO"></sk-dsfield-md>
                                <!--  -->

                                <!-- Colunas adicionais -->
                                    <sk-dsfield-md name = "ADICIONAL"></sk-dsfield-md>
                                <!--  -->
                            </sk-dataset>
                        <!--  -->

                        <!-- Componente responsavel pela materializacao do dataset virtual dos registros -->
                            <sk-datagrid
                                sk-dataset              = "central.dataset"
                                sk-on-datagrid-loaded   = "central.aoCarregarDatagrid (datagrid)"
                            ></sk-datagrid>
                        <!--  -->

                    </sk-face-two>
                <!--  -->

                </sk-double-face-panel>
            <!--  -->

        </sk-application>
    <!--  -->

</body>
</html>