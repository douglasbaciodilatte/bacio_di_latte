#include 'protheus.ch'
#include 'parmtype.ch'

/*/{Protheus.doc} impinv
//Rotina para importação e analise do inventário consolidado
//das lojas
@author Renan Paiva
@since 16/07/2018
@return return, return_description
/*/
user function impinv()
local _oDLG
local _cFile := SPACE(500)
local _dMes := Stod("")
local _lOk := .F.
local _lCancel := .F.
local _oGetFile
local _oOk
local _oCancel

private _oProcess
 
while !_lOk .and. !_lCancel

	DEFINE DIALOG _oDLG  TITLE "Importar Inventario" FROM 0,0 TO 150, 450 PIXEL
	@ 10, 08 Say "Caminho Arquivo:" COLOR CLR_BLUE PIXEL
	@ 08, 55 MSGet _cFile Size 150, 10 PIXEL
	_oGetFile := TButton():New( 08, 210, "...",_oDlg,{||getFile(@_cFile)}, 10,12,,,.F.,.T.,.F.,,.F.,,,.F. ) 
	@ 30, 08 Say "Período:" COLOR CLR_BLUE PIXEL
	@ 28, 55 MSGet _dMes SIZE 60, 10 PIXEL HASBUTTON
	_oOk := TButton():New( 50, 135, "Ok",_oDlg,{||_lOk := .T., _oDlg:End()}, 40,12,,,.F.,.T.,.F.,,.F.,,,.F. )
	_oCancel := TButton():New( 50, 180, "Cancelar",_oDlg,{|| _lCancel := .T., _oDlg:End()}, 40,12,,,.F.,.T.,.F.,,.F.,,,.F. )
	ACTIVATE DIALOG _oDlg CENTERED 

	//faz a validação dos campos
	if _lOk
		if empty(_cFile) .or. empty(_dMes)
			MsgInfo("Todos os campos são obrigatórios verifique o preenchimento","OBRIGAT")
			_lOk := .F.
		endif 
		if !empty(_cFile) .and. !File(_cFile)
			MsgInfo("Arquivo não encontrado, verifique o caminho do arquivo informado", "INVALIDFILE")
			_lOk := .F.
		endif
	endif
	
	//caso os campos estejam ok processa
	if _lOk
		_oProcess := MsNewProcess():New({|lEnd| ProcInv(@lEnd, _cFile, _dMes)}, "Aguarde", "Importando Arquivo" , .T.)
		_oProcess:Activate()
	endif
enddo	
return

/*/{Protheus.doc} ProcInv
//rotina para processar o arquivo csv
@author Renan Paiva
@since 16/07/2018
/*/
static function ProcInv(lEnd, _cFile, _dMes)

local _nHdl := FT_FUse(AllTrim(_cFile))
local _nLinhas
local _cLinha := ""
local _aLinha := {}
local _cSep := ""
local _oTable
local _cAlias := ""

if _nHdl < 0
	MsgStop("Erro ao abrir o arquivo", "ERROROPENFILE")
	return
endif

_dMes := LastDay(_dMes)

//Conta a quantidade de linhas no arquivo
_nLinhas := FT_FLastRec()

_oProcess:SetRegua1(2)
_oProcess:SetRegua2(_nLinhas)

_oTable := criaArea()

FT_FGoTop()
while !FT_FEOF()
	_cLinha := FT_FReadLn()
	if empty(_cSep)
		do case
			case at(";", _cLinha) > 0
				_cSep := ";"
			case at(",", _cLinha) > 0
				_cSep := ","
		endcase
	endif
	_aLinha := StrTokArr2(_cLinha, _cSep)
	if !empty(_aLinha)
		insTmpTbl(_oTable, _aLinha[1], _aLinha[2], _aLinha[4], val(strtran(_aLinha[5],",",".")), _dMes)
	endif
	_oProcess:IncRegua2("Lendo Arquivo... ")
	FT_FSkip()
enddo

fClose(_nHdl)

_cAlias := _oTable:GetAlias()

_oProcess:SetRegua2(_nLinhas)
_oProcess:IncRegua1("Analisando SB7")
dbSelectArea("SB7") //INVENT EM + PRODUTO + ARMAZEM
dbSetOrder(1)

dbSelectArea(_cAlias)
while !eof()
	SB7->(dbSeek((_cAlias)->(FILIAL + DTOS(DTINV) + PRODUTO + ARMAZEM)))
	if found() .and. (_cAlias)->QTD2UM != SB7->B7_QTSEGUM
		reclock("SB7", .F.)
		SB7->B7_QUANT	:= ConvUm( (_cAlias)->PRODUTO,0,(_cAlias)->QTD2UM,1 )
		SB7->B7_QTSEGUM	:= (_cAlias)->QTD2UM
		msUnlock()		
	elseif .not. found()
		insSB7((_cAlias)->FILIAL, (_cAlias)->PRODUTO, (_cAlias)->ARMAZEM, (_cAlias)->DTINV, (_cAlias)->QTD2UM)		
	endif
	_oProcess:IncRegua2("Analisando Filial " + (_cAlias)->FILIAL)
	dbSelectArea(_cAlias)
	dbSkip()
