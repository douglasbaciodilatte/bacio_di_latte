#INCLUDE "PROTHEUS.CH"
#include "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"


User Function MTA650MNU ()
	aAdd(aRotina,{ "Impressão da Etiqueta PA", "U_BDLETIQPA(SC2->C2_PRODUTO,SC2->C2_QUANT,SC2->C2_XLOTE,SC2->C2_XVALIDA,1)", 0 , 2, 0, .F.})
Return

User function MTA650I
	/*
	If SC2->C2_FILIAL $ "0031|0072"
		MsgRun("Imprimindo, aguarde...",,{||U_BDLETIQPA(SC2->C2_PRODUTO,SC2->C2_QUANT,SC2->C2_XLOTE,SC2->C2_XVALIDA, 2) })
	EndIf	
	*/

	If SC2->C2_SEQUEN != '001'

		If SC2->C2_FILIAL == "0031"
		
			SC2->C2_LOCAL 	:= "700002"
			SC2->C2_CC		:= "800003"
		
		ElseIf SC2->C2_FILIAL == "0072"
		
			SC2->C2_LOCAL 	:= "700023"
			SC2->C2_CC		:= "800003"	
		
		EndIf

	EndIf

Return

User Function BDLETIQPA(cProd, nQtd, cLote,dValid, nOpc)

	Processa({|| fImprime(cProd, nQtd,cLote,dValid) })

Return

