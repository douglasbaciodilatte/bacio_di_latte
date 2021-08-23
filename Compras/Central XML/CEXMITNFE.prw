#Include "Totvs.ch"

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CEXMITNFE � Autor � Fabritech            � Data �  15/09/20 ���
�������������������������������������������������������������������������͹��
���Descricao � Ponto de entrada apos carregar itens para lancar NF-e      ���
���          � (Central XML)                                              ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � BACIO                                                      ���
�������������������������������������������������������������������������͹��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
				cMensagem := "Nota de retorno! Obrigatorio amarra��o da nota de origem em todos os itens!"
				nX := Len( aRetorno ) + 1
			EndIf

		EndIf
	
	Next nX
	
	RestArea( aAreaAt )
	
Return { aRetorno, lRetorno, cMensagem }