enddo

_oTable:Delete()

return

/*/{Protheus.doc} insSB7
//Metodo para inserir registros na SB7 via execauto
@author Renan Paiva
@since 16/07/2018
/*/
static function insSB7(_cFilial, _cProd, _cLocal, _dData, _nQtd2UM)

local _aDadosB7 := {}
local _aDadosB9 := {}

private lMsErroAuto := .F.

//se necessário troca a filial
if cFilAnt != _cFilial
	xTrocaFil(_cFilial)		
endif                         

//Verifica se o produto esta bloqueado, caso sim realiza o desbloqueio
dbSelectArea("SB1")
dbSetOrder(1)
if !dbSeek(xFilial("SB1") + _cProd)
	return
endif

if SB1->B1_MSBLQL == '1'
	Reclock("SB1", .F.)
	SB1->B1_MSBLQL := '2'
	MsUnlock()
	msgInfo("Produto " + SB1->B1_COD + " - " + TRIM(SB1->B1_DESC) + " ### DESBLOQUEADO !!!","PRODESBLQ")
endif

//verifica se existe saldos iniciais
dbSelectArea("SB2")
dbSetOrder(1)
if !dbSeek(xFilial("SB2") + _cProd + _cLocal)
	aAdd(_aDadosB9, {"B9_FILIAL", xFilial("SB9") , NIL})
	aAdd(_aDadosB9, {"B9_COD", _cProd, NIL})
	aAdd(_aDadosB9, {"B9_LOCAL", _cLocal, NIL})
	aAdd(_aDadosB9, {"B9_QINI", 0, NIL})
	
	msExecAuto({|x, y| MATA220(x, y)}, _aDadosB9, 3)
	
	if lMsErroAuto
		mostraErro()
		return
	endif
endif

aAdd(_aDadosB7, {"B7_FILIAL", _cFilial, NIL})
aAdd(_aDadosB7, {"B7_COD", _cProd, NIL})
aAdd(_aDadosB7, {"B7_LOCAL", _cLocal, NIL})
aAdd(_aDadosB7, {"B7_QTSEGUM", _nQtd2UM, NIL})
aAdd(_aDadosB7, {"B7_DOC", "AUT"+LEFT(DTOS(_dData),6)})
aAdd(_aDadosB7, {"B7_DATA", _dData, NIL})

msExecAuto({|x, y, z| MATA270(x, y)}, _aDadosB7, .F., 3) //y = .f. contagem não será selecionada

if lMsErroAuto
	mostraErro()
endif

return 

/*/{Protheus.doc} getFile
//Funcao para abrir o browse de arquivos
@author Renan Paiva
@since 16/07/2018
/*/
static function getFile(_cFile)

_cFile := cGetFile( 'Arquivo CSV|*.csv|Arquivo Texto|*.txt' , 'Selecione o Arquivo', 1, 'C:\', .F., GETF_LOCALHARD,.T., .T. )

return

/*/{Protheus.doc} criaArea
// Funcao para criar a tabela temporária no banco de dados
@author Renan Paiva
@since 16/07/2018
/*/
static function criaArea()

local _aCampos := {}
local _cAlias := GetNextAlias()
local _oTable

aAdd(_aCampos,{"FILIAL","C",TamSx3("B7_FILIAL")[1],TamSx3("B7_FILIAL")[2]})
aAdd(_aCampos,{"PRODUTO","C",TamSx3("B7_COD")[1],TamSx3("B7_COD")[2]})
aAdd(_aCampos,{"ARMAZEM","C",TamSx3("B7_LOCAL")[1],TamSx3("B7_LOCAL")[2]})
aAdd(_aCampos,{"QTD2UM","N",TamSx3("B7_QTSEGUM")[1],TamSx3("B7_QTSEGUM")[2]})
aAdd(_aCampos,{"DTINV","D", 8, 0})

_oTable := FWTemporaryTable():New(_cAlias, _aCampos)
_oTable:AddIndex("1", {"FILIAL", "ARMAZEM", "PRODUTO"})
_oTable:Create()

return _oTable

/*/{Protheus.doc} insTmpTbl
// Funcao para inserir os dados do arquivo na tabela temporária, a finalidade eh
// garantir a ordenação
@author Renan Paiva
@since 16/07/2018
/*/
static function insTmpTbl(_oTable, _cFilial, _cProd, _cLocal, _nQtd2UM, _dData)

local _cAlias := _oTable:GetAlias()

dbSelectArea(_cAlias)
recLock(_cAlias, .T.)
(_cAlias)->FILIAL	:= _cFilial
(_cAlias)->PRODUTO	:= _cProd
(_cAlias)->ARMAZEM	:= _cLocal
(_cAlias)->QTD2UM	:= _nQtd2UM
(_cAlias)->DTINV	:= _dData
msUnLock()

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