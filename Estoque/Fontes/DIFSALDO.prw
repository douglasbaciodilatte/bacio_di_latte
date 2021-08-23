#INCLUDE 'RWMAKE.CH'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DIFSALDO  ºAutor  ³Rodolfo Vacari      º Data ³  23/02/2021 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ FJS - Lista Diferen‡as de Saldo entre SB2 x SB8 x SBF      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ RVACARI - FOR ALL                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function DIFSALDO()

//-- Variaveis Gern‚ricas
Private aReturn    := {'Zebrado', 1,'Administra‡„o', 2, 2, 1, '',1}
Private cbTxt      := ''
Private cDesc1     := 'O objetivo deste relat¢rio ‚ exibir detalhadamente todas as diferen‡as'
Private cDesc2     := 'de Saldo entre os arquivos SB2 x SB8 x SBF.'
Private cCabec1    := ''
Private cCabec2    := ''
Private cTitulo    := 'RELACAO DE DIFERENCAS SB2xSB8xSBF'
Private cString    := 'SB1'
Private cRodaTxt   := ''
Private cNomePrg   := 'DIFSALDO'
Private nTipo      := 18
Private nTamanho   := 'G'
Private nLastKey   := 0
Private nCntImpr   := 0
Private lAbortPrin := .F.
Private WnRel      := 'DIFSALDO'

//-- Envia o Controle para a funcao SETPRINT
WnRel:=SetPrint(cString,WnRel,,@cTitulo,cDesc1,cDesc2,'',.F.,'')

If nLastKey == 27
	Return Nil
Endif
SetDefault(aReturn,cString)
If nLastKey == 27
	Return Nil
Endif

RptStatus({|| _DIFSALDO()},cTitulo)

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_DIFSALDO ºAutor  ³RODOLFO VACARI      º Data ³  23/02/2021 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ RVACARI - FOR ALL                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function _DIFSALDO()

//-- Variaveis Especificas
// Alterado sequencia de Local para Private
Private aImp       := {}
Private aLocais    := {}
Private aLoteSLote := {}
Private aQuantSB2t := {}
Private aClassSB2t := {}
Private aEmpenSB2t := {}
Private aQuantSB8t := {}
Private aClassSB8t := {}
Private aEmpenSB8t := {}
Private aQuantSBFt := {}
Private aClassSBFt := {}
Private aEmpenSBFt := {}
Private cCod       := ''
Private cCodAnt    := ''
Private cLocal     := ''
Private cLoteCtl   := ''
Private cNumLote   := ''
Private cArqSDA    := ''
Private cFilSB1    := xFilial('SB1')
Private cSeekSB2   := ''
Private cSeekSB8   := ''
Private cSeekSBF   := ''
Private cSeekSDA   := ''
Private cPictQuant := '@E 999999999.99' //-- PesqPict('SB2','B2_QATU', 12) -> estava gerando @E ®99999999.99...
Private cTipoDif   := ''
Private cRastro    := ''
Private cLocaliza  := ''
Private lLocaliza  := .F.
Private lRastro    := .F.
Private lRastroS   := .F.
Private lImpEmp    := .F.
Private nX         := 0
Private nY         := 0
Private nIndSDA    := 0
Private nQuantSB2  := 0
Private nClassSB2  := 0
Private nEmpenSB2  := 0
Private nQuantSB8  := 0
Private nClassSB8  := 0
Private nEmpenSB8  := 0
Private nQuantSBF  := 0
Private nClassSBF  := 0
Private nEmpenSBF  := 0

//-- Variaveis de Controle de Impressao
Private nTotRegs   := 0
Private nMult      := 1
Private nPosAnt    := 4
Private nPosAtu    := 4
Private nPosCnt    := 0
Private Li         := 80
Private m_Pag      := 01
Private nTipo      := If(aReturn[4]==1,15,18)

If GetNewPar('MV_DIFSEMP','N')=='S'
	lImpEmp := (Aviso('DIFSALDO','Imprime Diferencas de Empenhos/Reservas? (Padrao=Nao)',{'Nao','Sim'})==2)
EndIf

