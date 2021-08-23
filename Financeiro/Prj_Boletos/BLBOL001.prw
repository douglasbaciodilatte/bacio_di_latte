#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BLBOL001   ºAutor  ³Vanito Rocha      Fº Data ³  20/08/20   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao do Boleto Bradesco com codigo de barras           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function BLBOL001(cCliente, cLoja,cDoc)

Local	aPergs  := {}
Local	_lCont	:= .T.
Local _cSql := ""
Local _nopc := 0
Local _nJaImp := 0
Private cBanco := SuperGetMV("MV_XBLBCO",.F.)
Private cAgencia := SuperGetMV("MV_XBLAGEN",.F.)
Private cConta := Alltrim(SuperGetMV("MV_XBLCC",.F.))
Private lExec := .F.
Private cIndexName := ''
Private cIndexKey := ''
Private cFilter := ''
Private _nImp := 2
Private cNumRural
Private cDigRural
Private nRow1:=0
Private nRow2:=800
Private nRow3:=2100
Private aLB1 := {}
Private oLB1
Private oOk		:= LoadBitMap(GetResources(), "LBOK")
Private oNo		:= LoadBitMap(GetResources(), "LBNO")
Private oPrint
Private _cNome := Space(35)
Private cPerg := Padr("BLBOL01",10)
Private _cValor := 0.00


AjustaSX1()

If FunName() = "BLBOL001"
	Pergunte (cPerg,.T.)
	
	cClieDe := MV_PAR01
	cClieAt := MV_PAR02
	cLojaDe := MV_PAR03
	cLojaAt := MV_PAR04
	dEmisDe := DTOS(MV_PAR05)
	dEmisAt := DTOS(MV_PAR06)
	dVencDe := DTOS(MV_PAR07)
	dVencAt := DTOS(MV_PAR08)
	cBanco  := MV_PAR09
	cAgencia:= MV_PAR10
	cConta  := MV_PAR11
Else
	cClieDe := cCliente
	cClieAt := cCliente
	cLojaDe := cLoja
	cLojaAt := cLoja
Endif

_cSql := " SELECT E1_PREFIXO,E1_NUM,E1_PARCELA,E1_PORTADO, E1_AGEDEP, E1_CONTA, E1_CLIENTE,E1_LOJA,A1_NOME,A1_NREDUZ,E1_EMISSAO,E1_VENCREA,E1_SALDO,E1_NUMBCO,E1_TIPO,E1_FILORIG "
_cSql += " FROM "+RETSQLNAME("SE1")+" SE1 "
_cSql += " INNER JOIN "+RETSQLNAME("SA1")+" SA1 ON A1_COD = E1_CLIENTE AND A1_LOJA = E1_LOJA AND SA1.D_E_L_E_T_ = ' ' "
_cSql += " WHERE SE1.D_E_L_E_T_ = ' ' AND  "
_cSql += " E1_CLIENTE BETWEEN '"+cClieDe+"' AND '"+cClieAt+"' AND "
_cSql += " E1_LOJA BETWEEN '"+cLojaDe+"' AND '"+cLojaAt+"' AND E1_SALDO > 0.00 AND "
If funname() == "BLBOL001"
	_cSql += " E1_EMISSAO BETWEEN '"+DTOS(MV_PAR05)+"' AND '"+DTOS(MV_PAR06)+"' AND "
	_cSql += " E1_VENCREA BETWEEN '"+DTOS(MV_PAR07)+"' AND '"+DTOS(MV_PAR08)+"' AND "
Else
	_cSql += " E1_NUM BETWEEN '"+cDoc+"' AND '"+cDoc+"' AND "
Endif
_cSql += " E1_TIPO IN('BOL','BO','NF') "
_cSql += " ORDER BY E1_CLIENTE,E1_EMISSAO,E1_NUM "

_cSql := ChangeQuery(_cSql)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cSql),"SE1TMP")

TCSETFIELD("SE1TMP","E1_EMISSAO","D",8,0)
TCSETFIELD("SE1TMP","E1_VENCREA","D",8,0)

aLB1:= {}

WHILE !SE1TMP->(EOF())
	_cPedido := SPACE(06)
	
	DbSelectArea("SC5")
	SC5->(DbSetOrder(6))
	If DbSeek(XFILIAL("SC5")+SE1TMP->E1_PREFIXO+SE1TMP->E1_NUM)
		_cPedido := SC5->C5_NUM
	Endif
	
	Aadd(aLB1,{" ",SE1TMP->E1_PREFIXO,SE1TMP->E1_NUM,SE1TMP->E1_PARCELA,SE1TMP->E1_CLIENTE,SE1TMP->E1_LOJA,;
	SE1TMP->A1_NOME,SE1TMP->A1_NREDUZ,SE1TMP->E1_TIPO,SE1TMP->E1_EMISSAO,SE1TMP->E1_VENCREA,SE1TMP->E1_SALDO,IIF(Empty(SE1TMP->E1_NUMBCO),"NAO","SIM"),;
	_cPedido})
	
	If Empty(SE1TMP->E1_NUMBCO)
		TRAF237X(SE1TMP->E1_PREFIXO , SE1TMP->E1_NUM, SE1TMP->E1_PARCELA , SE1TMP->E1_TIPO)
	Endif

	SE1TMP->(DbSkip())
ENDDO
SE1TMP->(DbCloseArea())

If FunName() = "BLBOL001"
	IF LEN(aLB1) = 0
		MsgInfo("Nao Existem Dados para os parametros fornecidos")
	Else
		
		DEFINE MSDIALOG _oDlgNf TITLE "Selecione os Titulos para Impressao de Boleto " FROM C(178),C(181) TO C(548),C(885) PIXEL
		@ C(007),C(005) ListBox oLB1 Fields ;
		HEADER "","Prefixo","Numero","Prc","Cliente","Loja","Razao Social","Nome Fantasia","Tipo","Emissao","Venc.Real","Valor","Impressao","Pedido";
		Size C(345),C(163) Of _oDlgNf Pixel;
		ColSizes 15,15,30,15,30,15,40,40,20,40,40,40,20,30
		oLB1:SetArray(aLB1)
		
		oLB1:bLine := {|| {;
		IIF(aLB1[oLB1:nAT,01]=' ',oNo,oOk),;
		aLB1[oLB1:nAT,02],;
		aLB1[oLB1:nAT,03],;
		aLB1[oLB1:nAT,04],;
		aLB1[oLB1:nAT,05],;
		aLB1[oLB1:nAT,06],;
		aLB1[oLB1:nAT,07],;
		aLB1[oLB1:nAT,08],;
		aLB1[oLB1:nAT,09],;
		aLB1[oLB1:nAT,10],;
		aLB1[oLB1:nAT,11],;
		aLB1[oLB1:nAT,12],;
		aLB1[oLB1:nAT,13],;
		aLB1[oLB1:nAT,14] }}
		
		oLb1:bLDblClick := {|| aLB1[oLB1:nAt,01] := iif(aLB1[oLB1:nAt,01]=' ','*',' '), oLb1:Refresh() }
		@ C(172),C(010) Say "Nome do Cliente " PIXEL OF _oDlgNf
		@ C(171),C(040) MsGet oNome Var _cNome Picture "@!" When .T. Size C(100),C(8) PIXEL OF _oDlgNf
		@ C(172),C(150) Button "Procurar"        Size C(050),C(012) ACTION (SearchNome(_cNome)) PIXEL OF _oDlgNf
		@ C(172),C(200) Button "Marcar Todos"    Size C(050),C(012) ACTION (MarcTodos()) PIXEL OF _oDlgNf
		@ C(172),C(250) Button "Impressao"       Size C(050),C(012) ACTION (_nOpc:= 1,_oDlgNf:End()) PIXEL OF _oDlgNf
		@ C(172),C(300) Button "Fechar "         Size C(050),C(012) ACTION (_nOpc:= 2,_oDlgNf:End()) PIXEL OF _oDlgNf
		ACTIVATE MSDIALOG _oDlgNf CENTERED
		IF _nOpc = 1
			//Inicia objeto oPrint
			oPrint:= TMSPrinter():New( "Boleto Laser" )
			oPrint:SetPortrait() // Modo Retrato
			oPrint:SetPaperSize(9) // Tipo de Folha para Impressao A4
			oPrint:StartPage()   // Inicia uma nova página
			For _nI := 1 to len(aLb1)
				If aLb1[_nI,1] = '*'
					LjMsgRun("Aguarde ... Gerando Selecao",,{|| MontaRel(aLb1[_nI,02],aLb1[_nI,03],aLb1[_nI,04],aLb1[_nI,05],aLb1[_nI,06],aLb1[_nI,09],aLb1[_nI,14]) })
				Endif
			Next
			//Finaliza objeto oPrint
			oPrint:EndPage()
			oPrint:Preview()
		Endif
	Endif
