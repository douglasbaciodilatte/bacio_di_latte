#include "PROTHEUS.CH"
#include "RWMAKE.CH"


User Function M310ITENS() 
  
Local aArea    	:= GetArea()
Local cProg 	:= PARAMIXB[1]
Local aItens 	:= PARAMIXB[2]
Local _cNumPed 	:= SC6->C6_NUM
Local _cNumFil	:= SC6->C6_FILIAL                 

	
	//Altera impostos pr? nota de entrada
	If Alltrim(cProg) $ "MATA140"
		
		If xFilial("SD1") $ '0031|0072|0136'

			For nX := 1 To Len(aItens)
				
					
				
			Next nX				

		EndIf

	EndIf

	//Altera informa??es de Lote Origem da Nota Fiscal de Saida
	If Alltrim(cProg) $ "MATA103"
	
		//Douglas Silva 19/11/2020: Inclus?o de busca Lote filial de Origem		
		For nX := 1 To Len(aItens)
				
			//Busca dados dos itens pedido de venda
			
			SC6->(dbSelectArea("SC6"))
			SC6->(dbSetOrder(2)) //C6_FILIAL+C6_PRODUTO+C6_NUM+C6_ITEM
			If SC6->(dbSeek( _cNumFil + aItens[nX][2][2] + _cNumPed + STRZERO(nX,2)  ))

				//Ajutes do Lotes de Produtos
				If aItens[nX][11][1] == "D1_LOTECTL"
					aItens[nX][11][2]	:= SC6->C6_LOTECTL
					aItens[nX][12][2]	:= SC6->C6_DTVALID
				EndIf	
				
				//Adciona Classifica??o Aliquota de IPI
				SD2->(dbSelectArea("SD2"))
				SD2->(DbSetOrder(3)) //D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM, R_E_C_N_O_, D_E_L_E_T_
				If SD2->(dbSeek( SC6->C6_FILIAL +  SC6->C6_NOTA + SC6->C6_SERIE + SC6->C6_CLI + SC6->C6_LOJA + SC6->C6_PRODUTO + SC6->C6_ITEM ))
				
					//Adiciona Aliquota de IPI
					If SD2->D2_IPI != 0
						aadd(aItens[nX],{"D1_IPI" 		,SD2->D2_IPI ,NIL})
						aadd(aItens[nX],{"D1_BASEIPI" 	,SD2->D2_BASEIPI,NIL})
					EndIf	
					
					//Adiciona ICMS - ST
					If SD2->D2_BRICMS != 0
						aadd(aItens[nX],{"D1_ALIQSOL"	,SD2->D2_ALIQSOL ,NIL})			
						aadd(aItens[nX],{"D1_BRICMS" 	,SD2->D2_BRICMS ,NIL})													
					EndIf								
					
				EndIf
				
			EndIf

			Next nX								
		
	EndIf


RestArea(aArea)

Return(aItens)
