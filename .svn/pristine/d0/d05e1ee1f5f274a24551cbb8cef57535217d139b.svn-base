#INCLUDE "Protheus.ch"
#include "topconn.ch"
//#include "RWMAKE.ch"
#DEFINE  CRLF        Chr(13)+Chr(10)

//Definicao dos elementos do array aTotVal
#DEFINE TOTHEA	 1 		//Total de Header
#DEFINE TOTDET	 2 		//Total de Detalhe
#DEFINE TOTTRA	 3 		//Total de Trailer
#DEFINE TOTUEN	 4 		//Total de Unidade de Entrega
#DEFINE TOTDEP	 5 		//Total de Departamento
#DEFINE TOTFUT	 6 		//Total de Funcionarios de VT
#DEFINE TOTITT	 7 		//Total de Itens de VT
#DEFINE TOTPAS	 8 		//Total de Passagens
#DEFINE TOTVVT   9      //Valor Total VT


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ TKTVTBDIL º Autor ³ JORGE SATO        º Data ³  01/03/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Geracao de Arquivo Texto para Aquisicao do VT Pela Ticket  º±±
±±º          ³ da Empresa MILANO COMERCIO VAREJISTA DE ALIMENTOS S.A.     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PROTHEUS 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±ºAlteracao ³  Data    ³ Analista  ³               Motivo                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±º          ³          ³           ³                                     º±±
±±º          ³          ³           ³                                     º±±
±±º          ³          ³           ³                                     º±±
±±º          ³          ³           ³                                     º±±
±±º          ³          ³           ³                                     º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function TKTVTBDIL()

//Declaracao de Variaveis
SetPrvt("lEnd,lContinua,lAbortPrint,lDetVT,nHdl,nDafas,cPerg,cNomeArq,cArq,cArqInd,nPos")
SetPrvt("aTotVal,lFlag,lTran,lRef,cFilSRO,cFilSRN,cTexto,cValAnt,nTVlrServ,nSeq,nDtrab,nRef,aInfoE,nEnt,cFilEnt")

//Carrega Variaveis
lEnd        := .F.
lContinua   := .T.
lAbortPrint := .F.
nHdl		:= 0
nDafas		:= 0
nPos		:= 0
cPerg		:= "KITVTBDIL "
cNomeArq	:= ""
cArq		:= ""
cArqInd		:= ""

fChkPerg()
pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Montagem da tela de processamento.                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 200,001 TO 410,480 DIALOG oDlg TITLE OemToAnsi( "Geracao Ticket Eletronico De VT" )
@ 02,10 TO 095,230
@ 10,018 Say " Este programa ira gerar um arquivo texto, conforme os parame- "
@ 18,018 Say " tros definidos  pelo usuario,  com os registros do arquivo de "
@ 26,018 Say " Geracao de Arquivo Texto do Ticket Eletronico De VT.        "

@ 70,128 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oDlg)
@ 70,188 BMPBUTTON TYPE 01 ACTION OkGeraTxt()

Activate Dialog oDlg Centered

If nHdl > 0
	If fClose(nHdl)
		If lContinua
			Aviso('AVISO','Gerado o arquivo ' + AllTrim(cNomeArq) + '...',{'OK'})
		Else
			If fErase(cNomeArq) == 0
				If lContinua
					Aviso('AVISO','Nao existem registros a serem gravados. A geracao do arquivo ' + AllTrim(cNomeArq) + ' foi abortada ...',{'OK'})
				EndIf
			Else
				MsgAlert('Ocorreram problemas na tentativa de delecao do arquivo '+AllTrim(cNomeArq)+'.')
			EndIf
		EndIf
	Else
		MsgAlert('Ocorreram problemas no fechamento do arquivo '+AllTrim(cNomeArq)+'.')
	EndIf
	
EndIf

fImpLis()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³ OKGERATXTº Autor ³ JORGE SATO         º Data ³  01/03/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao chamada pelo botao OK na tela inicial de processamenº±±
±±º          ³ to. Executa a geracao do arquivo texto.                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function OkGeraTxt()

Close(oDlg)

Processa({|| fRunTKT() },"Processando...")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fRunTkt   ºAutor ³ JORGE SATO          º Data ³  01/03/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Processamento do Sistema                                   º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PROTHEUS 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function fRunTkt()

//Carrega Variaveis
cFilAnter   := ""
cMatAnter   := ""
cMeioTran   := "" 
nSeqFu_     := 0
aTotVal		:= {0,0,0,0,0,0,0,0,0} 				//Informacoes definidas no #DEFINE
nSeq		:= 1
aInfoE		:= {}
aShTaSAli   := {}

//Variaveis das Perguntas
Pergunte(cPerg,.F.)

//Data de Referencia  		mv_par01
//Filial De            		mv_par02
//Filial Ate         		mv_par03
//Matricula De            	mv_par04
//Matricula Ate          	mv_par05
//Centro de Custo De      	mv_par06
//Centro de Custo Ate   	mv_par07
//Situacoes a Imprimir  	mv_par08
//Categorias a Imprimir 	mv_par09
//VT - Utilizacao De     	mv_par10
//VT - Utilizacao Ate    	mv_par11
//VT - Dt Entrega Minima 	mv_par12
//VT - Dt Entrega Maxima	mv_par13
//Nome do Arquivo           mv_par14


