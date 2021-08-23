#INCLUDE "Protheus.ch"
#INCLUDE "Topconn.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ BPCPA01  ºAutor  ³ Agility            º Data ³  23/10/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Programa de apontamento de producao de lojas.               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function BPCPA01()
Private _cCodUser  := RetCodUsr()
Private _cLocUsr   := SPACE(TAMSX3("D3_LOCAL")[1])
Private oDlgSele  := Nil
Private oGetDad1  := Nil
Private nOpcSele  := 0 
Private cCposSX3  := ""
Private aPosObj   := {} 
Private aObjects  := {}                        
Private aSize     := MsAdvSize() 
Private _aParBox  := {}
Private aAlter    := {"D3_QTDAPON"}
Private _dIniDe   := ""
Private _dIniAte  := dDataBase
Private _dApont   := dDataBase
Private aRet      := {}
Private aHedDad1  := {}
Private aColDad1  := {}
Private lEnd	  := .F.
Private cPerg     := "BPCP01"

ValidPerg(cPerg)

AtuPerg(cPerg, "MV_PAR02", dDataBase)

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

AtuPerg(cPerg, "MV_PAR03", _cLocUsr )

/*
aAdd(_aParBox,{1,"Data Inicial Ate   ", _dIniAte                       ,  ,"",     ,"",45,.T.})
aAdd(_aParBox,{1,"OP De              ", Space(11)                      ,"","","SC2","",0 ,.F.})
aAdd(_aParBox,{1,"OP Até             ", Repl('Z',11)                   ,"","","SC2","",0 ,.T.})
aAdd(_aParBox,{1,"Produto De         ", Space(TAMSX3("D3_COD")[1])     ,"","","SB1","",0 ,.F.})
aAdd(_aParBox,{1,"Produto Até        ", Repl('Z',TAMSX3("D3_COD")[1])  ,"","","SB1","",0 ,.T.})
aAdd(_aParBox,{1,"Local              ", Space(TAMSX3("D3_LOCAL")[1])   ,"","","NNR","",0 ,.F.})
aAdd(_aParBox,{1,"Data de Produção   ", _dApont                        ,  ,"",     ,"",45,.F.})
*/

If Pergunte(cPerg, .T. )

