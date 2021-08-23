#Include "tbiconn.ch"
#Include "protheus.ch"


/*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºPrograma ³ BLFINRL10         ºAutor³ RVACARI Felipe Mayer	    º Data Ini³ 15/06/2020   º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºDesc.    ³ Relatório Relatório de Pagamentos com vlr Bruto e Juros/Multa				  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºUso      ³ BACIO DI LATTE	                                            		  		  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/

User Function BLFINRL10()

Local aPergs   := {}
Local dDTBXDe := SToD('')
Local dDTBXAt := SToD('')


aAdd(aPergs, {1, "Data Baixa de" , dDTBXDe,  "",  ".T.",   "",  ".T.", 80,  .T.})
aAdd(aPergs, {1, "Data Baixa Até", dDTBXAt,  "",  ".T.",   "",  ".T.", 80,  .T.})

If ParamBox(aPergs, "Informe os parâmetros")
	MsAguarde({|| GeraExcel()},,"O arquivo Excel está sendo gerado...")
EndIf

Return Nil


/*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± Static	 ³ GeraExcel        ºAutor³ RVACARI Felipe Mayer	    º Data Ini³ 15/06/2020   º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºDesc.    ³ Responsável por montar Query e criação do objeto excel						  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/

Static Function GeraExcel()

Local oExcel  := FWMSEXCEL():New()
Local lOK 	  := .F.
Local cArq 	  := "" 
Local cQuery  := ""
Local cTitle  := "BDLFINRL2"
Local nY	  := 1
Local aItens   := {}
Local cPar1   := MV_PAR01
Local cPar2   := MV_PAR02
Local cDirTmp

SetPrvt("MV_PAR01","MV_PAR02")

	cQuery += " SELECT DISTINCT E2_FILORIG,E2_CCUSTO,CTT_DESC01 N_CCUSTO, "
	cQuery += " E2_TIPO,E2_PREFIXO,E2_NUM,E2_PARCELA,E2_NOMFOR,E2_FORNECE,E2_LOJA,E2_NATUREZ,  "
	cQuery += " CONVERT(VARCHAR(10), CAST(E2_EMISSAO AS DATE),103) AS E2_EMISSAO, "
	cQuery += " CONVERT(VARCHAR(10), CAST(E2_VENCREA AS DATE),103) AS E2_VENCREA, "
	cQuery += " CONVERT(VARCHAR(10), CAST(E2_BAIXA AS DATE),103) AS BAIXA, "
	cQuery += " (E2_VALOR+E2_IRRF+E2_ISS) BRUTO, (E2_ISS+E2_IRRF+E2_COFINS+E2_PIS+E2_CSLL) AS IMPOSTOS, "  
	cQuery += " (E2_VALLIQ)-(E2_JUROS+E2_MULTA) VALOR_LIQ, (E2_JUROS+E2_MULTA) AS JUROS_MULTA, E2_DESCONT AS DESCONTO, "
	cQuery += " (E2_VALLIQ-E2_DESCONT) AS VALOR_PAGO,E2_HIST FROM "+RetSqlName('SE2')+" SE2 "
	cQuery += " LEFT OUTER JOIN "+RetSqlName('CTT')+" CTT ON CTT_CUSTO=E2_CCUSTO AND CTT.D_E_L_E_T_='' "
	cQuery += " WHERE E2_BAIXA BETWEEN '"+DToS(cPar1)+"' AND '"+DToS(cPar2)+"' "
	cQuery += " AND E2_BAIXA <> '' AND SE2.D_E_L_E_T_= '' " //cQuery += " AND E2_BAIXA <> '' AND E2_TIPO = 'NF' AND SE2.D_E_L_E_T_= '' "
	cQuery += " ORDER BY E2_FILORIG, E2_EMISSAO, E2_NUM "


	If Select("TMP") <> 0
		DbSelectArea("TMP")
		DbCloseArea()
	EndIf	
	
	cQuery := ChangeQuery(cQuery)
	DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),'TMP',.F.,.T.)
	
	dbSelectArea("TMP")
	TMP->(dbGoTop())

	oExcel:SetLineFrColor("#000")
	oExcel:SetTitleFrColor("#000")
	oExcel:SetFrColorHeader("#000")
			
	oExcel:AddWorkSheet(cTitle)
	oExcel:AddTable(cTitle,cTitle)
	oExcel:AddColumn(cTitle,cTitle,"Orig"				,2,1)
	oExcel:AddColumn(cTitle,cTitle,"C. de Custo"		,2,1)
	oExcel:AddColumn(cTitle,cTitle,"C. de Custo"		,1,1)
	oExcel:AddColumn(cTitle,cTitle,"TP" 				,2,1)
	oExcel:AddColumn(cTitle,cTitle,"Prf" 				,2,1)
	oExcel:AddColumn(cTitle,cTitle,"Numero"				,1,1)
	oExcel:AddColumn(cTitle,cTitle,"Prc" 				,2,1)
	oExcel:AddColumn(cTitle,cTitle,"Nome Fornecedor"	,1,2)
	oExcel:AddColumn(cTitle,cTitle,"Fornecedor"			,2,2)
	oExcel:AddColumn(cTitle,cTitle,"Loja"				,2,2)
	oExcel:AddColumn(cTitle,cTitle,"Natureza"			,2,2)
	oExcel:AddColumn(cTitle,cTitle,"Data de Emissao"	,2,2)
	oExcel:AddColumn(cTitle,cTitle,"Vencto Real"		,2,2)
	oExcel:AddColumn(cTitle,cTitle,"Dt Baixa"			,2,2)
	oExcel:AddColumn(cTitle,cTitle,"Vlr Bruto"			,2,2)
	oExcel:AddColumn(cTitle,cTitle,"IMPOSTOS"			,2,2)
	oExcel:AddColumn(cTitle,cTitle,"Vlr Liquido"		,2,2)
	oExcel:AddColumn(cTitle,cTitle,"Jur/Multa"			,2,2)
	oExcel:AddColumn(cTitle,cTitle,"Descontos "			,2,2)
	oExcel:AddColumn(cTitle,cTitle,"Total Baixado"		,2,2)
	oExcel:AddColumn(cTitle,cTitle,"Classificação"		,1,2)
  
			
	While TMP->(!EOF())

		Aadd(aItens,{;
		TMP->E2_FILORIG	,;//[01]
		TMP->E2_CCUSTO	,;//[02]
		TMP->N_CCUSTO	,;//[03]
		TMP->E2_TIPO	,;//[04]
		TMP->E2_PREFIXO	,;//[05]
		TMP->E2_NUM		,;//[06]
		TMP->E2_PARCELA	,;//[07]
		TMP->E2_NOMFOR	,;//[08]
		TMP->E2_FORNECE	,;//[09]
		TMP->E2_LOJA	,;//[10]
		TMP->E2_NATUREZ	,;//[11]
		TMP->E2_EMISSAO	,;//[12]
		TMP->E2_VENCREA	,;//[13]
		TMP->BAIXA		,;//[14]
		TMP->BRUTO		,;//[15]
		TMP->IMPOSTOS	,;//[16]
		TMP->VALOR_LIQ	,;//[17]
		TMP->JUROS_MULTA,;//[18]
		TMP->DESCONTO	,;//[19]
		TMP->VALOR_PAGO	,;//[20]
		TMP->E2_HIST	})//[21]

		oExcel:AddRow(cTitle,cTitle,;
		{Alltrim(aItens[nY,01]),Alltrim(aItens[nY,02]),Alltrim(aItens[nY,03]),Alltrim(aItens[nY,04]),Alltrim(aItens[nY,05]),Alltrim(aItens[nY,06]),Alltrim(aItens[nY,07]),;
		 Alltrim(aItens[nY,08]),Alltrim(aItens[nY,09]),Alltrim(aItens[nY,10]),Alltrim(aItens[nY,11]),Alltrim(aItens[nY,12]),Alltrim(aItens[nY,13]),Alltrim(aItens[nY,14]),;
		 StrTran(cValToChar(aItens[nY,15]),".",","),StrTran(cValToChar(aItens[nY,16]),".",","),StrTran(cValToChar(aItens[nY,17]),".",","),StrTran(cValToChar(aItens[nY,18]),".",","),;
		 StrTran(cValToChar(aItens[nY,19]),".",","),StrTran(cValToChar(aItens[nY,20]),".",","),Alltrim(aItens[nY,21])})

		nY++
		lOK := .T.
		TMP->(dbSkip())
	
	EndDo     
     
		dbSelectArea("TMP")
		dbCloseArea()
		
			cDirTmp:= cGetFile( '*.csv|*.csv' , 'Selecionar um diretório para salvar', 1, 'C:\', .F., nOR( GETF_LOCALHARD, GETF_LOCALFLOPPY, GETF_RETDIRECTORY ),.T., .T. )

			oExcel:Activate()
			cArq := CriaTrab(NIL, .F.) + '_' +cTitle+ ".xml"
			oExcel:GetXMLFile(cArq)
			
			If __CopyFile(cArq,cDirTmp + cArq)
				If lOK
					oExcelApp := MSExcel():New()
					oExcelApp:WorkBooks:Open(cDirTmp + cArq)
					oExcelApp:SetVisible(.T.)
					oExcelApp:Destroy()
					MsgInfo("O arquivo Excel foi gerado no dirtério: <br>" + cDirTmp + cArq + ". ")
				EndIf
			Else
					MsgAlert("Erro ao criar o arquivo Excel!")
			EndIf
	
Return Nil
