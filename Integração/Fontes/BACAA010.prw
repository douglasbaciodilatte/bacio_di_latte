#Include 'Protheus.ch'
#INCLUDE 'FWMVCDEF.CH' 

/*---------------------------------------------------------------------------------------
{Protheus.doc} BACAA010
Rotina de cadastramento do processo de Amarracao entre os processos:
- PDV
- Deposito 
- Centro de Custo
- Conta Corrente 
@class      Nao Informado
@from       Nao Informado
@param      _nRecno -> Registro relacionado ao PIN esta posicionado
@attrib     Nao Informado
@protected  Nao Informado
@author     TOTVS
@Date     	16/02/2017
@version    P.12
@since      Nao Informado  
@return     ARRAY
@sample     Nao Informado
@obs        Esta funcionalidade deve retornar um ARRAY bidimensional com duas posições ex {"CAMPO",CONTEUDO}
			Já esta posicionado o registro da tabela  PIN
@project    Integração de arquivos - Motor de Integração
@menu       Nao Informado
@history    
rodolfo
---------------------------------------------------------------------------------------*/

User Function BACAA010()

Local _oMBrowse	:= NIL				//Objeto para montar a MBrowse
Local _cFiltro	:= ""				//Variavel para montar o filtro, caso possua
Local _aCores	:= ""				//Tratamento para a funcao Legenda e status na MBrowse
Local _nI		:= 0				//variavel de controle para laco

Private cCadastro	:= Alltrim(Posicione("SX2",1,"SZ2","X2_NOME")) 			//Variavel padrao para definir o nome da Rotina
Private aRotina		:= MenuDef()	//Busca as opcoes de menu disponiveis

dbSelectArea("SZ2")

oMBrowse := FWMBrowse():New()
oMBrowse:SetAlias("SZ2")
oMBrowse:SetDescription(cCadastro)

//Tratamento para Filtro
If !Empty( _cFiltro )
	oMBrowse:SetFilterDefault( _cFiltro )
EndIf

//Tratamento para Legenda
If Len(_aCores) > 0
	For _nI := 1 To Len(_aCores)
		oMBrowse:AddLegend(_aCores[_nI][1],_aCores[_nI][2],aCores[_nI][3]) 
	Next _nI  
EndIf

oMBrowse:Activate()

Return

//-------------------------------------------------------------------

Static Function MenuDef() 

Local aRotAux := {}
                                                            
aAdd(aRotAux,{"Pesquisar"	,"PesqBrw"    	, 0 , 1,0 	,.F.})
aAdd(aRotAux,{"Visualizar"	,'U_AA010MAN'	, 0 , 2,0 	,NIL})
aAdd(aRotAux,{"Incluir"		,'U_AA010MAN'	, 0 , 3,0	,NIL})
aAdd(aRotAux,{"Alterar"		,'U_AA010MAN'	, 0 , 4,143	,NIL})
aAdd(aRotAux,{"Excluir"		,'U_AA010MAN'	, 0 , 5,144	,NIL})

Return aRotAux

//-------------------------------------------------------------------

User Function AA010MAN(cAlias,nReg,nOpc)

Local _aSize 		:= MsAdvSize()						// Tamanho da tela
Local _oDlg
Local _oEnchoice

Local _lVisual	:= (nOpc == 2)
Local _lInclui	:= (nOpc == 3)
Local _lAltera	:= (nOpc == 4)
Local _lExclui	:= (nOpc == 5)

Private aTELA[0][0] // Variáveis que serão atualizadas pela Enchoice()
Private aGETS[0]	// e utilizadas pela função OBRIGATORIO()

If SetMDIChild()
	_aSize[5] := _aSize[5] - 12
	_aSize[3] := _aSize[5] / 2
EndIf 
		
DEFINE MSDIALOG _oDlg TITLE cCadastro FROM _aSize[7],0 TO _aSize[6],_aSize[5] PIXEL 
	RegToMemory("SZ2", _lInclui, .F.)
    
	_oEnchoice := MsMGet():New(cAlias,nReg,nOpc,,,,,{2,2,56,445},,,,,,_oDlg,,.T.)
	_oEnchoice:oBox:Align	:= CONTROL_ALIGN_ALLCLIENT
ACTIVATE MSDIALOG _oDlg CENTERED ON INIT EnchoiceBar(_oDlg, {|| AA010Grv(_oEnchoice,_lInclui,_lAltera,_lExclui,_oDlg) }, {|| _oDlg:End() },,)

Return

//-------------------------------------------------------------------

Static Function AA010Grv(_oEnchoice,_lInclui,_lAltera,_lExclui,_oDlg)

Local _bCampo	:= {|nCpo| Field(nCpo) }			//Bloco de Codigo para atualizacao do campo
Local _nI		:= 0

dbSelectArea("SZ2")

