#Include "Totvs.ch"
#Include "fileio.ch"

/*/{Protheus.doc} User Function RELPCP02
    Relatorio de Estrutura de produtos por componente
    @type user function
    @author Felipe Mayer
    @since 20/05/2021
    @param
    @return
/*/
User Function RELPCP02()

Local nHandle 
Local cDirTmp
Local aDados    := {}
Local cQuery    := ""
Local cAliasSQL := GetNextAlias()
Local cHora     := StrTran(cValToChar(Time()),":")
Local aParam    := {{1,"Produto de" ,Space(TamSx3('B1_COD')[1]),X3Picture('B1_COD'),"","SB1",".T.",80,.F.},;
                    {1,"Produto Até",Space(TamSx3('B1_COD')[1]),X3Picture('B1_COD'),"","SB1",".T.",80,.T.} }

    If !ParamBox(aParam,"Parametros",,,,.F.,420,5)        
        Return
    Else
        cQuery := CRLF + " WITH ESTRUT(CODIGO,COD_COMP,QTD,PERDA,DT_INI,DT_FIM,NIVEL) AS (  "
        cQuery += CRLF + "  SELECT G1_COD,G1_COMP,G1_QUANT,G1_PERDA,G1_INI,G1_FIM,1 AS NIVEL "
        cQuery += CRLF + " 	FROM "+RetSQLName('SG1')+" SG1 (NOLOCK) "
        cQuery += CRLF + " 	WHERE SG1.D_E_L_E_T_!='*' AND G1_FILIAL='"+xFilial('SG1')+"' "
        cQuery += CRLF + " UNION ALL "
        cQuery += CRLF + " 	SELECT CODIGO,G1_COMP,QTD*G1_QUANT,G1_PERDA,G1_INI,G1_FIM,NIVEL+1 "
        cQuery += CRLF + "  FROM "+RetSQLName('SG1')+" SG1 (NOLOCK) "
        cQuery += CRLF + " 	INNER JOIN ESTRUT EST ON G1_COD=COD_COMP "
        cQuery += CRLF + " 	WHERE SG1.D_E_L_E_T_!='*' AND SG1.G1_FILIAL='"+xFilial('SG1')+"' ) "
        cQuery += CRLF + " SELECT * FROM ESTRUT E1 WHERE E1.COD_COMP BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "
        cQuery += CRLF + " ORDER BY E1.COD_COMP "
        
        MPSysOpenQuery(cQuery,cAliasSQL)

        While (cAliasSQL)->(!EoF())
            aAdd(aDados,{;
                cValToChar((cAliasSQL)->NIVEL),;
                Alltrim((cAliasSQL)->CODIGO),;
                Alltrim(Posicione('SB1',1,xFilial('SB1')+(cAliasSQL)->CODIGO,'B1_DESC')),;
                Alltrim((cAliasSQL)->COD_COMP),;
                Alltrim(Posicione('SB1',1,xFilial('SB1')+(cAliasSQL)->COD_COMP,'B1_DESC')),;
                cValToChar((cAliasSQL)->QTD),;
                cValToChar((cAliasSQL)->PERDA),;
                cValToChar(Posicione('SB1',1,xFilial('SB1')+(cAliasSQL)->COD_COMP,'B1_CUSTD')),;
                SubsTr((cAliasSQL)->DT_INI,1,4)+'-'+SubsTr((cAliasSQL)->DT_INI,5,2)+'-'+SubsTr((cAliasSQL)->DT_INI,7,2),;
                SubsTr((cAliasSQL)->DT_FIM,1,4)+'-'+SubsTr((cAliasSQL)->DT_FIM,5,2)+'-'+SubsTr((cAliasSQL)->DT_FIM,7,2)})
            (cAliasSQL)->(DbSkip())
        EndDo

        (cAliasSQL)->(DbCloseArea())

        If Len(aDados) > 0
            cXml := fModeloXml(@cDirTmp,aDados)
            nHandle := FCreate(cDirTmp+'_Estruturas_Por_Componente_'+DToS(Date())+cHora+'.xml',FO_READWRITE+FO_SHARED)
            Fwrite(nHandle,cXml+chr(13)+chr(10),10000000)
            
            Fclose(nHandle)
            WinExec('Explorer.exe /select,"'+cDirTmp+'_Estruturas_Por_Componente_'+DToS(Date())+cHora+'.xml'+'"',1)

            MsgInfo('Processo realizado!')
        Else
            MsgAlert("Não há dados")
        EndIf
    EndIf
Return



/*/{Protheus.doc} fModeloXml
    Modelo do arquivo a ser gerado
    @type static function
    @author Felipe Mayer
    @since 13/05/2021
/*/
Static Function fModeloXml(cDirTmp,aDados)

