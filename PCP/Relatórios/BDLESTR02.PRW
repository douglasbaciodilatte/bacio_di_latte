#include 'protheus.ch'
#include 'parmtype.ch'

/*/{Protheus.doc} BDLESTR02
@author Renan Paiva
@since 24/04/2018
@version 1.0B
@description Relatorio para imprimir o CMV dos 3 meses 
			 a contar do periodo selecionado pelo usuário por empresa
			 é necessário que o usuário tenha acesso a todas as empresas para emitir o relatório
/*/
user function BDLESTR02()

local _oReport
private _cPerg := "BDLESTR02 "
private _cAlias := GetNextAlias()      
private _oTable
private _aPeriodos := {}
private _cOldFil := cFilAnt
private _cFilOperEst := SuperGetMv("MV_XFOPEST",.F.,"0031") //parametro com a filial dos estoques operacionais (fabrica e cd) locais que não são pontos de venda e que tenham estoque
private _cCstOperEst := SuperGetMv("MV_XAOPEST",.F.,"800003;800004") //parametro com o armazem dos estoques operacionais (fabrica e cd) locais que não são pontos de venda e que tenham estoque

//Valida se o TReport está habilitado
if TRepInUse()          
	AdjSx1(_cPerg)   
	Pergunte(_cPerg, .T.)
	_oReport := ReportDef()
	_oReport:PrintDialog()
else
	MsgInfo("TREPORT","Relatório disponível somente em TREPORT")
endIf

return

/*/{Protheus.doc} ReportDef
@author Renan Paiva
@since 25/04/2018
@description Funcao para configurar o relatório
@return objeto, treport
/*/
static function ReportDef()

local _oReport
local _oSection1
local _oSection2
local _aMeses := {"JAN/", "FEV/", "MAR/", "ABR/", "MAI/", "JUN/", "JUL/", "AGO/", "SET/", "OUT/", "NOV/", "DEZ/"}
local _dData := stod(alltrim(str(MV_PAR06)) + right("0" + alltrim(str(MV_PAR05)),2) + "01")
local _cPictQtd := pesqpict("SB9", "B9_QINI")
local _cPictVlr := pesqpict("SB9", "B9_VINI1")       
local _cFile := GetTempPath() + "\" + Trim(_cPerg) + ".xml"
                                
//1º periodo
aadd(_aPeriodos, {_dData, lastday(_dData), _aMeses[month(_dData)] + alltrim(str(MV_PAR06))})
//2º periodo
_dData := lastday(_dData) + 1
aadd(_aPeriodos, {_dData, lastday(_dData), _aMeses[month(_dData)] + alltrim(str(MV_PAR06))})
//3º periodo
_dData := lastday(_dData) + 1
aadd(_aPeriodos, {_dData, lastday(_dData), _aMeses[month(_dData)] + alltrim(str(MV_PAR06))})

_oReport := TReport():New(_cPerg,"CMV Período: " + _aPeriodos[1][3] + " - " + _aPeriodos[3][3],_cPerg,{|oReport| PrintReport(oReport)},"Este relatório exibirá os itens das notas fiscais por centro de custo conforme os parametros definidos pelo usuário")

//Seta o relatorio para paisagem
_oReport:SetLandscape()

_oSection1 := TRSection():New(_oReport,OemToAnsi("Centro de Custo"),{_cAlias})	