Else
	//Inicia objeto oPrint
	oPrint:= TMSPrinter():New( "Boleto Laser" )
	oPrint:SetPortrait() // Modo Retrato
	oPrint:SetPaperSize(9) // Tipo de Folha para Impressao A4
	oPrint:StartPage()   // Inicia uma nova página
	For _nI := 1 to len(aLb1)
		aLb1[_nI,1]:='*'
		If aLb1[_nI,1] = '*'
			LjMsgRun("Aguarde ... Gerando Selecao",,{|| MontaRel(aLb1[_nI,02],aLb1[_nI,03],aLb1[_nI,04],aLb1[_nI,05],aLb1[_nI,06],aLb1[_nI,09],aLb1[_nI,14]) })
		Endif
	Next
	//Finaliza objeto oPrint
	oPrint:EndPage()
	oPrint:Preview()
Endif
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MontaRel   ºAutor  ³Vanito Rocha      Fº Data ³  21/08/20   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao do Boleto Bradesco com codigo de barras           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function MontaRel(_cPrf,_cNum,_cPrc,_cCli,_cLoj,_cTip,_cSC5)

Local nX := 0
Local cNroDoc :=  " "
Local aDadosEmp    := {	SM0->M0_NOMECOM                                    ,; 						 //[1]Nome da Empresa
SM0->M0_ENDCOB                                     								,; 						 //[2]Endereço
AllTrim(SM0->M0_BAIRCOB)+", "+AllTrim(SM0->M0_CIDCOB)+", "+SM0->M0_ESTCOB 	,; //[3]Complemento
"CEP: "+Subs(SM0->M0_CEPCOB,1,5)+"-"+Subs(SM0->M0_CEPCOB,6,3)             	,; //[4]CEP
"PABX/FAX: "+SM0->M0_TEL                                                  	,; //[5]Telefones
"CNPJ: "+Subs(SM0->M0_CGC,1,2)+"."+Subs(SM0->M0_CGC,3,3)+"."+          	  	; 	 //[6]
Subs(SM0->M0_CGC,6,3)+"/"+Subs(SM0->M0_CGC,9,4)+"-"+                       ; //[6]
Subs(SM0->M0_CGC,13,2)                                                    ,; //[6]CGC
"I.E.: "+Subs(SM0->M0_INSC,1,3)+"."+Subs(SM0->M0_INSC,4,3)+"."+            ; //[7]
Subs(SM0->M0_INSC,7,3)+"."+Subs(SM0->M0_INSC,10,3)                         }  //[7]I.E

Local aDadosTit
Local aDadosBanco
Local aDatSacado
Local nI           := 1
Local aCB_RN_NN    := {}
Local aBolText     := {}
Local _cSeq		   := ""
Private nVlrAbat	   := 0

ProcRegua(Len(aLB1))

