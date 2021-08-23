#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"  
#include "Totvs.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RELSOL01  �Autor  �Andre Sarraipa      � Data �  09/18/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �Relatorios das solicita��es de Transferencias               ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Milano                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/



user function RELSOL01()

local oReport
local cPerg  := 'RELSOL01'
local cAlias := getNextAlias()

criaSx1(cPerg)
Pergunte(cPerg, .F.)

oReport := reportDef(cAlias, cPerg)

oReport:printDialog()

return

//+-----------------------------------------------------------------------------------------------+
//! Fun?o para cria?o da estrutura do relat?io.                                                !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportDef(cAlias,cPerg)

local cTitle  := "Relatorio Solic Transferencia"
local cHelp   := "Permite gerar relatorio das solicitacoes de transferencias."
Local aOrdem  := {"Solicita��o", ""}
//Local aOrdem  := "Solicitacao"

local oReport
local oSection1
local oSection2
local oBreak1

oReport	:= TReport():New('RELSOL01',cTitle,cPerg,{|oReport|ReportPrint(oReport,cAlias)},cHelp)
oReport:SetPortrait()

//Primeira se?o
oSection1 := TRSection():New(oReport,"Solicitacoes",{"NNS"},aOrdem)    

TRCell():New(oSection1,"NNS_COD"   , "NNS", "Solicitacao: ")
TRCell():New(oSection1,"NNS_DATA"  , "NNS", "Emissao") 
TRCell():New(oSection1,"NNS_XNOMSO", "NNS", "Solicitante")   
TRCell():New(oSection1,"NNS_STATUS", "NNS", "Status") 
  
//TRCell():New(oSection1,"A1_EST", "SA1", "Estado")   

//Segunda se?o
oSection2:= TRSection():New(oSection1,"ITENS",{"NNT","SB1","NNR"})
        
oSection2:SetLeftMargin(2)

//TRCell():New(oSection2,"NNT_PROD", "NNT", "Produto")   
TRCell():New(oSection2,"NNT_PROD" , "NNT","Cod do Produto",,18)
TRCell():New(oSection2,"B1_DESC", "SB1", "Descricao")
TRCell():New(oSection2,"B1_UM", "SB1", "Unid")
TRCell():New(oSection2,"NNT_QUANT", "NNT", "Quantidade 1UM")
TRCell():New(oSection2,"B1_SEGUM", "SB1", "2 Unid")
TRCell():New(oSection2,"NNT_QTSEG", "NNT", "Quantidade 2UM")
TRCell():New(oSection2,"B2_QATU", "SB2", "Saldo 1 Unid")
TRCell():New(oSection2,"NNR_DESCRI", "NNR", "Local Destino")
TRCell():New(oSection2,"NNT_XQTORI", "NNT", "Qtd Original")
TRCell():New(oSection2,"B2_QTSEGUM", "SB2", "Saldo 2 Unid")
TRCell():New(oSection2,"NNT_LOTECT", "NNT", "Lote")
TRCell():New(oSection2,"NNT_OBS", "NNT", "Observacao")
TRCell():New(oSection2,"B1_PESO", "SB1", "Pes.Liq.")
TRCell():New(oSection2,"B1_PESBRU", "SB1", "Pes.Bru.")

//TRCell():New(oSection2,"C6_VALOR", "SC6", "Total")              
//TRCell():New( oSection2, "EMISSAO" , "QRY","Emiss�o",,11)
                                                                              

//Totalizador por cliente
oBreak1 := TRBreak():New(oSection2,{|| (cAlias)->(NNS_COD) },"Total:",.F.)                   
//TRFunction():New(oSection2:Cell("NNT_PROD" ), "TOT1", "COUNT", oBreak1,,,"Qtd de Itens:", .F., .F.)
//TRFunction():New(oSection2:Cell("NNT_QTSEG" ),"TOT2", "SUM", oBreak1,,,"Qtd de Volumes:", .F., .F.)
//TRFunction():New(oSection2:Cell("NNT_QTSEG" ), "TOT2", "SUM", oBreak1,,,, .F., .F.)          
TRFunction():New(oSection2:Cell("NNT_PROD"),NIL,"COUNT",oBreak1,,,,.F.,.F.)         
TRFunction():New(oSection2:Cell("NNT_QTSEG"),NIL,"SUM",oBreak1,,,,.F.,.F.)       


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

/*if oReport:Section(1):GetOrder() == 1
	cOrdem := "NNS_COD" 
else
	cOrdem := "NNT_FILDES"
endif*/

