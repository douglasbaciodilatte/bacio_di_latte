#include 'protheus.ch'
#include 'parmtype.ch'

#DEFINE CRLF CHR(13) + CHR(10)

/*/{Protheus.doc} AGESTA01
//TODO  Função para permitir a inclusão de Ordens de Produção através de formulário,
em tela única, com parâmetros iguais, excetuando as quantidades.
Essas deverão ser informadas em coluna específica (quantidade).
@author henri
@since 30/01/2018
@version 1.0
@return ${return}, ${return_description}

@type function
/*/
User Function AGESTA01()

	Local _cPerg 	:= 'AGESTA01'
	Local _aParams	:= {}

	Private _lOk	:= .F.

	CriaSx1(_cPerg)

	If !Pergunte(_cPerg,.T.)
		Return
	EndIf

	aadd(_aParams, MV_PAR01)
	aadd(_aParams, MV_PAR02)
	aadd(_aParams, MV_PAR03)
	aadd(_aParams, MV_PAR04)
	aadd(_aParams, MV_PAR05)

	_aArray := TelaSC2(  _aParams  )
	If _lOk
		Processa({|| U_AGESTA02(  _aArray  )},'Processando','Gerando OP...')
	Endif
Return

/*/{Protheus.doc} TelaSC2
//TODO Tela de produtos selecionados para retornar um array para execauto de OP (MATA650).
@author Thiago
@since 01/02/2018
@version undefined
@type function
/*/
Static Function TelaSC2(_aParams)

	Local oFont
	Local oDlg
	Local oSize
	Local _nStyle 		:= GD_INSERT+GD_UPDATE+GD_DELETE
	Local _cLinOk 		:= "AllwaysTrue()"
	Local _cTudoOk 		:= "AllwaysTrue()"
	Local _nMax			:= 0
	Local _cFields		:= 'C2_PRODUTO.C2_UM.C2_QUANT.C2_LOCAL.C2_DATPRI.C2_DATPRF'
	Local _cTitulo		:= 'Geração de Ordem de Produção Automática'

	Private _aHeadCols	:= {}
	Private _oMsGD

	oSize := FwDefSize():New( .T. )
	oSize:lLateral  := .T. 
	oSize:AddObject( "DIALOG"	, 100, 100, .F., .T. )
	oSize:Process()

	oFont	:= TFont():New( "MS Sans Serif",0,-16,,.F.,0,,400,.F.,.F.,,,,,, )
	oDlg 	:= MSDialog():New(oSize:aWindSize[1],oSize:aWindSize[2],oSize:aWindSize[3],oSize:aWindSize[4],_cTitulo,,,.F.,,,,,,.T.,,,.T. )

	_aHeadCols 	:= MtHdCols(_cFields, _aParams)
	_nMax := len(_aHeadCols[2])

	_oMsGD := MsNewGetDados():New( oSize:aWindSize[1]+30,oSize:aWindSize[2]-5,oSize:aWindSize[3],oSize:aWindSize[4],_nStyle,;
	_cLinOk, _cTudoOk,, _aHeadCols[3],0,_nMax,,,'AllwaysTrue()',oDlg,_aHeadCols[1],_aHeadCols[2])

	oDlg:Activate(,,,.T.,,,EnchoiceBar(oDlg,{||_lOk:=.T.,oDlg:End()},{||oDlg:End()},,))

	_aArray := FiltCols(_aParams)

Return (_aArray)

/*/{Protheus.doc} MtHdCols
//TODO CHAMADA DE FUNÇÕES PARA CRIAR ESTRUTURA DO MSNEWGETDADOS
@author Thiago
@since 01/02/2018
@version undefined
@param _cFields, , descricao
@param _aParams, , descricao
@type function
/*/
Static Function MtHdCols(_cFields, _aParams)

	Local _aHeadCS 	 := Array(3)
	Local _aHeader 	 := MtHeader(_cFields)
	Local _aCols	 := MtCols(_cFields, _aHeader, _aParams)
	Local _aAlter	 := {}

	aadd(_aAlter,'C2_QUANT')

	_aHeadCS[1] := aClone(_aHeader)
	_aHeadCS[2] := aClone(_aCols)
	_aHeadCS[3] := aClone(_aAlter)

