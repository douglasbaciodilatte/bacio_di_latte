#Include 'Protheus.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BACDM020  ºAutor  ³Elaine Mazaro       º Data ³  15/02/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina que verifica se e possivel excluir a Pre Nota Fiscal º±±
±±º          ³de Entrada												  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio     												  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function BACDM020()

Local _lRet		:= .T.					//Variavel de controle
Local _aArea	:= GetArea()			//Salva a Area atual
Local _aAreaSM0	:= SM0->( GetArea() )	//Salva a Area da tabela SM0 - Empresas
Local _aAreaSA1	:= SA1->( GetArea() )	//Salva a Area da tabela SA1 - Cadastro de Cliente
Local _aAreaSA2	:= SA2->( GetArea() )	//Salva a Area da tabela SA2 - Cadastro de Fornecedor
Local _cCPFFor	:= Alltrim(GetAdvFVal("SA2","A2_CGC",xFilial("SA2") + SF1->F1_FORNECE + SF1->F1_LOJA,1,""))	//Verifica se a Nota Fiscal foi emitida para uma Empresa/Filial
Local _cFilOrig	:= ""					//Filial de Origem da Nota Fiscal
Local _cQry		:= ""					//Variavel para montar a QUERY
Local _cAlias	:= GetNextAlias()		//Proximo alias disponivel

//Busca a Filial do Fornecedor
SM0->( dbGoTop() )
While !SM0->( Eof() )
	If Alltrim(SM0->M0_CGC) == _cCPFFor .And. SM0->M0_CODIGO == cEmpAnt
		_cFilOrig := SM0->M0_CODFIL 	
		Exit
	EndIf
	SM0->( dbskip() )
End

RestArea(_aAreaSM0)

If !Empty(_cFilOrig)
	dbSelectArea("SA1")
	dbSetOrder(3)		//A1_FILIAL+A1_CGC
	If SA1->( dbSeek( xFilial("SA1") + SM0->M0_CGC ) )	
		_cQry := "SELECT 1 FROM " + RetSqlName("SF2")
		_cQry += " WHERE F2_FILIAL  = '" + _cFilOrig + "'"
		_cQry += "   AND F2_DOC     = '" + SF1->F1_DOC + "'"
		_cQry += "   AND F2_SERIE   = '" + SF1->F1_SERIE + "'"
		_cQry += "   AND F2_CLIENTE = '" + SA1->A1_COD + "'"
		_cQry += "   AND F2_LOJA    = '" + SA1->A1_LOJA + "'"
		_cQry += "   AND D_E_L_E_T_ = ' '"
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQry),_cAlias,.F.,.T.)
		
		//Caso exista registros entao a NF é de Transferencia
		If !(_cAlias)->( Eof() )
			MsgInfo("A Pré-Nota não poderá ser excluída, pois foi gerada a partir de uma transferência.")
			_lRet	:= .F.
		EndIf
		
		(_cAlias)->( dbCloseArea() )
	EndIf
EndIf

RestArea(_aArea)
RestArea(_aAreaSA1)
RestArea(_aAreaSA2)

Return _lRet