//-- Monta os Cabecalhos
cCabec1 := '                                                                                                          _______QUANTIDADE EM ESTOQUE_______    _____QUANTIDADE A CLASSIFICAR_____  '
cCabec2 := 'OC PRODUTO       LOCAL RASTRO? LOCALIZA? LOTE       SUB-LOTE       TIPO DA DIFERENCA                      QUANT_SB2    QUANT_SB8    QUANT_SBF    CLASS_SB2    CLASS_SB8    CLASS_SBF '
If lImpEmp
	cCabec1 := cCabec1 + '___QUANTIDADE EMPENHADA/RESERVADA____'
	cCabec2 := cCabec2 + 'EMP/RES_SB2  EMP/RES_SB8  EMP/RES_SBF'
EndIf
//--        XXXXXXXXXXXXXXX  XX    XXXXXXX XXXXXXX   XXXXXXXXXX XXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX 999999999999 999999999999 999999999999 999999999999 999999999999 999999999999 999999999999 999999999999 999999999999
//--        0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//--        01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

//-- Abertura dos Arquivos e Indices utilizados no Programa
dbSelectArea('SDA')
dbSetOrder(1)
If GetMV('MV_RASTRO')=='S'
	cArqSDA := CriaTrab('', .F.)
	IndRegua('SDA', cArqSDA, 'DA_FILIAL+DA_PRODUTO+DA_LOCAL+DA_LOTECTL+DA_NUMLOTE',,, 'Selecionando Registros...')
	nIndSDA := RetIndex('SDA')
	#IFNDEF TOP
		dbSetIndex(cArqSDA+OrdBagExt())
	#ENDIF
	dbSetOrder(nIndSDA+1)
	dbGoTop()
EndIf

dbSelectArea('SBF')
dbSetOrder(2)

dbSelectArea('SB8')
dbSetOrder(3)

dbSelectArea('SB2')
dbSetOrder(1)

dbSelectArea('SB1')
dbSetOrder(1)

//-- Inicia a Regua de Relatorio
SetRegua(LastRec())
dbGoTop()