//If ParamBox(_aParBox,"OP's' Lojas",@aRet,,,,,,,,.F.)

	_cMesCor := MV_PAR01
	_cMesFec := Substr(DTOS(GetMV("MV_ULMES")),1,6)
	_cDatApo := Substr(DTOS(MV_PAR02),1,6)

	_cMesApo := StrZero(Month(MV_PAR02),2)

	IF _cMesApo <> Substr(_cMesCor,5,2)
		ShowHelpDlg('BPCPA01',{'A data de apontamento está fora do Mês da Ordem de Produção.'},1,{'Altere a data de apontamento conforme mes definido da Ordem de Produção.'},1)
		Return
	ENDIF

	IF _cMesFec >= _cMesCor
		ShowHelpDlg('BPCPA01',{'O Ano/Mês da Ordem de Produção é menor ou igual ao Ano/Mês de fechamento. (MV_ULMES)'},1,{'Altere o parametro do Mês e Ano da Ordem de Produção.'},1)
		Return
	ENDIF

	IF _cMesFec >= _cDatApo
		ShowHelpDlg('BPCPA01',{'A Dt. real da produção apontada. é menor ou igual ao Ano/Mês de Fechamento. (MV_ULMES)'},1,{'Altere o parametro Dt. real da produção apontada..'},1)
		Return
	ENDIF

	/*
	IF Empty(_cMesFin)
		ShowHelpDlg('BPCPA01',{'A Data Inicial Até? não foi definida.'},1,{'Informe uma data até inicial de produção.'},1)
		Return
	ENDIF

	IF _cMesCor <> _cMesFin .AND. !Empty(_cMesFin)
		ShowHelpDlg('BPCPA01',{'A Data Inicial Até? está fora do mês corrente.'},1,{'Informe uma data que esteja dentro do mês corrente.'},1)
		Return
	ENDIF

	IF aRet[1] > aRet[2] .AND. !Empty(aRet[1]) .AND. !Empty(aRet[2])
		ShowHelpDlg('BPCPA01',{'A Data Inicial De? não pode ser maior que Data Inicial Até?.'},1,{'Informe uma data menor para a Data Inicial De?.'},1)
		Return
	ENDIF*/

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta o aHeader e o aCols do GetDados³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCposSX3 := "D3_TM|D3_QUANT|D3_OP|D3_CC|D3_COD|D3_DESCRI|D3_UM|D3_QTDAPON|D3_LOCAL|D3_EMISSAO"
	
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
	
	//_dIniAte := DTOS(aRet[1])
	//_dIniDe  := Alltrim(Str(Year(dDatabase)))+StrZero(Month(dDataBase),2)+"01"

	_dApont	 := MV_PAR02
	_cLocDe	 := MV_PAR03
	_cPrdDe	 := MV_PAR04
	_cPrdAte := MV_PAR05
    _cOPDe	 := MV_PAR06
  	_cOPAte	 := MV_PAR07
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Monta itens com dados da OP ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	_cQry := "SELECT * "
	_cQry += " FROM "+RETSQLNAME("SC2")
	_cQry += " WHERE "
	_cQry += " C2_FILIAL = '"+XFILIAL("SD3")+"' "
	_cQry += " AND C2_PRODUTO BETWEEN '"+_cPrdDe+"' AND '"+_cPrdAte+"'"
	_cQry += " AND C2_DATPRI BETWEEN '"+MV_PAR01+"01' AND '"+MV_PAR01+"31'"
	_cQry += " AND C2_NUM+C2_ITEM+C2_SEQUEN BETWEEN '"+_cOPDe+"' AND '"+_cOPAte+"'"
	_cQry += " AND C2_LOCAL = '"+_cLocDe+"'"
	_cQry += " AND C2_QUANT > C2_QUJE "
	_cQry += " AND C2_DATRF = '' "
	_cQry += " AND D_E_L_E_T_ = '' "
	_cQry += " ORDER BY C2_XDESC "	
	TCQUERY _cQry NEW ALIAS "QSC2"
	
	IF QSC2->(!Eof())
	
		While QSC2->(!Eof())
		
			Aadd(aColDad1,Array(Len(aHedDad1) + 1))
			_nPosTM := AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_TM"})
			aColDad1[Len(aColDad1)][_nPosTM]	                                         := &(aHedDad1[_nPosTM][12]) 
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_COD"})]     := QSC2->C2_PRODUTO
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_DESCRI"})]  := QSC2->C2_XDESC
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_QUANT"})]   := QSC2->C2_QUANT - QSC2->C2_QUJE
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_QTDAPON"})] := 0
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_UM"})]      := QSC2->C2_UM	
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_CC"})]      := QSC2->C2_CC
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_OP"})]      := QSC2->C2_NUM+QSC2->C2_ITEM+QSC2->C2_SEQUEN
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_LOCAL"})]   := QSC2->C2_LOCAL
			aColDad1[Len(aColDad1)][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_EMISSAO"})] := MV_PAR02			
			
			aColDad1[Len(aColDad1)][Len(aHedDad1) + 1] := .F.
			
			QSC2->(dbSkip())
		EndDo	

	ELSE

		ShowHelpDlg('BPCPA01',{'Não há dados a serem exibidos.'},1,{'Verifique os parametros informados.'},1)
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
	oDlgSele := TDialog():New(100,001,oMainWnd:nClientHeight-30,oMainWnd:nClientWidth-40,OemToAnsi("Apontamento Ordens de Produção  - Lojas"),,,,,,,,oMainWnd,.T.)
	
	oGetDad1 := MsNewGetDados():New(aPosObj[2,1]-15,aPosObj[2,2],aPosObj[2,3]-45,aPosObj[2,4]-10,14,,,"",aAlter,,9999,,,,oDlgSele,aHedDad1,aColDad1)
	
	oDlgSele:Activate(,,,,,,{|| EnchoiceBar(oDlgSele,{|| nOpcSele := 1 , oDlgSele:End()},{|| oDlgSele:End()})})       

ELSE
	Return
ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Gravacao dos dados informados³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
If nOpcSele == 1

	Processa({|lEnd| BPCPA01P(@lEnd)},"Apontamento de OPs Lojas",OemToAnsi("Apontando OPs Loja..."),.F.)

EndIf

Return Nil

Static Function BPCPA01P(lContinua)                                                                                                                                 

	_dEmissao := MV_PAR02

	ProcRegua(Len(oGetDad1:aCols))

	For nCntItem := 1 To Len(oGetDad1:aCols)

		IF !oGetDad1:aCols[nCntItem][Len(oGetDad1:aHeader)+1] .AND. oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_QTDAPON"})] > 0     

			IncProc("MATA250 - Apontamento de OP "+oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_OP"})])

			aVetor := {}
			lMsErroAuto := .F.
            Begin Transaction

               aVetor:={{"D3_TM"      , oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_TM"})]      , NIL},;
                        {"D3_OP"      , oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_OP"})]      , NIL},;
                        {"D3_LOCAL"   , oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_LOCAL"})]   , NIL},;
                        {"D3_COD"     , oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_COD"})]     , NIL},;
                        {"D3_UM"      , oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_UM"})]      , NIL},;
                        {"D3_QUANT"   , oGetDad1:aCols[nCntItem][AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_QTDAPON"})] , NIL},;
                        {"D3_PERDA"   , 0                                                                             , NIL},;
                        {"D3_EMISSAO" , _dEmissao                                                                      , NIL},;
                        {"D3_PARCTOT" , "P"                                                                           , NIL}}

                //Inclusao
               MSExecAuto({|x,y| mata250(x,y)},aVetor,3)

               If lMsErroAuto
                  DisarmTransaction()
                  Mostraerro()
               Endif

            End Transaction

       ENDIF

	Next nCntItem

	MsgInfo("Apontamento de Ordens de Produção - Lojas finalizado.","Aviso")

Return

Static Function ValidPerg(cPerg)

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

DbSelectArea("SX1")
DbSetOrder(1)
dbGotop()
cPerg := PADR(cPerg,Len(SX1->X1_GRUPO))

Aadd(aRegs,{cPerg,"01","Ano/Mes Ord. Produção (AAAAMM)","                              ","                              ","MV_CH1","C",6                    ,0,0,"G",""                   ,"MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"02","Dt. real da produção apontada ","                              ","                              ","MV_CH2","D",8                    ,0,0,"G",""                   ,"MV_PAR02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"03","Armazém                       ","                              ","                              ","MV_CH3","C",TAMSX3("D3_LOCAL")[1],0,0,"G",""                   ,"MV_PAR03","","","","","","","","","","","","","","","","","","","","","","","","","NNR",""})
Aadd(aRegs,{cPerg,"04","Produto Inicial               ","                              ","                              ","MV_CH4","C",TAMSX3("D3_COD")[1]  ,0,0,"G",""                   ,"MV_PAR04","","","","","","","","","","","","","","","","","","","","","","","","","SB1",""})
Aadd(aRegs,{cPerg,"05","Produto Final                 ","                              ","                              ","MV_CH5","C",TAMSX3("D3_COD")[1]  ,0,0,"G",""                   ,"MV_PAR05","","","","","","","","","","","","","","","","","","","","","","","","","SB1",""})
Aadd(aRegs,{cPerg,"06","Ordem de Produção Inicial     ","                              ","                              ","MV_CH6","C",11                   ,0,0,"G",""                   ,"MV_PAR06","","","","","","","","","","","","","","","","","","","","","","","","","SC2",""})
Aadd(aRegs,{cPerg,"07","Ordem de Produção Final       ","                              ","                              ","MV_CH7","C",11                   ,0,0,"G",""                   ,"MV_PAR07","","","","","","","","","","","","","","","","","","","","","","","","","SC2",""})

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
