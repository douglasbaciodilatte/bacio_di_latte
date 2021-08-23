#Include "Protheus.ch"

User Function BLADJLOT()

Local vArea :=GetArea()
Local cDocumento:=""
Local vTMS:= ""
Local _vItens:={}
Local _cAliasD3 := GetNextAlias()
Local _cAliasB2 := GetNextAlias()
Local _cAliasB8 := GetNextAlias()
Local _cCab:={}
Local vPosLoc:= 0
Local vPosEnd:= 0
Local vCabRE:={}
Local lBlqPr:=.F.
Local aPrdBlq:={}

Private lMsErroAuto	:= .F.
Private lMsHelpAuto	:= .F.
Private lAutoErrNoFile := .F.
Private cPerg := "BLADJLT1"
Private cHist:=""

Default cGrupo    := Space(10)
Default cOrdem    := Space(02)
Default cTexto    := Space(30)
Default cMVPar    := Space(15)
Default cVariavel := Space(6)
Default cTipoCamp := Space(1)
Default nTamanho  := 0
Default nDecimal  := 0
Default cTipoPar  := "G"
Default cValid    := Space(60)
Default cF3       := Space(6)
Default cPicture  := Space(40)
Default cDef01    := Space(15)
Default cDef02    := Space(15)
Default cDef03    := Space(15)
Default cDef04    := Space(15)
Default cDef05    := Space(15)
Default cHelp     := ""


zPutSX1(cPerg, "01", "Documento?",       	"MV_PAR01", "MV_CH1", "C", TamSX3('D3_DOC')[01], 	0, "G", cValid,       ""	, cPicture,        cDef01,  cDef02,        cDef03,        cDef04,    cDef05, "Informe o produto")
zPutSX1(cPerg, "02", "Armazem?",     	  	"MV_PAR02", "MV_CH2", "C", TamSX3('D3_LOCAL')[01], 	0, "G", cValid,       ""	, cPicture,        cDef01,  cDef02,        cDef03,        cDef04,    cDef05, "Informe o Armazem")
zPutSX1(cPerg, "03", "Tp.Mov. Entrada",    	"MV_PAR03", "MV_CH3", "C", TamSX3('D3_TM')[01],     0, "G", cValid,       ''	,   cPicture,        cDef01,  cDef02,        cDef03,        cDef04,    cDef05, "Informe Tipo da Movimentacao")
zPutSX1(cPerg, "04", "Tp.Mov. Saida",    	"MV_PAR04", "MV_CH3", "C", TamSX3('D3_TM')[01],     0, "G", cValid,       ''	,   cPicture,        cDef01,  cDef02,        cDef03,        cDef04,    cDef05, "Informe Tipo da Movimentacao")
zPutSX1(cPerg, "05", "Filial?",    			"MV_PAR05", "MV_CH4", "C", TamSX3('D3_FILIAL')[01], 0, "G", cValid,       ''	,   cPicture,        cDef01,  cDef02,        cDef03,        cDef04,    cDef05, "Informe a Filial")


If !Pergunte(cPerg, .T.)
	Return
Endif




If Empty(cDocumento)
	cDocumento	:= Upper(mv_par01)
EndIf



BEGINSQL ALIAS _cAliasD3
	%NOPARSER%
	SELECT SUM(B8_SALDO) AS BFQUANT, B8_PRODUTO, B8_LOTECTL, B8_DTVALID, B8_LOCAL FROM %TABLE:SB8%
	WHERE B8_LOCAL = %Exp:mv_par02% AND B8_SALDO < 0 AND B8_FILIAL = %Exp:mv_par05% '
	GROUP BY B8_LOCAL, B8_PRODUTO, B8_LOTECTL, B8_DTVALID
	ORDER BY B8_LOCAL, B8_PRODUTO, B8_LOTECTL, B8_DTVALID ASC
ENDSQL

If (_cAliasD3)->(Eof())
	(_cAliasD3)->(dbCloseArea())
	Return .T.