Local cXml     := ""
Local nX       := 0

    cXml := CRLF + " <?xml version='1.0'?> "
    cXml += CRLF + " <?mso-application progid='Excel.Sheet'?> "
    cXml += CRLF + " <Workbook xmlns='urn:schemas-microsoft-com:office:spreadsheet' "
    cXml += CRLF + "  xmlns:o='urn:schemas-microsoft-com:office:office' "
    cXml += CRLF + "  xmlns:x='urn:schemas-microsoft-com:office:excel' "
    cXml += CRLF + "  xmlns:ss='urn:schemas-microsoft-com:office:spreadsheet' "
    cXml += CRLF + "  xmlns:html='http://www.w3.org/TR/REC-html40'> "
    cXml += CRLF + "  <DocumentProperties xmlns='urn:schemas-microsoft-com:office:office'> "
    cXml += CRLF + "   <Author>Mayer Development .</Author> "
    cXml += CRLF + "   <LastAuthor>Mayer Development .</LastAuthor> "
    cXml += CRLF + "   <Created>2021-05-13T14:08:48Z</Created> "
    cXml += CRLF + "   <LastSaved>2021-05-20T22:01:09Z</LastSaved> "
    cXml += CRLF + "   <Version>16.00</Version> "
    cXml += CRLF + "  </DocumentProperties> "
    cXml += CRLF + "  <OfficeDocumentSettings xmlns='urn:schemas-microsoft-com:office:office'> "
    cXml += CRLF + "   <AllowPNG/> "
    cXml += CRLF + "  </OfficeDocumentSettings> "
    cXml += CRLF + "  <ExcelWorkbook xmlns='urn:schemas-microsoft-com:office:excel'> "
    cXml += CRLF + "   <WindowHeight>7545</WindowHeight> "
    cXml += CRLF + "   <WindowWidth>20490</WindowWidth> "
    cXml += CRLF + "   <WindowTopX>32767</WindowTopX> "
    cXml += CRLF + "   <WindowTopY>32767</WindowTopY> "
    cXml += CRLF + "   <ProtectStructure>False</ProtectStructure> "
    cXml += CRLF + "   <ProtectWindows>False</ProtectWindows> "
    cXml += CRLF + "  </ExcelWorkbook> "
    cXml += CRLF + "  <Styles> "
    cXml += CRLF + "   <Style ss:ID='Default' ss:Name='Normal'> "
    cXml += CRLF + "    <Alignment ss:Vertical='Bottom'/> "
    cXml += CRLF + "    <Borders/> "
    cXml += CRLF + "    <Font ss:FontName='Calibri' x:Family='Swiss' ss:Size='11' ss:Color='#000000'/> "
    cXml += CRLF + "    <Interior/> "
    cXml += CRLF + "    <NumberFormat/> "
    cXml += CRLF + "    <Protection/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s62'> "
    cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Bottom'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s63'> "
    cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Center'/> "
    cXml += CRLF + "    <NumberFormat ss:Format='Fixed'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s64'> "
    cXml += CRLF + "    <NumberFormat ss:Format='Short Date'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s65'> "
    cXml += CRLF + "    <Interior ss:Color='#B4C6E7' ss:Pattern='Solid'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s66'> "
    cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Bottom'/> "
    cXml += CRLF + "    <Interior ss:Color='#B4C6E7' ss:Pattern='Solid'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s67'> "
    cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Center'/> "
    cXml += CRLF + "    <Interior ss:Color='#B4C6E7' ss:Pattern='Solid'/> "
    cXml += CRLF + "    <NumberFormat ss:Format='Fixed'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s68'> "
    cXml += CRLF + "    <Interior ss:Color='#B4C6E7' ss:Pattern='Solid'/> "
    cXml += CRLF + "    <NumberFormat ss:Format='Short Date'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s69'> "
    cXml += CRLF + "    <Alignment ss:Horizontal='Left' ss:Vertical='Bottom'/> "
    cXml += CRLF + "    <Font ss:FontName='Calibri' x:Family='Swiss' ss:Size='18' ss:Color='#000000' "
    cXml += CRLF + "     ss:Bold='1'/> "
    cXml += CRLF + "    <Interior ss:Color='#B4C6E7' ss:Pattern='Solid'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s70'> "
    cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Bottom'/> "
    cXml += CRLF + "    <Font ss:FontName='Calibri' x:Family='Swiss' ss:Size='18' ss:Color='#000000' "
    cXml += CRLF + "     ss:Bold='1'/> "
    cXml += CRLF + "    <Interior ss:Color='#B4C6E7' ss:Pattern='Solid'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s71'> "
    cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Bottom'/> "
    cXml += CRLF + "    <Font ss:FontName='Calibri' x:Family='Swiss' ss:Size='11' ss:Color='#000000' "
    cXml += CRLF + "     ss:Bold='1'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s72'> "
    cXml += CRLF + "    <Alignment ss:Vertical='Bottom'/> "
    cXml += CRLF + "    <Font ss:FontName='Calibri' x:Family='Swiss' ss:Size='11' ss:Color='#000000' "
    cXml += CRLF + "     ss:Bold='1'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s73'> "
    cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Center'/> "
    cXml += CRLF + "    <Font ss:FontName='Calibri' x:Family='Swiss' ss:Size='11' ss:Color='#000000' "
    cXml += CRLF + "     ss:Bold='1'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s74'> "
    cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Center'/> "
    cXml += CRLF + "    <Font ss:FontName='Calibri' x:Family='Swiss' ss:Size='11' ss:Color='#000000' "
    cXml += CRLF + "     ss:Bold='1'/> "
    cXml += CRLF + "    <NumberFormat ss:Format='Fixed'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s75'> "
    cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Center'/> "
    cXml += CRLF + "    <Font ss:FontName='Calibri' x:Family='Swiss' ss:Size='11' ss:Color='#000000' "
    cXml += CRLF + "     ss:Bold='1'/> "
    cXml += CRLF + "    <NumberFormat ss:Format='Short Date'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s77'> "
    cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Center'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "   <Style ss:ID='s78'> "
    cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Center'/> "
    cXml += CRLF + "    <NumberFormat ss:Format='Short Date'/> "
    cXml += CRLF + "   </Style> "
    cXml += CRLF + "  </Styles> "
    cXml += CRLF + "  <Worksheet ss:Name='Estruturas_por_Componente'> "
    cXml += CRLF + "   <Table ss:ExpandedColumnCount='11' ss:ExpandedRowCount='9999' x:FullColumns='1' "
    cXml += CRLF + "    x:FullRows='1' ss:DefaultRowHeight='15'> "
    cXml += CRLF + "    <Column ss:AutoFitWidth='0' ss:Width='13.5'/> "
    cXml += CRLF + "    <Column ss:Width='30'/> "
    cXml += CRLF + "    <Column ss:StyleID='s62' ss:AutoFitWidth='0' ss:Width='90.75'/> "
    cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='255.75'/> "
    cXml += CRLF + "    <Column ss:StyleID='s62' ss:AutoFitWidth='0' ss:Width='111.75'/> "
    cXml += CRLF + "    <Column ss:AutoFitWidth='0' ss:Width='253.5'/> "
    cXml += CRLF + "    <Column ss:AutoFitWidth='0' ss:Width='36' ss:Span='1'/> "
    cXml += CRLF + "    <Column ss:Index='9' ss:StyleID='s63' ss:AutoFitWidth='0' ss:Width='36'/> "
    cXml += CRLF + "    <Column ss:StyleID='s64' ss:AutoFitWidth='0' ss:Width='65.25' ss:Span='1'/> "
    cXml += CRLF + "    <Row ss:AutoFitHeight='0' ss:Height='6.75'> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s67'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s68'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s68'/> "
    cXml += CRLF + "    </Row> "
    cXml += CRLF + "    <Row ss:AutoFitHeight='0' ss:Height='23.25'> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s69'><Data ss:Type='String'>Estruturas de Produtos - Por Componente</Data></Cell> "
    cXml += CRLF + "     <Cell ss:StyleID='s70'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s70'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s67'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s68'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s68'/> "
    cXml += CRLF + "    </Row> "
    cXml += CRLF + "    <Row ss:AutoFitHeight='0' ss:Height='6'> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s67'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s68'/> "
    cXml += CRLF + "     <Cell ss:StyleID='s68'/> "
    cXml += CRLF + "    </Row> "

    cXml += CRLF + "    <Row ss:Index='5' ss:AutoFitHeight='0'> "
    cXml += CRLF + "     <Cell ss:Index='2' ss:StyleID='s71'><Data ss:Type='String'>"+EncodeUtf8('Nível')+"</Data></Cell> "
    cXml += CRLF + "     <Cell ss:StyleID='s71'><Data ss:Type='String'>Codigo Pai</Data></Cell> "
    cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>"+EncodeUtf8('Descrição')+"</Data></Cell> "
    cXml += CRLF + "     <Cell ss:StyleID='s71'><Data ss:Type='String'>Cod Componente</Data></Cell> "
    cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>"+EncodeUtf8('Descrição')+"</Data></Cell> "
    cXml += CRLF + "     <Cell ss:StyleID='s73'><Data ss:Type='String'>Quant</Data></Cell> "
    cXml += CRLF + "     <Cell ss:StyleID='s73'><Data ss:Type='String'>Perda</Data></Cell> "
    cXml += CRLF + "     <Cell ss:StyleID='s74'><Data ss:Type='String'>Custo</Data></Cell> "
    cXml += CRLF + "     <Cell ss:StyleID='s75'><Data ss:Type='String'>"+EncodeUtf8('Data Início')+"</Data></Cell> "
    cXml += CRLF + "     <Cell ss:StyleID='s75'><Data ss:Type='String'>Data Final</Data></Cell> "
    cXml += CRLF + "    </Row> "

    For nX := 1 To Len(aDados)
        nCusto := Val(aDados[nX,6])*Val(aDados[nX,8])
        cXml += CRLF + "    <Row ss:AutoFitHeight='0'> "
        cXml += CRLF + "     <Cell ss:Index='2' ss:StyleID='s62'><Data ss:Type='Number'>"+EncodeUtf8(aDados[nX,1])+"</Data></Cell> "
        cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,2])+"</Data></Cell> "
        cXml += CRLF + "     <Cell ss:StyleID='Default'><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,3])+"</Data></Cell> "
        cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,4])+"</Data></Cell> "
        cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,5])+"</Data></Cell> "
        cXml += CRLF + "     <Cell ss:StyleID='s77'><Data ss:Type='Number'>"+EncodeUtf8(aDados[nX,6])+"</Data></Cell> "
        cXml += CRLF + "     <Cell ss:StyleID='s77'><Data ss:Type='Number'>"+EncodeUtf8(aDados[nX,7])+"</Data></Cell> "
        cXml += CRLF + "     <Cell><Data ss:Type='Number'>"+EncodeUtf8(cValToChar(nCusto))+"</Data></Cell> "
        cXml += CRLF + "     <Cell ss:StyleID='s78'><Data ss:Type='DateTime'>"+EncodeUtf8(aDados[nX,9])+"T00:00:00.000</Data></Cell> "
        cXml += CRLF + "     <Cell ss:StyleID='s78'><Data ss:Type='DateTime'>"+EncodeUtf8(aDados[nX,10])+"T00:00:00.000</Data></Cell> "
        cXml += CRLF + "    </Row> "
    Next nX

    cXml += CRLF + "   </Table> "
    cXml += CRLF + "   <WorksheetOptions xmlns='urn:schemas-microsoft-com:office:excel'> "
    cXml += CRLF + "    <PageSetup> "
    cXml += CRLF + "     <Header x:Margin='0.31496062000000002'/> "
    cXml += CRLF + "     <Footer x:Margin='0.31496062000000002'/> "
    cXml += CRLF + "     <PageMargins x:Bottom='0.78740157499999996' x:Left='0.511811024' "
    cXml += CRLF + "      x:Right='0.511811024' x:Top='0.78740157499999996'/> "
    cXml += CRLF + "    </PageSetup> "
    cXml += CRLF + "    <Unsynced/> "
    cXml += CRLF + "    <Print> "
    cXml += CRLF + "     <ValidPrinterInfo/> "
    cXml += CRLF + "     <PaperSizeIndex>9</PaperSizeIndex> "
    cXml += CRLF + "     <HorizontalResolution>600</HorizontalResolution> "
    cXml += CRLF + "     <VerticalResolution>600</VerticalResolution> "
    cXml += CRLF + "    </Print> "
    cXml += CRLF + "    <Zoom>93</Zoom> "
    cXml += CRLF + "    <Selected/> "
    cXml += CRLF + "    <DoNotDisplayGridlines/> "
    cXml += CRLF + "    <Panes> "
    cXml += CRLF + "     <Pane> "
    cXml += CRLF + "      <Number>3</Number> "
    cXml += CRLF + "      <ActiveRow>10</ActiveRow> "
    cXml += CRLF + "      <ActiveCol>5</ActiveCol> "
    cXml += CRLF + "     </Pane> "
    cXml += CRLF + "    </Panes> "
    cXml += CRLF + "    <ProtectObjects>False</ProtectObjects> "
    cXml += CRLF + "    <ProtectScenarios>False</ProtectScenarios> "
    cXml += CRLF + "   </WorksheetOptions> "
    cXml += CRLF + "  </Worksheet> "
    cXml += CRLF + " </Workbook> "

    cDirTmp := cGetFile('*.csv|*.csv','Selecionar um diretório para salvar',1,'C:\',.F.,nOR(GETF_LOCALHARD,GETF_LOCALFLOPPY,GETF_RETDIRECTORY),.T.,.T.)

Return cXml
