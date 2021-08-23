#INCLUDE "protheus.ch"

/*/{Protheus.doc} User Function SITEF005
    (long_description)
    @type  Function
    @author Douglas Rodrigues da Silva
    @since 22/06/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)

    /*/

User Function SITEF005(param_name)

    Private cCadastro := "Cadastro ADM x Cod Rede e Bandeira"

    Private aRotina := { {"Pesquisar","AxPesqui",0,1} ,;
                        {"Visualizar","AxVisual",0,2} ,;
                        {"Incluir","AxInclui",0,3} ,;
                        {"Alterar","AxAltera",0,4} ,;
                        {"Excluir","AxDeleta",0,5} }

    Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock

    Private cString := "ZZ2"

    dbSelectArea("ZZ2")
    dbSetOrder(1)

    dbSelectArea(cString)
    mBrowse( 6,1,22,75,cString)

Return
