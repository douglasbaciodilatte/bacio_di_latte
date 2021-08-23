#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"

/*/{Protheus.doc} BDCTB520
Description

	Processamento contas a receber 
	
	LP 520 - Baixas a Receber

@param xParam Parameter Description
@return Nil
@author  - Douglas Rodrigues da Silva
@since 07-11-2019
/*/

User Function BDCTB520()

	Local aPergs   := {}
    Private aRet	   := {}

    aAdd( aPergs ,{1,"Data"  ,Ctod(Space(8)),"","","","",50,.F.}) 
    
    If ParamBox(aPergs ,"Baixas Contas a Receber - LP 520",aRet)
        Processa( {|lEnd|  GERA_MOV(aRet[1])}, "BDCTB520","Gerando Movimentos Baixas...", .T. ) 
    Else
        Alert("Processo cancelado")
    EndIf
    
Return .T.

//+---------------------------------------------------------------------+
//| Processa moviemntos por LP                                          |
//+---------------------------------------------------------------------+

Static Function GERA_MOV(dData)

	Local cQuery1
	Local nLin := 1
		
	CT5->(dbSelectArea("CT5"))
	CT5->(dbSetOrder(1)) //CT5_FILIAL, CT5_LANPAD, CT5_SEQUEN, R_E_C_N_O_, D_E_L_E_T_
	
	//Verifica se existe LP 520
	If CT5->(dbSeek( xFilial ("CT5") + "520"))
	
		Do While CT5->(!EOF() .And. CT5->CT5_SEQUEN $ "001|002|003|004|005|006|007|008|009|")
			
			If CT5->CT5_STATUS == "2" .AND. CT5->CT5_SEQUEN $ "001|002|003|004|005|006|007|008|009|"
					
				cQuery1 := " SELECT TEMP.CONTA_DEBITO, TEMP.CONTA_CREDITO, TEMP.DATA, SUM(TEMP.SOMA) AS SOMA, CT1.CT1_DESC01 " + CRLF
				cQuery1 += " FROM ( " + CRLF
				cQuery1 += " 	SELECT " + CRLF   
				
				If CT5->CT5_SEQUEN == "001" //
					cQuery1 += " 	IIF(SUBSTRING(SE5.E5_NATUREZ,1,5) ='10103','111010003',SA6.A6_CONTA) AS CONTA_DEBITO, " + CRLF
					cQuery1 += " '' AS CONTA_CREDITO, " + CRLF
				ElseIf CT5->CT5_SEQUEN == "002"
					cQuery1 += " 	IIF(SE5.E5_ORIGEM <> 'FINA910','426010001','422020039') AS CONTA_DEBITO,
					cQuery1 += " '' AS CONTA_CREDITO, " + CRLF
				ElseIf CT5->CT5_SEQUEN == "003"
					cQuery1 += " '' AS CONTA_DEBITO,
					cQuery1 += " '331010002' AS CONTA_CREDITO, " + CRLF
				ElseIf CT5->CT5_SEQUEN == "004"
					cQuery1 += " '' AS CONTA_DEBITO,
					cQuery1 += " '331010004' AS CONTA_CREDITO, " + CRLF
				ElseIf CT5->CT5_SEQUEN == "005"
					cQuery1 += " '' AS CONTA_DEBITO,
					cQuery1 += " SED.ED_CONTA AS CONTA_CREDITO, " + CRLF
				ElseIf CT5->CT5_SEQUEN == "006"
					cQuery1 += " '425010009' AS CONTA_DEBITO,
					cQuery1 += " '214010001' AS CONTA_CREDITO, " + CRLF
				ElseIf CT5->CT5_SEQUEN == "007"
					cQuery1 += " '425010001' AS CONTA_DEBITO,
					cQuery1 += " '214010002' AS CONTA_CREDITO, " + CRLF				
				ElseIf CT5->CT5_SEQUEN == "008"
					cQuery1 += " '425010009' AS CONTA_DEBITO,
					cQuery1 += " '214010001' AS CONTA_CREDITO, " + CRLF
				ElseIf CT5->CT5_SEQUEN == "009"
					cQuery1 += " '425010001' AS CONTA_DEBITO,
					cQuery1 += " '214010002' AS CONTA_CREDITO, " + CRLF	
				EndIf
				
				cQuery1 += " SE5.E5_DATA 'DATA',	 " + CRLF
				cQuery1 += " ROUND(SUM( " + CRLF 
				
				If CT5->CT5_SEQUEN == "001"
					cQuery1 += " SE5.E5_VALOR " + CRLF
				ElseIf CT5->CT5_SEQUEN == "002"
					cQuery1 += " IIF(SE5.E5_RECONC != ' ' AND SE5.E5_MOTBX  = 'NOR',IIF(SE5.E5_VLDESCO = SE5.E5_VLDECRE,SE5.E5_VLDESCO,(SE5.E5_VLDESCO+SE5.E5_VLDECRE)),0) " + CRLF
				ElseIf CT5->CT5_SEQUEN == "003"
					cQuery1 += " SE5.E5_VLJUROS+SE5.E5_VLACRES " + CRLF
				ElseIf CT5->CT5_SEQUEN == "004"
					cQuery1 += " SE5.E5_VLMULTA " + CRLF
				ElseIf CT5->CT5_SEQUEN == "005"
					cQuery1 += " SE5.E5_VALOR+IIF(SE5.E5_VLDESCO = SE5.E5_VLDECRE, SE5.E5_VLDESCO,(SE5.E5_VLDESCO+SE5.E5_VLDECRE))-SE5.E5_VLJUROS-SE5.E5_VLMULTA-SE5.E5_VLACRES " + CRLF
				ElseIf CT5->CT5_SEQUEN == "006"
					cQuery1 += " (SE5.E5_VLJUROS + SE5.E5_VLMULTA + SE5.E5_VLACRES) * 0.0065 " + CRLF	
				ElseIf CT5->CT5_SEQUEN == "007"
					cQuery1 += " (SE5.E5_VLJUROS+SE5.E5_VLMULTA+SE5.E5_VLACRES)*0.04 " + CRLF	
				ElseIf CT5->CT5_SEQUEN == "008"
					cQuery1 += " (SE5.E5_VLJUROS+SE5.E5_VLMULTA+SE5.E5_VLACRES)*("+cValToChar(GETMV("MV_XPISREC"))+" /100) " + CRLF	
				ElseIf CT5->CT5_SEQUEN == "009"
					cQuery1 += " (SE5.E5_VLJUROS+SE5.E5_VLMULTA+SE5.E5_VLACRES)*("+cValtoChar(GETMV("MV_XPISREC"))+" /100) " + CRLF	
				EndIf
				
				cQuery1 += " ),2) AS SOMA" + CRLF
				cQuery1 += " FROM  " + CRLF
				cQuery1 += " "+RETSQLNAME("SE5")+" SE5 " + CRLF
				cQuery1 += " LEFT JOIN  " + CRLF
				cQuery1 += " "+RETSQLNAME("SED")+" SED ON SED.ED_FILIAL = '' AND SED.ED_CODIGO = SE5.E5_NATUREZ	AND SED.D_E_L_E_T_ != '*' " + CRLF
				cQuery1 += " LEFT JOIN "+RETSQLNAME("SA6")+" SA6 ON SA6.A6_FILIAL = ''AND SA6.A6_COD = SE5.E5_BANCO	AND SA6.A6_AGENCIA = SE5.E5_AGENCIA	AND SA6.A6_NUMCON = SE5.E5_CONTA AND SA6.D_E_L_E_T_ != '*' " + CRLF
				cQuery1 += " WHERE E5_FILIAL = '' AND SE5.D_E_L_E_T_ != '*'	AND " + CRLF
				
				If CT5->CT5_SEQUEN == "001"
					cQuery1 += " ((SE5.E5_RECONC != ' ' OR SE5.E5_BANCO = 'CXA' AND (SE5.E5_AGENCIA) != 'CXA   ' ) AND SE5.E5_MOTBX  = 'NOR' ) " + CRLF
				ElseIf CT5->CT5_SEQUEN == "002"
					cQuery1 += " (SE5.E5_RECONC != ' ' AND SE5.E5_MOTBX  = 'NOR') " + CRLF
				ElseIf CT5->CT5_SEQUEN == "003"
					cQuery1 += " (SE5.E5_RECONC != ' ' AND SE5.E5_MOTBX  = 'NOR') " + CRLF
				ElseIf CT5->CT5_SEQUEN == "004"
					cQuery1 += " (SE5.E5_RECONC != ' ' AND SE5.E5_MOTBX  = 'NOR') " + CRLF
				ElseIf CT5->CT5_SEQUEN == "005"
					cQuery1 += " (SE5.E5_RECONC != ' ' OR SE5.E5_BANCO ='CXA' AND SUBSTRING(SE5.E5_AGENCIA,1,3) != 'CXA') AND SE5.E5_MOTBX = 'NOR' " + CRLF
				ElseIf CT5->CT5_SEQUEN == "006"
					cQuery1 += " (SE5.E5_RECONC != ' ' AND SE5.E5_MOTBX  = 'NOR') " + CRLF	
				ElseIf CT5->CT5_SEQUEN == "007"
					cQuery1 += " (SE5.E5_RECONC != ' ' AND SE5.E5_MOTBX  = 'NOR') " + CRLF	
				ElseIf CT5->CT5_SEQUEN == "008"
					cQuery1 += " (SE5.E5_RECONC != ' ' AND SE5.E5_MOTBX  = 'NOR') " + CRLF
				ElseIf CT5->CT5_SEQUEN == "009"
					cQuery1 += " (SE5.E5_RECONC != ' ' AND SE5.E5_MOTBX  = 'NOR') " + CRLF															
				EndIf
				
				cQuery1 += " AND SE5.E5_DATA = '"+DTOS(dData)+"' AND SE5.E5_LA != 'S' " + CRLF
				
				cQuery1 += " AND SE5.E5_RECPAG = 'R' " + CRLF
				
				If CT5->CT5_SEQUEN== "001"
					cQuery1 += " GROUP BY SED.ED_CONTA, SE5.E5_DATA,	SE5.E5_NATUREZ,	SA6.A6_CONTA ) TEMP " + CRLF
				ElseIf CT5->CT5_SEQUEN == "002"
					cQuery1 += " GROUP BY SED.ED_CONTA, SE5.E5_DATA,	SE5.E5_NATUREZ,	SA6.A6_CONTA, SE5.E5_ORIGEM )TEMP  " + CRLF
				Else
					cQuery1 += " GROUP BY SED.ED_CONTA, SE5.E5_DATA,	SE5.E5_NATUREZ,	SA6.A6_CONTA ) TEMP " + CRLF
				EndIf

				cQuery1 += " LEFT JOIN "+RETSQLNAME("CT1")+" CT1 ON CT1.CT1_FILIAL = '' AND CT1.CT1_CONTA = TEMP.CONTA_DEBITO AND CT1.D_E_L_E_T_ != '*' " + CRLF 
				
				cQuery1 += " GROUP BY TEMP.CONTA_DEBITO, TEMP.CONTA_CREDITO, TEMP.DATA,CT1.CT1_DESC01 " + CRLF
				
				If ( Select("TMP") ) > 0
					DbSelectArea("TMP")
					TMP->(DbCloseArea())
				EndIf
			
				TCQUERY cQuery1 NEW ALIAS "TMP"
			
				DbSelectArea("TMP")
				DbGoTop()
				
				
					Do While TMP->(!EOF())
											
						//Gravação direta CT2
						Begin Transaction
							
							CT2->(dbSelectArea("CT2"))
							CT2->(dbSetOrder(1)) //CT2_FILIAL, CT2_DATA, CT2_LOTE, CT2_SBLOTE, CT2_DOC, CT2_LINHA, CT2_TPSALD, CT2_EMPORI, CT2_FILORI, CT2_MOEDLC
							
							If ! CT2->(dbSeek ( xFilial("CT2") + DTOS(dData) + "008850" + "002" + "900001" + STRZERO(nLin,3) ))
							
								If TMP->SOMA > 0
							
									RecLock("CT2", .T.)
									
										CT2->CT2_FILIAL := xFilial("CT2")
										CT2->CT2_DATA	:= dData
										CT2->CT2_LOTE	:= "008850" 
										CT2->CT2_SBLOTE	:= "002"
										CT2->CT2_DOC 	:= "900001"
										CT2->CT2_LINHA	:= STRZERO(nLin,3)
										CT2->CT2_MOEDLC	:= "01"
										CT2->CT2_DC		:= CT5->CT5_DC
										CT2->CT2_DEBITO	:= TMP->CONTA_DEBITO
										CT2->CT2_CREDIT	:= TMP->CONTA_CREDITO
										CT2->CT2_VALOR	:= TMP->SOMA
										CT2->CT2_HIST	:= CT5->CT5_HAGLUT
										CT2->CT2_EMPORI	:= "01"
										CT2->CT2_FILORI	:= "0001"
										CT2->CT2_TPSALD	:= "1"
										CT2->CT2_SEQUEN	:= "000000" + STRZERO(nLin,3)
										CT2->CT2_MANUAL	:= "2"
										CT2->CT2_ORIGEM	:= "520-" + CT5->CT5_SEQUEN + " "+SUBSTR(CUSUARIO,7,15)+" "+DTOC(DATE())
										CT2->CT2_ROTINA	:= "BDCTB520"
										CT2->CT2_AGLUT	:= "1"
										CT2->CT2_LP		:= CT5->CT5_LANPAD
										CT2->CT2_SEQHIS	:= "001"
										CT2->CT2_SEQLAN	:= CT5->CT5_SEQUEN
										CT2->CT2_CRCONV	:= "1"
										CT2->CT2_DTCV3	:= dData
										CT2->CT2_CTLSLD	:= "0"
										
									MsUnLock()
																
								EndIf
									
							EndIf 
																			
						End Transaction	
						
						nLin ++
												
						TMP->(dbSkip())
					Enddo
				
			EndIf						
			CT5->(dbSkip())
		Enddo
	EndIf		
	
	//Atualiza Flag SE5
	XFLGSE5(dData)
	
	MsgInfo("Contabilização concluída com sucesso, numero de registros: " + cValToChar(nLin), "BDCTB520" )
			
Return

Static Function XFLGSE5(dData)

	Local cQuery
	Local nStatus
	
	TCLink() //Inicia nova conexão banco de dados.
				
		cQuery := "	UPDATE "+RETSQLNAME("SE5")+" SET E5_LA = 'S' " + CRLF
		cQuery += "	WHERE E5_FILIAL = '' " + CRLF
		cQuery += "	AND E5_DATA = '"+DTOS(dData)+"' " + CRLF
		cQuery += "	AND E5_LA != 'S' " + CRLF
		cQuery += "	AND E5_RECPAG = 'R' " + CRLF
		cQuery += "	AND E5_MOTBX = 'NOR' " + CRLF
		cQuery += "	AND D_E_L_E_T_ != '*' " + CRLF
		
		nStatus := 	TcSqlExec(cQuery)
					
		TcSqlExec("COMMIT")
					
		If (nStatus < 0)
			Alert("TCSQLError() " + TCSQLError())
		EndIf
		
	TCUnlink()

Return