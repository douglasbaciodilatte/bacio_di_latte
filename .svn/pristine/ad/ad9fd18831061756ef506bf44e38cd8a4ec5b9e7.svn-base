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

    //Rotina em teste: Envio e-mail para o fornecedor apos a entrada da pre-nota. André Sarraipa.
 /*	u_ASCOM003(SF1->F1_DOC,;
				SF1->F1_SERIE,;
				SF1->F1_FORNECE,;
				SF1->F1_LOJA,;
				SF1->F1_TIPO)  */
				

Return

/*/{Protheus.doc} PriorProd
FUnção que verifica se algum produto da nota possui prioridade de classificação

@Author Wanderley Ramos NetoAGT_AGT
@Since 15/07/2017
@Return possui prioridade ou não
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
		
		// Verifica se possui um produto com prioridade de classificação
		lPriori := Posicione('SB1',1,cFilSB1+SD1->D1_COD, 'B1_XPRIPNT') == '1'
		
		SD1->(dbSkip())
	End

EndIf

AEval(aAReas, {|x| RestArea(x) })

Return lPriori