EndIf
//³Monta o cabecalho padrao para a rotina automatica de Movimentacao Entrada ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

_cCab:= {	{"D3_TM"		,MV_PAR03					,NIL},;
{"D3_DOC"    	,cDocumento 	  		,NIL},;
{"D3_EMISSAO"	,dDataBase		  		,Nil}}

dbSelectArea(_cAliasD3)
While !EOF(_cAliasD3)
	
	If !Empty((_cAliasD3)->B8_PRODUTO)
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial("SB1")+(_cAliasD3)->B8_PRODUTO)
		If SB1->B1_MSBLQL='1'
			
			aAdd(aPrdBlq,{(_cAliasD3)->B8_PRODUTO})
			
			Reclock("SB1",.F.)
			SB1->B1_MSBLQL :=''
			Msunlock()
		Endif
		If Rastro((_cAliasD3)->B8_PRODUTO)
			vItem := {	{"D3_COD",(_cAliasD3)->B8_PRODUTO								   		,NIL},;
			{"D3_QUANT"	 	,Abs((_cAliasD3)->BFQUANT)									   		,NIL},;
			{"D3_UM"     	,Posicione("SB1",1,xFilial("SB1")+(_cAliasD3)->B8_PRODUTO, "B1_UM")	,NIL},;
			{"D3_LOCAL"  	,mv_par02													   		,NIL},;
			{"D3_LOTECTL"	,(_cAliasD3)->B8_LOTECTL									   		,NIL},;
			{"D3_NUMLOTE"	,''															   		,NIL},;
			{"D3_LOCALIZ"	,''																	,NIL}}
			
			aadd(_vItens, vItem)
		Endif
	Endif
	dbSelectArea(_cAliasD3)
	Dbskip()
Enddo
(_cAliasD3)->(dbCloseArea())



Begin Transaction
If Len(_vItens) > 0
	MATA241(_cCab,_vItens,3)
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
	Endif
Endif


For nX:=1 to Len(aPrdBlq)
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xFilial("SB1")+aPrdBlq[nX])
	
	Reclock("SB1",.F.)
	SB1->B1_MSBLQL :='1'
	Msunlock()
	
	
Next Nx
End Transaction

APrdBlq:={}
_cAliasD3 := GetNextAlias()
BEGINSQL ALIAS _cAliasD3
	%NOPARSER%
	SELECT X.*, X.B2_QATU - X.B8SALDO AS SAISB2
	FROM(
	SELECT B2_FILIAL,B2_COD,B2_LOCAL,B2_QATU,SUM(B8_SALDO) B8SALDO
	FROM %TABLE:SB2% B2
	LEFT JOIN %TABLE:SB8% B8 ON B8.D_E_L_E_T_ = '' AND B8_PRODUTO = B2_COD AND B2_FILIAL = B8_FILIAL AND B8_LOCAL = B2_LOCAL
	WHERE B2_FILIAL=%EXP:MV_PAR05% AND B2_LOCAL=%EXP:MV_PAR02% AND  B2.D_E_L_E_T_ = ''
	GROUP BY B2_FILIAL, B2_COD, B2_LOCAL, B2_QATU
	) AS X
	WHERE X.B2_QATU > X.B8SALDO
ENDSQL

aPrdBlq:={}
aPrdLt:={}
_vItens:={}
_cCab:= {	{"D3_TM"		,MV_PAR03					,NIL},;
{"D3_DOC"    	,cDocumento 	  		,NIL},;
{"D3_EMISSAO"	,dDataBase		  		,Nil}}

