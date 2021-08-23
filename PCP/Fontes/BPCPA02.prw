#INCLUDE "Protheus.ch"
#INCLUDE "Topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ BPCPA02  ºAutor  ³ Agility            º Data ³  14/11/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Programa de encerramento de ordens de producao.             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function BPCPA02()
Local aSays    :={}
Local aButtons :={}
Local cPerg     := "BPCP02"
Local _cCodUser := RetCodUsr()
Local _cLocUsr  := SPACE(TAMSX3("D3_LOCAL")[1])
Local _lRetorna := .F.

Private oDlgSele := Nil
Private oGetDad1 := Nil
Private nOpcSele := 0 
Private cCposSX3 := ""
Private aPosObj  := {} 
Private aObjects := {}                        
Private aSize    := MsAdvSize() 
Private aHedDad1 := {}
Private aColDad1 := {}
Private lEnd	 := .F.
Private aAlter   := {}

ValidPerg(cPerg)

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

AADD(aSays,"Essa rotina ira encerrar as ordem de produção de acordo com os")
AADD(aSays,'parâmetros a serem informados, valide os parâmetros da rotina.')

AADD(aButtons, { 1,.T.,{|o| ( IIF(_lRetorna ,o:oWnd:End() ,Alert("Os parametros não foram definidos!") ) ) } } )
AADD(aButtons, { 2,.T.,{|o|  o:oWnd:End() }} )
AADD(aButtons, { 5,.T.,{|o| ( IIF(Pergunte(cPerg, .T. ), _lRetorna := .T., ) )             } } ) 

FormBatch("Encerramento de Ordens de Produção", aSays, aButtons,,200,405 )

If _lRetorna

	_cPerEnc := MV_PAR01
	IF EMPTY(_cPerEnc)
		ShowHelpDlg('BPCPA02',{'O parametro do Período de Encerramento não foi definido.'},1,{'Defina o período de encerramento nos parametros.'},1)
		Return
	ENDIF

	_cLocEnc := MV_PAR02
	IF EMPTY(_cLocEnc)
		ShowHelpDlg('BPCPA02',{'O parametro do Local não foi definido.'},1,{'Defina o Local de encerramento nos parametros.'},1)
		Return
	ENDIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta o aHeader e o aCols do GetDados³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCposSX3 := "D3_OP|D3_COD|D3_DESCRI|D3_LOCAL|D3_QUANT"
	
	dbSelectArea("SX3") 
	SX3->(dbSetOrder(1))
	SX3->(dbGoTop())
	SX3->(dbSeek("SD3"))
	While SX3->(!Eof()) .And. SX3->X3_ARQUIVO == "SD3"
		If AllTrim(SX3->X3_CAMPO) $ cCposSX3
			Aadd(aHedDad1,{	IIF(ALLTRIM(SX3->X3_CAMPO)=="D3_QUANT","Saldp Op",AllTrim(X3Titulo())),SX3->X3_CAMPO,SX3->X3_PICTURE,SX3->X3_TAMANHO			,;
									SX3->X3_DECIMAL,SX3->X3_VALID,SX3->X3_USADO,SX3->X3_TIPO,SX3->X3_F3		,;
									SX3->X3_CONTEXT,SX3->X3_CBOX,SX3->X3_RELACAO,SX3->X3_WHEN,SX3->X3_VISUAL	,;
									SX3->X3_VLDUSER,SX3->X3_PICTVAR,SX3->X3_OBRIGAT})
		EndIf
		
		SX3->(dbSkip())
	EndDo            

	_cLocDe	 := MV_PAR02
	_cOPDe	 := MV_PAR03
	_cOPAte	 := MV_PAR04
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta itens com dados da OP ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	_cQry := "SELECT * "
	_cQry += " FROM "+RETSQLNAME("SC2")
	_cQry += " WHERE "
	_cQry += " C2_FILIAL = '"+XFILIAL("SC2")+"' "
	_cQry += " AND C2_DATPRI BETWEEN '"+MV_PAR01+"01' AND '"+MV_PAR01+"31'"
	_cQry += " AND C2_NUM+C2_ITEM+C2_SEQUEN BETWEEN '"+_cOPDe+"' AND '"+_cOPAte+"'"
	_cQry += " AND C2_LOCAL = '"+_cLocDe+"'"
	_cQry += " AND C2_QUANT > C2_QUJE "
	_cQry += " AND C2_QUJE > 0 "
	_cQry += " AND C2_DATRF = '' "
	_cQry += " AND D_E_L_E_T_ = ' ' "
	_cQry += " ORDER BY C2_XDESC "	
	TCQUERY _cQry NEW ALIAS "QSC2"
	
	IF QSC2->(!Eof())
	
		While QSC2->(!Eof())
		
			Aadd(aColDad1,Array(Len(aHedDad1) + 1))
			_nPosTM := AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_TM"})
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_OP"})]      := QSC2->C2_NUM+QSC2->C2_ITEM+QSC2->C2_SEQUEN
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_COD"})]     := QSC2->C2_PRODUTO
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_DESCRI"})]  := QSC2->C2_XDESC
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_LOCAL"})]   := QSC2->C2_LOCAL
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_QUANT"})]   := QSC2->C2_QUANT - QSC2->C2_QUJE
			aColDad1[Len(aColDad1)][Len(aHedDad1) + 1] := .F.
			
			QSC2->(dbSkip())
		EndDo	

	ELSE

		ShowHelpDlg('BPCPA02',{'Não há dados a serem exibidos.'},1,{'Verifique os parametros informados.'},1)
		QSC2->(dbCloseArea())
		Return

	ENDIF

	QSC2->(dbCloseArea())

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
	oDlgSele := TDialog():New(100,001,oMainWnd:nClientHeight-30,oMainWnd:nClientWidth-40,OemToAnsi("Encerramento de Ordens de Produção"),,,,,,,,oMainWnd,.T.)
	
	oGetDad1 := MsNewGetDados():New(aPosObj[2,1]-15,aPosObj[2,2],aPosObj[2,3]-45,aPosObj[2,4]-10,14,,,"",aAlter,,9999,,,,oDlgSele,aHedDad1,aColDad1)
	
	oDlgSele:Activate(,,,,,,{|| EnchoiceBar(oDlgSele,{|| nOpcSele := 1 , oDlgSele:End()},{|| oDlgSele:End()})})       

