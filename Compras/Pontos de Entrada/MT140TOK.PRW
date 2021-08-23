#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE 'parmtype.ch'

/*/{Protheus.doc} MT140TOK
esponsável por validar todos os itens do pré-documento  
Finalidade..: Este ponto é executado após verificar se existem itens a serem gravados e tem como 
objetivo validar todos os itens do pré-documento
Eventos

@Author Douglas Rodrigues da Silva
@Since 24/10/2019
@Return Nil
/*/

User Function MT140TOK

Local lRetorno := PARAMIXB[1]  
Local lRet     :=.T.   //..CustomizaÃ§Ã£o do cliente
Local cTPRO    := SuperGetMv('MV_BDTIPRO',,'MC/SV')    
Local cMforn   := SuperGetMv('MV_BDLFOR',,'07XPHH/00QGMX')
Local cMret    := ""             
//Local cFornec  := CA100FOR
LOCAL nX       := 0


If cModulo == "EIC" .Or. AllTrim(FunName()) == "MATA310"
	Return(.T.)
EndIf  

For nX :=1 to Len(aCols)

	If !aCols[nX][Len(aHeader)+1] // Deletado
		If EMPTY(aCols[nX][gdfieldpos("D1_PEDIDO")])              
			dbSelectArea("SB1")
			dbSetOrder(1) 
			If MsSeek(XFilial("SB1") + aCols[nX][gdfieldpos("D1_COD")] )							
				If !(B1_TIPO $ cTPRO)
					//cMret += "O Produto: "+ B1_DESC + " Tipo: " + B1_TIPO + Chr(13)+Chr(10)     
					cMret += "O Produto: "+  PADR( B1_DESC, TAMSX3("B1_DESC")[1] ) + " Tipo: " + B1_TIPO + Chr(13)+Chr(10)
				EndIf
			EndIf	
		EndIf	
	EndIf
	
Next nX

	//Atendimento solicitação Elisagela Fiscal Bacio
	IF Alltrim(cEspecie) == "SPED" .AND. !IsInCallStack("U_CENTNFEXM") .AND. !(CA100FOR $ cMforn)
		MsgAlert("ATENÇÃO Tipo NF-e não permitido por Pré Nota, Efetuar lançamento via Central XML!","MT410TOK")
		lRet := .F.
	EndIf

	//Atendimento chamado 16479 - Bloqueio de alteração data base.
	If dDataBase != Date()
		dDataBase := Date()
	EndIf
	
	IF CA100FOR $ cMforn  
		Return(.T.)
	EndIf  
	
	IF !EMPTY(cMret)
		lRet := .F.
		MSGALERT("E necessário vincular o pedido de compra nos itens:!"+ Chr(13)+Chr(10) + Chr(13)+Chr(10)+ cMret + Chr(13)+Chr(10) + Chr(13)+Chr(10)+ ;
		 "Parametros da rotina: MV_BDTIPRO - MV_BDLFOR","Milano - MT140TOK") 
	ENDIF
	
	
	/****************************************************************************************************|
	|	Incluido 14/02/2020 Felipe Mayer - RVacari - não salvar sem preenchimento F1_ESPECIE	  	  	 |
	|****************************************************************************************************/

	If AllTrim(FunName()) == 'MATA140' 
		If Empty(Alltrim(cEspecie))
			lRet := .F.
			MsgAlert("Espécie do documento inválida!","Milano - MT140TOK")
		EndIf
	EndIf


Return lRet