dbSelectArea(_cAliasD3)
While !EOF(_cAliasD3)
	
	If !Empty((_cAliasD3)->B8_PRODUTO)
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial("SB1")+(_cAliasD3)->B8_PRODUTO)
		If SB1->B1_MSBLQL='1'
			
			aAdd(aPrdBlq,{(_cAliasD3)->B8_PRODUTO})
			
			Reclock("SB1",.F.)
			SB1->B1_MSBLQL :=''
			Msunlock()
		Endif
		If Rastro(SB1->B1_COD)
			aAdd(aPrdLt,{(_cAliasD3)->B8_PRODUTO})
			Reclock("SB1",.F.)
			SB1->B1_RASTRO :='N'
			Msunlock()
		Endif
		
		vItem := {	{"D3_COD",(_cAliasD3)->B8_PRODUTO								   		,NIL},;
		{"D3_QUANT"	 	,Abs((_cAliasD3)->SAISB2)									   		,NIL},;
		{"D3_UM"     	,Posicione("SB1",1,xFilial("SB1")+(_cAliasD3)->B8_PRODUTO, "B1_UM")	,NIL},;
		{"D3_LOCAL"  	,mv_par02													   		,NIL},;
		{"D3_LOCALIZ"	,''																	,NIL}}
		
		aadd(_vItens, vItem)
		
	Endif
	dbSelectArea(_cAliasD3)
	Dbskip()
Enddo
(_cAliasD3)->(dbCloseArea())



Begin Transaction
If Len(_vItens) > 0
	MATA241(_cCab,_vItens,3)
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
	Endif
Endif


For nX:=1 to Len(aPrdBlq)
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xFilial("SB1")+aPrdBlq[nX])
	
	Reclock("SB1",.F.)
	SB1->B1_MSBLQL :='1'
	Msunlock()
	
	
Next Nx

For nX:=1 to Len(aPrdLt)
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xFilial("SB1")+aPrdLt[nX])
	
	Reclock("SB1",.F.)
	SB1->B1_RASTRO := 'L'
	Msunlock()
	
	
Next Nx

End Transaction

aPrdLt:={}
_vItens:={}
APrdBlq:={}
_cAliasD3 := GetNextAlias()
BEGINSQL ALIAS _cAliasD3
	%NOPARSER%
	SELECT X.*, X.B2_QATU - X.B8SALDO AS SAISB2
	FROM(
	SELECT B2_FILIAL,B2_COD,B2_LOCAL,B2_QATU,SUM(B8_SALDO) B8SALDO
	FROM %TABLE:SB2% B2
	LEFT JOIN %TABLE:SB8% B8 ON B8.D_E_L_E_T_ = '' AND B8_PRODUTO = B2_COD AND B2_FILIAL = B8_FILIAL AND B8_LOCAL = B2_LOCAL
	WHERE B2_FILIAL=%EXP:MV_PAR05% AND B2_LOCAL=%EXP:MV_PAR02% AND  B2.D_E_L_E_T_ = ''
	GROUP BY B2_FILIAL, B2_COD, B2_LOCAL, B2_QATU
	) AS X
	WHERE X.B2_QATU <> X.B8SALDO
ENDSQL

aPrdBlq:={}
aPrdLt:={}
_vItens:={}
_cCab:= {	{"D3_TM"		,MV_PAR03					,NIL},;
{"D3_DOC"    	,cDocumento 	  		,NIL},;
{"D3_EMISSAO"	,dDataBase		  		,Nil}}

