#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"  
#include "Totvs.ch"

/*
���������������������������������������������������
���������������������������������������������������
���������������������������������������������������
���Programa  �RVFINR01  �Autor  �Rodolfo Vacari      � Data �  22/07/19   ����
����������������������������������������������������������������͹��
���Desc.     �Relatorios - Tabela do Contas a Pagar                           ���
���          �                                                                ���
����������������������������������������������������������������͹��
���Uso       � Milano                                                         ���
������������������������������������������������ͼ��
���������������������������������������������������
���������������������������������������������������
*/



user function RVFINR01()

local oReport
local cPerg  := "RVFINR01  "  //pergunta
local cAlias := getNextAlias()

U_RVPergSE2(cPerg)
Pergunte(cPerg,.F.)

oReport := reportDef(cAlias, cPerg)

oReport:printDialog()

return

//+-----------------------------------------------------------------------------------------------+
//! Fun?o para cria?o da estrutura do relat?io.                                                !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportDef(cAlias,cPerg)

local cTitle  := "Relatorio Contas a Pagar"
local cHelp   := "Permite gerar relatorio da tabela Contas a Pagar."
Local aOrdem  := {"ContasaPagar", ""}

local oReport
local oSection1
local oSection2
local oBreak1

oReport	:= TReport():New('RVFINR01',cTitle,cPerg,{|oReport|ReportPrint(oReport,cAlias)},cHelp)
oReport:SetPortrait()

//Primeira se?o
oSection1 := TRSection():New(oReport,"ContasaPagar",{"SE2"},aOrdem)    

