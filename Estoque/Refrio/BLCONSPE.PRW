#Include "TOTVS.ch"
#Include "FWMVCDEF.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#INCLUDE 'RWMAKE.CH'

User Function BLCONSPE(cNum)

Local cXml    := ''
Local cFil    := ''
Local cSolict := ''
Local cQuery  := ''
Local cResult := ''
Local lAux    := .T.
Local cItem   := ""
Local xCodReq:=""
Local xDestino:="00037"
Local xCNPJ_REQ:=""
Local xCNPJ_DEST:="49.363.468/0005-63"
Local lCab:=.T.
Local CCGCENT:=""
Local xEsp:="LOTE"
Local cStatus:=""
Local xSolicit
Local cMsg := ""

Local aPergs   		:= {}
Local nTipo    		:= 1
Private c_Alias 	:= GetNextAlias()
Private cRelto 	  	:= AllTrim(GETMV("MV_XREFEML"))

aAdd(aPergs, {2, "Tipo Importacao",               nTipo, {"1=WebService",              "2=Arquivos"},     100, ".T.", .F.})

If !ParamBox(aPergs, "Informe os parâmetros")
	Return Nil
EndIf
If ValType(MV_PAR01) == "N"
	If MV_PAR01 == 2
		BLCONPEA()
		Return Nil
	Endif
Else
	If MV_PAR01 == "2"
		BLCONPEA()
		Return Nil
	Endif
Endif

//Filiais que estão usando o envio dos arquivos
//0031 - CNPJ 11950487003105 - CÓDIGO REFRIO 00040
//0072 - CNPJ 11950487007283 - CÓDIGO REFRIO 00043
//0136 - FALTA DEFINIR


dbSelectArea("SM0")
dbSetOrder(1)
dbSeek(cEmpAnt+cFilAnt,.F.)
cCGCREQ := TRANSFORM(SM0->M0_CGC, "@R 99.999.999/9999-99")

If Funname()=="MATA311"
	
	BEGINSQL ALIAS c_Alias
		%NOPARSER%
		SELECT DISTINCT NNS_COD SOLICIT, NNS_DATA,NNS_SOLICT,NNS_XNOMSO,NNS_STATUS, NNS_XCDREF,NNS_STAREF,NNT_PROD,NNT_UM,NNT_LOCAL,NNT_QUANT,
		NNT_FILDES,NNT_LOCLD,NNT_XDATA,NNT_LOTECT, NNT_XHORA,NNT_QTSEG
		,NNT.R_E_C_N_O_ RECNNT FROM %TABLE:NNS% NNS
		INNER JOIN %TABLE:NNT% NNT ON NNT_COD=NNS_COD AND NNT_FILIAL=NNS_FILIAL AND NNT.D_E_L_E_T_=''
		WHERE NNS.D_E_L_E_T_='' AND NNS_STAREF='2' AND NNS_FILIAL=%EXP:cFilant%
	ENDSQL
Else
	BEGINSQL ALIAS c_Alias
		%NOPARSER%
		SELECT TOP 1 C5_FILIAL, C5_CLIENTE, C5_LOJACLI, C5_EMISSAO, C5_XHORA, C5_NUM SOLICIT, C5_STAREF, C6_FILIAL, C6_CLI, C6_LOJA, C6_NUM, C6_ITEM,
		C6_PRODUTO, C6_QTDVEN, C6_LOTECTL FROM %TABLE:SC5% SC5
		INNER JOIN %TABLE:SC6% SC6 ON SC5.C5_FILIAL=SC6.C6_FILIAL AND SC5.C5_NUM=SC6.C6_NUM AND SC5.C5_CLIENTE=SC6.C6_CLI AND SC5.C5_LOJACLI=SC6.C6_LOJA
		WHERE SC5.D_E_L_E_T_='' AND SC6.D_E_L_E_T_='' AND SC5.C5_STAREF='2' AND SC5.C5_NUM=%EXP:cNum% AND SC5.C5_FILIAL=%EXP:cFilAnt%
	ENDSQL
Endif

