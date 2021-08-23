#Include 'Protheus.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BACDM010  ºAutor  ³Elaine Mazaro       º Data ³  15/02/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que verifica se é uma Nota Fiscal de Transferencia e º±±
±±º          ³se a mesma pode ser excluida								  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio     												  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function BACDM010(_lExlui)

Local _lRet		:= .T.					//Variavel de controle para o retorno logico
Local _cAlias	:= GetNextAlias()		//Busca o proximo Alias disponivel
Local _cQry		:= ""					//Variavel de tratamento para o SELECT
Local _aArea	:= GetArea()			//Salva a Area atual
Local _aAreaSM0	:= SM0->( GetArea() )	//Salva a Area da tabela SM0 - Empresas
Local _aAreaSA2	:= SA2->( GetArea() )	//Salva a Area da tabela SA2 - Cadastro de Fornecedor
Local _cCPFCli	:= ""					//CPF do Cliente/Fornecedor
Local _cFilDest	:= ""					//Filial de Destino
Local _lTransf	:= .F.					//Determina se a NF é de Transferencia

Default _lExlui	:= .F.					//Define se exclui a Pre-Nota Fiscal ou se so valida

_cQry := "SELECT 1 FROM " + RetSqlName("SD2") + " D2"
_cQry += " INNER JOIN " + RetSqlName("SF4") + " F4 ON F4_FILIAL = '" + xFilial("SF4") + "' AND F4_CODIGO = D2_TES"
_cQry += "   AND F4_TRANFIL = '1' AND F4.D_E_L_E_T_ = ' '"
_cQry += " WHERE D2_FILIAL     = '" + xFilial("SD2") 	+ "'"
_cQry += "   AND D2_DOC        = '" + SF2->F2_DOC 		+ "'"
_cQry += "   AND D2_SERIE      = '" + SF2->F2_SERIE 	+ "'"
_cQry += "   AND D2_CLIENTE    = '" + SF2->F2_CLIENTE 	+ "'"
_cQry += "   AND D2_LOJA       = '" + SF2->F2_LOJA 		+ "'"
_cQry += "   AND D2.D_E_L_E_T_ = ' '"
dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQry),_cAlias,.F.,.T.)

//Caso exista registros entao a NF é de Transferencia   
If !(_cAlias)->( Eof() )
	_lTransf := .T.
EndIf

(_cAlias)->( dbCloseArea() )

If _lTransf
	//Verifica se a Nota Fiscal foi emitida para uma Empresa/Filial
	If SF2->F2_TIPO $ "DB"
		dbSelectArea("SA2")
		dbSetOrder(1)
		dbSeek( xFilial("SA2") + SF2->F2_CLIENTE + SF2->F2_LOJA )		
		_cCPFCli	:= Alltrim(SA2->A2_CGC)
	Else
		dbSelectArea("SA1")
		dbSetOrder(1)
		dbSeek( xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA )
		_cCPFCli	:= Alltrim(SA1->A1_CGC)
	EndIf

	//Busca a Filial 
	SM0->( dbGoTop() )
	While !SM0->( Eof() )
		If Alltrim(SM0->M0_CGC) == _cCPFCli
			_cFilDest := SM0->M0_CODFIL 	
			Exit
		EndIf
		SM0->( dbskip() )
	End
	
	RestArea(_aAreaSM0)
	
	If !Empty(_cFilDest)
		dbSelectArea("SA2")
		dbSetorder(3)
		If SA2->( dbSeek( xFilial("SA2") + SM0->M0_CGC ) )
			_cQry := "SELECT R_E_C_N_O_ RECSF1,F1_STATUS FROM " + RetSqlName("SF1")
			_cQry += " WHERE F1_FILIAL  = '" + _cFilDest 	+ "'"
			_cQry += "   AND F1_DOC     = '" + SF2->F2_DOC 	+ "'"
			_cQry += "   AND F1_SERIE   = '" + SF2->F2_SERIE+ "'"
			_cQry += "   AND F1_FORNECE = '" + SA2->A2_COD 	+ "'"
			_cQry += "   AND F1_LOJA    = '" + SA2->A2_LOJA	+ "'"
			_cQry += "   AND D_E_L_E_T_ = ' '"
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQry),_cAlias,.F.,.T.)
			
			If !(_cAlias)->( Eof() )
				If !Empty( (_cAlias)->F1_STATUS)
					MsgInfo("Pré-Nota Fiscal de Entrada já foi classificada no destino, por favor estornar a classificação antes.")
					_lRet := .F.
				Else
					If !BM012ExcPNFE(_cFilDest,(_cAlias)->RECSF1)
						_lRet := .F.
					Endif
				EndIf
			EndIf
			
			(_cAlias)->( dbCloseArea() )
		EndIf
	EndIf
EndIf

RestArea(_aArea)

Return _lRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BM012ExcPNFEºAutor³Elaine Mazaro       º Data ³  11/12/14   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que efetua a exclusao da Pre Nota Fiscal de Entrada  º±±
±±º          ³na filial de destino										  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Roma      												  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function BM012ExcPNFE(_cFilDest,_nRecSF1)