DbSelectArea("SE1")
DbSetOrder(2)
DbGotop()
If DbSeek(xFilial("SE1")+_cCli+_cLoj+_cPrf+_cNum+_cPrc+_cTip)
	While SE1->E1_FILIAL+SE1->E1_CLIENTE+SE1->E1_LOJA+SE1->E1_PREFIXO+SE1->E1_NUM+SE1->E1_PARCELA+SE1->E1_TIPO == xFilial("SE1")+_cCli+_cLoj+_cPrf+_cNum+_cPrc+_cTip
		IncProc("Espere gerando....")
		
		_lCont := .T.
		//------------------------------------------------------------------
		//Posiciona cabastro de banco
		//------------------------------------------------------------------
		DbSelectArea("SA6")
		DbSetOrder(1)

		If !DbSeek(xFilial("SA6")+PadR(cBanco, TamSX3("A6_COD")[1]) + PadR(cAgencia, TamSX3("A6_AGENCIA")[1]) + PadR(cConta, TamSX3("A6_NUMCON")[1]))
			_lCont := .F.
			If !_lCont
				MsgAlert("Nao encontrado Banco,Agencia ou Conta no Cadastro de Bancos","Atencao")
				Return
			Endif
		Endif
		
		//------------------------------------------------------------------
		//Posiciona parametros CNAB
		//------------------------------------------------------------------
		
		If _lCont
			DbSelectArea("SEE")
			DbSetOrder(1)
			If !DbSeek(xFilial("SEE")+PadR(cBanco, TamSX3("A6_COD")[1]) + PadR(cAgencia, TamSX3("A6_AGENCIA")[1]) + PadR(cConta, TamSX3("A6_NUMCON")[1]))
				_lCont := .F.
				
				If !_lCont
					MsgAlert("Nao encontrado Banco,Agencia ou Conta nos Cadastros dos Parâmetros CNAB","Atencao")
					Return
				Endif
			Endif
		Endif
		
		//------------------------------------------------------------------
		//Posiciona cadastro de clientes
		//------------------------------------------------------------------
		
		If _lCont
			DbSelectArea("SA1")
			DbSetOrder(1)
			If !DbSeek(xFilial("SA1")+SE1->E1_CLIENTE+SE1->E1_LOJA)
				_lCont := .F.
			Endif
		Endif
		
		//------------------------------------------------------------------
		//Dados do Banco
		//------------------------------------------------------------------
		
		If _lCont
			DbSelectArea("SE1")
			aDadosBanco  := {SA6->A6_COD,;					// [1]Numero do Banco
			ALLTRIM(SA6->A6_NOME),;							// [2]Nome do Banco Convenio
			STRZERO(VAL(SA6->A6_AGENCIA),4,0),;				// [3]Agência Convenio
			STRZERO(VAL(SA6->A6_NUMCON),7,0),;				// [4]Conta Corrente Convenio
			SA6->A6_DVCTA,;									// [5]Dígito da Conta Corrente Convenio
			"09",;											// [6]Codigo da Carteira
			SA6->A6_DVAGE,;									// [7]Dígito da Agencia Convenio
			" ",;											// [8]Clip Convenio
			"DM" }											// [9]Especie Convenio
			/*
			De Acordo com o Manual do Bradesco Páginas 30/31
			*/
			
			
			//------------------------------------------------------------------
			//Dados do cliente
			//------------------------------------------------------------------
			
			If Empty(SA1->A1_ENDCOB)
				aDatSacado   := {AllTrim(SA1->A1_NOME),;				// [1]Razão Social
				AllTrim(SA1->A1_COD ),;									// [2]Código
				AllTrim(SA1->A1_END )+"-"+AllTrim(SA1->A1_BAIRRO),;		// [3]Endereço
				AllTrim(SA1->A1_MUN ),;									// [4]Cidade
				SA1->A1_EST,;   										// [5]Estado
				SA1->A1_CEP,;    										// [6]CEP
				SA1->A1_CGC,;											// [7]CGC
				SA1->A1_PESSOA,;   										// [8]PESSOA
				SA1->A1_LOJA}		   									// [9]LOJA
			Else
				aDatSacado   := {AllTrim(SA1->A1_NOME),;				// [1]Razão Social
				AllTrim(SA1->A1_COD),;  								// [2]Código
				AllTrim(SA1->A1_ENDCOB)+"-"+AllTrim(SA1->A1_BAIRROC),;	// [3]Endereço
				AllTrim(SA1->A1_MUNC),;									// [4]Cidade
				SA1->A1_ESTC,; 											// [5]Estado
				SA1->A1_CEPC,; 											// [6]CEP
				SA1->A1_CGC,;											// [7]CGC
				SA1->A1_PESSOA,;										// [8]PESSOA
				SA1->A1_LOJA}		   									// [9]LOJA
			Endif
			nVlrAbat   :=  SomaAbat(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,"R",1,,SE1->E1_CLIENTE,SE1->E1_LOJA)
			nVlrAbat   +=  SE1->E1_DECRESC
			//-----------------------------------------------------------------
			//Definicao do nosso numero
			//------------------------------------------------------------------
			
			IF EMPTY(SE1->E1_NUMBCO)
				IF Empty(SEE->EE_FAXATU)
					_cSeq := StrZero(0,11)
				Else
					_cSeq := StrZero(Val(SEE->EE_FAXATU),11)
				Endif
				_cSeq2 := Soma1(_cSeq)
				DbSelectArea("SEE")
				Reclock("SEE",.F.)
				SEE->EE_FAXATU := _cSeq2
				MsUnlock()
				DbSelectArea("SE1")
				cNroDoc	:= AllTrim(SEE->EE_CODCART)+AllTrim(SEE->EE_FAXATU) //"09"+Alltrim(Str(YEAR(MSDATE())))+_cSeq
			ELSE
				cNroDoc	:= SubStr(ALLTRIM(SE1->E1_NUMBCO),1,13) //SubStr(ALLTRIM(SE1->E1_NRDOC),1,13)
			ENDIF
			
			//------------------------------------------------------------------
			//Monta codigo de barras
			//------------------------------------------------------------------
			_cValor := (SE1->E1_SALDO-nVlrAbat)
			
			aCB_RN_NN   := Ret_cBarra(	SE1->E1_PREFIXO	,SE1->E1_NUM	,SE1->E1_PARCELA	,SE1->E1_TIPO	,;
			Subs(aDadosBanco[1],1,3)	,aDadosBanco[3]	,aDadosBanco[4] ,aDadosBanco[5]	,;
			cNroDoc		,_cValor	, "09","7")
			
			aDadosTit	:= {AllTrim(E1_NUM)+IIf(!Empty(E1_PARCELA),"-","")+AllTrim(E1_PARCELA)		,;  // [1] Número do título
			E1_EMISSAO                          ,;  // [2] Data da emissão do título
			dDataBase                    	    ,;  // [3] Data da emissão do boleto
			E1_VENCREA                           ,;  // [4] Data do vencimento
			_cValor			               ,;  		// [5] Valor do título
			aCB_RN_NN[3]                        ,;  // [6] Nosso número (Ver fórmula para calculo)
			E1_PREFIXO                          ,;  // [7] Prefixo da NF
			E1_TIPO	                           	}   // [8] Tipo do Titulo
			
			aBolText := {}
			DbSelectArea("SE1")
			_nJurosMes := 1/30 						//Getmv("MV_TXPER")*30
			_nJurosDia := 10/30 					//Getmv("MV_TXPER")
			_nMulta:= 2 							//Getmv("MV_MULTA")
			If _nJurosDia > 0
				vlr_juros  := Transform( (( _cValor * _nJurosDia ) / 100) , '@E 999,999.99' )
				vlr_jurosM := Transform( _nJurosMes , '@E 99.99' )
				vlr_MultaP := Transform( _nMulta , '@E 99.99' )
			Endif
			If _nMulta > 0
				vlr_Multa  := Transform( (( _cValor * _nMulta ) / 100) , '@E 999,999.99' )
			Endif
			v_obs1     := '*** VALORES EXPRESSOS EM REAIS ***'
			v_obs2     := "SUJEITO A PROTESTO APOS 5(CINCO) DIAS UTEIS DO VENCIMENTO"
			If _nMulta > 0 .And. _nJurosDia > 0
				v_obs3     := 'JUROS DE MORA DIARIA DE '+'R$'+ltrim( vlr_juros )+' E MULTA MES DE '+'R$'+ltrim( vlr_Multa )+' A PARTIR DE '+DTOC(E1_VENCTO)+' '
			Else
				v_obs3 := ""
			Endif
			If !(_cSC5 = "XXXXXX") .And. !Empty(_cSC5)
				v_obs4     := 'REFERENTE AO PEDIDO N. '+_cSC5
			Else
				v_obs4     := ''
			Endif
			If !EMPTY(SE1->E1_NUMBCO)
				v_obs5     := '*** REIMPRESSAO DE BOLETO ****'
			Else
				v_obs5     := ''
			Endif
			v_obs6     := 'NAO RECEBER APOS 10 DIAS DA DATA '+DTOC(E1_VENCREA)
			
			AADD(aBolText,v_obs1)
			AADD(aBolText,v_obs2)
			AADD(aBolText,v_obs3)
			AADD(aBolText,v_obs4)
			AADD(aBolText,v_obs5)
			AADD(aBolText,v_obs6)
			//------------------------------------------------------------------
			//Imprime boleto
			//------------------------------------------------------------------
			
			Impress(oPrint,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,aCB_RN_NN)
			
			nX := nX + 1
			
			IncProc()
			DbSkip()
			
			nI := nI + 1
		Endif
		DbSelectArea("SE1")
		DbSkip()
	Enddo
Endif
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³Impress    ºAutor  ³Vanito Rocha      Fº Data ³  21/08/20   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao do Boleto Bradesco com codigo de barras           º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function Impress(oPrint,aDadosEmp,aDadosTit,aDadosBanco,aDatSacado,aBolText,aCB_RN_NN)
LOCAL nI := 0

Local oFont8   := TFont():New("Arial",9,8,.T.,.F.,5,.T.,5,.T.,.F.)
Local oFont11c := TFont():New("Courier New",9,11,.T.,.T.,5,.T.,5,.T.,.F.)
Local oFont11  := TFont():New("Arial",9,11,.T.,.T.,5,.T.,5,.T.,.F.)
Local oFont10  := TFont():New("Arial",9,10,.T.,.T.,5,.T.,5,.T.,.F.)
Local oFont14  := TFont():New("Arial",9,14,.T.,.T.,5,.T.,5,.T.,.F.)
Local oFont20  := TFont():New("Arial",9,20,.T.,.T.,5,.T.,5,.T.,.F.)
Local oFont21  := TFont():New("Arial",9,21,.T.,.T.,5,.T.,5,.T.,.F.)
Local oFont16n := TFont():New("Arial",9,16,.T.,.F.,5,.T.,5,.T.,.F.)
Local oFont15  := TFont():New("Arial",9,15,.T.,.T.,5,.T.,5,.T.,.F.)
Local oFont15n := TFont():New("Arial",9,15,.T.,.F.,5,.T.,5,.T.,.F.)
Local oFont14n := TFont():New("Arial",9,14,.T.,.F.,5,.T.,5,.T.,.F.)
Local oFont24  := TFont():New("Arial",9,24,.T.,.T.,5,.T.,5,.T.,.F.)
Local oFont10a := TFont():New("Arial",9,10,.T.,.F.,5,.T.,5,.T.,.F.)
oPrint:StartPage()
/*
------------------------------------------------------------------
Primeira parte
------------------------------------------------------------------
*/
nRow1 := 0
oPrint:Line (nRow1+0150,500,nRow1+0070, 500)					 				// LINHA VERTICAL
oPrint:Line (nRow1+0150,710,nRow1+0070, 710)									// LINHA VERTICAL
oPrint:Line (nRow1+0250,1030,nRow1+0150, 1030)   									// LINHA VERTICAL
oPrint:SayBitmap (nRow1+0055,100,"\System\Imagens\logobra.png",350,80 )			// [2]Nome do Banco
oPrint:Say  (nRow1+0075,513,aDadosBanco[1]+"-2",oFont21 )						// [1]Numero do Banco
oPrint:Say  (nRow1+0084,1900,"Aceite do Titulo",oFont10)
oPrint:Line (nRow1+0150,100,nRow1+0150,2300) 									// LINHA HORIZONTAL
oPrint:Say  (nRow1+0150,100 ,"Beneficiário",oFont8)
oPrint:Say  (nRow1+0200,100 ,aDadosEmp[1] ,oFont10)								//Nome
oPrint:Say  (nRow1+0170,1040 ,"Nosso Numero",oFont8)
oPrint:Say  (nRow1+0200,1040,SUBSTR(aDadosTit[6],1,2)+"/"+SUBSTR(aDadosTit[6],3,11)+'-'+Substr(aDadosTit[6],14,1) ,oFont10)
oPrint:Say  (nRow1+0150,1510,"Agência/Código Beneficiário",oFont8)
If !Empty(aDadosBanco[7])
	oPrint:Say  (nRow1+0200,1510,aDadosBanco[3]+"-"+aDadosBanco[7]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5],oFont10)
