#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"  
#include "Totvs.ch"



user function RELESTLJ()

local oReport
local cPerg  := 'RELESTLJ'
local cAlias := getNextAlias()



Pergunte(cPerg, .F.)

oReport := reportDef(cAlias, cPerg)

oReport:printDialog()

return  
          
//+-----------------------------------------------------------------------------------------------+
//! Rotina para montagem dos dados do relat?io.                                  !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportPrint(oReport,cAlias)
                 
local oSecao1 := oReport:Section(1)


//MONTRA PRODUTOS COM SALDO ZERO
if  MV_PAR04  == 1


oSecao1:BeginQuery()

BeginSQL Alias cAlias
	
SELECT B1_COD,B1_DESC,B1_UM,B2_QATU, B2_LOCAL,NNR_DESCRI,'' QTD_CONT
FROM %Table:SB2% B2 
INNER JOIN %Table:SB1% B1 ON B2_COD = B1_COD 
INNER JOIN %Table:NNR% NR ON NNR_CODIGO= B2_LOCAL AND NNR_FILIAL= B2_FILIAL 
WHERE B2.D_E_L_E_T_=''
AND B1.D_E_L_E_T_=''
AND NR.D_E_L_E_T_=''
AND B2_LOCAL= %Exp:MV_PAR01%
AND B2_COD BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03% 
ORDER BY B1_DESC
	
EndSQL 

oSecao1:EndQuery()  

oReport:SetMeter((cAlias)->(RecCount()))  

oSecao1:Print()	   	
		  
ELSE       

oSecao1:BeginQuery()

BeginSQL Alias cAlias
	
SELECT B1_COD,B1_DESC,B1_UM,B2_QATU, B2_LOCAL,NNR_DESCRI,'' QTD_CONT
FROM %Table:SB2% B2 
INNER JOIN %Table:SB1% B1 ON B2_COD = B1_COD 
INNER JOIN %Table:NNR% NR ON NNR_CODIGO= B2_LOCAL AND NNR_FILIAL= B2_FILIAL 
WHERE B2.D_E_L_E_T_=''
AND B1.D_E_L_E_T_=''
AND NR.D_E_L_E_T_=''
AND B2_LOCAL= %Exp:MV_PAR01%
AND B2_COD BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03% 
AND B2_QATU<>'0'
ORDER BY B1_DESC
	
EndSQL 

oSecao1:EndQuery()  

oReport:SetMeter((cAlias)->(RecCount()))  

oSecao1:Print()	    

ENDIF

return

//+-----------------------------------------------------------------------------------------------+
//! Função para criação da estrutura do relat?io.                                                !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportDef(cAlias,cPerg)

local cTitle  := "Relatorio de Posicao de Estoque"
local cHelp   := "Relatorio com o saldo atual de cada produto para no armazem indicado nos parametros."

local oReport
local oSection1

oReport	:= TReport():New('RELESTLJ',cTitle,cPerg,{|oReport|ReportPrint(oReport,cAlias)},cHelp)

//Primeira seção
oSection1 := TRSection():New(oReport,"Saldo",{"SB2"})    

TRCell():New(oSection1,"B1_COD", "SB1", "Produto")   
TRCell():New(oSection1,"B1_DESC", "SB1", "Descricao do Produto")   
TRCell():New(oSection1,"B1_UM", "SD3", "Unidade")   
TRCell():New(oSection1,"B2_QATU", "SB2", "Saldo Atual")
TRCell():New(oSection1,"B2_LOCAL", "SB2", "Armazem")  
//TRCell():New(oSection1,"NNR_DESCRI", "NNR", "Descr Armazem") 
TRCell():New(oSection1,"QTD_CONT", "SB2", "Qtd Contada")      
	
    


oBreak1 := TRBreak():New(oSection1,{|| (cAlias)->(B2_LOCAL) },"Total:",.F.)                       
TRFunction():New(oSection1:Cell("B1_COD"),NIL,"COUNT",oBreak1,,,,.F.,.F.)         
//TRFunction():New(oSection1:Cell("B2_QATU"),NIL,"SUM",oBreak1,,,,.F.,.F.) 


Return(oReport)

//+-----------------------------------------------------------------------------------------------+
//! Função para criação das perguntas (se n? existirem)                                          !
//+-----------------------------------------------------------------------------------------------+
static function criaSX1(cPerg)

putSx1(cPerg, '01', 'Codigo Armazem.'    , '', '', 'mv_ch1', 'C',6                    , 0, 0, 'G', '', 'NNR', '', '', 'mv_par01')
putSx1(cPerg, '02', 'Produto Inicial'    , '', '', 'mv_ch2', 'C',TAMSX3("D3_COD")[1]  , 0, 0, 'G', '', 'SB1', '', '', 'mv_par02')
putSx1(cPerg, '03', 'Produto Final'      , '', '', 'mv_ch3', 'C',TAMSX3("D3_COD")[1]  , 0, 0, 'G', '', 'SB1', '', '', 'mv_par03')
putSx1(cPerg, '04', 'Produtos sem Saldo?' , '', '','mv_ch5', 'C',1                   , 0, 0, 'G', '', ''   , '', '', 'mv_par04')


return    