dbSelectArea(c_Alias)

If Empty((c_Alias)->SOLICIT)
	MsgAlert("Nao foi encontrado dados validos para essa consulta, por favor verifique se o Status dessa Solicitacao/Pedido já nao se encontra como Processado ou se a mesma nao foi enviada", "Atencao")
	Return
Endif



While (c_Alias)->( !Eof() )
	
	cXml:=    '<CONSULTA>'+CRLF
	cXml+=    '  <TIPO>UNICO</TIPO>'+CRLF
	cXml+=    '  <CNPJ>'+cCGCREQ+'</CNPJ>'+CRLF
	cXml+=    '  <numero></numero>'+CRLF//+cSolict+
	cXml+=    '  <serie></serie>'+CRLF
	cXml+=    '  <chaveNFe></chaveNFe>'+CRLF
	cXml+=    '  <nroDocumento>'+(c_Alias)->SOLICIT+'</nroDocumento>'+CRLF
	cXml+=    '</CONSULTA>' +CRLF
	
	oWs:=WSWmsSIS():New()
	oWs:oWScabec:CIDENTIFICADOR:= "WEBAPI-I51"
	oWs:oWScabec:CREQUISITANTE:= cCGCREQ
	
	If oWs:SOLWMSConsumoInterfaces(oWs:oWScabec,cXml)
		cResult := oWs:cSOLWMSConsumoInterfacesResult
		BLLEXML(cResult)
	Else
		cResult := GetWSCError()
	EndIf
	(c_Alias)->( dbSkip() )
EndDo

(c_Alias)->( dbCloseArea() )

Return
/*
| leitura via websercice
*/
Static Function BLLEXML(cFile)

Local cError   := ""
Local cWarning := ""
Local oXml     := NIL
Local aXML     := {}
Local nI       := 0
Local Nx       := 0
Local cResolic
Local aSol
Local cPRODUTO := Space(15)
Local aitens
Local cArqName := "BLCON"+(c_Alias)->SOLICIT+".xml"
Local cDir := "\BLCONSPE\RECEBE\"
Local nHdl := j := 0
Local oDtValid
Local xDtValid
Local aMsg:={}
Local _cSubject:=""
Local xDescr:=""
Local cArquivo:=cArqName
Local oPRODUTO
Local oQuant
Local xQuant
Local oLotect
Local xLotect
Local oDtValid
Local xDtValid
Local aLotect:={}
Local nLenDet:=0
Local y:=0
Local _nQtdCxSep:=0
Local onQtdCxSep
Local w:= nPos := 0
Local cLotect := ""
Local nPos:=0
Local nRecno:=0
Local cItRef:=""
Local oItRef
Local nLen:= 0
Local _aItens := {}
Local aDados := {}

cArqname:=cDir+cArqName

If File(cArqName)
	FErase(cArqName)
Endif

nHdl := FCREATE(cArqName)
if nHdl = -1
	conout("Erro ao criar arquivo - ferror " + Str(Ferror()))
	Return .F.
endif
FWrite(nHdl,cFile+CRLF)
FClose(nHdl)

oXml := XmlParserFile( cArqName, "_", @cError, @cWarning )
If (oXml == NIL )
	MsgStop("Falha ao gerar Objeto XML : "+cError+" / "+cWarning)
	Return .F.
Endif

If !Empty(oXml:_RETORNO:_MENSAGEM:TEXT)
	MsgAlert("Sem novos eventos para processar.(Consulta: UNICO)", "Atencao")
	Return .F.
Endif

If valType(oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_NUMERO) <> "O"
	Return .f.
EndIf

If ValType(oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS) <> "O"
	Return .F.
Endif

_aItens := {}
If ValType(oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM) =="A"
	_aItens := oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM
	nLen := Len(_aItens)
Else
	nLen := 1
Endif

BEGIN TRANSACTION

