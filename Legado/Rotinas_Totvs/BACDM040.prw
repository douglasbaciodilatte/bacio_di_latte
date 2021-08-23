#Include 'Protheus.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BACDM040  ºAutor  ³Elaine Mazaro       º Data ³  11/12/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que gera a Pre Nota Fiscal de Entrada na filial de   º±±
±±º          ³destino em caso de Transferencia entre filiais			  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio      												  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function BACDM040(_lMsg)

Local _aArea		:= GetArea()							//Salva a Area Atual
Local _aAreaSM0		:= SM0->( GetArea() )					//Salva a Area da tabela SM0 - Empresas
Local _aAreaSA2		:= SA2->( GetArea() )					//Salva a Area da tabela SA2 - Cadastro de Fornecedor
Local _aAreaSD2		:= SD2->( GetArea() )					//Salva a Area da tabela SD2 - Itens da Nota Fiscal de Saida
Local _aAreaSC6		:= SC6->( GetArea() )					//Salva a Area da tabela SC6 - Itens Pedido
Local _aAreaSC9		:= SC9->( GetArea() )					//Salva a Area da tabela SC9 - Itens Liberados
Local _cCPFCli		:= ""									//CPF do Cliente/Fornecedor
Local _cLocal		:= ""									//Deposito para a Entrada do Produto
Local _cFilDest		:= ""									//Filial de Destino
Local _aCabSF1		:= {}									//Array com os dados do cabeçalho da Pre Nota Fiscal de Entrada
Local _aItemSD1		:= {}									//Array com os dados dos itens da Pre Nota Fiscal de Entrada
Local _cItem		:= Replicate("0",TamSX3("D1_ITEM")[1])	//Sequenciador de Item
Local _cSeekSF2		:= xFilial("SD2") + SF2->F2_DOC + SF2->F2_SERIE + SF2->F2_CLIENTE + SF2->F2_LOJA	//Chave de Pesquisa da tabela SF2
Local _cCondPg		:= ""									//Condicao de Pagamento
Local _cPedido		:= ""									//Numero do Pedido de Venda que gerou a Nota Fiscal
Local _lTransfer    := .t.									//Flag para mostrar se é transferencia
Local _cItemOri		:= ""
Local cAlias		:= GetNextAlias()
Local cQuery		:= ""
Local aStruSD2		:= {}
Local nI			:= 0
Local _lRet			:= .F.

Default _lMsg		:= .T.

//Verifica se a Nota Fiscal foi emitida para uma Empresa/Filial
If SF2->F2_TIPO $ "DB"
	_cCPFCli	:= Alltrim(GetAdvFVal("SA2","A2_CGC",xFilial("SA2") + SF2->F2_CLIENTE + SF2->F2_LOJA,1,""))
Else
	_cCPFCli	:= Alltrim(GetAdvFVal("SA1","A1_CGC",xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA,1,""))
EndIf

//Busca a Filial
SM0->( dbGoTop() )
While !SM0->( Eof() )
	If Alltrim(SM0->M0_CGC) == _cCPFCli
		_cFilDest := PadR(Alltrim(SM0->M0_CODFIL),Len(cFilAnt))
		Exit
	EndIf
	SM0->( dbskip() )
End

RestArea(_aAreaSM0)

cQuery := "SELECT * FROM " + RetSqlName("SD2")
cQuery += " WHERE D2_FILIAL  = '" + xFilial("SD2")	+ "' "
cQuery += "   AND D2_DOC     = '" + SF2->F2_DOC		+ "'"
cQuery += "   AND D2_SERIE   = '" + SF2->F2_SERIE	+ "'"
cQuery += "   AND D2_CLIENTE = '" + SF2->F2_CLIENTE	+ "'"
cQuery += "   AND D2_LOJA    = '" + SF2->F2_LOJA	+ "'"
cQuery += "   AND D_E_L_E_T_ = ' '"
cQuery += " ORDER BY D2_ITEM"
cQuery := ChangeQuery(cQuery)
dbUseArea(.T., 'TOPCONN', TCGenQry(,,cQuery),cAlias, .F., .T.)
aStruSD2 := SD2->(dbStruct())
For nI := 1 to len(aStruSD2)
	If ( aStruSD2[nI][2] $ 'DNL')
		TCSetField(cAlias,aStruSD2[ni,1], aStruSD2[ni,2],aStruSD2[ni,3],aStruSD2[ni,4])
	Endif
