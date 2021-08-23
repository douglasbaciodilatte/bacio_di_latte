#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#include "Fileio.ch"
#INCLUDE "TBICONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Função    ³ bdlinv6  ³ Autor ³ Reinaldo Rabelo       ³ Data ³ 09/06/21 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Zera Saldo de Lotes                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Especifico Bacio                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function BDLINV6()


	Local lRet 	:= .T.
	Local nOpca := 0
    Private cLErro := ""
	Private oDlg2
	Private c_dirimp := space(100)

	DEFINE MSDIALOG oDlg TITLE "Zera Saldo de Lotes" FROM F0400115(000),F0400115(000) TO F0400115(150),F0400115(320) PIXEL
	@ 010,009 Say   "Este programa tem a finalidade de Zerar os Lotes de"       Size 200,008          PIXEL OF oDlg  //030
	//@ 010,009 Say   ".........|.........|.........|.........|.........|.........|.........|.........|.........|.........|.........|"       Size 200,008          PIXEL OF oDlg  //030
	@ 020,009 Say   "Produtos, atravez de um arquivo .CSV" Size 200,008          PIXEL OF oDlg  //030
	@ 030,009 Say   "Diretorio"       Size 045,008          PIXEL OF oDlg  //030
	@ 038,009 MSGET c_dirimp          Size 120,010 WHEN .F. PIXEL OF oDlg //038
	@ 038,140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("*.csv|*.csv","Importacao de Dados",0, ,.T.,GETF_LOCALHARD))
	@ 65,009 Button "OK"       Size F0400115(037),F0400115(012) PIXEL OF oDlg Action(nOpca := 1, oDlg:End())
	@ 65,060 Button "Cancelar" Size F0400115(037),F0400115(012) PIXEL OF oDlg Action(nOpca := 0, oDlg:end())

	ACTIVATE MSDIALOG oDlg CENTERED

	If nOpca == 1
		If Empty(c_dirimp)
			MsgInfo("Nenhum arquivo CSV foi selecionado! Importação não realizada.")
			lRet := .F.
		Else
			If ApMsgYesNo("Atualiza Saldo dos Lotes ?",OemToAnsi('ATENCAO'))
				DbSelectArea('SC4')
				SC4->(dbSetOrder(1))
				PROCESSA( {|| fuGera(c_dirimp) } ,"Lendo Dados e atualizando Saldo dos Lotes...")
			EndIf
		EndIf
	Else
		lRet := .F.
	EndIf

Return(lRet)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Função    ³ FGERA    ³ Autor ³ Reinaldo Rabelo       ³ Data ³ 09/06/21 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Gera o array e salva os dados do .CSV na tabela DA1        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Especifico Bacio                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function fuGera(cArq)

	Local cLinha    := ""
	Local lPrim     := .T.
	Local aCampos   := {}
	Local aDados    := {}
    Private cDoc  := ""
	Private aErro := {}

	If !File(cArq)
		MsgStop("O arquivo " + cArq + " não foi encontrado. A importação será abortada!"," - ATENCAO")
		Return
	EndIf

	FT_FUSE(cArq)
	ProcRegua(FT_FLASTREC())
	FT_FGOTOP()
	While !FT_FEOF()

		IncProc("Lendo arquivo texto...")

		cLinha := FT_FREADLN()
		cLinha += ";"

		If lPrim
			aCampos := Separa(UPPER(cLinha),";",.T.)
			lPrim := .F.
		Else
			AADD(aDados,Separa(cLinha,";",.T.))
		EndIf

		FT_FSKIP()
	EndDo

	FT_FUSE()

	ProcRegua(Len(aDados))

	For nX := 1 TO Len(aDados)
		
		aDados[nX,1] := strzero(val(aDados[nX,1]),len(SC4->C4_FILIAL))	//FILIAL;
		dbSelectArea("SB1")
		SB1->(DBSETORDER(1))
		
		aDados[nX,2] := PADR(aDados[nX,2],LEN(SB1->B1_COD))
		
		IF EMPTY(xFilial('SB1'))
			cChave := xFilial('SB1')+aDados[nX,2]
		else
			cChave := aDados[nX,1]+aDados[nX,2]
		EndIf
		
		IF !SB1->(dBSEEK(cChave))
			aDados[nX,8] := "F"	//PRODUTO;
		ENDIF
			
		aDados[nX,4] := STRZERO(VAL(aDados[nX,4]),LEN(SB1->B1_LOCPAD))	//ARMAZEM;
		
		aDados[nX,5] := PADR(aDados[nX,5],16)
		aDados[nX,7] := val(strTran(strTran(aDados[nX,7],".",""),",","."))	//VALOR;
	
		IncProc(OemToAnsi("Lendo Produto: " + aDados[nX,2]))

		//Else
		//	aDados[_nx][04] := "F"
		//	IncProc(OemToAnsi("Produto Não Localizado : " + _cProduto))

		//EndIf

	Next nX

    cDoc := GetSXEnum("SD3","D3_DOC")

	For nX := 1 to len(aDados)
	
		if Empty(aDados[nX,8])
			IncProc(OemToAnsi("Atualizando Saldo do Produto: " + aDados[nX,2]))

            aDados[nX,8] := M240(aDados[nX])

		EndIf
	
	Next
	
	cOcorrencia := fuLog(aCampos,aDados,cArq)

	//ApMsgAlert(OemToAnsi("Custo Standard Atualizado." + CHR(13) + CHR(10)+"Verifique as Ocorrencias no Arquivo: " + cOcorrencia) )