TRCell():New(_oSection1,"CCUSTO", _cAlias, "CCusto", "@!")
TRCell():New(_oSection1,"DSCCUST", _cAlias, "Descrição", "@!")
TRCell():New(_oSection1,"TIPOFIL", _cAlias, "Tp Loja", "@!")
TRCell():New(_oSection1,"PRODUTO", _cAlias, "Produto")
TRCell():New(_oSection1,"B1_DESC", , "Desc. Prod")
TRCell():New(_oSection1,"TIPOPROD", _cAlias, "Tp")
//1º periodo
TRCell():New(_oSection1,"QTDESTINI1", _cAlias, "| " + _aPeriodos[1][3] + CRLF + "| Qtd Est Ini", _cPictQtd)
TRCell():New(_oSection1,"QTDCOMPR1", _cAlias, "Qtd Comp", _cPictQtd)
TRCell():New(_oSection1,"QTDESTFIM1", _cAlias, "Qtd Est Fim", _cPictQtd)
TRCell():New(_oSection1,"CSTESTINI1", _cAlias, "Cust Est Ini", _cPictVlr)   
TRCell():New(_oSection1,"CSTCOMPR1", _cAlias, "Cust Comp Ini", _cPictVlr)
TRCell():New(_oSection1,"CSTESTFIM1", _cAlias, "Cust Est Fim", _cPictVlr)   
TRCell():New(_oSection1,"CSTUNIT1", , "Custo Unit.", _cPictVlr)   
TRCell():New(_oSection1,"CMV1", _cAlias, "CMV", _cPictVlr)
TRCell():New(_oSection1,"DESVIO1", _cAlias, "Desvio", _cPictVlr)
TRCell():New(_oSection1,"MEDIA1", _cAlias, "Media", _cPictVlr)
TRCell():New(_oSection1,"MEDIANA1", _cAlias, "Mediana", _cPictVlr)
TRCell():New(_oSection1,"DIFF1", , "Dif. Mediana %", _cPictVlr)
//2º periodo
TRCell():New(_oSection1,"QTDESTINI2", _cAlias, "| " + _aPeriodos[2][3] + CRLF + "| Qtd Est Ini", _cPictQtd)
TRCell():New(_oSection1,"QTDCOMPR2", _cAlias, "Qtd Comp", _cPictQtd)
TRCell():New(_oSection1,"QTDESTFIM2", _cAlias, "Qtd Est Fim", _cPictQtd)
TRCell():New(_oSection1,"CSTESTINI2", _cAlias, "Cust Est Ini", _cPictVlr)   
TRCell():New(_oSection1,"CSTCOMPR2", _cAlias, "Cust Comp Ini", _cPictVlr)
TRCell():New(_oSection1,"CSTESTFIM2", _cAlias, "Cust Est Fim", _cPictVlr)
TRCell():New(_oSection1,"CSTUNIT2", , "Custo Unit.", _cPictVlr)   
TRCell():New(_oSection1,"CMV2", _cAlias, "CMV", _cPictVlr)
TRCell():New(_oSection1,"DESVIO2", _cAlias, "Desvio", _cPictVlr)
TRCell():New(_oSection1,"MEDIA2", _cAlias, "Media", _cPictVlr)
TRCell():New(_oSection1,"MEDIANA2", _cAlias, "Mediana", _cPictVlr)
TRCell():New(_oSection1,"DIFF2", , "Dif. Mediana %", _cPictVlr)
//3º periodo
TRCell():New(_oSection1,"QTDESTINI3", _cAlias, "| " + _aPeriodos[3][3] + CRLF + "| Qtd Est Ini", _cPictQtd)
TRCell():New(_oSection1,"QTDCOMPR3", _cAlias, "Qtd Comp", _cPictQtd)
TRCell():New(_oSection1,"QTDESTFIM3", _cAlias, "Qtd Est Fim", _cPictQtd)
TRCell():New(_oSection1,"CSTESTINI3", _cAlias, "Cust Est Ini", _cPictVlr)   
TRCell():New(_oSection1,"CSTCOMPR3", _cAlias, "Cust Comp Ini", _cPictVlr)
TRCell():New(_oSection1,"CSTESTFIM3", _cAlias, "Cust Est Fim", _cPictVlr)   
TRCell():New(_oSection1,"CSTUNIT3", , "Custo Unit.", _cPictVlr)   
TRCell():New(_oSection1,"CMV3", _cAlias, "CMV", _cPictVlr)
TRCell():New(_oSection1,"DESVIO3", _cAlias, "Desvio", _cPictVlr)
TRCell():New(_oSection1,"MEDIA3", _cAlias, "Media", _cPictVlr)
TRCell():New(_oSection1,"MEDIANA3", _cAlias, "Mediana", _cPictVlr)    
TRCell():New(_oSection1,"DIFF3", , "Dif. Mediana %", _cPictVlr)

return _oReport
      
/*/{Protheus.doc} ReportDef
@author Renan Paiva
@since 25/04/2018
@description Funcao para impressão do relatório
/*/
static function PrintReport(_oReport)

local _oSection1 	:= _oReport:Section(1) //Inicializa a primeira sessao do treport 
local _cCCusto		:= ""
local _nRetTot		:= ""
//carrega os dados
MSAguarde( {|| xGetData()}, "Aguarde" ,"Obtendo dados ...",.F.)

