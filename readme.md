# SankhyaJS BI MasterBlaster Turbo Super HyperUltra MegaPower 3000

Finalmente...!

## Briefing

Este é um projeto que torna a biblioteca SankhyaJS e seus componentes em AngularJS disponíveis para uso em um componente de BI.
Por quê? ...porque sim!



## Instalação

1. Primeiro, clone o repositório e entre no diretório:

```bash
git clone https://github.com/wansleynery/BI-SankhyaJS.git
cd BI-SankhyaJS
```

2. Depois, MANUALMENTE, crie um ZIP com o conteúdo do diretório raiz (ou use um comando caso esteja no Linux):

```bash
zip -r dashboard.zip .
```

3. Abra a tela Construtor de Componentes do BI e importe o arquivo ZIP criado dentro de um novo componente do tipo "HTML5" e dê o nome do componente de **TELA_HTML5** (importante para remoção do frame nas controladoras - linha 24).

4. Defina como a página a ser aberta algum dos dois arquivos JSP disponíveis na pasta _entidade_ ou _standalone_.

5. Pronto! Agora é só clicar em pré-visualizar a tela.


## Desenvolvimento (Pontos de atenção)

1. A estrutura do arquivo JSP deverá ser mantida (como está) na sua maior parte. Após exaustivas tentativas, testes, implementações e correções, a modelagem atual (incluindo a ordem das tags e conteudos) está funcional. **Qualquer alteração poderá causar problemas de renderização e processamento.**

---

2. As importações de arquivos acessórios para o funcionamento da tela deverá seguir as localizações específicas nos arquivos JSP:

    - CSS: Linha 34
    - JS (Bibliotecas): Linha 181
    - JS (Controladoras): Linha 230
    - JS (Services): Linha 235

---

3. Ambas as controladoras fazem uso de um recurso da biblioteca _JX_ chamado `removerFrame` que, basicamente, remove o frame de entorno do componente de BI. Isso pode ser bom para a estética da tela e ganho pequeno de espaço, por outro lado, perderemos a barra de parâmetros lateral e o botão de recarga e maximização do componente. Tenha isso em mente se deseja mesmo esse comportamento e, se necessário, remova as linhas entre 14 a 26 na respectiva controladora que estiver utilizando.

---

3. **Nem todas as preferências podem funcionar** se buscadas pela chamada `MGEParameters.as...`, tendo em vista que é necessário a injeção das dependências ainda na construção da página e isso inclui as preferências que o _ResourceID_ da tela pode acessar em tempo de execução. Como uma forma de contornar isso, utilize um método de consulta ao banco de forma assíncrona (para o exemplo, utilizo a biblioteca importada do JX):
```javascript
//...

    JX.consultar (`
        SELECT COALESCE (MAX (INTEIRO), -1) AS INTEIRO
          FROM TSIPAR
         WHERE CHAVE = 'CODUSUVISITA'
           AND CODUSU = 0
    `).then (parametros => {

        // Sempre retornara um array, sendo vazio caso nao encontre
        // Exemplo: [{ INTEIRO: 0 }, { INTEIRO: 1 }, ...]

        for (let parametro of parametros) {
            console.log (parametro.INTEIRO);
        }

    });

//...
```

---

4. Essa versão de tela é desenvolvida para controladora sendo uma classe, mas as telas do Sankhya são desenvolvidas em modelagem funcional ou seja, a controladora é uma função com escopo disassociado, por isso é usado a abordagem seguinte nos códigos Sankhya (dessa forma, o contexto da função passa a ser controlado sem efeitos colaterais, uma forma segura de se trabalhar com o AngularJS):

```javascript
//...
    var self = this;
    self.variavel = 'valor';
//...
```
Mas as controladoras desse projeto,  estão implementadas como classe, para controlar melhor o escopo e gerenciar o contexto da forma mais estrita possível, sem contar que mostro uma forma mais clara e conscisa de trabalhar com classes dentro do AngularJS:

```javascript
//...
    this.variavel = 'valor';
//...
```
_Sinta-se a vontade para alterar isso!_

---

5. No exemplo da pasta _entidade_, utilizamos um componente da biblioteca SankhyaJS chamado `sk-dynaform`, que _"monta"_ a grade e o formulário de forma automatica, mas ele só poderá ser utilizado com uma entidade existente (ou um _dataset_ existente, mas ainda não testado), ou seja, precisa indicar uma tabela ou view real do Sankhya para a construção do componente, seguindo a respectiva ordem e hierarquia:

```html
<sk-application> <!-- Componente que cria um contexto de aplicação para os componentes -->

    <sk-dynaform></sk-dynaform> <!-- Componente que pre-monta um formulário a partir de uma entidade -->

</sk-application>
```

Agora, na pasta _standalone_, terá um exemplo de como montar uma grade ou formulário de forma dinâmica, a partir de dados temporários ou que não estejam em lugar algum da plataforma, com os componentes principais sendo o `sk-dataset` e `sk-datagrid`, seguindo a respectiva ordem e hierarquia (Observação: pode ser utilizado essa modelagem para montar telas com entidades existentes, bastando remover o parâmetro `sk-standalone` do componente `sk-dataset`):

```html
<sk-application> <!-- Componente que cria um contexto de aplicação para os componentes -->

    <sk-dataset sk-standalone></sk-dataset> <!-- Componente que cria um estrutura de dados em memória para ser utilizada como fonte de dados -->

    <sk-double-face-panel> <!-- Componente GRADE-FORMULÁRIO que permite a troca de visão entre dois lados, como um cartão -->

        <sk-face-one> <!-- O lado A do componente GRADE-FORMULÁRIO, geralmente para o formulário -->

            <sk-form></sk-form> <!-- Componente que pré-monta um formulário a partir dos dados do dataset -->

            <!-- ... OU ... -->

            <sk-simple-form></sk-simple-form> <!-- Componente que pré-monta um formulário a partir dos dados do dataset -->

        </sk-face-one>

        <sk-face-two> <!-- O lado B do componente GRADE-FORMULÁRIO -->
            <sk-datagrid> <!-- Componente de grade, que consome a fonte de dados do dataset -->
            </sk-datagrid>
        </sk-face-two>

    </sk-double-face-panel>

</sk-application>
```



## Licença

Toda, pode passar!

Brincadeiras a parte, o projeto é licenciado sob a licença MIT. Um dos pontos principais de atenção é que, mesmo sendo um projeto de código aberto, não deverá ser inputado qualquer responsabilidade ao autor original por danos causados pelo uso do código ou mesmo a necessidade de manutenção do mesmo.