dDataRef	:= If(Empty(mv_par01),dDataBase,mv_par01) // Periodo de Referencia
lTran		:= .T.
cFilDe      := mv_par02
cFilAte     := mv_par03
cMatDe      := mv_par04
cMatAte     := mv_par05
cCcDe       := mv_par06
cCcAte      := mv_par07
cSit        := mv_par08
cCat        := mv_par09
dUtilDe     := mv_par10
dUtilAte    := mv_par11
dEntrMin    := mv_par12
dEntrMax    := mv_par13
nPercKit    := 0
nVlPonto    := 0.00
cNomeArq	:= mv_par14
cAnoMes     := Str(Year(dDataRef),4) + StrZero(Month(dDataRef),2)
cCNPJ		:= " "//mv_par27
lDetVT 		:= .T.
//Cria DBF

//fCriaDBF()

//Cria o arquivo texto
While .T.
	If File(cNomeArq)
		If (nAviso := Aviso('AVISO','Deseja substituir o ' + AllTrim(cNomeArq) + ' existente ?', {'Sim','Nao','Cancela'})) == 1
			If fErase(cNomeArq) == 0
				Exit
			Else
				MsgAlert('Ocorreram problemas na tentativa de delecao do arquivo '+AllTrim(cNomeArq)+'.')
			EndIf
		ElseIf nAviso == 2
			Pergunte(cPerg,.T.)
			Loop
		Else
			Return
		EndIf
	Else
		Exit
	EndIf
EndDo

nHdl := fCreate(cNomeArq)

If nHdl == -1
	MsgAlert('O arquivo '+AllTrim(cNomeArq)+' nao pode ser criado! Verifique os parametros.','Atencao!')
	Return
Endif

//Monta Query de Filtro

CQUERY := "SELECT RA_FILIAL,RA_CC,RA_MAT,RA_NOME,RA_NASC,RA_RG,RA_RGUF,RA_SEXO,RA_MAE,RA_LOGRTP,RA_ENDEREC,RA_NUMENDE,RA_COMPLEM,RA_MUNICIP,RA_BAIRRO,RA_CEP,RA_ESTADO,RA_CIC,CTT_DESC01,R0_CODIGO,R0_QDIACAL,R0_VALCAL,R0_TPVALE,RN_VUNIATU,RN_ITEMPED,RFP_TKCDOP,RFP_TKCDBL,RFP_TKTPBL"
CQUERY += " FROM " + RETSQLNAME("SRA")+ " INNER JOIN " +  RETSQLNAME("SR0")+ " ON (R0_FILIAL = RA_FILIAL AND R0_MAT = RA_MAT AND R0_VALCAL > 0 )"
CQUERY += " INNER JOIN " +  RETSQLNAME("SRN")+ " ON (R0_CODIGO = RN_COD)"
CQUERY += " LEFT OUTER JOIN " + RETSQLNAME("RFP")+ " ON (RFP_TPVALE = R0_TPVALE AND RFP_CODIGO = RN_COD)"
CQUERY += " INNER JOIN " +  RETSQLNAME("CTT")+ " ON (RA_CC = CTT_CUSTO)" //RA_FILIAL = CTT_FILIAL AND 
CQUERY += " WHERE RA_SITFOLH <> 'D' AND R0_TPVALE = '0'"
CQUERY += " AND RA_FILIAL >= '"+CFILDE+"' AND RA_FILIAL <= '"+CFILATE+"'"
CQUERY += " AND RA_CC     >= '"+CCCDE+ "' AND RA_CC     <= '"+CCCATE+ "'"
CQUERY += " AND RA_MAT    >= '"+CMATDE+"' AND RA_MAT    <= '"+CMATATE+"'"
CQUERY += " AND " + RETSQLNAME("SRA")+ ".D_E_L_E_T_ = ' ' AND " + RETSQLNAME("SR0")+ ".D_E_L_E_T_ = ' ' AND " + RETSQLNAME("CTT")+ ".D_E_L_E_T_ = ' '"
CQUERY += " AND " + RETSQLNAME("SRN")+ ".D_E_L_E_T_ = ' ' AND " + RETSQLNAME("RFP")+ ".D_E_L_E_T_ = ' '"
CQUERY += " ORDER BY R0_TPVALE,RA_FILIAL,RA_NOME"

cQuery := ChangeQuery(cQuery)

//Verifica se Tabela Aberta
If Select("R0NW") > 0
	DbSelectArea("R0NW")
	DbCloseArea("R0NW")
EndIf

//Abre Tabela
dbUseArea( .T., 'TOPCONN', TcGenQry( ,, cQuery ), 'R0NW', .T., .F. )

TcSetField( "R0NW", "R0_VALCAL"  , "N", 12, 2 )
TcSetField( "R0NW", "RA_NASC"    , "D",  8, 0 )
TcSetField( "R0NW", "RN_VUNIATU" , "N", 12, 2 )

R0NW->(DbGotop())

fCarrTab( @aShTaSAli,"U002")

cFilAnter   := R0NW->RA_FILIAL
cMatAnter   := R0NW->RA_MAT
cMeioTran   := R0NW->R0_CODIGO

