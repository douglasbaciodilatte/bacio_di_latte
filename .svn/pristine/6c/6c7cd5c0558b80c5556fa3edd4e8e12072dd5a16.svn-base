#INCLUDE "Topconn.ch"        
#INCLUDE "PROTHEUS.CH"
#include "rwmake.ch"
#include "TbiConn.ch"      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRELBDPRC  บAutor  ณMicrosiga           บ Data ณ  03/26/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/



User Function RELBDPRC()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDeclaracao de variaveis                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Private oReport  := Nil
Private oSecCab	 := Nil    
Private cPerg 	 := "RELBDPRC"                        

lMenu := .f.
If Select("SX2") <> 0
lMenu := .t.
Endif

If !lMenu
PREPARE ENVIRONMENT EMPRESA '01' FILIAL '0001' MODULO 'EST' TABLES 'SD3','CTT'
Endif // */






//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefinicoes/preparacao para impressao      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
ReportDef()
oReport:PrintDialog() 

 


If !lMenu
RESET ENVIRONMENT 
Endif

Return Nil




/*
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Defini็ใo da estrutura do relat๓rio.                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ReportDef()

oReport := TReport():New("RELBDPRC","Producao e consumo",cPerg,{|oReport| PrintReport(oReport)},"Impressใo da produ็ใo e consumo dos 7 ultimos dias.")
oReport:SetLandscape(.T.)

oSecCab := TRSection():New( oReport , "Inventarios Digitados", {"QRYPRC"} )
TRCell():New( oSecCab, "CTT_CUSTO"             , "QRYPRC","Cod Loja")
TRCell():New( oSecCab, "CTT_DESC01"            , "QRYPRC","Loja")
TRCell():New( oSecCab, "D3_TM"                 , "QRYPRC","Tp Apontamento")       
TRCell():New(oSecCab,"EMISSAO"                 ,  "QRYPRC" , "Data" , "" , 10) 
TRCell():New( oSecCab, "QUANT"                 , "QRYPRC","Quantidade")

//DBCloseArea()

Return Nil



Static Function PrintReport(oReport)

Local cQuery     := ""
Local nBdias    := SuperGetMv('MV_RELBDP',,'7')


//Pergunte(cPerg,.F.)

cQuery += "SELECT CTT_CUSTO,CTT_DESC01,D3_TM =  "
cQuery += " CASE  "
cQuery += "      WHEN D3_TM = '100' THEN 'Produ็ใo' "
cQuery += "		 WHEN D3_TM = '502' THEN 'Consumo' "
cQuery += "		 ELSE D3_TM "
cQuery += "      END, "
cQuery += "SUBSTRING(D3_EMISSAO,7,2) + '/' + SUBSTRING(D3_EMISSAO ,5,2) + '/' + SUBSTRING(D3_EMISSAO ,1,4)  "
cQuery += "  EMISSAO, "
cQuery += "  sum(D3_QUANT) QUANT "
cQuery += "FROM " + RetSqlName("CTT") + " CTT "
cQuery += "LEFT JOIN " + RetSqlName("SD3") + " D3 ON D3_LOCAL = CTT_CUSTO AND D3.D_E_L_E_T_='' AND D3_TM IN ('100','502')  "
cQuery += "AND D3_EMISSAO BETWEEN replace(CONVERT (date, DATEADD (D, - "+nBdias+", GETDATE () )),'-','')  AND replace(CONVERT (date, GETDATE()),'-','')  "
cQuery += "WHERE CTT.D_E_L_E_T_=''  "
cQuery += "AND CTT_CLASSE = '2' "
cQuery += "AND CTT_DESC01 LIKE 'LJ%' "
cQuery += "AND CTT_BLOQ<>'1' "
cQuery += "GROUP BY CTT_CUSTO,CTT_DESC01,D3_TM,SUBSTRING(D3_EMISSAO,7,2) + '/' + SUBSTRING(D3_EMISSAO ,5,2) + '/' + SUBSTRING(D3_EMISSAO ,1,4) "
cQuery += "ORDER BY CTT_CUSTO,CTT_DESC01,SUBSTRING(D3_EMISSAO,7,2) + '/' + SUBSTRING(D3_EMISSAO ,5,2) + '/' + SUBSTRING(D3_EMISSAO ,1,4),D3_TM desc "




If Select("QRYPRC") > 0
	Dbselectarea("QRYPRC")
	QRYPRC->(DbClosearea())
EndIf

TcQuery cQuery New Alias "QRYPRC"

oSecCab:BeginQuery()
oSecCab:EndQuery({{"QRYPRC"},cQuery})
oSecCab:Print()

Return Nil