//-- Varre todo o SB1
Do While !SB1->(Eof()) .And. SB1->B1_FILIAL==cFilSB1
	
	//-- Verifica se houve interrup‡„o pelo operador
	#IFNDEF WINDOWS
		Inkey()
		lAbortPrin := (LastKey()==286)
	#ENDIF
	If lAbortPrin
		Exit
	Endif
	
	//-- Processa a Regua de Relatorio
	IncRegua()
	
	//-- Executa a validacao do filtro do usuario
	If !Empty(aReturn[7]) .And. !&(aReturn[7])
		dbSkip()
		Loop
	EndIf
	
	cCod      := B1_COD
	lRastro   := Rastro(B1_COD)
	lRastroS  := Rastro(B1_COD, 'S')
	lLocaliza := Localiza(B1_COD)
	If lRastro .Or. lLocaliza
		
		//-- Verifica em quais Locais o Saldo deve ser Analisado
		aLocais := {}
		dbSelectArea('SB2')
		If dbSeek(cSeekSB2:=xFilial('SB2')+cCod, .F.)
			Do While !Eof() .And. cSeekSB2==B2_FILIAL+B2_COD
				If aScan(aLocais, B2_LOCAL)==0
					aAdd(aLocais, B2_LOCAL)
				EndIf
				dbSkip()
			EndDo
		EndIf
		If lLocaliza
			dbSelectArea('SBF')
			If dbSeek(cSeekSBF:=xFilial('SBF')+cCod, .F.)
				Do While !Eof() .And. cSeekSBF==BF_FILIAL+BF_PRODUTO
					If aScan(aLocais, BF_LOCAL)==0
						aAdd(aLocais, BF_LOCAL)
					EndIf
					dbSkip()
				EndDo
			EndIf
		EndIf
		If lRastro
			dbSelectArea('SB8')
			If dbSeek(cSeekSB8:=xFilial('SB8')+cCod, .F.)
				Do While !Eof() .And. cSeekSB8==B8_FILIAL+B8_PRODUTO
					If aScan(aLocais, B8_LOCAL)==0
						aAdd(aLocais, B8_LOCAL)
					EndIf
					dbSkip()
				EndDo
			EndIf
		EndIf
		
		For nX := 1 to Len(aLocais)
			
			cLocal     := aLocais[nX]
			nQuantSB8t := 0
			nClassSB8t := 0
			nEmpenSB8t := 0
			nQuantSBFt := 0
			nClassSBFt := 0
			nEmpenSBFt := 0
			
			//-- Compoe o Saldo no SB2 por Produto+Local
			nQuantSB2 := 0
			nClassSB2 := 0
			nEmpenSB2 := 0
			dbSelectArea('SB2')
			If dbSeek(cSeekSB2:=xFilial('SB2')+cCod+cLocal, .F.)
				Do While !Eof() .And. cSeekSB2==B2_FILIAL+B2_COD+B2_LOCAL
					nQuantSB2 := nQuantSB2+B2_QATU
					nClassSB2 := nClassSB2+B2_QACLASS
					nEmpenSB2 := nEmpenSB2+(B2_QEMP+B2_RESERVA)
					dbSkip()
				EndDo
			EndIf
			
			If lLocaliza
				nQuantSBF := 0
				nClassSBF := 0
				nEmpenSBF := 0
				nQuantSB8 := 0
				nClassSB8 := 0
				nEmpenSB8 := 0
				dbSelectArea('SBF')
				If dbSeek(cSeekSBF:=xFilial('SBF')+cCod+cLocal, .F.)
					aLoteSLote := {}
					Do While !Eof() .And. cSeekSBF == BF_FILIAL+BF_PRODUTO+BF_LOCAL
						nQuantSBF := 0
						nClassSBF := 0
						nEmpenSBF := 0
						If lRastro
							cLoteCtl  := BF_LOTECTL
							cNumLote  := BF_NUMLOTE
							If (aScan(aLoteSLote, {|x| x[1]==cLoteCtl.And.If(lRastroS,x[2]==cNumLote,.T.)}))==0
								aAdd(aLoteSLote, {cLoteCtl,cNumLote})
							EndIf
							nQuantSB8 := 0
							nClassSB8 := 0
							nEmpenSB8 := 0
							If Empty(cLoteCtl+cNumLote)
								dbSkip()
								Loop
							EndIf
							//-- Compoe o Saldo no SBF por Produto+Local+Lote+SubLote
							Do While !Eof() .And. cSeekSBF+cLoteCtl+cNumLote==BF_FILIAL+BF_PRODUTO+BF_LOCAL+BF_LOTECTL+BF_NUMLOTE
								nQuantSBF := nQuantSBF+BF_QUANT
								nEmpenSBF := nEmpenSBF+BF_EMPENHO
								dbSkip()
							EndDo
							//-- Compoe o Saldo no SDA por Produto+Local+Lote+SubLote
							dbSelectArea('SDA')
							If dbSeek(cSeekSDA:=xFilial('SDA')+cCod+cLocal+cLoteCtl+cNumLote, .F.)
								Do While !Eof() .And. cSeekSDA==DA_FILIAL+DA_PRODUTO+DA_LOCAL+DA_LOTECTL+DA_NUMLOTE
									nQuantSBF := nQuantSBF+DA_SALDO
									nClassSBF := nClassSBF+DA_SALDO
									dbSkip()
								EndDo
							EndIf
							nQuantSBFt := nQuantSBFt+nQuantSBF
							nClassSBFt := nClassSBFt+nClassSBF
							nEmpenSBFt := nEmpenSBFt+nEmpenSBF
							//-- Compoe o Saldo no SB8 por Produto+Local+Lote+SubLote
							dbSelectArea('SB8')
							If dbSeek(cSeekSB8:=xFilial('SB8')+cCod+cLocal+cLoteCtl+If(lRastroS,cNumLote,''), .F.)
								Do While !Eof() .And. cSeekSB8==B8_FILIAL+B8_PRODUTO+B8_LOCAL+B8_LOTECTL+If(lRastroS,B8_NUMLOTE,'')
									nQuantSB8 := nQuantSB8+B8_SALDO
									nClassSB8 := nClassSB8+B8_QACLASS
									nEmpenSB8 := nEmpenSB8+B8_EMPENHO
									dbSkip()
								EndDo
								nQuantSB8t := nQuantSB8t+nQuantSB8
								nClassSB8t := nClassSB8t+nClassSB8
								nEmpenSB8t := nEmpenSB8t+nEmpenSB8
							EndIf
							//-- Diferen‡a entre SBFxSB8
							cTipoDif := 'B8xBF'
							_AddImp()
						Else
							//-- Compoe o Saldo no SBF por Produto+Local
							Do While !Eof() .And. cSeekSBF==BF_FILIAL+BF_PRODUTO+BF_LOCAL
								nQuantSBF := nQuantSBF+BF_QUANT
								nEmpenSBF := nEmpenSBF+BF_EMPENHO
								dbSkip()
							EndDo
							//-- Compoe o Saldo no SDA por Produto+Local
							dbSelectArea('SDA')
							If dbSeek(cSeekSDA:=xFilial('SDA')+cCod+cLocal, .F.)
								Do While !Eof() .And. cSeekSDA==DA_FILIAL+DA_PRODUTO+DA_LOCAL
									nQuantSBF := nQuantSBF+DA_SALDO
									nClassSBF := nClassSBF+DA_SALDO
									dbSkip()
								EndDo
							EndIf
							nQuantSBFt := nQuantSBFt+nQuantSBF
							nClassSBFt := nClassSBFt+nClassSBF
							nEmpenSBFt := nEmpenSBFt+nEmpenSBF
						EndIf
						dbSelectArea('SBF')
					EndDo
					//-- Procura por Lotes/SubLotes no SB8 nÆo registrados no SBF
					If lRastro .And. SB8->(dbSeek(cSeekSB8:=xFilial('SB8')+cCod+cLocal, .F.))
						//-- Produtos sem movimenta‡Æo no SBF
						dbSelectArea('SB8')
						Do While !Eof() .And. cSeekSB8==B8_FILIAL+B8_PRODUTO+B8_LOCAL
							nQuantSB8 := 0
							nClassSB8 := 0
							nEmpenSB8 := 0
							cLoteCtl  := B8_LOTECTL
							cNumLote  := B8_NUMLOTE
							If !(aScan(aLoteSLote, {|x| x[1]==cLoteCtl.And.If(lRastroS,x[2]==cNumLote,.T.)}))==0
								dbSkip()
								Loop
							EndIf
							If Empty(cLoteCtl+cNumLote)
								dbSkip()
								Loop
							EndIf
							//-- Compoe o Saldo no SB8 por Produto+Local+Lote+SubLote
							Do While !Eof() .And. cSeekSB8+cLoteCtl+If(lRastroS,cNumLote,'')==B8_FILIAL+B8_PRODUTO+B8_LOCAL+B8_LOTECTL+If(lRastroS,B8_NUMLOTE,'')
								nQuantSB8 := nQuantSB8+B8_SALDO
								nClassSB8 := nClassSB8+B8_QACLASS
								nEmpenSB8 := nEmpenSB8+B8_EMPENHO
								dbSkip()
							EndDo
							nQuantSB8t := nQuantSB8t+nQuantSB8
							nClassSB8t := nClassSB8t+nClassSB8
							nEmpenSB8t := nEmpenSB8t+nEmpenSB8
							nQuantSBF  := 0
							nClassSBF  := 0
							nEmpenSBF  := 0
							//-- Compoe o Saldo no SDA por Produto+Local+Lote+SubLote
							dbSelectArea('SDA')
							If dbSeek(cSeekSDA:=xFilial('SDA')+cCod+cLocal+cLoteCtl+If(lRastroS,cNumLote,''), .F.)
								Do While !Eof() .And. cSeekSDA==DA_FILIAL+DA_PRODUTO+DA_LOCAL+DA_LOTECTL+If(lRastroS,DA_NUMLOTE,'')
									nQuantSBF := nQuantSBF+DA_SALDO
									nClassSBF := nClassSBF+DA_SALDO
									dbSkip()
								EndDo
							EndIf
							nQuantSBFt := nQuantSBFt+nQuantSBF
							nClassSBFt := nClassSBFt+nClassSBF
							nEmpenSBFt := nEmpenSBFt+nEmpenSBF
							//-- Diferen‡a entre SBFxSB8
							cTipoDif := 'B8xBF'
							_AddImp()
							dbSelectArea('SB8')
						EndDo
					EndIf
				ElseIf lRastro .And. SB8->(dbSeek(cSeekSB8:=xFilial('SB8')+cCod+cLocal, .F.))
					//-- Produtos sem movimenta‡Æo no SBF
					dbSelectArea('SB8')
					Do While !Eof() .And. cSeekSB8==B8_FILIAL+B8_PRODUTO+B8_LOCAL
						nQuantSB8 := 0
						nClassSB8 := 0
						nEmpenSB8 := 0
						cLoteCtl  := B8_LOTECTL
						cNumLote  := B8_NUMLOTE
						If Empty(cLoteCtl+cNumLote)
							dbSkip()
							Loop
						EndIf
						//-- Compoe o Saldo no SB8 por Produto+Local+Lote+SubLote
						Do While !Eof() .And. cSeekSB8+cLoteCtl+If(lRastroS,cNumLote,'')==B8_FILIAL+B8_PRODUTO+B8_LOCAL+B8_LOTECTL+If(lRastroS,B8_NUMLOTE,'')
							nQuantSB8 := nQuantSB8+B8_SALDO
							nClassSB8 := nClassSB8+B8_QACLASS
							nEmpenSB8 := nEmpenSB8+B8_EMPENHO
							dbSkip()
						EndDo
						nQuantSB8t := nQuantSB8t+nQuantSB8
						nClassSB8t := nClassSB8t+nClassSB8
						nEmpenSB8t := nEmpenSB8t+nEmpenSB8
						nQuantSBF  := 0
						nClassSBF  := 0
						nEmpenSBF  := 0
						//-- Compoe o Saldo no SDA por Produto+Local+Lote+SubLote
						dbSelectArea('SDA')
						If dbSeek(cSeekSDA:=xFilial('SDA')+cCod+cLocal+cLoteCtl+If(lRastroS,cNumLote,''), .F.)
							Do While !Eof() .And. cSeekSDA==DA_FILIAL+DA_PRODUTO+DA_LOCAL+DA_LOTECTL+If(lRastroS,DA_NUMLOTE,'')
								nQuantSBF := nQuantSBF+DA_SALDO
								nClassSBF := nClassSBF+DA_SALDO
								dbSkip()
							EndDo
						EndIf
						nQuantSBFt := nQuantSBFt+nQuantSBF
						nClassSBFt := nClassSBFt+nClassSBF
						nEmpenSBFt := nEmpenSBFt+nEmpenSBF
						//-- Diferen‡a entre SBFxSB8
						cTipoDif := 'B8xBF'
						_AddImp()
						dbSelectArea('SB8')
					EndDo
				Else
					//-- Verifica no SDA Saldos Ainda NÆo Distribuidos
					dbSelectArea('SDA')
					If dbSeek(cSeekSDA:=xFilial('SDA')+cCod+cLocal, .F.)
						Do While !Eof() .And. cSeekSDA==DA_FILIAL+DA_PRODUTO+DA_LOCAL
							nQuantSBF := 0
							nClassSBF := 0
							nEmpenSBF := 0
							//-- Compoe o Saldo por Produto+Local
							Do While !Eof() .And. cSeekSDA==DA_FILIAL+DA_PRODUTO+DA_LOCAL
								nQuantSBF := nQuantSBF+DA_SALDO
								nClassSBF := nClassSBF+DA_SALDO
								dbSkip()
							EndDo
							nQuantSBFt := nQuantSBFt+nQuantSBF
							nClassSBFt := nClassSBFt+nClassSBF
							nEmpenSBFt := nEmpenSBFt+nEmpenSBF
							dbSelectArea('SDA')
						EndDo
					EndIf
				EndIf
				nQuantSB8 := nQuantSB8t
				nClassSB8 := nClassSB8t
				nEmpenSB8 := nEmpenSB8t
				nQuantSBF := nQuantSBFt
				nClassSBF := nClassSBFt
				nEmpenSBF := nEmpenSBFt
				If lRastro
					//-- Diferen‡a entre SB8xSB2
					cLoteCtl  := ''
					cNumLote  := ''
					cTipoDif  := 'B2xB8'
					_AddImp()
				EndIf
				//-- Diferen‡a entre SBFxSB2
				cLoteCtl := ''
				cNumLote := ''
				cTipoDif := 'B2xBF'
				_AddImp()
			ElseIf lRastro
				nQuantSB8 := 0
				nClassSB8 := 0
				nEmpenSB8 := 0
				dbSelectArea('SB8')
				If dbSeek(cSeekSB8:=xFilial('SB8')+cCod+cLocal, .F.)
					Do While !Eof() .And. cSeekSB8==B8_FILIAL+B8_PRODUTO+B8_LOCAL
						cLoteCtl  := B8_LOTECTL
						cNumLote  := If(lRastroS,B8_NUMLOTE,'')
						nQuantSB8 := 0
						nClassSB8 := 0
						nEmpenSB8 := 0
						//-- Compoe no SB8 o Saldo por Produto+Local+Lote+SubLote
						Do While !Eof() .And. cSeekSB8+cLoteCtl+cNumLote==B8_FILIAL+B8_PRODUTO+B8_LOCAL+B8_LOTECTL+If(lRastroS,B8_NUMLOTE,'')
							nQuantSB8 := nQuantSB8+B8_SALDO
							nClassSB8 := nClassSB8+B8_QACLASS
							nEmpenSB8 := nEmpenSB8+B8_EMPENHO
							dbSkip()
						EndDo
						nQuantSB8t := nQuantSB8t+nQuantSB8
						nClassSB8t := nClassSB8t+nClassSB8
						nEmpenSB8t := nEmpenSB8t+nEmpenSB8
					EndDo
					nQuantSB8 := nQuantSB8t
					nClassSB8 := nClassSB8t
					nEmpenSB8 := nEmpenSB8t
					nQuantSBF := nQuantSBFt
					nClassSBF := nClassSBFt
					nEmpenSBF := nEmpenSBFt
					//-- Diferen‡a entre SB8xSB2
					cLoteCtl := ''
					cNumLote := ''
					cTipoDif := 'B2xB8'
					_AddImp()
				EndIf
			EndIf
		Next nX
	EndIf
	dbSelectArea('SB1')
	dbSkip()
