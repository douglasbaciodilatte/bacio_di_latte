#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"  
#include "Totvs.ch"

User function RBTPCP001()

local oReport
local cPerg  := 'RBTPCP001 '
local cAlias := getNextAlias()

AdjSx1(cPerg)   
Pergunte(cPerg, .T.)

//Pergunte(cPerg, .F.)

oReport := reportDef(cAlias, cPerg)

oReport:printDialog()

return  
          
//+-----------------------------------------------------------------------------------------------+
//! Rotina para montagem dos dados do relat?io.                                  !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportPrint(oReport,cAlias)
                 
local oSecao1 := oReport:Section(1)

oSecao1:BeginQuery()

BeginSQL Alias cAlias
	
SELECT D4_COD, B1_DESC, D4_DATA,B1_UM, SUM(D4_QTDEORI) D4_QTDEORI, B1_TIPO
FROM %Table:SD4% SD4 INNER JOIN %Table:SB1% SB1 ON D4_COD = B1_COD
WHERE SD4.%notdel% AND SB1.%notdel% AND D4_DATA BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03% AND D4_FILIAL = '0031' 
AND SUBSTRING(D4_OP,1,6) IN (%Exp:MV_PAR01%) AND D4_OPORIG = ' ' AND B1_TIPO <> 'PA'
GROUP BY D4_COD, B1_DESC, D4_DATA, B1_UM, B1_TIPO
ORDER BY B1_DESC
	
EndSQL 

oSecao1:EndQuery()  

oReport:SetMeter((cAlias)->(RecCount()))  

oSecao1:Print()	   

return

//+-----------------------------------------------------------------------------------------------+
//! Fun��o para cria��o da estrutura do relat?io.                                                !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportDef(cAlias,cPerg)

local cTitle  := "Relatorio de Separacao OP :"+ALLTRIM(MV_PAR01)+" - "+DTOC(MV_PAR02)+"-"+DTOC(MV_PAR03)
local cHelp   := "Permite gerar relatorio de Separacao de Produtos para Atender as OPs."

local oReport
local oSection1

oReport	:= TReport():New('RBTPCP001',cTitle,cPerg,{|oReport|ReportPrint(oReport,cAlias)},cHelp)

//Primeira se��o
oSection1 := TRSection():New(oReport,"SEPARACAO",{"SD4"})    

TRCell():New(oSection1,"D4_COD", "SD4", "Codigo","",17)           
TRCell():New(oSection1,"B1_DESC", "SB1", "Descricao do Produto")   
TRCell():New(oSection1,"B1_UM", "SB1", "Unidade")   
TRCell():New(oSection1,"D4_QTDEORI", "SD4", "Quantidade")
TRCell():New(oSection1,"D4_DATA", "SD4", "Emissao")   
TRCell():New(oSection1,"B1_TIPO", "SB1", "Tipo")        


oBreak1 := TRBreak():New(oSection1,{|| (cAlias)->(D4_DATA) },"Total  :  Qtde.Produto                                                                       Quantidade",.F.)                       
TRFunction():New(oSection1:Cell("D4_COD"),NIL,"COUNT",oBreak1,,,,.F.,.F.)         
TRFunction():New(oSection1:Cell("D4_QTDEORI"),NIL,"SUM",oBreak1,,,,.F.,.F.) 


Return(oReport)

static function AdjSx1(_cPerg)

Local _aPerg  := {}
Local _ni

Aadd(_aPerg,{"OPs ?","mv_ch1","C",60,0,"G","","mv_par01","","","","SC2",""})
Aadd(_aPerg,{"Data De  ?","mv_ch2","D",8,0,"G","","mv_par02","","","","",""})
Aadd(_aPerg,{"Data At� ?","mv_ch3","D",8,0,"G","","mv_par03","","","","",""})    


dbSelectArea("SX1")
for _ni := 1 to len(_aPerg)
	if !dbSeek(_cPerg+StrZero(_ni,2))
		RecLock("SX1",.T.)
		SX1->X1_GRUPO    := _cPerg
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
	endif
next _ni

return