dbSelectArea(_cAliasD3)
While !EOF(_cAliasD3)
	
	If !Empty((_cAliasD3)->B2_COD)
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial("SB1")+(_cAliasD3)->B2_COD)
		If SB1->B1_MSBLQL='1'
			
			aAdd(aPrdBlq,{(_cAliasD3)->B2_COD})
			
			Reclock("SB1",.F.)
			SB1->B1_MSBLQL :=''
			Msunlock()
		Endif
		If Rastro(SB1->B1_COD)
			aAdd(aPrdLt,{(_cAliasD3)->B2_COD})
			Reclock("SB1",.F.)
			SB1->B1_RASTRO :='N'
			Msunlock()
		Endif
		
		If (_cAliasD3)->SAISB2 > 0
			_cCab[1,2] := MV_PAR04 //SAINDO SB2
			nSB2 := (_cAliasD3)->SAISB2
		ElseIf (_cAliasD3)->SAISB2 < 0
			_cCab[1,2] := MV_PAR03 //ENTRANDO SB2
			nSB2 := (_cAliasD3)->SAISB2 *(-1)
		Endif
		
		vItem := {	{"D3_COD",(_cAliasD3)->B2_COD								   		,NIL},;
		{"D3_QUANT"	 	,Abs(nSB2)													   		,NIL},;
		{"D3_UM"     	,Posicione("SB1",1,xFilial("SB1")+(_cAliasD3)->B2_COD, "B1_UM")	,NIL},;
		{"D3_LOCAL"  	,mv_par02													   		,NIL},;
		{"D3_LOCALIZ"	,''																	,NIL}}
		
		aadd(_vItens, vItem)
		
	Endif
	dbSelectArea(_cAliasD3)
	Dbskip()
Enddo
(_cAliasD3)->(dbCloseArea())

Begin Transaction

If Len(_vItens) > 0
	MATA241(_cCab,_vItens,3)
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
	Endif
Endif


For nX:=1 to Len(aPrdBlq)
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xFilial("SB1")+aPrdBlq[nX])
	
	Reclock("SB1",.F.)
	SB1->B1_MSBLQL :='1'
	Msunlock()
	
	
Next Nx

For nX:=1 to Len(aPrdLt)
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xFilial("SB1")+aPrdLt[nX])
	
	Reclock("SB1",.F.)
	SB1->B1_RASTRO := 'L'
	Msunlock()
	
	
Next Nx
End transaction

aPrdBlq:={}
aPrdLt:={}
_vItens:={}
_cAliasD3 := GetNextAlias()
BEGINSQL ALIAS _cAliasD3
	%NOPARSER%
	SELECT X.*, X.B2_QATU - X.B8SALDO AS SAISB2
	FROM(
	SELECT B2_FILIAL,B2_COD,B2_LOCAL,B2_QATU,SUM(B8_SALDO) B8SALDO
	FROM %TABLE:SB2% B2
	LEFT JOIN %TABLE:SB8% B8 ON B8.D_E_L_E_T_ = '' AND B8_PRODUTO = B2_COD AND B2_FILIAL = B8_FILIAL AND B8_LOCAL = B2_LOCAL
	WHERE B2_FILIAL=%EXP:MV_PAR05% AND B2_LOCAL=%EXP:MV_PAR02% AND  B2.D_E_L_E_T_ = ''
	GROUP BY B2_FILIAL, B2_COD, B2_LOCAL, B2_QATU
	) AS X
	WHERE X.B2_QATU = X.B8SALDO
ENDSQL

aPrdBlq:={}
aPrdLt:={}
_vItens:={}
_cCab:= {	{"D3_TM"		,MV_PAR03					,NIL},;
{"D3_DOC"    	,cDocumento 	  		,NIL},;
{"D3_EMISSAO"	,dDataBase		  		,Nil}}

dbSelectArea(_cAliasD3)
While !EOF(_cAliasD3)
	
	If !Empty((_cAliasD3)->B2_COD)
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial("SB1")+(_cAliasD3)->B2_COD)
		If SB1->B1_MSBLQL='1'
			
			aAdd(aPrdBlq,{(_cAliasD3)->B2_COD})
			
			Reclock("SB1",.F.)
			SB1->B1_MSBLQL :=''
			Msunlock()
		Endif
		If Rastro(SB1->B1_COD)
			aAdd(aPrdLt,{(_cAliasD3)->B2_COD})
			Reclock("SB1",.F.)
			SB1->B1_RASTRO :='N'
			Msunlock()
		Endif
		
		If (_cAliasD3)->SAISB2 > 0
			_cCab[1,2] := MV_PAR04 //SAINDO SB2
			nSB2 := (_cAliasD3)->SAISB2
		ElseIf (_cAliasD3)->SAISB2 < 0
			_cCab[1,2] := MV_PAR03 //ENTRANDO SB2
			nSB2 := (_cAliasD3)->SAISB2 *(-1)
		Endif
		
		vItem := {	{"D3_COD",(_cAliasD3)->B2_COD								   		,NIL},;
		{"D3_QUANT"	 	,Abs(nSB2)													   		,NIL},;
		{"D3_UM"     	,Posicione("SB1",1,xFilial("SB1")+(_cAliasD3)->B2_COD, "B1_UM")	,NIL},;
		{"D3_LOCAL"  	,mv_par02													   		,NIL},;
		{"D3_LOCALIZ"	,''																	,NIL}}
		
		aadd(_vItens, vItem)
		
	Endif
	dbSelectArea(_cAliasD3)
	Dbskip()
