/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ SF1100I  ³ Autor ³ Jeremias Lameze Jr.   ³ Data ³ 10.02.17   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Validacao dos Itens da Nota Fiscal de Entrada                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ SF1100I			                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ BACIO                                                        ³±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function SF1100I()
//*
Local aAreaLoc	:= GetArea(),cPrefSE2:= &(GetMv("MV_2DUPREF")),cFilSE2 := xFilial("SE2")
Local aAreaSE2,cPrefSE1:= AllTrim(&(GetMv("MV_1DUPREF"))),cFilSE1 := xFilial("SE1")
Local cFrmPgto,aAreaSD1,cCusto:=" ",cItemCta:=" ",cClVl:=" ",cGrupo:=" ",cDescIt:=" ",cXObs:=" ",aAreaSC7
Local nDifTam 	:= TamSX3("F1_DOC")[1] - 6
Local nTamData := IIF(__SetCentury(),10,8)
Local aRet		:= {}               
local cBdlHist  :=""

aAreaSF1 := SF1->(GetArea())
//*
cPrefSE1 := cPrefSE1+SPACE(03-Len(cPrefSE1))
//cPrefSE2 := cPrefSE2+SPACE(03-Len(cPrefSE2))// Removid em 05abril2018 muitos titulos estão sendo gravos sem centro de custo, foi removido o altril deste variavel 
//*
//u_F1LANCTO()
//*
If !SF1->F1_TIPO $ "DB"
	If !Empty(SF1->F1_DUPL)
		dbSelectArea("SD1")
		aAreaSD1 := GetArea()
		dbSetOrder(1)
		MsSeek(SF1->F1_FILIAL+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA)
		If !Eof()
			cCusto  := SD1->D1_CC
		Endif     
		
		//Historic0 financeiro Bacio 
   		DbSelectArea("SA2")
   		SA2->(DbSetOrder(1)) 
   		If SA2->(dbSeek( xFilial("SA2")+SF1->F1_FORNECE+SF1->F1_LOJA))   
   			cBdlHist := alltrim(SA2->A2_XHIST)   		
   		ENDIF
		
		

		dbSelectArea("SE2")
		dbSetOrder(1)
		dbSelectArea("SE2")
		aAreaSE2 := GetArea()
		dbSeek(cFilSE2+cPrefSE2+SF1->F1_DOC)
		While !Eof() .And. SE2->E2_FILIAL+SE2->E2_PREFIXO+SE2->E2_NUM == cFilSE2+cPrefSE2+SF1->F1_DOC
			If SE2->E2_FORNECE+SE2->E2_LOJA == SF1->F1_FORNECE+SF1->F1_LOJA              
			
				RecLock("SE2",.F.)
				IF !Empty(cCusto)
					SE2->E2_CCUSTO  := cCusto
				Else
					SE2->E2_CCUSTO	:= " "
				EndIf   
				
				IF !Empty(cBdlHist)  
					SE2->E2_HIST := cBdlHist				
				ENDIF	   
				MsUnLock()
			Endif
			dbSkip()
		End
		RestArea(aAreaSE2)
	Endif
Endif                           

RecLock("SF1",.F.) 
SF1->F1_XDTCLAS := Date() 
SF1->(MsUnlock()) 

RestArea(aAreaSF1)

RestArea(aAreaLoc)
Return