Return (_aHeadCS)

/*/{Protheus.doc} MtCols
//TODO MONTA ACOLS PARA APRESENTAR NA MSNEWGETDADOS
@author Thiago
@since 01/02/2018
@version undefined
@param _cFields, , descricao
@param _aHeader, , descricao
@param _aParams, , descricao
@type function
/*/
Static Function MtCols(_cFields, _aHeader, _aParams)
	Local _cAlias := ExecQry(_aParams)
	Local _aCols  := {}
	Local _nx

	While ! (_cAlias)->(Eof())

		Aadd(_aCols, Array(len(_aHeader)+1) )

		For _nx	:= 1 To len(_aHeader)
			If ( _aHeader[_nx][2] == 'C2_PRODUTO' )
				_aCols[Len(_aCols)][_nx] := (_cAlias)->COD

			ElseIf ( _aHeader[_nx][2] == 'B1_DESC' )
				_aCols[Len(_aCols)][_nx] := (_cAlias)->DESCR

			ElseIf ( _aHeader[_nx][2] == 'C2_UM' )
				_aCols[Len(_aCols)][_nx] := (_cAlias)->UM

			ElseIf ( _aHeader[_nx][2] == 'C2_QUANT' )
				_aCols[Len(_aCols)][_nx] := 0

			ElseIf ( _aHeader[_nx][2] == 'C2_LOCAL' )
				_aCols[Len(_aCols)][_nx] := _aParams[3]

			ElseIf ( _aHeader[_nx][2] == 'C2_DATPRI' )
				_aCols[Len(_aCols)][_nx] := _aParams[1]

			ElseIf ( _aHeader[_nx][2] == 'C2_DATPRF' )
				_aCols[Len(_aCols)][_nx] := _aParams[2]

			EndIf

		Next
		_aCols[Len(_aCols)][len(_aHeader)+1] := .F.

		(_cAlias)->(DbSkip())
	End

	if len(_aCols) == 0

		Aadd(_aCols,Array(len(_aHeader)+1))

		For _nx	:= 1 To len(_aHeader)

			_aCols[Len(_aCols)][_nx] := CriaVar(_aHeader[_nx][2])

		Next
		_aCols[Len(_aCols)][len(_aHeader)+1] := .F.

	Endif

Return (_aCols)

/*/{Protheus.doc} ExecQry
//TODO QUERY PARA FILTRAR OS PRODUTOS NO RANGE DE... ATE...
@author Thiago
@since 01/02/2018
@version undefined
@param _aParams, , descricao
@type function
/*/
Static Function ExecQry(_aParams)

	Local _cDoProd	:= _aParams[4]
	Local _cAteProd := _aParams[5]
	Local _cAlias 	:= GetNextAlias()

	BeginSql Alias _cAlias
	SELECT DISTINCT COD, DESCR, UM
	FROM(
	SELECT B1_COD COD, B1_UM UM, B1_DESC DESCR
	FROM %Table:SB1% (NOLOCK)
	WHERE %NotDel%
	AND B1_MSBLQL = '2'
	AND B1_XPRDLOJ = '1'
	AND SUBSTRING(B1_DESC,1,6) = 'GELATO'
	AND RIGHT(RTRIM(LTRIM(B1_DESC)),4) = 'LOJA'
	AND B1_COD BETWEEN %Exp:_cDoProd% AND %Exp:_cAteProd%
	) SB1

	INNER JOIN(
	SELECT G1_COD
	FROM %Table:SG1% (NOLOCK)
	WHERE %NotDel%
	) SG1

	ON COD = G1_COD

	ORDER BY DESCR

	EndSql

	(_cAlias)->(dbGoTop())

Return (_cAlias)