EndDo	

//-- ImpressÆo dos Dados
For nX := 1 to Len(aImp)
	aSort(aImp[nX],,,{|x, y| x[1]+x[2]+x[5]+x[6] < y[1]+y[2]+y[5]+y[6]})
	For nY := 1 to Len(aImp[nX])
		lRastro   := aImp[nX, nY,03,1]
		lLocaliza := aImp[nX, nY,04]
		cCod      := aImp[nX, nY, 01]
		cLocal    := aImp[nX, nY, 02]
		cRastro   := If(aImp[nX,nY,03,1],If(aImp[nX,nY,03,2],'SUBLOTE','LOTE'),'NAO')
		cLocaliza := If(aImp[nX,nY,04],'UTILIZA','NAO')
		cLoteCtl  := aImp[nX, nY, 05]
		cNumLote  := aImp[nX, nY, 06]
		cTipoDif  := aImp[nX, nY, 07]
		nQuantSB2 := aImp[nX, nY, 08]
		nQuantSB8 := aImp[nX, nY, 09]
		nQuantSBF := aImp[nX, nY, 10]
		nClassSB2 := aImp[nX, nY, 11]
		nClassSB8 := aImp[nX, nY, 12]
		nClassSBF := aImp[nX, nY, 13]
		nEmpenSB2 := aImp[nX, nY, 14]
		nEmpenSB8 := aImp[nX, nY, 15]
		nEmpenSBF := aImp[nX, nY, 16]
		_ImpDif()
	Next nY