TRCell():New(oSection1,"E2_FILIAL"   , "SE2", "FILIAL")
TRCell():New(oSection1,"E2_PREFIXO"   , "SE2", "PREFIXO")
TRCell():New(oSection1,"E2_NUM"   , "SE2", "TITULO")
TRCell():New(oSection1,"E2_PARCELA"   , "SE2", "PARCELA")
TRCell():New(oSection1,"E2_TIPO"   , "SE2", "TIPO")
TRCell():New(oSection1,"E2_NATUREZ"   , "SE2", "NATUREZA")
TRCell():New(oSection1,"E2_FORNECE"   , "SE2", "FORNECEDOR")
TRCell():New(oSection1,"E2_LOJA"   , "SE2", "LOJA")
TRCell():New(oSection1,"E2_NOMFOR"   , "SE2", "NOME_FORNECEDOR")
TRCell():New(oSection1,"E2_EMISSAO"   , "SE2", "EMISSAO")
TRCell():New(oSection1,"E2_VENCTO"   , "SE2", "VENCIMENTO")
TRCell():New(oSection1,"E2_VENCREA"   , "SE2", "VENC_REAL")
TRCell():New(oSection1,"E2_VALOR"   , "SE2", "VALOR")
TRCell():New(oSection1,"E2_ISS"   , "SE2", "ISS")
TRCell():New(oSection1,"E2_IRRF"   , "SE2", "IRRF")
TRCell():New(oSection1,"E2_BAIXA"   , "SE2", "BAIXA")
TRCell():New(oSection1,"E2_EMIS1"   , "SE2", "EMIS_CONT")
TRCell():New(oSection1,"E2_HIST"   , "SE2", "HISTORICO")
TRCell():New(oSection1,"E2_MOVIMEN"   , "SE2", "MOVIMENTO")
TRCell():New(oSection1,"E2_SALDO"   , "SE2", "SALDO")
TRCell():New(oSection1,"E2_OK"   , "SE2", "OK")
TRCell():New(oSection1,"E2_DESCONT"   , "SE2", "DESCONTO")
TRCell():New(oSection1,"E2_MULTA"   , "SE2", "MULTA")
TRCell():New(oSection1,"E2_JUROS"   , "SE2", "JUROS")
TRCell():New(oSection1,"E2_VALLIQ"   , "SE2", "LIQUIDO")
TRCell():New(oSection1,"E2_VENCORI"   , "SE2", "VENCORI")
TRCell():New(oSection1,"E2_VALJUR"   , "SE2", "VALJUROS")
TRCell():New(oSection1,"E2_PORCJUR"   , "SE2", "PORCJUROS")
TRCell():New(oSection1,"E2_MOEDA"   , "SE2", "MOEDA")
TRCell():New(oSection1,"E2_RATEIO"   , "SE2", "RATEIO")
TRCell():New(oSection1,"E2_VLCRUZ"   , "SE2", "VLCRUZ")
TRCell():New(oSection1,"E2_ACRESC"   , "SE2", "ACRESC")
TRCell():New(oSection1,"E2_PARCIR"   , "SE2", "PARCIR")
TRCell():New(oSection1,"E2_PARCISS"   , "SE2", "PARCISS")
TRCell():New(oSection1,"E2_INSS"   , "SE2", "INSS")
TRCell():New(oSection1,"E2_PARCINS"   , "SE2", "PARCINS")
TRCell():New(oSection1,"E2_TXMOEDA"   , "SE2", "TXMOEDA")
TRCell():New(oSection1,"E2_DECRESC"   , "SE2", "DECRESC")
TRCell():New(oSection1,"E2_MULTNAT"   , "SE2", "MULTNAT")
TRCell():New(oSection1,"E2_NUMTIT"   , "SE2", "NUMTIT")
TRCell():New(oSection1,"E2_DIRF"   , "SE2", "DIRF")
TRCell():New(oSection1,"E2_CODRET"   , "SE2", "CODRET")
TRCell():New(oSection1,"E2_PARCCSS"   , "SE2", "PARCCSS")
TRCell():New(oSection1,"E2_RETENC"   , "SE2", "RETENC")
TRCell():New(oSection1,"E2_FILORIG"   , "SE2", "FILORIG")
TRCell():New(oSection1,"E2_COFINS"   , "SE2", "COFINS")
TRCell():New(oSection1,"E2_PIS"   , "SE2", "PIS")
TRCell():New(oSection1,"E2_CSLL"   , "SE2", "CSLL")
TRCell():New(oSection1,"E2_PARCCOF"   , "SE2", "PARCCOF")
TRCell():New(oSection1,"E2_PARCPIS"   , "SE2", "PARCPIS")
TRCell():New(oSection1,"E2_PARCSLL"   , "SE2", "PARCSLL")
TRCell():New(oSection1,"E2_VRETPIS"   , "SE2", "VRETPIS")
TRCell():New(oSection1,"E2_VRETCOF"   , "SE2", "VRETCOF")
TRCell():New(oSection1,"E2_VRETCSL"   , "SE2", "VRETCSL")
TRCell():New(oSection1,"E2_PRETPIS"   , "SE2", "PRETPIS")
TRCell():New(oSection1,"E2_PRETCOF"   , "SE2", "PRETCOF")
TRCell():New(oSection1,"E2_PRETCSL"   , "SE2", "PRETCSL")
TRCell():New(oSection1,"E2_BASEPIS"   , "SE2", "BASEPIS")
TRCell():New(oSection1,"E2_BASECSL"   , "SE2", "BASECSL")
TRCell():New(oSection1,"E2_VRETISS"   , "SE2", "VRETISS")
TRCell():New(oSection1,"E2_VENCISS"   , "SE2", "VENCISS")
TRCell():New(oSection1,"E2_VBASISS"   , "SE2", "VBASISS")
TRCell():New(oSection1,"E2_MDRTISS"   , "SE2", "MDRTISS")
TRCell():New(oSection1,"E2_TRETISS"   , "SE2", "TRETISS")
TRCell():New(oSection1,"E2_VRETIRF"   , "SE2", "VRETIRF")
TRCell():New(oSection1,"E2_INSSRET"   , "SE2", "INSSRET")
TRCell():New(oSection1,"E2_CODISS"   , "SE2", "CODISS")
TRCell():New(oSection1,"E2_BASEISS"   , "SE2", "BASEISS")
TRCell():New(oSection1,"E2_CCUSTO"   , "SE2", "CCUSTO")
TRCell():New(oSection1,"E2_VRETINS"   , "SE2", "VRETINS")
TRCell():New(oSection1,"E2_BASEIRF"   , "SE2", "BASEIRF")
TRCell():New(oSection1,"E2_BASECOF"   , "SE2", "BASECOF")
TRCell():New(oSection1,"E2_RETINS"   , "SE2", "RETINS")
TRCell():New(oSection1,"E2_BASEINS"   , "SE2", "BASEINS")
TRCell():New(oSection1,"E2_CODINS"   , "SE2", "CODINS")
TRCell():New(oSection1,"E2_PRISS"   , "SE2", "PRISS")
 
//TRCell():New(oSection1,"A1_EST", "SA1", "Estado")   

//Segunda se?o
//oSection2:= TRSection():New(oSection1,"ITENS",{"NNT","SB1","NNR"})
        
//oSection2:SetLeftMargin(2)

//TRCell():New(oSection2,"NNT_PROD", "NNT", "Produto")   
//TRCell():New(oSection2,"C6_VALOR", "SC6", "Total")              
//TRCell():New( oSection2, "EMISSAO" , "QRY","Emiss�o",,11)
                                                                              