lProc := .T.
For j:= 1 To nLen
	FreeObj(oPRODUTO)
	FreeObj(oQuant)
	FreeObj(oLotect)
	FreeObj(oDtValid)
	if ValType(oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM) =="A"
		oPRODUTO := oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM[j]:_CODPRODUTO
		oQuant:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM[j]:_QTDEEMBALAGEMSEP
	Else
		oPRODUTO := oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM:_CODPRODUTO
		oQuant:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM:_QTDEEMBALAGEMSEP
	Endif

	cPRODUTO := PADR(oPRODUTO:TEXT,TAMSX3("NNT_PROD")[1])
	xQuant:=oQuant:TEXT
	
	cResolic:= oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_NUMERO:TEXT

	If Funname()=="MATA311"
		cResolic := StrZero(Val(cResolic),TAMSX3("NNS_COD")[1])
	Else
		cResolic := StrZero(Val(cResolic),TAMSX3("C5_NUM")[1])
	Endif


	//If !Val(xQuant) > 0
	//	Alert("Por favor verificar junto ao Fornecedor se o Pedido/Solicitação não foi estornado, não existem detalhes para o processamento")
	//	lProc := .F.
	//	EXIT
	//Endif
	SC6->( dbSetOrder(2))
	SC6->( dbSeek(xFilial("SC6")+cPRODUTO+cResolic,.F.) )
	aLotect:={}
	If Val(xQuant) > 0 
		If Rastro(cPRODUTO)
			If ValType(oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM) == "A"
				If ValType(oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM[j]:_DETALHES:_DETALHE) == "A"
					nLenDet := Len(oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM[j]:_DETALHES:_DETALHE)
					aLotect := {}
					For y:= 1 To nLenDet
						oLotect:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM[j]:_DETALHES:_DETALHE[y]:_NROLOTE
						onQtdCxSep:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM[j]:_DETALHES:_DETALHE[y]:_QTDECAIXASEP
						
						oDtValid:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM[j]:_DETALHES:_DETALHE[y]:_DATAVALIDADE
						xDtValid:=oDtValid:TEXT

						cLotect := oLotect:TEXT
						_nQtdCxSep := Val(StrTran(onQtdCxSep:TEXT,",","."))
						//Verifica se o Lote Existe e tem data de validade correto
						//If ( cMsg := vLidaLote(cPRODUTO,cLotect,xDtValid,SC6->C6_LOCAL) ) != "OK"
						//	aAdd(aMsg, {{cPRODUTO, cMsg, Transform(SC6->C6_XQTDREF,PesqPict("SC6","C6_XQTDREF")),Transform(SC6->C6_QTDVEN,PesqPict("SC6","C6_QTDVEN")),SC6->C6_XLTREF,cLotect}})
						//EndIf
						//Aglutina Lotes Iguais				
						If (nPos := aScan(aLotect,{|R| R[1]+R[2] == cPRODUTO+cLotect})) == 0
							aAdd(aLotect,{cPRODUTO,cLotect,xDtValid,_nQtdCxSep})
						Else
							aLotect[nPos][4] += _nQtdCxSep
						Endif
					Next y
				ElseIf ValType(oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM[j]:_DETALHES:_DETALHE) == "O"
					oLotect:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM[j]:_DETALHES:_DETALHE:_NROLOTE
					xLotect := oLotect:TEXT

					oDtValid:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM[j]:_DETALHES:_DETALHE:_DATAVALIDADE
					xDtValid:=oDtValid:TEXT

				Else
					xLotect:=Space(Tamsx3("B8_LOTECTL")[1])
				Endif
			Else
				If ValType(oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM:_DETALHES:_DETALHE) == "A"
					nLenDet := Len(oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM:_DETALHES:_DETALHE)
					aLotect := {}
					For y:= 1 To nLenDet
						oLotect:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM:_DETALHES:_DETALHE[y]:_NROLOTE
						onQtdCxSep:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM:_DETALHES:_DETALHE[y]:_QTDECAIXASEP
						
						oDtValid:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM:_DETALHES:_DETALHE[y]:_DATAVALIDADE
						xDtValid:=oDtValid:TEXT

						cLotect := oLotect:TEXT
						_nQtdCxSep := Val(StrTran(onQtdCxSep:TEXT,",","."))
						//Verifica se o Lote Existe e tem data de validade correto
						//If ( cMsg := vLidaLote(cPRODUTO,cLotect,xDtValid,SC6->C6_LOCAL) ) != "OK"
						//	aAdd(aMsg, {{cPRODUTO, cMsg, Transform(SC6->C6_XQTDREF,PesqPict("SC6","C6_XQTDREF")),Transform(SC6->C6_QTDVEN,PesqPict("SC6","C6_QTDVEN")),SC6->C6_XLTREF,cLotect}})
						//EndIf
						//Aglutina Lotes Iguais				
						If (nPos := aScan(aLotect,{|R| R[1]+R[2] == cPRODUTO+cLotect})) == 0
							aAdd(aLotect,{cPRODUTO,cLotect,xDtValid,_nQtdCxSep})
						Else
							aLotect[nPos][4] += _nQtdCxSep
						Endif
					Next y
				ElseIf ValType(oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM:_DETALHES:_DETALHE) == "O"
					oLotect:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM:_DETALHES:_DETALHE:_NROLOTE
					xLotect := oLotect:TEXT

					oDtValid:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM:_DETALHES:_DETALHE:_DATAVALIDADE
					xDtValid:=oDtValid:TEXT

				Else
					xLotect:=Space(Tamsx3("B8_LOTECTL")[1])
				Endif			
			Endif
		Else
			xLotect:=Space(Tamsx3("B8_LOTECTL")[1])
		Endif
			
		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial("SB1")+cPRODUTO)
		xDescr:=B1_DESC
			
		If Funname()=="MATA311"
			dbSelectArea("NNT")
			dbSetOrder(1)
			If dbSeek(xFilial("NNT")+cResolic+cFilAnt+cPRODUTO,.F.)
				RecLock("NNT",.F.)
				NNT->NNT_XQTREF := NNT->NNT_QUANT
				NNT->NNT_QUANT  := Val(strtran(strtran(xQuant,".",""),",","."))
				NNT->NNT_XLTREF :=NNT->NNT_LOTECT
				NNT->NNT_LOTECT :=xLotect
				NNT->NNT_LOTED  :=xLotect
				NNT->NNT_DTVALI :=CTOD(Substr(xDtValid,1,10))
				NNT->NNT_DTVALD :=CTOD(Substr(xDtValid,1,10))
				MsUnlock()
				
				aAdd(aMsg, {{cPRODUTO, xDescr, Transform(NNT->NNT_XQTREF,PesqPict("NNT","NNT_XQTREF")),Transform(NNT->NNT_QUANT,PesqPict("NNT","NNT_QUANT")),NNT->NNT_XLTREF,xLotect}})
				
			  	MsgAlert("A solicitacao de Transferencia Numero: " + Alltrim(cResolic) + " foi Separada pela Refrio, verifique o seu e-mail para maiores detalhes", "Atencao")


			Endif
		Else
			dbSelectArea("SC6")
			dbSetOrder(2)
			If dbSeek(xFilial("SC6")+cPRODUTO+cResolic,.F.)
				If Len(aLotect) == 0 .Or. Len(aLotect) == 1 
					If Len(aLotect) == 1 
						xLotect := aLotect[1,2]
						xDtValid:= aLotect[1,3]
					Endif

					RecLock("SC6",.F.)
					SC6->C6_XQTDREF:= SC6->C6_QTDVEN
					SC6->C6_QTDVEN := Val(strtran(strtran(xQuant,".",""),",","."))
					SC6->C6_QTDLIB := Val(strtran(strtran(xQuant,".",""),",","."))
					SC6->C6_XLTREF := SC6->C6_LOTECTL
					SC6->C6_LOTECTL:= xLotect
					If Rastro(cProduto)
						SC6->C6_DTVALID:= CTOD(Substr(xDtValid,1,10))
					Endif
					MsUnlock()
					aAdd(aMsg, {{cPRODUTO, xDescr, Transform(SC6->C6_XQTDREF,PesqPict("SC6","C6_XQTDREF")),IIF(Val(xQuant) > 0, Transform(SC6->C6_QTDVEN,PesqPict("SC6","C6_QTDVEN")), "Item Cortado"),SC6->C6_XLTREF,xLotect}})
				ElseIf Len(aLotect) > 1 
					_aStruct := SC6->( dbStruct() )
					_aLinha := {}
					_cPos := ""
					nRECSC6 := SC6->( Recno() )
					aEval(_aStruct,{|R| _cPos:= R[1], aAdd(_aLinha,{Alltrim(_cPos),SC6->&(_cPos)}) } )				

					_cAlias := GetNextAlias()
					BEGINSQL ALIAS _cAlias
						%NOPARSER%
						SELECT MAX(C6_ITEM) NEWITEM FROM %TABLE:SC6% C6 WHERE C6.%NOTDEL% AND C6_FILIAL = %EXP:XFILIAL("SC6")% AND C6_NUM = %EXP:SC6->C6_NUM%
					ENDSQL
					dbSelectArea(_cAlias)
					cItem := SOMA1((_cAlias)->NEWITEM)
					(_cAlias)->( dbCloseArea() )
					/* Retirado por Douglas Silva
					dbSelectArea("SC6")
					dbGoto(nRECSC6)
					RecLock("SC6",.F.,.T.)
						dbDelete()
					MsUnlock()
					*/
					For w:= 1 To Len(aLotect)
						RecLock("SC6",.T.)
						For z:= 1 To Len(_aLinha)
							If _aLinha[z,1] == "C6_ITEM"
								SC6->C6_ITEM := cItem
								cItem := Soma1(cItem)
							
							ElseIf _aLinha[z,1] == "C6_LOTECTL" .Or. _aLinha[z,1] == "C6_XLTREF"
								SC6->&(_aLinha[z,1]) := aLotect[w,2]
							ElseIf _aLinha[z,1] == "C6_QTDLIB" .Or. _aLinha[z,1] == "C6_QTDVEN" .Or. _aLinha[z,1] == "C6_XQTDREF"
								SC6->&(_aLinha[z,1]) := aLotect[w,4]
							
							ElseIf _aLinha[z,1] == "C6_DTVALID"
								SC6->&(_aLinha[z,1]) := CTOD(Substr(aLotect[w,3],1,10))
							Else
								SC6->&(_aLinha[z,1]) := _aLinha[z,2]
							Endif
						Next z
						MsUnlock()
						aAdd(aMsg, {{cPRODUTO, xDescr, Transform(SC6->C6_XQTDREF,PesqPict("SC6","C6_XQTDREF")),IIF(Val(xQuant) > 0, Transform(SC6->C6_QTDVEN,PesqPict("SC6","C6_QTDVEN")), "Item Cortado"),SC6->C6_XLTREF,xLotect}})
					Next w
				Endif
			Endif
		Endif
	Endif
