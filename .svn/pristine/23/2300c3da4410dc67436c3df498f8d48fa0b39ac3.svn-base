#Include "tbiconn.ch"
#Include "protheus.ch"


/*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºPrograma ³ BLESTR17         ºAutor³ RVACARI Felipe Mayer	    º Data Ini³ 05/03/2020   º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºDesc.    ³ Exibir a produção/Consumo por Produto em uma matrix dia a dia - TODAS AS LOJAS ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºUso      ³ BACIO DI LATTE	                                            		  		  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/

User Function BLESTR17()

Local aPergs   := {}
Local cMes     := Space(2)
Local cAno     := Space(4)
private _dDataDe
private _dDataAte


aAdd(aPergs, {1, "Mês",  cMes,  "",  ".T.",   "",  ".T.", 80,  .T.})
aAdd(aPergs, {1, "Ano",	 cAno,  "",  ".T.",   "",  ".T.", 80,  .T.})


If ParamBox(aPergs, "Informe os parâmetros")
	MsAguarde({|| GeraExcel()},,"O arquivo Excel está sendo gerado...")
EndIf

Return Nil


/*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± Static	 ³ GeraExcel        ºAutor³ RVACARI Felipe Mayer	    º Data Ini³ 05/03/2020   º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºDesc.    ³ Responsável por montar Query e criação do objeto excel						  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºUso      ³ BACIO DI LATTE	                                            		  		  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/

Static Function GeraExcel()

Local oExcel  := FWMSEXCEL():New()
Local lOK 	  := .F.
Local cArq 	  := "" 
Local cQuery  := ""
Local cQuery1 := ""
Local cTitle  := ""
Local cPar1   := MV_PAR01
Local cPar2   := MV_PAR02
local _nTot   := 0
local _nTot1  := 0
Local nTot    := 0
Local nTot1   := 0
local nX 	  := 0
local nY	  := 0
Local cDirTmp
Private MV_PAR01
Private MV_PAR02


    _dDataDe := StoD(cPar2 + strzero(val(cPar1),2) + "01")
    _dDataAte := LastDay(_dDataDe)

	cTitle := {"Janeiro", "Fevereiro", "Março", "Abril", "Março", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"};
	[Month(_dDataAte)] + "_" + Alltrim(Str(Year(_dDataAte)))

	cQuery := " SELECT DESCRICAO,ISNULL(D1, 0) D1,ISNULL(D2, 0) D2,ISNULL(D3, 0) D3,ISNULL(D4, 0) D4,ISNULL(D5, 0) D5,ISNULL(D6, 0) D6,ISNULL(D7, 0) D7, "   
	cQuery += " ISNULL(D8, 0) D8,ISNULL(D9, 0) D9,ISNULL(D10, 0) D10,ISNULL(D11, 0) D11,ISNULL(D12, 0) D12,ISNULL(D13, 0) D13,ISNULL(D14, 0) D14, "
	cQuery += " ISNULL(D15, 0) D15,ISNULL(D16, 0) D16,ISNULL(D17, 0) D17,ISNULL(D18, 0) D18,ISNULL(D19, 0) D19,ISNULL(D20, 0) D20,ISNULL(D21, 0) D21, "
	cQuery += " ISNULL(D22, 0) D22,ISNULL(D23, 0) D23,ISNULL(D24, 0) D24,ISNULL(D25, 0) D25,ISNULL(D26, 0) D26,ISNULL(D27, 0) D27,ISNULL(D28, 0) D28, "
	cQuery += " ISNULL(D29, 0) D29,ISNULL(D30, 0) D30,ISNULL(D31, 0) D31, LOCPAD"
	cQuery += " FROM (SELECT B1_DESC DESCRICAO, D3_FILIAL FILIAL, D3_LOCAL LOCPAD,D3_CF CF,D3_TM TM,D3_USUARIO USUARIO,'D' + LTRIM(STR(DAY(D3_EMISSAO))) DIA,D3_QUANT "  
	cQuery += " FROM "+RetSQLName("SD3")+" D3 JOIN "+RetSQLName("SB1")+" B1 ON B1_COD = D3_COD AND D3_EMISSAO BETWEEN '"+ DToS(_dDataDe) +"' AND '"+ DToS(_dDataAte) +"' "
	cQuery += " AND D3_ESTORNO = '' AND D3.D_E_L_E_T_='' AND B1.D_E_L_E_T_='') PRD "
	cQuery += " PIVOT ( SUM(PRD.D3_QUANT) FOR DIA IN (D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20, D21,  "
	cQuery += " D22, D23, D24, D25, D26, D27, D28, D29, D30, D31)) PVT "
	cQuery += " WHERE FILIAL <> '0031'  AND CF = 'PR0' AND USUARIO = 'gestor.loja' "
	cQuery += " ORDER BY LOCPAD "

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
			
	oExcel:AddWorkSheet("PRODUCAO")
	oExcel:AddTable("PRODUCAO","PRODUCAO - "+cTitle)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"Descrição",1,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"Armazém",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"1",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"2",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"3",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"4",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"5",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"6",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"7",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"8",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"9",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"10",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"11",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"12",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"13",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"14",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"15",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"16",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"17",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"18",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"19",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"20",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"21",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"22",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"23",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"24",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"25",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"26",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"27",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"28",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"29",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"30",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"31",2,1)
	oExcel:AddColumn("PRODUCAO","PRODUCAO - "+cTitle,"Total",2,1)
		
		While TMP->(!EOF())

			_nTot := 0
			
			For nX := 1 To day(_dDataAte)
				_nTot += ("TMP")->&(FieldName(nX+1))
			Next nX
			
			nTot := _nTot

			oExcel:AddRow("PRODUCAO","PRODUCAO - "+cTitle,;
			{TMP->DESCRICAO,TMP->LOCPAD,TMP->D1,TMP->D2,TMP->D3,TMP->D4,TMP->D5,TMP->D6,TMP->D7,TMP->D8,TMP->D9,TMP->D10,TMP->D11,TMP->D12,TMP->D13,TMP->D14,TMP->D15,;
			TMP->D16,TMP->D17,TMP->D18,TMP->D19,TMP->D20,TMP->D21,TMP->D22,TMP->D23,TMP->D24,TMP->D25,TMP->D26,TMP->D27,TMP->D28,TMP->D29,TMP->D30,TMP->D31,nTot})
																												
				lOK := .T.
				TMP->(dbSkip())
		EndDo

		dbSelectArea("TMP")
		dbCloseArea()

	cQuery1 := " SELECT DESCRICAO,ISNULL(D1, 0) D1,ISNULL(D2, 0) D2,ISNULL(D3, 0) D3,ISNULL(D4, 0) D4,ISNULL(D5, 0) D5,ISNULL(D6, 0) D6,ISNULL(D7, 0) D7, "   
	cQuery1 += " ISNULL(D8, 0) D8,ISNULL(D9, 0) D9,ISNULL(D10, 0) D10,ISNULL(D11, 0) D11,ISNULL(D12, 0) D12,ISNULL(D13, 0) D13,ISNULL(D14, 0) D14, "
	cQuery1 += " ISNULL(D15, 0) D15,ISNULL(D16, 0) D16,ISNULL(D17, 0) D17,ISNULL(D18, 0) D18,ISNULL(D19, 0) D19,ISNULL(D20, 0) D20,ISNULL(D21, 0) D21, "
	cQuery1 += " ISNULL(D22, 0) D22,ISNULL(D23, 0) D23,ISNULL(D24, 0) D24,ISNULL(D25, 0) D25,ISNULL(D26, 0) D26,ISNULL(D27, 0) D27,ISNULL(D28, 0) D28, "
	cQuery1 += " ISNULL(D29, 0) D29,ISNULL(D30, 0) D30,ISNULL(D31, 0) D31, LOCPAD"
	cQuery1 += " FROM (SELECT B1_DESC DESCRICAO, B1_COD COD, B1_TIPO TIPO,D3_FILIAL FILIAL, D3_LOCAL LOCPAD,D3_CF CF,D3_TM TM,D3_USUARIO  USUARIO,'D' + LTRIM(STR(DAY(D3_EMISSAO))) DIA,D3_QUANT "  
	cQuery1 += " FROM "+RetSQLName("SD3")+" D3 JOIN "+RetSQLName("SB1")+" B1 ON B1_COD = D3_COD AND D3_EMISSAO BETWEEN '"+ DToS(_dDataDe) +"' AND '"+ DToS(_dDataAte) +"' "
	cQuery1 += " AND D3_ESTORNO = '' AND D3.D_E_L_E_T_='' AND B1.D_E_L_E_T_='') PRD "
	cQuery1 += " PIVOT ( SUM(PRD.D3_QUANT) FOR DIA IN (D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20, D21,  "
	cQuery1 += " D22, D23, D24, D25, D26, D27, D28, D29, D30, D31)) PVT "
	cQuery1 += " WHERE FILIAL <> '0031'  AND TM = '999' AND USUARIO = 'gestor.loja' AND DESCRICAO LIKE '%GELATO%' AND TIPO ='PA' "
	cQuery1 += " ORDER BY LOCPAD "

	If Select("TMP2") <> 0
		DbSelectArea("TMP2")
		DbCloseArea()
	EndIf	
	
	cQuery1 := ChangeQuery(cQuery1)
	DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery1),'TMP2',.F.,.T.)
	
	dbSelectArea("TMP2")
	TMP2->(dbGoTop())

	oExcel:AddWorkSheet("CONSUMO")
	oExcel:AddTable("CONSUMO","CONSUMO - "+cTitle)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"Descrição",1,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"Armazém",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"1",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"2",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"3",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"4",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"5",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"6",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"7",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"8",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"9",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"10",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"11",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"12",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"13",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"14",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"15",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"16",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"17",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"18",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"19",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"20",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"21",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"22",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"23",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"24",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"25",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"26",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"27",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"28",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"29",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"30",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"31",2,1)
	oExcel:AddColumn("CONSUMO","CONSUMO - "+cTitle,"Total",2,1)	
			
		While TMP2->(!EOF())

			_nTot1 := 0
			
			For nY := 1 To day(_dDataAte)
				_nTot1 += ("TMP2")->&(FieldName(nY+1))
			Next nY

			nTot1 := _nTot1
			
			oExcel:AddRow("CONSUMO","CONSUMO - "+cTitle,;
			{TMP2->DESCRICAO,TMP2->LOCPAD,TMP2->D1,TMP2->D2,TMP2->D3,TMP2->D4,TMP2->D5,TMP2->D6,TMP2->D7,TMP2->D8,TMP2->D9,TMP2->D10,TMP2->D11,TMP2->D12,TMP2->D13,TMP2->D14,TMP2->D15,;
			TMP2->D16,TMP2->D17,TMP2->D18,TMP2->D19,TMP2->D20,TMP2->D21,TMP2->D22,TMP2->D23,TMP2->D24,TMP2->D25,TMP2->D26,TMP2->D27,TMP2->D28,TMP2->D29,TMP2->D30,TMP2->D31,nTot1 })
															
				lOK := .T.
				TMP2->(dbSkip())
		EndDo

			dbSelectArea("TMP2")
			dbCloseArea()
		
			cDirTmp:= cGetFile( '*.csv|*.csv' , 'Selecionar um diretório para salvar', 1, 'C:\', .F., nOR( GETF_LOCALHARD, GETF_LOCALFLOPPY, GETF_RETDIRECTORY ),.T., .T. )

			oExcel:Activate()
	
			cArq := CriaTrab(NIL, .F.) + '_' + cTitle + ".xml"
			oExcel:GetXMLFile(cArq)
			
			If __CopyFile(cArq,cDirTmp + cArq)
				If lOK
					oExcelApp := MSExcel():New()
					oExcelApp:WorkBooks:Open(cDirTmp + cArq)
					oExcelApp:SetVisible(.T.)
					oExcelApp:Destroy()
					MsgInfo("O arquivo Excel foi gerado no dirtério: " + cDirTmp + cArq + ". ")
				EndIf
			Else
					MsgAlert("Erro ao criar o arquivo Excel!")
			EndIf
	
Return Nil