Else
	oPrint:Say  (nRow1+0200,1510,aDadosBanco[3]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5],oFont10)
Endif
oPrint:Say  (nRow1+0150,1900,"Nro.Documento",oFont8)
oPrint:Say  (nRow1+0200,1900,aDadosTit[7]+aDadosTit[1],oFont10) //Prefixo +Numero+Parcela
oPrint:Say  (nRow1+0250,100 ,"Pagador",oFont8)
oPrint:Say  (nRow1+0300,100 ,aDatSacado[1]+" ("+aDatSacado[2]+" - "+aDatSacado[9]+")" ,oFont10)				//Nome aDatSacado[1],oFont10)
oPrint:Say  (nRow1+0250,1510,"Vencimento",oFont8)
oPrint:Say  (nRow1+0300,1510,StrZero(Day(aDadosTit[4]),2) +"/"+ StrZero(Month(aDadosTit[4]),2) +"/"+ Right(Str(Year(aDadosTit[4])),4),oFont10)
oPrint:Say  (nRow1+0250,1900,"Valor do Documento",oFont8)
oPrint:Say  (nRow1+0300,1940,AllTrim(Transform(aDadosTit[5],"@E 999,999,999.99")),oFont10)
oPrint:Say  (nRow1+0350,0100 ,"Pagador/Avalista",oFont8)
oPrint:Say  (nRow1+0450,0100,"Recebi(emos) o boleto/título com as características acima.",oFont10)
oPrint:Say  (nRow1+0510,0100,"Data",oFont8)
oPrint:Say  (nRow1+0510,0450,"Assinatura",oFont8)
oPrint:Say  (nRow1+0600,0100,"        /        /    ",oFont11)
If !Empty(aBolText[5])
	oPrint:Say  (nRow1+0680,0100,aBolText[5],oFont8)
Endif
oPrint:Line (nRow1+0250,100,nRow1+0250,2300)    //LINHA EMBAIXO DO BENEFICIÁRIO
oPrint:Line (nRow1+0350,100,nRow1+0350,2300)    //LINHA EMBAIXO DO SACADO
oPrint:Line (nRow1+0450,100,nRow1+0450,2300)    //LINHA EMBAIXO DO SACADOR/AVALISTA
oPrint:Line (nRow1+0500,100,nRow1+0500,2300)    //LINHA EMBAIXO DO RECEBI(EMOS)
oPrint:Line (nRow1+0650,100,nRow1+0650,2300)    //LINHA EMBAIXO DA ASSINATURA
oPrint:Line (nRow1+0350,1500,nRow1+0150,1500)
oPrint:Line (nRow1+0350,1890,nRow1+0150,1890)
oPrint:Line (nRow1+0500,0440,nRow1+0650,0440)   //LINHA VERTICAL DATA/ASSINATURA
/*
------------------------------------------------------------------
Segunda parte
------------------------------------------------------------------
*/

For nI := 100 to 2300 step 50								//Pontilhado separador
	oPrint:Line(nRow2, nI,nRow2, nI+30)
Next nI
oPrint:Line (nRow2+130,100,nRow2+130,2300)
oPrint:Line (nRow2+130,500,nRow2+50, 500)
oPrint:Line (nRow2+130,710,nRow2+50, 710)
oPrint:SayBitmap (nRow2+35,100,"\System\Imagens\logobra.png",350,80 )			// [2]Nome do Banco
oPrint:Say  (nRow2+055,513,aDadosBanco[1]+"-2",oFont21 )	// [1]Numero do Banco
oPrint:Say  (nRow2+064,1800,"Recibo do Pagador",oFont10)
oPrint:Line (nRow2+230,100,nRow2+230,2300)
oPrint:Line (nRow2+330,100,nRow2+330,2300)
oPrint:Line (nRow2+400,100,nRow2+400,2300)
oPrint:Line (nRow2+470,100,nRow2+470,2300)
oPrint:Line (nRow2+400,300,nRow2+470,300)// LINHA VERTICAL DO USO DO BANCO / CIP
oPrint:Line (nRow2+330,500,nRow2+470,500)
oPrint:Line (nRow2+400,750,nRow2+470,750)
oPrint:Line (nRow2+330,1000,nRow2+470,1000)
oPrint:Line (nRow2+330,1300,nRow2+400,1300)
oPrint:Line (nRow2+330,1480,nRow2+470,1480)
oPrint:Say  (nRow2+130,100 ,"Local de Pagamento",oFont8)
oPrint:Say  (nRow2+165,100 ,"Pagável preferencialmente na Rede Bradesco ou Bradesco Expresso",oFont10)
oPrint:Say  (nRow2+130,1810,"Vencimento"                                     ,oFont8)
cString	:= StrZero(Day(aDadosTit[4]),2) +"/"+ StrZero(Month(aDadosTit[4]),2) +"/"+ Right(Str(Year(aDadosTit[4])),4)
nCol := 1810+(374-(len(cString)*22))
oPrint:Say  (nRow2+170,nCol,cString,oFont11c)
oPrint:Say  (nRow2+230,100 ,"Beneficiário"                                        ,oFont8)
oPrint:Say  (nRow2+260,100 ,aDadosEmp[1]+" " +aDadosEmp[6],oFont10)
oPrint:Say  (nRow2+290,100 ,aDadosEmp[2],oFont10)
oPrint:Say  (nRow2+230,1810,"Agência/Código Beneficiário",oFont8)
If !Empty(aDadosBanco[7])
	cString := Alltrim(aDadosBanco[3]+"-"+aDadosBanco[7]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5])
Else
	cString := Alltrim(aDadosBanco[3]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5])
