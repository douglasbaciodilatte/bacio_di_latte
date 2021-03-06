#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"

/*/
{Protheus.doc} BDESTA02
Description

	Rotina tem como objetivo criar saldo inicial para produtos em todos os armaz?ns 

@param xParam Parameter Description
@return Nil
@author  - Douglas Rodrigues Silva
@since 05/12/2019
/*/

User Function BDESTA03()

	Local aParamBox	:= {}
	Private aRet		:= {}
			
	//Parametros para gerar query de dados
	aAdd(aParamBox,{1,"Filial De" 	,Space(4),"","","SM0","",50,.F.}) 
	aAdd(aParamBox,{1,"Filial Ate"	,Space(4),"","","SM0","",50,.F.}) 
	aAdd(aParamBox,{1,"Produto"		,Space(15),"","","SB1","",50,.F.}) 
			
	If ParamBox(aParamBox ,"Parametros ",aRet)	
		Processa(  {|| Exec1(aRet) } ,'Aguarde Sincronizando Armaz?m x Filial...')		
	Else
		Alert("A??o cancelada! ")
	EndIf
	
Return

Static Function Exec1(aRet)

	Local cQuery := ""
	Local nTotal := 0
	Local nRec	 := 0
	/*
	cQuery := " SELECT B7_COD, B1_DESC, B1_TIPO " + CRLF
	cQuery += " FROM "+RETSQLNAME("SB7")+" SB7 " + CRLF
	cQuery += " LEFT JOIN "+RETSQLNAME("SB1")+" SB1 ON SB1.B1_FILIAL = '' AND SB1.B1_COD = SB7.B7_COD AND SB1.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " WHERE B7_QUANT != 0 AND SB7.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " 	AND SB1.B1_MSBLQL != '1' AND SUBSTRING(SB7.B7_DATA,1,4) = '2019' AND B1_TIPO NOT IN ( 'MC','VE' ) " + CRLF	
	cQuery += " GROUP BY B7_COD, B1_DESC, B1_TIPO " + CRLF
	*/

	cQuery := " SELECT B1_COD, B1_DESC, B1_TIPO " + CRLF
	cQuery += " FROM "+RETSQLNAME("SB1")+" SB1 " + CRLF 
	cQuery += " WHERE D_E_L_E_T_ != '*' AND B1_XLISTA = '2' AND B1_FILIAL = '' " + CRLF
	cQuery += " ORDER BY B1_TIPO " + CRLF

	cQuery := ChangeQuery(cQuery)
	
	If Select("QRY") > 0
		Dbselectarea("QRY")
		QRY->(DbClosearea())
	EndIf
	
	TcQuery cQuery New Alias "QRY"
	
	Count To nTotal
	
	ProcRegua(nTotal)
		
	QRY->(dbGoTop())
	
	//Inicia leitura cadastro de produto
	Do While QRY->(!EOF())
		
		IncProc()
		
		//Query para buscar todos os Armaz?ns diponivel na base
		cQuery := " SELECT NNR_FILIAL, NNR_CODIGO FROM "+RETSQLNAME("NNR")+" WHERE D_E_L_E_T_ != '*' AND NNR_CODIGO NOT IN ('01    ', '000001') " + CRLF 
		cQuery += " AND NNR_FILIAL BETWEEN '"+aRet[1]+"' AND '"+aRet[2]+"' GROUP BY NNR_FILIAL, NNR_CODIGO ORDER BY 1,2 " + CRLF
		
		cQuery := ChangeQuery(cQuery)
	
		If Select("QRZ") > 0
			Dbselectarea("QRZ")
			QRZ->(DbClosearea())
		EndIf
		
		TcQuery cQuery New Alias "QRZ"
		
		Do While QRZ->(!EOF())
			
			//Verifica se produto reamente n?o existe saldo inicial
			SB2->(dbSelectArea("SB2"))
			SB2->(dbSetOrder(1)) //B2_FILIAL, B2_COD, B2_LOCAL
			
			If ! SB2->( (dbSeek( QRZ->NNR_FILIAL + QRY->B1_COD + QRZ->NNR_CODIGO  )) )
				nRec++
				RecLock("SB2",.T.)
					SB2->B2_FILIAL 	:= QRZ->NNR_FILIAL
					SB2->B2_COD 	:= QRY->B1_COD
					SB2->B2_LOCAL	:= QRZ->NNR_CODIGO 
					SB2->B2_XDTINI	:= Date()
				MsUnlock()							
			EndIf
			
			QRZ->(dbSkip())
		Enddo	
		
		QRY->(dbSkip())
	Enddo	
	
	MsgInfo("Processamento conclu?do com sucesso, numero de itens criado " + cValToChar(nRec))

Return