While R0NW->(!Eof())
	

	IncProc('Gerando o Arquivo... ')
	nRef := val(R0NW->R0_TPVALE) 
	aInfoE := {}
	nSM0Recno := SM0->(Recno())
	SM0->(dbSeek(cEmpAnt + R0NW->RA_FILIAL,.T.))

	Aadd(aInfoE,SM0->M0_NOME)
	Aadd(aInfoE,SM0->M0_NOMECOM)
	Aadd(aInfoE,SM0->M0_CGC)

	// Retorna ao Registro
	SM0->(dbGoto(nSM0Recno))

	IF cFilAnter = R0NW->RA_FILIAL .AND. cMatAnter = R0NW->RA_MAT .AND. cMeioTran <> R0NW->R0_CODIGO
		nSeqFu_	+= 1
		fGerTTIT()
	ELSE 	  
		nSeqFu_	:= 0 
		fGerTTFU()
	ENDIF
	fGerTTIT() 
	cFilAnter   := R0NW->RA_FILIAL
	cMatAnter   := R0NW->RA_MAT
	cMeioTran   := R0NW->R0_CODIGO
	R0NW->(DbSkip())
EndDo

If (lDetVT) //Flag de Detalhe de Funcionario com VT
	
	//Header do Registro LSUP5
	fGerLSUP5()
		
	//Header TT
	fGerTT()
		
	//Calculo do Valor do Servico
	nTVlrServ := (nPercKit * aTotVal[TOTPAS]) + (aTotVal[TOTUEN] * nVlPonto)
		
	//Registro de Pedido
	fGerTTPE()

	//Unidade de Entrega - 
	fGerTTUN()

	//Departamento - 
	fGerTTDE()

	//Funcionarios - ITENS PEDIDOS
	
	DbSelectArea("R0NW")
	R0NW->(DbGotop())
	cFilAnter   := R0NW->RA_FILIAL
	cMatAnter   := R0NW->RA_MAT
	cMeioTran   := R0NW->R0_CODIGO	
	While R0NW->(!Eof()) 
	
		aInfoE := {}
		nSM0Recno := SM0->(Recno())
		SM0->(dbSeek(cEmpAnt + R0NW->RA_FILIAL,.T.))

		Aadd(aInfoE,SM0->M0_NOME)
		Aadd(aInfoE,SM0->M0_NOMECOM)
		Aadd(aInfoE,SM0->M0_CGC)

		// Retorna ao Registro
		SM0->(dbGoto(nSM0Recno))

		IF cFilAnter = R0NW->RA_FILIAL .AND. cMatAnter = R0NW->RA_MAT .AND. cMeioTran <> R0NW->R0_CODIGO
			nSeqFu_	+= 1
			fGTTIT()
		ELSE 	  
			nSeqFu_	:= 0 
			fGTTFU()
		ENDIF
		fGTTIT() 
		cFilAnter   := R0NW->RA_FILIAL
		cMatAnter   := R0NW->RA_MAT
		cMeioTran   := R0NW->R0_CODIGO
		R0NW->(DbSkip())
	EndDo



	//REGISTRO TRAILLER
	fGerTT99()

	//Trailler do Arquivo
	fGerLSUP9()

Endif
Return

//Fim da Rotina
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGerLSUP5 ºAutor ³ JORGE SATO          º Data ³  01/03/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gera Registro LSUP5                                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß ok*/

Static Function fGerLSUP5()

cTexto := "LSUP5"                      	// 001 - 005 -> Tipo do Registro
cTexto += "TICKET  "	             	// 006 - 013 -> Nome do Usuario que gerou o arquivo
cTexto += Space(11)                    	// 014 - 024 -> Brancos
cTexto += GravaData(dDataBase,.F.,8 )  	// 025 - 032 -> Data da Geracao
cTexto += Time()	   				   	// 033 - 040 -> Hora da Gravação HH.MM.SS
cTexto += "LAYOUT-26/07/2013"          	// 041 - 057 -> Fixo
cTexto += Space(107)                   	// 058 - 165 -> Brancos
cTexto += CRLF

fGravaReg(AllTrim(cTexto))

Return

//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGerTT     ºAutor  ³JORGE SATO          º Data ³ 01/03/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gera Header TT                                             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PROTHEUS 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function fGerTT()

cTexto := fGerStr(4,"T")                // 001 - 004 -> Tipo do Pacote
cTexto += "A"                           // 005 - 005 -> Ordem do Kit
cTexto += GravaData(dDataBase,.F.,8)    // 006 - 013 -> Data da Geracao
cTexto += "V4.0"                        // 014 - 017 -> Ordem do Kit
cTexto += Space(60)                     // 018 - 077 -> Brancos
cTexto += CRLF

aTotVal[TOTHEA] += 1

fGravaReg(AllTrim(cTexto))

Return
//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGerTTPE  ºAutor  ³JORGE SATO          º Data ³  01/03/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gera Registro TTPE                                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PROTHEUS 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function fGerTTPE()