//oBreak1 := TRBreak():New(oSection2,{|| (cAlias)->(E2_NUM) },"Total:",.F.)                   
//TRFunction():New(oSection2:Cell("NNT_PROD" ), "TOT1", "COUNT", oBreak1,,,"Qtd de Itens:", .F., .F.)
//TRFunction():New(oSection2:Cell("NNT_QTSEG" ),"TOT2", "SUM", oBreak1,,,"Qtd de Volumes:", .F., .F.)
//TRFunction():New(oSection2:Cell("NNT_QTSEG" ), "TOT2", "SUM", oBreak1,,,, .F., .F.)          
//TRFunction():New(oSection1:Cell("NNT_PROD"),NIL,"COUNT",oBreak1,,,,.F.,.F.)         
//TRFunction():New(oSection1:Cell("NNT_QTSEG"),NIL,"SUM",oBreak1,,,,.F.,.F.)       


//Aqui, farei uma quebra  por se��o
oSection1:SetPageBreak(.T.)
                               */
Return(oReport)

//+-----------------------------------------------------------------------------------------------+
//! Rotina para montagem dos dados do relat?io.                                  !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportPrint(oReport,cAlias)

local oSection1b := oReport:Section(1)
local oSection2b := oReport:Section(1):Section(1)  
local cOrdem    
local cStatus 

cOrdem := "E2_FILORIG, E2_NUM"  

oSection1b:BeginQuery()

BeginSQL Alias cAlias
	
SELECT 
E2_FILIAL,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_TIPO,E2_NATUREZ,E2_FORNECE,E2_LOJA,E2_NOMFOR,E2_EMISSAO,
E2_VENCTO,E2_VENCREA,E2_VALOR,E2_ISS,E2_IRRF,E2_BAIXA,E2_EMIS1,E2_HIST,E2_MOVIMEN,E2_SALDO,E2_OK,E2_DESCONT,
E2_MULTA,E2_JUROS,E2_VALLIQ,E2_VENCORI,E2_VALJUR,E2_PORCJUR,E2_MOEDA,E2_RATEIO,E2_VLCRUZ,E2_ACRESC,E2_PARCIR,
E2_PARCISS,E2_INSS,E2_PARCINS,E2_TXMOEDA,E2_DECRESC,E2_MULTNAT,E2_NUMTIT,E2_DIRF,E2_CODRET,E2_PARCCSS,E2_RETENC,
E2_FILORIG,E2_COFINS,E2_PIS,E2_CSLL,E2_PARCCOF,E2_PARCPIS,E2_PARCSLL,E2_VRETPIS,E2_VRETCOF,E2_VRETCSL,E2_PRETPIS,
E2_PRETCOF,E2_PRETCSL,E2_BASEPIS,E2_BASECSL,E2_VRETISS,E2_VENCISS,E2_VBASISS,E2_MDRTISS,E2_TRETISS,E2_VRETIRF,E2_INSSRET,
E2_CODISS,E2_BASEISS,E2_CCUSTO,E2_VRETINS,E2_BASEIRF,E2_BASECOF,E2_RETINS,E2_BASEINS,E2_CODINS,E2_PRISS 
FROM %Table:SE2% SE2 
WHERE E2_EMIS1 BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04% 
AND D_E_L_E_T_ = '' 
AND E2_FILORIG BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02%
AND E2_TIPO = 'NF'
ORDER BY %Exp:cOrdem%
	
EndSQL 

oSection1b:EndQuery()    
oSection2b:SetParentQuery()

oReport:SetMeter((cAlias)->(RecCount()))  

oSection2b:SetParentFilter({|cParam| (cAlias)->E2_NUM == cParam}, {|| (cAlias)->E2_NUM})

oSection1b:Print()	   

return

//+-----------------------------------------------------------------------------------------------+
//! Fun?o para cria?o das perguntas (se n? existirem)                                          !
//+-----------------------------------------------------------------------------------------------+
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �fChkPerg  �Autor � Rodolfo Vacari         � Data �  01/03/2017 ����
�������������������������������������������������������������������������͹��
���Desc.     � Perguntas do Sistema.                                      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus 12                                                ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
����������������������������������������������������������������������������� */

User Function RVPergSE2(cPerg)

Local aRegs := {}
Local Fi    := FWSizeFilial()

aAdd(aRegs,{cPerg,'01','Filial De               ?','','','mv_ch1','C',Fi,0,0,'G','           ','mv_par01','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','XM0','','',''})
aAdd(aRegs,{cPerg,'02','Filial Ate              ?','','','mv_ch2','C',Fi,0,0,'G','NaoVazio   ','mv_par02','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','XM0','','',''})
aAdd(aRegs,{cPerg,'03','Data De                 ?','','','mv_ch3','D',08,0,0,'G','           ','mv_par03','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','','','',''})
aAdd(aRegs,{cPerg,'04','Data Ate                ?','','','mv_ch4','D',08,0,0,'G','NaoVazio   ','mv_par04','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','','','',''})
                                             
ValidPerg(aRegs,cPerg,.F.)

Return
