#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

/*/{Protheus.doc} DBCTBR02
   Gerenciador de Processamento
   @author  Douglas Rodrigues da Silva
   @table   Tabelas
   @since   05/03/2020
/*/
User Function DBCTBR02()
  
  	Local aParamBox := {}
	
	Private aRet := {}
		
	aAdd(aParamBox,{1,"Ano/Mes"  , Space(6),"","","","",50,.T.})
		
	If ParamBox(aParamBox,"Extrator Dados...",@aRet)
			
		xProc9(aRet[1])
	
	EndIf

Return


Static Function xProc9(cData)
	
    cQuery := " SELECT * FROM ( " + CRLF
	cQuery += " SELECT " + CRLF 
	cQuery += " 	SUBSTRING(CT2_DATA,7,2) + '/' + SUBSTRING(CT2_DATA,5,2) + '/' + SUBSTRING(CT2_DATA,1,4) AS 'DATA_LANCAMENTO', " + CRLF
	cQuery += " 	CT2_LOTE + CT2_SBLOTE + CT2_DOC + CT2_LINHA AS 'DOCUMENTO', " + CRLF
	cQuery += " 	CT2_CREDIT AS 'CONTA_CREDITO', " + CRLF
	cQuery += " 	'' AS 'CONTA_DEBITO', " + CRLF
	cQuery += " 	IIF(CT2_CREDIT != '' AND (CT2_DC = '2' OR CT2_DC = '3'), CT2_VALOR,0) AS 'VALOR_CREDITO', " + CRLF
	cQuery += " 	0 AS 'VALOR_DEBITO', " + CRLF
	cQuery += " 	CT2_HIST AS 'HISTORICO', " + CRLF
	cQuery += " 	IIF(CT2_MANUAL = '1', 'SIM','NAO') AS 'LANCAMENTO_MANUAL', " + CRLF
	cQuery += " 	CT2_ORIGEM AS 'USUARIO_LANCAMENTO', " + CRLF
	cQuery += " 	R_E_C_N_O_ 'REGISTRO', " + CRLF
	cQuery += " 	SUBSTRING( " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 3, 1)+SUBSTRING(CT2_USERGI, 7, 1)+ " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 11,1)+SUBSTRING(CT2_USERGI, 15,1)+ " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 2, 1)+SUBSTRING(CT2_USERGI, 6, 1)+ " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 10,1)+SUBSTRING(CT2_USERGI, 14,1)+ " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 1, 1)+SUBSTRING(CT2_USERGI, 5, 1)+ " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 9, 1)+SUBSTRING(CT2_USERGI, 13,1)+ " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 17,1)+SUBSTRING(CT2_USERGI, 4, 1)+ " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 8, 1),3,6) AS USUARIO " + CRLF
	cQuery += " FROM "+RETSQLNAME("CT2")+" CT2 " + CRLF
	cQuery += " WHERE SUBSTRING(CT2_DATA,1,6) = '"+cData+"' " + CRLF
	cQuery += " AND D_E_L_E_T_ != '*' AND CT2_DC != '4' AND CT2_TPSALD != '9'  " + CRLF
	cQuery += " AND CT2_CREDIT != '' " + CRLF
	cQuery += " UNION ALL  " + CRLF
	cQuery += " SELECT  " + CRLF
	cQuery += " 	SUBSTRING(CT2_DATA,7,2) + '/' + SUBSTRING(CT2_DATA,5,2) + '/' + SUBSTRING(CT2_DATA,1,4) AS 'DATA_LANCAMENTO', " + CRLF
	cQuery += " 	CT2_LOTE + CT2_SBLOTE + CT2_DOC + CT2_LINHA AS 'DOCUMENTO', " + CRLF
	cQuery += " 	'' AS 'CONTA_CREDITO', " + CRLF
	cQuery += " 	CT2_DEBITO AS 'CONTA_DEBITO', " + CRLF
	cQuery += " 	0 AS 'VALOR_CREDITO', " + CRLF
	cQuery += " 	IIF(CT2_DEBITO != '' AND (CT2_DC = '1' OR CT2_DC = '3'), CT2_VALOR,0) AS 'VALOR_DEBITO', " + CRLF
	cQuery += " 		CT2_HIST AS 'HISTORICO', " + CRLF
	cQuery += " 	IIF(CT2_MANUAL = '1', 'SIM','NAO') AS 'LANCAMENTO_MANUAL', " + CRLF
	cQuery += " 	CT2_ORIGEM AS 'USUARIO_LANCAMENTO', " + CRLF
	cQuery += " 	R_E_C_N_O_ 'REGISTRO', " + CRLF
	cQuery += " 	SUBSTRING( " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 3, 1)+SUBSTRING(CT2_USERGI, 7, 1)+ " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 11,1)+SUBSTRING(CT2_USERGI, 15,1)+ " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 2, 1)+SUBSTRING(CT2_USERGI, 6, 1)+ " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 10,1)+SUBSTRING(CT2_USERGI, 14,1)+ " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 1, 1)+SUBSTRING(CT2_USERGI, 5, 1)+ " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 9, 1)+SUBSTRING(CT2_USERGI, 13,1)+ " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 17,1)+SUBSTRING(CT2_USERGI, 4, 1)+ " + CRLF
	cQuery += " 	SUBSTRING(CT2_USERGI, 8, 1),3,6) AS USUARIO " + CRLF
	cQuery += " FROM "+RETSQLNAME("CT2")+" CT2 " + CRLF
	cQuery += " WHERE SUBSTRING(CT2_DATA,1,6) = '"+cData+"' " + CRLF
	cQuery += " AND D_E_L_E_T_ != '*' AND CT2_DC != '4' AND CT2_TPSALD != '9' " + CRLF
	cQuery += " AND CT2_DEBITO != '' ) TEMP " + CRLF

	U_QRYCSV(cQuery,"LANÇAMENTOS CONTABEIS")

Return