Endif
nCol := 1810+(374-(len(cString)*22))
oPrint:Say  (nRow2+270,nCol,cString,oFont11c)
oPrint:Say  (nRow2+330,100 ,"Data do Documento"                              ,oFont8)
oPrint:Say  (nRow2+360,100, StrZero(Day(aDadosTit[2]),2) +"/"+ StrZero(Month(aDadosTit[2]),2) +"/"+ Right(Str(Year(aDadosTit[2])),4),oFont10)
oPrint:Say  (nRow2+330,505 ,"Nro.Documento"                                  ,oFont8)
oPrint:Say  (nRow2+360,605 ,aDadosTit[7]+aDadosTit[1]						,oFont10) //Prefixo +Numero+Parcela
oPrint:Say  (nRow2+330,1005,"Espécie Doc."                                   ,oFont8)
oPrint:Say  (nRow2+360,1050,aDadosBanco[9],oFont10) //Tipo do Titulo
oPrint:Say  (nRow2+330,1305,"Aceite",oFont8)
oPrint:Say  (nRow2+360,1400,"N",oFont10) //De acordo com o Manual e segundo o Sidnei esse conteudo deve ser N para o Campo Aceite
oPrint:Say  (nRow2+330,1485,"Data do Processamento",oFont8)
oPrint:Say  (nRow2+360,1550,StrZero(Day(aDadosTit[3]),2) +"/"+ StrZero(Month(aDadosTit[3]),2) +"/"+ Right(Str(Year(aDadosTit[3])),4),oFont10)
oPrint:Say  (nRow2+330,1810,"Nosso Número",oFont8)
cString := ALLTRIM(SUBSTR(aDadosTit[6],1,2)+"/"+SUBSTR(aDadosTit[6],3,11)+'-'+Substr(aDadosTit[6],14,1))
nCol := 1860+(374-(len(cString)*22))
oPrint:Say  (nRow2+360,nCol,cString,oFont11c)
oPrint:Say  (nRow2+400,100 ,"Uso do Banco",oFont8)
oPrint:Say  (nRow2+400,350 ,"Cip",oFont8)
oPrint:Say  (nRow2+430,350 ,"000",oFont10)
/*
A linha 525 e 526 Trata-se do CIP e de acordo com o Manual do Banco Bradesco deve ser feito conforme abaixo:
Trata-se de código utilizado para identificar mensagens especificas ao beneficiário,
sendo que o mesmo consta no cadastro do Banco, quando não houver código cadastrado
preencher com zeros "000".

*/
oPrint:Say  (nRow2+400,505 ,"Carteira",oFont8)
oPrint:Say  (nRow2+430,555 ,aDadosBanco[6],oFont10)
oPrint:Say  (nRow2+400,755 ,"Espécie",oFont8)
oPrint:Say  (nRow2+430,805 ,"R$",oFont10)
oPrint:Say  (nRow2+400,1005,"Quantidade",oFont8)
oPrint:Say  (nRow2+400,1485,"Valor",oFont8)
oPrint:Say  (nRow2+400,1810,"Valor do Documento",oFont8)
cString := Alltrim(Transform(aDadosTit[5],"@E 99,999,999.99"))
nCol := 1810+(374-(len(cString)*22))
oPrint:Say  (nRow2+430,nCol,cString ,oFont11c)
oPrint:Say  (nRow2+470,100 ,"Instruções (Todas informações deste boleto são de exclusiva responsabilidade do Beneficiário)",oFont8)
oPrint:Say  (nRow2+520,100 ,aBolText[1] ,oFont10a)
oPrint:Say  (nRow2+570,100 ,aBolText[2] ,oFont10a)
oPrint:Say  (nRow2+620,100 ,aBolText[3] ,oFont10a)
oPrint:Say  (nRow2+670,100 ,aBolText[4] ,oFont10a)
oPrint:Say  (nRow2+720,100 ,aBolText[6] ,oFont10a)
oPrint:Say  (nRow2+770,100 ,aBolText[5] ,oFont10a)
oPrint:Say  (nRow2+470,1810,"(-)Desconto/Abatimento"                         ,oFont8)
oPrint:Say  (nRow2+540,1810,"(-)Outras Deduções"                             ,oFont8)
oPrint:Say  (nRow2+610,1810,"(+)Mora/Multa"                                  ,oFont8)
oPrint:Say  (nRow2+680,1810,"(+)Outros Acréscimos"                           ,oFont8)
oPrint:Say  (nRow2+750,1810,"(=)Valor Cobrado"                               ,oFont8)
oPrint:Say  (nRow2+820,100 ,"Pagador"                                         ,oFont8)
oPrint:Say  (nRow2+830,300 ,aDatSacado[1]+" ("+aDatSacado[2]+" - "+aDatSacado[9]+")"             ,oFont10)
oPrint:Say  (nRow2+873,300 ,aDatSacado[3]                                    ,oFont10)
oPrint:Say  (nRow2+913,300 ,aDatSacado[6]+"    "+aDatSacado[4]+" - "+aDatSacado[5],oFont10) // CEP+Cidade+Estado
if aDatSacado[8] = "J"
	oPrint:Say  (nRow2+953,300 ,"CNPJ: "+TRANSFORM(aDatSacado[7],"@R 99.999.999/9999-99"),oFont10) // CGC
Else
	oPrint:Say  (nRow2+953,300 ,"CPF: "+TRANSFORM(aDatSacado[7],"@R 999.999.999-99"),oFont10) 	// CPF
EndIf

oPrint:Say  (nRow2+1009,2000,Left(aDadosTit[6],13)+'-'+Substr(aDadosTit[6],14,1) ,oFont10)
oPrint:Say  (nRow2+1025,100 ,"Pagador/Avalista",oFont8)
oPrint:Say  (nRow2+1075,1500,"Autenticação Mecânica",oFont8)
oPrint:Say  (nRow2+1075,1850,"Ficha de Compensação",oFont10a)
oPrint:Line (nRow2+130,1800,nRow2+820,1800 )
oPrint:Line (nRow2+540,1800,nRow2+540,2300 )
oPrint:Line (nRow2+610,1800,nRow2+610,2300 )
oPrint:Line (nRow2+680,1800,nRow2+680,2300 )
oPrint:Line (nRow2+750,1800,nRow2+750,2300 )
oPrint:Line (nRow2+820,100 ,nRow2+820,2300 )
oPrint:Line (nRow2+1060,100 ,nRow2+1060,2300 )
/*
------------------------------------------------------------------
Terceira parte
------------------------------------------------------------------
*/

For nI := 100 to 2300 step 50								//Pontilhado separador
	oPrint:Line(nRow3, nI,nRow3, nI+30)
Next nI
oPrint:Line (nRow3+130,100,nRow3+130,2300)
oPrint:Line (nRow3+130,500,nRow3+50, 500)
oPrint:Line (nRow3+130,710,nRow3+50, 710)

oPrint:SayBitmap (nRow3+35,100,"\System\Imagens\logobra.png",350,80 )			// [2]Nome do Banco
oPrint:Say  (nRow3+055,513,"237"+"-2",oFont21 )	// 	[1]Numero do Banco

oPrint:Say  (nRow3+054,755,aCB_RN_NN[2],oFont14n)			// Impressao da Linha Digitavel
oPrint:Line (nRow3+230,100,nRow3+230,2300)
oPrint:Line (nRow3+330,100,nRow3+330,2300)
oPrint:Line (nRow3+400,100,nRow3+400,2300)
oPrint:Line (nRow3+470,100,nRow3+470,2300)
oPrint:Line (nRow3+400,300,nRow3+470,300)// LINHA VERTICAL DO USO DO BANCO / CIP
oPrint:Line (nRow3+330,500,nRow3+470,500)
oPrint:Line (nRow3+400,750,nRow3+470,750)
oPrint:Line (nRow3+330,1000,nRow3+470,1000)
oPrint:Line (nRow3+330,1300,nRow3+400,1300)
oPrint:Line (nRow3+330,1480,nRow3+470,1480)
oPrint:Say  (nRow3+130,100 ,"Local de Pagamento",oFont8)
oPrint:Say  (nRow3+165,100 ,"Pagável preferencialmente na Rede Bradesco ou Bradesco Expresso",oFont10)
oPrint:Say  (nRow3+130,1810,"Vencimento"                                     ,oFont8)
cString	:= StrZero(Day(aDadosTit[4]),2) +"/"+ StrZero(Month(aDadosTit[4]),2) +"/"+ Right(Str(Year(aDadosTit[4])),4)
nCol := 1810+(374-(len(cString)*22))
oPrint:Say  (nRow3+170,nCol,cString,oFont11c)
oPrint:Say  (nRow3+230,100 ,"Beneficiário"                                        ,oFont8)
oPrint:Say  (nRow3+260,100 ,aDadosEmp[1]+" " +aDadosEmp[6],oFont10)
oPrint:Say  (nRow3+290,100 ,aDadosEmp[2],oFont10)
oPrint:Say  (nRow3+230,1810,"Agência/Código Beneficiário",oFont8)
If !Empty(aDadosBanco[7])
	cString := Alltrim(aDadosBanco[3]+"-"+aDadosBanco[7]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5])