cTexto := "TTPE"                                          // 001 - 004 -> Tipo do Produto
cTexto += transform((fGerZero(14,aInfoE[3])),"@r 99.999.999/9999-99")  // 005 - 022 -> Cnpj Principal
cTexto += "K."+SUBSTR(Dtoc(dDataRef),1,2)+SUBSTR(Dtoc(dDataRef),3,4)+SUBSTR(Dtoc(dDataRef),9,2)                     // 023 - 032 -> Numero do Pedido
cTexto += StrZero(aTotVal[TOTUEN],4)                      // 033 - 036 -> Qde Unidades Pedido
cTexto += StrZero(aTotVal[TOTDEP],4)                      // 037 - 040 -> Qde Deptos Pedido
cTexto += StrZero(aTotVal[TOTFUT],5)                      // 041 - 045 -> Qde Funcionario Pedido
cTexto += StrZero(aTotVal[TOTITT],6)                      // 046 - 051 -> Qde Itens Pedido
cTexto += transform((fGerZero(16,nTVlrServ)),"9999999999999.99")         // 052 - 067 -> Valor Servicos Pedido
cTexto += transform((fGerZero(16,aTotVal[TOTPAS])),"9999999999999.99")   // 068 - 083 -> Valor Bilhetes Pedido
cTexto += GravaData(dDataBase,.F.,8)                      // 084 - 091  -> Data de Geracao
cTexto += " "                                             // 092 - 092 -> Espacos
cTexto += GravaData(dUtilDe,.F.,8)                        // 093 - 100  -> Periodo Utilizacao De
cTexto += GravaData(dUtilAte,.F.,8)                       // 101 - 108  -> Periodo Utilizacao Ate
cTexto += Transform((fGerZero(12,nPercKit)),"000000000.00") // 109 - 120 -> Preco de 01 Kit
cTexto += transform((fGerZero(12,nVlPonto)),"999999999.99")   // 121 - 132 -> Preco por Ponto Entrega
cTexto += "N"                                             // 133 - 133 -> Tipo do Pedido
cTexto += StrZero(aTotVal[TOTUEN],4)                      // 134 - 137 -> Qde Unidades Pagas
cTexto += "C"                                             // 138 - 138 -> Ordem do Pedido TT
cTexto += "P"                                             // 139 - 139 -> Tipo Rateio Entregas
cTexto += "%  "                                           // 140 - 142 -> Moeda do Kit
cTexto += "R$ "                                           // 143 - 145 -> Moeda da Entrega
cTexto += CRLF

aTotVal[TOTDET] += 1

fGravaReg(AllTrim(cTexto))

Return
//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGerTTUN  ºAutor  ³JORGE SATO          º Data ³  01/03/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gera Registro TTUN                                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PROTHEUS 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function fGerTTUN()

cTexto := "TTUN"                                                // 001 - 004 -> Tipo de Registro
cTexto += transform((fGerZero(14,aInfoE[3])),"@r 99.999.999/9999-99")// 005 - 022 -> CNPJ
cTexto += "K."+SUBSTR(Dtoc(dDataRef),1,2)+SUBSTR(Dtoc(dDataRef),3,4)+SUBSTR(Dtoc(dDataRef),9,2)                        // 023 - 032 -> Numero do Pedido
cTexto += fGerZero(6,aShTaSAli[nPos,05])                        // 033 - 038 -> Codigo Un. Entrega
cTexto += fGerStr(26,aShTaSAli[nPos,06])                        // 039 - 064 -> Nome Uni.Entrega
cTexto += fGerStr(4,aShTaSAli[nPos,07])                         // 065 - 068 -> Tipo Logradouro
cTexto += fGerStr(30,aShTaSAli[nPos,08])                        // 069 - 098 -> Nome do Logradouro
cTexto += fGerZero(6,aShTaSAli[nPos,09])                        // 099 - 104 -> Numero do Logradouro
cTexto += fGerStr(10,aShTaSAli[nPos,10])                        // 105 - 114 -> Complemento do Logradouro
cTexto += fGerStr(15,aShTaSAli[nPos,11])                        // 115 - 129 -> Bairro
cTexto += fGerStr(25,aShTaSAli[nPos,12])                        // 130 - 154 -> Municipio
cTexto += aShTaSAli[nPos,13]                                    // 155 - 163 -> CEP
cTexto += aShTaSAli[nPos,14]                                    // 164 - 165 -> Estado
cTexto += GravaData(dEntrMin,.F.,8)                             // 166 - 173 -> Data Minima Entrega
cTexto += GravaData(dEntrMax,.F.,8)                             // 174 - 181 -> Data Maxima Entrega
cTexto += fGerStr(20,aShTaSAli[nPos,16])                        // 182 - 201 -> Responsavel Recebimento
cTexto += fGerZero(11,aShTaSAli[nPos,17])                       // 202 - 212 -> Fone Contato
cTexto += fGerZero(4,aShTaSAli[nPos,18])                        // 213 - 216 -> Ramal
cTexto += "S"                                                   // 217 - 217 -> Lista de Assinatura
cTexto += Space(40)                                             // 218 - 257 -> Reservado
cTexto += "S"                                                   // 258 - 258 -> Separacao por Departamento
cTexto += CRLF
aTotVal[TOTUEN] += 1
aTotVal[TOTDET] += 1

fGravaReg(AllTrim(cTexto))
Return
//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGerTTDE  ºAutor  ³JORGE SATO         º Data ³  01/03/2017  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gera Registro TTDE                                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PROTHEUS 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function fGerTTDE()
	
	//Departamento