Enddo
(_cAliasD3)->(dbCloseArea())
(_cAliasD3)->(dbCloseArea())

Begin Transaction
If Len(_vItens) > 0
	MATA241(_cCab,_vItens,3)
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
	Endif
Endif


For nX:=1 to Len(aPrdBlq)
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xFilial("SB1")+aPrdBlq[nX])
	
	Reclock("SB1",.F.)
	SB1->B1_MSBLQL :='1'
	Msunlock()
	
Next Nx

For nX:=1 to Len(aPrdLt)
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xFilial("SB1")+aPrdLt[nX])
	
	Reclock("SB1",.F.)
	SB1->B1_RASTRO := 'L'
	Msunlock()
Next Nx
End Transaction

RestArea(vArea)
If lMsErroAuto
	Quit
EndIf

aPrdBlq:={}
aPrdLt:={}
_vItens:={}
_cAliasD3 := GetNextAlias()
BEGINSQL ALIAS _cAliasD3
	%NOPARSER%
	SELECT X.*, X.B2_QATU - X.B8SALDO AS SAISB2,A.B8_LOTECTL,A.B8_DTVALID
	FROM(
	SELECT B2_FILIAL,B2_COD,B2_LOCAL,B2_QATU,SUM(B8_SALDO) B8SALDO
	FROM SB2010 B2
	LEFT JOIN SB8020 B8 ON B8.D_E_L_E_T_ = '' AND B8_PRODUTO = B2_COD AND B2_FILIAL = B8_FILIAL AND B8_LOCAL = B2_LOCAL
	WHERE B2_FILIAL=%EXP:MV_PAR05% AND B2_LOCAL=%EXP:MV_PAR02% AND  B2.D_E_L_E_T_ = ''
	GROUP BY B2_FILIAL, B2_COD, B2_LOCAL, B2_QATU
	) AS X
	LEFT JOIN SB8020 A ON A.D_E_L_E_T_ = '' AND A.B8_FILIAL = B2_FILIAL AND A.B8_PRODUTO = B2_COD AND A.B8_LOCAL = B2_LOCAL
	WHERE X.B2_QATU = X.B8SALDO AND B2_QATU > 0
	ORDER BY B2_FILIAL,B2_COD,B2_LOCAL,A.B8_LOTECTL,A.B8_DTVALID
	
ENDSQL

aPrdBlq:={}
aPrdLt:={}
_vItens:={}
_cCab:= {	{"D3_TM"		,MV_PAR04					,NIL},;
{"D3_DOC"    	,cDocumento 	  		,NIL},;
{"D3_EMISSAO"	,dDataBase		  		,Nil}}