Static Function fImprime(cProd, nQtd, cLote,dValid)
	Local nY
	Local nP
	Local _cDescr1
	Local _cDescr2
	Local _cUnidade
	Local _cCodPro
	Local _cLoteCTL
	Local _cValidade
	Local _cCodBar
	Local _cContem
	Local _cAlergico
	Local _cIngredi
	Local _cInfNut
	Local _cPesoPad
	Local _nQtdLin
	Local _nLin
	Local i
	Private _aArq	  :={}
	Private aCodEtq	  :={}
	Private cLocImp  := ""
	private aPar     	:= {}
	private aRetPar   := {}


	if empty(Alltrim(cLocImp))
		aAdd(aPar,{1,"Escolha a Impressora " ,SPACE(6) ,"@!"       ,'.T.' , 'CB5', '.T.', 20 , .T. } )
	Endif

	If !ParamBox(aPar,"INFORMAR IMPRESSORA",@aRetPar)
		Return
	EndIf

	cLocImp:= ALLTRIM(aRetPar[1])

	If !CB5SetImp(cLocImp,.F.)
		MsgAlert("Local de impressao invalido!","Aviso")
		Return
	EndIf


	SB1->(DbSetOrder(1))
	SB1->(DbSeek(xFilial("SB1")+cProd))

	SB5->(DbSetOrder(1))
	If SB5->(DbSeek(xFilial("SB5")+cProd))
		_cDescr1  := ALLTRIM(SB5->B5_XTITULO)
		_cDescr2  := ALLTRIM(SB5->B5_XSUBTIT)
		_cUnidade := " "+SB1->B1_UM+" "
		_cPesoPad := Alltrim(SB5->B5_XPESO)
		_cCodPro  := Alltrim(SB1->B1_COD)
		_cLoteCTL := AllTrim(cLote)
		_cValidade:= Transform(dValid,"@E dd/mm/aaaa")
		_cCodBar  := AllTrim(SB1->B1_CODBAR)
		_cContem := Upper(AllTrim(SB5->B5_XCONTEM))
		_cAlergico := "ALÉRGICOS: " + Upper(AllTrim(SB5->B5_XALERGI))
		_cIngredi := "Ingredientes: " + AllTrim(SB5->B5_XINGRED)
		_cInfNut  := "Informação Nutricional: " + AllTrim(SB5->B5_XINFNUT)
		//EMAIL SAC
		B5XEMASAC:=SB5->B5_XEMASAC


		AADD(_aArq,'CT~~CD,~CC^~CT~'+ CRLF)
		AADD(_aArq,'^XA~TA000~JSN^LT0^MNW^MTD^PON^PMN^LH0,0^JMA^PR5,5~SD30^JUS^LRN^CI0^XZ'+ CRLF)
		AADD(_aArq,'^XA'+ CRLF)
		AADD(_aArq,'^MMT'+ CRLF)
		AADD(_aArq,'^PW783'+ CRLF)
		AADD(_aArq,'^LL0783'+ CRLF)
		AADD(_aArq,'^LS0'+ CRLF)
		AADD(_aArq,'^CI27'+ CRLF) //SET O ENCODING

		_nLin := 104
		_nQtdLin := MlCount(_cIngredi, 130)
		for i := 1 to _nQtdLin
			AADD(_aArq,'^FT15,'+AllTrim(Str(_nLin))+'^A0N,16,14^FH\^FD' + memoline(_cIngredi, 130, i) + '^FS'+ CRLF)
			_nLin += 20
		next
		//_nLin := 146
		_nQtdLin := MlCount(_cContem, 130)
		for i := 1 to _nQtdLin
			AADD(_aArq,'^FT15,'+AllTrim(Str(_nLin))+'^A0N,16,14^FH\^FD' + memoline(_cContem, 130, i) + '^FS'+ CRLF)
			AADD(_aArq,'^FT16,'+AllTrim(Str(_nLin))+'^A0N,16,14^FH\^FD' + memoline(_cContem, 130, i) + '^FS'+ CRLF)			
			_nLin += 20
		next
		//_nLin := 166
		_nQtdLin := MlCount(_cAlergico, 130)
		for i := 1 to _nQtdLin
			AADD(_aArq,'^FT15,'+AllTrim(Str(_nLin))+'^A0N,16,14^FH\^FD' + memoline(_cAlergico, 130, i) +'^FS'+ CRLF)
			AADD(_aArq,'^FT16,'+AllTrim(Str(_nLin))+'^A0N,16,14^FH\^FD' + memoline(_cAlergico, 130, i) +'^FS'+ CRLF)
			_nLin += 20
		next
		//_nLin := 228
		_nQtdLin := MlCount(_cInfNut, 130)
		for i := 1 to _nQtdLin
			AADD(_aArq,'^FT15,'+AllTrim(Str(_nLin))+'^A0N,16,14^FH\^FD' + memoline(_cInfNut, 130, i) +'^FS'+ CRLF)
			_nLin += 20
		next
		
		AADD(_aArq,'^FT15,'+AllTrim(Str(_nLin))+'^A0N,17,16^FH\^FD* % Valores diários com base em uma dieta de 2.000 kcal ou 8400 kJ. Seus valores diários podem ser ^FS'+ CRLF)
		AADD(_aArq,'^FT15,'+AllTrim(Str(_nLin + 20))+'^A0N,17,16^FH\^FDmaiores ou menores dependendo de suas necessidades energéticas.^FS'+ CRLF)
		AADD(_aArq,'^FT15,'+AllTrim(Str(_nLin + 40))+'^A0N,17,16^FH\^FD** VD não estabelecido.^FS'+ CRLF)
		AADD(_aArq,'^FT15,77^A0N,17,16^FH\^FD'+PADC(_cDescr2, 130)+'^FS'+ CRLF)
		AADD(_aArq,'^FT15,568^A0N,45,45^FH\^FDPeso: '+_cPesoPad+' Kg ^FS'+ CRLF)
		AADD(_aArq,'^BY3,3,55^FT100,650^BCN,,Y,N'+ CRLF)
		AADD(_aArq,'^FD>:' + _cCodBar + '^FS'+ CRLF)
		AADD(_aArq,'^BY3,3,55^FT100,750^BCN,,Y,N'+ CRLF)
		AADD(_aArq,'^FD>:' + _cLoteCTL + '^FS'+ CRLF)
		AADD(_aArq,'^FT15,55^A0N,39,38^FH\^FD'+PADC(_cDescr1, 54)+'^FS'+ CRLF)		
		AADD(_aArq,'^FT432,550^A0N,17,16^FH\^FDSAC- Serviço de atendimento ao Consumidor^FS'+ CRLF)
		AADD(_aArq,'^FT432,571^A0N,17,16^FH\^FDsac@bdil.com.br^FS'+ CRLF)
		AADD(_aArq,'^FT432,444^A0N,17,16^FH\^FDFabricado por:^FS'+ CRLF)
		AADD(_aArq,'^FT432,465^A0N,17,16^FH\^FDMilano Com Var de Ali S.A. ^FS'+ CRLF)
		AADD(_aArq,'^FT432,486^A0N,17,16^FH\^FDAv João Paulo Ablas 1380 - Cotia - SP^FS'+ CRLF)
		AADD(_aArq,'^FT432,507^A0N,17,16^FH\^FDCNPJ 11 950 487/0031-05^FS'+ CRLF)
		AADD(_aArq,'^FT432,528^A0N,17,16^FH\^FDIndústria Brasileira.^FS'+ CRLF)
		AADD(_aArq,'^FT15,445^A0N,20,19^FH\^FDModo de conservação:^FS'+ CRLF)
		AADD(_aArq,'^FT17,504^A0N,20,19^FH\^FDApós aberto consumir em 5 dias.^FS'+ CRLF)
		AADD(_aArq,'^FT431,400^A0N,23,24^FH\^FDLote: '+_cLoteCTL+'^FS'+ CRLF)
		AADD(_aArq,'^FT15,469^A0N,20,19^FH\^FDManter em temperatura inferior a -20\F8C.^FS'+ CRLF)
		AADD(_aArq,'^FT15,406^A0N,37,36^FH\^FDValidade: '+_cValidade+'^FS'+ CRLF)
		AADD(_aArq,'^PQ'+cValTochar(nQtd)+',0,1,Y^XZ'+ CRLF)

		AADd(aCodEtq,_aArq)


		For nY:=1 To Len(aCodEtq)
			For nP:=1 To Len(aCodEtq[nY])
				MSCBWrite(aCodEtq[nY][nP])
			Next nP
		Next nY

		_aArq:= {}
		aCodEtq:= {}
		MSCBEND()

		MSCBCLOSEPRINTER()


	Else
		Alert("Sem cadastro de complemento:"+alltrim(cProd))
	Endif
Return
