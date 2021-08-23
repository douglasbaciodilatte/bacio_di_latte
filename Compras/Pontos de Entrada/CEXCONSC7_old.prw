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
	Local nPosDoc	:= Ascan( aHeader, { |x| Alltrim( x[2] ) == "D1_QUANT" 	} )
	Local nPosXML	:= Ascan( aHeader, { |x| Alltrim( x[2] ) == "XIT_QTENFE"} )
	Local aParamIXB	:= PARAMIXB
	Local nRetQtd	:= 0
	
	
	//Verifica Produto x Fornecedor (Faz a conversao ou nao)
	If Alltrim( SA5->A5_XCONVER ) == "2"
	   //	nRetQtd	:= aCols[ N ][ nPosDoc ]    
		nRetQtd	:= ( aCols[ N ][ nPosXML ] * IIF( SA5->A5_XTIPCOV == "D", SA5->A5_XCONV, IIF( SA5->A5_XCONV <> 0, 1 / SA5->A5_XCONV, 1 ) ) )
	Else
		nRetQtd	:= ( aCols[ N ][ nPosXML ] * IIF( SB1->B1_TIPCONV == "D", SB1->B1_CONV, IIF( SB1->B1_CONV <> 0, 1 / SB1->B1_CONV, 1 ) ) )
	EndIf
	
Return nRetQtd