Next nX


//-- Verifica se houve interrup‡„o pelo operador
If lAbortPrin
	@Prow()+1, 001 PSAY 'CANCELADO PELO OPERADOR'
ElseIf Len(aImp)>0 .And. Len(aImp[1])>0
	//-- ImpressÆo da Legenda
	If Li > 58
		Cabec(cTitulo,cCabec1,cCabec2,cNomePrg,nTamanho,nTipo)
	EndIf
	Li := Li+1
	@Li, 000 PSAY 'INFORMACOES SOBRE OS TIPOS DE DIFERENCA:'
	Li := Li+1
	@LI, 000 PSAY 'Q_ - DIFERENCA DE QUANTIDADES'
	Li := Li+1
	@Li, 000 PSAY 'C_ - DIFERENCA DE QTD A CLASSIFICAR'
	Li := Li+1
	If lImpEmp
		@Li, 000 PSAY 'E_ - DIFERENCA DE QTD EMPENHADA/RESERVADA'
		Li := Li+1
	EndIf
	@Li, 000 PSAY 'AAxBB - ARQUIVOS ONDE AS DIFERENCAS FORAM ENCONTRADAS'
	Li := Li+1
	@Li, 000 PSAY '        OBS.: O SALDO DO SBF FOI COMPOSTO COM A ADICAO DA QTD DO SDA'
	Li := Li+1
