#Include "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BDLESTR01 ºAutor  ³Renan Paiva         º Data ³  20/04/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio dos itens da nota fiscal por centro de custo     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio di Latte                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function BDLSKR01()

Local oReport
Private cPerg 	:= "BDLESTR01 "
Private cAlias  := GetNextAlias()

If TRepInUse()          
	AdjSx1()   
	Pergunte(cPerg, .T.)
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	MsgInfo("TREPORT","Relatório disponível somente em TREPORT")
EndIf
Return

*****************************************************************
//Monta a sessao do TReport definindo as celulas para impressao
*****************************************************************
Static Function ReportDef()

Local oReport
Local oSection1
Local oSection2

oReport := TReport():New(cPerg,"Itens das Notas Fiscais por Centro de Custo",cPerg,{|oReport| PrintReport(oReport)},"Este relatório exibirá os itens das notas fiscais por centro de custo conforme os parametros definidos pelo usuário")
oSection1 := TRSection():New(oReport,OemToAnsi("Centro de Custo"),{cAlias})	

TRCell():New(oSection1,"D1_CC")
TRCell():New(oSection1,"CTT_DESC01")

oSection2 := TRSection():New(oSection1,OemToAnsi("Movimentações"),{cAlias})	
TRCell():New(oSection2,"D1_COD")
TRCell():New(oSection2,"B1_DESC")
TRCell():New(oSection2,"D1_FORNECE")
TRCell():New(oSection2,"D1_LOJA")
TRCell():New(oSection2,"A2_NREDUZ")
TRCell():New(oSection2,"D1_SERIE")
TRCell():New(oSection2,"D1_DOC")   
TRCell():New(oSection2,"D1_DTDIGIT")
TRCell():New(oSection2,"D1_QUANT")
TRCell():New(oSection2,"D1_VUNIT")
TRCell():New(oSection2,"D1_TOTAL")
TRCell():New(oSection2,"D1_CUSTO")
TRCell():New(oSection2,"D1_CF")
TRCell():New(oSection2,"X5_DESCRI",,"DESC CFOP","@!",50)

Return oReport
      
**************************************************************
//Rotina para impressao do relatorio
**************************************************************
Static Function PrintReport(oReport)

Local oSection1 	:= oReport:Section(1) //Inicializa a primeira sessao do treport 
Local oSection2 	:= oReport:Section(1):Section(1) //Inicializa a primeira sessao do treport
Local nRecTot  		:= 0                         
Local cCCusto		:= ""

MSAguarde( {|| ObtDados()}, "Aguarde" ,"Obtendo dados ...",.F.)

oSection1:Cell("D1_CC"  ):SetBlock({ || (cAlias)->D1_CC   })
oSection1:Cell("CTT_DESC01" ):SetBlock({ || (cAlias)->CTT_DESC01  })

oSection2:Cell("D1_COD"):SetBlock({ || (cAlias)->D1_COD })
oSection2:Cell("B1_DESC"):SetBlock({ || (cAlias)->B1_DESC })
oSection2:Cell("D1_FORNECE"):SetBlock({ || (cAlias)->D1_FORNECE })
oSection2:Cell("D1_LOJA"):SetBlock({|| (cAlias)->D1_LOJA })
oSection2:Cell("A2_NREDUZ"):SetBlock({|| (cAlias)->A2_NREDUZ })
oSection2:Cell("D1_SERIE"):SetBlock({|| (cAlias)->D1_SERIE })
oSection2:Cell("D1_DOC"):SetBlock({|| (cAlias)->D1_DOC })
oSection2:Cell("D1_DTDIGIT"):SetBlock({|| (cAlias)->D1_DTDIGIT })
oSection2:Cell("D1_QUANT"):SetBlock({|| (cAlias)->D1_QUANT })
oSection2:Cell("D1_VUNIT"):SetBlock({|| (cAlias)->D1_VUNIT })
oSection2:Cell("D1_TOTAL"):SetBlock({|| (cAlias)->D1_TOTAL })
oSection2:Cell("D1_CUSTO"):SetBlock({|| (cAlias)->D1_CUSTO })
oSection2:Cell("D1_CF"):SetBlock({|| (cAlias)->D1_CF })
oSection2:Cell("X5_DESCRI"):SetBlock({|| (cAlias)->X5_DESCRI })
                         
oBreak1 := TRBreak():New(oSection2,{||(cAlias)->(D1_CC)},"Total Centro de Custo",.F.) 
TRFunction():New(oSection2:Cell("D1_TOTAL"),NIL,"SUM",oBreak1,,,,.F.,.F.)
TRFunction():New(oSection2:Cell("D1_CUSTO"),NIL,"SUM",oBreak1,,,,.F.,.F.)

dbSelectArea(cAlias)
Count To nRecTot
dbGoTop()      

oReport:SetMeter(nRecTot)

While !Eof()
	If oReport:Cancel()
		Exit
	EndIf
	oSection1:Init()
	oSection1:PrintLine()     
	oSection2:Init()
	cCCusto := (cAlias)->D1_CC	
	While !Eof() .And. (cAlias)->D1_CC == cCCusto
		If oReport:Cancel()
			Exit
		EndIf
		oSection2:PrintLine()
		oReport:IncMeter()
		dbSkip()
	EndDo    
	oSection1:Finish()
	oSection2:Finish()
	dbSelectArea(cAlias)
EndDo                   

(cAlias)->(dbCloseArea())

Return
                                                              
**************************************************************
//cria as perguntas do relatorio
**************************************************************
Static Function ObtDados()
                                                             
Local cNotTipo := Iif(LEN(ALLTRIM(MV_PAR09))>1,"% AND B1_TIPO IN " + FormatIn(MV_PAR09, ";") + "%", "% %")

