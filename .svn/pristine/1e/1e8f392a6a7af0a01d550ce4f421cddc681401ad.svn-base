
#Include 'PROTHEUS.CH'

/*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ºPrograma ³ MT140LOK     ºAutor³ RVACARI Felipe Mayer	      º Data ³ 28/02/2020	 º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ºDesc.    ³ P.E - Não deixar descer a linha se o Produto for <> de SV e == 'NFSE'	  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ºUso      ³ BACIO DI LATTE                       		                     		 º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/

User Function  MT140LOK()

Local lRet	:= .T.
Local cCod  := ''
Local nX	:= 0
Local nPosCodLote	:= aScan(aHeader, { |x| Alltrim(x[2]) == 'D1_LOTECTL' })
Local nPosCodNLot	:= aScan(aHeader, { |x| Alltrim(x[2]) == 'D1_NUMLOTE' })
Local nPosCodDtva	:= aScan(aHeader, { |x| Alltrim(x[2]) == 'D1_DTVALID' })
Local nPosCodIte	:= aScan(aHeader, { |x| Alltrim(x[2]) == 'D1_ITEM' })
Local nPosCodCod	:= aScan(aHeader, { |x| Alltrim(x[2]) == 'D1_COD' })

	For nX := 1 To Len(aCols)
		cCod := aCols[nX,02]
		If Subs(cCod,1,2) <> "SV" .And. Alltrim(cEspecie) == 'NFSE'
			MsgAlert("Espécie do documento inválida para o produto: "+cCod,"Milano - MT140LOK")
			lRet  := .F. 
		Endif
	Next nX	

	//Exclui Lote linha pré nota de entrada para lojas
	If xFilial("SD1") $ '0031|0072'

		SA1->(dbSelectArea("SA1"))
		SA1->(dbSetOrder(1)) //A1_FILIAL+A1_COD+A1_LOJA

		If SA1->(dbSeek( xFilial("SA1") + "07XPHH" ))

			For nX := 1 To Len(aCols)
				//Busca Lote nota de origem
				SD2->(DBSelectArea("SD2"))
				SD2->(dbSetOrder(3)) //D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
				If SD2->(dbSeek( SF1->F1_LOJA + SF1->F1_DOC + SF1->F1_SERIE + "07XPHH" + SF1->F1_FILIAL + aCols[nX,nPosCodCod] + STRZERO( Val(aCols[nX,nPosCodIte] ),2) ))

					aCols[nX,nPosCodLote]	:= SD2->D2_LOTECTL
					aCols[nX,nPosCodNLot]	:= SD2->D2_NUMLOTE
					aCols[nX,nPosCodDtva]	:= SD2->D2_DTVALID

				EndIf	
				
			Next nX	

		EndIf

	else

		For nX := 1 To Len(aCols)
			aCols[nX,nPosCodLote]	:= ""
		Next nX		

	Endif

Return lRet
