#Include "TOTVS.ch"

/*/
{Protheus.doc} MTA010MNU
	@Description: Novas op��es no menu de Cadastro de Produtos
	@author: Felipe Mayer
	@since: 20/05/2021
    @see: https://centraldeatendimento.totvs.com/hc/pt-br/articles/360013462332-MP-ADVPL-Novas-op��es-no-menu-de-Cadastro-de-Produtos-MATA010-
/*/
User Function MTA010MNU()
    AAdd(aRotina, {"Gerar c�digo BN","U_BDCOMBN",0,2,0,Nil})
Return