EndIf

If !(Li==80)
	Roda(nCntImpr, cRodaTxt, nTamanho)
EndIf

Set Device to Screen

If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(WnRel)
Endif

MS_Flush()

fErase(cArqSDA+OrdBagExt())

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_AddImp   ºAutor  ³RODOLFO VACARI      º Data ³  23/02/2021 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Adiciona Dados no Array de Impressao                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ RVACARI - FOR ALL                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function _AddImp()

Local aTmp       := {}
Local nY         := 0
Local nPos       := 0

If Len(aImp) <= 0 .Or. Len(aImp) >=4095
	aAdd(aImp, {})
EndIf

aTmp := {cCod,;                    //-- 01.Codigo do Produto
	cLocal,;                        //-- 02.Local
	{lRastro,lRastroS},;            //-- 03.Rastro?
	lLocaliza,;                     //-- 04.Localiza?
	If('B2'$cTipoDif,'',cLoteCtl),; //-- 05.Lote
	If('B2'$cTipoDif.Or.!lRastroS,'',cNumLote),; //-- 06.Sub-Lote
	'',;                            //-- 07.Tipo de Diferen‡a
	nQuantSB2,;                     //-- 08.Qtd SB2
	nQuantSB8,;                     //-- 09.Qtd SB8
	nQuantSBF,;                     //-- 10.Qtd SBF
	nClassSB2,;                     //-- 11.Class SB2
	nClassSB8,;                     //-- 12.Class SB8
	nClassSBF,;                     //-- 13.Class SBF
	nEmpenSB2,;                     //-- 14.Empen SB2
	nEmpenSB8,;                     //-- 15.Empen SB8
	nEmpenSBF}                      //-- 16.Empen SBF