cOrdem := "NNS_COD"  


//1=Aprovado;2=Finalizado;3=Em Aprovacao;4=Rejeitado                                                                              

if  MV_PAR07  == 2

	cStatus := "1"

ELSEIF MV_PAR07  == 3

	cStatus := "2"	
		  
ELSE       

	cStatus := "1','2','3','4"     
	
ENDIF
		  
oSection1b:BeginQuery()

BeginSQL Alias cAlias
	

SELECT	
NNS_COD,NNS_DATA,NNT_PROD,B1_DESC,NNT_UM,NNT_QUANT,NNT_QTSEG,
NNT_FILDES,NNS_XNOMSO,
SUBSTRING(NNR_DESCRI,1,50) AS 'NNR_DESCRI',
NNT_XQTORI, B2_QATU,B2_QTSEGUM,NNT_OBS,NNS_STATUS, NNT_XQTORI * B1_PESO AS B1_PESO, NNT_XQTORI * B1_PESBRU AS B1_PESBRU, 
NNT_LOTECT, B1_SEGUM, B1_UM
FROM %Table:NNS% NNS  
INNER JOIN %Table:NNT% NNT ON NNS_FILIAL = NNT_FILIAL  AND NNS_COD= NNT_COD 
INNER JOIN %Table:SB1% SB1 ON B1_COD = NNT_PROD 
LEFT  JOIN %Table:SB2% SB2 ON NNT_PROD = B2_COD AND NNT_LOCAL = B2_LOCAL AND NNT_FILIAL = B2_FILIAL AND SB2.D_E_L_E_T_='' 
LEFT  JOIN %Table:NNR% NNR ON NNR_CODIGO = NNT_LOCLD AND NNR_FILIAL = NNT_FILDES AND NNR.D_E_L_E_T_='' 
WHERE  
NNS.D_E_L_E_T_='' 
AND NNT.D_E_L_E_T_='' 
AND SB1.D_E_L_E_T_=''
AND NNT_FILDES BETWEEN %Exp:MV_PAR01% AND %Exp:MV_PAR02% 
AND NNS_COD BETWEEN %Exp:MV_PAR03% AND %Exp:MV_PAR04%
AND NNS_DATA BETWEEN %Exp:MV_PAR05% AND %Exp:MV_PAR06%
AND NNS_STATUS IN (%Exp:cStatus%)
ORDER BY %Exp:cOrdem% 

	
EndSQL 

oSection1b:EndQuery()    
oSection2b:SetParentQuery()

oReport:SetMeter((cAlias)->(RecCount()))  

oSection2b:SetParentFilter({|cParam| (cAlias)->NNS_COD == cParam}, {|| (cAlias)->NNS_COD})

oSection1b:Print()	   

return

//+-----------------------------------------------------------------------------------------------+
//! Fun?o para cria?o das perguntas (se n? existirem)                                          !
//+-----------------------------------------------------------------------------------------------+


static function criaSX1(cPerg)          

putSx1(cPerg, '01', 'Filial destino de?' , '', '', 'mv_ch1', 'C', TAMSX3("NNT_FILDES")[1], 0, 0, 'G', '', 'XM0', '', '', 'mv_par01')
putSx1(cPerg, '02', 'Filial destino at?' , '', '', 'mv_ch2', 'C', TAMSX3("NNT_FILDES")[1], 0, 0, 'G', '', 'XM0', '', '', 'mv_par02')
putSx1(cPerg, '03', 'Sol. Transf de?'    , '', '', 'mv_ch3', 'C', TAMSX3("NNS_COD")[1]   , 0, 0, 'G', '', ''   , '', '', 'mv_par03')
putSx1(cPerg, '04', 'Sol. Transf at?'    , '', '', 'mv_ch4', 'C', TAMSX3("NNS_COD")[1]   , 0, 0, 'G', '', ''   , '', '', 'mv_par04')
putSx1(cPerg, '05', 'Data de?'           , '', '', 'mv_ch5', 'D', 8                      , 0, 0, 'G', '', ''   , '', '', 'mv_par05')
putSx1(cPerg, '06', 'Data at?'           , '', '', 'mv_ch6', 'D', 8                      , 0, 0, 'G', '', ''   , '', '', 'mv_par06')
putSx1(cPerg, '07', 'Status?'            , '', '','mv_ch7', 'C', 1                      , 0, 0, 'C', '', ''   , '', '1', 'mv_par07','Todas','Todas','Todas','','Em Aberto','Em Aberto','Em Aberto','Encerradas','Encerradas','Encerradas')


return   
