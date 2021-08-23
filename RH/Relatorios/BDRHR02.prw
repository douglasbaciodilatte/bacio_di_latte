#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRCOMR01   บAutor  ณ Douglas Silva      บ Data ณ 29/10/2019  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressใo de cadastro de funcionแrios em TReport.          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Bacio Di Latte - RVacari                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function BDRHR02()

	Local cQuery := ""

	cQuery := " SELECT  " + CRLF
	cQuery += " 	SRZ.RZ_FILIAL,  " + CRLF
	cQuery += " 	SRZ.RZ_CC, " + CRLF 
	cQuery += " 	CTT_DESC01, " + CRLF
	cQuery += " 	SRZ.RZ_PD, " + CRLF 	
	cQuery += " 	SRV.RV_DESC, " + CRLF 	
	cQuery += " 	SRZ.RZ_VAL, " + CRLF 
	cQuery += " 	CASE " + CRLF	
	cQuery += " 		WHEN SRV.RV_TIPOCOD = '1' THEN 'PROVENTO' " + CRLF
	cQuery += " 		WHEN SRV.RV_TIPOCOD = '2' THEN 'DESCONTO' " + CRLF
	cQuery += " 		WHEN SRV.RV_TIPOCOD = '3' THEN 'BASE PROVENTO' " + CRLF
	cQuery += " 		WHEN SRV.RV_TIPOCOD = '4' THEN 'BASE DESCONTO' " + CRLF
	cQuery += " 	END 'TIPO_VERBA' " + CRLF
	cQuery += " FROM " + RetSqlName("SRZ") + " SRZ " + CRLF
	cQuery += " JOIN " + RetSqlName("SRV") + " SRV ON SRV.RV_FILIAL = '' AND SRV.RV_COD = SRZ.RZ_PD AND SRV.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " JOIN " + RetSqlName("CTT") + " CTT ON CTT.CTT_FILIAL = '' AND CTT.CTT_CUSTO = SRZ.RZ_CC AND CTT.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " WHERE " + CRLF 
	cQuery += " 	SRZ.RZ_FILIAL != '' " + CRLF
	cQuery += " 	AND RZ_MAT = 'zzzzzz' " + CRLF 
	cQuery += " 	AND RZ_CC != 'zzzzzzzzz' " + CRLF
	cQuery += " 	AND SRZ.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " GROUP BY SRZ.RZ_FILIAL, CTT_DESC01, SRZ.RZ_PD, SRV.RV_DESC, SRZ.RZ_CC, SRZ.RZ_VAL, SRV.RV_TIPOCOD " + CRLF

	cQuery := ChangeQuery(cQuery)

	//Chamada fun็ใo para gerar em Excel
	U_QRYCSV(cQuery,"Resumo Folha Pagto x C. Custos")

Return Nil