#Include "PROTHEUS.ch" 
//#Include "GPER130.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GPER130  ³ Autor ³ R.H. - Mauro          ³ Data ³ 26.04.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Recibo de Ferias                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GPER130(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS  ³  Motivo da Alteracao                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Carlos E. O.³11/11/13³M12RH01³ Retirada da funcao AjustaSx1 para       ³±±
±±³            ³        ³196704 ³ inclusao do fonte na P12.               ³±±
±±³Sidney O.   ³27/08/14³TPZPWZ ³ Criada validacao para as datas do grupo ³±±
±±³            ³        ³       ³ de perguntas GPR130.                    ³±±
±±³Flavio Corr ³16/06/15³TSPUL3 ³ Correção busca de ferias na SRF para    ³±±
±±³            ³        ³       ³ aviso ferias calculadas                 ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function xGPER130()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local cString  := "SRA"                // ALIAS DO ARQUIVO PRINCIPAL (BASE)
Local aOrd     := {" Matricula "," C.Custo + Matric","C.Custo + Nome","Nome"} 	//" Matricula "###" C.Custo + Matric" ### "C.Custo + Nome" ### "Nome"
//Local nTotregs,nMult,nPosAnt,nPosAtu,nPosCnt,cSav20,cSav7 // REGUA
Local cDesc1   := "Aviso / Recibo de Ferias "	//"Aviso / Recibo de F‚rias "
Local cDesc2   := "Sera impresso de acordo com os parametros solicitados pelo"	//"Ser  impresso de acordo com os parametros solicitados pelo"
Local cDesc3   := "usuario."	//"usu rio."
Local cSavAlias,nSavRec,nSavOrdem    
Local lPnm070TamPE := ExistBlock( "PNM070TAM" )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Basicas)                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aReturn := {"Zebrado", 1,"Administrador", 1, 2, 1, "",1 }	// "Zebrado"###"Administrador"
Private nomeprog:="GPER130"
Private anLinha := { },nLastKey := 0
Private cPerg   :="GPR130"
Private aStruSRF	:= {}   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Private(Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cPd13o := Space(3)
Private aCodFol := {}     // Matriz com Codigo da folha
   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis UtinLizadas na funcao IMPR                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private Titulo  := "RECIBO E AVISO DE FERIAS"		//"RECIBO E AVISO DE FERIAS"
Private AT_PRG  := "GPER130"
Private wCabec0 := 3
Private wCabec1 := ""
Private wCabec2 := ""
Private wCabec3 := ""
Private CONTFL  := 1
Private nLi     := 0
Private nTamanho:= "P"

cSavAlias := Alias()
nSavRec   := RecNo()
nSavOrdem := IndexOrd()   

If lPnm070TamPE
 	IF ( ValType( uRetBlock := ExecBlock("PNM070TAM",.F.,.F.))  == "C" )
   	   nTamanho := uRetBlock
	Endif
EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte("GPR130",.F.)
   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:="GPER130"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,@Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,nTamanho)
   
If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif
   
RptStatus({|lEnd| GP130Imp(@lEnd,wnRel,cString)},Titulo)

