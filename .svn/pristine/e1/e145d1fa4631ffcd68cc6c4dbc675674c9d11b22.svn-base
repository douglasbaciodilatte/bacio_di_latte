#Include 'Protheus.ch'

User Function IN210GL2()

Local _aItemSL	:= ParamIXB[1]
Local _nPos		:= 0
Local _cNum		:= ""
Local _cProd	:= ""
Local _cItem	:= ""

If ValType(_aItemSL) == "A"
	dbSelectArea("SL2")
	dbSetOrder(1)	//L2_FILIAL+L2_NUM+L2_ITEM+L2_PRODUTO

	_cNum	:= Alltrim(_aItemSL[aScan(_aItemSL,{|x| Alltrim(x[1]) == "L2_NUM" 		})][2])
	_cProd	:= Alltrim(_aItemSL[aScan(_aItemSL,{|x| Alltrim(x[1]) == "L2_PRODUTO"	})][2])
	_cItem	:= Alltrim(_aItemSL[aScan(_aItemSL,{|x| Alltrim(x[1]) == "L2_ITEM" 		})][2])

	If (_nPos := aScan(_aItemSL,{|x| Alltrim(x[1]) == "L2_LOCAL" })) > 0
		If SL2->( dbSeek( xFilial("SL2") + PadR(_cNum,TamSX3("L2_NUM")[1]) + PadR(_cItem,TamSX3("L2_ITEM")[1]) + PadR(_cProd,TamSX3("L2_PRODUTO")[1]) ) )
			If Alltrim(SL2->L2_LOCAL) <> Alltrim(_aItemSL[_nPos][2])
				RecLock("SL2",.F.)
				SL2->L2_LOCAL := Alltrim(_aItemSL[_nPos][2])
				SL2->( MsUnLock() )
			EndIf
		Endif
	EndIf
EndIf
Return