Next j
END TRANSACTION
If !lProc
	RETURN .F.
Endif
If Funname()=="MATA311"
	Reclock("NNS",.F.)
	NNS->NNS_STAREF:="3"
	MsUnlock()
	
	_cSubject:="A solicitacao de Transferencia Numero: " + Alltrim(cResolic) + " foi Separada pela Refrio" + CHR(13) + CHR(10)
	
Else
	DbSelectArea("SC5")
	DbSetOrder(1)
	DbSeek(xFilial("SC5")+cResolic)
	Reclock("SC5",.F.)
	SC5->C5_STAREF:="3"
	MsUnlock()
	
	_cSubject:= "O Pedido de Vendas Numero: " + Alltrim(cResolic) + " foi Separado pela Refrio" + CHR(13) + CHR(10)
	
Endif


U_BLEMNOTF(cRelto,"" ,_cSubject, aMsg,{},.F.)



If Funname()=="MATA311"

	MsgAlert("A solicitacao de Transferencia Numero: " + Alltrim(cResolic) + " foi Separada pela Refrio, verifique o seu e-mail para maiores detalhes", "Atencao")

Else

	MsgAlert("O Pedido de Vendas Numero: " + Alltrim(cResolic) + " foi Separado pela Refrio, verifique o seu e-mail para maiores detalhes", "Atencao")

