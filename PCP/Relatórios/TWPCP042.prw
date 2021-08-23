#Include "TWPCP042.CH"
#Include "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณTWPCP042  บAutor  ณRenan Paiva         บ Data ณ  19/11/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Relatorio onde ้ usado TW                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function TWPCP042()

Local oReport                                       
Private cPerg := "TWPC42"
cPerg 		:= PadR(cPerg,10) //if(cversao<>"P10",cPerg, PadR(cPerg,10))
Private cAlias	:= GetNextAlias()  

If TRepInUse()     
	AdjSx1()         
	Pergunte(cPerg,.T.)                        	
	oReport:=ReportDef()
	oReport:PrintDialog()
Else
	MsgInfo(STR002,STR001)	
	Return
EndIf
      
Return
**************************************************************
//Monta a sessao do TReport definindo as celulas para impressao
**************************************************************
Static Function ReportDef()

Local oReport
Local oSection     
Local cArq		:= ""
Local aCampos	:= {{"COD","C",15,0},{"COMP","C",15,0},{"QUANT","N",TamSx3("G1_QUANT")[1],TamSx3("G1_QUANT")[2]},{"NIVEL","C",2,0}}                          

cArq := CriaTrab(aCampos,.T.)
dbUseArea(.T.,,cArq,cAlias)

oReport := TReport():New("TWPCP042",STR003,cPerg,{|oReport| PrintReport(oReport)},STR004)
oSection := TRSection():New(oReport,OemToAnsi(STR005),{cAlias})	

TRCell():New(oSection,"COD"  ,,STR005,"@",25)
TRCell():New(oSection,"COMP" ,,STR006,"@",25)
TRCell():New(oSection,"QUANT",,STR007,PesqPict("SG1","G1_QUANT"),25)

Return oReport

**************************************************************
//Rotina para impressao do relatorio
**************************************************************
Static Function PrintReport(oReport)

Local oSection 	:= oReport:Section(1) //Inicializa a primeira sessao do treport 

dbSelectArea("SG1")
dbSetOrder(1)
If !dbSeek(xfilial("SG1")+mv_par01)
	MsgStop(STR008,STR001)
EndIf
	
MsgMeter({|oMeter|oGetEstrut(mv_par01,mv_par02)},STR009,STR010)   

oSection:Cell("COD"  ):SetBlock({ || (cAlias)->COD   })
oSection:Cell("COMP" ):SetBlock({ || (cAlias)->COMP  })
oSection:Cell("QUANT"):SetBlock({ || (cAlias)->QUANT })

oSection:Print()

Return
//====================================================================\\
// || ROTINA PARA GERAR ESTRUTURA COM QUANTIDADE DE COMPONENTES    || \\
//====================================================================\\
Static Function oGetEstrut(cCod,nQuant)

Local nQtdAnt	:= 0
Local lAdd		:= .F.  
Local nNivel	:= 1    
Local nRecno	:= 0
    
dbSelectArea("SG1")
dbSetOrder(1)
If !dbSeek(xFilial("SG1")+cCod)
	Return
EndIf

While SG1->G1_COD == cCod   
	If G1_INI <= dDataBase .And. G1_FIM >= dDataBase    
		RecLock(cAlias,.T.)
		(cAlias)->COD 	:= SG1->G1_COD
		(cAlias)->COMP  := SG1->G1_COMP
		(cAlias)->QUANT	:= nQuant*SG1->G1_QUANT  
		(cAlias)->NIVEL	:= SG1->G1_NIV
		MsUnLock()  	
	EndIf	        
	dbSelectArea("SG1")
	dbSkip()	
Enddo	

dbSelectArea(cAlias)
dbGoTop()	
While .T.

	While !Eof()                                        
		dbSelectArea("SG1")                       					
		If dbSeek(xFilial("SG1")+(cAlias)->COMP)
			nQtdAnt := (cAlias)->QUANT
			While Trim(SG1->G1_COD) == Trim((cAlias)->COMP)
				If SG1->G1_INI <= dDataBase .And. SG1->G1_FIM >= dDataBase
					nRecno := (cAlias)->(Recno())
					RecLock(cAlias,.T.)
					(cAlias)->COD 	:= SG1->G1_COD
					(cAlias)->COMP  := SG1->G1_COMP
					(cAlias)->QUANT	:= nQtdAnt*SG1->G1_QUANT
					(cAlias)->NIVEL	:= SG1->G1_NIV
					MsUnLock() 
					lAdd := .T.      
					(cAlias)->(dbGoTo(nRecno))
				EndIf	
				dbSelectArea("SG1")
				dbSkip()			
	        EndDo                                       
   	    EndIf                                        
   	    dbSelectArea(cAlias) 
   	    dbSkip()
    EndDo           
	    
    If lAdd
    	lAdd:=.F.
    Else	
    	Exit
    EndIf	
        
EndDo
Return


**************************************************************
//cria as perguntas do relatorio
**************************************************************

Static Function AdjSx1()

Local _aPerg  := {}
Local _ni

Aadd(_aPerg,{STR011,"mv_ch1","C",15,0,"G","","mv_par01","","","","SB1",""})
Aadd(_aPerg,{STR012,"mv_ch2","N",18,2,"G","","mv_par02","","","","",""})

dbSelectArea("SX1")
For _ni := 1 To Len(_aPerg)
	If !dbSeek(cPerg+StrZero(_ni,2))
		RecLock("SX1",.T.)
		SX1->X1_GRUPO    := cPerg
		SX1->X1_ORDEM    := StrZero(_ni,2)
		SX1->X1_PERGUNT  := _aPerg[_ni][1]
		SX1->X1_PERSPA   := _aPerg[_ni][1]
		SX1->X1_PERENG   := _aPerg[_ni][1]
		SX1->X1_VARIAVL  := _aPerg[_ni][2]
		SX1->X1_TIPO     := _aPerg[_ni][3]
		SX1->X1_TAMANHO  := _aPerg[_ni][4]
		SX1->X1_DECIMAL  := _aPerg[_ni][5]
		SX1->X1_GSC      := _aPerg[_ni][6]
		SX1->X1_VALID	 := _aPerg[_ni][7]
		SX1->X1_VAR01    := _aPerg[_ni][8]
		SX1->X1_DEF01    := _aPerg[_ni][9]
		SX1->X1_DEFSPA1  := _aPerg[_ni][9]
		SX1->X1_DEFENG1  := _aPerg[_ni][9]
		SX1->X1_DEF02    := _aPerg[_ni][10]
		SX1->X1_DEFSPA2  := _aPerg[_ni][10]
		SX1->X1_DEFENG2  := _aPerg[_ni][10]
		SX1->X1_DEF03    := _aPerg[_ni][11]
		SX1->X1_DEFSPA3  := _aPerg[_ni][11]
		SX1->X1_DEFENG3  := _aPerg[_ni][11]
		SX1->X1_F3       := _aPerg[_ni][12]
		SX1->X1_CNT01    := _aPerg[_ni][13]
		MsUnLock()
	EndIf
Next _ni

Return