cTexto := "TTDE"                                             // 001 - 004 -> Tipo de Produto
cTexto += transform((fGerZero(14,aInfoE[3])),"@r 99.999.999/9999-99")// 005 - 022 -> CNPJ
cTexto += "K."+SUBSTR(Dtoc(dDataRef),1,2)+SUBSTR(Dtoc(dDataRef),3,4)+SUBSTR(Dtoc(dDataRef),9,2)    //+left(Dtoc(dDataRef),10)                        // 023 - 032 -> Numero do Pedido
cTexto += fGerZero(6,aShTaSAli[nPos,05])                     // 033 - 038 -> Codigo Un. Entrega
cTexto += fGerZero(6,R0NW->RA_CC)//fGerZero(6,aShTaSAli[nPos,05]) //039 - 044 -> Codigo Departamento
cTexto += fGerStr(26,R0NW->CTT_DESC01) //fGerStr(26,Posicione("CTT",1,cSetor,"CTT_DESC01")) // 045 - 070 -> Nome Departamento
cTexto += Space(20)                                          // 071 - 090 -> Reservado
cTexto += transform((fGerZero(14,aInfoE[3])),"@r 99.999.999/9999-99") // 091 - 108 -> CNPJ de Faturamento
cTexto += CRLF
aTotVal[TOTDEP]	+= 1
aTotVal[TOTDET]	+= 1	

fGravaReg(AllTrim(cTexto))
Return
//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGerTTFU  ºAutor  ³JORGE SATO         º Data ³  01/03/2017  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gera Registro TTFU                                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PROTHEUS 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function fGerTTFU()
	
cTexto := "TTFU"                                          // 001 - 004 -> Tipo do Produto
cTexto += cCNPJ											  // 005 - 022 -> Cnpj Principal
cTexto += "K."+SUBSTR(Dtoc(dDataRef),1,2)+SUBSTR(Dtoc(dDataRef),3,4)+SUBSTR(Dtoc(dDataRef),9,2)  // 023 - 032 -> Numero do Pedido
cTexto += fGerZero(6,aShTaSAli[nPos,05])                  // 033 - 038 -> Codigo da Unidade
cTexto += fGerZero(6,R0NW->RA_CC)                         // 039 - 044 -> Codigo Departamento
cTexto += fGerZero(12,R0NW->RA_CIC)		                   // 045 - 056 -> Codigo do Funcionario
cTexto += fGerStr(30,R0NW->RA_NOME)                        // 057 - 086 -> Nome do Funcionario
cTexto += fGerStr(10,STRTRAN(R0NW->RA_RG,".",""),1,10)     // 087 - 096 -> Nro RG do funcionário
cTexto += fGerZero(11,R0NW->RA_CIC)                        // 097 - 107 -> Nro CPF do funcionário
cTexto += Space(4)							              // 108 - 111 -> Reservado
cTexto += GravaData(R0NW->RA_NASC,.F.,8)           		  // 112 - 119 -> Data Nascimento aaaammdd
cTexto += R0NW->RA_RGUF                        			  // 120 - 121 -> Estado de Emissao do RG
cTexto += R0NW->RA_SEXO                        			  // 122 - 122 -> Sexo do funcionário
cTexto += fGerStr(30,R0NW->RA_MAE)                         // 123 - 152 -> Nome da Mãe do funcionário
cTexto += fGerStr(5,R0NW->RA_LOGRTP)                       // 153 - 157 -> Tipo do Logradouro fixamos "RUA"
cTexto += fGerStr(40,R0NW->RA_ENDEREC)                     // 158 - 197 -> Nome da Mãe do funcionário  //At(",",SM0->M0_ENDCOB)
cTexto += fGerZero(6,R0NW->RA_NUMENDE)                     // 198 - 203 -> Nro. do Logradouro fixamos "000000"
cTexto += fGerStr(15,R0NW->RA_COMPLEM)                     // 204 - 218 -> Complemento do Endereco
cTexto += fGerStr(40,R0NW->RA_MUNICIP)               	  // 219 - 258 -> Municipio do Endereco
cTexto += fGerStr(30,R0NW->RA_BAIRRO)               		  // 259 - 288 -> Municipio do Endereco
cTexto += fGerZero(8,R0NW->RA_CEP) //SUBSTR(R0NW->RA_CEP,1,8)+ "-" + SUBSTR(R0NW->RA_CEP,6,3) // 289 - 296 -> Cep do Endereco
cTexto += R0NW->RA_ESTADO  								  // 297 - 298 -> Estado do Endereco
cTexto += "000201" 										 // 299 - 304 -> Rede de Recarga
cTexto += CRLF
	
aTotVal[TOTFUT]	+= 1
aTotVal[TOTDET]	+= 1

Return
//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGerTTIT  ºAutor  ³JORGE SATO         º Data ³  01/03/2017  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gera Registro TTIT                                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PROTHEUS 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function fGerTTIT()

