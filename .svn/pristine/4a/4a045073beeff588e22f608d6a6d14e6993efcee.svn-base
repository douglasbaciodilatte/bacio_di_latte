#INCLUDE 'PROTHEUS.CH'

/*/
{Protheus.doc} BDESTA02
Description

	Rotina tem como objetivo fechamento do financeiro Parametro MV_DATAFIN

@param xParam Parameter Description
@return Nil
@author  - Rodolfo Vacari
@since 09/12/2019
/*/

User Function BDFINA01()

	aPergs 	:= {}
	aRet	:= {}

	aAdd( aPergs ,{1,"Fechamento"  ,Ctod(Space(8)),"","","","",50,.F.}) // Tipo data
	If ParamBox(aPergs ,"Parametros ",aRet)
			
			SX6->(dbSelectArea("SX6"))
			If SX6->(dbSeek(xFilial("SX6") + "MV_DATAFIN"))
				RecLock("SX6", .F.)
					SX6->X6_CONTEUD := DTOC(aRet[1])
					SX6->X6_CONTSPA	:= DTOC(aRet[1])
					SX6->X6_CONTENG	:= DTOC(aRet[1])
				MsUnLock()
			EndIf
	EndIf
	
	MsgInfo("Alterção concluída com sucesso!")

Return