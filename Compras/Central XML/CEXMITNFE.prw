#Include "Totvs.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CEXMITNFE º Autor ³ Fabritech            º Data ³  15/09/20 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Ponto de entrada apos carregar itens para lancar NF-e      º±±
±±º          ³ (Central XML)                                              º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ BACIO                                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CEXMITNFE()

	Local aRetorno	:= PARAMIXB
	Local aAreaAt	:= GetArea()
	Local lRetorno	:= .T.
	Local cCfoRet	:= GetMv("MV_XCFORET")
	Local cMensagem := ""


	For nX := 1 To Len( aCols ) 
		
		//Pega Posicao da TES
		nPosTes	:= AScan( aHeader,{ |x| AllTrim(x[2]) == "D1_TES" } )
		nPosCfo	:= AScan( aHeader,{ |x| AllTrim(x[2]) == "XIT_CFNFE"	})
		nPosNfo	:= AScan( aHeader,{ |x| AllTrim(x[2]) == "D1_NFORI" } )
		
		If nPosCfo > 0 .And. Alltrim(aCols[nX][nPosCfo]) $ cCfoRet

			If Empty(aCols[nX][nPosNfo])
				lRetorno := .F.
				cMensagem := "Nota de retorno! Obrigatorio amarração da nota de origem em todos os itens!"
				nX := Len( aRetorno ) + 1
			EndIf

		EndIf
	
	Next nX
	
	RestArea( aAreaAt )
	
Return { aRetorno, lRetorno, cMensagem }