Next

If !(cAlias)->(Eof())
	While !(cAlias)->( Eof() )
		//Posiciona no cadastro do TES
		If SF4->( dbSeek( xFilial("SF4") + (cAlias)->D2_TES ) )
			If SF4->F4_TRANFIL <> "1"
				_lTransfer := .F.
				Exit
			EndIf
		EndIf
		(cAlias)->(DbSkip())
	End
Else
	_lTransfer := .f.
Endif

If _lTransfer
	dbSelectArea("SA2")
	dbSetorder(3)
	SA2->( dbGoTop() )
	If SA2->( dbSeek( xFilial("SA2") + SM0->M0_CGC ) )
		
		dbSelectArea("SC6")
		dbSetorder(1)	//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
		
		dbSelectArea("SF4")
		dbSetorder(1)
		
		dbSelectArea("SC9")
		dbSetOrder(2)	//C9_FILIAL+C9_CLIENTE+C9_LOJA+C9_PEDIDO+C9_ITEM
			
		(cAlias)->(DbGoTop())
		If !(cAlias)->(Eof())
			While !(cAlias)->( Eof() )
				//Posiciona no cadastro do TES
				If SF4->( dbSeek( xFilial("SF4") + (cAlias)->D2_TES ) )
					If SF4->F4_TRANFIL <> "1"
						_aItemSD1 := {}
						Exit
					EndIf
				EndIf
				
				//Posiciono no item do pedido de venda
				dbSeek( xFilial("SC6") + (cAlias)->D2_PEDIDO + (cAlias)->D2_ITEMPV + (cAlias)->D2_COD ) 
				
				//Realiza o tratamento do Item
				_cItem	:= Soma1(_cItem,TamSX3("D1_ITEM")[1])
				
				//Guarda o numero do Pedido para acrescentar informacoes no cabecalho da NFE
				_cPedido:= (cAlias)->D2_PEDIDO
				
				//Adiciona os dados da Nota Fiscal de Saida no Array para o EXECAUTO
				_cItemOri := fConvSerie((cAlias)->D2_ITEMORI,TamSX3("D2_ITEM")[1])
				
				//Busca o local (armazem destino) para o item de entrada
				_cLocal	:= SC6->C6_XLOCDES
				
				aAdd(_aItemSD1,{{"D1_FILIAL"	,_cFilDest				,Nil},;
				{"D1_ITEM"		,_cItem					,Nil},;
				{"D1_COD"		,(cAlias)->D2_COD		,Nil},;
				{"D1_QUANT"		,(cAlias)->D2_QUANT		,Nil},;
				{"D1_VUNIT"		,(cAlias)->D2_PRCVEN	,Nil},;
				{"D1_TOTAL"		,(cAlias)->D2_TOTAL		,Nil},;
				{"D1_FORNECE"	,SA2->A2_COD			,Nil},;
				{"D1_LOJA"		,SA2->A2_LOJA			,Nil},;
				{"D1_LOCAL"		,_cLocal				,Nil},;
				{"D1_DOC"		,(cAlias)->D2_DOC		,Nil},;
				{"D1_EMISSAO"	,(cAlias)->D2_EMISSAO	,Nil},;
				{"D1_DTDIGIT"	,(cAlias)->D2_EMISSAO	,Nil},;
				{"D1_GRUPO"		,(cAlias)->D2_GRUPO		,Nil},;
				{"D1_TP"		,(cAlias)->D2_TP		,Nil},;
				{"D1_TIPO"		,SF2->F2_TIPO			,Nil},;
				{"D1_SERIE"		,(cAlias)->D2_SERIE		,Nil},;
				{"D1_NFORI"		,(cAlias)->D2_NFORI		,Nil},;
				{"D1_SERIORI"	,(cAlias)->D2_SERIORI	,Nil},;
				{"D1_ITEMORI"	,_cItemOri				,Nil}})	 //(cAlias)->D2_ITEMORI
							
				(cAlias)->( dbSkip() )
			End
			
			_cCondPg	:= GetAdvFVal("SC5","C5_CONDPAG",xFilial("SC5") + _cPedido,1,"")
			_aCabSF1	:= {{"F1_FILIAL"	,_cFilDest		,Nil},;		//Filial
			{"F1_TIPO"		,SF2->F2_TIPO	,Nil},;		//Tipo da Nota Fiscal de Entrada
			{"F1_FORMUL" 	,"N"    		,Nil},;		// Formulario
			{"F1_DOC"		,SF2->F2_DOC	,Nil},;		//Numero da Nota Fiscal de Entrada
			{"F1_SERIE"		,SF2->F2_SERIE	,Nil},;		//Serie da Nota Fiscal de Entrada
			{"F1_FORNECE"	,SA2->A2_COD	,Nil},;		//Codigo do Fornecedor
			{"F1_LOJA"		,SA2->A2_LOJA	,Nil},;		//Loja do Fornecedor
			{"F1_EMISSAO"	,SF2->F2_EMISSAO,Nil},;		//Emissao da Nota Fiscal de Entrada
			{"F1_EST"		,SA2->A2_EST	,Nil},;		//Estado do Fornecedor
			{"F1_DTDIGIT"	,SF2->F2_EMISSAO,Nil},;		//Data de Digitacao da Nota Fiscal de Entrada
			{"F1_ESPECIE"	,"SPED"			,Nil},;		//Especie da Nota Fiscal de Entrada
			{"F1_COND"   	, _cCondPg		,Nil},;		//Condicao do Fornecedor
			{"F1_RECBMTO"	,SF2->F2_EMISSAO,Nil}}		//Data do Recebimento da Nota Fiscal de Entrada
		EndIf
		
		//Rotina que gera a Pre Nota Fiscal de Entrada na Filial de Recebimento
		If Len(_aCabSF1) > 0 .And. Len(_aItemSD1) > 0
			_lRet := BM011GeraPNFE(	_cFilDest		,_aCabSF1		,_aItemSD1	,SA2->A2_COD	,SA2->A2_LOJA,;
			SF2->F2_DOC		,SF2->F2_SERIE	,SF2->F2_CLIENTE,SF2->F2_LOJA,;
			SF2->F2_EMISSAO	,_lMsg			)
		EndIf
	EndIf