conout('Teste')
Return(aDados)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Função    ³ F0400115 ³ Autor ³ Reinaldo Rabelo       ³ Data ³ 18/03/19 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Ajusta as coordenadas da tela de parâmetros                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ Especifico DIMEP                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function F0400115(nTam)

	Local nHRes	:=	oMainWnd:nClientWidth	// Resolucao horizontal do monitor

	If      nHRes == 640	// Resolucao 640x480
		nTam *= 0.8
	ElseIf (nHRes == 798).Or.(nHRes == 800)	// Resolucao 800x600
		nTam *= 1
	Else	// Resolucao 1024x768 e acima
		nTam *= 1.28
	EndIf

	If "MP8" $ oApp:cVersion

		If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()
			nTam *= 0.90
		EndIf

	EndIf

Return NoRound(nTam)


Static Function fuLog(aCampos,aDados,cArq)

	Local cArqLog := substr(cArq,1,len(cArq)-4 ) + '_IMP.csv'
    Local cArqLog2 := substr(cArq,1,len(cArq)-4 ) + '_Erro.log'
	LOCAL nHandle := FCREATE(cArqLog, FC_NORMAL)
    
    MemoWrite(cArqLog2,cLErro)

	IF nHandle == -1

		MsgAlert("O Arquivo não foi criado:" + STR(FERROR()))
		Return 'Erro'

	ELSE

		FWRITE(nHandle, aCampos[1]+';' +aCampos[2]+';' +aCampos[3]+';' +aCampos[4]+';' +aCampos[5]+';' +aCampos[6]+';' +aCampos[7]+';Importado' + Chr(13) + chr(10) )

		for nx := 1 to len(aDados)
			FWRITE(nHandle, aDados[nX,1] + ';' + aDados[nX,2] + ';' + aDados[nX,3] + ';' + aDados[nX,4] + ';' + aDados[nX,5] + ';' + aDados[nX,6] + ';' + Transform(aDados[nX,7], " @E 99999999.99" ) + ';' + iif(aDados[nX,8] ,'OK','Não Processado') + Chr(13) + Chr(10))
		Next

		FCLOSE(nHandle)

	ENDIF

Return cArqLog


//************************************************************************************************
Static Function M240(aD3)

Local lRet    := .T.
//Local aDados := {}
Local cDetalhe := ""
Local aItem  := {}
Local nOpc   := 3 //-Opção de execução da rotina, informado nos parametros quais as opções possiveisl
Private lMsErroAuto   := .F.
Private lMsHelpAuto   := .F.
Private lAutoErrNoFile:= .T. 

    aItem := {  {"D3_FILIAL" , aD3[1]   ,NIL},;
                {"D3_DOC"    , cDoc     ,NIL},;
                {"D3_TM"     , "501"    ,NIL},;
                {"D3_CC"    , "800003" ,NIL},;//
                {"D3_COD"    , aD3[2]   ,NIL},;//{"D3_UM"     ,""         ,NIL},;
                {"D3_QUANT"  , aD3[7]   ,NIL},;
                {"D3_LOCAL"  , aD3[4]   ,NIL},;//     //{"D3_CC"     , aD3     ,NIL},;//{"D3_DOC"    , aD3     ,NIL},;
                {"D3_LOTECTL", aD3[5]   ,NIL},;
                {"D3_EMISSAO", date()   ,NIL}}
                /*
                {"D3_NUMSEQ" ,"000017"   ,NIL},;
                {"D3_LOCALIZ","RUA 002 " ,NIL},;
                {"D3_LOTECTL","1012 "    ,NIL},;
                {"D3_DTVALID",dDatav     ,NIL}}
            */
    MSExecAuto({|x,y| mata240(x,y)},aItem,nOpc)

    If lMsErroAuto

        cLog:= "Erro na operação : " + CRLF
        aEval(GetAutoGrLog(), {|x| cDetalhe+= x + CRLF })
        lRet:= .F.
        cLErro += cDetalhe               
    Else

        lRet := .T.

    Endif

	ConOut(Repl("-",80))

Return lRet
