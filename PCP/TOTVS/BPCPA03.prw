#INCLUDE "Protheus.ch"
#INCLUDE "Topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ BPCPA03  ºAutor  ³ Agility            º Data ³  16/11/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Programa de apontamento de consumo lojas.                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function BPCPA03()
Private _cCodUser  := RetCodUsr()
Private _cLocUsr   := SPACE(TAMSX3("D3_LOCAL")[1])
Private _lRetorna  := .F.
Private lHasButton := .T.

Private oDlgSele  := Nil
Private oGetDad1  := Nil
Private nOpcSele  := 0 
Private cCposSX3  := ""
Private aPosObj   := {} 
Private aObjects  := {}                        
Private aSize     := MsAdvSize() 
Private aAlter    := {"D3_QTDAPON"}
Private _dApont   := dDataBase
Private aRet      := {}
Private aHedDad1  := {}
Private aColDad1  := {}
Private lEnd	  := .F.
Private cPerg     := "BPCP03"

Private _cTM := Space(TAMSX3("D3_TM")[1])
Private _cCC := Space(TAMSX3("D3_CC")[1])
Private _dEm := Ctod("  /  /  ")

ValidPerg(cPerg)

AtuPerg(cPerg, "MV_PAR01", dDataBase)

_cQry := "SELECT GQ_LOCAL "
_cQry += " FROM "+RETSQLNAME("SGQ")
_cQry += " WHERE "
_cQry += " GQ_FILIAL = '"+XFILIAL("SGQ")+"'" 
_cQry += " AND GQ_USER = '"+_cCodUser+"'"
_cQry += " AND D_E_L_E_T_ =  ' '"
TCQUERY _cQry NEW ALIAS "TMPSGQ"
IF TMPSGQ->(!EOF())
	_cLocUsr := TMPSGQ->GQ_LOCAL
ENDIF
TMPSGQ->(dbCloseArea())

AtuPerg(cPerg, "MV_PAR02", _cLocUsr )

