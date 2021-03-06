/*//#########################################################################################
Modulo  : Estoque
Fonte   : blestr14
Objetivo: Exibir dados para relat?rio de invent?rio
*///#########################################################################################

#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

/*/{Protheus.doc} blestr14
   Gerenciador de Processamento
   @author  Douglas Rodrigues da Silva
   @table   Tabelas
   @since   28-01-2020
/*/
User Function BLESTR14()
  
  	Local aParamBox := {}
	Local cTipo		:= '1'  
	
	Private aRet := {}
		
	aAdd(aParamBox,{1,"Data Inventario"  ,Ctod(Space(8)),"","","","",50,.T.})
	aAdd(aParamBox,{2,"Dados",  	cTipo, {"1=Detalhado","2=Aglutinado-Soma"},     122, ".T.", .F.})
				
	If ParamBox(aParamBox,"Extrator Dados...",@aRet)
		
		If 	MV_PAR02 == "1"
			XEXCEL1()
		elseif MV_PAR02 == "2"
			XEXCEL2()
		EndIf	
	
	EndIf

Return


Static Function XEXCEL1()

	cQuery := " SELECT B7_LOCAL, CTT.CTT_DESC01, ISNULL(B7_DOC,'') B7_DOC, SB1.B1_COD, SB1.B1_DESC, SB1.B1_UM, SUM(B7_QUANT) B7_QUANT, ROUND(SUM(SB7.B7_QUANT*SB1.B1_CUSTD),2) AS B1_CUSTD " + CRLF 
 	cQuery += " FROM "+RETSQLNAME("SB7")+" SB7 " + CRLF 
 	cQuery += " JOIN "+RETSQLNAME("SB1")+" SB1 ON B1_FILIAL = '' AND B7_COD = B1_COD AND SB1.D_E_L_E_T_ != '*' " + CRLF 
 	cQuery += " JOIN "+RETSQLNAME("CTT")+" CTT ON CTT_FILIAL = '' AND CTT_CUSTO = SB7.B7_LOCAL AND CTT.D_E_L_E_T_ != '*' " + CRLF 
 	cQuery += " WHERE SUBSTRING(SB7.B7_DATA,1,6) = '"+SUBSTR(DTOS(MV_PAR01),1,6)+"' " + CRLF 
 	cQuery += " 	AND SB7.D_E_L_E_T_ = '' " + CRLF 
	cQuery += " 	AND SB7.B7_LOCAL = '700003' " + CRLF
	cQuery += " 	AND SB7.B7_QUANT > 0 " + CRLF
 	cQuery += " GROUP BY B7_LOCAL, B7_DOC, CTT.CTT_DESC01, SB1.B1_COD, SB1.B1_DESC,SB1.B1_UM " + CRLF
 	cQuery += " ORDER BY 1 " + CRLF 

	U_QRYCSV(cQuery,"SB7 - Resumo Inventario")

Return

Static Function XEXCEL2()
	
	cQuery := " SELECT B7_LOCAL, B7_DATA, CTT.CTT_DESC01, ISNULL(B7_DOC,'') B7_DOC, ROUND(SUM(SB7.B7_QUANT*SB1.B1_CUSTD),2) AS B1_CUSTD " + CRLF

	cQuery += " FROM "+RETSQLNAME("SB7")+" SB7 " + CRLF 
	cQuery += " JOIN "+RETSQLNAME("SB1")+" SB1 ON B1_FILIAL = '' AND B7_COD = B1_COD AND SB1.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " JOIN "+RETSQLNAME("CTT")+" CTT ON CTT_FILIAL = '' AND CTT_CUSTO = SB7.B7_LOCAL AND CTT.D_E_L_E_T_ != '*' " + CRLF

	cQuery += " WHERE " + CRLF 
	cQuery += " 	SUBSTRING(SB7.B7_DATA,1,6) = '"+SUBSTR(DTOS(MV_PAR01),1,6)+"' " + CRLF 
	cQuery += " 	AND SB7.D_E_L_E_T_ = '' " + CRLF 
	cQuery += " 	AND SB7.B7_QUANT > 0 " + CRLF 		
	cQuery += " GROUP BY B7_LOCAL, B7_DOC, B7_DATA, CTT_DESC01 " + CRLF 
 	cQuery += " ORDER BY 1 " + CRLF  

	U_QRYCSV(cQuery,"SB7 - Soma Resumo Inventario")	

Return