dbselectarea(cSavAlias)
dbsetorder(nSavOrdem)
dbgoto(nSavrec)
    
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ GP130imp ³ Autor ³ R.H. - Mauro          ³ Data ³ 26.04.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Recibo de Ferias                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ GPER130(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function GP130IMP(lEnd,WnRel,cString)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis Locais (Programa)                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//Arrays
Local aPeriodos  := {}

//Logicas
Local lTemCpoProg

//Numericas
Local nImprVias
Local nCnt
Local i

//Strings
Local cRot 			:= ""
Local cTipoRot 		:= ""

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Variaveis de Acesso do Usuario                               ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
Local cAcessaSRA	:= &( " { || " + ChkRH( "GPER130" , "SRA" , "2" ) + " } " )

Private nSol13,nSolAb,nRecib,nRecAb,nRec13,cFilDe,cFilAte
Private cMatDe,cMatAte,cCcDe,cCcAte,cNomDe,cNomAte,cDtSt13
Private nFaltas	:= Val_Salmin:=0
Private Salario	:= SalHora := SalDia := SalMes := nSalPg := 0.00
Private lAchou		:= .F.
Private aInfo		:= {}
Private aTabFer	:= {}    			// Tabela para calculo dos dias de ferias
Private aCodBenef	:= {}
Private nAviso,lImpAv,dDtfDe,dDtfAte,nImprDem

Private DaAuxI		:= Ctod("//")
Private DaAuxF		:= Ctod("//")
Private cAboAnt	:= If(GetMv("MV_ABOPEC")=="S","1","2") //-- Abono antes ferias
Private cAboPec	:= ""

Private aVerbsAbo		:= {}
Private aVerbs13Abo	:= {}
Private aPeriodo	:= {}
Private NDBANCO

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis Utilizadas para Parametros                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nOrdem  := aReturn[8]
nSol13  := mv_par01     //  SoLic. 1o. Parc. 13o.
nSolAb  := mv_par02     //  SoLic. Abono Pecun.
nAviso  := mv_par03     //  Aviso de Ferias
nRecib  := mv_par04     //  Recibo de Ferias
nRecAb  := mv_par05     //  Recibo de Abono
nRec13  := mv_par06     //  Recibo 1¦ parc. 13o.
nDtRec  := mv_par07     //  Imprime Periodo de Ferias
dDtfDe  := mv_par08     //  Periodo de Ferias De
dDtfAte := mv_par09     //  Periodo de Ferias Ate
cFilDe  := mv_par10     //  FiLial De
cFilAte := mv_par11     //  FiLial Ate
cMatDe  := mv_par12     //  Matricula De
cMatAte := mv_par13     //  Matricula Ate
cCcDe   := mv_par14     //  Centro De Custo De
cCcAte  := mv_par15     //  Centro De Custo Ate
cNomDe  := mv_par16     //  Nome De
cNomAte := mv_par17     //  Nome Ate
dDtSt13 := mv_par18     //  Data SoLic. 13o.
nVias   := mv_par19     //  No. de Vias
dDtPgDe := mv_par20	    //  Data de Pagamento De
dDtPgAte:= mv_par21	    //  Data de Pagamento Ate

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica a base instalada, se for Brasil utiliza o param,	³
//³ caso contrario, fixa o param como 2 (Nao Imprime Demitidos)	³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nImprDem:= Iif( cPaisLoc == "BRA", mv_par22, 2 )
nDAbnPec:= IiF (cPaisLoc == "BRA", mv_par23, 15)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica a existencia dos campos de programacao ferias no SRF³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lTemCpoProg := fTCpoProg()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pocisiona No Primeiro Registro Selecionado                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SRA")
   
If nOrdem == 1
	dbSetOrder(1)
ElseIf nOrdem == 2
	dbSetOrder(2)
ElseIf nOrdem == 3
	dbSetOrder(8)
ElseIf nOrdem == 4
	dbSetOrder(3)
Endif
   
If nOrdem == 1
	dbSeek( cFilDe + cMatDe,.T. )
	cInicio  := "SRA->RA_FILIAL + SRA->RA_MAT"
	cFim     := cFilAte + cMatAte
ElseIf nOrdem == 2
	dbSeek( cFilDe + cCcDe + cMatDe,.T. )
	cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
	cFim     := cFilAte + cCcAte + cMatAte
ElseIf nOrdem = 3
	dbSeek(cFilDe + cCcDe + cNomDe,.T.)
	cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_NOME"
	cFim     := cFilAte + cCcAte + cNomAte
ElseIf nOrdem = 4
	dbSeek(cFilDe + cNomDe + cMatDe,.T.)
	cInicio  := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
	cFim     := cFilAte + cNomAte + cMatAte
Endif

//--Setar impressora                     
@ 0,0 psay Avalimp(080) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Carrega Regua de Processamento                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SetRegua(RecCount())
   
While !Eof() .And. &cInicio <= cFim

    nLi:= 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Movimenta Regua de Processamento                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IncRegua()

	If lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	Endif	 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Parametrizacao do Intervalo de Impressao            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If (SRA->RA_MAT < cMatDe) .Or. (SRA->RA_MAT > cMatAte) .Or. ;
		(SRA->RA_CC  < cCcDe ) .Or. (SRA->RA_CC  > cCcAte) .Or.;
		(SRA->RA_NOME < cNomDe) .Or. (SRA->RA_NOME > cNomAte) 
		SRA->(dbSkip(1))
		Loop
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Consiste Situacao do Funcionario                             ³
	//³ Inclusao do tratamento para Imprime Demitidos S/N no Brasil. ³
	//³ Se nao for Brasil considera-se o param como 2 (Nao imprime)	 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
   	If SRA->RA_SITFOLH $ "D" .AND. nImprDem <> 1	// 1 - Imprime Demitido = Sim
		SRA->(dbSkip(1))
		Loop
	Endif
		                                                                    
	/*
	ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	³Consiste Filiais e Acessos                                             ³
	ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
    If !( SRA->RA_FILIAL $ fValidFil() ) .Or. !Eval( cAcessaSRA )
		dbSelectArea("SRA")
      	dbSkip()
       	Loop
	EndIF

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//| Carrega tabela para apuracao dos dias de ferias - aTabFer    |
	//| 1-Meses Periodo    2-Nro Periodos   3-Dias do Mes    4-Fator |
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	

	DbSelectArea("SRF")
	DbSetOrder(2)
	
	cDeSRF := SRA->RA_FILIAL + SRA->RA_MAT + fGetCodFol("0072")
	cAteSRF := SRA->RA_FILIAL + cMatAte + fGetCodFol("0072")
	
	If DbSeek(cDeSRF)
		While SRF->(!Eof() .and. RF_FILIAL + RF_MAT + RF_PD == cDeSRF )
			If SRF->RF_STATUS $ " 1" .and. ( SRF->RF_DFERVAT > 0 .or. SRF->RF_DFERAAT > 0  .or. SRF->RF_DVENPEN > 0 ) //Carrega o primeiro periodo aquisitivo com dias vencidos ou a vencer
				If SRF->RF_DATAINI >= dDtfDe
					dDtIniProg := SRF->RF_DATAINI
					nDiasProg  := SRF->RF_DFEPRO1
					nDAbProg   := SRF->RF_DABPRO1
					nPercProg  := SRF->RF_PERC13S					
				ElseIf SRF->RF_DATINI2 >= dDtfDe
					dDtIniProg := SRF->RF_DATINI2
					nDiasProg  := SRF->RF_DFEPRO2
					nDAbProg   := SRF->RF_DABPRO2
					nPercProg  := SRF->RF_PERC13S
				ElseIf SRF->RF_DATINI3 >= dDtfDe
					dDtIniProg := SRF->RF_DATINI3
					nDiasProg  := SRF->RF_DFEPRO3
					nDAbProg   := SRF->RF_DABPRO3
					nPercProg  := SRF->RF_PERC13S
				EndIf
				Exit
			EndIf
			SRF->(DbSkip())
		EndDo
	EndIf

	cProcesso 	:= SRA->RA_PROCES
	cTipoRot	:= "3"
	cRot 		:= fGetCalcRot(cTipoRot)
	cPeriodo	:= ""
	cSemana		:= ""

	If !Empty(dDtIniProg) //Se existir programcao de ferias, posiciona no periodo
		fRetPerComp(SubStr(Dtos(dDtIniProg),5,2), SubStr(Dtos(dDtIniProg),1,4),, cProcesso,cRot,@aPeriodo )
		If Empty(aPeriodo) .or. !Empty(aPeriodo[1,11])
			dDtIniProg := CtoD("")
		Else
			cPeriodo := aPeriodo[1,1]
			cSemana  := aPeriodo[1,2]
		EndIf
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Carrega o periodo atual de calculo (aberto)                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	//fGetLastPer( @cPeriodo,@cSemana , cProcesso, cRot , .T., .F., @cAnoMes )
	
	aPeriodo := {}
	
	//Carrega todos os dados do periodo
	//fCarPeriodo( cPeriodo , cRot , @aPeriodo, @lUltSemana, @nPosSem)	  
	
	fTab_Fer(@aTabFer)

	lAchou := .F.      
	lImpAv := If(nAviso==1 .or. nSolAb==1 .or. nSol13==1,.T.,.F.)   // Imprime Aviso e/ou So.Abono e/ou Sol.1.Parc.13. s/Calcular

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Procura No Arquivo de Ferias o Periodo a Ser Listado         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea("SRH" )
   	If dbSeek( SRA->RA_FILIAL + SRA->RA_MAT )
   		aPeriodos := {}
		While !Eof() .And. SRA->RA_FILIAL + SRA->RA_MAT == SRH->RH_FILIAL + SRH->RH_MAT
			If ( !(cPaisLoc $ "ANG") .And. (SRH->RH_DATAINI >= dDtfDe .And. SRH->RH_DATAINI <= dDtfAte) .And.;
			   (SRH->RH_DTRECIB >= dDtPgDe .And. SRH->RH_DTRECIB <= dDtPgAte) ) .OR. ;
			   ( (cPaisLoc $ "ANG") .And. (SRH->RH_DTRECIB >= dDtPgDe .And. SRH->RH_DTRECIB <= dDtPgAte) )
				AAdd(aPeriodos, Recno() )
			EndIf
			dbSkip()
		Enddo

		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Imprime Aviso de Ferias Caso nao tenha calculado             ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(aPeriodos) == 0
			dbSelectArea( "SRA" )
			If lImpAv
			   FImprAvi(lTemCpoProg)
			Endif		
			dbSelectArea( "SRA" )
			dbSkip()
			Loop
		Endif
		
		For nCnt := 1 To Len(aPeriodos)
			dbSelectArea( "SRH" )
			dbGoTo(aPeriodos[nCnt])

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Carrega Matriz Com Dados da Empresa                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			fInfo(@aInfo,SRA->RA_FILIAL)
         
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Carrega Variaveis Codigos da Folha                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If !FP_CODFOL(@aCodFol,SRA->RA_FILIAL)
				Return
			Endif
         
			DaAuxI := SRH->RH_DATAINI
			DaAuxF := SRH->RH_DATAFIM

			If nRec13 == 1
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Monta a Variavel na Lista Para Nao Aparecer Recibo de Ferias ³
				//³ e Sim No Recibo De Abono e 13o.                              ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				cPd13o := aCodFol[22,1]
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Busca os codigos de pensao definidos no cadastro beneficiario³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				fBusCadBenef(@aCodBenef, "131", {aCodfol[172,1]})
			Endif

			If nRecAb == 1
			
				//Verbas encontradas no GPEXIDC.PRX com 'abono' na descricao
				//			
				aAdd(aVerbsAbo, aCodFol[74,1])
				aAdd(aVerbsAbo, aCodFol[205,1])
				aAdd(aVerbsAbo, aCodFol[617,1])
				aAdd(aVerbsAbo, aCodFol[622,1])												
				aAdd(aVerbsAbo, aCodFol[623,1])
				
				For i := 632 To 635
					aAdd(aVerbsAbo, aCodFol[i,1])
				Next				
																				
				//Verbas encontradas no GPEXIDC1.PRX com 'abono' na descricao
				//				
				For i := 1312 To 1327
					aAdd(aVerbsAbo, aCodFol[i,1])
				Next

				aAdd(aVerbsAbo, aCodFol[1330,1])				
				aAdd(aVerbsAbo, aCodFol[1331,1])								
								
				aAdd(aVerbs13Abo, aCodFol[79,1])
				aAdd(aVerbs13Abo, aCodFol[206,1])				
								
			Endif			
						
	       lAchou := .T.   
			For nImprVias := 1 to nVias
				 ExecBlock("xIMPFER",.F.,.F.)
			Next nImprVias
			lImpAv := .F.
	    Next nCnt
    EndIf
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime Aviso de Ferias Caso nao tenha calculado             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
	If lImpAv
	   FImprAvi(lTemCpoProg)
	Endif

	dbSelectArea("SRA")
	dbSkip()
Enddo
   
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Termino do relatorio                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SRA")
Set Filter to 
dbsetorder(1)
   
Set Device To Screen
If aReturn[5] == 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif
MS_FLUSH()

*-----------------------------
Static Function FImprAvi(lTemCpoProg)
*-----------------------------
Local dDtIniProg,nDiasAbono,nDiasFePro,nDiasDedFer
Local nImprVias
Local cQry		:= ""
Local cData		:= dtos(dDtfDe)
Local cData1	:= dTos(dDtfAte)
Local nX		:= 1

If nAviso==1 .or. nSolAb==1 .or. nSol13==1 // Imprimi Aviso e/ou Sol.Abono e/ou Sol1.Parc.13. sem calcular

	aStruSRF  := If(Empty(aStruSRF),SRF->(dbStruct()),aStruSRF)	
	
	cQry := GetNextAlias()
	BEGINSQL ALIAS cQry
			SELECT *
			FROM %table:SRF% SRF
			WHERE SRF.%notDel% 
			AND RF_FILIAL= %exp:SRA->RA_FILIAL%
			AND RF_MAT=%exp:SRA->RA_MAT%
			AND RF_STATUS=%exp:'1'%
			AND ( (RF_DATAINI BETWEEN %exp:cData% AND %exp:cData1%) OR (RF_DATINI2 BETWEEN %exp:cData% AND %exp:cData1%)  OR (RF_DATINI3 BETWEEN %exp:cData% AND %exp:cData1%))
			ORDER BY RF_DATABAS 
	ENDSQL
	For nX := 1 To Len(aStruSRF)
		If ( aStruSRF[nX][2] <> "C" )
			TcSetField(cQry,aStruSRF[nX][1],aStruSRF[nX][2],aStruSRF[nX][3],aStruSRF[nX][4])
		EndIf
	Next nX
	
	//-- Verifica se no Arquivo SRF Existe Periodo de Ferias
	If !(cQry)->(Eof())
		dDtIniProg := CTOD("")
		nDiasFePro := 0
		nDiasAbono := 0
		If (cQry)->RF_DATAINI >= dDtfDe .And. (cQry)->RF_DATAINI <= dDtfAte
			dDtIniProg := (cQry)->RF_DATAINI                    
			nDiasFePro := If(lTemCpoProg, (cQry)->RF_DFEPRO1, 0)
			nDiasAbono := If(lTemCpoProg, (cQry)->RF_DABPRO1, 0)
		ElseIf lTemCpoProg
			If (cQry)->RF_DATINI2 >= dDtfDe .And. (cQry)->RF_DATINI2 <= dDtfAte
				dDtIniProg := (cQry)->RF_DATINI2
				nDiasFePro := (cQry)->RF_DFEPRO2
				nDiasAbono := (cQry)->RF_DABPRO2
			ElseIf (cQry)->RF_DATINI3 >= dDtfDe .And. (cQry)->RF_DATINI3 <= dDtfAte
				dDtIniProg := (cQry)->RF_DATINI3
				nDiasFePro := (cQry)->RF_DFEPRO3
				nDiasAbono := (cQry)->RF_DABPRO3
			EndIf
		EndIf
		If !Empty(dDtIniProg)
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Carrega Matriz Com Dados da Empresa                          ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ				
			fInfo(@aInfo,SRA->RA_FILIAL)
			nDferven := nDferave := 0
			If (cQry)->RF_DVENPEN > 0 .And. !Empty((cQry)->RF_IVENPEN)
		 		M->RH_DATABAS := (cQry)->RF_IVENPEN
				M->RH_DBASEAT := (cQry)->RF_FVENPEN
				nDferven       := (cQry)->RF_DVENPEN
			Else
		  		M->RH_DATABAS := (cQry)->RF_DATABAS
				M->RH_DBASEAT := fCalcFimAq((cQry)->RF_DATABAS)
				If nDiasFePro > 0
					nDferven := nDiasFePro
				Else
					//Calc_Fer(SRF->RF_DATABAS,dDatabase,@nDferven,@nDferave)
					nDferven := (cQry)->RF_DFERVAT
					nDferven := If (nDferVen <= 0,nDferave,nDferven)
				EndIf
			EndIf
			
			nDiasAviso 		:= GetNewPar("MV_AVISFER",aTabFer[3])  // Dias Aviso Ferias
			
			If !empty((cQry)->RF_ABOPEC)
				cAboPec := (cQry)->RF_ABOPEC
			Else	          
				cAboPec := cAboAnt		//-- cAboPec = 1 -> considera abono antes do periodo de gozo de ferias 
			EndIf

			M->RH_DTAVISO  := fVerData(dDtIniProg - (If (nDiasAviso > 0, nDiasAviso,aTabFer[3]))) 
			M->RH_DFERIAS  := If( nDFerven > aTabFer[3] , aTabFer[3] , nDFerven )
			M->RH_DTRECIB  := If(cAboPec=="1" .and. nDiasAbono > 0,DataValida(DataValida((dDtIniProg-nDiasAbono)-1,.F.)-1,.F.), DataValida(DataValida(dDtIniProg-1,.F.)-1,.F.))
			M->RF_TEMABPE  := (cQry)->RF_TEMABPE
	
			If (cQry)->RF_TEMABPE == "S" .And. !lTemCpoProg
				M->RH_DFERIAS -= If(nDiasAbono > 0, nDiasAbono, 10)
			Endif

			//--Abater dias de ferias Antecipadas
			If (cQry)->RF_DFERANT > 0
				M->RH_DFERIAS := Min(M->RH_DFERIAS, aTabFer[3]-(cQry)->RF_DFERANT)
			Endif

			// Abate Faltas  do cad. Provisoes 
			If (cQry)->RF_DFALVAT > 5
				nDFaltaV:= (cQry)->RF_DFALVAT
				TabFaltas(@nDFaltaV)                                                    

				If (nDFaltaV > 0 .and. nDiasAbono > 0 ) 
				            
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³  Se tiver faltas e abono, calcular os dias de ferias\abono proporcional as faltas.|
				//³	 Exemplo: 20 dias ferias                                                          |
		   	    //³	          10 dias de abono e                                                      |
				//³ 		  10 Faltas = deduzir 6 dias das ferias. 		 					      |
				//³           Regra do abono: 1/3 dos dias de ferias.                                 |
				//³			  Como funcionario teve 10 faltas, ele tem direito a apenas 24 dias de    |
				//³           ferias, e nao 30. Os dias de feria e abono devem ser proporcionais aos  |
				//³           dias de direito de ferias.                                              |
				//³           Dias de Direito = 24													  |
   		        //³           Dias de Abono   =  8 (24 / 3 = 1/3 dos dias de direito )                |
   	    	    //³           Dias de Ferias  = 16 (24 - 8 dias de abono) 							  |
   	    	    //³           Total de Ferias + Abono  = 24 Dias 									  |
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

					nDiasDedFer   := ( nDiasFePro - ( nDFaltaV - nDiasAbono ) )
					
					If nDiasDedFer > 0  
						M->RH_DFERIAS := nDiasDedFer - NoRound( ( ( nDiasFePro + nDiasAbono ) - nDFaltaV ) / 3 )
					Else	
						M->RH_DFERIAS -= (nDFaltaV)				
					EndIf	
	
				Else	
					M->RH_DFERIAS -= (nDFaltaV)
				EndIf	
			Endif			
	
			DaAuxI := dDtIniProg
			DaAuxF := dDtIniProg + M->RH_DFERIAS - 1
	
			If M->RH_DFERIAS > 0
				For nImprVias := 1 to nVias
					ExecBlock("IMPFER",.F.,.F.)
				Next
			Endif
		EndIf
	Endif
	(cQry)->(dbCloseArea())
Endif	

Return