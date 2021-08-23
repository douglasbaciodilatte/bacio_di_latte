#Include 'Protheus.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณIT250VL2  บAutor  ณMicrosiga           บ Data ณ  06/26/17   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPonto de Entrada no Motor de integracao para tratar ARRAY doบฑฑ
ฑฑบ          ณEXECAUTO													  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Motor de Integracao										  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function IT250VL()

Local _cQry		:= ""
Local _cAlias	:= GetNextAlias()
Local _aArea	:= GetArea()
Local _dData	:= _aTabRet[aScan(_aTabRet,{|x| Alltrim(x[1]) == "E5_DATA"}	)	][2]
Local _cMoeda	:= Alltrim(_aTabRet[aScan(_aTabRet,{|x| Alltrim(x[1]) == "E5_MOEDA"})	][2])
Local _cNaturez	:= Alltrim(_aTabRet[aScan(_aTabRet,{|x| Alltrim(x[1]) == "E5_NATUREZ"})	][2])
Local _cBanco	:= Alltrim(_aTabRet[aScan(_aTabRet,{|x| Alltrim(x[1]) == "E5_BANCO"})	][2])
Local _cAgencia	:= Alltrim(_aTabRet[aScan(_aTabRet,{|x| Alltrim(x[1]) == "E5_AGENCIA"})	][2])
Local _cConta	:= Alltrim(_aTabRet[aScan(_aTabRet,{|x| Alltrim(x[1]) == "E5_CONTA"})	][2])
Local _cRecPag	:= Alltrim(_aTabRet[aScan(_aTabRet,{|x| Alltrim(x[1]) == "E5_RECPAG"})	][2])
Local _cNumCheq	:= IIF(aScan(_aTabRet,{|x| Alltrim(x[1]) == "E5_NUMCHEQ"}) == 0 ,"",Alltrim(_aTabRet[aScan(_aTabRet,{|x| Alltrim(x[1]) == "E5_NUMCHEQ"})][2]))
Local _cDocumen	:= IIF(aScan(_aTabRet,{|x| Alltrim(x[1]) == "E5_DOCUMEN"}) == 0 ,"",Alltrim(_aTabRet[aScan(_aTabRet,{|x| Alltrim(x[1]) == "E5_DOCUMEN"})][2]))
Local _cFilOrig	:= Alltrim(_aTabRet[aScan(_aTabRet,{|x| Alltrim(x[1]) == "E5_FILORIG"})	][2])
Local _nPCCusto	:= aScan(_aTabRet,{|x| Alltrim(x[1]) == "E5_CCUSTO"})
Local _cFilial	:= ""
Local _cPDV		:= ""
Local _cDoc		:= ""

If _cBanco == "CXA" .And. _cAgencia == "CXA" .And. _cConta == "CXA"
	_cDoc := IIF(Empty(_cNumCheq),_cDocumen,_cNumCheq)
	
	_cQry := "SELECT PIJ_AGENCI,PIJ_CONTA FROM " + RetSqlName("PIJ")
	_cQry += " WHERE PIJ_FILIAL = '" + xFilial("PIJ") + "'"
	_cQry += "   AND D_E_L_E_T_ = ' '"
	_cQry += "   AND PIJ_DATA   = '" + dTos(_dData) + "'"
	_cQry += "   AND PIJ_MOEDA  = '" + _cMoeda 		+ "'"
	_cQry += "   AND PIJ_NATURE = '" + _cNaturez 	+ "'"
	_cQry += "   AND PIJ_BANCO  = '" + _cBanco 		+ "'"
	_cQry += "   AND (PIJ_DOCUME = '" + _cDoc + "' OR PIJ_NUMCHE = '" + _cDoc + "')"
	_cQry += "   AND PIJ_RECPAG = '" + IIF(_cRecPag == "P","R","P") + "'"
	_cQry += "   AND PIJ_FILORI	= '" + _cFilOrig + "'"
	_cQry += "   AND PIJ_CONTA <> 'CXA'"
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,_cQry),_cAlias,.F.,.T.)
	If !(_cAlias)->( Eof() )
		_cFilial:= (_cAlias)->PIJ_AGENCI
		_cPDV	:= (_cAlias)->PIJ_CONTA		
	EndIf
	
	(_cAlias)->( dbCloseArea() )
Else
	_cFilial:= _cAgencia
	_cPDV	:= _cConta
EndIf

If !Empty(_cFilial) .And. !Empty(_cPDV)
	_cQry := "SELECT Z2_CC FROM " + RetSqlName("SZ2")
	_cQry += " WHERE Z2_FILIAL = '" + _cFilial + "'"
	_cQry += "   AND Z2_CONTA  = '" + _cPDV + "'"
	_cQry += "   AND D_E_L_E_T_ = ' '"
	dbUseArea(.T.,"TOPCONN",TCGENQRY(,,_cQry),_cAlias,.F.,.T.)
	If !(_cAlias)->( Eof() )
		If _nPCCusto > 0
			_aTabRet[_nPCCusto][2] := (_cAlias)->Z2_CC
		Else
			aAdd(_aTabRet,{"E5_CCUSTO",(_cAlias)->Z2_CC,NIL})
		EndIf
	EndIf
	(_cAlias)->( dbCloseArea() )
EndIf

Return