Local _aCabSF1	:= {}					//Cabecalho da Pre-NFE
Local _aItemSD1	:= {}					//Itens da Pre-NFE
Local _aArea	:= GetArea()			//Salva a Area Atual
Local _aAreaSF1	:= SF1->( GetArea() )	//Salva a Area da Tabela SF1 - Cabecalho da Nota Fiscal de Entrada
Local _aAreaSD1	:= SD1->( GetArea()	)	//Salva a Area da Tabela SD1 - Itens da Nota Fiscal de Entrada
Local _cSeekSF1	:= ""					//Chave de busca da tabela SF1
Local _cFilBkp	:= cFilAnt				//Backup da Filial Posicionada
Local _lRet		:= .T.					//Variavel que controla o retorno da funcao
Private lMsErroAuto	:= .F.				//Variavel usada no EXECAUTO para determinar se conseguiu ou nao excluir a Pre Nota Fiscal de Entrada

//Altera a Filial para a de destino para excluir a Pre Nota Fiscal de Entrada
cFilAnt	:= _cFilDest

dbSelectArea("SF1")
SF1->( dbGoTo( _nRecSF1 ) )

_aCabSF1	:= {{"F1_FILIAL"	,xFilial("SF1")	,Nil},;		//Filial
				{"F1_TIPO"		,SF1->F1_TIPO	,Nil},;		//Tipo da Nota Fiscal de Entrada
				{"F1_FORMUL" 	,SF1->F1_FORMUL	,Nil},;		// Formulario
				{"F1_DOC"		,SF1->F1_DOC	,Nil},;		//Numero da Nota Fiscal de Entrada
				{"F1_SERIE"		,SF1->F1_SERIE	,Nil},;		//Serie da Nota Fiscal de Entrada
				{"F1_FORNECE"	,SF1->F1_FORNECE,Nil},;		//Codigo do Fornecedor
				{"F1_LOJA"		,SF1->F1_LOJA	,Nil},;		//Loja do Fornecedor
				{"F1_EMISSAO"	,SF1->F1_EMISSAO,Nil},;		//Emissao da Nota Fiscal de Entrada
				{"F1_EST"		,SF1->F1_EST	,Nil},;		//Estado do Fornecedor
				{"F1_DTDIGIT"	,SF1->F1_DTDIGIT,Nil},;		//Data de Digitacao da Nota Fiscal de Entrada
				{"F1_ESPECIE"	,SF1->F1_ESPECIE,Nil},;		//Especie da Nota Fiscal de Entrada
				{"F1_RECBMTO"	,SF1->F1_RECBMTO,Nil}}		//Data do Recebimento da Nota Fiscal de Entrada

_cSeekSF1	:= xFilial("SD1") + SF1->F1_DOC + SF1->F1_SERIE + SF1->F1_FORNECE + SF1->F1_LOJA

dbSelectArea("SD1")
dbSetOrder(1)		//D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM
If SD1->( dbSeek( _cSeekSF1 ) )
	While !SD1->( Eof() ) .And. _cSeekSF1 == SD1->D1_FILIAL + SD1->D1_DOC + SD1->D1_SERIE + SD1->D1_FORNECE + SD1->D1_LOJA
		//Adiciona os dados da Nota Fiscal de Saida no Array para o EXECAUTO
		aAdd(_aItemSD1,{{"D1_FILIAL"	,SD1->D1_FILIAL		,Nil},;
						{"D1_ITEM"		,SD1->D1_ITEM		,Nil},;	
						{"D1_COD"		,SD1->D1_COD		,Nil},;
						{"D1_QUANT"		,SD1->D1_QUANT		,Nil},;
						{"D1_VUNIT"		,SD1->D1_VUNIT		,Nil},;
						{"D1_TOTAL"		,SD1->D1_TOTAL		,Nil},;
						{"D1_FORNECE"	,SD1->D1_FORNECE	,Nil},;
						{"D1_LOJA"		,SD1->D1_LOJA		,Nil},;
						{"D1_LOCAL"		,SD1->D1_LOCAL		,Nil},;
						{"D1_DOC"		,SD1->D1_DOC		,Nil},;
						{"D1_EMISSAO"	,SD1->D1_EMISSAO	,Nil},;
						{"D1_DTDIGIT"	,SD1->D1_DTDIGIT	,Nil},;
						{"D1_GRUPO"		,SD1->D1_GRUPO		,Nil},;
						{"D1_TP"		,SD1->D1_TP			,Nil},;
						{"D1_TIPO"		,SD1->D1_TIPO		,Nil},;
						{"D1_SERIE"		,SD1->D1_SERIE		,Nil},;
						{"D1_NFORI"		,SD1->D1_NFORI		,Nil},;
						{"D1_SERIORI"	,SD1->D1_SERIORI	,Nil},;
						{"D1_ITEMORI"	,SD1->D1_ITEMORI	,Nil},;
						{"D1_TESACLA"	,SD1->D1_TESACLA	,Nil}})
		SD1->( dbSkip() )
	End
EndIf

If Len(_aCabSF1) > 0 .And. Len(_aItemSD1) > 0
	//ExecAuto da Pre Nota Fiscal de Entrada
	MSExecAuto({|x,y,z| MATA140(x,y,z) },_aCabSF1,_aItemSD1,5)

	//Verifica se deu erro na exclusao da Pre Nota Fiscal de Entrada
	If lMsErroAuto
		_lRet := .F.
		MostraErro()
	EndIf
EndIf

//Restaura as areas salvas anteriormente
RestArea(_aArea)
RestArea(_aAreaSF1)
RestArea(_aAreaSD1)

cFilAnt := _cFilBkp

Return _lRet