#Include "Totvs.ch"

/*/{Protheus.doc} CEXATUSA5
@description 	Ponto de entrada antes de atualizar registro na SA5
@author 		Amedeo D. Paoli Filho
@version		1.0
@param			ExpC1, C, Codigo do Produto
@return			ExpL1, L, Logico (Atualiza ou nao atualiza)
@type 			Function
/*/
User Function CEXATUSA5()
	Local aProd		:= PARAMIXB
	Local lRetorno	:= .T.

	//Valida tipo de produto para apresentar tela de amarração
	SB1->(dbSelectArea("SB1"))
	SB1->(dbSetOrder(1))
	If SB1->(dbSeek( xFilial("SB1") + aProd[1] ))
		If SB1->B1_TIPO $ "MP|ME|EM|PA|SV|VE|"
			lRetorno := .F.
		EndIf
	EndIf
	
Return lRetorno