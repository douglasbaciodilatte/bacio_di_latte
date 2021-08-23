#include "rwmake.ch"
#include "TopConn.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AFATM02   ºAutor  ³ Edson Ito          º Data ³ 18/07/2007  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Interface para gera‡ao de arquivo texto de notas fiscais    º±±
±±ºAlterado  ³14/01/2010 Alexandre Goncalves, Alteracao das consultas SQL º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Industrias Anhembi                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function AFATM02d()

SetPrvt("ARADIO0,NRADIO0,_NITENS,")
SetPrvt("_CPATH,CPATCHGRV,LEND,CARQCBD,CARQMER,CARQINT")
SetPrvt("NHANDLECB,_QTDIAS,CCAMPO01,CCAMPO02,CCAMPO03,CCAMPO04")
SetPrvt("CCAMPO05,CCAMPO06,CCAMPO07,CCAMPO08,CCAMPO09,CCAMPO10")
SetPrvt("CCAMPO11,CCAMPO12,CCAMPO13,CCAMPO14,CCAMPO15,CCAMPO16")
SetPrvt("CCAMPO17,CCAMPO18,CCAMPO19,CCAMPO20,CCAMPO21,CCAMPO22")
SetPrvt("CCAMPO23,CCAMPO24,CCAMPO25,CCAMPO26,CCAMPO27,CCAMPO28")
SetPrvt("CCAMPO29,CCAMPO30,CCAMPO31,CCAMPO32,CCAMPO33,CCAMPO34")
SetPrvt("CCAMPO35")
SetPrvt("NCONT,NHANDLE,CCHAVE,CCAMPO23,CARQCDB,_NDOC,_NUMDUPL")
SetPrvt("NCONTA01,CSTRING,CCAMPO,I,SSALIAS,AREGS,N_QTDCX")
SetPrvt("J,cCgc")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ mv_par01 Data da Nota Fiscal de                                        ³
//³ mv_par02 Data da Nota Fiscal Ate                                       ³
//³ mv_par03 Codigo do Cliente de                                          ³
//³ mv_par04 Loja Cliente de                                               ³
//³ mv_par05 Codigo do Cliente Ate                                         ³
//³ mv_par06 Loja do Cliente Ate                                           ³
//³ mv_par07 Numero da Nota de                                             ³
//³ mv_par08 Numero da Nota Ate                                            ³
//³ mv_par09 Serie da Nota de                                              ³
//³ mv_par10 Serie da Nota Ate                                             ³
//³ mv_par11 Diretorio gravacao arquivo                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cPerg     := "AFTM02" + Space(4)
Private cEOL := CHR(13)+CHR(10)