ELSE
	Return
ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Gravacao dos dados informados³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
If nOpcSele == 1

	nAviso := Aviso( "*** Atenção ***","Confirma o encerramento das OP’s? Esse processo é irreversível.", { "Sim", "Não" } )
	IF nAviso == 1

		Processa({|lEnd| BPCPA02E(@lEnd)},"Encerramento de OPs",OemToAnsi("Encerrando OPs..."),.F.)

	ENDIF

EndIf

Return Nil


Static Function BPCPA02E(lContinua)                                                                                                                                 

	ProcRegua(Len(oGetDad1:aCols))

	For nCntItem := 1 To Len(oGetDad1:aCols)

		IF !oGetDad1:aCols[nCntItem][Len(oGetDad1:aHeader)+1]     

			IncProc("Encerrando de OP "+oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_OP"})])

			aVetor := {}
			lMsErroAuto := .F.
            Begin Transaction

            	dbSelectArea("SC2")
            	dbSetOrder(1)
            	dbSeek(XFILIAL("SC2")+ALLTRIM(oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_OP"})]))

            	_cSQL := "SELECT * FROM " + RETSQLNAME("SD3") + " WHERE "
				_cSQL += "D3_OP      = '" + ALLTRIM(SC2->C2_NUM+SC2->C2_ITEM+SC2->C2_SEQUEN+SC2->C2_ITEMGRD)  + "' AND "
				_cSQL += "D3_CF = 'PR0' AND "
				_cSQL += "D3_LOCAL = '"+_cLocDe+"' AND "
				_cSQL += "D3_ESTORNO <> 'S' AND "
				_cSQL += "D_E_L_E_T_ = '' ORDER BY R_E_C_N_O_ DESC"
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cSQL),"TD3",.F.,.T.)

               aVetor:={{ "D3_OP"	, TD3->D3_OP		, NIL },;
				  { "D3_TM" 		, TD3->D3_TM		, NIL },;
				  { "D3_EMISSAO"	, TD3->D3_EMISSAO	, NIL },;
				  { "D3_COD"		, TD3->D3_COD		, NIL },;
				  { "D3_UM"			, TD3->D3_UM		, NIL },;
				  { "D3_LOCAL"		, TD3->D3_LOCAL		, NIL },;
				  { "D3_DOC"		, TD3->D3_DOC   	, NIL },;
				  { "D3_NUMSEQ"		, TD3->D3_NUMSEQ  	, NIL }}

                //Encerramento
               MSExecAuto({|x,y| mata250(x,y)},aVetor,6)

               If lMsErroAuto
                  DisarmTransaction()
                  Mostraerro()
               Endif

               dbSelectArea("TD3")
               TD3->(dbCloseArea())

            End Transaction

       ENDIF

	Next nCntItem

	MsgInfo("Encerramento de Ordens de Produção finalizado.","Aviso")

Return

Static Function ValidPerg(cPerg)

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

DbSelectArea("SX1")
DbSetOrder(1)
dbGotop()
cPerg := PADR(cPerg,Len(SX1->X1_GRUPO))

Aadd(aRegs,{cPerg,"01","Período encerramento (AAAAMM)   "," "," ","MV_CH1","C",6                    ,0,0,"G",""                   ,"MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"02","Código Armazém                  "," "," ","MV_CH2","C",TAMSX3("D3_LOCAL")[1],0,0,"G",""                   ,"MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","NNR",""})
Aadd(aRegs,{cPerg,"03","Ordem de Produção Inicial       "," "," ","MV_CH3","C",11                   ,0,0,"G",""                   ,"MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","SC2",""})
Aadd(aRegs,{cPerg,"04","Ordem de Produção Final         "," "," ","MV_CH4","C",11                   ,0,0,"G",""                   ,"MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","SC2",""})

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