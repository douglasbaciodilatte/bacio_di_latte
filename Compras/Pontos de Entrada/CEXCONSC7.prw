#Include "Totvs.ch"

/*/{Protheus.doc} CEXCONSC7
@description 	Ponto de entrada na conversao do fator do produto
@obs			Nao utilizar a conversao, devolver o a quantidade atual
@author 		Fabrica de Software Fabritech
@since 			03/2018
@version		1.0
@return			Nil
@type 			Function
/*/
User Function CEXCONSC7()
	Local nPosDoc	:= Ascan( aHeader, { |x| Alltrim( x[ 2 ] ) == "D1_QUANT" 	} )
	Local nPosXML	:= Ascan( aHeader, { |x| Alltrim( x[ 2 ] ) == "XIT_QTENFE"	} )
	Local nPosUM	:= Ascan( aHeader, { |x| Alltrim( x[ 2 ] ) == "XIT_UMNFE"	} )
	Local aParamIXB	:= PARAMIXB
	Local nRetQtd	:= 0

	Local cTpCon	:= ""
	Local lConve	:= .F.
	Local nX        := 0
	
	//Verifica Produto x Fornecedor (Faz a conversao ou nao)
	If Alltrim( SA5->A5_XCONVER ) == "2"
		
		//Caso faca a conversao, verifica a Regra (SA5)
		For nX := 1 To 4
        	
			//Guarda os campos da SA5
			cUmSA5  := &( "SA5->A5_XUM"    + Alltrim( Str( nX ) ) )
    		cTipSA5 := &( "SA5->A5_XTIPCV" + Alltrim( Str( nX ) ) )
        	nFatSA5 := &( "SA5->A5_XCONV"  + Alltrim( Str( nX ) ) )

			//Pega o tipo de 1 a 4 ou o padrao
			If !Empty( cTipSA5 )
				cTpCon	:= cTipSA5
			Else
				cTpCon	:= SA5->A5_XTIPCOV
			EndIf

			If !Empty( cUmSA5 ) .And. Alltrim( Upper( aCols[ N ][ nPosUM ] ) ) == Alltrim( Upper( cUmSA5 ) )
				nRetQtd	:= ( aCols[ N ][ nPosXML ] * IIF( cTpCon == "D", nFatSA5, IIF( nFatSA5 <> 0, 1 / nFatSA5, 1 ) ) )
				lConve	:= .T.
			EndIf

		Next nX

		//Caso nao tenha feito a conversao, faz no padrao
		If !lConve
			nRetQtd	:= ( aCols[ N ][ nPosXML ] * IIF( SB1->B1_TIPCONV == "D", SB1->B1_CONV, IIF( SB1->B1_CONV <> 0, 1 / SB1->B1_CONV, 1 ) ) )
		EndIf

	Else
		nRetQtd	:= ( aCols[ N ][ nPosXML ] * IIF( SB1->B1_TIPCONV == "D", SB1->B1_CONV, IIF( SB1->B1_CONV <> 0, 1 / SB1->B1_CONV, 1 ) ) )
	EndIf
	
Return nRetQtd
