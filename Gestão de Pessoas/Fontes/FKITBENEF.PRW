#INCLUDE "rwmake.ch"
#DEFINE     cEol        Chr(13)+Chr(10)
#DEFINE     HEADER      1
#DEFINE     TRAILLER    2
#DEFINE     DETALHES    3

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFKITBENEF บAutor  ณ  JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Gera็ใo do arquivo de compra de Beneficios (VR/VA/VT)      ณฑฑ
ฑฑณ			 ณ                                                            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑบUso       ณ MILANO COMERCIO VAREJISTA DE ALIMENTOS S.A.                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User function FKITBENEF()

//Declaracao de Variaveis
private cPerg      := PADR("FKITBENEF",LEN(SX1->X1_GRUPO))
private oGeraTxt
private cString := "SRA"
private nDiver:=0
Private cEndereco
Private cNumero
Private cMinhaFil	:= ""

dbSelectArea("SRA")
dbSetOrder(1)

fPerg()
pergunte(cPerg,.T.)

//Montagem da tela de processamento.
@ 200,001 TO 410,480 DIALOG oGeraTxt TITLE OemToAnsi( "Geracao do Kit Beneficios Ticket" )
@ 02,10 TO 095,230
@ 10,018 Say " Este programa ira gerar um arquivo texto, conforme os parame- "
@ 18,018 Say " tros definidos  pelo usuario,  com os registros do arquivo de "
@ 26,018 Say " Geracao de Arquivo Texto para Aquisicao do Kit Beneficios.    "

@ 70,128 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oGeraTxt)
@ 70,188 BMPBUTTON TYPE 01 ACTION OkGeraTxt()

Activate Dialog oGeraTxt Centered

fClose(nDiver)
u__fCloseDb("TMB")

Return()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณOKGERATXT บAutor  ณ  JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

Static Function OkGeraTxt()

Processa({|| RunCont() },"Processando...")

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRUNCONT   บAutor  ณ  JORGE SATO        บ Data ณ  28/02/201  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static function RunCont()

local cFilDe, cFilAte
local cMatDe, cMatAte, cCcDe, cCcAte, cSit, cCat, clocal
local cFilAnt, cCcAnt , cDeptoAnt
local lFirst, lProcessou, lWithMov, lTTitVt, lTTitVtD
local lTtde, lTtUn, lHdte, lHdva
local aDiver, aCodFol
local aCc   := {}
local nPos3 := 0
local lReprocessa
local i
Local nX	:= 0
Local lGravaLog	:= .F.
Local aDeptoProc	:= {}
Local nPosDepto	:= 0

private dDataRef, cAnoMes
private nVlPonto, dUtilDe, dUtilAte, dEntrMin, dEntrMax, cGrupoDe, cGrupoAte
private dVrEntr, dVaEntr, dDtDesc
private nTotVA, nTotVR
private lAlimentacao, lRestaurante, lRestEletro, lTransporte, lCombustivel
private nAtuSRK
private cArq     := "KITBENEF.TXT"
private aInfo    := {}
private aResp    := {}
private aPd      := {}
private aTotTTPE := {}
private lAbort   := .F.
private xDiasMes
private nTItemSeq := 0      // Sequencia dos Itens do Pedido
private nTVlrServ := 0      // Valor dos Servicos do Pedido
private nTotTik   := 0      // Total de Tickets do VR
private nVlTotTic := 0      // Valor Total do VR
private nVlTic 	  := 0      // Valor Total do VR
private nTotFunc  := 0      // Quantidade de Funcionแrios
private nValVA    := 0      // Valor do VA
private nTValVA   := 0      // Valor Total do Pedido do VA
private nSomaVt   := 0
Private nSomaVtD  := 0      //soma dif. vt chamado 003721
private aLsup9    := {0,0,0} // 1=Header - 2=Trailler - 3=Total
private aTotVa    := {0,0}   // 1=Total de Funcionarios - 2=Valor Total do VA
private aTotVr    := {0,0}   // 1=Total de Funcionarios - 2=Valor Total do VA
private lTr01     := .F.
Private nSeqComb  := 0
Private nValCred  := 0
Private nTotLin   := 0
Private nValTot	  := 4
Private cSRAObrig := ""
Private lGeraLog  := .F.
Private lGravaVT  := .F.
Private cLogTransp := ""
Private aLogTransp := {}

count:= "08"
lin  := 1

Pergunte(cPerg,.F.)

dDataRef     	:= mv_par01
lAlimentacao 	:= If(mv_par02==1,.T.,.F.)
lRestaurante 	:= If(mv_par03==1,.T.,.F.)
lTransporte  	:= If(mv_par04==1,.T.,.F.)
lCombustivel  	:= If(mv_par05==1,.T.,.F.)
cFilDe       	:= AllTrim(mv_par06)
cFilAte      	:= AllTrim(mv_par07)
cMatDe       	:= mv_par08
cMatAte      	:= mv_par09
cCcDe        	:= mv_par10
cCcAte       	:= mv_par11
cSit         	:= mv_par12
cCat         	:= mv_par13
clocal       	:= Alltrim(mv_par14)
nVlPonto     	:= mv_par15
dUtilDe      	:= mv_par16
dUtilAte     	:= mv_par17
dEntrMin     	:= mv_par18
dEntrMax     	:= mv_par19
dVrEntr      	:= mv_par20
dVaEntr      	:= mv_par21
cUsuSistema  	:= SUBS(MV_PAR22,1,8)
cAnoMes      	:= Str(Year(dDataRef),4) + StrZero(Month(dDataRef),2)
lTeveVA         := .f.
nLogTransp		:= 0

xDiasMes := fUDia(dDataRef)