//DEFINE O CODEBLOCK PARA PREENCHER O CAMPO B1_DESC EM TEMPO DE EXECUÇÃO
_oSection1:Cell("B1_DESC"  ):SetBlock({ || getadvfval("SB1","B1_DESC",xFilial("SB1") + (_cAlias)->PRODUTO,1,"") })
_oSection1:Cell("DIFF1"):SetBlock({ || (_cAlias)->CMV1 / (_cAlias)->MEDIANA1 * 100 } )
_oSection1:Cell("DIFF2"):SetBlock({ || (_cAlias)->CMV2 / (_cAlias)->MEDIANA2 * 100 } )
_oSection1:Cell("DIFF3"):SetBlock({ || (_cAlias)->CMV3 / (_cAlias)->MEDIANA3 * 100 } )
_oSection1:Cell("CSTUNIT1"):SetBlock({ || (_cAlias)->(CSTESTINI1 + CSTCOMPR1 + CSTESTFIM1) / (_cAlias)->(QTDESTINI1 + QTDCOMPR1 + QTDESTINI1) } )
_oSection1:Cell("CSTUNIT2"):SetBlock({ || (_cAlias)->(CSTESTINI2 + CSTCOMPR2 + CSTESTFIM2) / (_cAlias)->(QTDESTINI2 + QTDCOMPR2 + QTDESTINI2) } )
_oSection1:Cell("CSTUNIT3"):SetBlock({ || (_cAlias)->(CSTESTINI3 + CSTCOMPR3 + CSTESTFIM3) / (_cAlias)->(QTDESTINI3 + QTDCOMPR3 + QTDESTINI3) } )
//FAZ A QUEBRA POR CENTRO DE CUSTO
_oBreak1 := TRBreak():New(_oSection1,{||(_cAlias)->(CCUSTO)},"Total Centro de Custo",.F.) 
//TOTAL FINAL/ SOMENTE CMV
_oBreak2 := TRBreak():New(_oSection1,{||(_cAlias)->(EOF())},"Total Centro de Custo",.F.) 

