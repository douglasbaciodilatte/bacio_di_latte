#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"  
#include "Totvs.ch"



user function RELBCPRO()

local oReport
local cPerg  := 'RELBCPRO'
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

oSecao1:BeginQuery()

BeginSQL Alias cAlias
	
SELECT D3_FILIAL,D3_TM,D3_COD,B1_DESC,D3_UM,D3_QUANT,D3_OP,D3_LOCAL,NNR_DESCRI,D3_DOC,
D3_EMISSAO,D3_CC,D3_ESTORNO 
from %Table:SD3% D3 
INNER JOIN %Table:SB1% B1 ON B1_COD=D3_COD
LEFT  JOIN %Table:NNR% NR ON NNR_CODIGO= D3_LOCAL AND NNR_FILIAL= D3_FILIAL AND NR.D_E_L_E_T_=''
WHERE D3.D_E_L_E_T_=''
AND B1.D_E_L_E_T_=''
AND D3_LOCAL = %Exp:MV_PAR01%
AND D3_COD     BETWEEN %Exp:MV_PAR02% AND %Exp:MV_PAR03%
AND D3_EMISSAO BETWEEN %Exp:MV_PAR04% AND %Exp:MV_PAR05%
AND D3_TM IN ('100')
ORDER BY D3_EMISSAO,B1_DESC    
	
EndSQL 

oSecao1:EndQuery()  

oReport:SetMeter((cAlias)->(RecCount()))  

oSecao1:Print()	   

return

//+-----------------------------------------------------------------------------------------------+
//! Função para criação da estrutura do relat?io.                                                !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportDef(cAlias,cPerg)

local cTitle  := "Relatorio de Producao"
local cHelp   := "Permite gerar relatorio de Producao."

local oReport
local oSection1

oReport	:= TReport():New('RELBCPRO',cTitle,cPerg,{|oReport|ReportPrint(oReport,cAlias)},cHelp)

//Primeira seção
oSection1 := TRSection():New(oReport,"Producao",{"SD3"})    

TRCell():New(oSection1,"D3_TM", "SD3", "TP Movimento")
TRCell():New(oSection1,"D3_COD", "SD3", "Codigo","",17)           
TRCell():New(oSection1,"B1_DESC", "SB1", "Descricao do Produto")   
TRCell():New(oSection1,"D3_UM", "SD3", "Unidade")   
TRCell():New(oSection1,"D3_QUANT", "SD3", "Quantidade")
TRCell():New(oSection1,"D3_EMISSAO", "SD3", "Emissao")   
TRCell():New(oSection1,"D3_OP", "SD3", "Ord Producao") 
TRCell():New(oSection1,"D3_LOCAL", "SD3", "Cod. Armazem")  
TRCell():New(oSection1,"NNR_DESCRI", "NNR", "Descr Armazem")           


oBreak1 := TRBreak():New(oSection1,{|| (cAlias)->(D3_EMISSAO) },"Total:",.F.)                       
TRFunction():New(oSection1:Cell("D3_COD"),NIL,"COUNT",oBreak1,,,,.F.,.F.)         
TRFunction():New(oSection1:Cell("D3_QUANT"),NIL,"SUM",oBreak1,,,,.F.,.F.) 


Return(oReport)

//+-----------------------------------------------------------------------------------------------+
//! Função para criação das perguntas (se n? existirem)                                          !
//+-----------------------------------------------------------------------------------------------+
static function criaSX1(cPerg)

putSx1(cPerg, '01', 'Codigo Armazem?' , '', '', 'mv_ch1', 'C',6                    , 0, 0, 'G', '', 'NNR', '', '', 'mv_par01')
putSx1(cPerg, '02', 'Produto Inicial' , '', '', 'mv_ch2', 'C',TAMSX3("D3_COD")[1]  , 0, 0, 'G', '', 'SB1', '', '', 'mv_par02')
putSx1(cPerg, '03', 'Produto Final'   , '', '', 'mv_ch3', 'C',TAMSX3("D3_COD")[1]  , 0, 0, 'G', '', 'SB1', '', '', 'mv_par03')
putSx1(cPerg, '04', 'Data de?'        , '', '', 'mv_ch5', 'D',8                    , 0, 0, 'G', '', ''   , '', '', 'mv_par04')
putSx1(cPerg, '05', 'Data at?'        , '', '', 'mv_ch6', 'D',8                    , 0, 0, 'G', '', ''   , '', '', 'mv_par05')

return    