If Pergunte(cPerg, .T. )

	_cTM := GetMV("AG_TMCONSU")
	_cCC := MV_PAR02
	_dEm := MV_PAR01

	_cDataCon := MV_PAR01
	_cDataFec := GetMV("MV_ULMES")

	IF _cDataCon <= _cDataFec
		ShowHelpDlg('BPCPA03',{'A data de apontamento do consumo não pode ser menor que a data de fechamento estoque. (MV_ULMES)'},1,{'Altere a data de apontamento de consumo.'},1)
		Return
	ENDIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta o aHeader e o aCols do GetDados³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCposSX3 := "D3_QTDAPON|D3_COD|D3_DESCRI|D3_UM|D3_LOCAL|D3_QUANT"
	
	dbSelectArea("SX3") 
	SX3->(dbSetOrder(1))
	SX3->(dbGoTop())
	SX3->(dbSeek("SD3"))
	While SX3->(!Eof()) .And. SX3->X3_ARQUIVO == "SD3"
		If AllTrim(SX3->X3_CAMPO) $ cCposSX3
			Aadd(aHedDad1,{	IIF(ALLTRIM(SX3->X3_CAMPO)=="D3_QUANT","Saldo Estoque",AllTrim(X3Titulo())),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO			,;
									SX3->X3_DECIMAL,SX3->X3_VALID,SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3		,;
									SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO,SX3->X3_WHEN,SX3->X3_VISUAL	,;
									SX3->X3_VLDUSER,SX3->X3_PICTVAR,SX3->X3_OBRIGAT})
		EndIf
		
		SX3->(dbSkip())
	EndDo            
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta itens com dados da OP ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	_cQry := "SELECT B1_COD, B1_DESC, B1_UM, B2_QATU,B1_GRUPO "
	_cQry += " FROM "+RETSQLNAME("SB1")+" B1"
	_cQry += " INNER JOIN "+RETSQLNAME("SB2")+" B2"
	_cQry += " ON B1_COD = B2_COD "
	_cQry += " WHERE "
	_cQry += " B1_FILIAL = '"+XFILIAL("SB1")+"' "
	_cQry += " AND B1_COD BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'"
	_cQry += " AND B1_XESTCON = '1' "
	_cQry += " AND B1.D_E_L_E_T_ = '' "
	_cQry += " AND B2_FILIAL = '"+XFILIAL("SB2")+"' "
	_cQry += " AND B2_LOCAL = '"+MV_PAR02+"' "
	_cQry += " AND B2_QATU > 0 "
	_cQry += " AND B2.D_E_L_E_T_ = ' ' "
	_cQry += " ORDER BY B1_GRUPO,B1_DESC "	
	TCQUERY _cQry NEW ALIAS "QRY"
	
	IF QRY->(!Eof())
	
		While QRY->(!Eof())
		
			Aadd(aColDad1,Array(Len(aHedDad1) + 1))
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_COD"})]     := QRY->B1_COD
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_DESCRI"})]  := QRY->B1_DESC
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_QTDAPON"})]   := 0
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_UM"})]      := QRY->B1_UM	
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_LOCAL"})]   := MV_PAR02
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_QUANT"})]   := QRY->B2_QATU

			
			aColDad1[Len(aColDad1)][Len(aHedDad1) + 1] := .F.
			
			QRY->(dbSkip())
		EndDo	

	ELSE

		ShowHelpDlg('BPCPA03',{'Não há dados a serem exibidos.'},1,{'Verifique os parametros informados.'},1)
		QRY->(dbCloseArea())
		Return

	ENDIF

	QRY->(dbCloseArea())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Define a area dos objetos                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aObjects := {} 
	AAdd( aObjects, { 020, 020, .f., .f. } )
	AAdd( aObjects, { 100, 100, .t., .t. } )
	
	aInfo := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 } 
	aPosObj := MsObjSize( aInfo, aObjects ) 
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Desenha a tela de definicao de Modo de Compartilhamento³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oDlgSele := TDialog():New(100,001,oMainWnd:nClientHeight-30,oMainWnd:nClientWidth-40,OemToAnsi("Apontamento Consumo - Lojas"),,,,,,,,oMainWnd,.T.)

	oFont := TFont():New('Courier new',,-18,.T.)
	cBlKWhen := "{|| .F. }"

	oSay1:= TSay():New(aPosObj[2,1] - 17,01,{||'TM:'},oDlgSele,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,200,20)
	oGet1 := TGet():New( aPosObj[2,1] - 17, 030, { | u | If( PCount() == 0, _cTM, _cTM := u ) },oDlgSele, ;
	040, 010, "!@",, 0, 16777215,,.F.,,.T.,,.F.,&(cBlkWhen),.F.,.F.,,.F.,.F. ,,"_cTM",,,,lHasButton )
	oGet1:cF3 := "SF5"

	oSay2:= TSay():New(aPosObj[2,1] - 17,75,{||'Centro de Custo:'},oDlgSele,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,200,20)
	oGet2 := TGet():New( aPosObj[2,1] - 17,170, { | u | If( PCount() == 0, _cCC, _cCC := u ) },oDlgSele, ;
	050, 010, "!@",, 0, 16777215,,.F.,,.T.,,.F.,&(cBlkWhen),.F.,.F.,,.F.,.F. ,,"_cCC",,,,lHasButton )
	oGet2:cF3 := "CTT"

	oSay3:= TSay():New(aPosObj[2,1] - 15,225,{||'Emissão:'},oDlgSele,,oFont,,,,.T.,CLR_BLUE,CLR_WHITE,200,20)
	oGet3 := TGet():New( aPosObj[2,1] - 15,280,{ | u | If( PCount() == 0, _dEm, _dEm := u ) },oDlgSele,;
	050,010, "!@",,0, 16777215,,.F.,,.T.,,.F.,&(cBlkWhen),.F.,.F.,,.F.,.F. ,,"_dEm",,,,lHasButton )
	
	oGetDad1 := MsNewGetDados():New(aPosObj[2,1],aPosObj[2,2],aPosObj[2,3]-45,aPosObj[2,4]-10,GD_UPDATE,  ,,"",aAlter,,9999,,,,oDlgSele,aHedDad1,aColDad1)
	
	oDlgSele:Activate(,,,,,,{|| EnchoiceBar(oDlgSele,{|| nOpcSele := 1 , oDlgSele:End()},{|| oDlgSele:End()})})       