cTexto := "TTIT"                                             // 001 - 004 -> Tipo do Produto
cTexto += cCNPJ											     // 005 - 022 -> Cnpj Principal
cTexto += "K."+SUBSTR(Dtoc(dDataRef),1,2)+SUBSTR(Dtoc(dDataRef),3,4)+SUBSTR(Dtoc(dDataRef),9,2)  // 023 - 032 -> Numero do Pedido
cTexto += fGerZero(6,aShTaSAli[nPos,05])                     // 033 - 038 -> Codigo da Unidade
cTexto += fGerZero(6,R0NW->RA_CC)	                         // 039 - 044 -> Codigo Departamento
cTexto += fGerZero(12,R0NW->RA_CIC)						     // 045 - 056 -> Codigo do Funcionario
cTexto += StrZero(nSeqFu_,3)                          		 // 057 - 059 -> Seq Itens Funcionario
cTexto += StrZero(R0NW->R0_QDIACAL,8)                         // 060 - 067 -> Qde Bilhetes/Viagens
cTexto += fGerZero(9,Transform(R0NW->RN_VUNIATU,'999999.99')) // 068 - 076 -> Valor Tarifa do Item
cTexto += fGerStr(6,R0NW->RFP_TKCDOP)                           // 077 - 082 -> Codigo Operadora Transp
cTexto += fGerStr(12,R0NW->RFP_TKCDBL)                        // 083 - 094 -> Codigo Bilhete Operadora
cTexto += fGerStr(4,R0NW->RFP_TKTPBL)                         // 095 - 098 -> Tipo Bilhete
cTexto += "N"                                           	 // 099 - 099 -> Flag Tipo Pedido
cTexto += CRLF 

aTotVal[TOTITT]	+= 1
aTotVal[TOTPAS]	+= R0NW->R0_QDIACAL
aTotVal[TOTDET]	+= 1
aTotVal[TOTVVT]	+= R0NW->R0_QDIACAL*R0NW->RN_VUNIATU 

Return
//Fim da Rotina


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGerTT99  ºAutor  ³JORGE SATO         º Data ³  01/03/2017  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gera Registro TT99                                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PROTHEUS 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function fGerTT99()

cTexto := "9999"                               // 001 - 004 -> Fixo "9999"
cTexto += StrZero(aTotVal[TOTITT],8)           // 005 - 012 -> Total Linhas
cTexto += Space(152)                           // 013 - 164 -> Brancos
cTexto += CRLF

aTotVal[TOTTRA]	+= 1

fGravaReg(AllTrim(cTexto))

Return
//Fim da Rotina


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGerLSUP9 ºAutor ³ JORGE SATO          º Data ³  01/03/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gera Registro LSUP9                                        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function fGerLSUP9()

cTexto := "LSUP9"                     			// 001 - 005 -> Tipo do Registro
cTexto += StrZero(aTotVal[TOTHEA],8)  			// 006 - 013 -> Total Header´s
cTexto += StrZero(aTotVal[TOTTRA],8)  			// 014 - 021 -> Total Trailler´s
cTexto += StrZero(aTotVal[TOTDET],8)  			// 022 - 029 -> Total Registros
cTexto += Space(135)                  			// 030 - 165 -> Brancos
cTexto += CRLF

fGravaReg(AllTrim(cTexto))

Return

//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ fGravaReg   ³ Autor ³ JORGE SATO       º Data ³ 01/03/2017 º±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Grava Registros no Arquivo Texto                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fGravaReg()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ KITVTBDIL                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fGravaReg(cLin)

If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
	If !MsgYesNo('Ocorreu um erro na gravacao do arquivo '+AllTrim(cNomeArq)+'.   Continua?','Atencao!')
		lContinua := .F.
		Return
	Endif
Endif

Return

//Fim da Rotina


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³  fGerStr ºAutor ³ JORGE SATO         º Data ³  01/03/2017 º±±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Acrescenta espacos a direita                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function fGerStr(nNum,cVaria)

Local cVar

cVar := AllTrim(cVaria) + Space(nNum)

cVar := Subst(cVar,1,nNum)

Return(cVar)

//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGerZero  ºAutor ³ JORGE SATO         º Data ³  01/03/2017 º±±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Acrescenta zeros a Esquerda                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function fGerZero(nNum,cVaria)

Local cVar

cVar := Replic("0",nNum) + AllTrim(cVaria)

cVar := Right(cVar,nNum)

Return(cVar)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fChkPerg  ºAutor ³ JORGE SATO         º Data ³  01/03/2017 º±±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Perguntas do Sistema.                                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Protheus 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function fChkPerg()

Local aRegs := {}
Local Fi    := FWSizeFilial()