Else
	cString := Alltrim(aDadosBanco[3]+"/"+aDadosBanco[4]+"-"+aDadosBanco[5])
Endif

nCol := 1810+(374-(len(cString)*22))
oPrint:Say  (nRow3+270,nCol,cString,oFont11c)
oPrint:Say  (nRow3+330,100 ,"Data do Documento"                              ,oFont8)
oPrint:Say  (nRow3+360,100, StrZero(Day(aDadosTit[2]),2) +"/"+ StrZero(Month(aDadosTit[2]),2) +"/"+ Right(Str(Year(aDadosTit[2])),4),oFont10)
oPrint:Say  (nRow3+330,505 ,"Nro.Documento"                                  ,oFont8)
oPrint:Say  (nRow3+360,605 ,aDadosTit[7]+aDadosTit[1]						,oFont10) //Prefixo +Numero+Parcela
oPrint:Say  (nRow3+330,1005,"Espécie Doc."                                   ,oFont8)
oPrint:Say  (nRow3+360,1050,aDadosBanco[9],oFont10) //Tipo do Titulo
oPrint:Say  (nRow3+330,1305,"Aceite",oFont8)
oPrint:Say  (nRow3+360,1400,"N",oFont10)
oPrint:Say  (nRow3+330,1485,"Data do Processamento",oFont8)
oPrint:Say  (nRow3+360,1550,StrZero(Day(aDadosTit[3]),2) +"/"+ StrZero(Month(aDadosTit[3]),2) +"/"+ Right(Str(Year(aDadosTit[3])),4),oFont10)
oPrint:Say  (nRow3+330,1810,"Nosso Número",oFont8)
cString := ALLTRIM(SUBSTR(aDadosTit[6],1,2)+"/"+SUBSTR(aDadosTit[6],3,11)+'-'+Substr(aDadosTit[6],14,1))
nCol := 1860+(374-(len(cString)*22))
oPrint:Say  (nRow3+360,nCol,cString,oFont11c)
oPrint:Say  (nRow3+400,100 ,"Uso do Banco",oFont8)
oPrint:Say  (nRow3+400,350 ,"Cip",oFont8)
oPrint:Say  (nRow3+430,400 ,"000",oFont10)//aqui


oPrint:Say  (nRow3+400,505 ,"Carteira",oFont8)
oPrint:Say  (nRow3+430,555 ,aDadosBanco[6],oFont10)
oPrint:Say  (nRow3+400,755 ,"Espécie",oFont8)
oPrint:Say  (nRow3+430,805 ,"R$",oFont10)
oPrint:Say  (nRow3+400,1005,"Quantidade",oFont8)
oPrint:Say  (nRow3+400,1485,"Valor",oFont8)
oPrint:Say  (nRow3+400,1810,"Valor do Documento",oFont8)
cString := Alltrim(Transform(aDadosTit[5],"@E 99,999,999.99"))
nCol := 1810+(374-(len(cString)*22))
oPrint:Say  (nRow3+430,nCol,cString ,oFont11c)
oPrint:Say  (nRow3+470,100 ,"Instruções (Todas informações deste boleto são de exclusiva responsabilidade do Beneficiário)",oFont8)
oPrint:Say  (nRow3+520,100 ,aBolText[1] ,oFont10a)
oPrint:Say  (nRow3+570,100 ,aBolText[2] ,oFont10a)
oPrint:Say  (nRow3+620,100 ,aBolText[3] ,oFont10a)
oPrint:Say  (nRow3+670,100 ,aBolText[4] ,oFont10a)
oPrint:Say  (nRow3+720,100 ,aBolText[6] ,oFont10a)
oPrint:Say  (nRow3+770,100 ,aBolText[5] ,oFont10a)
oPrint:Say  (nRow3+470,1810,"(-)Desconto/Abatimento"                         ,oFont8)
oPrint:Say  (nRow3+540,1810,"(-)Outras Deduções"                             ,oFont8)
oPrint:Say  (nRow3+610,1810,"(+)Mora/Multa"                                  ,oFont8)
oPrint:Say  (nRow3+680,1810,"(+)Outros Acréscimos"                           ,oFont8)
oPrint:Say  (nRow3+750,1810,"(=)Valor Cobrado"                               ,oFont8)
oPrint:Say  (nRow3+820,100 ,"Pagador"                                         ,oFont8)
oPrint:Say  (nRow3+830,300 ,aDatSacado[1]+" ("+aDatSacado[2]+" - "+aDatSacado[9]+")"             ,oFont10)
oPrint:Say  (nRow3+873,300 ,aDatSacado[3]                                    ,oFont10)
oPrint:Say  (nRow3+913,300 ,aDatSacado[6]+"    "+aDatSacado[4]+" - "+aDatSacado[5],oFont10) // CEP+Cidade+Estado
if aDatSacado[8] = "J"
	oPrint:Say  (nRow3+953,300 ,"CNPJ: "+TRANSFORM(aDatSacado[7],"@R 99.999.999/9999-99"),oFont10) // CGC
Else
	oPrint:Say  (nRow3+953,300 ,"CPF: "+TRANSFORM(aDatSacado[7],"@R 999.999.999-99"),oFont10) 	// CPF