BeginSql Alias cAlias                          
	COLUMN D1_DTDIGIT AS DATE
	COLUMN D1_QUANT AS NUMERIC(18,2)
	COLUMN D1_VUNIT AS NUMERIC(18,6)
	COLUMN D1_TOTAL AS NUMERIC(18,2)
	COLUMN D1_CUSTO AS NUMERIC(18,2)
	%noparser%
	SELECT D1_COD, 
		   B1_DESC, 
		   D1_CC, 
		   CTT_DESC01, 
		   D1_FORNECE, 
		   D1_LOJA, 
		   A2_NREDUZ, 
		   D1_SERIE, 
		   D1_DOC,       
		   D1_DTDIGIT,
		   D1_QUANT, 
		   D1_VUNIT, 
		   D1_TOTAL ,
		   D1_CUSTO, 
		   D1_CF, 
		   X5_DESCRI
	FROM %Table:SD1% D1
	LEFT JOIN %Table:CTT% TT
	ON D1.D1_CC = TT.CTT_CUSTO
	AND TT.%NotDel%
	JOIN %Table:SF4% F4
	ON D1.D1_TES = F4.F4_CODIGO
	AND (%exp:MV_PAR07% = 1 OR F4_ESTOQUE = 'S' AND %exp:MV_PAR07% = 2 OR F4_ESTOQUE='N' AND %exp:MV_PAR07% = 3)
	AND (%exp:MV_PAR08% = 1 OR F4_DUPLIC = 'S' AND %exp:MV_PAR08% = 2 OR F4_DUPLIC = 'N' AND %exp:MV_PAR08% = 3)
	AND F4.%NotDel%
	JOIN %Table:SB1% B1
	ON D1.D1_COD = B1.B1_COD
	%exp:cNotTipo%
	AND B1.%NotDel%
	JOIN %Table:SX5% X5
	ON X5_TABELA = '13'
	AND D1.D1_CF = X5_CHAVE
	AND X5.%NotDel%
	JOIN %Table:SA2% A2
	ON D1.D1_FORNECE = A2.A2_COD
	AND D1.D1_LOJA = A2.A2_LOJA
	AND A2.%NotDel%
	WHERE 
	D1.D1_FILIAL BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02%
	AND D1.D1_DTDIGIT BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06%
	AND D1.%NotDel%
	ORDER BY D1_CC, D1_COD, D1_DTDIGIT           
EndSql

Return
**************************************************************
//cria as perguntas do relatorio
**************************************************************
Static Function AdjSx1()

Local _aPerg  := {}
Local _ni

Aadd(_aPerg,{"Filial De ?","mv_ch1","C",4,0,"G","","mv_par01","","","","SM0",""})
Aadd(_aPerg,{"Filial Até ?","mv_ch2","C",4,0,"G","","mv_par02","","","","SM0",""})
Aadd(_aPerg,{"C. Custo De ","mv_ch3","C",9,0,"G","","mv_par03","","","","CTT",""})
Aadd(_aPerg,{"C. Custo Até ?","mv_ch4","C",9,0,"G","","mv_par04","","","","CTT",""})
Aadd(_aPerg,{"Dt. Digitação De ?","mv_ch5","D",8,0,"G","","mv_par05","","","","",""})
Aadd(_aPerg,{"Dt. Digitação Até ?","mv_ch6","D",8,0,"G","","mv_par06","","","","",""})    
Aadd(_aPerg,{"Quanto ao Estoque ?","mv_ch7","C",1,0,"C","","mv_par07","Ambos","Movimenta","Não Movimenta","",""})    
Aadd(_aPerg,{"Quanto ao Financeiro ?","mv_ch8","C",1,0,"C","","mv_par08","Ambos","Gera","Não Gera","",""})    
Aadd(_aPerg,{"Excluir TPs Prod. ?","mv_ch9","C",40,0,"G","","mv_par09","","","","",""})

dbSelectArea("SX1")
For _ni := 1 To Len(_aPerg)
	If !dbSeek(cPerg+StrZero(_ni,2))
		RecLock("SX1",.T.)
		SX1->X1_GRUPO    := cPerg
		SX1->X1_ORDEM    := StrZero(_ni,2)
		SX1->X1_PERGUNT  := _aPerg[_ni][1]
		SX1->X1_PERSPA   := _aPerg[_ni][1]
		SX1->X1_PERENG   := _aPerg[_ni][1]
		SX1->X1_VARIAVL  := _aPerg[_ni][2]
		SX1->X1_TIPO     := _aPerg[_ni][3]
		SX1->X1_TAMANHO  := _aPerg[_ni][4]
		SX1->X1_DECIMAL  := _aPerg[_ni][5]
		SX1->X1_GSC      := _aPerg[_ni][6]
		SX1->X1_VALID	 := _aPerg[_ni][7]
		SX1->X1_VAR01    := _aPerg[_ni][8]
		SX1->X1_DEF01    := _aPerg[_ni][9]
		SX1->X1_DEFSPA1  := _aPerg[_ni][9]
		SX1->X1_DEFENG1  := _aPerg[_ni][9]
		SX1->X1_DEF02    := _aPerg[_ni][10]
		SX1->X1_DEFSPA2  := _aPerg[_ni][10]
		SX1->X1_DEFENG2  := _aPerg[_ni][10]
		SX1->X1_DEF03    := _aPerg[_ni][11]
		SX1->X1_DEFSPA3  := _aPerg[_ni][11]
		SX1->X1_DEFENG3  := _aPerg[_ni][11]
		SX1->X1_F3       := _aPerg[_ni][12]
		SX1->X1_CNT01    := _aPerg[_ni][13]
		MsUnLock()
	EndIf
Next _ni

Return