//1º PERIODO
TRFunction():New(_oSection1:Cell("CSTESTINI1"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("CSTCOMPR1"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("CSTESTFIM1"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("CMV1"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("DESVIO1"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("MEDIANA1"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("DIFF1"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
//2º PERIODO
TRFunction():New(_oSection1:Cell("CSTESTINI2"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("CSTCOMPR2"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("CSTESTFIM2"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("CMV2"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("DESVIO2"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("MEDIANA2"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("DIFF2"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
//3º PERIODO
TRFunction():New(_oSection1:Cell("CSTESTINI3"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("CSTCOMPR3"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("CSTESTFIM3"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("CMV3"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("DESVIO3"),NIL,"SUM",_oBreak1,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("MEDIANA3"),NIL,"SUM",_oBreak1,,,,.F.,.F.) 
TRFunction():New(_oSection1:Cell("DIFF3"),NIL,"SUM",_oBreak1,,,,.F.,.F.)

TRFunction():New(_oSection1:Cell("CMV1"),NIL,"SUM",_oBreak2,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("CMV2"),NIL,"SUM",_oBreak2,,,,.F.,.F.)
TRFunction():New(_oSection1:Cell("CMV3"),NIL,"SUM",_oBreak2,,,,.F.,.F.)
dbSelectArea(_cAlias)
dbSetOrder(1)//CCusto + Tp Prod + Produto
dbGoTop()      

_oSection1:Print()

_oTable:delete()
return

/*/{Protheus.doc} xGetData
@author Renan Paiva
@since 24/04/2018
@description Funcao para Obter os dados utilizados no relatorio
/*/
static function xGetData()
                   
local _cAlias1Tmp := GetNextAlias()
local _cFilExp := "% ("
local _aSM0	:= {}
local _aData1Per := {}
locaL _aData2Per := {}
local _aData3Per := {}
local _cTipoFil := ""
local _cCCusto := ""
local _cFilial := ""
local _cProduto := ""
local _nCusto := 0
local _nRecno := 0
local _a1Mediana := {}
local _a2Mediana := {}
local _a3Mediana := {}
local _aEstatist := {}
//Cria tabela temporaria no banco de dados utilizando a função FWTemporaryTable
xCriaTmp()

//carrega todas as empresas e filiais que o usuário tem acesso, se .T. carrega inclusive as sem acesso
_aSM0 := fwempload(.F.) 

//remove os dados de outras empresas
for i := 1 to len(_aSM0)
	if _aSM0[i][1] == cEmpAnt .And. _aSM0[i][3] >= MV_PAR01 .And. _aSM0[i][3] <= MV_PAR02
		_cFilExp += "'" + _aSM0[i][3] + "',"
	endif
next

//remove a ultima virgula e adiciona o ) para fechar o in e o % para o parser nao add '
_cFilExp := left(_cFilExp, len(_cFilExp) - 1) + ") %"  

BeginSql Alias _cAlias1Tmp
	%noparser%
	SELECT NNR_FILIAL, NNR_CODIGO, NNR_DESCRI, B1_COD, B1_TIPO 
	FROM %table:NNR% A
	JOIN %table:CTT% B
	ON A.NNR_FILIAL IN %exp:_cFilExp%
	AND A.NNR_CODIGO = CTT_CUSTO   
	AND A.NNR_CODIGO BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
	AND A.NNR_CODIGO != ''
	AND A.%notdel%
	AND B.%notdel%
	JOIN %table:SB1% C
	ON C.B1_TIPO IN ('PA','PI','MP','EM')
	AND C.%notdel%  
	JOIN %table:SB2% D
	ON B2_FILIAL = NNR_FILIAL
	AND B2_COD = B1_COD
	AND B2_LOCAL = NNR_CODIGO
	AND D.%notdel%
	ORDER BY NNR_FILIAL, NNR_CODIGO, B1_TIPO, B1_COD
EndSql

dbSelectArea(_cAlias1Tmp)
	
while !Eof()
	RecLock(_cAlias,.T.)
	(_cAlias)->FILIAL	:= (_cAlias1Tmp)->NNR_FILIAL
	(_cAlias)->PRODUTO	:= (_cAlias1Tmp)->B1_COD
	(_cAlias)->TIPOPROD	:= (_cAlias1Tmp)->B1_TIPO
	(_cAlias)->CCUSTO	:= (_cAlias1Tmp)->NNR_CODIGO
	(_cAlias)->DSCCUST	:= (_cAlias1Tmp)->NNR_DESCRI 
	(_cAlias)->(MsUnLock())
	dbSelectArea(_cAlias1Tmp)
	dbSkip()
enddo
     
_cFilial := (_cAlias)->FILIAL
if cFilAnt != _cFilial
	xTrocaFil((_cAlias)->FILIAL)		
endif                         
dbSelectArea(_cAlias)
dbGoTop()
while !eof()       
	_aData1Per := xGetDtPer((_cAlias)->PRODUTO, (_cAlias)->CCUSTO, _aPeriodos[1][1], _aPeriodos[1][2])
	_aData2Per := xGetDtPer((_cAlias)->PRODUTO, (_cAlias)->CCUSTO, _aPeriodos[2][1], _aPeriodos[2][2])
	_aData3Per := xGetDtPer((_cAlias)->PRODUTO, (_cAlias)->CCUSTO, _aPeriodos[3][1], _aPeriodos[3][2])
	if _cFilial != (_cAlias)->FILIAL
		_cFilial := (_cAlias)->FILIAL
		xTrocaFil((_cAlias)->FILIAL)		
	endif
	if _cCCusto != (_cAlias)->CCUSTO
		_cCCusto := (_cAlias1Tmp)->NNR_CODIGO
		do case
			case left((_cAlias)->CCUSTO,2) == "30"
				_cTipoFil := "K"
			case ALLTRIM((_cAlias)->CCUSTO) == "800002"
				_cTipoFil := "FAB"
			case ALLTRIM((_cAlias)->CCUSTO) == "800003"
				_cTipoFil := "CDC"
			case xIsLjProd((_cAlias)->CCUSTO, _aPeriodos[1][1])
				_cTipoFil := "SP"
			otherwise
				_cTipoFil := "S"
		endcase	
	endif	       
	_nCusto := 0
	//Soma os custos para ver se houve movimentacao no periodo para o produto
	aEval(_aData1Per, {|x| _nCusto += x}, 4)
	aEval(_aData2Per, {|x| _nCusto += x}, 4)
	aEval(_aData3Per, {|x| _nCusto += x}, 4)
	
	reclock(_cAlias, .F.)
	//se nao houve movimentacao avança para o proximo registro
	if _nCusto == 0
		dbDelete()
		(_cAlias)->(MsUnlock())
		(_cAlias)->(dbSkip())
		loop
	end
	(_cAlias)->TIPOFIL	:= _cTipoFil		
	(_cAlias)->PERIODO1	:= _aPeriodos[1][3]
	(_cAlias)->QTDESTINI1:= _aData1Per[1]
	(_cAlias)->QTDCOMPR1 := _aData1Per[2]
	(_cAlias)->QTDESTFIM1 :=_aData1Per[3]
	(_cAlias)->CSTESTINI1 :=_aData1Per[4]
	(_cAlias)->CSTCOMPR1 := _aData1Per[5]
	(_cAlias)->CSTESTFIM1 :=_aData1Per[6]
	(_cAlias)->CMV1		  :=_aData1Per[6] - (_aData1Per[4] + _aData1Per[5])
	
	(_cAlias)->PERIODO2	:= _aPeriodos[2][3]
	(_cAlias)->QTDESTINI2:= _aData2Per[1]
	(_cAlias)->QTDCOMPR2 := _aData2Per[2]
	(_cAlias)->QTDESTFIM2 :=_aData2Per[3]
	(_cAlias)->CSTESTINI2 :=_aData2Per[4]
	(_cAlias)->CSTCOMPR2 := _aData2Per[5]
	(_cAlias)->CSTESTFIM2 :=_aData2Per[6]
	(_cAlias)->CMV2		  :=_aData2Per[6] - (_aData2Per[4] + _aData2Per[5])
	
	(_cAlias)->PERIODO3	:= _aPeriodos[3][3]
	(_cAlias)->QTDESTINI3:= _aData3Per[1]
	(_cAlias)->QTDCOMPR3 := _aData3Per[2]
	(_cAlias)->QTDESTFIM3 :=_aData3Per[3]
	(_cAlias)->CSTESTINI3 :=_aData3Per[4]
	(_cAlias)->CSTCOMPR3 := _aData3Per[5]
	(_cAlias)->CSTESTFIM3 :=_aData3Per[6]
	(_cAlias)->CMV3		  :=_aData3Per[6] - (_aData3Per[4] + _aData3Per[5])
	
	(_cAlias)->(MsUnLock())   
	dbSelectArea(_cAlias)
	(_cAlias)->(dbSkip())
enddo

(_cAlias)->(__dbPack())
//Restaura a filial original
xTrocaFil(_cOldFil)

//Realiza o calculo do Desvio Padrao e das Medianas do CMV
dbSelectArea(_cAlias)
dbSetOrder(2) //Produto + Tipo Loja
dbGoTop()
while !eof()
	_cProduto := (_cAlias)->PRODUTO
	_cTipoFil := (_cAlias)->TIPOFIL
	_a1Mediana := {}
	_a2Mediana := {}
	_a3Mediana := {}
	_aEstatist := {}
	_nRecno := (_cAlias)->(Recno())
	while !eof() .And. _cProduto == (_cAlias)->PRODUTO .AND. _cTipoFil == (_cAlias)->TIPOFIL
		if (_cAlias)->CMV1 != 0
			aadd(_a1Mediana, (_cAlias)->CMV1)
		endif
		if (_cAlias)->CMV2 != 0
			aadd(_a2Mediana, (_cAlias)->CMV2)
		endif
		if (_cAlias)->CMV3 != 0
			aadd(_a3Mediana, (_cAlias)->CMV3)
		endif
		dbSkip()
	enddo             
	
	aadd(_aEstatist, xEstatistica(_a1Mediana))
	aadd(_aEstatist, xEstatistica(_a2Mediana))
	aadd(_aEstatist, xEstatistica(_a3Mediana))
	
	dbSelectArea(_cAlias)
	(_cAlias)->(dbGoTo(_nRecno))
	while !eof() .And. _cProduto == (_cAlias)->PRODUTO .AND. _cTipoFil == (_cAlias)->TIPOFIL
		reclock(_cAlias, .F.)//alteração
		(_cAlias)->DESVIO1 	:= _aEstatist[1][2]
		(_cAlias)->MEDIANA1 := _aEstatist[1][1] 
		(_cAlias)->MEDIA1	:= _aEstatist[1][3]
		
		(_cAlias)->DESVIO2 	:= _aEstatist[2][2]
		(_cAlias)->MEDIANA2	:= _aEstatist[2][1]
		(_cAlias)->MEDIA2	:= _aEstatist[2][3]
		
		(_cAlias)->DESVIO3	:= _aEstatist[3][2]
		(_cAlias)->MEDIANA3	:= _aEstatist[3][1]
		(_cAlias)->MEDIA3	:= _aEstatist[3][3]
		(_cAlias)->(msunlock())
		dbskip()
	enddo
	
enddo
return            
/*/{Protheus.ch} xStatistica
@author Renan Paiva
@since 26/04/2018
@description Funcao para calcular a mediana e o desvio padrao
@param _aMediana, Array, [1]mediana, [2]desvio padrao, [3] média
/*/
static function xEstatistica(_aMediana)
local _nMedio := 0
local _nCusto := 0
local _aRet := {}

//calcula as medianas	
if !empty(_aMediana)
	//ordena o array para calcular a 1 mediana
	aSort(_aMediana,,,{|x,y| x < y })
	_nMeio := iif(noround((len(_aMediana)) / 2, 0) != 0, noround((len(_aMediana)) / 2, 0), 1)
	if len(_aMediana) % 2 == 0			
		aadd(_aRet,(_aMediana[_nMeio] + _aMediana[_nMeio + 1] ) / 2 )
	else
		aadd(_aRet, _aMediana[_nMeio] )
	endif			
else
	aadd(_aRet, 0 )
endif      

//calcula os desvios
//desvio 1 periodo
_nCusto := 0
_nSumSqrt := 0
aeval(_aMediana, {|x| _nCusto += x})
_nMedia := _nCusto / len(_aMediana)
aeval(_aMediana, {|x| _nSumSqrt += (x - _nMedia)^2 })
//exponencial de 1/2 equivale a raiz quadrada, a funcao sqrt so calcula numeros positivos nao alterar
aadd( _aRet,_nMedia / len(_aMediana) ^ 1/2 )

//add média
aadd(_aRet, _nMedia)

return _aRet

/*/{Protheus.doc} xIsLjProd
@author Renan Paiva
@since 24/04/2018
@description Funcao para classificar a loja, determinando se há produção ou não no local
@param _cLocal, , Local (Armazém)
@param _dData, , Data Inicio do Periodo p Pesquisa
@return logico, retorna .T. caso exista produção no armazém
/*/
static function xIsLjProd(_cLocal, _dData)

local _cTmpAlias := GetNextAlias()
local _dDataIni := _dData - 30
local _dDataFim := _dData + 120
local _lRet := .T.

beginsql alias _cTmpAlias
	SELECT TOP 1 *
	FROM %table:SD3%
	WHERE D3_FILIAL = %xFilial:SD3%
	AND D3_LOCAL = %exp:_cLocal%
	AND D3_EMISSAO BETWEEN %exp:_dDataIni% AND %exp:_dDataFim%
	AND D3_OP != ''
	AND %notdel%
endsql

dbSelectArea(_cTmpAlias)
_lRet := !eof()
(_cTmpAlias)->(dbCloseArea())

return _lRet

/*/{Protheus.doc} xCriaTmp
@author Renan Paiva
@since 24/04/2018
@description Rotina para a criação de tabela temporária no banco de dados
/*/
static function xCriaTmp()

local _aCpos := {}

aAdd(_aCpos, {"FILIAL","C", TamSX3("B1_FILIAL")[1], 0})
aAdd(_aCpos, {"TIPOFIL","C", 3, 0})
aAdd(_aCpos, {"PRODUTO", "C", TamSX3("B1_COD")[1], 0})
aAdd(_aCpos, {"TIPOPROD","C", TamSX3("B1_TIPO")[1], 0})
aAdd(_aCpos, {"CCUSTO","C", TamSX3("CTT_CUSTO")[1], 0})
aadd(_aCpos, {"DSCCUST", "C", TamSX3("NNR_DESCRI")[1], 0})
//Periodo 1
aAdd(_aCpos, {"PERIODO1", "C", 8, 0})        
//Quantidades do Periodo 1
aAdd(_aCpos, {"QTDESTINI1","N",TamSX3("B9_QINI")[1], TamSX3("B9_QINI")[2]})
aAdd(_aCpos, {"QTDCOMPR1","N",TamSX3("D1_QUANT")[1], TamSX3("D1_QUANT")[2]})           
aAdd(_aCpos, {"QTDESTFIM1","N",TamSX3("B9_QINI")[1], TamSX3("B9_QINI")[2]})
//Valores do Periodo 1
aAdd(_aCpos, {"CSTESTINI1","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
aAdd(_aCpos, {"CSTCOMPR1","N",TamSX3("D1_CUSTO")[1], TamSX3("D1_CUSTO")[2]})           
aAdd(_aCpos, {"CSTESTFIM1","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
//CMV Periodo 1
aAdd(_aCpos, {"CMV1","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
aAdd(_aCpos, {"DESVIO1","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
aAdd(_aCpos, {"MEDIA1","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
aAdd(_aCpos, {"MEDIANA1","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
//Periodo 2
aAdd(_aCpos, {"PERIODO2", "C", 8, 0})        
//Quantidades do Periodo 2
aAdd(_aCpos, {"QTDESTINI2","N",TamSX3("B9_QINI")[1], TamSX3("B9_QINI")[2]})
aAdd(_aCpos, {"QTDCOMPR2","N",TamSX3("D1_QUANT")[1], TamSX3("D1_QUANT")[2]})           
aAdd(_aCpos, {"QTDESTFIM2","N",TamSX3("B9_QINI")[1], TamSX3("B9_QINI")[2]})
//Valores do Periodo 2
aAdd(_aCpos, {"CSTESTINI2","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
aAdd(_aCpos, {"CSTCOMPR2","N",TamSX3("D1_CUSTO")[1], TamSX3("D1_CUSTO")[2]})           
aAdd(_aCpos, {"CSTESTFIM2","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
//CMV Periodo 2
aAdd(_aCpos, {"CMV2","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
aAdd(_aCpos, {"DESVIO2","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
aAdd(_aCpos, {"MEDIA2","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
aAdd(_aCpos, {"MEDIANA2","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
//Periodo 3
aAdd(_aCpos, {"PERIODO3", "C", 8, 0})        
//Quantidades do Periodo 3
aAdd(_aCpos, {"QTDESTINI3","N",TamSX3("B9_QINI")[1], TamSX3("B9_QINI")[2]})
aAdd(_aCpos, {"QTDCOMPR3","N",TamSX3("D1_QUANT")[1], TamSX3("D1_QUANT")[2]})           
aAdd(_aCpos, {"QTDESTFIM3","N",TamSX3("B9_QINI")[1], TamSX3("B9_QINI")[2]})
//Valores do Periodo 3
aAdd(_aCpos, {"CSTESTINI3","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
aAdd(_aCpos, {"CSTCOMPR3","N",TamSX3("D1_CUSTO")[1], TamSX3("D1_CUSTO")[2]})           
aAdd(_aCpos, {"CSTESTFIM3","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
//CMV Periodo 3
aAdd(_aCpos, {"CMV3","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
aAdd(_aCpos, {"DESVIO3","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
aAdd(_aCpos, {"MEDIA3","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})
aAdd(_aCpos, {"MEDIANA3","N",TamSX3("B9_VINI1")[1], TamSX3("B9_VINI1")[2]})

_oTable := FWTemporaryTable():New(_cAlias, _aCpos)     
_oTable:AddIndex("01",{"FILIAL","CCUSTO","TIPOPROD","PRODUTO"})
_oTable:AddIndex("02",{"PRODUTO","TIPOFIL"})
_oTable:Create()                                         

return

/*/{Protheus.doc} xTrocaFil
@author Renan Paiva
@since 24/04/2018
@description Funcao para trocar a filial corrente permitindo a 
			 obtencao dos dados de todas as filiais
@param _cFilial, Caractere, Filial que o sistema deve ser setado
/*/
static function xTrocaFil(_cFilial)
OpenSM0() //Abrir Tabela SM0 (Empresa/Filial)
dbSelectArea("SM0") //Abro a SM0
SM0->(dbSetOrder(1))
SM0->(dbSeek(cEmpAnt + _cFilial,.T.)) //Posiciona Empresa
cEmpAnt := SM0->M0_CODIGO //Seto as variaveis de ambiente
cFilAnt := SM0->M0_CODFIL
OpenFile( cEmpAnt + _cFilial) //Abro a empresa que eu desejo trabalhar
return

/*/{Protheus.doc} xGetDtPer
@author Renan Paiva
@since 24/04/2018
@description Funcao que retorna os dados para o calculo do CMV
@param _cProd, caractere , Produto
@param _cLocal, caractere, Local (Armazém)
@param _dDataIni, data, Data Inicio Periodo
@param _dDataFim, data, Data Fim Periodo
/*/
static function xGetDtPer(_cProd, _cLocal, _dDataIni, _dDataFim)

Local _aRet := {}
Local _cTmpD1Alias := GetNextAlias()
Local _cTmpD2Alias := GetNextAlias()
Local _aEstIni := CalcEst(_cProd, _cLocal, _dDataIni)
Local _aEstFim := CalcEst(_cProd, _cLocal, _dDataFim + 1)

beginsql alias _cTmpD1Alias        
	COLUMN D1_QUANT AS NUMERIC(18,2)
	COLUMN D1_CUSTO AS NUMERIC(18,2)
	SELECT SUM(D1_QUANT) D1_QUANT, SUM(D1_CUSTO) D1_CUSTO
	FROM %table:SD1% D1
	JOIN %table:SF4% F4
	ON D1_TES = F4_CODIGO
	AND D1_FILIAL = %xFilial:SD1%
	AND D1_COD = %exp:_cProd%
	AND D1_LOCAL = %exp:_cLocal%
	AND D1_DTDIGIT BETWEEN %exp:_dDataIni% AND %exp:_dDataFim%
	AND F4_ESTOQUE = 'S'
	AND (F4_DUPLIC = 'S' OR RIGHT(RTRIM(D1_CF),3) IN ('151','152','153','155','156')) //COMPUTA A ENTRADA DE COMPRAS E TRANSFERENCIAS
	AND D1.%notdel%
	AND F4.%notdel%
endsql


_aRet := {_aEstIni[1], (_cTmpD1Alias)->D1_QUANT, _aEstFim[1],_aEstIni[2], (_cTmpD1Alias)->D1_CUSTO,_aEstFim[2]}

(_cTmpD1Alias)->(dbCloseArea())
                        
//VERIFICA SE A FILIAL É UM ESTOQUE OPERACIONAL (FÁBRICA OU CD)
if xFilial() $ _cFilOperEst .or. _cLocal $ _cCstOperEst
	beginsql alias _cTmpD2Alias                                
		COLUMN D2_QUANT AS NUMERIC(18,2)
		COLUMN D2_CUSTO1 AS NUMERIC(18,2)
		SELECT SUM(D2_QUANT) D2_QUANT, SUM(D2_CUSTO1) D2_CUSTO1
		FROM %table:SD2%
		WHERE D2_FILIAL = %xFilial:SD2%
		AND D2_EMISSAO BETWEEN %exp:_dDataIni% AND %exp:_dDataFim%
		AND D2_LOCAL = %_exp:_cLocal%
		AND RIGHT(RTRIM(D2_CF), 3) IN ('151','152','153','155','156')
		AND %notdel%
	endsql
	_aRet[3] += (_cTmpD2Alias)->D2_QUANT
	_aRet[6] += (_cTmpD2Alias)->D2_CUSTO1
	(_cTmpD2Alias)->(dbCloseArea())
endif                      

return _aRet

/*/{Protheus.doc} AdjSx1
@author renan
@since 25/04/2018
@version undefined

@return return, return_description
@example
(examples)
@see (links_or_references)
/*/
static function AdjSx1(_cPerg)

Local _aPerg  := {}
Local _ni

Aadd(_aPerg,{"Filial De ?","mv_ch1","C",4,0,"G","","mv_par01","","","","SM0",""})
Aadd(_aPerg,{"Filial Até ?","mv_ch2","C",4,0,"G","","mv_par02","","","","SM0",""})
Aadd(_aPerg,{"C. Custo De ","mv_ch3","C",9,0,"G","","mv_par03","","","","CTT",""})
Aadd(_aPerg,{"C. Custo Até ?","mv_ch4","C",9,0,"G","","mv_par04","","","","CTT",""})
Aadd(_aPerg,{"Mês ?","mv_ch5","N",2,0,"G","","mv_par05","","","","",""})
Aadd(_aPerg,{"Ano ?","mv_ch6","N",4,0,"G","","mv_par06","","","","",""})    


dbSelectArea("SX1")
for _ni := 1 to len(_aPerg)
	if !dbSeek(_cPerg+StrZero(_ni,2))
		RecLock("SX1",.T.)
		SX1->X1_GRUPO    := _cPerg
		SX1->X1_ORDEM    := StrZero(_ni,2)
		SX1->X1_PERGUNT  := _aPerg[_ni][1]
		SX1->X1_PERSPA   := _aPerg[_ni][1]
		SX1->X1_PERENG   := _aPerg[_ni][1]
		SX1->X1_VARIAVL  := _aPerg[_ni][2]
		SX1->X1_TIPO     := _aPerg[_ni][3]
		SX1->X1_TAMANHO  := _aPerg[_ni][4]
		SX1->X1_DECIMAL  := _aPerg[_ni][5]
		SX1->X1_GSC      := _aPerg[_ni][6]
		SX1->X1_VALID	 := _aPerg[_ni][7]
		SX1->X1_VAR01    := _aPerg[_ni][8]
		SX1->X1_DEF01    := _aPerg[_ni][9]
		SX1->X1_DEFSPA1  := _aPerg[_ni][9]
		SX1->X1_DEFENG1  := _aPerg[_ni][9]
		SX1->X1_DEF02    := _aPerg[_ni][10]
		SX1->X1_DEFSPA2  := _aPerg[_ni][10]
		SX1->X1_DEFENG2  := _aPerg[_ni][10]
		SX1->X1_DEF03    := _aPerg[_ni][11]
		SX1->X1_DEFSPA3  := _aPerg[_ni][11]
		SX1->X1_DEFENG3  := _aPerg[_ni][11]
		SX1->X1_F3       := _aPerg[_ni][12]
		SX1->X1_CNT01    := _aPerg[_ni][13]
		MsUnLock()
	endif
next _ni

return