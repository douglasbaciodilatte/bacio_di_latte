#Include "PROTHEUS.CH"
#Include "Parmtype.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"
#Include "TopConn.ch"

#define eol chr(13)+chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ImpXlsTra Autor ³   Reinaldo Rabelo      ³ Data ³ 26/03/21 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Atualiza lista de Produtos (.CSV)                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs       ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function BDLESTA7() 
Private nOpc      := 0
Private cCadastro := "Atualiza Lista de Produto"
Private aSay      := {}
Private aButton   := {}
Private aLista	  := {}
Private cPerg	  := Padr("IMPCSV",10)
Private nPosProd := 0
Private nPosList := 0
Private aLisAux  := {}
Private cCab     := ""
Private cArq     := ""
lRet := .F.

aAdd( aSay, "O objetivo desta rotina e efetuar a leitura e importacao de um arquivo csv" )

aAdd( aButton, { 1,.T.,{|| nOpc := 1,FechaBatch()}})
aAdd( aButton, { 2,.T.,{|| FechaBatch()}})
//AADD( aButton, { 5,.T.,{|| Pergunte(cPerg,.T. ) } } )

FormBatch( cCadastro, aSay, aButton )

If nOpc == 1
	Processa( {|| lRet:=Import() }, "Importando Arquivo CSV.......")
	If lRet
		Processa( {|| Atualiza(aLista)}, "Atualizando Lista de Produtos...")
	Else
		MsgStop("Atenção Não Foi Possível Efetuar a Leitura Correta do Arquivo de Importação, Verifique !!!")
	EndIf
Endif

Return()


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ Import   ³ Autor ³  Reinaldo Rabelo      ³ Data ³ 26/03/21 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Importa Lista de Precos (.CSV)                             ³±±
±±³          ³ Leitura do CSV e montagem da tabela temporaria             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs       ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Import()
Local cBuffer   := ""
Local cFileOpen := ""
Local cTitulo1  := "Selecione o arquivo"
Local cExtens	:= "Arquivo CSV | *.csv"

/*If Empty(MV_PAR01)
	MsgStop("Por Favor Informe a Qual Transportadora Pertence esta Planilha !")
	Return .f.
Endif
*/

/*
_________________________________________________________
cGetFile(<ExpC1>,<ExpC2>,<ExpN1>,<ExpC3>,<ExpL1>,<ExpN2>)
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
<ExpC1> - Expressao de filtro
<ExpC2> - Titulo da janela
<ExpN1> - Numero de mascara default 1 para *.Exe
<ExpC3> - Diretório inicial se necessário
<ExpL1> - .F. botão salvar - .T. botão abrir
<ExpN2> - Mascara de bits para escolher as opções de visualização do objeto (prconst.ch)
*/
cFileOpen := cGetFile(cExtens,cTitulo1,2,,.T.,GETF_LOCALHARD+GETF_NETWORKDRIVE,.T.)

If !File(cFileOpen)
	MsgAlert("Arquivo texto: "+cFileOpen+" não localizado",cCadastro)
	Return(.F.)
Endif
cArq := cFileOpen
FT_FUSE(cFileOpen)  //ABRIR
FT_FGOTOP() //PONTO NO TOPO
ProcRegua(FT_FLASTREC()) //QTOS REGISTROS LER

cBuffer := FT_FREADLN() //LENDO LINHA

cCab	:= cBuffer
aDados  := Separa(cBuffer,";",.T.)

nPosProd := aScan(aDados, {|x| upper(Alltrim(x)) == "PRODUTO" })
nPosList := aScan(aDados, {|x| upper(Alltrim(x)) == "LISTA" })

if nPosProd == 0 .or.  nPosList == 0
	Alert("Arquivo com Layout invalido...")
    Return .F.
Endif

FT_FSKIP()   //proximo registro no arquivo txt

While !FT_FEOF()  //FACA ENQUANTO NAO FOR FIM DE ARQUIVO
	IncProc()
	
	
	// Capturar dados
	cBuffer := FT_FREADLN() //LENDO LINHA
	
	aDados := Separa(cBuffer,";",.T.)
    if len(aDados) > 0	
		AAdd(aLista,{aDados[nPosProd],aDados[nPosList]})
		AAdd(aLisAux,aDados)
	endif
	FT_FSKIP()   //proximo registro no arquivo txt
EndDo

FT_FUSE() //fecha o arquivo txt

Return(!Empty(aLista))


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ Atualiza ³    Reinaldo Rabelo             ³ Data ³ 26/03/21³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Importa Lista PRODUTO (.CSV)                               ³±±
±±³          ³ Atualiza o campo B1_XLISTA                               . ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Obs       ³                                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Atualiza(aLista)
Local aArea := GetArea()
//Local aOcorre := {}
Local nI := 0
Local cOcorr := ""

If !MsgYesNo("Confirma o Processamento da Lista de Produto ?")
	Return .f.
Endif

aRoteiros	:=	{}

ProcRegua(Len(aLista)) 
For nI := 1 To Len(aLista)
	IncProc('Processando Lista...')
	dbSelectArea("SB1")
	DbSetOrder(1)
	
	IF SB1->(DbSeek(xFilial("SB1")+aLista[nI,1])) .or. aLista[nI,2]$"1/2"
		RecLock("SB1",.F.)
		SB1->B1_XLISTA := aLista[nI,2]
		SB1->(MsUnLock())
	else
		if Empty(cOcorr) 
			cOcorr :=  cCab + eol
		EndIf
		for nX := 1 to len(aLisAux[nI])  
			cOcorr += aLisAux[nI,nX]+";"
		Next nX
		cOcorr := substr(cOcorr,1,len(cOcorr)-1) +eol 
		//cOcorr += eol 
	EndIf
	
Next nI
SB1->(dbgotop())
SET FILTER TO SB1->B1_XLISTA == " " .AND. SB1->B1_FILIAL == xFilial("SB1")

WHILE !(SB1->(eof()))
	RecLock("SB1",.F.)
		SB1->B1_XLISTA := "1"
		SB1->(MsUnLock())
	SB1->(DBSKIP())
EndDo

SET FILTER TO
if !Empty(cOcorr)
	cArq := substr(cArq,1,rat("\",cArq) )
	memowrite(cArq +"Prouto_erro.csv",cOcorr)
	MsgStop("Atenção alguns Produtos não foram encontrado!" + eol + "Verifique o arquivo: " + cArq + "Prouto_erro.csv" )
endif
RestArea(aArea)

Return .t.


