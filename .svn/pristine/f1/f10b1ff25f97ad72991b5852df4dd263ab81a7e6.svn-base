#INCLUDE "PROTHEUS.CH"

User Function SD1140I()

//Busca Aliquota de ICMS-ST
If SF1->F1_FORNECE == "07XPHH"

	ICMSSTSaida(SF1->F1_DOC,;
					SF1->F1_SERIE,;
					SF1->F1_FORNECE,;
					SF1->F1_LOJA,;
					SF1->F1_TIPO)
EndIf


Return

/*/{Protheus.doc} PriorProd
FUnção que verifica se algum produto da nota possui prioridade de classificação

@Author Wanderley Ramos NetoAGT_AGT
@Since 15/07/2017
@Return possui prioridade ou não
/*/

Static Function ICMSSTSaida(cDoc,cSerie,cForn,cLoja,cTipo)

Local lRet				:= .T.
Local cFilSD1			:= xFilial('SD1')
Local aAreas			:= {SB1->(GetArea()),SD1->(GetArea()),GetArea()}

SD1->(DbSetOrder(1))
If SD1->( dbSeek( cFilSD1+cDoc+cSerie+cForn+cLoja ) )

	While SD1->(! Eof()) ;
			.And. SD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA) == cFilSD1+cDoc+cSerie+cForn+cLoja ;
		
			//Busca documento de Saída se houve ICMS ST
			SD2->(dbSelectArea("SD2"))
			SD2->(DbSetOrder(3)) //D2_FILIAL, D2_DOC, D2_SERIE, D2_CLIENTE, D2_LOJA, D2_COD, D2_ITEM, R_E_C_N_O_, D_E_L_E_T_
			If SD2->(dbSeek( "0031" +  cDoc + cSerie + cForn + xFilial("SF1") + SD1->D1_COD + SUBSTR(SD1->D1_ITEM,3,2) ))

				//Vefica os campos de ICMS-ST
                If SD1->D1_ICMSRET == 0 .And. SD2->D2_ICMSRET != 0
                    SD1->D1_ICMSRET := SD2->D2_ICMSRET
                    SD1->D1_BRICMS  := SD2->D2_BRICMS
                EndIf
                
                //Verifica aliquota de IPI
                If SD1->D1_IPI == 0 .And. SD2->D2_IPI != 0
                    SD1->D1_IPI := SD2->D2_IPI
                EndIf
				

			EndIf
		
		SD1->(dbSkip())
	End

EndIf

AEval(aAReas, {|x| RestArea(x) })

Return(lRet)