VALIDPERG()
Pergunte(cPerg,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis de memoria no programa                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aRadio0  := {"CBD       "}//,"          ","         "}
nRadio0  := 0
_NItens  := 1

@ 150,001 TO 400,450 DIALOG oDlgMain TITLE "Interface Microsiga x Clientes"
@ 005,010 SAY "Este programa tem como objetivo a geração de arquivo texto das notas fiscais emitidas"
@ 015,010 SAY "para importacao no sistema do cliente, com base nos parametros selecionados."

//Habilitar com quiser utilizar o nRadio0 com mais de uma opcao.
@ 030,010 TO 120,100 TITLE " Selecione Movimento "
@ 040,030 RADIO aRadio0 VAR nRadio0
@ 040,130 BMPBUTTON TYPE 05 ACTION Pergunte("AFTM02",.T.)
@ 060,130 BMPBUTTON TYPE 01 ACTION (RunProc(),Close(oDlgMain))
@ 080,130 BMPBUTTON TYPE 02 ACTION Close(oDlgMain)

//@ 040,040 BMPBUTTON TYPE 05 ACTION Pergunte("AFTM02",.T.)
//@ 040,090 BMPBUTTON TYPE 01 ACTION (RunProc(),Close(oDlgMain))
//@ 040,140 BMPBUTTON TYPE 02 ACTION Close(oDlgMain)

ACTIVATE DIALOG oDlgMain CENTER

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ RUNPROC  ³ Autor ³ Cadubitski              ³ Data ³ 09/03/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Executa a chamada da funcao                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function RunProc()

Public _lEndLine := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria a pasta/diretorio caso nao exista                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_cPath := Alltrim(MV_PAR11)
_cPath := Iif ( Right(_cPath,1) == "\",SubStr(_cPath,1,Len(_cPath)-1),_cPath)

If MakeDir(_cPath) # 0
	If !MontaDir(_cPath)
		MsgBox("Pasta nao cadastrada.","ATENCAO","ATENCAO")
	EndIf
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Patch para importacao de dados dos arquivos textos                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cPatchGrv := Alltrim(_cPath)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Nome do arquivo texto para exportacao de dados                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_cNome := ""
If mv_par03 <> mv_par05  // Clientes diferentes
    cArqInt := Alltrim(cPatchGrv)+"\GER"+Substr(dtos(dDataBAse),7,2)+Substr(dtos(dDataBAse),5,2)+Substr(dtos(dDataBAse),3,2)+LEFT(STRTRAN(TIME(),":",""),6)+".TXT"
Else
    _cNome := Substr(Alltrim(Posicione("SA1",1,xFilial("SA1")+mv_par03+mv_par04,"A1_NREDUZ")),1,5)
    _cNome := StrTran(_cNome," ","")
    cArqInt := Alltrim(cPatchGrv)+"\"+_cNome+Substr(dtos(dDataBAse),7,2)+Substr(dtos(dDataBAse),5,2)+Substr(dtos(dDataBAse),3,2)+LEFT(STRTRAN(TIME(),":",""),6)+".TXT"
EndIf

nHandleCB:= FCreate(cArqInt,0)

If nHandleCB == -1
	MsgAlert("O arquivo de nome "+cArqInt+" nao pode ser criado! Verifique os parametros.","Atencao!")
	Return
Endif

lEnd := .F.

If nRadio0 == 1 					// CDB
 	_lEndLine := .F.  // nao acrescenta fim de linha no Header 9
	Processa({|lEnd| NF_CBD()})
	Aviso("Atenção!","Arquivo Gerado",	{"Ok"})
Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ NF_MERCAD³ Autor ³ Edson Ito               ³ Data ³ 09/03/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Processa montagem do arquivo texto                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/            

Static Function NF_CBD()

Local cQuery := ""
Local cChaveSd2

cQuery := " SELECT F2_DOC    , F2_SERIE  , F2_CLIENTE, F2_FILIAL , " +CEOL
cQuery += "        F2_LOJA   , F2_TRANSP , F2_EMISSAO, " +cEOL
cQuery += "        F2_PREFIXO, F2_VOLUME1, F2_PLIQUI , F2_VALBRUT, " +cEOL
cQuery += "        F2_PBRUTO , F2_VALMERC, F2_FRETE AS 'F2_X_FRETE'  , " +cEOL
cQuery += "        F2_VALMERC, F2_DESCONT, F2_NFORI  , F2_SERIORI, " +cEOL
cQuery += "        F2_VALIPI , F2_BASEIPI, F2_VALICM , F2_BASEICM, " +cEOL
cQuery += "        F2_ICMSRET, F2_BRICMS , F2_SEGURO , F2_DUPL, " +cEOL
cQuery += "        F2_VALFAT" +cEOL
cQuery += "   FROM " + RetSqlName("SF2") + " SF2 " +cEOL
cQuery += "   JOIN " + RetSqlName("SA1") + " SA1 ON SA1.A1_FILIAL = '' AND SA1.A1_COD = SF2.F2_CLIENTE AND SA1.A1_LOJA = SF2.F2_LOJA AND SA1.D_E_L_E_T_ != '*' " +cEOL
cQuery += "  WHERE F2_FILIAL = '" + xFilial("SF2") + "' " +cEOL
cQuery += "    AND SF2.D_E_L_E_T_ = ' ' " +cEOL
cQuery += "    AND F2_TIPO      IN ('N','C','P','I') " +cEOL
cQuery += "    AND F2_EMISSAO BETWEEN '" + Dtos(Mv_par01) + "' AND '" + Dtos(Mv_par02) + "' " +cEOL
cQuery += "    AND SA1.A1_XNEOGRI = '1' " +cEOL
cQuery += "ORDER BY F2_FILIAL,F2_CLIENTE,F2_LOJA,F2_EMISSAO,F2_DOC" +cEOL

TCQUERY cQuery NEW ALIAS "SF2TMP"

dbSelectArea("SF2TMP")
dbGoTop()
ProcRegua(RecCount())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Nome do arquivo texto para exportacao de dados                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Do While !Eof()
	
	IncProc("Gerando Arquivo de Notas Fiscais " + ("SF2TMP")->F2_DOC)
	
	cChaveSd2 := xFilial("SD2")+("SF2TMP")->F2_DOC+("SF2TMP")->F2_SERIE+("SF2TMP")->F2_CLIENTE+("SF2TMP")->F2_LOJA
	
	SA1->(dbSetOrder(1))
	SA1->(dbSeek(xFilial("SA1")+("SF2TMP")->F2_CLIENTE+("SF2TMP")->F2_LOJA))

	SA4->(dbSetOrder(1))
	SA4->(dbSeek(xFilial("SA4")+("SF2TMP")->F2_TRANSP))

	SD2->(dbSetOrder(3))
	SD2->(dbSeek(cChaveSd2))

	SC5->(dbSetOrder(1))
	SC5->(dbSeek(xFilial("SC5")+SD2->D2_PEDIDO))
	
	SC6->(dbSetOrder(1))
	SC6->(dbSeek(xFilial("SC6")+SD2->D2_PEDIDO))


	SE1->(dbSetOrder(1))
	SE1->(dbSeek(xFilial("SE1") + ("SF2TMP")->F2_PREFIXO + ("SF2TMP")->F2_DOC ))
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ cCampo01  "01" Registro HEADER-1                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCampo01 := "01"	                                                       	// Cod.Registro
	cCampo02 := "009"                                                         	// Funcao Mensagem
	cCampo03 := "325"                                                         	// Funcao Mensagem
	cCampo04 := StrZero(Val(("SF2TMP")->F2_DOC),9)                            	// Numero da Nota Fiscal
	cCampo05 := ("SF2TMP")->F2_SERIE                                           	// Cod.Serie Nota
	cCampo06 := SPACE(2)                                          				// Sub Serie Nota
	cCampo07 := ("SF2TMP")->F2_EMISSAO+SubStr(Time(),1,2)+SubStr(Time(),4,2) 	// Data+Hora+Emissao Nota
	cCampo09 := ("SF2TMP")->F2_EMISSAO+SubStr(Time(),1,2)+SubStr(Time(),4,2) 	// Data+Hora+Emissao Nota
	cCampo10 := ("SF2TMP")->F2_EMISSAO+SubStr(Time(),1,2)+SubStr(Time(),4,2) 	// Data+Hora+Emissao Nota
	cCampo11 := StrZero(Val(SD2->D2_CF),4)                                   	// Cod.Fiscal Operacao
	cCampo12 := StrZero(VAL(Substr(SC5->C5_XPEDCLI,1,15)),15)                 	// Numero Pedido Comprador
	cCampo13 := StrZero(VAL(Substr(SC5->C5_XPEDCLI,1,15)),15)                 	// Numero Pedido Sistema emissão
	cCampo14 := StrZero(0,15)                                                	// Numero Contrato
	cCampo15 := StrZero(0,15)                                                	// Lista de Preço
	cCampo17 := SC5->C5_XEANCOM                                               	// Cod-EAN Comprador
	cCampo18 := SC5->C5_XEANCOF                                               	// Cod-EAN Fatura e Cobrança
	cCampo19 := SC5->C5_XEANLE                                               	// Cod-EAN Local de Entrega
	cCampo20 := SC5->C5_XEANFOR                                               	// Cod-EAN Fornecedor
	cCampo21 := SC5->C5_EANENF                                               	// Cod-EAN Emissor NF-e
	cCampo22 := StrZero(Val(SA2->A2_CGC),15)                                 	// Num.CGC.do Comprador
	cCampo23 := StrZero(Val(SA2->A2_CGC),15)                                 	// Num.CGC.Local de Cobrança
	cCampo24 := StrZero(Val(SA2->A2_CGC),15)                                 	// Num.CGC.Local de Entrega	
	cCampo25 := StrZero(Val(SM0->M0_CGC),15)                                 	// Num.CGC.Emissor Fornecedor
	cCampo26 := StrZero(Val(SM0->M0_CGC),15)                                 	// Num.CGC.Emissor Emissor
	cCampo27 := StrZero(Val(SM0->M0_INSC),20)                                	// Num.Inscricao Estadual Emissor Fatura
	cCampo28 := SM0->M0_ESTCOB                                               	// Cod.UF.Inscr.Estadual Emissor Fatura
	cCampo29 := SC5->C5_XEANLE          										// Cod.EAN.Local Entrega
	cCampo30 := SC5->C5_XEANCOF                                             	// Cod.EAN.Local Cobranca
	cCampo31 := Space(04)                                                    	// Cod.Banco
	cCampo32 := Space(05)                                                    	// Cod.Agencia Bancaria
	cCampo33 := Space(11)                                                    	// Num.Conta Corrente
	cCampo34 := Space(74)                                                    	// Filler
	
	nCont    := 34
	nHandle  := nHandleCB
	GravaTxt()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ cCampo22 : "02" Registro Condicoes de Pagamento                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCampo01 := "02"                                                                                	// Cod.Registro N02
	cCampo02 := StrZero(Val(("SF2TMP")->F2_DOC),9)                                                   	// Numero Nota Fiscal N06
	cCampo03 := ("SF2TMP")->F2_SERIE                                                                  	// Cod.Serie Nota A03
	cCampo04 := IIf(SubStr(SD2->D2_CF,2,3)=="910","015","003")                                      	// Tipo de Pagamento A03
	cCampo05 := IIf(cCampo04=="003","1","0")                                                        	// Referencia de Prazo
	cCampo06 := Space(2)                                                                            	// Descricao Cond.Pagto
	cCampo07 := StrZero(0,3)                                                                        	// Qtde Dias
	cCampo08 := Str(Year(SE1->E1_VENCTO),4)+StrZero(Month(SE1->E1_VENCTO),2)+StrZero(day(SE1->E1_VENCTO),2)      // Data de Vencimento
	cCampo09 := StrZero(0,6)													                       // Porcentagem Desconto Financeiro
	cCampo10 := "00000"									                                             	// Porcentagem a Pagar Fatura
	cCampo11 := Space(241)
	
	nCont    := 11
	nHandle  := nHandleCB
	GravaTxt()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ "03" Registro Header - 3                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCampo01 := "03"                                           		// Cod.Registro
	cCampo02 := StrZero(Val(("SF2TMP")->F2_DOC),9)              	// Numero Nota Fiscal
	cCampo03 := ("SF2TMP")->F2_SERIE                            	// Cod.Serie Nota
	cCampo04 := "    "                                         		// Tipo Veiculo
	cCampo05 := StrZero(Val(SA4->A4_CGC),15)                   	// Cod.EAN ou CGC Transportadora
	cCampo06 := "251"                                          		// Tipo Identificacao Transp
	cCampo07 := SubStr(SA4->A4_Nome,1,25)                      	// Nome Transportadora
	cCampo08 := "            "                                 		// Ident-Placa Veiculo (UF+placa)
	cCampo09 := IIf(SC5->C5_TPFRETE=="C","CIF","FOB")          	// Tipo Frete
	cCampo10 := StrZero(0,13)                                  		// Valor Encargos Financeiros
	cCampo11 := StrZero(0,5)                                   		// Taxa Aliquota ICMS FRETE
	cCampo12 := StrZero(0,5)                                   		// Taxa Aliquota ICMS Seguro
	cCampo13 := Space(184)                                     		// Filler
	
	nCont    := 13
	nHandle  := nHandleCB
	GravaTxt()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ "4" Registro Detalhe - Itens da Nota Fiscal                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SD2")
	dbSetOrder(3)
	dbSeek(cChaveSd2)
	_nItens := 0
	
	Do While !Eof() .And. SD2->D2_FILIAL+SD2->D2_DOC+SD2->D2_SERIE+SD2->D2_CLIENTE+SD2->D2_LOJA == cChaveSd2
		
		SF4->(dbSetOrder(1))
		SF4->(dbSeek(xFilial("SF4")+SD2->D2_TES))

		SC6->(dbSetOrder(1))
		SC6->(dbSeek(xFilial("SC6")+SD2->D2_PEDIDO+SD2->D2_ITEMPV+SD2->D2_COD))
		
		SB1->(dbSetOrder(1))
		SB1->(dbSeek(xFilial("SB1")+SD2->D2_COD))
		
		cCampo01 := "04"                                                                                      			// Cod. Registro
		cCampo02 := StrZero(Val(("SF2TMP")->F2_DOC),9)                                                                 // Numero Nota Fiscal
		cCampo03 := ("SF2TMP")->F2_SERIE                                                                       			// Cod.Serie Nota
//		cCampo04 := Iif(SA1->A1_X_TPCOD="1",SB1->B1_X_CDEAN,SB1->B1_X_CDDUN)											// Cod. Ean Produto 1=EAN 2=DUN
		cCampo04 := SB1->B1_CODBAR																					// Cod. Ean Produto 1=EAN 2=DUN
		cCampo05 := '0'+SubStr(StrZero(("SF2TMP")->F2_VOLUME1,6,0),1,6)+"000"                                  		// Volume Total
		cCampo06 := SubStr(STRZERO(SD2->D2_QUANT,11,2),2,7)+SubStr(STRZERO(SD2->D2_QUANT,11,2),10,2)+'0'      		// Qtde - Faturada
		cCampo07 := 'CX'+Space(1)                                                              							// Unidade Medida Faturada
		cCampo08 := SubStr(STRZERO(SD2->D2_QUANT,11,2),2,7)+SubStr(STRZERO(SD2->D2_QUANT,11,2),10,2)+'0'      		// Qtde - Entregue
		cCampo09 := 'CX'+Space(1)                                                              							// Unidade Medida Faturada
		cCampo10 := SubStr(StrZero((SD2->D2_QUANT*SB1->B1_PESBRU),17,6),6,5)+SubStr(STRZERO((SD2->D2_QUANT*SB1->B1_PESBRU),17,6),12,3)    	// Peso Total Item Entregue Bruto
		cCampo11 := SubStr(StrZero(SD2->D2_QUANT*SD2->D2_PRUNIT,20,6),1,13)+SubStr(STRZERO(SD2->D2_QUANT*SD2->D2_PRUNIT,20,6),15,2)   		// Valor Bruto Total
		cCampo12 := SubStr(StrZero(SD2->D2_QUANT*SD2->D2_PRCVEN,20,6),1,13)+SubStr(StrZero(SD2->D2_QUANT*SD2->D2_PRCVEN,20,6),15,2)      	// Valor Liquido Total
		cCampo13 := SubStr(StrZero(SD2->D2_PRUNIT,18,6),1,11)+SubStr(STRZERO(SD2->D2_PRUNIT,18,6),13,2)       		// Valor Bruto Unitario
		cCampo14 := SubStr(STRZERO(SD2->D2_PRCVEN,18,6),1,11)+SubStr(STRZERO(SD2->D2_PRCVEN,18,6),13,2)       		// Valor Liquido Unitario
		cCampo15 := SF4->F4_SITTRIB                                                                           			// Cod.Situacao Tributaria
		cCampo16 := SubStr(StrZero(SD2->D2_PICM,6,2),1,3)+SubStr(STRZERO(SD2->D2_PICM,6,2),5,2)               		// Taxa Aliquota ICMS
		cCampo17 := StrZero(0,5)                                                                              			// Taxa Aliquota ICMS-Substituicao Tributaria
		cCampo18 := SubStr(StrZero(SD2->D2_IPI,6,2),1,3)+SubStr(STRZERO(SD2->D2_IPI,6,2),5,2)                 		// Taxa Aliquota IPI
		cCampo19 := "00000"																							// Taxa Percentual Desconto Comercial
//		cCampo20 := Iif(SA1->A1_X_ENVDE='1',StrZero(SD2->D2_DESCON*100,15),StrZero(0,15))								// valor desconto comercial
		cCampo20 := StrZero(0,13)																						// valor desconto comercial
		cCampo21 := StrZero(0,5)                                                                              			// Porcentagem Reducao Base ICMS
		cCampo22 := Space(115)                                                                                			// Filler

//		cCampo19 := SubStr(StrZERO(SD2->D2_DESCON/100,13,2),8,3)+SubStr(STRZERO(SD2->D2_DESCON/100,13,2),12,2)   	// Taxa Percentual Desconto Comercial
//		cCampo20 := SubStr(StrZERO(SD2->D2_DESCON,14,2),1,11)+SubStr(StrZERO(SD2->D2_DESCON,11,2),10,2)       		// valor desconto comercial
		
		nCont    := 22
		nHandle  := nHandleCB
		_NItens := _NItens + 1
		GravaTxt()
		
		dbSelectArea("SD2")
		dbSkip()
	Enddo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ "09" Registro Trailer                                               ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCampo01 := "09"                                                                                                        	// Cod. Registro
	cCampo02 := StrZero(Val(("SF2TMP")->F2_DOC),9)                                                                           	// Numero Nota Fiscal
	cCampo03 := ("SF2TMP")->F2_SERIE                                                                                         	// Cod.Serie Nota
	cCampo04 := StrZero(_NItens,4)                                                                                          	// Num.Total de Itens Nota
	cCampo05 := StrZero(("SF2TMP")->F2_VOLUME1,4)                                                                            	// Num.Total Embalagens
	cCampo06 := SubStr(StrZero(("SF2TMP")->F2_VOLUME1  ,16,2),1,13)+SubStr(StrZero(("SF2TMP")->F2_VOLUME1  ,16,2),15,2)     // Qtde Total Pallets
	cCampo07 := SubStr(StrZero(("SF2TMP")->F2_PBRUTO   ,09,2),1,06)+SubStr(StrZero(("SF2TMP")->F2_PBRUTO   ,09,2),08,2)+'0' // Total Peso Bruto
	cCampo08 := SubStr(StrZero(("SF2TMP")->F2_PLIQUI   ,09,2),2,05)+SubStr(StrZero(("SF2TMP")->F2_PLIQUI   ,09,2),08,2)+'0' // Total Peso Liquido
	cCampo09 := SubStr(StrZero(("SF2TMP")->F2_BASEICMS ,17,2),1,14)+SubStr(StrZero(("SF2TMP")->F2_BASEICMS ,17,2),16,2)     // Valor Base Calculo ICMS
	cCampo10 := SubStr(StrZero(("SF2TMP")->F2_VALICM   ,16,2),1,13)+SubStr(StrZero(("SF2TMP")->F2_VALICM   ,16,2),15,2)     // Valor Total ICMS
	cCampo11 := SubStr(StrZero(("SF2TMP")->F2_BRICMS   ,17,2),1,14)+SubStr(StrZero(("SF2TMP")->F2_BRICMS   ,17,2),16,2)     // Valor Base Calculo ICMS Substituicao
	cCampo12 := SubStr(StrZero(("SF2TMP")->F2_ICMSRET  ,16,2),1,13)+SubStr(StrZero(("SF2TMP")->F2_ICMSRET  ,16,2),15,2)     // Valor Total ICMS Substituicao
	cCampo13 := SubStr(StrZero(("SF2TMP")->F2_VALMERC  ,16,2),1,13)+SubStr(StrZero(("SF2TMP")->F2_VALMERC  ,16,2),15,2)     // Valor Total Mercadorias
	cCampo14 := SubStr(StrZero(0    ,14,2),1,11)+SubStr(StrZero(0,14,2),13,2) 											    // Valor Total Frete
	cCampo15 := SubStr(StrZero(("SF2TMP")->F2_SEGURO   ,14,2),1,11)+SubStr(StrZero(("SF2TMP")->F2_SEGURO   ,14,2),13,2)     // Valor Total Seguro
	cCampo16 := StrZero(0,13)                                                                                   				// Valor Total Outros Encargos
	cCampo17 := SubStr(StrZero(("SF2TMP")->F2_BASEIPI  ,17,2),1,14)+SubStr(STRZERO(("SF2TMP")->F2_BASEIPI,17,2),16,2)       // Valor Base Calculo IPI
	cCampo18 := SubStr(StrZero(("SF2TMP")->F2_VALIPI   ,16,2),1,13)+SubStr(STRZERO(("SF2TMP")->F2_VALIPI,16,2),15,2)        // Valor Total IPI
	cCampo19 := SubStr(StrZero(("SF2TMP")->F2_DESCONT  ,16,2),1,13)+SubStr(STRZERO(("SF2TMP")->F2_DESCONT,16,2),15,2)       // Valor Total Descontos
	cCampo20 := IIF(EMPTY(("SF2TMP")->F2_DUPL),SubStr(StrZero(("SF2TMP")->F2_VALMERC,16,2),1,13)+SubStr(STRZERO(("SF2TMP")->F2_VALMERC,16,2),15,2),SubStr(StrZero(("SF2TMP")->F2_VALFAT,16,2),1,13)+SubStr(STRZERO(("SF2TMP")->F2_VALFAT,16,2),15,2))// Valor Total Nota
	cCampo21 := StrZero(0,13)                                                                                   				// Valor Total Desp Acessoria nao Tributada
	cCampo22 := SubStr(StrZero(("SF2TMP")->F2_VALICM   ,16,2),3,11)+SubStr(STRZERO(("SF2TMP")->F2_VALICM,16,2),15,2)        // Valor Total ICM na fonte
	cCampo23 := Space(26)                                                                                                   	// Filler
	
	nCont    := 23
	nHandle  := nHandleCB
	
	dbSelectArea("SF2TMP")
	dbSkip()
	GravaTxt()  // verifico na funcao se e final de arquivo
Enddo

FClose(nHandleCB)

dbSelectArea("SF2TMP")
("SF2TMP")->( DbCloseArea() )

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ GRAVATXT ³ Autor ³ MARCIO COSTA            ³ Data ³ 30/10/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao ³ Gera Texto com Base nas Informacoes                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function GravaTxt()

Local cString  := ""
Local cCampo   := ""

For i := 1 To nCont
	cCampo  := "cCampo" + StrZero(i,2)
	cString := cString  + &(cCampo)
Next

IF cCampo01 == "09" .and. ("SF2TMP")->( Eof() ) .and. _lEndLine // ultima linha a ser gravada, nao grava linha em branco
   FWrite(nHandle, cString)
ELSE   
   FWrite(nHandle, cString + Chr(13) + Chr(10) )
ENDIF   

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³VALIDPERG ³ Autor ³ Marcio Costa         	³ Data ³ 07/11/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica as perguntas incluindo-as caso nao existam		  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso		 ³                                      					  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ValidPerg()

Local cLAlias := Alias()
Local aRegs   := {}

aAdd(aRegs,{PADR(cPerg,6),"01","Data Emissao De     ?","","","mv_ch1","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","","S","","","",""})
aAdd(aRegs,{PADR(cPerg,6),"02","Data Emissao Ate    ?","","","mv_ch2","D",08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","","S","","","",""})
aAdd(aRegs,{PADR(cPerg,6),"11","Diretório p/Gravação?","","","mv_chb","C",50,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","","S","","","",""})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Atualizacao do SX1 com os parametros criados³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SX1")
dbSetorder(1)
For nLoop1 := 1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[nLoop1,2])
		RecLock("SX1",.T.)
		For nLoop2 := 1 to FCount()
			FieldPut(nLoop2,aRegs[nLoop1,nLoop2])
		Next
		MsUnlock()
		dbCommit()
	Endif
Next

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Retorna ambiente original³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cLAlias)

Return

Static Function SomaHr(cData,cHora,nDias,nMin)
Local cRet    := ""   
Local nHora   := nMin/60
Local nRestM  := nMin%60
Local nMinRet := 0
Local nHorRet := nHora
Local dDatRet := SToD(cData) + nDias

If ( Val(SubStr(cHora,4,2)) + nRestM ) > 60
	nHorRet++
	nMinRet := ( Val(SubStr(cHora,4,2)) + nRestM ) % 60
Else
	nMinRet := ( Val(SubStr(cHora,4,2)) + nRestM )
EndIf 

If ( Val(SubStr(cHora,1,2)) + nHora ) > 24
	dDatRet++
	nHorRet := ( Val(SubStr(cHora,1,2)) + nHora ) % 24
Else
	nHorRet := ( Val(SubStr(cHora,1,2)) + nHora )
EndIf                                            

cRet := DToS(dDatRet) + StrZero(nHorRet,2) + StrZero(nMinRet,2)
	
Return cRet