clocal += If(Right(clocal,1)#"\","\","")

//SET DELETED OFF

If ( lCombustivel )
	
	cArq := cLocal + "XXXDCC01ETC10" + dToS(Date()) + StrTran(Time() , ":" , "") + "H" + ".TXT" //xyz Pegar o c๓digo do cliente (XXX)
		
	/*XXX - Sigla para identificar o cliente
	DCC01 - Sistema e versใo do layout
	E/R - Arquivo de entrada (E) ou retorno (R)
	TC - Produto Ticket Car
	10 - Tipo de arquivo “Transfer๊ncia Financeira WATTS TC”
	YYYYMMDDHHNNSSFF - Data e hora do arquivo, sendo:
	YYYY – Ano
	MM – M๊s
	DD – Dia
	HH – Hora
	NN – Minuto
	SS – Segundo
	FF – Milissegundo
	P/H - Ambiente de produ็ใo (P) ou homologa็ใo (H)*/

Else

	If ( lTransporte )
		
		cLogTransp	:= cLocal + "LOG DE ERROS - VALE TRANSPORTE.TXT"		
	
	EndIf		

	cArq := clocal+"KITBENEF.TXT"	
	
EndIf

If !fMtResp(@aResp)
	Aviso("Registro Invalido","Parametro Especifico nao Cadastrado!!!",{"Atencao!"})
	Return
EndIf

//Verifica se Existe Algum Item Selecionado
If !lAlimentacao .And. !lRestaurante .And. !lTransporte .And. !lCombustivel
	Aviso("Opcao Invalida","As opcoes nao foram selecionadas.",{"Atencao!"})
	Return
EndIf

//Cria o Arquivo para os Ticket Restaurante, Transporte e Combustivel
If lAlimentacao .Or. lRestaurante .Or. lTransporte .Or. lCombustivel

    If File( cArq )
       If Aviso("ATENCAO","O Arquivo " + cArq + " Jแ Existe. Sobrepor?",{"Nใo","Sim"}) == 1
          Return
       EndIf
    EndIf

	nDiver :=  fCreate(cArq)

	If nDiver == -1
		Aviso("Arquivo Invalido","O arquivo "+cArq+" nao pode ser criado! Verifique os parametros.",{"Atencao!"})
		Return
	Endif
	If !fCriaDbf("DIVER")
		Aviso("Arquivo Invalido","Nao foi possivel criar o arquivo temporario!!!.",{"Atencao!"})
		Return
	EndIf
EndIf

aDiver    := {}
aCodFol   := {}

dbSelectArea( "CTT" )
dbSetOrder(1)

dbSelectArea( "SR0" )
dbSetOrder(1)

dbSelectArea( "SRN" )
dbSetOrder(1)

lFirst     := .T.
lTtun      := .T.
lHdte      := .T.
lHdtre     := .T.
lHdva      := .T.
lTtde      := .T.
lProcessou := .F.

cDeptoAnt	:= ""

fInfo(@aInfo,"001") //fInfo(@aInfo,"01")
/*If !Fp_CodFol(@aCodFol,"02")
	Return
EndIf*/

// Processa Validacao dos Centros de Custo.
dbSelectArea( "CTT" )
dbGoTop()

ProcRegua( RecCount() )

lReprocessa := .T.
Do While !Eof()
	IncProc( "Verificando Centros de Custo Validos..." )

	If CTT->CTT_CUSTO < cCcDe    .Or. CTT->CTT_CUSTO > cCcAte
		dbSkip()
		Loop
	EndIf

	Aadd(aCc,{ CTT->CTT_CUSTO,"FAZ",CTT->(Recno()) })

	dbSelectArea("CTT")
	CTT->(dbSkip())
EndDo

If !lAbort

	If ( lCombustivel )
	
		aDiver := {}
		fBenComb(@aDiver)
		fDbfGrava("0000" ,aDiver ,"DIVER")
	
	Else
	
		// Grava Header Arquivo Transporte
		aDiver := {}
		fBenLsup5(@aDiver)
		fDbfGrava("0000" ,aDiver ,"DIVER")
		aLsup9[HEADER]++

		If lTransporte //lAlimentacao .Or. lRestaurante .Or. lTransporte
			aDiver := {}
			fBenHdTT(@aDiver)
			fDbfGrava("0001" ,aDiver ,"DIVER")
			aLsup9[HEADER]++
		EndIf
		// Grava Header Arquivo Refeicao - Registro 0
		If lRestaurante
			aDiver := {}
			fBenHdTR(@aDiver)
			fDbfGrava("ZX07" ,aDiver ,"DIVER")
			aLsup9[HEADER]++
		EndIf
	
	EndIf

EndIf

dbSelectArea("SRA")
dbSetOrder(2)
ProcRegua(RecCount())

If cFilDe+cMatDe == cFilAte+cMatAte
	dbSetOrder(1)
	dbSeek( cFilDe+cMatDe )
	dbSetOrder(3)
Else
	dbSeek( cFilDe,.T. )
EndIf

If ( lTransporte )
	
	SRA->(dbSetOrder(3))
	SRA->(dbGoTop())
	
EndIF

// Inicio do Loop
lDesFez := .F.
lJaFez  := .f.
cFilAnt := "@@"
aFilPrc := {}
cFilPrc := ""
lCCOk   := .F.

While !SRA->( Eof() )

	If ( SRA->RA_FILIAL <= cFilAte .And. !lAbort )	

		If Ascan( aFilPrc, SRA->RA_FILIAL ) == 0
			cFilPrc += SRA->RA_FILIAL+"/"  // 01/02/03
			Aadd( aFilPrc, SRA->RA_FILIAL )
		EndIf

		IncProc( SRA->(RA_FILIAL+" - "+RA_MAT+" - "+RA_NOME) )		

		If cFilDe+cMatDe == cFilAte+cMatAte
			If SRA->(RA_FILIAL+RA_MAT) # cFilDe+cMatDe
				Exit
			EndIf
		EndIf

		If (SRA->RA_FILIAL  < cFilDe  .Or. SRA->RA_FILIAL  > cFilAte)  .Or. ;
			(SRA->RA_MAT     < cMatDe  .Or. SRA->RA_MAT     > cMatAte)  .Or. ;
			!(SRA->RA_SITFOLH $ cSit) .Or. !(SRA->RA_CATFUNC $ cCat)
			SRA->( dbSkip() )
			Loop
		EndIf	

		CTT->(dbSeek( xFilial("CTT")+SRA->RA_CC ))

		If lFirst
			cFilAnt := SRA->RA_FILIAL
			cCcAnt  := SRA->RA_CC
			aInfo   := {}
			If !fInfo(@aInfo,SRA->RA_FILIAL)
				Exit
			EndIf
			lFirst  := .F.
		EndIf

		// Quebra por Filial
		If AllTrim(SRA->RA_FILIAL) # AllTrim(cFilAnt)
			cFilAnt := SRA->RA_FILIAL
			aInfo   := {}
			If !fInfo(@aInfo,SRA->RA_FILIAL)
				Exit
			EndIf
			lTtUn   := .T.
			lHdte   := .T.
			lHdva   := .T.
		EndIf

		If lTransporte			
			
			// Grava Itens por Funcionario
			nTItemSeq := 0
			lWithMov  := .F.
			nSomaVt   := 0
			nSomaVtD  := 0
			lTTitVt   := .F.
			lTTitVtD  := .F.

			dbSelectArea( "SR0" )
			dbSetOrder(1)
			If ( dbSeek( SRA->RA_FILIAL+SRA->RA_MAT ) )
			
				cSRAObrig	:= ""
				lGravaLog	:= .F.
				lGravaVT	:= .F.
				
				While !Eof() .And. SR0->R0_FILIAL+SR0->R0_MAT == SRA->RA_FILIAL+SRA->RA_MAT

					If SR0->R0_TpVale <> '0'
						SR0->(dbSkip())
						Loop
					EndIf

					If SR0->R0_VALCAL == 0
						SR0->(dbSkip())
						Loop
					EndIf
					
					IF EMPTY(SRA->RA_RG)
						cSRAObrig += ALLTRIM(RetTitle("RA_RG")) + ", "
					ENDIF

					IF EMPTY(SRA->RA_CIC)
						cSRAObrig += ALLTRIM(RetTitle("RA_CIC"))
					ENDIF				
					
					IF EMPTY(SRA->RA_NASC)
						cSRAObrig += ALLTRIM(RetTitle("RA_NASC")) + ", "
					ENDIF		

					IF EMPTY(SRA->RA_RGUF)
						cSRAObrig += ALLTRIM(RetTitle("RA_RGUF")) + ", "
					ENDIF
					IF EMPTY(SRA->RA_SEXO)
						cSRAObrig += ALLTRIM(RetTitle("RA_SEXO")) + ", "
					ENDIF
					
					IF EMPTY(SRA->RA_MAE)
						cSRAObrig += ALLTRIM(RetTitle("RA_MAE")) + ", "
					ENDIF
					
					IF EMPTY(SRA->RA_LOGRTP)
						cSRAObrig += ALLTRIM(RetTitle("RA_LOGRTP")) + ", "
					ENDIF
					
					IF EMPTY(SRA->RA_LOGRDSC)
						cSRAObrig += ALLTRIM(RetTitle("RA_LOGRDSC")) + ", "
					ENDIF

					IF EMPTY(SRA->RA_LOGRNUM)
						cSRAObrig += ALLTRIM(RetTitle("RA_LOGRNUM")) + ", "
					ENDIF

					IF EMPTY(SRA->RA_COMPLEM)
						cSRAObrig += ALLTRIM(RetTitle("RA_COMPLEM")) + ", "
					ENDIF

					IF EMPTY(SRA->RA_MUNICIP)
						cSRAObrig += ALLTRIM(RetTitle("RA_MUNICIP")) + ", "
					ENDIF

					IF EMPTY(SRA->RA_BAIRRO)
						cSRAObrig += ALLTRIM(RetTitle("RA_BAIRRO")) + ", "
					ENDIF
					
					IF EMPTY(VAL(SRA->RA_CEP))
						cSRAObrig += ALLTRIM(RetTitle("RA_CEP")) + ", "
					ENDIF
					
					IF EMPTY(SRA->RA_ESTADO)
						cSRAObrig += ALLTRIM(RetTitle("RA_ESTADO")) + ", "
					ENDIF

					IF EMPTY(SRA->RA_DEPTO)
						cSRAObrig += ALLTRIM(RetTitle("RA_DEPTO")) + ", "
					ENDIF

					cSRAObrig	:= Left(cSRAObrig , Len(cSRAObrig) - 2)
					
					IF !EMPTY(cSRAObrig)

						If ( !lGravaLog )
						 
							lGeraLog	:= .T.
							cSRAObrig := "Campos obrigatorios em branco - " + AllTrim(RetTitle("RA_MAT ")) + " - " + SRA->RA_MAT + " - " + AllTrim(RetTitle("RA_NOME ")) + ": " + SRA->RA_NOME + " -> " +cSRAObrig// + cEol			
							AADD(aLogTransp , cSRAObrig)
							lGravaLog	:= .T.						
						 
						EndIf				

					Else
					
						lGravaVT	:= .T.
					
						// Quebra por Centro de Custo
						nPosDepto	:= Ascan(aDeptoProc , SRA->RA_DEPTO )
						If (nPosDepto == 0)
						
							cDeptoAnt := SRA->RA_DEPTO
							AADD(aDeptoProc , cDeptoAnt )							
							lTtde   := .T.
							
						EndIf				

						SRN->(dbSeek( xFilial("SRN")+SR0->R0_CODIGO ))

						nTItemSeq++

						If (nPos3 := Ascan(aTotTTPE,{|x| x[1]==aInfo[10]}) ) > 0
							aTotTTPE[nPos3,2] += SR0->R0_VALCAL
						EndIf
						//Alimenta Registro TTIT
						aDiver := {}
						fBenTTIT(@aDiver)
						fDbfGrava(aInfo[10]+"06" ,aDiver ,"DIVER")
						aLsup9[DETALHES]++

						If (nPos3 := Ascan(aTotTTPE,{|x| x[1]==aInfo[10]}) ) > 0
							aTotTTPE[nPos3,5]++
						EndIf					
									
					EndIf

					dbSelectArea("SR0")
					SR0->(dbSkip())				

				EndDo
				
				If ( lGravaVT )
				
					dbSelectArea( "SRA" )

					// Grava Funcionarios
					aDiver := {}
					fBenTTFU(@aDiver)
					fDbfGrava(aInfo[10]+"05" ,aDiver ,"DIVER")
					aLsup9[DETALHES]++
					If (nPos3 := Ascan(aTotTTPE,{|x| x[1]==aInfo[10]}) ) > 0
						aTotTTPE[nPos3,4]++
					EndIf

					// Grava Departamentos
					If lTtde
						aDiver := {}
						fBenTTDE(@aDiver)
						fDbfGrava(aInfo[10]+"04" ,aDiver ,"DIVER")
						aLsup9[DETALHES]++
						If (nPos3 := Ascan(aTotTTPE,{|x| x[1]==aInfo[10]}) ) > 0
							aTotTTPE[nPos3,6]++
						EndIf

						lTtde := .F.

					EndIf

					// Grava Unidades de Entrega
					If lTtun
						aDiver := {}
						fBenTTUN(@aDiver)
						fDbfGrava(aInfo[10]+"03" ,aDiver ,"DIVER")
						aLsup9[DETALHES]++
						If (nPos3 := Ascan(aTotTTPE,{|x| x[1]==aInfo[10]}) ) > 0
							aTotTTPE[nPos3,3]++
						EndIf

						lTtun := .F.

					EndIf
					
				EndIf
			
			EndIf
		
		EndIf
		
		If lRestaurante .Or. lAlimentacao
			
			// Quebra por Centro de Custo
			If AllTrim(SRA->RA_CC) # AllTrim(cCcAnt) //.and. Sra->Ra_Filial # "03"
				cCcAnt := SRA->RA_CC
				lTtde   := .T.
			EndIf
			
			nTotVA    := 0
			nTotVR    := 0

			// Busca os Valores do Vale Alimentacao
			fBuscaVA(@nTotVA, @nTotVR)

			If nTotVA > 0
				// Vale Alimentacao Eletronico
				If lAlimentacao

					// Grava Header Arquivo Alimentacao - Unidade - Registro 2
					lTeveVA := .t. // AAJ25102005 OS 2726/05
					If lHdva

						aDiver := {}
						fBenHdVA(@aDiver)
						fDbfGrava("ZY07" ,aDiver ,"DIVER")
						aLsup9[HEADER]++

						aDiver := {}
						fBenUEVA(@aDiver)
						fDbfGrava("ZY"+count,aDiver ,"DIVER")
						aLsup9[HEADER]++
						lHdva:=.F.
						count:=strzero((val(count)+1),2)
					Endif
					// Grava Arquivo Refeicao - Funcionarios - Registro 3
					aDiver := {}
					fBenFUVA(@aDiver)
					fDbfGrava("ZY"+count,aDiver ,"DIVER")
					aLsup9[DETALHES]++
					aTotVa[1]++
				EndIf

			EndIf


			// Vale Refeicao
			If nTotVR > 0

				If lRestaurante
					// Grava Header Arquivo Refeicao - Unidade - Registro 2
					If lHdte
						aDiver := {}
						fBenHdTE(@aDiver)
						fDbfGrava("ZX"+count,aDiver ,"DIVER")
						aLsup9[HEADER]++
						lHdte:=.F.
						count:=strzero((val(count)+1),2)
					Endif
					// Grava Arquivo Refeicao - Funcionarios - Registro 3
					aDiver := {}
					fBenFUTR(@aDiver)
					fDbfGrava("ZX"+count,aDiver ,"DIVER")
					aLsup9[DETALHES]++

					// Totais do Vale Refeicao
					aTotVR[1]++

				EndIf

			Endif

		EndIf
		
		If ( lCombustivel )
		
			nSeqComb++		
			nValCred	:= 0 // xyz Valor do cr้dito
			nTotLin++
			nValTot+=100
		
			aDiver	:= {}
			fDetComb(@aDiver)
			fDbfGrava("01",aDiver ,"DIVER")
		
		EndIf

		lProcessou := .T.
	
	EndIf

	dbSelectArea("SRA")
	SRA->(dbSkip())

EndDo


If lProcessou .And. !lAbort
	// Grava Trailler Arquivo Alimentacao Eletronico -  Registro 9
	If lAlimentacao .and. lTeveVA
		aDiver := {}
		fBenTRVA(@aDiver)
		fDbfGrava("ZY"+count,aDiver ,"DIVER") //a
		aLsup9[TRAILLER]++
	EndIf

	// Grava Trailler Arquivo Refeicao -  Registro 9
	If lRestaurante
		aDiver := {}
		fBenTRTR(@aDiver)
		fDbfGrava("ZX"+count,aDiver ,"DIVER") //a
		aLsup9[TRAILLER]++
	EndIf

	// Calculo do Total de Servicos do Pedido por Estado de Entrega
	If lTransporte
		If Len(aTotTTPE) > 0
			For i := 1 To Len(aTotTTPE)
				If aTotTTPE[i,2] == 0 .Or. aTotTTPE[i,3] == 0
					Loop
				EndIf

				nTVlrServ := Round(aTotTTPE[i,2] + (Round(aTotTTPE[i,3] * nVlPonto,2)),2)   //Round(aTotTTPE[i,2] * (nPercKit/100),2) + Round(aTotTTPE[i,3] * nVlPonto,2)
				// Grava Header Pedido
				aDiver := {}
				fBenTTPE(@aDiver,i)
				fDbfGrava(aTotTTPE[i,1]+"02" ,aDiver ,"DIVER")
				aLsup9[DETALHES]++
				aLsup9[TRAILLER]++
			Next
			lValVT := .T.
		Endif
		aDiver := {}
		fBenFnArq(@aDiver)
		fDbfGrava("ZZZY",aDiver ,"DIVER")
	EndIf

	// Grava Trailler Arquivo Final
	//If lAlimentacao .or. lRestaurante .or. lTransporte

	    //count:=strzero((val(count)+1),2)

		//aDiver := {}
		//fBenFnArq(@aDiver)
		//fDbfGrava("ZZZY",aDiver ,"DIVER") //b
		//aLsup9[TRAILLER]++

	//EndIf
	
	If ( lCombustivel )
	
		aDiver := {}
		fTrailComb(@aDiver)
		fDbfGrava("03",aDiver ,"DIVER")
	
	Else

		aDiver := {}
		fBenLsup9(@aDiver)
		fDbfGrava("ZZZZ",aDiver ,"DIVER") //b
		aLsup9[TRAILLER]++
	
	EndIf

	fGravaTxt()

EndIf

// Fecha o Arquivo para os Ticket Restaurante, Transporte e Combustivel
If lAlimentacao .Or. lRestaurante .Or. lTransporte
	fClose(nDiver)
	// Fecha Arquivo Temporario de Transporte e Refeicao
	dbSelectArea( "TMB" )
	dbCloseArea()
EndIf
// Restaura Posicionamento do SRA
dbSelectArea( "SRA" )
dbSetOrder(1)
dbGoTop()

Close(oGeraTxt)

If ( lTransporte .AND. lGeraLog )

	nLogTransp	:= fCreate(cLogTransp)
	
	For nX := 1 TO Len(aLogTransp)
		
		cLinha	:= ""
		cLinha	:= aLogTransp[nX] + cEol
		fWrite(nLogTransp , cLinha)
	
	Next

	fClose(nLogTransp)
	Alert("Foram encontrados erros na gera็ใo do arquivo de Vale Transporte. Avalie o arquivo : " + cLogTransp)
	WINEXEC("NOTEPAD " + cLogTransp)

Else

	Alert("Arquivo Gerado: "+cArq)
	WINEXEC("NOTEPAD " + cArq)
	
EndIf
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFBUSCAVA  บAutor  ณ  JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBuscaVA(nTotVA, nTotVR)

local aOld := GETAREA()

nTotVA := Posicione("SR0",3,SRA->RA_FILIAL+SRA->RA_MAT+"2","R0_VALCAL")
nTotVR := Posicione("SR0",3,SRA->RA_FILIAL+SRA->RA_MAT+"1","R0_VALCAL")

RESTAREA( aOld )

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ  JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */
static Function fBenLsup5(xBenef)

Aadd( xBenef,{"LSUP5"} )                                 // 001 - 005 -> Tipo do Registro
Aadd( xBenef[Len(xBenef)],cUsuSistema)                   // 006 - 013 -> Nome do Usuario que gerou o arquivo
Aadd( xBenef[Len(xBenef)],Space(11) )                    // 014 - 024 -> Brancos
Aadd( xBenef[Len(xBenef)],fCvData(dDataBase,"AAAA") )    // 025 - 032 -> Data da Geracao
Aadd( xBenef[Len(xBenef)],Time())    				      // 033 - 040 -> Hora da Grava็ใo HH.MM.SS
Aadd( xBenef[Len(xBenef)],If(lTransporte,"LAYOUT-26/07/2013","LAYOUT-16/06/2014") )          // 041 - 057 -> Brancos
Aadd( xBenef[Len(xBenef)],Space(107) )                  // 058 - 165 -> Brancos

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ  JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */
static Function fBenLsup9(xBenef)

Aadd( xBenef,{"LSUP9"} )                                 // 001 - 005 -> Tipo do Registro
Aadd( xBenef[Len(xBenef)],StrZero(aLsup9[HEADER],8) )    // 006 - 013 -> Total Headerดs
Aadd( xBenef[Len(xBenef)],StrZero(aLsup9[TRAILLER],8) )  // 014 - 021 -> Total Traillerดs
Aadd( xBenef[Len(xBenef)],StrZero(aLsup9[DETALHES],8) )  // 022 - 029 -> Total Registros
Aadd( xBenef[Len(xBenef)],Space(277) )                   // 030 - 306 -> Brancos

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ  JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenHdVA(xBenef)
Local xDado
Local nX
Local lFound	:= .F.
private c_CodKit

xDado	:= AllTrim(aInfo[12])

For nX := 1 TO LEN(aResp)	
	If ( xDado == aResp[nX,15])
		lFound	:= .T.
		Exit
	EndIf
Next

If lFound
	nPos		:= nX
	c_CodKit	:= aResp[nPos,6]
EndIf

Aadd( xBenef,{"T"} )                                                 // 001 - 001 -> Fixo "T"
Aadd( xBenef[Len(xBenef)],"A" )                                      // 002 - 002 -> Fixo "A" Almentacao
Aadd( xBenef[Len(xBenef)],"02" )                                     // 003 - 004 -> Fixo "02"
Aadd( xBenef[Len(xBenef)],"0" )    				                  // 005 - 005 -> Registro "0"
Aadd( xBenef[Len(xBenef)],"A" )    				                  // 006 - 006 -> Produto "A" Alimentacao
Aadd( xBenef[Len(xBenef)],c_CodKit )				                  // 007 - 016 -> Codigo Cliente Ticket
Aadd( xBenef[Len(xBenef)],Left(aInfo[03]+Space(24),24) )      	    // 017 - 040 -> Nome da Empresa p/ Personalizacao
Aadd( xBenef[Len(xBenef)],Space(06) )			                    // 041 - 046 -> Espacos
Aadd( xBenef[Len(xBenef)],fCvData(dDataRef,"AAAA") )                // 047 - 054 -> Data do Pedido
Aadd( xBenef[Len(xBenef)],fCvData(dVaEntr,"AAAA") )                 // 055 - 062 -> Data de Liberacao do Pedido
Aadd( xBenef[Len(xBenef)],"C" )    				                 // 063 - 063 -> Tipo do Pedido Fixo "C"
Aadd( xBenef[Len(xBenef)],Space(16) )			                    // 064 - 079 -> Espacos
Aadd( xBenef[Len(xBenef)],StrZero(Month(dDataRef),2) )             // 080 - 081 -> Mes de Referencia
Aadd( xBenef[Len(xBenef)],Space(19) )			                    // 082 - 100 -> Espacos
Aadd( xBenef[Len(xBenef)],"04" )    				                // 101 - 102 -> Tipo do Layout Fixo "04"
Aadd( xBenef[Len(xBenef)],"33" )    				                // 103 - 104 -> Tipo do Cartao TAE="33"
Aadd( xBenef[Len(xBenef)],Space(48) )			                    // 105 - 152 -> Espacos
Aadd( xBenef[Len(xBenef)],"SUP   " ) 			                    // 153 - 158 -> Tipo do Cartao TAE="33"
Aadd( xBenef[Len(xBenef)],"#" )                                    // 159 - 164 -> Controle Sequencia
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ  JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenUEVA(xBenef)
local nPos
local c_Nome    := Space(20)
Local c_TipoLog := Space(4)
Local c_Lograd  := Space(30)
Local c_Numero  := Space(6)
Local c_Complem := Space(10)
Local c_Municip := Space(25)
Local c_Bairro  := Space(15)
Local c_CEP     := Space(5)
Local c_Estado  := Space(2)
Local nX		:= 0
Local lFound	:= .F.
Local xDado

xDado	:= AllTrim(aInfo[12])

For nX := 1 TO LEN(aResp)	
	If ( xDado == aResp[nX,15])
		lFound	:= .T.
		Exit
	EndIf
Next
nPos	:= nX

If (lFound)
	c_Nome    := aResp[nPos,2]
	c_TipoLog := aResp[nPos,7]
	c_Lograd  := aResp[nPos,8]
	c_Numero  := aResp[nPos,9]
    c_Complem := aResp[nPos,10]
    c_Municip := aResp[nPos,12]
    c_Bairro  := aResp[nPos,11]
    c_CEP     := aResp[nPos,14]
    c_Estado  := aResp[nPos,13]
EndIf

Aadd( xBenef,{"T"} )                                                  // 001 - 001 -> Fixo "T"
Aadd( xBenef[Len(xBenef)],"A" )                                      // 002 - 002 -> Fixo "A" Almentacao
Aadd( xBenef[Len(xBenef)],"02" )                                     // 003 - 004 -> Fixo "02"
Aadd( xBenef[Len(xBenef)],"2" )    				                      // 005 - 005 -> Registro "2"
Aadd( xBenef[Len(xBenef)],Left(aInfo[03],26) )                      // 006 - 031 -> Descricao da Unidade
Aadd( xBenef[Len(xBenef)],Left(c_TipoLog,4) )                        // 032 - 035 -> Tipo de Logradouro
Aadd( xBenef[Len(xBenef)],Left(c_Lograd,30))                         // 036 - 065 -> Endereco Entrega
Aadd( xBenef[Len(xBenef)],Left(c_Numero,6))                          // 066 - 071 -> Numero Entrega
Aadd( xBenef[Len(xBenef)],Left(c_Complem,10))                       // 072 - 081 -> Complemento Entrega
Aadd( xBenef[Len(xBenef)],Left(c_Municip,25))                       // 082 - 106 -> Cidade Entrega
Aadd( xBenef[Len(xBenef)],Left(c_Bairro,15) )                      // 107 - 121 -> Bairro Entrega
Aadd( xBenef[Len(xBenef)],Left(c_CEP,5) )                         // 122 - 126 -> Cep Entrega
Aadd( xBenef[Len(xBenef)],c_Estado )                                // 127 - 128 -> Estado Entrega
Aadd( xBenef[Len(xBenef)],c_Nome )                                 // 129 - 148 -> Responsavel Unidade
Aadd( xBenef[Len(xBenef)],Right(c_CEP,3) )                      // 149 - 151 -> Complememnto do Cep
Aadd( xBenef[Len(xBenef)],Space(07) )                                // 152 - 158 -> Brancos
Aadd( xBenef[Len(xBenef)],"#" )                                       // 159 - 164 -> Controle Sequencia

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ  JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenFUVA(xBenef)

Local cDescCC	:= ""
Local nTamCampo	:= 0

nTamCampo:= 26 - Len(AllTrim(CTT->CTT_CUSTO))

cDescCC	:= Left(CTT->CTT_DESC01 , nTamCampo)

If ( Len(AllTrim(CTT->CTT_CUSTO)) + Len(cDescCC) < 26 )

	cDescCC	:= PadR(cDescCC , nTamCampo)

EndIf

//Aadd( xBenef[Len(xBenef)],Left(CTT->CTT_DESC01,20) )               // 012 - 031 -> Nome do Depto
//Aadd( xBenef[Len(xBenef)],StrZero(Val(SRA->RA_MAT),12) )            // 032 - 043 -> Numero do funcionario na Ticket

Aadd( xBenef,{"T"} )                                                  // 001 - 001 -> Fixo "T"
Aadd( xBenef[Len(xBenef)],"A" )                                      // 002 - 002 -> Fixo "A" Almentacao
Aadd( xBenef[Len(xBenef)],"02" )                                     // 003 - 004 -> Fixo "02"
Aadd( xBenef[Len(xBenef)],"3" )    				                    // 005 - 005 -> Registro "3"
Aadd( xBenef[Len(xBenef)],CTT->CTT_CUSTO )                        // 006 - 011 -> Codigo do Depto
Aadd( xBenef[Len(xBenef)],cDescCC)               					// 012 - 031 -> Nome do Depto
Aadd( xBenef[Len(xBenef)],StrZero(Val(SRA->RA_CIC),12) )            // 032 - 043 -> Numero do funcionario na Ticket
Aadd( xBenef[Len(xBenef)],fCvData(SRA->RA_NASC,"DDMMAAAA") )            // 0440 - 051 -> Data de Nascimento
Aadd( xBenef[Len(xBenef)],Space(18) )                                // 052 - 069 -> Personalizacao By Cliente
Aadd( xBenef[Len(xBenef)],Left(aInfo[03]+Space(26),26) )   	     // 070 - 095 -> Nome da Unidade
Aadd( xBenef[Len(xBenef)],"00101" )                                   // 096 - 100 -> Fixo "00101"
Aadd( xBenef[Len(xBenef)],StrZero(Int((nTotVa)*100),9) )             // 101 - 109 -> Valor Total do VA
Aadd( xBenef[Len(xBenef)],"A" )                                        // 110 - 110 -> Fixo "A" Alimentacao
Aadd( xBenef[Len(xBenef)],"E" )                                        // 111 - 111 -> Fixo "E" Eletronico
Aadd( xBenef[Len(xBenef)],Left(SRA->RA_NOME,30) )                    // 112 - 141 -> Nome do Funcionario
Aadd( xBenef[Len(xBenef)],Space(17) )                                 // 142 - 158 -> Personalizacao By Cliente
Aadd( xBenef[Len(xBenef)],"#" )                                        // 159 - 164 -> Controle Sequencia
aTotVa[2] += Int((nTotVA)*100)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ  JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenTRVA(xBenef)
Aadd( xBenef,{"T"} )                                                  // 001 - 001 -> Fixo "T"
Aadd( xBenef[Len(xBenef)],"A" )                                      // 002 - 002 -> Fixo "A" Almentacao
Aadd( xBenef[Len(xBenef)],"02" )                                     // 003 - 004 -> Fixo "02"
Aadd( xBenef[Len(xBenef)],"9" )    				                      // 005 - 005 -> Registro "9"
Aadd( xBenef[Len(xBenef)],StrZero(aTotVa[1],8) )                    // 006 - 013 -> Total de Funcionarios do VA
Aadd( xBenef[Len(xBenef)],StrZero(aTotVa[2],14) )                   // 014 - 027 -> Valor Total do VA
Aadd( xBenef[Len(xBenef)],Space(131) )			                     // 028 - 158 -> Brancos
Aadd( xBenef[Len(xBenef)],"#" )                                      // 159 - 164 -> Controle Sequencia
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Header do Arquivo de Transporte.                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenHdTT(xBenef)

Aadd( xBenef,{"T   "} )                                  // 001 - 004 -> Tipo do Pacote
Aadd( xBenef[Len(xBenef)],"A" )                          // 005 - 005 -> Ordem do Kit
Aadd( xBenef[Len(xBenef)],fCvData(dDataBase,"AAAA") )    // 006 - 013 -> Data da Geracao
Aadd( xBenef[Len(xBenef)],"V4.0" )                       // 014 - 017 -> Ordem do Kit
Aadd( xBenef[Len(xBenef)],Space(60) )                    // 018 - 077 -> Brancos

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Registro Tipo "TTPE" de Transporte.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenTTPE(xBenef,i)
Aadd( xBenef,{"TTPE"} )                                                  // 001 - 004 -> Tipo do Produto
Aadd( xBenef[Len(xBenef)],Transform(aInfo[12],'@R 99.999.999/9999-99' )) // 005 - 022 -> Cnpj Principal
Aadd( xBenef[Len(xBenef)],"K."+Subs(Dtoc(dDataRef),1,6)+Subs(Dtoc(dDataRef),9,2) )                          // 023 - 032 -> Numero do Pedido
Aadd( xBenef[Len(xBenef)],StrZero(aTotTTPE[i,3],4) )                    // 033 - 036 -> Qde Unidades Pedido
Aadd( xBenef[Len(xBenef)],StrZero(aTotTTPE[i,6],4) )                    // 037 - 040 -> Qde Deptos Pedido
Aadd( xBenef[Len(xBenef)],StrZero(aTotTTPE[i,4],5) )                    // 041 - 045 -> Qde Funcionario Pedido
Aadd( xBenef[Len(xBenef)],StrZero(aTotTTPE[i,5],6) )                    // 046 - 051 -> Qde Itens Pedido
Aadd( xBenef[Len(xBenef)],Transform(nTVlrServ,'9999999999999.99') )      // 052 - 067 -> Valor Servicos Pedido
Aadd( xBenef[Len(xBenef)],Transform(aTotTTPE[i,2],'9999999999999.99') ) // 068 - 083 -> Valor Bilhetes Pedido
Aadd( xBenef[Len(xBenef)],fCvData(dDataBase,"AAAA") )                    // 084 - 091  -> Data de Geracao
Aadd( xBenef[Len(xBenef)]," " )                                          // 092 - 092 -> Espacos
Aadd( xBenef[Len(xBenef)],fCvData(dUtilDe,"AAAA") )                      // 093 - 100  -> Periodo Utilizacao De
Aadd( xBenef[Len(xBenef)],fCvData(dUtilAte,"AAAA") )                     // 101 - 108  -> Periodo Utilizacao Ate
Aadd( xBenef[Len(xBenef)],"000000000.00" )                              // 109 - 120 -> Preco de 01 Kit
Aadd( xBenef[Len(xBenef)],Transform(nVlPonto,'999999999.99') )           // 121 - 132 -> Preco por Ponto Entrega
Aadd( xBenef[Len(xBenef)],"N" )                                          // 133 - 133 -> Tipo do Pedido
Aadd( xBenef[Len(xBenef)],StrZero(aTotTTPE[i,3],4) )                   // 134 - 137 -> Qde Unidades Pagas
Aadd( xBenef[Len(xBenef)],"A" )                                          // 138 - 138 -> Ordem do Pedido TT
Aadd( xBenef[Len(xBenef)],"P" )                                          // 139 - 139 -> Tipo Rateio Entregas
Aadd( xBenef[Len(xBenef)],"%  " )                                        // 140 - 142 -> Moeda do Kit
Aadd( xBenef[Len(xBenef)],"R$ " )                                        // 143 - 145 -> Moeda da Entrega
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Registro Tipo "TTFU" de Transporte.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP7                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenTTUN(xBenef)
local nPos
local c_Fone  := Space(11)
local c_Ramal := Space(04)
local c_Nome    := Space(20)
Local c_TipoLog := Space(4)
Local c_Lograd  := Space(30)
Local c_Numero  := Space(6)
Local c_Complem := Space(10)
Local c_Municip := Space(25)
Local c_Bairro  := Space(15)
Local c_CEP     := Space(5)
Local c_Estado  := Space(2)

Local nX		:= 0
Local lFound	:= .F.
Local xDado

xDado	:= AllTrim(aInfo[12])

For nX := 1 TO LEN(aResp)	
	If ( xDado == aResp[nX,15])
		lFound	:= .T.
		Exit
	EndIf
Next

nPos	:= nX

If ( lFound )
	c_Nome    := aResp[nPos,2]
	c_Fone    := aResp[nPos,3]
	c_fone	  := StrTran(c_Fone , "-" , "")
	c_fone    := StrZero(Val(c_fone) , 11)
	c_Ramal   := aResp[nPos,4]
	c_TipoLog := aResp[nPos,7]
	c_Lograd  := aResp[nPos,8]
	c_Numero  := aResp[nPos,9]
    c_Complem := aResp[nPos,10]
    c_Municip := aResp[nPos,12]
    c_Bairro  := aResp[nPos,11]
    c_CEP     := aResp[nPos,14]
    c_Estado  := aResp[nPos,13]
EndIf

Aadd( xBenef,{"TTUN"} )                                                     // 001 - 004 -> Tipo do Produto
Aadd( xBenef[Len(xBenef)],Transform(aInfo[12],'@R 99.999.999/9999-99' ))  // 005 - 022 -> Cnpj Principal
Aadd( xBenef[Len(xBenef)],"K."+Subs(Dtoc(dDataRef),1,6)+Subs(Dtoc(dDataRef),9,2) )                // 023 - 032 -> Numero do Pedido
Aadd( xBenef[Len(xBenef)],StrZero(Val(Alltrim(aInfo[17]) ) , 6) )                           // 033 - 038 -> Codigo da Unidade
//Aadd( xBenef[Len(xBenef)],Alltrim(Subs(aInfo[17],3)) )                           // 033 - 038 -> Codigo da Unidade
Aadd( xBenef[Len(xBenef)],Padr(aInfo[03],26) )                            // 039 - 064 -> Descricao da Unidade
Aadd( xBenef[Len(xBenef)],Padr(c_TipoLog,4) )                             // 065 - 068 -> Tipo de Logradouro
Aadd( xBenef[Len(xBenef)],Padr(c_Lograd,30) )                             // 069 - 098 -> Logradouro
Aadd( xBenef[Len(xBenef)],StrZero(Val(c_Numero),6) )                             // 099 - 104 -> numero
Aadd( xBenef[Len(xBenef)],Padr(c_Complem,10) )                             // 105 - 114 -> Complemento
Aadd( xBenef[Len(xBenef)],Padr(c_Bairro,15) )                             // 115 - 129 -> Bairro
Aadd( xBenef[Len(xBenef)],Padr(c_Municip,25) )                             // 130 - 154 -> Municipio
Aadd( xBenef[Len(xBenef)],Subs(c_CEP,1,5)+"-"+Subs(c_CEP,6,3) )           // 155 - 163 -> CEP
Aadd( xBenef[Len(xBenef)],Padr(c_Estado,2) )                             // 164 - 165 -> Estado
Aadd( xBenef[Len(xBenef)],fCvData(dEntrMin,"AAAA") )                      // 166 - 173 -> Data Minima Entrega
Aadd( xBenef[Len(xBenef)],fCvData(dEntrMax,"AAAA") )                      // 174 - 181 -> Data Maxima Entrega
Aadd( xBenef[Len(xBenef)],c_Nome )                                        // 175 - 201 -> Responsavel Unidade
Aadd( xBenef[Len(xBenef)],c_Fone )                                        // 202 - 212 -> DDD + Telefone
Aadd( xBenef[Len(xBenef)],c_Ramal )                                       // 213 - 216 -> Ramal
Aadd( xBenef[Len(xBenef)],"N" )                                           // 217 - 217 -> Lista Assinatura?
Aadd( xBenef[Len(xBenef)],Space(40) )                                     // 218 - 257 -> Espacos
Aadd( xBenef[Len(xBenef)],"S" )                                           // 258 - 258 -> Separa por Depto?
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Registro Tipo "TTDE" de Transporte.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenTTDE(xBenef)

Local cDescDepto	:= ""
Local aAreaSQB		:= {}
Local cDepto		:= SRA->RA_DEPTO

aAreaSQB	:= SQB->(GetArea())

If SQB->(dbSeek ( xFilial("SQB" , cFilAnt) + cDepto ))
	cDescDepto := SQB->QB_DESCRIC
Endif

/*
cMinhaFil	:= PadR( '01' , Len(SRA->RA_FILIAL) )
If SQB->(dbSeek ( cMinhaFil + cDepto ))
	cDescDepto := SQB->QB_DESCRIC
Endif*/

Aadd( xBenef,{"TTDE"} )                                                    // 001 - 004 -> Tipo do Produto
Aadd( xBenef[Len(xBenef)],Transform(aInfo[12],'@R 99.999.999/9999-99' )) // 005 - 022 -> Cnpj Principal
Aadd( xBenef[Len(xBenef)],"K."+Subs(Dtoc(dDataRef),1,6)+Subs(Dtoc(dDataRef),9,2) )                         // 023 - 032 -> Numero do Pedido
Aadd( xBenef[Len(xBenef)], StrZero(Val(aInfo[17]) , 6 ) )                          // 033 - 038 -> Codigo da Unidade
Aadd( xBenef[Len(xBenef)],StrZero( Val(cDepto) , 6) )                           // 039 - 044 -> Codigo do Depto
//Aadd( xBenef[Len(xBenef)],StrZero( Val(SRA->RA_DEPTO) , 6) )                           // 039 - 044 -> Codigo do Depto
Aadd( xBenef[Len(xBenef)],PadR(AllTrim(cDescDepto ), 26) )                // 012 - 031 -> Nome do Depto
Aadd( xBenef[Len(xBenef)],Space(20) )                                    // 071 - 090 -> Espacos
Aadd( xBenef[Len(xBenef)],Transform(aInfo[12],'@R 99.999.999/9999-99' )) // 091 - 108 -> Cnpj Faturamento

RestArea(aAreaSQB)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Registro Tipo "TTFU" de Transporte.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenTTFU(xBenef)

Local cTpEnd
Local cLograd := ""
Local cDescCC	:= ""
Local nTamCampo	:= 0

fEndereco(SRA->RA_ENDEREC)

cTpEnd := Subs(Sra->Ra_Enderec,1,2)
fRetLogr(cTpEnd,@cLograd)

nTamCampo:= 26 - Len(AllTrim(CTT->CTT_CUSTO))

cDescCC	:= Left(CTT->CTT_DESC01 , nTamCampo)

Aadd( xBenef,{"TTFU"} )                                                     // 001 - 004 -> Tipo do Produto
Aadd( xBenef[Len(xBenef)],Transform(aInfo[12],'@R 99.999.999/9999-99' ))  // 005 - 022 -> Cnpj Principal
Aadd( xBenef[Len(xBenef)],"K."+Subs(Dtoc(dDataRef),1,6)+Subs(Dtoc(dDataRef),9,2) )                      // 023 - 032 -> Numero do Pedido
Aadd( xBenef[Len(xBenef)],StrZero(Val(Alltrim(aInfo[17]) ) , 6))                       // 033 - 038 -> Codigo da Unidade
Aadd( xBenef[Len(xBenef)],StrZero( Val(SRA->RA_DEPTO) , 6))                   // 039 - 044 -> Codigo do Depto
Aadd( xBenef[Len(xBenef)],StrZero(Val(SRA->RA_CIC),12) )            // 045 - 052 -> Codigo do Funcionario
Aadd( xBenef[Len(xBenef)],Padr(SRA->RA_NOME,30) )                     // 057 - 086 -> Nome do Funcionario
Aadd( xBenef[Len(xBenef)],SUBS(STRTRAN(SRA->RA_RG,".",""),1,10))      // 087 - 096 -> Nro RG do funcionแrio
Aadd( xBenef[Len(xBenef)],SRA->RA_CIC )                            // 097 - 107 -> Nro CPF do funcionแrio
Aadd( xBenef[Len(xBenef)],"    " )                                // 108 - 111 -> Brancos
Aadd( xBenef[Len(xBenef)],SUBS(DTOS(SRA->RA_NASC),1,4) + SUBS(DTOS(SRA->RA_NASC),5,2)+ SUBS(DTOS(SRA->RA_NASC),7,2) )// 112 - 119 -> Data Nascimento aaaammdd
Aadd( xBenef[Len(xBenef)],SRA->RA_RGUF )                            // 120 - 121 -> Estado de Emissao do RG
Aadd( xBenef[Len(xBenef)],SRA->RA_SEXO )                              // 122 - 122 -> Sexo do funcionแrio
Aadd( xBenef[Len(xBenef)],PadR(AllTrim(SRA->RA_MAE),30) )                    // 123 - 152 -> Nome da Mใe do funcionแrio
Aadd( xBenef[Len(xBenef)],PadR(AllTrim(SRA->RA_LOGRTP) , 5) )                           // 153 - 157 -> Tipo do Logradouro
Aadd( xBenef[Len(xBenef)],Padr(ALLTRIM(SRA->RA_LOGRDSC) , 40 ))                          // 158 - 197 -> Nome do logradouro
Aadd( xBenef[Len(xBenef)],Padr(AllTrim(SRA->RA_LOGRNUM),6) )                       // 198 - 203 -> Nro. do Logradouro
Aadd( xBenef[Len(xBenef)],SUBS(SRA->RA_COMPLEM,1,15) )                // 204 - 218 -> Complemento do Endereco
Aadd( xBenef[Len(xBenef)],PADR(ALLTRIM(SRA->RA_MUNICIP) , 40))                // 219 - 258 -> Municipio do Endereco
Aadd( xBenef[Len(xBenef)],PADR(ALLTRIM(SRA->RA_BAIRRO) , 30))                  // 259 - 288 -> Municipio do Endereco
Aadd( xBenef[Len(xBenef)],PadR(AllTrim(SRA->RA_CEP) , 8))                                // 289 - 296 -> Cep do Endereco
Aadd( xBenef[Len(xBenef)],SRA->RA_ESTADO ) 							 // 297 - 298 -> Estado do Endereco
Aadd( xBenef[Len(xBenef)],"000201" )                                // 299 - 304 -> Modal

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Registro Tipo "TTIT" de Transporte.                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenTTIT(xBenef)

Local cBilhete	:= ""
Local cCodOper	:= ""
Local cDescCTT	:= ""
Local cAliasRFP	:= ""
Local cChaveRFP	:= ""
Local aAreaRFP	:= {}

cAliasRFP	:= "RFP"
aAreaRFP	:= (cAliasRFP)->(GetArea())

If SR0->R0_Valcal <= 0
	Return
Endif

cChaveRFP	:= xFilial("RFP" , cFilAnt ) + SR0->R0_TPVALE + SR0->R0_CODIGO

If ( (cAliasRFP)->(dbSeek(cChaveRFP)) )
	
	cCodOper	:= PadR( (cAliasRFP)->(RFP_TKCDOP) , 6 )
	cBilhete	:= PadR( (cAliasRFP)->(RFP_TKCDBL) , 12 )
	cDescCTT	:= PadR( (cAliasRFP)->(RFP_TKTPBL) , 4 )

EndIf

Aadd( xBenef,{"TTIT"} )                                                   // 001 - 004 -> Tipo do Produto
Aadd( xBenef[Len(xBenef)],Transform(aInfo[12],'@R 99.999.999/9999-99' ))  // 005 - 022 -> Cnpj Principal
Aadd( xBenef[Len(xBenef)],"K."+Subs(Dtoc(dDataRef),1,6)+Subs(Dtoc(dDataRef),9,2) )   // 023 - 032 -> Numero do Pedido
Aadd( xBenef[Len(xBenef)],StrZero(Val(aInfo[17]) , 6 ) )                           // 033 - 038 -> Codigo da Unidade
Aadd( xBenef[Len(xBenef)],StrZero( Val(SRA->RA_DEPTO) , 6) )                           // 039 - 044 -> Codigo do Depto
Aadd( xBenef[Len(xBenef)],StrZero(Val(SRA->RA_CIC),12) )                // 045 - 056 -> Codigo do Funcionario
Aadd( xBenef[Len(xBenef)],StrZero(nTItemSeq,3) )                          // 057 - 059 -> Seq Itens Funcionario
Aadd( xBenef[Len(xBenef)],StrZero(SR0->R0_QDIAINF , 8 ) )                    // 060 - 067 -> Qde Bilhetes/Viagens
Aadd( xBenef[Len(xBenef)],StrZero(SRN->RN_VUNIATU , 9 , 2 ) )       // 068 - 076 -> Valor Tarifa do Item
Aadd( xBenef[Len(xBenef)],cCodOper )                               // 077 - 082 -> Codigo Operadora Transp
Aadd( xBenef[Len(xBenef)],cBilhete )                               // 083 - 094 -> Codigo Bilhete Operadora

Aadd( xBenef[Len(xBenef)],cDescCTT )                                // 095 - 098 -> Tipo Bilhete
Aadd( xBenef[Len(xBenef)],"N" )                                           // 099 - 099 -> Flag Tipo Pedido

RestArea(aAreaRFP)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Header do Arquivo de Refeicao. Registro "0"        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenHdTR(xBenef)
Local xDado
Local nX
Local lFound
private c_CodKit 

xDado	:= AllTrim(aInfo[12])

For nX := 1 TO LEN(aResp)	
	If ( xDado == aResp[nX,15])
		lFound	:= .T.
		Exit
	EndIf
Next

If lFound
	nPos		:= nX
	c_CodKit	:= aResp[nPos,6]
EndIf

Aadd( xBenef,{"T"} )                                                 // 001 - 001 -> Fixo "T"
Aadd( xBenef[Len(xBenef)],"R" )                                      // 002 - 002 -> Fixo "A" Almentacao
Aadd( xBenef[Len(xBenef)],"02" )                                     // 003 - 004 -> Fixo "02"
Aadd( xBenef[Len(xBenef)],"0" )    				                  // 005 - 005 -> Registro "0"
Aadd( xBenef[Len(xBenef)],"R" )    				                  // 006 - 006 -> Produto "A" Alimentacao
Aadd( xBenef[Len(xBenef)],c_CodKit )				                  // 007 - 016 -> Codigo Cliente Ticket
Aadd( xBenef[Len(xBenef)],Left(aInfo[03]+Space(24),24) )      	    // 017 - 040 -> Nome da Empresa p/ Personalizacao
Aadd( xBenef[Len(xBenef)],Space(06) )			                    // 041 - 046 -> Espacos
Aadd( xBenef[Len(xBenef)],fCvData(dDataRef,"AAAA") )                // 047 - 054 -> Data do Pedido
Aadd( xBenef[Len(xBenef)],fCvData(dVaEntr,"AAAA") )                 // 055 - 062 -> Data de Liberacao do Pedido
Aadd( xBenef[Len(xBenef)],"C" )    				                 // 063 - 063 -> Tipo do Pedido Fixo "C"
Aadd( xBenef[Len(xBenef)],Space(16) )			                    // 064 - 079 -> Espacos
Aadd( xBenef[Len(xBenef)],StrZero(Month(dDataRef),2) )             // 080 - 081 -> Mes de Referencia
Aadd( xBenef[Len(xBenef)],Space(19) )			                    // 082 - 100 -> Espacos
Aadd( xBenef[Len(xBenef)],"04" )    				                // 101 - 102 -> Tipo do Layout Fixo "04"
Aadd( xBenef[Len(xBenef)],"34" )    				                // 103 - 104 -> Tipo do Cartao TAE="33"
Aadd( xBenef[Len(xBenef)],Space(48) )			                    // 105 - 152 -> Espacos
Aadd( xBenef[Len(xBenef)],"SUP   " ) 			                    // 153 - 158 -> Tipo do Cartao TAE="33"
Aadd( xBenef[Len(xBenef)],"#" )                                    // 159 - 164 -> Controle Sequencia

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Registro Tipo "2" de Refeicao.                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenHdTE(xBenef)
local nPos
local c_Nome    := Space(20)
Local c_TipoLog := Space(4)
Local c_Lograd  := Space(30)
Local c_Numero  := Space(6)
Local c_Complem := Space(10)
Local c_Municip := Space(25)
Local c_Bairro  := Space(15)
Local c_CEP     := Space(5)
Local c_Estado  := Space(2)

Local nX		:= 0
Local lFound	:= .F.
Local xDado

xDado	:= AllTrim(aInfo[12])

For nX := 1 TO LEN(aResp)	
	If ( xDado == aResp[nX,15])
		lFound	:= .T.
		Exit
	EndIf
Next

nPos	:= nX

If ( lFound )
	c_Nome    := aResp[nPos,2]
	c_TipoLog := aResp[nPos,7]
	c_Lograd  := aResp[nPos,8]
	c_Numero  := aResp[nPos,9]
    c_Complem := aResp[nPos,10]
    c_Municip := aResp[nPos,12]
    c_Bairro  := aResp[nPos,11]
    c_CEP     := aResp[nPos,14]
    c_Estado  := aResp[nPos,13]
EndIf

Aadd( xBenef,{"T"} )                                                  // 001 - 001 -> Fixo "T"
Aadd( xBenef[Len(xBenef)],"R" )                                      // 002 - 002 -> Fixo "R" Restaurante
Aadd( xBenef[Len(xBenef)],"02" )                                     // 003 - 004 -> Fixo "02"
Aadd( xBenef[Len(xBenef)],"2" )    				                      // 005 - 005 -> Registro "2"
Aadd( xBenef[Len(xBenef)],Left(aInfo[03],26) )                      // 006 - 031 -> Descricao da Unidade
Aadd( xBenef[Len(xBenef)],Left(c_TipoLog,4) )                        // 032 - 035 -> Tipo de Logradouro
Aadd( xBenef[Len(xBenef)],Left(c_Lograd,30))                         // 036 - 065 -> Endereco Entrega
Aadd( xBenef[Len(xBenef)],Left(c_Numero,6))                          // 066 - 071 -> Numero Entrega
Aadd( xBenef[Len(xBenef)],Left(c_Complem,10))                       // 072 - 081 -> Complemento Entrega
Aadd( xBenef[Len(xBenef)],Left(c_Municip,25))                       // 082 - 106 -> Cidade Entrega
Aadd( xBenef[Len(xBenef)],Left(c_Bairro,15) )                      // 107 - 121 -> Bairro Entrega
Aadd( xBenef[Len(xBenef)],Left(c_CEP,5) )                         // 122 - 126 -> Cep Entrega
Aadd( xBenef[Len(xBenef)],c_Estado )                                // 127 - 128 -> Estado Entrega
Aadd( xBenef[Len(xBenef)],c_Nome )                                 // 129 - 148 -> Responsavel Unidade
Aadd( xBenef[Len(xBenef)],Right(c_CEP,3) )                      // 149 - 151 -> Complememnto do Cep
Aadd( xBenef[Len(xBenef)],Space(07) )                                // 152 - 158 -> Brancos
Aadd( xBenef[Len(xBenef)],"#" )                                       // 159 - 164 -> Controle Sequencia

lTr01 := .T.
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Registro Tipo "3" de Refeicao.                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenFUTR(xBenef)

Local cDescCC	:= ""
Local nTamCampo	:= 0

nTamCampo:= 26 - Len(AllTrim(CTT->CTT_CUSTO))

cDescCC	:= Left(CTT->CTT_DESC01 , nTamCampo)

If ( Len(AllTrim(CTT->CTT_CUSTO)) + Len(cDescCC) < 26 )

	cDescCC	:= PadR(cDescCC , nTamCampo)

EndIf

Aadd( xBenef,{"T"} )                                                  // 001 - 001 -> Fixo "T"
Aadd( xBenef[Len(xBenef)],"R" )                                      // 002 - 002 -> Fixo "A" Almentacao
Aadd( xBenef[Len(xBenef)],"02" )                                     // 003 - 004 -> Fixo "02"
Aadd( xBenef[Len(xBenef)],"3" )    				                    // 005 - 005 -> Registro "3"
Aadd( xBenef[Len(xBenef)],CTT->CTT_CUSTO )                        // 006 - 011 -> Codigo do Depto
Aadd( xBenef[Len(xBenef)],cDescCC )               					// 012 - 031 -> Nome do Depto
Aadd( xBenef[Len(xBenef)],StrZero(Val(SRA->RA_CIC),12) )            // 032 - 043 -> Numero do funcionario na Ticket
Aadd( xBenef[Len(xBenef)],fCvData(SRA->RA_NASC,"DDMMAAAA") )            // 0440 - 051 -> Data de Nascimento
Aadd( xBenef[Len(xBenef)],Space(18) )                                // 052 - 069 -> Personalizacao By Cliente
Aadd( xBenef[Len(xBenef)],Left(aInfo[03]+Space(26),26) )   	     // 070 - 095 -> Nome da Unidade
Aadd( xBenef[Len(xBenef)],"00101" )                                   // 096 - 100 -> Fixo "00101"
Aadd( xBenef[Len(xBenef)],StrZero(Int((nTotVR)*100),9) )             // 101 - 109 -> Valor Total do VA
Aadd( xBenef[Len(xBenef)],"R" )                                        // 110 - 110 -> Fixo "A" Alimentacao
Aadd( xBenef[Len(xBenef)],"E" )                                        // 111 - 111 -> Fixo "E" Eletronico
Aadd( xBenef[Len(xBenef)],Left(SRA->RA_NOME,30) )                    // 112 - 141 -> Nome do Funcionario
Aadd( xBenef[Len(xBenef)],Space(17) )                                 // 142 - 158 -> Personalizacao By Cliente
Aadd( xBenef[Len(xBenef)],"#" )                                        // 159 - 164 -> Controle Sequencia
aTotVR[2] += Int((nTotVR)*100)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Registro Tipo "9" de Refeicao.                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenTRTR(xBenef)

Aadd( xBenef,{"T"} )                                                  // 001 - 001 -> Fixo "T"
Aadd( xBenef[Len(xBenef)],"R" )                                      // 002 - 002 -> Fixo "A" Almentacao
Aadd( xBenef[Len(xBenef)],"02" )                                     // 003 - 004 -> Fixo "02"
Aadd( xBenef[Len(xBenef)],"9" )    				                      // 005 - 005 -> Registro "9"
Aadd( xBenef[Len(xBenef)],StrZero(aTotVR[1],8) )                    // 006 - 013 -> Total de Funcionarios do VA
Aadd( xBenef[Len(xBenef)],StrZero(aTotVR[2],14) )                   // 014 - 027 -> Valor Total do VA
Aadd( xBenef[Len(xBenef)],Space(131) )			                     // 028 - 158 -> Brancos
Aadd( xBenef[Len(xBenef)],"#" )                                      // 159 - 164 -> Controle Sequencia

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Registro Final do Arquivo de Transporte e Refeicao.บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP7                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenFnArq(xBenef)
//User function fBenFnArq(xBenef)
Aadd( xBenef,{"9999"} )                                          // 001 - 004 -> Fixo "9999"
Aadd( xBenef[Len(xBenef)],strzero(lin,8))                        // 005 - 012 -> Total Linhas
Aadd( xBenef[Len(xBenef)],Space(152) )                           // 013 - 164 -> Brancos
Return




// AQUI COMEวA A CUSTOMIZAวรO PARA ENVIO DE ARQUIVO PARA PEDIDO DE
// TICKET RESTAURANTE ELETRONICO.




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Header do Arquivo de Refeicao Eletronica           บฑฑ
ฑฑบ          ณ Registro "0" - Registro Header                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP7                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */
//static Function fBenHdTRE(xBenef)

User Function fBenHdTRE(xBenef)
private c_CodKit

If (nPos := Ascan(aResp,{|x| x[1]==Subs(aInfo[17],4,3)}) ) > 0
	c_CodKit := aResp[nPos,6]
EndIf

Aadd( xBenef,{"T" } )                                         	// 001 - 001 -> Fixo em "T"
Aadd( xBenef[Len(xBenef)],"R")                                	// 002 - 002 -> "R" - Restaurante
Aadd( xBenef[Len(xBenef)],"02")                               	// 003 - 004 -> Fixo em "02"
Aadd( xBenef[Len(xBenef)],"0")                        			// 005 - 005 -> Tipo Registro
Aadd( xBenef[Len(xBenef)],"R")	                           		// 006 - 006 -> "R" - Restaurante
Aadd( xBenef[Len(xBenef)],c_CodKit)				            // 007 - 016 -> Codigo Cliente Ticket
Aadd( xBenef[Len(xBenef)],Left(aInfo[3],24) )                  // 017 - 040 -> Nome da Empresa
Aadd( xBenef[Len(xBenef)],Space(06) )                          // 041 - 046 -> Brancos
Aadd( xBenef[Len(xBenef)],fCvData(dDataBase,"AAAA") )          // 047 - 054 -> Data do Pedido
Aadd( xBenef[Len(xBenef)],fCvData(dVrEntr,"AAAA") )            // 055 - 062 -> Data da Libera็ใo do Benefํcio
Aadd( xBenef[Len(xBenef)],"C" )                                // 063 - 063 -> Tipo do Pedido
Aadd( xBenef[Len(xBenef)],Space(16) )                          // 064 - 079 -> Brancos
Aadd( xBenef[Len(xBenef)],StrZero(Month(dDataRef),2) )         // 080 - 081 -> Mes Utilizacao
Aadd( xBenef[Len(xBenef)],Space(19) )                          // 082 - 100 -> Brancos
Aadd( xBenef[Len(xBenef)],"04" )                               // 101 - 102 -> Tipo de Lay-Out
Aadd( xBenef[Len(xBenef)],"34" )                               // 103 - 104 -> Tipo do Cartใo
Aadd( xBenef[Len(xBenef)],Space(48) )                          // 105 - 152 -> Reservado
Aadd( xBenef[Len(xBenef)],"SUP   " )                           // 153 - 158 -> Origem
Aadd( xBenef[Len(xBenef)],"@")				                    // 159 - 164 -> Seqü๊ncia

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Registro Tipo "2" de Refeicao Eletr๔nica           บฑฑ
ฑฑบ          ณ Registro de Unidade de Entrega.                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */
//static Function fBenTREUE(xBenef)
user Function fBenTREUE(xBenef)
local nPos
local c_tipo 	:= Space(04)
local c_Logr 	:= Space(30)
local n_num  	:= 0
local c_Compl	:= Space(10)
local c_Nome  	:= Space(20)
local c_Fone  	:= Space(11)
local c_Ramal 	:= Space(04)

If (nPos 		:= Ascan(aResp,{|x| x[1]==Subs(aInfo[17],4,3) }) ) > 0
	c_Nome  	:= aResp[nPos,2]
	c_Fone  	:= aResp[nPos,3]
	c_Ramal 	:= aResp[nPos,4]
	c_tipo 		:= aResp[nPos,07]
	c_Logr 		:= aResp[nPos,08]
	n_num  		:= aResp[nPos,09]
	c_Compl		:= aResp[nPos,10]
EndIf

Aadd( xBenef,{"T"} )                                                    // 001 - 001 -> Tipo do Produto
Aadd( xBenef[Len(xBenef)],"R" )                                         // 002 - 002 -> Tipo Registro
Aadd( xBenef[Len(xBenef)],"02" )                                        // 003 - 004 -> Tipo Registro
Aadd( xBenef[Len(xBenef)],"2" )                                         // 005 - 005 -> Tipo Registro
Aadd( xBenef[Len(xBenef)],Left(aInfo[03],26) )                          // 006- 031 -> Descricao da Unidade
Aadd( xBenef[Len(xBenef)],Left(c_tipo,04)) 							 // 032 - 035 -> Endereco Entrega
Aadd( xBenef[Len(xBenef)],Left(c_logr,30)) 							 // 036 - 065 -> Logradouro
Aadd( xBenef[Len(xBenef)],Left(n_num,6)) 								 // 066 - 071 -> N๚mero
Aadd( xBenef[Len(xBenef)],Left(c_Compl,10)) 							 // 072 - 081 -> Complemento
Aadd( xBenef[Len(xBenef)],Left(aInfo[09]+Space(05),25))                 // 082 - 106 -> Cidade Entrega
Aadd( xBenef[Len(xBenef)],Left(aInfo[14],15) )                          // 107 - 121 -> Bairro Entrega
Aadd( xBenef[Len(xBenef)],Left(aInfo[11],5) )                           // 122 - 126 -> Cep Entrega
Aadd( xBenef[Len(xBenef)],aInfo[10] )                                   // 127 - 128 -> Estado Entrega
Aadd( xBenef[Len(xBenef)],c_Nome )                                      // 129 - 148 -> Responsavel Unidade
Aadd( xBenef[Len(xBenef)],Right(aInfo[11],3) )                          // 149 - 151 -> Compl Cep Entrega
Aadd( xBenef[Len(xBenef)],Space(07) )                                   // 152 - 158 -> Espacos
Aadd( xBenef[Len(xBenef)],"@" )                                         // 159 - 164 -> Controle Sequencia

lTr01 := .T.
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Registro Tipo "3" de Refeicao.                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */
//static Function fBenFUTRE(xBenef)
User Function fBenFUTRE(xBenef)
Aadd( xBenef,{"T"} )                             		   			// 001 - 001 -> Tipo do Produto
Aadd( xBenef[Len(xBenef)],"R" )                            		// 002 - 002 -> Tipo Registro
Aadd( xBenef[Len(xBenef)],"02" )                          	 		// 003 - 004 -> Tipo Registro
Aadd( xBenef[Len(xBenef)],"3" )                            		// 005 - 005 -> Tipo Registro
Aadd( xBenef[Len(xBenef)],CTT->CTT_CUSTO )                            // 006 - 011 -> Codigo do Depto
Aadd( xBenef[Len(xBenef)],Left(CTT->CTT_DESC01,20) )                // 012 - 031 -> Nome do Depto
Aadd( xBenef[Len(xBenef)],"0")					                // 032 - 032 -> Codigo do Funcionario
Aadd( xBenef[Len(xBenef)],SRA->(RA_CIC))	                        // 033 - 043 -> Codigo do Funcionario
Aadd( xBenef[Len(xBenef)],fCvData(SRA->RA_NASC,"DDMMAAAA") )      	// 044 - 051 -> Data de Nascimento do Funcionแrio
Aadd( xBenef[Len(xBenef)],Space(18) )                          	// 052 - 069 -> Reservado
Aadd( xBenef[Len(xBenef)],Left(aInfo[03],26) )                 	// 070 - 095 -> Descricao da Unidade
Aadd( xBenef[Len(xBenef)],"00101" )			                	// 096 - 100 -> Fixo
Aadd( xBenef[Len(xBenef)],StrZero(Int(nTTVlTick*100),9) )      	// 101 - 109 -> Valor Total do Ticket
Aadd( xBenef[Len(xBenef)],"R" )                                	// 110 - 110 -> Refeicao
Aadd( xBenef[Len(xBenef)],"E" )                                	// 111 - 111 -> Carne
Aadd( xBenef[Len(xBenef)],Left(SRA->RA_NOME,30) )              	// 112 - 141 -> Nome do Funcionario
Aadd( xBenef[Len(xBenef)],Space(17) )                          	// 142 - 158 -> Reservado
Aadd( xBenef[Len(xBenef)],"@" )                                	// 159 - 164 -> Controle Sequencia

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Registro Tipo "9" de Refeicao Eletr๔nica.          บฑฑ
ฑฑบ          ณ Registro Trailler                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */
//static Function fBenTRTRE(xBenef)
User Function fBenTRTRE(xBenef)
Aadd( xBenef,{"TR02"} )                                             // 001 - 004 -> Tipo do Produto
Aadd( xBenef[Len(xBenef)],"9" )                                     // 005 - 005 -> Tipo Registro
Aadd( xBenef[Len(xBenef)],StrZero(nTotFunc,08) )                    // 006 - 013 -> Total Registro
Aadd( xBenef[Len(xBenef)],StrZero( nVlTotTic,14 ) )           // 014 - 027 -> Total Pedidos
Aadd( xBenef[Len(xBenef)],Space(131) )                              // 028 - 158 -> Brancos
Aadd( xBenef[Len(xBenef)],"@" )                                     // 159 - 164 -> Controle Sequencia
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Conversao da Data Conforme Parametro.                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */
Static Function fCvData(dDt,xTp)
local cRet := ""
If xTp == "AAAA"
	cRet := Str(Year(dDt),4) + StrZero(Month(dDt),2) + StrZero(Day(dDt),2)
ElseIf xTp == "AA"
	cRet := Right(Str(Year(dDt),4),2) + StrZero(Month(dDt),2) + StrZero(Day(dDt),2)
ElseIf xTp == "DDMMAAAA"
	cRet := StrZero(Day(dDt),2) + StrZero(Month(dDt),2) + Str(Year(dDt),4)
EndIf
Return( cRet )


/*
=============================================================================
Programa   fGravaTXT      Autor JORGE SATO        บ Data ณ  28/02/2017
=============================================================================
Desc.      Grava o Arquivo Texto.
=============================================================================
Uso        P12
============================================================================= */

static Function fGravaTxt

local aOld := GETAREA()
local cLin
local i, o
local nSeqDiver := 0
local nSeqAlim  := 0
local nSeqTR    := 0

dbSelectArea( "TMB" )
dbGoTop()
ProcRegua(RecCount())
Do While !Eof()
	IncProc("Aguarde... Gerando Arquivo Texto...")

	// Filtra Lancamentos Validos do Registro TR01
	If !lTr01
		If Left(TMB->TMB_TXT,4) == "TR01"
			dbSkip()
			Loop
		EndIf
	EndIf

	cLin := Alltrim(TMB->TMB_TXT)
	If Right(cLin,1) == "*"
		cLin := Left(cLin,Len(cLin)-1)
	EndIf
	If Left(TMB->TMB_TXT,4) == "TR01"
		nSeqDiver++
		cLin += StrZero(nSeqDiver,6)
	EndIf
	If Left(TMB->TMB_TXT,4) == "TA02"
		If Right(cLin,1) == "#"
			cLin := Left(cLin,Len(cLin)-1)
		EndIf
		nSeqAlim++
		cLin += StrZero(nSeqAlim,6)
	EndIf

	If Left(TMB->TMB_TXT,4) == "TR02"

		If Right(cLin,1) == "#"
			cLin := Left(cLin,Len(cLin)-1)
		EndIf

		nSeqTR++

		cLin += StrZero(nSeqTR,6)
	EndIf

	cLin += cEol

	If fWrite(nDiver,cLin,Len(cLin)) != Len(cLin)
		If !MsgAlert("Ocorreu um erro na gravacao do arquivo. Continua?","Atencao!")
			Exit
		Endif
	Endif

	dbSelectArea("TMB")
	TMB->(dbSkip())
EndDo

RESTAREA( aOld )

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFDBFGRAVA บAutor  ณ  JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */
static Function fDbfGrava(xTipo,xDiver)
local aOld := GETAREA()
local cTxt := ""
local i, o
Local xDado

For i := 1 To Len(xDiver)
	For o := 1 To Len(xDiver[i])
		cLInha	:= ""		
		If xDiver[i,o] = NIL
			xDado	:= ""
		Else
			xDado	:= xDiver[i,o]
		eNDiF
		cTxt += xDado
	Next
Next

If !Empty(cTxt)

	dbSelectArea( "TMB" )
	RecLock( "TMB" ,.T. )
	TMB->TMB_ORDEM  := xTipo
	TMB->TMB_TXT    := cTxt
	lin:=lin+1
	MsUnlock()
EndIf

RESTAREA( aOld )

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFCRIADBF  บAutor  ณ  JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fCriaDbf()
local aCampos := {}

Aadd(aCampos,{ "TMB_ORDEM" ,"C" ,004 ,0 })
Aadd(aCampos,{ "TMB_TXT"   ,"C" ,350 ,0 })

dbCreate("TMBDIVER" ,aCampos)
dbUseArea(.T.,,"TMBDIVER" ,"TMB" ,.F.)
If !Used()
	Return( .F. )
EndIf
IndRegua("TMB" ,"TMBDIVER", "TMB_ORDEM",,, "Criando Indices..." )

Return( .T. )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFINFO     บAutor  ณ  JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

Static Function fInfo(xInf,xFil)
local lRet    := .F.
local nSM0Rec := SM0->(Recno())

If SM0->(dbSeek( Left(cNumEmp,2) + xFil ))
	xInf := {}
	Aadd( xInf, SM0->M0_FILIAL   )    // 01 - Descricao da Filial
	Aadd( xInf, SM0->M0_NOME     )    // 02 - Descricao da Empresa
	Aadd( xInf, SM0->M0_NOMECOM  )    // 03 - Nome Completo da Empresa
	Aadd( xInf, SM0->M0_ENDCOB   )    // 04 - Endereco de Cobranca
	Aadd( xInf, SM0->M0_CIDCOB   )    // 05 - Cidade de Cobranca
	Aadd( xInf, SM0->M0_ESTCOB   )    // 06 - Estado de Cobranca
	Aadd( xInf, SM0->M0_CEPCOB   )    // 07 - Cep de Cobranca
	Aadd( xInf, SM0->M0_ENDENT   )    // 08 - Endereco de Entrega
	Aadd( xInf, SM0->M0_CIDENT   )    // 09 - Cidade de Entrega
	Aadd( xInf, SM0->M0_ESTENT   )    // 10 - Estado de Entrega
	Aadd( xInf, SM0->M0_CEPENT   )    // 11 - Cep de Entrega
	Aadd( xInf, SM0->M0_CGC )         // 12 - Cnpj -> Sempre da Matriz
	Aadd( xInf, SM0->M0_BAIRCOB  )    // 13 - Bairro de Cobranca
	Aadd( xInf, SM0->M0_BAIRENT  )    // 14 - Bairro de Entrega
	Aadd( xInf, SM0->M0_COMPCOB  )    // 15 - Complemento de Cobranca
	Aadd( xInf, SM0->M0_COMPENT  )    // 16 - Complemento de Entrega
	Aadd( xInf, SM0->M0_CODFIL   )    // 17 - Codigo da Filial
	lRet := .T.
EndIf

SM0->(dbGoTo( nSM0Rec ))

Return( lRet )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFULTDIA   บAutor  ณ  JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

Static Function fUDia(dDt)
local cRet

If StrZero(Month(dDt),2) $ "01*03*05*07*08*10*12"
	cRet := "31"
ElseIf StrZero(Month(dDt),2) $ "04*06*09*11"
	cRet := "30"
Else
	cRet := If( !Empty(Ctod("29"+Right(Dtoc(dDt),6))),"29","28" )
EndIf

Return( cRet )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFMTRESP   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fMtResp(xResp)

local aOld := GETAREA()
local lRet := .F.
local nPos := 0
Local cTipoEnd
Local cLogR
Local cCodContr	:= ""

dbSelectArea("RGC")
dbGotop()

If lRestaurante
	cCodContr	:= "1390570032"
ElseIf lAlimentacao
	cCodContr	:= "1390570014"
EndIf

While !Eof()

	cTipoEnd := Subs(Rgc->Rgc_Ender,1,2)
	fRetLogr(cTipoEnd,@cLogR)

	If (nPos := Ascan(aTotTTPE,{|x| x[1] == RGC->RGC_ESTADO }) ) == 0
		// Totalizador TTPE
		Aadd(aTotTTPE,{RGC->RGC_ESTADO, ;  // 1 - Estado
		0,                          ;      // 2 - Total Valor Bilhetes
		0,                          ;      // 3 - Total Unidades Pedido
		0,                          ;      // 4 - Total Funcionarios Pedido
		0,                          ;      // 5 - Total Item Pedido
		0                           })     // 6 - Total Departamentos Pedido
	EndIf

	Aadd(xResp,{Alltrim(RGC->RGC_KEYLOC),              ;   //FILIAL
	Left(RGC->RGC_NMRESP,20),                          ;   //CONTATO
	Alltrim(RGC->RGC_CDAREA)+Alltrim(RGC->RGC_FONE),   ;   //TELEFONE
	"0000",                                             ;   //RAMAL
	"0000000000",                                        ;   //COD KIT BENEFICIO	
	cCodContr,                                        ;   //COD VALE ALIMENTAวรO
	cLogR,                                              ;   //TIPO LOGRADOURO
	Padr(Rgc->Rgc_Ender,30),                           ;   //LOGRADOURO
	StrZero(Rgc->Rgc_Numero,6),                        ;   //NUMERO
	Padr(Rgc->Rgc_Comple,10) ,                          ;   //COMPLEMENTO
	Padr(Rgc->Rgc_Bairro,15) ,                          ;   //BAIRRO
	Padr(Rgc->Rgc_Munic,25)  ,                          ;   //MUNICIPIO
	Padr(Rgc->Rgc_Estado,2)  ,                          ;   //ESTADO
	Padr(Rgc->Rgc_CodPos,8)  ,							; //CEP
	ALLTRIM(RGC->RGC_CPFCGC)											}) //CGC

	dbSelectArea("RGC")
	RGC->(dbSkip())
	lRet := .T.

EndDo

RESTAREA( aOld )

Return( lRet )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FRETLOGR บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ MP8                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

Static Function fRetLogr(cTipo,cLogr)

cTipo := Upper(cTipo)

If cTipo == "R " .or. cTipo == "RU"
   cLogR := "R   "
ElseIf cTipo == "A " .or. cTipo == "AV"
   cLOgR := "AV  "
ElseIf cTipo == "L " .or. cTipo == "LA"
   cLogR := "LG  "
ElseIf cTipo == "E " .or. cTipo == "ES"
   cLogR := "ES  "
ElseIf cTipo == "P " .or. cTipo == "PR"
   cLogR := "PC  "
ElseIf cTipo == "A " .or. cTipo == "AL"
   cLogR := "AL  "
ElseIf cTipo == "R " .or. cTipo == "RO"
   cLogR := "ROD "
ElseIf cTipo == "T " .or. cTipo == "TR"
   cLogR := "TV  "
Endif


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FPERG    บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

Static Function fPerg()

Local aRegs := {}

aAdd(aRegs,{cPerg,'01','Data de Referencia     ?','','','mv_ch1','D',08,0,0,'G','NaoVazio   ','mv_par01','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'02','Gera V.Alimenta็ใo     ?','','','mv_ch2','N',01,0,0,'C','           ','mv_par02','Sim            ','','','','','Nใo          ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'03','Gera Vale Refei็ใo     ?','','','mv_ch3','N',01,0,0,'C','           ','mv_par03','Sim            ','','','','','Nใo          ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'04','Gera Vale Transporte   ?','','','mv_ch4','N',01,0,0,'C','           ','mv_par04','Sim            ','','','','','Nใo          ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'05','Gera Vale Combustivel  ?','','','mv_ch5','N',01,0,0,'C','           ','mv_par05','Sim            ','','','','','Nใo          ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'06','Filial De              ?','','','mv_ch6','C',08,0,0,'G','           ','mv_par06','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SM0',''})
aAdd(aRegs,{cPerg,'07','Filial Ate             ?','','','mv_ch7','C',08,0,0,'G','NaoVazio   ','mv_par07','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SM0',''})
aAdd(aRegs,{cPerg,'08','Matricula De           ?','','','mv_ch8','C',06,0,0,'G','           ','mv_par08','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SRA',''})
aAdd(aRegs,{cPerg,'09','Matricula Ate          ?','','','mv_ch9','C',06,0,0,'G','NaoVazio   ','mv_par09','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SRA',''})
aAdd(aRegs,{cPerg,'10','Centro de Custo De     ?','','','mv_chA','C',20,0,0,'G','           ','mv_par10','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SI3',''})
aAdd(aRegs,{cPerg,'11','Centro de Custo Ate    ?','','','mv_chB','C',20,0,0,'G','NaoVazio   ','mv_par11','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SI3',''})
aAdd(aRegs,{cPerg,'12','Situacoes a Imprimir   ?','','','mv_chC','C',05,0,0,'G','fSituacao  ','mv_par12','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'13','Categorias a Imprimir  ?','','','mv_chD','C',12,0,0,'G','fCategoria ','mv_par13','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'14','Local de Geracao       ?','','','mv_chE','C',30,0,0,'G','NaoVazio   ','mv_par14','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'15','Valor Ponto de Entrega ?','','','mv_chF','N',12,2,0,'G','NaoVazio   ','mv_par15','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'16','VT - Utilizacao De     ?','','','mv_chG','D',08,0,0,'G','NaoVazio   ','mv_par16','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'17','VT - Utilizacao Ate    ?','','','mv_chH','D',08,0,0,'G','NaoVazio   ','mv_par17','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'18','VT - Dt Entrega Minima ?','','','mv_chI','D',08,0,0,'G','NaoVazio   ','mv_par18','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'19','VT - Dt Entrega Maxima ?','','','mv_chJ','D',08,0,0,'G','NaoVazio   ','mv_par19','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'20','VR - Data Entrega      ?','','','mv_chK','D',08,0,0,'G','NaoVazio   ','mv_par20','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'21','VA - Data Entrega      ?','','','mv_chL','D',08,0,0,'G','NaoVazio   ','mv_par21','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})
aAdd(aRegs,{cPerg,'22','Usuario do Sistema     ?','','','mv_chM','C',08,0,0,'G','NaoVazio   ','mv_par22','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ',''})

ValidPerg(aRegs,cPerg)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_FCLOSEDB บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

User Function _fCloseDb(_cAlias)

//Tenta fechar o alias indicado

local _cAliasAtu:=Upper(alias())

if u__fIsOpen(_cAlias)
   dbselectarea(_cAlias)
   DbClosearea()
endif

if _cAliasAtu<>upper(_cAlias).and.!empty(_cAliasAtu)
   Dbselectarea(_cAliasAtu)
endif

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ_FCLOSEDB บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

User Function _fIsOpen(_cAlias)

//Retorna logico, se o alias esta ou nao aberto
local _cAliasAtu:=Upper(alias()),_nVez:=1,_lAberto

_lAberto:=(!empty(_cAlias).and.select(_cAlias)>0)

if !empty(_cAliasAtu)
   dbselectarea(_cAliasAtu)
endif

return _lAberto


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ fEnderecoบ Autor ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Divide uma string de endere็o e n๚mero em duas, uma de en  บฑฑ
ฑฑบ          ณ dere็o e outra de n๚mero                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
static function fEndereco(cEnd)

cEndereco := cEnd
nUM     := AT("1",cEndereco)
nDOIS   := AT("2",cEndereco)
nTRES   := AT("3",cEndereco)
nQUATRO := AT("4",cEndereco)
nCINCO  := AT("5",cEndereco)
nSEIS   := AT("6",cEndereco)
nSETE   := AT("7",cEndereco)
nOITO   := AT("8",cEndereco)
nNOVE   := AT("9",cEndereco)
nZERO   := AT("0",cEndereco)

IF nUm == 0
	nUm := 100
ENDIF
IF nDois == 0
	nDois := 100
ENDIF
IF nTres == 0
	nTres := 100
ENDIF
IF nQuatro == 0
	nQuatro := 100
ENDIF
IF nCinco == 0
	nCinco := 100
ENDIF
IF nSeis == 0
	nSeis := 100
ENDIF
IF nSete == 0
	nSete := 100
ENDIF
IF nOito == 0
	nOito := 100
ENDIF
IF nNove == 0
	nNove := 100
ENDIF
IF nZero == 0
	nZero := 100
ENDIF



nQuebra := min(nUm,nDois)
nQuebra := min(nQuebra,nTres)
nQuebra := min(nQuebra,nQuatro)
nQuebra := min(nQuebra,nCinco)
nQuebra := min(nQuebra,nSeis)
nQuebra := min(nQuebra,nSete)
nQuebra := min(nQuebra,nOito)
nQuebra := min(nQuebra,nNove)
nQuebra := min(nQuebra,nZero)

cNumero := subs(cEndereco,nQuebra)
cEndereco := LEFT(cEndereco,nQuebra-1)

nQuebra := at(" ",cNumero)
cNumero := LEFT(cNumero,nQuebra-1)
if empty(cNumero)
	cNumero := "SN"
endif

nQuebra := at(",",cEndereco)
IF NQUEBRA>0
	cEndereco := LEFT(cEndereco,nQuebra-1)
ENDIF

return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fBenComb(xBenef)
Local cCnpj		:= aInfo[12]
Local cCodBase	:= "" // xyz Pre Cadastro
Local cDataHora	:= dToS(Date()) + StrTran(Time() , ":" , "")
Local cVerLayOut:= "0000001.00"
Local cCpfGestor:= StrZero(0 , 11) // Pre Cadastro
Local cIdArq	:= "TKTCAR00002"

Aadd( xBenef,{"00"} )                                 // 001 - 002 -> Fixo "00"
Aadd( xBenef[Len(xBenef)],cCnpj)							// 003 - 016 -> CNPJ
Aadd( xBenef[Len(xBenef)],PadL(AllTrim(cCodBase) , 12))		// 017 - 028 -> Codigo da base
Aadd( xBenef[Len(xBenef)],cDataHora )						// 029 - 042 -> Data/Hora minuto
Aadd( xBenef[Len(xBenef)],cVerLayOut)						// 043 - 052 -> Versao do LayOut
Aadd( xBenef[Len(xBenef)],cCpfGestor)						// 053 - 063 -> CPF Gestor Ticket
Aadd( xBenef[Len(xBenef)],cIdArq )							// 064 - 074 -> Brancos

Return

/*? Alfanum้rico: Alinhados เ esquerda com brancos เ direita.
? Num้rico: Alinhado เ direita e quando necessแrio preenchido com zeros เ
esquerda, sem separador de decimal.
? Data: Formatado com ano, m๊s, dia, hora, minuto e segundo.
(AAAAMMDDHH24MISS)*/


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Registro Tipo "3" de Refeicao.                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fDetComb(xBenef) //fDetcom = DetalheCombustivel

Local cTipoReg	:= "01"
Local cSeq		:= StrZero(nSeqComb , 5)
Local cTipoId	:= "01" 
Local cValId	:= SRA->RA_CIC
Local cValCred	:= StrZero(nValCred , 9)
Local cIdOpe	:= "02"
Local cCodRet	:= Space(12)
Local cDescRet	:= Space(100)
Local cFiller	:= Space(500)

Aadd( xBenef , {cTipoReg} )							// 001 - 002 -> Fixo "01" 
Aadd( xBenef[Len(xBenef)],cSeq )								// 003 - 007 -> Sequencial
Aadd( xBenef[Len(xBenef)],cTipoId )								// 008 - 009 -> // 01-CPF | 03-IDENTIFICAวรO | 04-PLACA | 05-CHASSI | 07-CARTรO
Aadd( xBenef[Len(xBenef)],cValId )								// 010 - 027 -> Valor da Identifica็ใo
Aadd( xBenef[Len(xBenef)],cValCred )							// 028 - 036 -> Valor do Cr้dito
Aadd( xBenef[Len(xBenef)],cIdOpe )								// 037 - 038 -> Fixo "02" (Distribui็ใo de Cr้dito
Aadd( xBenef[Len(xBenef)],cCodRet )								// 039 - 050 -> Espa็os em branco - constarแ apenas no arquivo retorno
Aadd( xBenef[Len(xBenef)],cDescRet )							// 051 - 150 -> Espa็os em branco - constarแ apenas no arquivo retorno
Aadd( xBenef[Len(xBenef)],cFiller )								// 151 - 650 -> Espa็os em branco - constarแ apenas no arquivo retorno

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณKTBENEF   บAutor  ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Monta o Registro Tipo "3" de Refeicao.                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ P12                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

static Function fTrailComb(xBenef) //fTrailComb = TrailerCombustivel

Local cTipoReg	:= "99"
Local cTotLin	:= StrZero(nTotLin , 12)
Local cValTot	:= StrZero(nValTot , 9)

Aadd( xBenef ,{cTipoReg} )						// 001 - 002 -> Fixo "99" 
Aadd( xBenef[Len(xBenef)],cTotLin )							// 003 - 014 -> Total de Linhas
Aadd( xBenef[Len(xBenef)],cValTot )							// 015 - 023 -> Total Geral distribuido

Return