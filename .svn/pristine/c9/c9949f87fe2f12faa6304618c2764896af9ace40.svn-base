#INCLUDE "Totvs.ch"
#include "fileio.ch"


/*/{Protheus.doc} User Function blcomr15
    Relatorio de Cadastro de Clientes - Supermercados
    @type user function
    @author Felipe Mayer
    @since 25/05/2021
/*/
User Function blcomr15()

Local nHandle 
Local cDirTmp
Local aDados    := {}
Local cQuery    := ""
Local cAliasSQL := GetNextAlias()
Local cHora     := StrTran(cValToChar(Time()),":")
Local aParam    := {{1,"Natureza",Space(TamSx3('ED_CODIGO')[1]),X3Picture('ED_CODIGO'),"","SED",".T.",80,.F.}}

    If !ParamBox(aParam,"Parametros",,,,.F.,420,5)        
        Return
    Else
		cQuery := CRLF + " SELECT A1_COD+A1_LOJA AS TAG,A1_COD,A1_LOJA,A1_CGC,A1_NOME,A1_NREDUZ,A1_END,A1_COMPLEM, "
		cQuery += CRLF + " 		A1_BAIRRO,A1_EST,A1_COD_MUN,A1_MUN,A1_CEP,A1_NATUREZ,A1_DDD,A1_TEL,A1_INSCR, "
		cQuery += CRLF + " 		CASE WHEN A1_TIPO = 'R' THEN 'Revendedor' "
		cQuery += CRLF + " 			WHEN A1_TIPO = 'F' THEN 'Cons. Final' "
		cQuery += CRLF + " 			WHEN A1_TIPO = 'L' THEN 'Produtor Rural' "
		cQuery += CRLF + " 			WHEN A1_TIPO = 'S' THEN 'Solidário' "
		cQuery += CRLF + " 			WHEN A1_TIPO = 'X' THEN 'Exportação' "
		cQuery += CRLF + " 		ELSE '' END AS TIPO, "
		cQuery += CRLF + " 		A1_CONTA,A1_COND,E4_DESCRI, "
		cQuery += CRLF + "		ISNULL(A1_GRPVEN,'') GRUPO_VEND, "
		cQuery += CRLF + "		ISNULL(ACY_DESCRI,'') DESC_GPVEND "
		cQuery += CRLF + " FROM "+RetSqlName('SA1')+" "
		cQuery += CRLF + " LEFT JOIN "+RetSqlName('ACY')+" ACY ON ACY_FILIAL='' AND ACY_GRPVEN=A1_GRPVEN "
		cQuery += CRLF + " LEFT JOIN "+RetSqlName('SE4')+" SE4 ON E4_FILIAL='' AND E4_CODIGO=A1_COND "
		cQuery += CRLF + " WHERE A1_NATUREZ='"+MV_PAR01+"' "
        
        MPSysOpenQuery(cQuery,cAliasSQL)

        While (cAliasSQL)->(!EoF())
            aAdd(aDados,{;
                AllTrim((cAliasSQL)->TAG),;
				AllTrim((cAliasSQL)->A1_COD),;
				AllTrim((cAliasSQL)->A1_LOJA),;
				AllTrim((cAliasSQL)->A1_CGC),;
				AllTrim((cAliasSQL)->A1_NOME),;
				AllTrim((cAliasSQL)->A1_NREDUZ),;
				AllTrim((cAliasSQL)->A1_END),;
				AllTrim((cAliasSQL)->A1_COMPLEM),;
				AllTrim((cAliasSQL)->A1_BAIRRO),;
				AllTrim((cAliasSQL)->A1_EST),;
				AllTrim((cAliasSQL)->A1_COD_MUN),;
				AllTrim((cAliasSQL)->A1_MUN),;
				AllTrim((cAliasSQL)->A1_CEP),;
				AllTrim((cAliasSQL)->A1_NATUREZ),;
				AllTrim((cAliasSQL)->A1_DDD),;
				AllTrim((cAliasSQL)->A1_TEL),;
				AllTrim((cAliasSQL)->A1_INSCR),;
				AllTrim((cAliasSQL)->TIPO),;
				AllTrim((cAliasSQL)->A1_CONTA),;
				AllTrim((cAliasSQL)->A1_COND),;
				AllTrim((cAliasSQL)->E4_DESCRI),;
				AllTrim((cAliasSQL)->GRUPO_VEND),;
				AllTrim((cAliasSQL)->DESC_GPVEND)})
            (cAliasSQL)->(DbSkip())
        EndDo

        (cAliasSQL)->(DbCloseArea())

        If Len(aDados) > 0
            cXml := fModeloXml(@cDirTmp,aDados)
            nHandle := FCreate(cDirTmp+'_Clientes_'+DToS(Date())+cHora+'.xml',FO_READWRITE+FO_SHARED)
            Fwrite(nHandle,cXml+chr(13)+chr(10),10000000)
            
            Fclose(nHandle)
            WinExec('Explorer.exe /select,"'+cDirTmp+'_Clientes_'+DToS(Date())+cHora+'.xml'+'"',1)

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
	cXml += CRLF + "    <Alignment ss:Horizontal='Left' ss:Vertical='Bottom'/> "
	cXml += CRLF + "   </Style> "
	cXml += CRLF + "   <Style ss:ID='s64'> "
	cXml += CRLF + "    <Alignment ss:Horizontal='Left' ss:Vertical='Center'/> "
	cXml += CRLF + "    <NumberFormat ss:Format='Fixed'/> "
	cXml += CRLF + "   </Style> "
	cXml += CRLF + "   <Style ss:ID='s65'> "
	cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Bottom'/> "
	cXml += CRLF + "    <NumberFormat ss:Format='Short Date'/> "
	cXml += CRLF + "   </Style> "
	cXml += CRLF + "   <Style ss:ID='s66'> "
	cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Bottom'/> "
	cXml += CRLF + "    <Interior ss:Color='#B89875' ss:Pattern='Solid'/> "
	cXml += CRLF + "   </Style> "
	cXml += CRLF + "   <Style ss:ID='s67'> "
	cXml += CRLF + "    <Alignment ss:Horizontal='Left' ss:Vertical='Bottom'/> "
	cXml += CRLF + "    <Interior ss:Color='#B89875' ss:Pattern='Solid'/> "
	cXml += CRLF + "   </Style> "
	cXml += CRLF + "   <Style ss:ID='s68'> "
	cXml += CRLF + "    <Alignment ss:Horizontal='Left' ss:Vertical='Center'/> "
	cXml += CRLF + "    <Interior ss:Color='#B89875' ss:Pattern='Solid'/> "
	cXml += CRLF + "    <NumberFormat ss:Format='Fixed'/> "
	cXml += CRLF + "   </Style> "
	cXml += CRLF + "   <Style ss:ID='s69'> "
	cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Bottom'/> "
	cXml += CRLF + "    <Interior ss:Color='#B89875' ss:Pattern='Solid'/> "
	cXml += CRLF + "    <NumberFormat ss:Format='Short Date'/> "
	cXml += CRLF + "   </Style> "
	cXml += CRLF + "   <Style ss:ID='s70'> "
	cXml += CRLF + "    <Alignment ss:Horizontal='Left' ss:Vertical='Bottom'/> "
	cXml += CRLF + "    <Font ss:FontName='Calibri' x:Family='Swiss' ss:Size='18' ss:Color='#000000' "
	cXml += CRLF + "     ss:Bold='1'/> "
	cXml += CRLF + "    <Interior ss:Color='#B89875' ss:Pattern='Solid'/> "
	cXml += CRLF + "   </Style> "
	cXml += CRLF + "   <Style ss:ID='s71'> "
	cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Bottom'/> "
	cXml += CRLF + "    <Font ss:FontName='Calibri' x:Family='Swiss' ss:Size='18' ss:Color='#000000' "
	cXml += CRLF + "     ss:Bold='1'/> "
	cXml += CRLF + "    <Interior ss:Color='#B89875' ss:Pattern='Solid'/> "
	cXml += CRLF + "   </Style> "
	cXml += CRLF + "   <Style ss:ID='s72'> "
	cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Bottom'/> "
	cXml += CRLF + "    <Font ss:FontName='Calibri' x:Family='Swiss' ss:Size='11' ss:Color='#000000' "
	cXml += CRLF + "     ss:Bold='1'/> "
	cXml += CRLF + "   </Style> "
	cXml += CRLF + "   <Style ss:ID='s73'> "
	cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Bottom'/> "
	cXml += CRLF + "    <Borders/> "
	cXml += CRLF + "    <Font ss:FontName='Calibri' x:Family='Swiss' ss:Size='11' ss:Color='#000000'/> "
	cXml += CRLF + "    <Interior/> "
	cXml += CRLF + "    <NumberFormat/> "
	cXml += CRLF + "    <Protection/> "
	cXml += CRLF + "   </Style> "
	cXml += CRLF + "   <Style ss:ID='s74'> "
	cXml += CRLF + "    <Alignment ss:Horizontal='Left' ss:Vertical='Center'/> "
	cXml += CRLF + "   </Style> "
	cXml += CRLF + "   <Style ss:ID='s75'> "
	cXml += CRLF + "    <Alignment ss:Horizontal='Center' ss:Vertical='Center'/> "
	cXml += CRLF + "    <NumberFormat ss:Format='Short Date'/> "
	cXml += CRLF + "   </Style> "
	cXml += CRLF + "  </Styles> "
	cXml += CRLF + "  <Worksheet ss:Name='Clientes_Supermercados'> "
	cXml += CRLF + "   <Table ss:ExpandedColumnCount='23' ss:ExpandedRowCount='9999' x:FullColumns='1' "
	cXml += CRLF + "    x:FullRows='1' ss:DefaultRowHeight='15'> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:AutoFitWidth='0' ss:Width='97.5'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='43.5'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='28.5'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='85.5'/> "
	cXml += CRLF + "    <Column ss:StyleID='s63' ss:Width='221.25'/> "
	cXml += CRLF + "    <Column ss:StyleID='s63' ss:Width='158.25'/> "
	cXml += CRLF + "    <Column ss:StyleID='s63' ss:Width='296.25'/> "
	cXml += CRLF + "    <Column ss:StyleID='s64' ss:Width='129'/> "
	cXml += CRLF + "    <Column ss:StyleID='s65' ss:Width='151.5'/> "
	cXml += CRLF + "    <Column ss:StyleID='s65' ss:Width='39'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='68.25'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:AutoFitWidth='0' ss:Width='133.5'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='51'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='49.5'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='27'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='67.5'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='88.5'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='62.25'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='84'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='63.75'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='87'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='63'/> "
	cXml += CRLF + "    <Column ss:StyleID='s62' ss:Width='96'/> "
	cXml += CRLF + "    <Row ss:AutoFitHeight='0' ss:Height='6.75'> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s67'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s67'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s67'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s68'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s69'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "    </Row> "
	cXml += CRLF + "    <Row ss:AutoFitHeight='0' ss:Height='23.25'> "

	cXml += CRLF + Iif(Alltrim(MV_PAR01) == Alltrim('10107'),;
		"<Cell ss:StyleID='s70'><Data ss:Type='String'>       Cadastro Clientes - Supermercados</Data></Cell>",;
		"<Cell ss:StyleID='s70'><Data ss:Type='String'>       Cadastro Clientes</Data></Cell>")

	cXml += CRLF + "     <Cell ss:StyleID='s71'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s71'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s67'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s67'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s67'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s68'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s69'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "    </Row> "
	cXml += CRLF + "    <Row ss:AutoFitHeight='0' ss:Height='6'> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s67'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s67'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s67'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s68'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s69'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s66'/> "
	cXml += CRLF + "    </Row> "
	cXml += CRLF + "    <Row ss:AutoFitHeight='0'> "
	cXml += CRLF + "     <Cell ss:Index='11' ss:StyleID='s65'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
	cXml += CRLF + "     <Cell ss:StyleID='s65'/> "
	cXml += CRLF + "    </Row> "
	cXml += CRLF + "    <Row ss:AutoFitHeight='0'> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>TAG</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Codigo</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Loja</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>"+EncodeUtf8('CNPJ/CPF')+"</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Nome</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>N Fantasia</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Endereco</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Complemento</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Bairro</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Estado</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Cd.Municipio</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Municipio</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>CEP</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Natureza</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>DDD</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Telefone</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Ins. Estad.</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Tipo</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>C. Contabil</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Cond. Pagto</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Descri Cond Pgto</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Grupo vend</Data></Cell> "
	cXml += CRLF + "     <Cell ss:StyleID='s72'><Data ss:Type='String'>Descri Grupo Vend</Data></Cell> "
	cXml += CRLF + "    </Row> "

	For nX := 1 To Len(aDados)
		cCgc := Iif(Len(EncodeUtf8(aDados[nX,04]))>11,Transform(EncodeUtf8(aDados[nX,04]),"@R 99.999.999/9999-99"),;
				Transform(EncodeUtf8(aDados[nX,04]),"@R 999.999.999-99"))

		cXml += CRLF + "    <Row ss:AutoFitHeight='0'> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,01])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,02])+"</Data></Cell> "
		cXml += CRLF + "     <Cell ss:StyleID='s73'><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,03])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+cCgc+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,05])+"</Data></Cell> "
		cXml += CRLF + "     <Cell ss:StyleID='s74'><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,06])+"</Data></Cell> "
		cXml += CRLF + "     <Cell ss:StyleID='s74'><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,07])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,08])+"</Data></Cell> "
		cXml += CRLF + "     <Cell ss:StyleID='s75'><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,09])+"</Data></Cell> "
		cXml += CRLF + "     <Cell ss:StyleID='s75'><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,10])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,11])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,12])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,13])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,14])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,15])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,16])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,17])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,18])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,19])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,20])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,21])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,22])+"</Data></Cell> "
		cXml += CRLF + "     <Cell><Data ss:Type='String'>"+EncodeUtf8(aDados[nX,23])+"</Data></Cell> "
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
	cXml += CRLF + "      <ActiveRow>5</ActiveRow> "
	cXml += CRLF + "     </Pane> "
	cXml += CRLF + "    </Panes> "
	cXml += CRLF + "    <ProtectObjects>False</ProtectObjects> "
	cXml += CRLF + "    <ProtectScenarios>False</ProtectScenarios> "
	cXml += CRLF + "   </WorksheetOptions> "
	cXml += CRLF + "  </Worksheet> "
	cXml += CRLF + " </Workbook> "

    cDirTmp := cGetFile('*.csv|*.csv','Selecionar um diretório para salvar',1,'C:\',.F.,nOR(GETF_LOCALHARD,GETF_LOCALFLOPPY,GETF_RETDIRECTORY),.T.,.T.)

Return cXml
