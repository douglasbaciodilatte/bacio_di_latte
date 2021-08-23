#INCLUDE 'PROTHEUS.CH'

/*/
{Protheus.doc} BDESTA02
Description

	Rotina tem como objetivo ajustar fechamento inventário parâmetro MV_ULMES 

@param xParam Parameter Description
@return Nil
@author  - Douglas Silva
@since 04/10/2019
/*/

User Function BDESTA02()

	aPergs 	:= {}
	aRet	:= {}

	aAdd( aPergs ,{1,"Fechamento"  ,Ctod(Space(8)),"","","","",50,.F.}) // Tipo data
	If ParamBox(aPergs ,"Parametros ",aRet)
	
		SM0->(dbSelectArea("SM0"))
		SM0->(dbSetOrder(1))
		Do While SM0->(!EOF())
			
			SX6->(dbSelectArea("SX6"))
			If SX6->(dbSeek( Alltrim(SM0->M0_CODFIL) + "MV_ULMES  "))
				RecLock("SX6", .F.)
					SX6->X6_CONTEUD := DTOC(aRet[1])
					SX6->X6_CONTSPA	:= DTOC(aRet[1])
					SX6->X6_CONTENG	:= DTOC(aRet[1])
				MsUnLock()
			EndIf
			
			SM0->(dbSkip())
		Enddo
		
	EndIf
	
	MsgInfo("Alterçaão concluída com sucesso!")

Return