EndIf
oPrint:Say  (nRow3+1009,2000,Left(aDadosTit[6],13)+'-'+Substr(aDadosTit[6],14,1) ,oFont10)
oPrint:Say  (nRow3+1025,100 ,"Pagador/Avalista",oFont8)
oPrint:Say  (nRow3+1075,1500,"Autenticação Mecânica",oFont8)
oPrint:Say  (nRow3+1075,1850,"Ficha de Compensação",oFont10a)
oPrint:Line (nRow3+130,1800,nRow3+820,1800 )
oPrint:Line (nRow3+540,1800,nRow3+540,2300 )
oPrint:Line (nRow3+610,1800,nRow3+610,2300 )
oPrint:Line (nRow3+680,1800,nRow3+680,2300 )
oPrint:Line (nRow3+750,1800,nRow3+750,2300 )
oPrint:Line (nRow3+820,100 ,nRow3+820,2300 )
oPrint:Line (nRow3+1060,100 ,nRow3+1060,2300 )
/*
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MSBAR       ³ Autor ³ ALEX SANDRO VALARIO ³ Data ³  06/99   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime codigo de barras                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 01 cTypeBar String com o tipo do codigo de barras          ³±±
±±³          ³ 				"EAN13","EAN8","UPCA" ,"SUP5"   ,"CODE128"    ³±±
±±³          ³ 				"INT25","MAT25,"IND25","CODABAR","CODE3_9"    ³±±
±±³          ³ 02 nRow		Numero da Linha em centimentros               ³±±
±±³          ³ 03 nCol		Numero da coluna em centimentros			  ³±±
±±³          ³ 04 cCode		String com o conteudo do codigo               ³±±
±±³          ³ 05 oPr		Obejcto Printer                               ³±±
±±³          ³ 06 lcheck	Se calcula o digito de controle               ³±±
±±³          ³ 07 Cor 		Numero  da Cor, utilize a "common.ch"         ³±±
±±³          ³ 08 lHort		Se imprime na Horizontal                      ³±±
±±³          ³ 09 nWidth	Numero do Tamanho da barra em centimetros     ³±±
±±³          ³ 10 nHeigth	Numero da Altura da barra em milimetros       ³±±
±±³          ³ 11 lBanner	Se imprime o linha em baixo do codigo         ³±±
±±³          ³ 12 cFont		String com o tipo de fonte                    ³±±
±±³          ³ 13 cMode		String com o modo do codigo de barras CODE128 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ ImpressÆo de etiquetas c¢digo de Barras para HP e Laser    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
If _nImp == 2 // Laser
	If CEMPANT = '21'
		If _nImp21 = 1 //Hp
			MSBAR2("INT25",27.0,.9,aCB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,.9,Nil,Nil,"A",.F.)
		ElseIf _nImp21 = 2 //Xeox
			MSBAR2("INT25",25.5,.9,aCB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.3,Nil,Nil,"A",.F.)
		ElseIf _nImp21 = 3 //Epson
			MSBAR2("INT25",25.5,.9,aCB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.4,Nil,Nil,"A",.F.)
		Endif
	ELSE
		MSBAR2("INT25",27.0,.9,aCB_RN_NN[1],oPrint,.F.,Nil,Nil,0.025,1.4,Nil,Nil,"A",.F.)
	Endif
Else
	MSBAR2("INT25",20.5,1,aCB_RN_NN[1],oPrint,.F.,Nil,Nil,0.010,1.0,Nil,Nil,"A",.F.)
Endif

IF EMPTY(SE1->E1_NUMBCO) .Or. Empty(SE1->E1_IDCNAB) .Or. SE1->E1_CODBAR <> aCB_RN_NN[1]
	DbSelectArea("SE1")
	RecLock("SE1",.f.)
	SE1->E1_IDCNAB  := SE1->(E1_PREFIXO+STRZERO(VAL(ALLTRIM(E1_NUM)),6,0)+E1_PARCELA)
	SE1->E1_PORTADO	:= SA6->A6_COD
	SE1->E1_AGEDEP	:= SA6->A6_AGENCIA
	SE1->E1_CONTA	:= SA6->A6_NUMCON+SA6->A6_DVCTA
	SE1->E1_NUMBCO	:= AllTrim(aCB_RN_NN[3])  //substr(aCB_RN_NN[3], 7, 8)
	SE1->E1_CODBAR	:= aCB_RN_NN[1]
	SE1->E1_NRDOC	:= AllTrim(aCB_RN_NN[3])
	SE1->E1_OCORREN	:= "01"
	MsUnlock()
ENDIF
aCB_RN_NN := {}
oPrint:EndPage() // Finaliza a página
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Ret_cBarra  ºAutor  ³Vanito Rocha     Fº Data ³  21/08/20   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gera SE1                        					          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function Ret_cBarra(	cPrefixo	,cNumero	,cParcela	,cTipo	,;
cBanco		,cAgencia	,cConta		,cDacCC	,;
cNroDoc		,nValor		,cCart		,cMoeda	)

Local cNosso		:= ""
Local cDigNosso		:= ""
Local NNUM			:= ""
Local cCampoL		:= ""
Local cFatorValor	:= ""
Local cLivre		:= ""
Local cDigBarra	    := ""
Local cBarra		:= ""
Local cParte1		:= ""
Local cDig1			:= ""
Local cParte2		:= ""
Local cDig2			:= ""
Local cParte3		:= ""
Local cDig3			:= ""
Local cParte4		:= ""
Local cParte5		:= ""
Local cDigital		:= ""
Local aRet			:= {}

cNosso := ""
//Composicao do nosso número
cDigNosso  := U_DigNosso(cNroDoc)
cNosso     := cNroDoc+cDigNosso
//Composicao do codigo de barras
//Página 26 do Manual do Bradesco a variável cCampoL é a responsável pela montagem do Campo Livre
/*
cCampol
Posição		Tamanho	Conteúdo
20 a 23		4	Agência Beneficiária (Sem o digito verificador, completar com zeros a esquerda quando necessário)
24 a 25		2	Carteira
26 a 36		11	Número do Nosso Número (Sem o digito verificador)
37 a 43		7	Conta do Beneficiário (Sem o digito verificador, completar com zeros a esquerda quando necessário)
44 a 44		1	Zero
*/
cCampoL := cAgencia+cNroDoc+cConta+cDacCC


cFatorValor := U_Fator() + StrZero(_cValor * 100,10,0)

//Página 26 do Manual do Bradesco, a variável cLivre é a responsável pela montagem do código de Barras
/*
cLivre

Posição		Tamanho	Conteúdo
01 a 03		3	Identificação do Banco
04 a 04		1	Código da Moeda (Real = 9, Outras=0)
05 a 05		1	Dígito verificador do Código de Barras
06 a 09		4	Fator de Vencimento (Vide Nota)
10 a 19		10	Valor
20 a 44		25	Campo Livre
*/
cLivre := cBanco+"9" + cFatorValor + cCampoL
cDigBarra := U_DigBarra ( cLivre )

cBarra := cBanco+"9"+cDigBarra+cFatorValor+cCampoL

//Composicao da linha digitavel
/*
cParte1
Composto pelo código de Banco, código da moeda,
as cinco primeiras posições do campo livre e o dígito verificador deste campo;
*/
cParte1 := cBanco+"9" + Substr(cCampoL, 1 , 5 )
cDig1 := U_DigLinha(cParte1)
/*
cParte2
Composto pelas posições 6ª a 15ª do campo livre e o dígito verificador deste campo;
*/
cParte2 := Substr(cCampoL,6,10)
cDig2 := U_DigLinha( cParte2 )

/*
cParte3
Composto pelas posições 16ª a 25ª do campo livre e o dígito verificador deste campo;
*/
cParte3 := Substr(cCampoL,16,10 )
cDig3 := U_DigLinha( cParte3 )

/*
cParte4
Composto pelo dígito verificador do código de barras, ou seja, a 5ª posição do código de barras;
*/
cParte4 :=cDigBarra

/*
cParte5
Composto pelo fator de vencimento com 4(quatro) caracteres e
o valor do documento com 10(dez) caracteres, sem separadores e sem edição.
*/
cParte5 := cFatorValor

cDigital := Substr( cParte1, 1, 5 ) + "." + Substr( cparte1, 6, 4) + cDig1+"  "
cDigital += Substr( cParte2, 1, 5 ) + "." + Substr( cparte2, 6, 5) + cDig2+"  "
cDigital += Substr( cParte3, 1, 5 ) + "." + Substr( cparte3, 6, 5) + cDig3+"  "
cDigital += cParte4 + "  "
cDigital += cParte5

//Retorno funcao: codigo de barras, Linha digitavel e nosso numero

Aadd( aRet, cBarra )
Aadd( aRet, cDigital )
Aadd( aRet, cNosso )
Return aRet

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³DigNosso  ºAutor  ³Vanito Rocha       Fº Data ³  21/08/20   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Para calculo do Digito Verificador do Nosso Numero          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function DigNosso(cVariavel)

Local cMult := "2765432765432"
Local nSoma := 0
Local nDigVer := 0
Local cDigVer := ""

//(IF(EMPTY(SE1->E1_NUMBCO),U_DigNosso(),RTrim(Substr(SE1->E1_NUMBCO,3,11))))

For i:= 1 to 13
	nSoma := nSoma + Val(Subs(cVariavel,i,1))*Val(Subs(cMult,i,1))
Next

nDigVer := 11 - mod(nSoma,11)
cDigVer := Alltrim(Str(int(nDigVer)))

Do Case
	Case nDigVer == 11
		cDigVer := "0"
	Case nDigVer == 10
		cDigVer := "P"
EndCase

Return(cDigVer)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³DigBarra  ºAutor  ³Vanito Rocha       Fº Data ³  21/08/20   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Para calculo do nosso numero                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function DigBarra(cVariavel)

Local cMult := "4329876543298765432987654329876543298765432"
Local nSoma := 0
Local nDigVer := 0
Local cDigVer := ""

//Rotina para calculo do digito verificador
For i:= 1 TO len(Alltrim(cVariavel))
	nSoma += Val(Subs(cVariavel,i,1))*Val(Subs(cMult,i,1))
Next

nDigVer := 11 - mod(nSoma,11)

If nDigVer >= 10
	nDigVer:=1
Endif