aAdd(aRegs,{cPerg,'01','Data de Referencia      ?','','','mv_ch1','D',08,0,0,'G','NaoVazio   ','mv_par01','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ','','',''})
aAdd(aRegs,{cPerg,'02','Filial De               ?','','','mv_ch2','C',Fi,0,0,'G','           ','mv_par02','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','XM0','','',''})
aAdd(aRegs,{cPerg,'03','Filial Ate              ?','','','mv_ch3','C',Fi,0,0,'G','NaoVazio   ','mv_par03','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','XM0','','',''})
aAdd(aRegs,{cPerg,'04','Matricula De            ?','','','mv_ch4','C',06,0,0,'G','           ','mv_par04','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SRA','','',''})
aAdd(aRegs,{cPerg,'05','Matricula Ate           ?','','','mv_ch5','C',06,0,0,'G','NaoVazio   ','mv_par05','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SRA','','',''})
aAdd(aRegs,{cPerg,'06','Centro de Custo De      ?','','','mv_ch6','C',12,0,0,'G','           ','mv_par06','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','CTT','','',''})
aAdd(aRegs,{cPerg,'07','Centro de Custo Ate     ?','','','mv_ch7','C',12,0,0,'G','NaoVazio   ','mv_par07','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','CTT','','',''})
aAdd(aRegs,{cPerg,'08','Situacoes a Imprimir    ?','','','mv_ch8','C',05,0,0,'G','fSituacao  ','mv_par08','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ','','',''})
aAdd(aRegs,{cPerg,'09','Categorias a Imprimir   ?','','','mv_ch9','C',12,0,0,'G','fCategoria ','mv_par09','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ','','',''})
aAdd(aRegs,{cPerg,'10','VT - Utilizacao De      ?','','','mv_cha','D',08,0,0,'G','NaoVazio   ','mv_par10','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ','','',''})
aAdd(aRegs,{cPerg,'11','VT - Utilizacao Ate     ?','','','mv_chb','D',08,0,0,'G','NaoVazio   ','mv_par11','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ','','',''})
aAdd(aRegs,{cPerg,'12','VT - Dt Entrega Minima  ?','','','mv_chc','D',08,0,0,'G','NaoVazio   ','mv_par12','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ','','',''})
aAdd(aRegs,{cPerg,'13','VT - Dt Entrega Maxima  ?','','','mv_chd','D',08,0,0,'G','NaoVazio   ','mv_par13','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ','','',''})
aAdd(aRegs,{cPerg,'14','Local e Nome do Arquivo ?','','','mv_che','C',70,0,0,'G','NaoVazio   ','mv_par14','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','DIR','','',''})
                                             
ValidPerg(aRegs,cPerg,.F.)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ fImpLis      ³ Autor ³ JORGE SATO     º Data ³  01/03/2017 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ imprime totais para conferencia                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fImpLis()                                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fImpLis()
cString  := ''
aOrd     := {}
aReturn  := { '', 1,'', 1, 2, 2,'',1 }
nTamanho := 'P'
Titulo   := 'LISTAGEM DE TOTAIS DO PEDIDO'
cDesc1   := 'Emissao de Relatorio com totais dos valores do pedido '
cDesc2   := ''
cDesc3   := ''
cPerg    := ''
cCancel  := '*** ABORTADO PELO OPERADOR ***'
wCabec1	 := 'Empresa: '+SM0->M0_NOMECOM
wCabec2  := '   CNPJ: '+cCNPJ
NomeProg := 'TotBenef'
nLastKey := 0
m_pag    := 0
li       := 0
ContFl   := 1
nOrdem	 := 0
lEnd     := .F.
wnrel    := 'TotBenef'
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,nTamanho)
If nLastKey == 27
	Return
Endif
SetDefault(aReturn,cString)
If nLastKey == 27
	Return
Endif
nOrdem   := aReturn[8]
//Processa Impressao
RptStatus({|lEnd| ImprRel()},'Imprimindo...')
Return


//------------------------//
Static Function ImprRel() //
//------------------------//

cDet := 'Arquivo: '+alltrim(cNomeArq)
Impr(cDet,'C')

cDet := " "
Impr(cDet,'C')

cDet := "      Total VT "
Impr(cDet,'C')

cDet := Transform(aTotVal[TOTVVT],'@E 999,999,999.99')+" "+Transform(aTotVal[TOTVVR],'@E 999,999,999.99')+" "

Impr(cDet,'C')

cDet := " "
Impr(cDet,'C')

Impr(cDet,'C')
nTotG := aTotVal[TOTVVT]

cDet := "                                                               Total Geral"
Impr(cDet,'C')

cDet := space(60)+Transform(nTotG,'@E 999,999,999.99')
Impr(cDet,'C')

If aReturn[5] == 1
	Set Printer TO
	ourspool(wnrel)
Endif
MS_FLUSH()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGTTFU  ºAutor  ³  JORGE SATO         º Data ³  01/03/2017  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gera Registro TTFU                                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PROTHEUS 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function fGTTFU()

Local   aShTaSAli:= {}
Local cCNPJ	:= transform((fGerZero(14,aInfoE[3])),"@r 99.999.999/9999-99")

fCarrTab( @aShTaSAli,"U002")