dbSelectArea(_cAliasD3)
While !EOF(_cAliasD3)
	
	If !Empty((_cAliasD3)->B8_PRODUTO)
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial("SB1")+(_cAliasD3)->B2_COD)
		If SB1->B1_MSBLQL='1'
			
			aAdd(aPrdBlq,{(_cAliasD3)->B2_COD})
			
			Reclock("SB1",.F.)
			SB1->B1_MSBLQL :=''
			Msunlock()
		Endif
		If Rastro(SB1->B1_COD)
			aAdd(aPrdLt,{(_cAliasD3)->B2_COD})
			Reclock("SB1",.F.)
			SB1->B1_RASTRO :='N'
			Msunlock()
		Endif
		
		vItem := {	{"D3_COD",(_cAliasD3)->B2_COD								   		,NIL},;
		{"D3_QUANT"	 	,Abs(nSB2)													   		,NIL},;
		{"D3_UM"     	,Posicione("SB1",1,xFilial("SB1")+(_cAliasD3)->B2_COD, "B1_UM")	,NIL},;
		{"D3_LOCAL"  	,mv_par02													   		,NIL},;
		{"D3_LOCALIZ"	,''																	,NIL}}
		
		aadd(_vItens, vItem)
		
	Endif
	dbSelectArea(_cAliasD3)
	Dbskip()
Enddo
(_cAliasD3)->(dbCloseArea())

Begin Transaction
If Len(_vItens) > 0
	MATA241(_cCab,_vItens,3)
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
	Endif
Endif


For nX:=1 to Len(aPrdBlq)
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xFilial("SB1")+aPrdBlq[nX])
	
	Reclock("SB1",.F.)
	SB1->B1_MSBLQL :='1'
	Msunlock()
	
Next Nx

For nX:=1 to Len(aPrdLt)
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xFilial("SB1")+aPrdLt[nX])
	
	Reclock("SB1",.F.)
	SB1->B1_RASTRO := 'L'
	Msunlock()
Next Nx
End Transaction

RestArea(vArea)
If lMsErroAuto
	Quit
EndIf
Return lMsErroAuto


Static Function zPutSX1(cGrupo, cOrdem, cTexto, cMVPar, cVariavel, cTipoCamp, nTamanho, nDecimal, cTipoPar, cValid, cF3, cPicture, cDef01, cDef02, cDef03, cDef04, cDef05, cHelp)
Local aArea       := GetArea()
Local cChaveHelp  := ""
Local nPreSel     := 0


