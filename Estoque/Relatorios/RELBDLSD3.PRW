#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRELBDSD3   บAutor  Andre Sarraipa       บ Data ณ  03/26/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/



User Function RELBDSD3()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDeclaracao de variaveis                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Private oReport  := Nil
Private oSecCab	 := Nil    
Private cPerg 	 := "RELBDSD3"

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณDefinicoes/preparacao para impressao      ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
ReportDef()
oReport:PrintDialog()

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

oReport := TReport():New("RELBDSD3","Inventarios Efetivados",cPerg,{|oReport| PrintReport(oReport)},"Inventarios efetivados por lojas considerando os tres ultimos meses.")
oReport:SetLandscape(.T.)

oSecCab := TRSection():New( oReport , "Inventarios Efetivados", {"QRYTSD3"} )
TRCell():New( oSecCab, "CTT_CUSTO"             , "QRYTSD3","Cod Loja")
TRCell():New( oSecCab, "CTT_DESC01"           , "QRYTSD3","Loja")
TRCell():New( oSecCab, "ANO_MES"       , "QRYTSD3","Mes Ano")
TRCell():New( oSecCab, "QTD_EFETV"       , "QRYTSD3","Qtd Efetivada")
//TRCell():New( oSecCab, "NNS_XNOMSO"     , "QRYTSD3")

DBCloseArea()

Return Nil



Static Function PrintReport(oReport)

Local cQuery     := ""

//Pergunte(cPerg,.F.)



cQuery += "SELECT CTT_CUSTO,CTT_DESC01, "
cQuery += "SUBSTRING(D3_EMISSAO ,5,2) + '/' + SUBSTRING(D3_EMISSAO ,1,4) ANO_MES, "
cQuery += "COUNT(D3_LOCAL) QTD_EFETV "
cQuery += "FROM " + RetSqlName("CTT") +" CTT "
cQuery += "LEFT JOIN " + RetSqlName("SD3") +" D3 ON D3_LOCAL = CTT_CUSTO AND D3.D_E_L_E_T_='' AND D3_DOC='INVENT' "                   
cQuery += "AND D3_EMISSAO BETWEEN replace(CONVERT (date, DATEADD (m, -3, GETDATE () )),'-','')  AND "
cQuery += "replace(CONVERT (date, GETDATE()+10),'-','') "
cQuery += "WHERE CTT.D_E_L_E_T_='' "
cQuery += "AND CTT_CLASSE = '2' "
cQuery += "AND CTT_DESC01 LIKE 'LJ%' "
cQuery += "AND CTT_BLOQ<>'1' "
cQuery += "GROUP BY CTT_CUSTO,CTT_DESC01,SUBSTRING(D3_EMISSAO ,5,2) + '/' + SUBSTRING(D3_EMISSAO ,1,4) "
cQuery += "ORDER BY 1 ,3 "


If Select("QRYTSD3") > 0
	Dbselectarea("QRYTSD3")
	QRYTSD3->(DbClosearea())
EndIf

TcQuery cQuery New Alias "QRYTSD3"

oSecCab:BeginQuery()
oSecCab:EndQuery({{"QRYTSD3"},cQuery})
oSecCab:Print()

Return Nil