dbSelectArea("RCC")
dbSetorder(1)
if dbSeek(xfilial("RCC")+"U002")
	IF RCC->RCC_FILIAL + RCC->RCC_CODIGO == xFilial("RCC") + "U002" .AND. SUBST(RCC->RCC_FIL,1,1) == " "
		nPos := 1
	ELSEIf (Ascan(aShTaSAli,{|x| x[2]== RCC->RCC_FIL}))
		nPos := Ascan(aShTaSAli,{|x| x[4]})
	EndIf
	
	cTexto := "TTFU"                                          // 001 - 004 -> Tipo do Produto
	cTexto += cCNPJ											  // 005 - 022 -> Cnpj Principal
	cTexto += "K."+SUBSTR(Dtoc(dDataRef),1,2)+SUBSTR(Dtoc(dDataRef),3,4)+SUBSTR(Dtoc(dDataRef),9,2)  // 023 - 032 -> Numero do Pedido
	cTexto += fGerZero(6,aShTaSAli[nPos,05])                  // 033 - 038 -> Codigo da Unidade
	cTexto += fGerZero(6,R0NW->RA_CC)                         // 039 - 044 -> Codigo Departamento
	cTexto += fGerZero(12,R0NW->RA_CIC)		                   // 045 - 056 -> Codigo do Funcionario
	cTexto += fGerStr(30,R0NW->RA_NOME)                        // 057 - 086 -> Nome do Funcionario
	cTexto += fGerStr(10,STRTRAN(R0NW->RA_RG,".",""),1,10)     // 087 - 096 -> Nro RG do funcionário
	cTexto += fGerZero(11,R0NW->RA_CIC)                        // 097 - 107 -> Nro CPF do funcionário
	cTexto += Space(4)							              // 108 - 111 -> Reservado
	cTexto += GravaData(R0NW->RA_NASC,.F.,8)           		  // 112 - 119 -> Data Nascimento aaaammdd
	cTexto += R0NW->RA_RGUF                        			  // 120 - 121 -> Estado de Emissao do RG
	cTexto += R0NW->RA_SEXO                        			  // 122 - 122 -> Sexo do funcionário
	cTexto += fGerStr(30,R0NW->RA_MAE)                         // 123 - 152 -> Nome da Mãe do funcionário
	cTexto += fGerStr(5,R0NW->RA_LOGRTP)                       // 153 - 157 -> Tipo do Logradouro fixamos "RUA"
	cTexto += fGerStr(40,R0NW->RA_ENDEREC)                     // 158 - 197 -> Endereco do funcionário 
	cTexto += fGerZero(6,R0NW->RA_NUMENDE)                     // 198 - 203 -> Nro. do Logradouro fixamos "000000"
	cTexto += fGerStr(15,R0NW->RA_COMPLEM)                     // 204 - 218 -> Complemento do Endereco
	cTexto += fGerStr(40,R0NW->RA_MUNICIP)               	  // 219 - 258 -> Municipio do Endereco
	cTexto += fGerStr(30,R0NW->RA_BAIRRO)               	  // 259 - 288 -> Bairro do Endereco
	cTexto += fGerZero(8,R0NW->RA_CEP)                        // 289 - 296 -> Cep do Endereco
	cTexto += R0NW->RA_ESTADO  								  // 297 - 298 -> Estado do Endereco
	cTexto += "000201" 										 // 299 - 304 -> Rede de Recarga
	cTexto += CRLF

ENDIF 
fGravaReg(AllTrim(cTexto))
Return
//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fGTTIT  ºAutor  ³  JORGE SATO         º Data ³  01/03/2017  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gera Registro TTIT                                         º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ PROTHEUS 12                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß */

Static Function fGTTIT()

Local   aShTaSAli:= {}
Local   cCNPJ 	:= transform((fGerZero(14,aInfoE[3])),"@r 99.999.999/9999-99")

fCarrTab( @aShTaSAli,"U002")

dbSelectArea("RCC")
dbSetorder(1)
if dbSeek(xfilial("RCC")+"U002")
	IF RCC->RCC_FILIAL + RCC->RCC_CODIGO == xFilial("RCC") + "U002" .AND. SUBST(RCC->RCC_FIL,1,1) == " "
		nPos := 1
	ELSEIf (Ascan(aShTaSAli,{|x| x[2]== RCC->RCC_FIL}))
		nPos := Ascan(aShTaSAli,{|x| x[4]})
	EndIf

	cTexto := "TTIT"                                             // 001 - 004 -> Tipo do Produto
	cTexto += cCNPJ											     // 005 - 022 -> Cnpj Principal
	cTexto += "K."+SUBSTR(Dtoc(dDataRef),1,2)+SUBSTR(Dtoc(dDataRef),3,4)+SUBSTR(Dtoc(dDataRef),9,2)  // 023 - 032 -> Numero do Pedido
	cTexto += fGerZero(6,aShTaSAli[nPos,05])                     // 033 - 038 -> Codigo da Unidade
	cTexto += fGerZero(6,R0NW->RA_CC)	                         // 039 - 044 -> Codigo Departamento
	cTexto += fGerZero(12,R0NW->RA_CIC)						     // 045 - 056 -> Codigo do Funcionario
	cTexto += StrZero(nSeqFu_,3)                          		 // 057 - 059 -> Seq Itens Funcionario
	cTexto += StrZero(R0NW->R0_QDIACAL,8)                         // 060 - 067 -> Qde Bilhetes/Viagens
	cTexto += fGerZero(9,Transform(R0NW->RN_VUNIATU,'999999.99')) // 068 - 076 -> Valor Tarifa do Item
	cTexto += fGerStr(6,R0NW->RFP_TKCDOP)                           // 077 - 082 -> Codigo Operadora Transp
	cTexto += fGerStr(12,R0NW->RFP_TKCDBL)                        // 083 - 094 -> Codigo Bilhete Operadora
	cTexto += fGerStr(4,R0NW->RFP_TKTPBL)                         // 095 - 098 -> Tipo Bilhete
	cTexto += "N"                                           	 // 099 - 099 -> Flag Tipo Pedido
	cTexto += CRLF 

ENDIF 
fGravaReg(AllTrim(cTexto))
Return
//Fim da Rotina