cDigVer := Alltrim(Str(nDigVer))

Return(cDigVer)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³DigLinha  ºAutor  ³Vanito Rocha          Data ³  21/08/20   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Para calculo da linha digitavel                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function DigLinha(cVariavel)

Local Auxi := 0, sumdig := 0

cbase  := cVariavel
lbase  := LEN(cBase)
umdois := 2
sumdig := 0
Auxi   := 0
iDig   := lBase
While iDig >= 1
	auxi   := Val(SubStr(cBase, idig, 1)) * umdois
	sumdig := SumDig+If (auxi < 10, auxi, (auxi-9))
	umdois := 3 - umdois
	iDig:=iDig-1
EndDo
cValor:=AllTrim(STR(sumdig,12))

If SumDig < 10
	nDezena:=VAL(ALLTRIM(STR(VAL(SUBSTR(cvalor,1,1))+1,12)))
Else
	nDezena:=VAL(ALLTRIM(STR(VAL(SUBSTR(cvalor,1,1))+1,12))+"0")
Endif

auxi := nDezena - sumdig

If auxi >= 10
	auxi := 0
EndIf
Return(str(auxi,1,0))

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Fator		ºAutor  ³Vanito Rocha          Data ³  21/08/20   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Calculo do FATOR  de vencimento para linha digitavel.       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User function Fator()
cData := SE1->E1_VENCREA

cFator := STR((cData-ctod("07/10/1997")),4)


Return(cFator)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³AjustaSX1  ºAutor  ³Vanito Rocha           Data ³ 21/08/20  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Verifica as perguntas incluíndo-as caso näo existam        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function AjustaSX1()
Local aAreaAnt := GetArea()
Local aRegs :={}
Local i := 0, j := 0, k := 0
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³  Grupo/Ordem/Pergunta Portugues/Pergunta Espanhol/Pergunta Ingles/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/DefSPA1/DefEng1/Cnt01/Var02/Def02/DefSpa2/DefEng2/Cnt02/Var03/Def03/DefSpa3/DefEng3/Cnt03/Var04/Def04/DefSpa4/DefEng4/Cnt04/Var05/Def05/DefSpa5/DefEng5/Cnt05/XF3/GrgSxg/cPyme/aHelpPor/aHelpEng/aHelpSpa/cHelp ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//aAdd(aRegs,{cPerg,"01","Data Inicio? ","...","...","mv_ch1","D",08,0,0,"G","","MV_PAR01","","","","","","","","","","","","","","","","","","","","","","","","","   ","S"})
//aAdd(aRegs,{cPerg,"02","Data Final?  ","...","...","mv_ch2","D",08,0,0,"G","","MV_PAR02","" ,"","",""       ,"","","","","","","","","","","","","","","","","","","","","   ","S"})

Aadd(aRegs,{cPerg,"01","De Cliente    ","...","...","mv_cha","C",06,0,0,"G","","MV_PAR01","","","",""        ,"","","","","","","","","","","","","","","","","","","","","SA1","N"})
Aadd(aRegs,{cPerg,"02","Ate Cliente   ","...","...","mv_chb","C",06,0,0,"G","","MV_PAR02","","","","ZZZZZZ"  ,"","","","","","","","","","","","","","","","","","","","","SA1","N"})
Aadd(aRegs,{cPerg,"03","De Loja       ","...","...","mv_chc","C",04,0,0,"G","","MV_PAR03","","","",""        ,"","","","","","","","","","","","","","","","","","","","","   ","N"})
Aadd(aRegs,{cPerg,"04","Ate Loja      ","...","...","mv_chd","C",04,0,0,"G","","MV_PAR04","","","","ZZZZ"      ,"","","","","","","","","","","","","","","","","","","","","   ","N"})
Aadd(aRegs,{cPerg,"05","De Emissao    ","...","...","mv_che","D",08,0,0,"G","","MV_PAR05","","","","01/01/11","","","","","","","","","","","","","","","","","","","","","   ","N"})
Aadd(aRegs,{cPerg,"06","Ate Emissao   ","...","...","mv_chf","D",08,0,0,"G","","MV_PAR06","","","","31/12/11","","","","","","","","","","","","","","","","","","","","","   ","N"})
Aadd(aRegs,{cPerg,"07","De Vencimento ","...","...","mv_chg","D",08,0,0,"G","","MV_PAR07","","","","01/01/11","","","","","","","","","","","","","","","","","","","","","   ","N"})
Aadd(aRegs,{cPerg,"08","Ate Vencimento","...","...","mv_chh","D",08,0,0,"G","","MV_PAR08","","","","31/12/11","","","","","","","","","","","","","","","","","","","","","   ","N"})
Aadd(aRegs,{cPerg,"09","Banco         ","...","...","mv_chi","C",03,0,0,"G","","MV_PAR09","","","",""        ,"","","","","","","","","","","","","","","","","","","","","SA6","N"})
Aadd(aRegs,{cPerg,"10","Agencia       ","...","...","mv_chj","C",05,0,0,"G","","MV_PAR10","","","",""        ,"","","","","","","","","","","","","","","","","","","","","   ","N"})
Aadd(aRegs,{cPerg,"11","Conta         ","...","...","mv_chk","C",10,0,0,"G","","MV_PAR11","","","",""        ,"","","","","","","","","","","","","","","","","","","","","   ","N"})

DbSelectArea("SX1")
DbSetOrder(1)
For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnLock()
	Endif
Next
RestArea( aAreaAnt )
Return

Static Function MarcTodos()
Local _nI
for _nI := 1 to len(aLb1)
	aLB1[_nI,01] := iif(aLB1[_nI,01]=' ','*',' ')
next
Return
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³   C()   ³ Autores ³ Norbert/Ernani/Mansano ³ Data ³10/05/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Funcao responsavel por manter o Layout independente da       ³±±
±±³           ³ resolucao horizontal do Monitor do Usuario.                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function C(nTam)
Local nHRes	:=	oMainWnd:nClientWidth	// Resolucao horizontal do monitor
If nHRes == 640	// Resolucao 640x480 (soh o Ocean e o Classic aceitam 640)
	nTam *= 0.8
ElseIf (nHRes == 798).Or.(nHRes == 800)	// Resolucao 800x600
	nTam *= 1
Else	// Resolucao 1024x768 e acima
	nTam *= 1.28
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Tratamento para tema "Flat"³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If "MP8" $ oApp:cVersion
	If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()
		nTam *= 0.90
	EndIf
EndIf
Return Int(nTam)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³SearchNome³ Autor ³ JVanito Rocha           ³ Data ³15/10/2017³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Procura o Nome do Cliente no Array Especificado              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static FuncTion SearchNome(_cNome)
Local __cNome := Alltrim(_cNome)
Local _nI := 0
For _nI:= 1 to Len(aLB1)
	If !Empty(__cNome) .And. Len(__cNome) >= 3
		If Alltrim(_cNome) $ aLB1[_nI,7]
			oLB1:nAt := _nI
			Exit
		Endif
	Else
		MsgALert("Procura invalida, o campo de procura tem que ter mais 3 caractes","ERRO")
		oLB1:nAt := 1
		Exit
	Endif
Next
oLB1:Refresh()
oLB1:SetFocus()
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³SearchNome³ Autor ³ Douglas Silva          ³ Data ³13/04/2021 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Transferencia entre conta contabil                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function TRAF237X(_cPrefixo, _cNum, _cParc, _cTipo)

   	SE1->(dbSelectArea("SE1"))
	SE1->(dbSetOrder(1)) //E1_FILIAL+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO

	If SE1->(dbSeek(xFilial("SE1") + _cPrefixo + _cNum + _cParc + _cTipo  ))

		RecLock('SE1',.f.)
			SE1->E1_PORTADO := cBanco
			SE1->E1_AGEDEP	:= cAgencia
			SE1->E1_CONTA   := cConta
		MsUnlock('SE1')

	EndIf	

Return