Endif

(cAlias)->(DbCloseArea())

RestArea(_aArea)
RestArea(_aAreaSA2)
RestArea(_aAreaSC6)
RestArea(_aAreaSD2)
RestArea(_aAreaSC9)
RestArea(_aAreaSM0)

Return _lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BM011GeraPNFEºAutor³Elaine Mazaro       ºData ³  11/12/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que gera a Nota Fiscal de Entrada na Filial de Desti-º±±
±±º          ³no														  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio        											  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function BM011GeraPNFE(	_cFilDest	,_aCabSF1	,_aItemSD1	,_cCodFor	,;
_cLojFor	,_cDoc		,_cSerie	,;
_cCliente	,_cLojCli	,_dEmissao	,_lMsg		)

Local _cFilBkp	:= cFilAnt							//Backup da Filial de Origem
Local _aArea	:= GetArea()						//Salva a Area atual
Local _aAreaSD1	:= SD1->( GetArea() )				//Salva a area da tabela SD1 - Itens da Nota Fiscal de Entrada

Private lMsErroAuto	:= .F.							//Variavel usada no EXECAUTO para determinar se conseguiu ou nao criar a Pre Nota Fiscal de Entrada

//Altera a Filial para a de detino
cFilAnt := _cFilDest

//ExecAuto da Pre Nota Fiscal de Entrada
MSExecAuto({|x,y,z| MATA140(x,y,z) },_aCabSF1,_aItemSD1,3)

//Retorna a Filial do Backup
cFilAnt	:= _cFilBkp

RestArea(_aArea)
RestArea(_aAreaSD1)

Return !lMsErroAuto

// Funcao para Converter a Serie
Static Function fConvSerie(cOrig,nTam)
Local cResult := cOrig
Local nCount := 0
Default cOrig := "0001"
Default nTam  := Len(cOrig)
If nTam <= 4 .And. Len(cOrig) <> nTam
	cSerOri := StrZero(0,Len(cOrig))
	cSerDes := StrZero(0,nTam)
	While cSerOri<>Repl("Z",Len(cSerOri)) .And. cSerDes<>Repl("Z",Len(cSerDes))
		nCount++
		cSerOri := Soma1(cSerOri)
		cSerDes := Soma1(cSerDes)
		If cSerOri=cOrig
			cResult := cSerDes
			Exit
		Endif
	Enddo
Endif

Return cResult

Return
