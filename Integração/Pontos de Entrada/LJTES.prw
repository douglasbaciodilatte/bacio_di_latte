#Include 'Protheus.ch'

User Function LJTES()

Local _lRet		:= .T.	//Returno sempre .T. para gravar o Financeiro
Local _cQry		:= ""
Local _cAlias	:= GetNextAlias()
Local _aArea	:= GetArea()
Local _aAreaSE5	:= SE5->( GetArea() )

ConOut("LJTES - Filial: " + SL1->L1_FILIAL + " Documento: " + SL1->L1_DOC + "/" +SL1->L1_SERIE )

_cQry := "SELECT E5.R_E_C_N_O_ RECSE5,E1_AGEDEP,E1_CONTA FROM " + RetSqlName("SE1") + " E1"
_cQry += " INNER JOIN " + RetSqlName("SE5") + " E5 ON E5_FILIAL = E1_FILIAL AND E5_PREFIXO = E1_PREFIXO	AND E5_NUMERO = E1_NUM"
_cQry += "   AND E5_PARCELA = E1_PARCELA AND E5_TIPO = E1_TIPO AND E5_NATUREZ = E1_NATUREZ AND E5_CLIFOR = E1_CLIENTE"
_cQry += "   AND E5_CLIENTE = E1_CLIENTE AND E5_LOJA = E1_LOJA AND E5_RECPAG = 'R' AND E5.D_E_L_E_T_ = ' '"
_cQry += " WHERE E1_FILIAL  = '" + xFilial("SE1")	+ "'"
_cQry += "   AND E1_FILORIG = '" + SL1->L1_FILIAL	+ "'"
_cQry += "   AND E1_NUM     = '" + SL1->L1_DOC		+ "'"
_cQry += "   AND E1_PREFIXO = '" + SL1->L1_SERIE	+ "'"
_cQry += "   AND E1_CLIENTE = '" + SL1->L1_CLIENTE	+ "'"
_cQry += "   AND E1_LOJA    = '" + SL1->L1_LOJA		+ "'"
_cQry += "   AND E1_TIPO    = 'R$'"
_cQry += "   AND E1.D_E_L_E_T_ = ' '"
DbUseArea(.T.,"TOPCONN",TcGenQry(,,ChangeQuery(_cQry)),_cAlias,.T.,.T.)
While !(_cAlias)->( Eof() )
	SE5->( dbGoTo( (_cAlias)->RECSE5 ) )
	
	ConOut("LJTES - Filial: " + SL1->L1_FILIAL + " Documento: " + SL1->L1_DOC + "/" +SL1->L1_SERIE +;
		   " Era Agencia/Conta: " + SE5->E5_AGENCIA + "/" + SE5->E5_CONTA +;
		   " Ficou Agencia/Conta: " + (_cAlias)->E1_AGEDEP + "/" + (_cAlias)->E1_CONTA)
	
	//Retira do saldo bancario o valor anterior
	AtuSalBco(SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_DTDISPO,SE5->E5_VALOR,"-")
	
	RecLock("SE5",.F.)
	SE5->E5_AGENCIA := (_cAlias)->E1_AGEDEP
	SE5->E5_CONTA	:= (_cAlias)->E1_CONTA
	SE5->( MsUnLock() )
	
	//Retira do saldo bancario o valor novo
	AtuSalBco(SE5->E5_BANCO,SE5->E5_AGENCIA,SE5->E5_CONTA,SE5->E5_DTDISPO,SE5->E5_VALOR,"+")	
	
	(_cAlias)->( dbSkip() )
End

(_cAlias)->( dbCloseArea() )

RestArea(_aArea)
RestArea(_aAreaSE5)

Return _lRet