//Se tiver Grupo, Ordem, Texto, Parâmetro, Variável, Tipo e Tamanho, continua para a criação do parâmetro
If !Empty(cGrupo) .And. !Empty(cOrdem) .And. !Empty(cTexto) .And. !Empty(cMVPar)
	
	//Definição de variáveis
	cGrupo     := PadR(cGrupo, Len(SX1->X1_GRUPO), " ")           //Adiciona espaços a direita para utilização no DbSeek
	cChaveHelp := "P." + AllTrim(cGrupo) + AllTrim(cOrdem) + "."  //Define o nome da pergunta
	cMVPar     := Upper(cMVPar)                                   //Deixa o MV_PAR tudo em maiúsculo
	nPreSel    := Iif(cTipoPar == "C", 1, 0)                      //Se for Combo, o pré-selecionado será o Primeiro
	cDef01     := Iif(cTipoPar == "F", "56", cDef01)              //Se for File, muda a definição para ser tanto Servidor quanto Local
	nTamanho   := Iif(nTamanho > 60, 60, nTamanho)                //Se o tamanho for maior que 60, volta para 60 - Limitação do Protheus
	nDecimal   := Iif(nDecimal > 9,  9,  nDecimal)                //Se o decimal for maior que 9, volta para 9
	nDecimal   := Iif(cTipoPar == "N", nDecimal, 0)               //Se não for parâmetro do tipo numérico, será 0 o Decimal
	cTipoCamp  := Upper(cTipoCamp)                                //Deixa o tipo do Campo em maiúsculo
	cTipoCamp  := Iif(! cTipoCamp $ 'C;D;N;', 'C', cTipoCamp)     //Se o tipo do Campo não estiver entre Caracter / Data / Numérico, será Caracter
	cTipoPar   := Upper(cTipoPar)                                 //Deixa o tipo do Parâmetro em maiúsculo
	cTipoPar   := Iif(Empty(cTipoPar), 'G', cTipoPar)             //Se o tipo do Parâmetro estiver em branco, será um Get
	nTamanho   := Iif(cTipoPar == "C", 1, nTamanho)               //Se for Combo, o tamanho será 1
	
	DbSelectArea('SX1')
	SX1->(DbSetOrder(1)) // Grupo + Ordem
	
	//Se não conseguir posicionar, a pergunta será criada
	If ! SX1->(DbSeek(cGrupo + cOrdem))
		RecLock('SX1', .T.)
		X1_GRUPO   := cGrupo
		X1_ORDEM   := cOrdem
		X1_PERGUNT := cTexto
		X1_PERSPA  := cTexto
		X1_PERENG  := cTexto
		X1_VAR01   := cMVPar
		X1_VARIAVL := cVariavel
		X1_TIPO    := cTipoCamp
		X1_TAMANHO := nTamanho
		X1_DECIMAL := nDecimal
		X1_GSC     := cTipoPar
		X1_VALID   := cValid
		X1_F3      := cF3
		X1_PICTURE := cPicture
		X1_DEF01   := cDef01
		X1_DEFSPA1 := cDef01
		X1_DEFENG1 := cDef01
		X1_DEF02   := cDef02
		X1_DEFSPA2 := cDef02
		X1_DEFENG2 := cDef02
		X1_DEF03   := cDef03
		X1_DEFSPA3 := cDef03
		X1_DEFENG3 := cDef03
		X1_DEF04   := cDef04
		X1_DEFSPA4 := cDef04
		X1_DEFENG4 := cDef04
		X1_DEF05   := cDef05
		X1_DEFSPA5 := cDef05
		X1_DEFENG5 := cDef05
		X1_PRESEL  := nPreSel
		
		//Se tiver Help da Pergunta
		If !Empty(cHelp)
			X1_HELP    := ""
			
			fPutHelp(cChaveHelp, cHelp)
		EndIf
		SX1->(MsUnlock())
	EndIf
EndIf

RestArea(aArea)
Return

/*---------------------------------------------------*
| Função: fPutHelp                                  |
| Desc:   Função que insere o Help do Parametro     |
*---------------------------------------------------*/

Static Function fPutHelp(cKey, cHelp, lUpdate)
Local cFilePor  := "SIGAHLP.HLP"
Local cFileEng  := "SIGAHLE.HLE"
Local cFileSpa  := "SIGAHLS.HLS"
Local nRet      := 0
Default cKey    := ""
Default cHelp   := ""
Default lUpdate := .F.

//Se a Chave ou o Help estiverem em branco
If Empty(cKey) .Or. Empty(cHelp)
	Return
EndIf

//**************************** Português
nRet := SPF_SEEK(cFilePor, cKey, 1)

//Se não encontrar, será inclusão
If nRet < 0
	SPF_INSERT(cFilePor, cKey, , , cHelp)
	
	//Senão, será atualização
Else
	If lUpdate
		SPF_UPDATE(cFilePor, nRet, cKey, , , cHelp)
	EndIf
EndIf



//**************************** Inglês
nRet := SPF_SEEK(cFileEng, cKey, 1)

//Se não encontrar, será inclusão
If nRet < 0
	SPF_INSERT(cFileEng, cKey, , , cHelp)
	
	//Senão, será atualização
Else
	If lUpdate
		SPF_UPDATE(cFileEng, nRet, cKey, , , cHelp)
	EndIf
EndIf



//**************************** Espanhol
nRet := SPF_SEEK(cFileSpa, cKey, 1)

//Se não encontrar, será inclusão
If nRet < 0
	SPF_INSERT(cFileSpa, cKey, , , cHelp)
	
	//Senão, será atualização
Else
	If lUpdate
		SPF_UPDATE(cFileSpa, nRet, cKey, , , cHelp)
	EndIf
EndIf
Return