/*/{Protheus.doc} MtHeader
//TODO MONTA HEADER
@author Thiago
@since 01/02/2018
@version undefined
@param _cFields, , descricao
@type function
/*/
Static Function MtHeader(_cFields)
	Local _aHeader 	:= {}
	Local _cAlias	:= 'SC2'
	Local _aArea	:= ''

	SX3->(dbSetOrder(1))
	SX3->(dbSeek(_cAlias))

	While !SX3->(Eof()) .And. (SX3->X3_ARQUIVO == _cAlias )

		if  AllTrim(SX3->X3_CAMPO)$_cFields

			AADD(_aHeader,{ AllTrim(SX3->X3_TITULO),	AllTrim(SX3->X3_CAMPO),SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",,SX3->X3_TIPO,,SX3->X3_CONTEXT} )

			If AllTrim(SX3->X3_CAMPO) == 'C2_PRODUTO'
				_aArea := SX3->(GetArea())
				SX3->(dbSetOrder(2))
				If SX3->(dbSeek('B1_DESC'))
					AADD(_aHeader,{ AllTrim(SX3->X3_TITULO),AllTrim(SX3->X3_CAMPO),SX3->X3_PICTURE,SX3->X3_TAMANHO,SX3->X3_DECIMAL,"",,SX3->X3_TIPO,,SX3->X3_CONTEXT} )
				EndIf
				RestArea(_aArea)
			EndIf

		Endif

		SX3->(dbSkip())

	End

Return (_aHeader)

/*/{Protheus.doc} FiltCols
//TODO FILTRA VETOR ANTES DE MANDAR PARA O EXECAUTO
@author Thiago
@since 01/02/2018
@version undefined

@type function
/*/
Static Function FiltCols(_aParams)
	Local _cNum		:= ''
	Local _aArrayAux:= {}
	Local _aArray 	:= {}
	Local _aHeader 	:= _aHeadCols[1]
	Local _aCols 	:= _oMsGD:aCols
	Local _nPosDel	:= Len(_aHeader) + 1
	Local _nx, _ny, _nPQuant, _nPProd

	For _nx := 1 to Len(_aCols)
		If _aCols[_nx,_nPosDel] == .F.
			aadd(_aArrayAux, _aCols[_nx])
		EndIf
	Next

	For _ny := 1 to Len(_aArrayAux)

		_nPProd 	:= aScan(_aHeader, {|x| AllTrim(x[2]) == 'C2_PRODUTO'})
		_nPQuant 	:= aScan(_aHeader, {|x| AllTrim(x[2]) == 'C2_QUANT'})

		_cNum := CriaVar('C2_NUM')

		If Empty(_cNum)
			_cNum := GetSxeNum('SC2')
		Else
			_cNum := ''
			SC2->(RollBackSxe())
		EndIf

		aAdd(_aArray,{xFilial('SC2'),;		//	C2_FILIAL
		_cNum,;					//	C2_NUM
		'01',;								//	C2_ITEM
		'001',;								//	C2_SEQUEN
		_aArrayAux[_ny,_nPProd],;			//	C2_PRODUTO
		_aParams[3],;						//	C2_LOCAL
		_aArrayAux[_ny,_nPQuant],;			//	C2_QUANT
		_aParams[1],;						//	C2_DATPRI
		_aParams[2],;						//	C2_DATPRF
		'F',;								//	C2_TPOP
		'I',;								//	C2_TPPR
		})

	Next

Return (_aArray)

/*/{Protheus.doc} CriaSX1
//TODO Descrição auto-gerada.
@author henri
@since 20/01/2018
@version 1.0
@return ${return}, ${return_description}
@param _cPerg, , descricao
@type function
/*/
Static Function CriaSX1(_cPerg)

	Local _aArea 	:= GetArea()
	Local aRegs 	:= {}
	Local _i
	Local _nMes 	:= month(dDataBase)
	Local _nProxMes := month(dDataBase) +1
	Local _nAno		:= year(dDataBAse)
	Local _nProxAno	:= year(dDataBAse)
	Local _dPrevIni, _dEntrega, _cLocal

	if _nProxMes == 13

		_nProxMes := 1
		_nProxAno += 1

	Endif

	_dPrevIni := '01/'+StrZero(_nMes,2)+'/'+cvaltochar(_nAno)
	_dEntrega  := dToC( ctod('01/'+StrZero(_nProxMes,2)+'/'+cvaltochar(_nProxAno)  ) -1)

	_cLocal := GetLocal()

	dbSelectArea("SX1")
	dbSetOrder(1)

	_cPerg := padr(_cPerg,len(SX1->X1_GRUPO))

	Aadd(aRegs,{_cPerg,"01" ,"Previsão Inicial "		,"mv_ch1" ,"D" ,08						,0, "G","mv_par01","","","","","","","NaoVazio()",_dPrevIni})
	Aadd(aRegs,{_cPerg,"02" ,"Entrega "					,"mv_ch2" ,"D" ,08						,0, "G","mv_par02","","","","","","","NaoVazio()",_dEntrega})
	Aadd(aRegs,{_cPerg,"03" ,"Código Armazém "			,"mv_ch3" ,"C" ,TamSx3('NNR_CODIGO')[1]	,0, "G","mv_par03","NNR","","","","","","NaoVazio()",_cLocal})
	Aadd(aRegs,{_cPerg,"04" ,"Produto Inicial "			,"mv_ch4" ,"C" ,TamSx3('B1_COD')[1]		,0, "G","mv_par04","_xSB1","","","","","","",""})
	Aadd(aRegs,{_cPerg,"05" ,"Produto Final "			,"mv_ch5" ,"C" ,TamSx3('B1_COD')[1]	,0, "G","mv_par05","_xSB1","","","","","",""          ,"zzzzzzzzz"})

	DbSelectArea("SX1")
	DbSetOrder(1)

	For _i := 1 To Len(aRegs)
		If  !DbSeek(aRegs[_i,1]+aRegs[_i,2])
			RecLock("SX1",.T.)
			Replace X1_GRUPO   with aRegs[_i,01]
			Replace X1_ORDEM   with aRegs[_i,02]
			Replace X1_PERGUNT with aRegs[_i,03]
			Replace X1_VARIAVL with aRegs[_i,04]
			Replace X1_TIPO	   with aRegs[_i,05]
			Replace X1_TAMANHO with aRegs[_i,06]
			Replace X1_PRESEL  with aRegs[_i,07]
			Replace X1_GSC	   with aRegs[_i,08]
			Replace X1_VAR01   with aRegs[_i,09]
			Replace X1_F3	   with aRegs[_i,10]
			Replace X1_DEF01   with aRegs[_i,11]
			Replace X1_DEF02   with aRegs[_i,12]
			Replace X1_DEF03   with aRegs[_i,13]
			Replace X1_DEF04   with aRegs[_i,14]
			Replace X1_DEF05   with aRegs[_i,15]
			Replace X1_VALID   with aRegs[_i,16]
			Replace X1_CNT01   with aRegs[_i,17]
			MsUnlock()

		Else
			Reclock("SX1",.F.)
			Replace X1_CNT01   with aRegs[_i,17]
			MsUnlock()
		EndIF
	Next _i

	RestArea(_aArea)

Return

/*/{Protheus.doc} GetLocal
//TODO O usuário deve informar o armazém para inclusão da OP cadastrado na tabela NNR,
deve iniciar o parâmetro com o armazém da loja na tabela SGQ.
É possível localizar o armazém pelo usuário logado através do índice 5
@author henri
@since 30/01/2018
@version 1.0
@return ${return}, ${return_description}

@type function
/*/
Static Function GetLocal()
	Local _cLocal := ''

	SGQ->(dbOrderNickName('SGQUSER'))

	if SGQ->(dbSeek(xfilial()+__cUserId))
		_cLocal := SGQ->GQ_LOCAL
	Endif

Return(_cLocal)