aTmp[7] := ''
If 'B8xBF' $cTipoDif
	If !(QtdComp(nQuantSBF)==QtdComp(nQuantSB8))
		aTmp[7] := aTmp[7] + If(Empty(aTmp[7]),'','/') + 'Q_'+cTipoDif
	EndIf
	If !(QtdComp(nClassSBF)==QtdComp(nClassSB8))
		aTmp[7] := aTmp[7] + If(Empty(aTmp[7]),'','/') + 'C_'+cTipoDif
	EndIf
	If lImpEmp .And. !(QtdComp(nEmpenSBF)==QtdComp(nEmpenSB8))
		aTmp[7] := aTmp[7] + If(Empty(aTmp[7]),'','/') + 'E_'+cTipoDif
	EndIf
	If !Empty(aTmp[7])
		For nY := 1 to Len(aImp)
			nPos := aScan(aImp[nY], {|x|x[1]==aTmp[1].And.x[2]==aTmp[2].And.x[5]==aTmp[5].And.x[6]==aTmp[6]})
			If nPos > 0
				Exit
			EndIf
		Next nY
		If nPos > 0 .And. !'B2'$aImp[nY,nPos,7] .And. Len((aImp[nY,nPos,7]+If(Empty(aImp[nY,nPos,7]),'','/')+aTmp[7]))<=35
			aImp[nY,nPos,7] := aImp[nY,nPos,7] + If(Empty(aImp[nY,nPos,7]),'','/') + aTmp[7]
		Else
			aAdd(aImp[Len(aImp)], aClone(aTmp))
		EndIf
	EndIf
ElseIf 'B2xB8' $cTipoDif
	If !(QtdComp(nQuantSB8)==QtdComp(nQuantSB2))
		aTmp[7] := aTmp[7] + If(Empty(aTmp[7]),'','/') + 'Q_'+cTipoDif
	EndIf
	If !(QtdComp(nClassSB8)==QtdComp(nClassSB2))
		aTmp[7] := aTmp[7] + If(Empty(aTmp[7]),'','/') + 'C_'+cTipoDif
	EndIf
	If lImpEmp .And. !(QtdComp(nEmpenSB8)==QtdComp(nEmpenSB2))
		aTmp[7] := aTmp[7] + If(Empty(aTmp[7]),'','/') + 'E_'+cTipoDif
	EndIf
	If !Empty(aTmp[7])
		For nY := 1 to Len(aImp)
			nPos := aScan(aImp[nY], {|x|x[1]==aTmp[1].And.x[2]==aTmp[2].And.Empty(x[5]+x[6])})
			If nPos > 0
				Exit
			EndIf
		Next nY
		If nPos > 0 .And. !'B8xBF'$aImp[nY,nPos,7] .And. Len((aImp[nY,nPos,7]+If(Empty(aImp[nY,nPos,7]),'','/')+aTmp[7]))<=35
			aImp[nY,nPos,7] := aImp[nY,nPos,7] + If(Empty(aImp[nY,nPos,7]),'','/') + aTmp[7]
		Else
			aAdd(aImp[Len(aImp)], aClone(aTmp))
		EndIf
	EndIf
