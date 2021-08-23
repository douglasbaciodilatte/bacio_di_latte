#INCLUDE "totvs.ch"

/*/{Protheus.doc} User Function CADBLQIN
    (long_description)
    @type  Tela de Cadastro
    @author Douglas Rodrigues da Silva
    @since 02/04/2020
    @version 1.0
    @param 
    @return Logica verdadeira
    @example
    (examples)
    @see (links_or_references)
/*/

User Function CADBLQIN()
 
Private cCadastro := "Cadastro de Bloqueio Item Inventario - Gestor Loja"
Private aRotina := {    {"Pesquisar","AxPesqui"     ,0,1} ,;
                        {"Visualizar","AxVisual"    ,0,2} ,;
                        {"Incluir","AxInclui"       ,0,3} ,;
                        {"Alterar","AxAltera"       ,0,4} ,;
                        {"Excluir","AxDeleta"       ,0,5} }

Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock

Private cString := "ZZ2"

dbSelectArea("ZZ2")
dbSetOrder(1)

dbSelectArea(cString)
mBrowse( 6,1,22,75,cString)

Return
