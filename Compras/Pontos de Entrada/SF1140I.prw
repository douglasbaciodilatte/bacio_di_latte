#INCLUDE "PROTHEUS.CH"

User Function SF1140I()

If PriorProd(	SF1->F1_DOC,;
				SF1->F1_SERIE,;
				SF1->F1_FORNECE,;
				SF1->F1_LOJA,;
				SF1->F1_TIPO)

	u_ASCOM002(SF1->F1_DOC,;
				SF1->F1_SERIE,;
				SF1->F1_FORNECE,;
				SF1->F1_LOJA,;
				SF1->F1_TIPO)
	
EndIf           

	//Adicionado para tratar ICMS-ST Transferencia entre filiais ICMS-ST
	If SF1->F1_FORNECE == "07XPHH" .And. SF1->F1_LOJA == "0031"

		//Busca itens NF-e
		SD1->(DBSelectArea("SD1"))
		SD1->(dbSetOrder(1)) //D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM
		If SD1->(dbSeek( SF1->F1_FILIAL + SF1->F1_DOC + SF1->F1_SERIE + SF1->F1_FORNECE + SF1->F1_LOJA))
		
			Do While SD1->(!EOF() .And. SF1->F1_FILIAL+SF1->F1_DOC == SD1->D1_FILIAL + SD1->D1_DOC)
				
				//Tratamento para produtos com ICMS ST
				//2 D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
				

				SD1->(dbSkip())
			Enddo
		
		EndIf

	EndIf

    //Rotina em teste: Envio e-mail para o fornecedor apos a entrada da pre-nota. Andr? Sarraipa.
 /*	u_ASCOM003(SF1->F1_DOC,;
				SF1->F1_SERIE,;
				SF1->F1_FORNECE,;
				SF1->F1_LOJA,;
				SF1->F1_TIPO)  */
				

Return

/*/{Protheus.doc} PriorProd
FUn??o que verifica se algum produto da nota possui prioridade de classifica??o

@Author Wanderley Ramos NetoAGT_AGT
@Since 15/07/2017
@Return possui prioridade ou n?o
/*/
Static Function PriorProd(cDoc,cSerie,cForn,cLoja,cTipo)

Local lPriori			:= .F.
Local cFilSD1			:= xFilial('SD1')
Local cFilSB1			:= xFilial('SB1')
Local aAreas			:= {SB1->(GetArea()),SD1->(GetArea()),GetArea()}

SD1->(DbSetOrder(1))
If SD1->( dbSeek( cFilSD1+cDoc+cSerie+cForn+cLoja ) )

	While SD1->(! Eof()) ;
			.And. SD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA) == cFilSD1+cDoc+cSerie+cForn+cLoja ;
			.And. !lPriori
		
		// Verifica se possui um produto com prioridade de classifica??o
		lPriori := Posicione('SB1',1,cFilSB1+SD1->D1_COD, 'B1_XPRIPNT') == '1'
		
		SD1->(dbSkip())
	End

EndIf

AEval(aAReas, {|x| RestArea(x) })

Return lPriori