ElseIf 'B2xBF' $cTipoDif
	If !(QtdComp(nQuantSBF)==QtdComp(nQuantSB2))
		aTmp[7] := aTmp[7] + If(Empty(aTmp[7]),'','/') + 'Q_'+cTipoDif
	EndIf
	If !(QtdComp(nClassSBF)==QtdComp(nClassSB2))
		aTmp[7] := aTmp[7] + If(Empty(aTmp[7]),'','/') + 'C_'+cTipoDif
	EndIf
	If lImpEmp .And. !(QtdComp(nEmpenSBF)==QtdComp(nEmpenSB2))
		aTmp[7] := aTmp[7] + If(Empty(aTmp[7]),'','/') + 'E_'+cTipoDif
	EndIf
	If !Empty(aTmp[7])
		For nY := 1 to Len(aImp)
			nPos := aScan(aImp[nY], {|x|x[1]==aTmp[1].And.x[2]==aTmp[2].And.Empty(x[5]+x[6])})
			If nPos > 0
				Exit
			EndIf
		Next nY
		If nPos > 0 .And. !'B8xBF'$aImp[nY,nPos,7] .And. Len((aImp[nY,nPos,7]+If(Empty(aImp[nY,nPos,7]),'','/')+aTmp[7]))<=35
			aImp[nY,nPos,7] := aImp[nY,nPos,7] + If(Empty(aImp[nY,nPos,7]),'','/') + aTmp[7]
		Else
			aAdd(aImp[Len(aImp)], aClone(aTmp))
		EndIf
	EndIf
EndIf

Return Nil	

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³_AddImp   ºAutor  ³RODOLFO VACARI     º Data ³  23/02/2021  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Imprime Diferen‡as de Saldo entre SB2 x SB8 x SBF          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ RVACARI - FOR ALL                                          º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function _ImpDif()

If Li > 58
	Cabec(cTitulo,cCabec1,cCabec2,cNomePrg,nTamanho,nTipo)
EndIf
If cCod == cCodAnt
	@Li, 000 PSAY '   ' + PadR(cCod, 15)
Else
	cCodAnt := cCod
	@Li, 000 PSAY '*  ' + PadR(cCod, 15)
EndIf
@Li, 017 PSAY PadR(cLocal,    06)
@Li, 023 PSAY PadR(cRastro,   07)
@Li, 031 PSAY PadR(cLocaliza, 07)
@Li, 041 PSAY PadR(cLoteCtl,  10)
@Li, 052 PSAY PadR(cNumLote,  06)
@Li, 067 PSAY PadR(cTipoDif,  36)
@Li, 103 PSAY If('Q_'$cTipoDif,If('B2'$cTipoDif,Transform(nQuantSB2, cPictQuant),'            '),If('B2'$cTipoDif,'------------','            '))
@Li, 116 PSAY If('Q_'$cTipoDif,If(lRastro,      Transform(nQuantSB8, cPictQuant),'            '),If(lRastro,      '------------','            '))
@Li, 129 PSAY If('Q_'$cTipoDif,If(lLocaliza,    Transform(nQuantSBF, cPictQuant),'            '),If(lLocaliza,    '------------','            '))
@Li, 142 PSAY If('C_'$cTipoDif,If('B2'$cTipoDif,Transform(nClassSB2, cPictQuant),'            '),If('B2'$cTipoDif,'------------','            '))
@Li, 155 PSAY If('C_'$cTipoDif,If(lRastro,      Transform(nClassSB8, cPictQuant),'            '),If(lRastro,      '------------','            '))
@Li, 168 PSAY If('C_'$cTipoDif,If(lLocaliza,    Transform(nClassSBF, cPictQuant),'            '),If(lLocaliza,    '------------','            '))
If lImpEmp
	@Li, 181 PSAY If('E_'$cTipoDif,If('B2'$cTipoDif,Transform(nEmpenSB2, cPictQuant),'            '),If('B2'$cTipoDif,'------------','            '))
	@Li, 194 PSAY If('E_'$cTipoDif,If(lRastro,      Transform(nEmpenSB8, cPictQuant),'            '),If(lRastro,      '------------','            '))
	@Li, 207 PSAY If('E_'$cTipoDif,If(lLocaliza,    Transform(nEmpenSBF, cPictQuant),'            '),If(lLocaliza,    '------------','            '))
EndIf

Li := Li+1

Return Nil