//Valida se os campos obrigatorios foram preenchidos e se nao esta duplicado
If _lInclui .or. _lAltera
	If !Obrigatorio(aGets,aTela) .Or. !A010VldCmp(_oEnchoice,_lInclui,_lAltera)
		Return
	EndIf
EndIf

Begin Transaction 	
	If _lInclui .Or. _lAltera
		RecLock("SZ2",_lInclui)
		For _nI := 1 TO FCount()
			If "_FILIAL" $ FieldName(_nI)
				FieldPut(_nI,xFilial("SZ2"))
			Else
				FieldPut(_nI,M->&(EVAL(_bCampo,_nI)))
			EndIf
		Next _nI
	ElseIf _lExclui
		RecLock("SZ2",.F.)
		SZ2->( dbDelete() )
		SZ2->( msUnLock() )
	EndIf
End Transaction

_oDlg:End()

Return 

//-------------------------------------------------------------------

Static Function A010VldCmp(_oEnchoice,_lInclui,_lAltera)

Local _lRet	:= .T.												//Filial de Retorno
Local _aArea	:= GetArea()									//Area Atual
Local _aAreaSA6	:= SA6->( GetArea() )							//Area da tabela SA6 (Bancos)
Local _aAreaCTT	:= CTT->( GetArea() )							//Area da tabela CTT (Centros de Custo)
Local _aAreaNNR	:= NNR->( GetArea() )							//Area da tabela NNR (Depositos)
Local _aAreaSLG	:= SLG->( GetArea() )							//Area da tabela SLG (Estacoes)
Local _cCxFil	:= SuperGetMV("ES_CXAFIL",,"CXA")				//Codigo do Caixa usado na Filial (CXA)
Local _cAgencia	:= PadR(cFilAnt,TamSX3("A6_AGENCIA")[1])		//Numero da Agencia do Banco (nesse caso sera a filial posicionada)

//Tratamento do Campo Z2_PDV (Estacao)
dbSelectArea("SLG")
dbSetOrder(1)		//LG_FILIAL+LG_CODIGO
If !SLG->( dbSeek( xFilial("SLG") + M->Z2_PDV ) )
	 ApMsgInfo("Deposito " + Alltrim(M->Z2_LOCAL) + " não cadastrado ( NNR - Cadastro de Depositos)")
	 _lRet := .F.	
EndIf

//Tratamento do Campo Z2_LOCAL (Deposito)
If _lRet
	dbSelectArea("NNR")
	dbSetOrder(1)	//NNR_FILIAL+NNR_CODIGO
	If !NNR->( dbSeek( xFilial("NNR") + M->Z2_LOCAL ) )
		 ApMsgInfo("Deposito " + Alltrim(M->Z2_LOCAL) + " não cadastrado ( NNR - Cadastro de Depositos)")
		 _lRet := .F.	
	EndIf
EndIf

//Tratamento do Campo Z2_CC (Centro de Custo)
If _lRet
	dbSelectArea("CTT")
	dbSetOrder(1)	//CTT_FILIAL+CTT_CUSTO
	If CTT->( dbSeek( xFilial("CTT") + M->Z2_CC ) )
		If !(CTT->CTT_CLASSE == "2")
			 ApMsgInfo("Centro de Custo " + Alltrim(M->Z2_CC) + " não é Analitico")
			 _lRet := .F.		
		EndIf
		
		If !(Alltrim(CTT->CTT_FILMAT) == Alltrim(cFilAnt))
			 ApMsgInfo("Centro de Custo " + Alltrim(M->Z2_CC) + " não pertence a filial (" + Alltrim(cFilAnt) + ")")
			 _lRet := .F.				
		EndIf
	Else
		 ApMsgInfo("Não foi encontrado o Centro de Custo " + Alltrim(M->Z2_CC))
		 _lRet := .F.	
	EndIf
EndIf

//Tratamento do campo Z2_CONTA (Conta corrente do banco)
If _lRet
	dbSelectArea("SA6")
	dbSetOrder(1)	//A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
	If !SA6->( dbSeek( xFilial("SA6") + _cCxFil + _cAgencia + M->Z2_CONTA ) )
		 ApMsgInfo("Não foi encontrado o caixa para a filial e conta (" + Alltrim(_cCxFil) + "/" + Alltrim(_cAgencia) + "/" + Alltrim(M->Z2_CONTA) + ")")
		 _lRet := .F.
	EndIf
EndIf

RestArea(_aArea)
RestArea(_aAreaSA6)
RestArea(_aAreaCTT)
RestArea(_aAreaNNR)
RestArea(_aAreaSLG)

Return _lRet

//-------------------------------------------------------------------

User Function BACAA011(_cEstacao)

Local _aRet	:= {}

dbSelectArea("SZ2")
dbSetOrder(1)
If SZ2->( dbSeek( xFilial("SZ2") + _cEstacao) )
	aAdd(_aRet,Z2_LOCAL	)
	aAdd(_aRet,Z2_CC	)
	aAdd(_aRet,Z2_CONTA	)
EndIf

Return _aRet