ELSE
	Return
ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Gravacao dos dados informados³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
If nOpcSele == 1

	Processa({|lEnd| BPCPA03P(@lEnd)},"Apontamento Consumo Lojas",OemToAnsi("Apontando Consumo Loja..."),.F.)

EndIf

Return Nil

Static Function BPCPA03P(lContinua)                                                                                                                                 

	ProcRegua(Len(oGetDad1:aCols))

	_aCab1 := {}
	_aCab1 := { {"D3_TM" ,_cTM , NIL},;
	{"D3_CC" ,_cCC, NIL},;
	{"D3_EMISSAO" ,_dEm, NIL}} 

	_aTotItem := {}

	For nCntItem := 1 To Len(oGetDad1:aCols)

		IF !oGetDad1:aCols[nCntItem][Len(oGetDad1:aHeader)+1] .AND. oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_QTDAPON"})] > 0     

			IncProc("Apontamento de Consumo "+oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_COD"})])

			_aItem := {}
			_aItem :={ {"D3_COD" ,oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_COD"})] ,NIL},;
			{"D3_UM"    ,oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_UM"})]      ,NIL},; 
			{"D3_QUANT" ,oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_QTDAPON"})] ,NIL},;
			{"D3_LOCAL" ,oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_LOCAL"})]   ,NIL}}
				
			aadd(_aTotItem,_aItem) 

       ENDIF

	Next nCntItem

	lMsErroAuto := .F.
	Begin Transaction
	
	MSExecAuto({|x,y,z| MATA241(x,y,z)},_aCab1,_aTotItem,3)
	
	If lMsErroAuto
		DisarmTransaction()
		Mostraerro()
	Else
		MsgInfo("Apontamento Consumo - Lojas finalizado.","Aviso")           
	Endif
	
	End Transaction

Return

Static Function ValidPerg(cPerg)

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

DbSelectArea("SX1")
DbSetOrder(1)
dbGotop()
cPerg := PADR(cPerg,Len(SX1->X1_GRUPO))

Aadd(aRegs,{cPerg,"01","Data Apont. Consumo       "," "," ","MV_CH1","D",8                    ,0,0,"G",""             ,"MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"02","Código Armazém            "," "," ","MV_CH2","C",TAMSX3("D3_LOCAL")[1],0,0,"G","U_BPCP03A()"  ,"MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","NNR",""})
Aadd(aRegs,{cPerg,"03","Produto Inicial           "," "," ","MV_CH3","C",11                   ,0,0,"G",""             ,"MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","SC2",""})
Aadd(aRegs,{cPerg,"04","Produto Final             "," "," ","MV_CH4","C",11                   ,0,0,"G",""             ,"MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","SC2",""})

For i:=1 to Len(aRegs)
	If !dbseek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	EndIf
Next

DbSelectArea(_sAlias)

Return Nil
 
Static Function AtuPerg(cPergAux, cParAux, xConteud)
    Local aArea      := GetArea()
    Local nPosCont   := 8
    Local nPosPar    := 14
    Local nLinEncont := 0
    Local aPergAux   := {}
    Default xConteud := ''
     
    //Se não tiver pergunta, ou não tiver ordem
    If Empty(cPergAux) .Or. Empty(cParAux)
        Return
    EndIf
     
    //Chama a pergunta em memória
    Pergunte(cPergAux, .F., /*cTitle*/, /*lOnlyView*/, /*oDlg*/, /*lUseProf*/, @aPergAux)
     
    //Procura a posição do MV_PAR
    nLinEncont := aScan(aPergAux, {|x| Upper(Alltrim(x[nPosPar])) == Upper(cParAux) })
     
    //Se encontrou o parâmetro
    If nLinEncont > 0
        //Caracter
        If ValType(xConteud) == 'C'
            &(cParAux+" := '"+xConteud+"'")
         
        //Data
        ElseIf ValType(xConteud) == 'D'
            &(cParAux+" := sToD('"+dToS(xConteud)+"')")
             
        //Numérico ou Lógico
        ElseIf ValType(xConteud) == 'N' .Or. ValType(xConteud) == 'L'
            &(cParAux+" := "+cValToChar(xConteud)+"")
         
        EndIf
         
        //Chama a rotina para salvar os parâmetros
        __SaveParam(cPergAux, aPergAux)
    EndIf
     
    RestArea(aArea)
Return

//Valida data dias para retroagir ou avancar data base
User Function BPCP03V(_dData)
Local _lRet := .T.
Local _aRet := {}

IF (  PswSeek(_cCodUser, .T.) )
	_aRet := PswRet() 
ENDIF

IF LEN(_aRet) > 0
	_nDataRe := _dData - _aRet[1][23][2]
	_nDataAv := _dData + _aRet[1][23][3]
	DO CASE
		CASE MV_PAR01 > _nDataAv
			ShowHelpDlg('BPCPA03V',{'A Data de Consumo definida é superior ao limite de dias a avançar.'},1,{'Altere a Data de Consumo.'},1)
			_lRet := .F.
	 	CASE MV_PAR01 < _nDataRe
			ShowHelpDlg('BPCPA03V',{'A Data de Consumo definida é inferior ao limite de dias a retroceder.'},1,{'Altere a Data de Consumo.'},1)
			_lRet := .F.
	END CASE
ENDIF

Return(_lRet)

//Valida saldo em estoque
User Function BPCP03E(_nQtdApo)

dbSelectArea("SB2")
IF dbSeek(xFilial("SB2") + PADR(oGetDad1:aCols[oGetDad1:nAt][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_COD"})],TAMSX3("D3_COD")[1]) + PADR(oGetDad1:aCols[oGetDad1:nAt][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_LOCAL"})],TAMSX3("D3_LOCAL")[1]))
	_nSaldo := SB2->B2_QATU
ENDIF
IF _nSaldo < oGetDad1:aCols[oGetDad1:nAt][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_QTDAPON"})]
	ShowHelpDlg('BPCPA03E',{'A quantidade informada para consumo é superior que o saldo em estoque '+Transform(_nSaldo,"@E 9,999,999.99")+'.'},1,{'Altere a quantidade.'},1)				
	_nQtdApo := 0
ENDIF

Return(_nQtdApo)


//Valida Permicao ao Armazem
User Function BPCP03A()
Local _lRet := .T.

_cQry := "SELECT GQ_LOCAL "
_cQry += " FROM "+RETSQLNAME("SGQ")
_cQry += " WHERE "
_cQry += " GQ_FILIAL = '"+XFILIAL("SGQ")+"'" 
_cQry += " AND GQ_USER = '"+_cCodUser+"'"
_cQry += " AND D_E_L_E_T_ =  ' '"
TCQUERY _cQry NEW ALIAS "TMPSGQ"
IF TMPSGQ->(!EOF())
	_lRet := .T.
	IF ALLTRIm(MV_PAR02) <> ALLtrim(TMPSGQ->GQ_LOCAL)
		ShowHelpDlg('BPCPA03A',{'O usuário não tem permissão a este armazém.'},1,{'Altere o código do armazém.'},1)
		_lRet := .F.
	ENDIF
ELSE
	ShowHelpDlg('BPCPA03A',{'O usuário não tem permissão a este armazém.'},1,{'Altere o código do armazém.'},1)
	_lRet := .F.
ENDIF
TMPSGQ->(dbCloseArea())

Return(	_lRet)