Endif

// Copia arquivos do servidor para o remote local, sem compactar antes de transmitir
If MV_PAR01 == 1 // 1 leitura via webservice | 2 leitura do arquivo
	If __CopyFile(cArquivo, "\BLCONSPE\LIDO\"+cArquivo)
		FErase(cArqName)
	Endif
Endif

Return
/*
|faz a leitura atraves dos arquivos ja lido
*/
Static Function BLCONPEA()

Local aFiles := {}
Local nCount := nX := 0
Local cDir := "\BLCONSPE\LIDO\"
Local cError := ""
Local cWarning := ""
Local cArqName := ""
Local cPRODUTO := ""
Local cResolic := ""
Local oPRODUTO
Local oQuant
Local xQuant
Local oLotect
Local xLotect
Local oDtValid
Local xDtValid
Local aMsg:={}
Local _cSubject:=""
Local xDescr:=""
//	Chama tela para selecionar Qual arquivo deseja utilizar
Local cArquivo := SelectArq(Directory(cDir+"*.xml", "D"))
cArqName:= cDir+cArquivo
If ! File(cArqName)
	//colocar mensagem com alert de nao ter achado o arquivo
	Return Nil
Endif

oXml := XmlParserFile( cArqName, "_", @cError, @cWarning )

If !Empty(oXml:_RETORNO:_MENSAGEM:TEXT)
	MsgAlert("Sem novos eventos para processar.(Consulta: UNICO)", "Atencao")
	Return Nil
Endif


If valType(oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_NUMERO) <> "O"
	Return .f.
EndIf

cResolic:= oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_NUMERO:TEXT

If Funname()=="MATA311"
	cResolic := STRTRAN(PADL(cResolic,TAMSX3("NNS_COD")[1])," ","0")
Else
	cResolic := STRTRAN(PADL(cResolic,TAMSX3("C5_NUM")[1])," ","0")
Endif

DbSelectArea("SC5")
DbSetOrder(1)
DbSeek(xFilial("SC5")+cResolic)
If !Empty(SC5->C5_NOTA)
	MsgAlert("Esse pedido já encontra-se faturado, foi gerado a Nota: "+SC5->C5_NOTA+" consulta nao permitida!", "Atencao")
	Return
Endif

If ValType(oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS) <> "O"
	Return .F.
Endif

For j:= 1 To Len(oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM)
	oPRODUTO := oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM[j]:_CODPRODUTO
	cPRODUTO := PADR(oPRODUTO:TEXT,TAMSX3("NNT_PROD")[1])
	
	oQuant:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM[j]:_QTDEEMBALAGEMSEP
	xQuant:=oQuant:TEXT
	
	If !Val(xQuant) > 0
		MsgAlert("Por favor verificar junto ao Fornecedor se o Pedido/Solicitacao nao foi estornado, nao existem detalhes para o processamento", "Atencao")
		Exit
		Return
	Endif
	
	
	
	oLotect:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM[j]:_DETALHES:_DETALHE:_NROLOTE
	xLotect:=oLotect:TEXT
	
	oDtValid:=oXml:_RETORNO:_MENSAGEM:_RETORNO_CARGAS:_RETORNO_DOCCARGA:_ITENS:_ITEM[j]:_DETALHES:_DETALHE:_DATAVALIDADE
	xDtValid:=oDtValid:TEXT
	
	
	DbSelectArea("SB1")
	DbSetOrder(1)
	DbSeek(xFilial("SB1")+cPRODUTO)
	xDescr:=B1_DESC
	
	If Funname()=="MATA311"
		
		dbSelectArea("NNT")
		dbSetOrder(1)
		If dbSeek(xFilial("NNT")+cResolic+cFilAnt+cPRODUTO,.F.)
			
			RecLock("NNT",.F.)
			NNT->NNT_XQTREF := NNT->NNT_QUANT
			NNT->NNT_QUANT  := Val(strtran(strtran(xQuant,".",""),",","."))
			NNT->NNT_XLTREF :=NNT->NNT_LOTECT
			NNT->NNT_LOTECT :=xLotect
			NNT->NNT_LOTED  :=xLotect
			NNT->NNT_DTVALI :=CTOD(Substr(xDtValid,1,10))
			NNT->NNT_DTVALD :=CTOD(Substr(xDtValid,1,10))
			MsUnlock()
			
			aAdd(aMsg, {{cPRODUTO, xDescr, Transform(NNT->NNT_XQTREF,PesqPict("NNT","NNT_XQTREF")),Transform(NNT->NNT_QUANT,PesqPict("NNT","NNT_QUANT")),NNT->NNT_XLTREF,xLotect}})
			
		Endif
		
	Else
		dbSelectArea("SC6")
		dbSetOrder(2)
		If dbSeek(xFilial("SC6")+cPRODUTO+cResolic,.F.)
			
			RecLock("SC6",.F.)
			SC6->C6_XQTDREF:= SC6->C6_QTDVEN
			SC6->C6_QTDVEN := Val(strtran(strtran(xQuant,".",""),",","."))
			SC6->C6_QTDLIB := Val(strtran(strtran(xQuant,".",""),",","."))
			SC6->C6_XLTREF := SC6->C6_LOTECTL
			SC6->C6_LOTECTL:= xLotect
			SC6->C6_DTVALID:= CTOD(Substr(xDtValid,1,10))
			MsUnlock()
			
			aAdd(aMsg, {{cPRODUTO, xDescr, Transform(SC6->C6_XQTDREF,PesqPict("SC6","C6_XQTDREF")),Transform(SC6->C6_QTDVEN,PesqPict("SC6","C6_QTDVEN")),SC6->C6_XLTREF,xLotect}})
			
		Endif
	Endif
Next j


If Funname()=="MATA311"
	
	Reclock("NNS",.F.)
	NNS->NNS_STAREF:="3"
	MsUnlock()
	
	_cSubject:="A solicitacao de Transferencia Numero: " + Alltrim(cResolic) + " foi Separada pela Refrio" + CHR(13) + CHR(10)
	
Else
	
	DbSelectArea("SC5")
	DbSetOrder(1)
	DbSeek(xFilial("SC5")+cResolic)
	Reclock("SC5",.F.)
	SC5->C5_STAREF:="3"
	MsUnlock()
	
	_cSubject:= "O Pedido de Vendas Numero: " + Alltrim(cResolic) + " foi Separado pela Refrio" + CHR(13) + CHR(10)
	
Endif

U_BLEMNOTF(cRelto,"" ,_cSubject, aMsg,{},.F.)

Return
/*
TELA PARA SELECAO DE ARQUIVOS XML
*/
Static Function SelectArq(aFiles)
Local aArea := GetArea()
Local cRet := ""
Local oOK := LoadBitmap(GetResources(),'br_verde')
Local oNO := LoadBitmap(GetResources(),'br_vermelho')
Local aBrowse := {}
Local _aHeader := {}
Local _aHeadSize := {}
Local oDlgArq
Local aAux := {}
Local nReg := nPos := 0
Local aRet := {}
Local nOpcao := 0
Local cMensagem := "E necessário selecionar pelo menos um item para confirmar."
Local aArea := GetArea()
Local oCmbo,Font, oBMP
Local oBtn
Local cCmb := ""
Local _cTit := "Selecione Arquivos XML"
Local aOrd := {}
Local nOrd := 1
Local bPesq := {|| }
Local bSort := {|| }

/*
A Tabela C (abaixo), descreve a estrutura do array de retorno:
1 Nome do arquivo
2 Tamanho
3 Data
4 Hora
5 Atributos, exemplo A=Arquivo, D=Diretório
*/
_aHeader:= {"","Arquivo","Data","Hora"}
_aHeadSize := {20,40,20,20}

aEval(aFiles,{|R| aAdd(aBrowse,{.F.,R[1],R[3],R[4]}) })


DEFINE MSDIALOG oDlgArq TITLE _cTit FROM 150,180 TO 550,700 PIXEL

oFont:= oDlgArq:oFont
oBrowse := TWBrowse():New( 30 , 01, 260,184-31,,_aHeader,_aHeadSize,;
oDlgArq,,,,,{||},,,,,,,.F.,,.T.,,.F.,,, )
oBrowse:SetArray(aBrowse)
oBrowse:bLine := {||{If(aBrowse[oBrowse:nAt,01],oOK,oNO),aBrowse[oBrowse:nAt,02],;
aBrowse[oBrowse:nAt,03],aBrowse[oBrowse:nAt,04] } }
// Troca a imagem no duplo click do mouse
oBrowse:bLDblClick := {|| aBrowse[oBrowse:nAt][1] := !aBrowse[oBrowse:nAt][1], oBrowse:DrawSelect(), nOpcao:=1, oDlgArq:End()  }

ACTIVATE MSDIALOG oDlgArq CENTERED ON INIT EnchoiceBar(oDlgArq,;
{||aEval(aBrowse,{|X| If(X[1],nOpcao := 1,Nil) }),If(nOpcao==1,oDlgArq:End(),Alert(cMensagem)) },;
{||nOpcao:=2,oDlgArq:End()},,{})

If nOpcao == 1
	npos := aScan(aBrowse,{|R| R[1] == .T. })
	cRet := aBrowse[nPos,2]
Endif

RestArea(aArea)
Return cRet


Static Function BLSendMail(cAccount,cPassword,cServer,cFrom,cEmail,cAssunto,cMensagem)

Local cEmailTo 	:= ""
Local cEmailBcc	:= ""
Local cEmailTo2 := ""
Local cEmailTo3 := ""
Local lResult  	:= .F.
Local lResult2 	:= .F.
Local lResult3 	:= .F.
Local cError   	:= ""
Local lRet	   	:= .F.
Local cSenha   	:= cPassword
Local aAttach  	:= ""
Local lVenEmail	:= .T.
Local cConta    := Alltrim(SuperGETMV("MV_RELACNT") )
Local cServer   := Alltrim(SuperGETMV("MV_RELSERV"))
Local cSenha    := Alltrim(SuperGETMV("MV_RELPSW"))


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia o mail para a lista selecionada. Envia como BCC para que a pessoa pense³
//³que somente ela recebeu aquele email, tornando o email mais personalizado.   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If At(";",cEmail) > 0 // existe um segundo e-mail.
	cEmailBcc:= SubStr(cEmail,At(";",cEmail)+1,Len(cEmail))
Endif

cEmailTo:= SubStr(cEmail,1,At(";",cEmail)-1)

lResult := MailSmtpOn( cServer, cConta, cSenha, )

// Se a conexao com o SMPT esta ok
If lResult
	
	lRet := Mailauth(cConta,cSenha)
	
	
	If lRet
		
		lResult2 := MailSend( cConta, { cEmailTo }, { }, { cEmailBcc }, cAssunto, cMensagem,, .F. )
		If !lResult2
			//Erro no envio do email
			cError:=MailGetErr( )
		Endif
		
	Else
		cError:=MailGetErr( )
	Endif
	
	MailSmtpOff()  // Disconnect to Smtp Server
	
Else
	//Erro na conexao com o SMTP Server
	cError:=MailGetErr( )
Endif
//EndIf
Return(lResult)
/*Verifica se o lote enviado existe na SB8
/*E esta condizendo o armazem e datda de validade
*/
Static Function vLidaLote(xPRODUTO,xLotect,dDtValid,xLocal)
Local aArea := GetArea()
Local cRet := "OK"

dbSelectArea("SB8")
dbSetOrder(2)
If dbSeek(xFilial("SB8")+xPRODUTO+xLocal+xLotect,.F.)
	If SB8->B8_DTVALID != CTOD(Substr(dDtValid,1,10))
		cRet := "Data de Validade invalida"
	Endif
Else
	cRet := "Lote inexistente"
Endif
RestArea(aArea)
Return cRet
