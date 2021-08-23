#Include 'Protheus.ch'

User Function LJ010SF3()

Local _cQry		:= ""
Local _cAlias	:= GetNextAlias()
Local _aArea	:= GetArea()
Local _aAreaSD2	:= SD2->( GetArea() )
Local _aArmPDV	:= {}
Local _cFiltro	:= ""

_cQry := "SELECT L2_XCCUSTO,D2_CCUSTO,D2.R_E_C_N_O_ RECSD2 FROM " + RetSqlName("SL2") + " L2"
_cQry += " INNER JOIN " + RetSqlName("SD2") + " D2 ON L2_FILIAL = D2_FILIAL AND L2_DOC = D2_DOC AND L2_SERIE = D2_SERIE"
_cQry += "        AND D2.D_E_L_E_T_ = ' ' AND D2_COD = L2_PRODUTO AND D2_ITEMPV = L2_ITEM"
_cQry += " WHERE L2_FILIAL     = '" + xFilial("SL2") 	+ "'"
_cQry += "   AND L2_NUM        = '" + SL1->L1_NUM 		+ "'"
_cQry += "   AND L2.D_E_L_E_T_ = ' '"
_cQry += "   AND L2_XCCUSTO   <> D2_CCUSTO"
_cQry += "   AND L2_XCCUSTO   <> ' '"  
DbUseArea( .T., "TOPCONN", TcGenQry(,,_cQry), _cAlias, .T., .F. )

dbSelectArea("SD2")

While !(_cAlias)->( Eof() )
	SD2->( dbGoTo( (_cAlias)->RECSD2 ) )
	
	RecLock("SD2",.F.)
	SD2->D2_CCUSTO := SL2->L2_XCCUSTO
	SD2->( MsUnLock() )

	(_cAlias)->( dbSkip() )
End

(_cAlias)->( dbCloseArea() )

RestArea(_aArea)
RestArea(_aAreaSD2)

//Filtra a tabela SA6 para que o titulo financeiro so retorne o caixa correto
//_aArmPDV := U_BACAA011(_cEstacao)                 					
/*==============================\
|	Elementos do array _aArmPDV	|
|_aArmPDV[1] - Deposito			|
|_aArmPDV[2] - Centro de Custo	| 
|_aArmPDV[3] - Conta Corrente	|
\==============================*/
/*
If Len(_aArmPDV) > 0
	dbSelectArea("SA6")
	SA6->( dbGoTop() )
	
	//Limpa o filtro
	SET FILTER TO
	
	_cFiltro := "A6_FILIAL = '" + xFilial("SA6") + "' .AND. A6_COD = '" + Alltrim(SL1->L1_OPERADO) + "' .AND. A6_AGENCIA = '" + Alltrim(cFilAnt) + "' .AND. A6_NUMCON = '" + Alltrim(_aArmPDV[3]) + "'"
	
	//Adiciona o novo filtro
	SET FILTER TO &(cFiltro)
	
	ConOut("LJ010SF3 - Recno: " + Alltrim( Str( SA6->( Recno() ) ) ) )
EndIf
*/
Return