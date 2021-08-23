#Include "Totvs.ch"
#Include "Fileio.ch"

/*/
{Protheus.doc} EXCZCZ
	@Description: Exclusao de registros tabelas ZCZ
	@author: Felipe Mayer
	@since: 06/07/2021
/*/
User Function EXCZCZ

Local aParam := {}

    aAdd(aParam,{1,"Numero de" ,Space(9),"",".T.","",".T.",50,.F.})
    aAdd(aParam,{1,"Numero Até",Space(9),"",".T.","",".T.",50,.T.})
    aAdd(aParam,{1,"DT Pgto de" ,SToD(''),"",".T.","",".T.",50,.F.})
    aAdd(aParam,{1,"DT Pgto Até",SToD(''),"",".T.","",".T.",50,.F.})

    If ParamBox(aParam,"Parametros",,,,.F.,480,5)
        Processa({||fSearch()},'Aguarde...')
    EndIf 

Return


/*/
{Protheus.doc} fSearch
	@Description: Busca dados
	@author: Felipe Mayer
	@since: 06/07/2021
/*/
Static Function fSearch()

Local nY        := 0
Local aDados    := {}
Local aList     := {}
Local cAliasSQL := GetNextAlias()

SetPrvt("oList1","oFont1","oDlg1","oSay1","oGrp","oBtn1","oBtn2","oBtn3")

    cQuery := CRLF + " SELECT * FROM "+RetSqlName('ZCZ')+"  "
    cQuery += CRLF + " WHERE D_E_L_E_T_!='*'  "
    cQuery += CRLF + " AND ZCZ_NUM BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "
    cQuery += CRLF + " AND ZCZ_DTPG BETWEEN '"+DToS(MV_PAR03)+"' AND '"+DToS(MV_PAR04)+"' "
    cQuery += CRLF + " AND ZCZ_PROC='N' "
    
    MPSysOpenQuery(cQuery,cAliasSQL)

    While (cAliasSQL)->(!EoF())
        aAdd(aDados,{;
            Alltrim((cAliasSQL)->ZCZ_FILORI),;
            Alltrim((cAliasSQL)->ZCZ_PREFIX),;
            Alltrim((cAliasSQL)->ZCZ_NUM),;
            Alltrim((cAliasSQL)->ZCZ_PARCEL),;
            Alltrim((cAliasSQL)->ZCZ_TIPO),;
            Alltrim((cAliasSQL)->ZCZ_NATURE),;
            Alltrim((cAliasSQL)->ZCZ_PORTAD),;
            Alltrim((cAliasSQL)->ZCZ_CLIENT),;
            Alltrim((cAliasSQL)->ZCZ_LOJA),;
            Alltrim((cAliasSQL)->ZCZ_NOMCLI),;
            DToC(SToD((cAliasSQL)->ZCZ_EMISSA)),;
            DToC(SToD((cAliasSQL)->ZCZ_VENCTO)),;
            DToC(SToD((cAliasSQL)->ZCZ_VENCRE)),;
            cValToChar((cAliasSQL)->ZCZ_VALOR),;
            DToC(SToD((cAliasSQL)->ZCZ_DTPG)) })
        (cAliasSQL)->(DbSkip())
    EndDo

    (cAliasSQL)->(DbCloseArea())

    For nY := 1 to Len(aDados)
        Aadd(aList,aDados[nY])
    Next nY

    If Len(aList) < 1
        Aadd(aList,{'','','','','','','','','','','','','','',''})
    EndIf

    oFont1 := TFont():New('Calibri',,-22,.T.)
    oDlg1  := MSDialog():New(018,065,634,1310,"Exclusão de Registros",,,.F.,,,,,,.T.,,,.T. )
    oSay1  := TSay():New( 008,010,{||"CONFIRMA EXCLUSÃO DOS REGISTROS?"},oDlg1,,oFont1,,,,.T.,CLR_BLACK,CLR_WHITE,200,020)

    oList1 := TCBrowse():New(040,008,608,260,,;
    {'Fil Origem','Prefixo','Numero','Parcela','Tipo','Natureza','Portd','Cliente','Loja','Nome Cliente','Emissao','Vencimento','Vencimento Real','Valor','Dt Pgto'},;
    {35,35,50,35,35,50,35,50,35,90,50,50,50,50,50},,,,,,,,,,,,,.F.,,.T.,,.F.,,,)

    oList1:SetArray(aList)
    oList1:bLine := {||{;
        aList[oList1:nAt,01],;
        aList[oList1:nAt,02],;
        aList[oList1:nAt,03],;
        aList[oList1:nAt,04],;
        aList[oList1:nAt,05],;
        aList[oList1:nAt,06],;
        aList[oList1:nAt,07],;
        aList[oList1:nAt,08],;
        aList[oList1:nAt,09],;
        aList[oList1:nAt,10],;
        aList[oList1:nAt,11],;
        aList[oList1:nAt,12],;
        aList[oList1:nAt,13],;
        aList[oList1:nAt,14],;
        aList[oList1:nAt,15]}}
    
    oGrp := TGroup():New( 004,495,029,611,"",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
    oBtn1 := TButton():New( 008,556,"Confirmar",oDlg1,{|| Processa( {|| ExcReg(aDados),oDlg1:End() }, "EXCZCZ", "Processando aguarde...", .F.) },049,016,,,,.T.,,"",,,,.F. )
    oBtn2 := TButton():New( 008,501,"Cancelar" ,oDlg1,{|| oDlg1:End()},049,016,,,,.T.,,"",,,,.F. )
    oBtn3 := TButton():New( 008,400,"Gerar Excel" ,oDlg1,{|| Processa( {|| GeraExcel(aDados) }, "EXCZCZ", "Gerando Excel...", .F.) },049,016,,,,.T.,,"",,,,.F. )

    oList1:Refresh()
    oDlg1:Activate(,,,.T.)

Return

/*/
{Protheus.doc} ExcReg
	@Description: delete reclock tabela
	@author: Felipe Mayer
	@since: 06/07/2021
/*/
Static Function ExcReg(aDados)

Local nY    := 0
Local nCont := 0

    If Len(aDados) > 0
        For nY :=  1 To Len(aDados)
            DbSelectArea('ZCZ')
            ZCZ->(DbSetOrder(1))
            ZCZ->(DbGoTop())

            cChave := AvKey(aDados[nY,01],'ZCZ_FILORI');
                     +AvKey(aDados[nY,02],'ZCZ_PREFIX');
                     +AvKey(aDados[nY,03],'ZCZ_NUM');
                     +AvKey(aDados[nY,04],'ZCZ_PARCEL');
                     +AvKey(aDados[nY,05],'ZCZ_TIPO');
                     +AvKey(aDados[nY,08],'ZCZ_CLIENT');
                     +AvKey(aDados[nY,09],'ZCZ_LOJA')
            
            If ZCZ->(DbSeek(cChave))
                RecLock('ZCZ', .F.)
                ZCZ->ZCZ_LOG := 'Deletado por '+UsrRetName(RetCodUsr())+' - '+DToC(Date())+' - '+Time() 
                DbDelete()
                ZCZ->(MsUnlock())
                nCont++
            EndIf
        Next nY

        MsgInfo("Processo Finalizado!<br>Total de itens deletados: "+cValToChar(nCont))
    Else
        MsgAlert("Não foi encontrado itens para deletar!","Atenção")
    EndIf

    ZCZ->(DbCloseArea())
    
Return


/*/
{Protheus.doc} GeraExcel
	@Description: Gera excel para conferir
	@author: Felipe Mayer
	@since: 06/07/2021
/*/
Static Function GeraExcel(aDados)

Local oExcel  := FWMSEXCEL():New()
Local nX	  := 0
Local cArq 	  := "" 
Local cDirTmp := ""
Local lOK 	  := .F.
Local cTitle  := "Exclusao_Registros"
Local dDataGer:= Date()
Local cHoraGer:= Time()

	If len(aDados) < 1
		MsgAlert("Não foi encontrado dados para extrair")
	Else
		oExcel:SetLineFrColor("#000")
		oExcel:SetTitleFrColor("#000")
		oExcel:SetFrColorHeader("#000")
		oExcel:AddWorkSheet(cTitle)
		oExcel:AddTable(cTitle,cTitle)
		oExcel:AddColumn(cTitle,cTitle,"Fil Origem"     ,2,1)
		oExcel:AddColumn(cTitle,cTitle,"Prefixo"		,2,1)
		oExcel:AddColumn(cTitle,cTitle,"Numero"		    ,2,1)
		oExcel:AddColumn(cTitle,cTitle,"Parcela"     	,2,1)
		oExcel:AddColumn(cTitle,cTitle,"Tipo"	  	    ,2,1)
		oExcel:AddColumn(cTitle,cTitle,"Natureza"     	,2,1)
		oExcel:AddColumn(cTitle,cTitle,"Portd"  	    ,2,1)
		oExcel:AddColumn(cTitle,cTitle,"Cliente"	    ,2,1)
		oExcel:AddColumn(cTitle,cTitle,"Loja"	        ,2,1)
		oExcel:AddColumn(cTitle,cTitle,"Nome Cliente"   ,1,1)
        oExcel:AddColumn(cTitle,cTitle,"Emissao"        ,2,4)
        oExcel:AddColumn(cTitle,cTitle,"Vencimento"     ,2,4)
        oExcel:AddColumn(cTitle,cTitle,"Vencimento Real",2,4)
        oExcel:AddColumn(cTitle,cTitle,"Valor"        	,2,3)
        oExcel:AddColumn(cTitle,cTitle,"Dt Pgto"        ,2,4)

		For nX :=  1 To Len(aDados)
			oExcel:AddRow(cTitle,cTitle,;
			{aDados[nX,01],aDados[nX,02],aDados[nX,03],aDados[nX,04],aDados[nX,05],aDados[nX,06],aDados[nX,07],aDados[nX,08],;
            aDados[nX,09],aDados[nX,10],CToD(aDados[nX,11]),CToD(aDados[nX,12]),CToD(aDados[nX,13]),Val(aDados[nX,14]),CToD(aDados[nX,15])})
            lOK := .T.
		Next nX

		cDirTmp := cGetFile('*.csv|*.csv','Selecionar um diretório para salvar',1,'C:\',.F.,nOR(GETF_LOCALHARD,GETF_LOCALFLOPPY,GETF_RETDIRECTORY),.T.,.T.)

		oExcel:Activate()

		cArq := CriaTrab(NIL, .F.) + "_" + cTitle + "_" + dToS(dDataGer) + "_" + StrTran(cHoraGer, ':', '-')+ ".xml"  
		oExcel:GetXMLFile(cArq)
		
		If __CopyFile(cArq,cDirTmp + cArq)
			If lOK
				oExcelApp := MSExcel():New()
				oExcelApp:WorkBooks:Open(cDirTmp + cArq)
				oExcelApp:SetVisible(.T.)
				oExcelApp:Destroy()
				MsgInfo("O arquivo Excel foi gerado no dirtério: " + cDirTmp + cArq)
			EndIf
		Else
			MsgAlert("Erro ao criar o arquivo Excel!")
		EndIf
	EndIf
Return
