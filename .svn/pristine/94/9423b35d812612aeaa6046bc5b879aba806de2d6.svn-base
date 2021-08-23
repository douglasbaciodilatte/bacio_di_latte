#INCLUDE "blcomr14.CH"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun??o    ³ blcomr14  ³ Autor ³Alexandre Inacio Lemes ³ Data ³03/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri??o ³ Emiss?o da Rela??o de Divergencias de Pedidos de Compras   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ blcomr14(void)                                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function blcomr14()

Local oReport

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ ReportDef³Autor  ³Alexandre Inacio Lemes ³Data  ³03/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri??o ³ Emiss?o da Rela??o de Divergencias de Pedidos de Compras   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ oExpO1: Objeto do relatorio                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local cTitle   := STR0001 //"Relacao de Divergencias de Pedidos de Compras"
Local oReport 
Local oSection1

Local cAliasSD1 := GetNextAlias()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                                   ³
//³ mv_par01 // a partir da data de recebimento                            ³
//³ mv_par02 // ate a data de recebimento                                  ³
//³ mv_par03 // Lista itens Pedido - Que constam na NF / todos os itens    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte("MTR130",.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= TReport():New("MTR130",cTitle,"MTR130", {|oReport| ReportPrint(oReport,cAliasSD1)},STR0002+" "+STR0003) //"Emissao da Relacao de Itens para Compras com divergencias"
oReport:SetLandscape() 
oReport:nDevice := 4
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatorio. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de codigo para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1:= TRSection():New(oReport,STR0016,{"SD1","SF1","SA2","SB1"},/*aOrdem*/)
oSection1:SetHeaderPage()                                

TRCell():New(oSection1,"D1_DOC"    ,"SD1",/*Titulo*/,/*Picture*/,MAX(TamSX3("C7_NUM")[1],TamSX3("D1_DOC")[1]),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D1_EMISSAO","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D1_FORNECE","SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D1_LOJA"   ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"A2_NOME"   ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D1_COD"    ,"SD1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_DESC","SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"B1_UM"     ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D1_QUANT"  ,"SD1",/*Titulo*/,"@E 999,999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D1_VUNIT"  ,"SD1",/*Titulo*/,"@E 999,999,999,999.99",,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"D1_TOTAL"  ,"SD1",/*Titulo*/,"@E 999,999,999,999.99",,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"F1_DTDIGIT","SF1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"E4_COND"   ,"   ","Cond. Pag.",/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| getAdvFVal("SE4", "E4_COND", xFilial("SE4") + SF1->F1_COND, 1, "") })

oSection2:= TRSection():New(oSection1,STR0017,{"SC7","SA2","SB1"}) 
oSection2:SetHeaderPage()

TRCell():New(oSection2,"C7_NUM"    ,"SC7",/*Titulo*/,/*Picture*/,MAX(TamSX3("C7_NUM")[1],TamSX3("D1_DOC")[1]),/*lPixel*/,/*{|| code-block de impressao }*/)   
TRCell():New(oSection2,"C7_EMISSAO","SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"C7_FORNECE","SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"C7_LOJA"   ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"A2_NOME"   ,"SA2",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"C7_PRODUTO","SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"B1_DESC","SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"B1_UM"     ,"SB1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"C7_QUANT"  ,"SC7",/*Titulo*/,"@E 999,999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"VALUNIT"   ,"   ",/*Titulo*/,"@E 999,999,999,999.99",/*Tamanho*/,/*lPixel*/,{|| ROUND(nValorSC7,2) })
TRCell():New(oSection2,"TOTALIT"   ,"   ","Vlr. Total","@E 999,999,999,999.99",/*Tamanho*/,/*lPixel*/,{|| SC7->C7_QUANT * nValorSC7 })
TRCell():New(oSection2,"C7_DATPRF" ,"SC7",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"E4_COND"   ,"   ","Cond. Pag.",/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| getAdvFVal("SE4", "E4_COND", xFilial("SE4") + SC7->C7_COND, 1, "") })

oSection1:Cell("D1_FORNECE"):GetFieldInfo("C7_FORNECE")
oSection1:Cell("D1_QUANT"):GetFieldInfo("C7_QUANT")
oSection1:Cell("F1_DTDIGIT"):GetFieldInfo("C7_DATPRF")
//oSection2:Cell("VALUNIT"):GetFieldInfo("C7_PRECO")
//oSection2:Cell("VALUNIT"):SetSize(TamSX3("C7_PRECO")[1]+4)

oSection2:Cell("C7_NUM"):HideHeader()
oSection2:Cell("C7_EMISSAO"):HideHeader()
oSection2:Cell("C7_FORNECE"):HideHeader()
oSection2:Cell("C7_LOJA"):HideHeader()
oSection2:Cell("A2_NOME"):HideHeader()
oSection2:Cell("C7_PRODUTO"):HideHeader()
oSection2:Cell("B1_DESC"):HideHeader()
oSection2:Cell("B1_UM"):HideHeader()
oSection2:Cell("C7_QUANT"):HideHeader()
oSection2:Cell("VALUNIT"):HideHeader()
oSection2:Cell("TOTALIT"):HideHeader()
oSection2:Cell("C7_DATPRF"):HideHeader()
oSection2:Cell("E4_COND"):HideHeader()

oSection1:SetNoFilter("SB1")
oSection1:SetNoFilter("SA2")
oSection1:SetNoFilter("SF1")
oSection2:SetNoFilter("SB1")
oSection2:SetNoFilter("SA2")
 
Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³Alexandre Inacio Lemes ³Data  ³03/07/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri??o ³ Emiss?o da Rela??o de Divergencias de Pedidos de Compras   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAliasSD1)

Local oSection1  := oReport:Section(1) 
Local oSection2  := oReport:Section(1):Section(1)  
Local dDataSav   := ctod("")
Local aItPcNotNF := {}
Local cCondPagto := ""
Local cNumPcSD1  := ""
Local cItemPcSD1 := ""

Local nExiste    := 0
Local nX         := 0

Private nValorSC7:= 0

dbSelectArea("SC7")
dbSetOrder(1)

dbSelectArea("SF1")
dbSetOrder(1)

dbSelectArea("SD1")
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³	
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:Section(1):BeginQuery()	

BeginSql Alias cAliasSD1

SELECT D1_FILIAL,D1_DOC,D1_SERIE,D1_FORNECE,D1_LOJA,D1_COD,D1_ITEM,D1_EMISSAO,D1_DTDIGIT,D1_QUANT,D1_VUNIT,
           D1_TIPODOC,D1_SERIREM,D1_REMITO,D1_ITEMREM,D1_PEDIDO,D1_ITEMPC,D1_TIPO,F1_FILIAL,F1_DOC,F1_SERIE,
           F1_FORNECE,F1_LOJA,F1_COND,F1_EMISSAO,F1_TIPO,F1_DTDIGIT 
         	
FROM %table:SD1% SD1, %table:SF1% SF1

WHERE D1_FILIAL = %xFilial:SD1% AND 
  		  D1_DTDIGIT >= %Exp:Dtos(mv_par01)% AND 
	  D1_DTDIGIT <= %Exp:Dtos(mv_par02)% AND 
  	  D1_TIPO = 'N' AND
	  D1_LOCAL = D1_CC AND
	  SD1.%NotDel% AND
	  F1_FILIAL = %xFilial:SF1% AND 
	  F1_DOC = D1_DOC AND
	  F1_SERIE = D1_SERIE AND
	  F1_FORNECE = D1_FORNECE AND
	  F1_LOJA = D1_LOJA AND
  		  SF1.%NotDel% 
	  
ORDER BY %Order:SD1% 
		
EndSql 

oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)


TRPosition():New(oSection1,"SB1",1,{|| xFilial("SB1") + (cAliasSD1)->D1_COD })
TRPosition():New(oSection1,"SA2",1,{|| xFilial("SA2") + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA })

oReport:SetMeter(SD1->(LastRec()))
dbSelectArea(cAliasSD1)

If cPaisLoc == "BRA"
	
	While !oReport:Cancel() .And. !(cAliasSD1)->(Eof())
		
		oReport:IncMeter()
		If oReport:Cancel()
			Exit
		EndIf
		
		dDataSav  := dDataBase
		dDataBase := (cAliasSD1)->D1_DTDIGIT
		
		cDoc := (cAliasSD1)->D1_DOC + (cAliasSD1)->D1_SERIE + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA
		
		If mv_par03 == 2 .And. !Empty((cAliasSD1)->D1_PEDIDO)
			nExiste := aScan(aItPcNotNF,{|x| x[1] == (cAliasSD1)->D1_PEDIDO })
			If nExiste == 0
				dbSelectArea("SC7")
				dbSetOrder(14)
				If dbSeek(xFilEnt(xFilial("SC7"))+(cAliasSD1)->D1_PEDIDO,.F.)
					SA2->(dbSetOrder(1))
					SA2->(dbSeek(xFilial("SA2")+SC7->C7_FORNECE+SC7->C7_LOJA))
					
					While SC7->C7_NUM == (cAliasSD1)->D1_PEDIDO
						aadd(aItPcNotNF,{ SC7->C7_NUM,SC7->C7_FORNECE,SC7->C7_LOJA,SC7->C7_ITEM,SC7->C7_PRODUTO,;
						SA2->A2_NOME,SC7->C7_COND,SC7->C7_EMISSAO,;
						SC7->C7_UM,SC7->C7_QUANT,SC7->C7_PRECO,SC7->C7_DATPRF })
						dbSelectArea("SC7")
						dbSkip()
					EndDo
				EndIf
			Endif
		EndIf
		
		dbSelectArea("SC7")
		SC7->(dbSetOrder(19))       
		If dbSeek(xFilEnt(xFilial("SC7"))+(cAliasSD1)->D1_COD+(cAliasSD1)->D1_PEDIDO+(cAliasSD1)->D1_ITEMPC,.F.)
			nValorSC7 := Round(IIf(Empty(SC7->C7_REAJUST),xMoeda(SC7->C7_PRECO,SC7->C7_MOEDA,1,(cAliasSD1)->D1_EMISSAO,2,SC7->C7_TXMOEDA),Formula(SC7->C7_REAJUST)), 2)
			
			cCondPagto := (cAliasSD1)->F1_COND
			
			If SC7->C7_COND  <> cCondPagto .Or. SC7->C7_DATPRF <> (cAliasSD1)->D1_DTDIGIT .Or. ;
				SC7->C7_QUANT <> (cAliasSD1)->D1_QUANT .Or. nValorSC7 <> (cAliasSD1)->D1_VUNIT
				
				oSection1:Init()
				oSection1:PrintLine()
				oSection2:Init()
				oSection2:PrintLine()
				
				oSection1:Finish()
			EndIf
			
			If mv_par03 == 2 .And. !Empty((cAliasSD1)->D1_PEDIDO)
				nExiste := ascan(aItPcNotNF,{|x| x[1]+x[2]+x[3]+x[4]+x[5]==SC7->C7_NUM+SC7->C7_FORNECE+SC7->C7_LOJA+SC7->C7_ITEM+SC7->C7_PRODUTO})
				If nExiste > 0
					aDel(aItPcNotNF,nExiste)
					aSize(aItPcNotNF,len(aItPcNotNF)-1)
				EndIf
			EndIf
			
		Else
			
			oSection1:Init()
			oSection1:PrintLine()
			oReport:PrintText(STR0010,,oSection1:Cell("D1_DOC"):ColPos()) // "Nao ha' pedido de compra colocado"
			oSection1:Finish()
			
		EndIf
		
		dDataBase := dDataSav
		
		dbSelectArea(cAliasSD1)
		dbSkip()
		
		If mv_par03 == 2 .And. cDoc <> (cAliasSD1)->D1_DOC + (cAliasSD1)->D1_SERIE + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA
			
			If Len(aItPcNotNF) > 0
				
				oReport:FatLine()
				oReport:PrintText(STR0015+" "+Substr(cDoc,1,6),,oSection1:Cell("D1_DOC"):ColPos()) // "Itens do(s) pedido(s) que nao constam na Nota Fiscal "
				
				For nX :=1 to Len(aItPcNotNF)
					
					oReport:PrintText(aItPcNotNF[nX,01]+" "+aItPcNotNF[nX,04]+"  "+dtoc(aItPcNotNF[nX,08])+space(6)+;
					aItPcNotNF[nX,02]+space(08)+aItPcNotNF[nX,03]+space(05)+aItPcNotNF[nX,06]+space(11)+;
					aItPcNotNF[nX,05]+space(05)+aItPcNotNF[nX,09]+space(08)+TransForm(aItPcNotNF[nX,10],"@E 999,999,999.99")+;
					space(05)+TransForm(aItPcNotNF[nX,11],"@E 999,999,999.99")+space(05)+dtoc(aItPcNotNF[nX,12])+;
					space(07)+aItPcNotNF[nX,07],,oSection1:Cell("D1_DOC"):ColPos())
					
				Next nX
				
				oReport:FatLine()
				oReport:SkipLine()
				
				aItPcNotNF := {}
				
			EndIf
			
		EndIf
		
	EndDo
	
Else
	
	While !oReport:Cancel() .And. !(cAliasSD1)->(Eof())
		
		oReport:IncMeter()
		If oReport:Cancel()
			Exit
		EndIf
		
		If IsRemito(1,(cAliasSD1)+"->D1_TIPODOC")
			dBSkip()
			Loop
		Endif
		
		If !Empty((cAliasSD1)->D1_REMITO)

			aArea := GetArea()
			dbSelectArea("SD1")
			dbSetOrder(1)
			dbSeek(xFilial("SD1")+ (cAliasSD1)->D1_REMITO + (cAliasSD1)->D1_SERIREM + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA + (cAliasSD1)->D1_COD + (cAliasSD1)->D1_ITEMREM )
			cNumPcSD1  := SD1->D1_PEDIDO
			cItemPcSD1 := SD1->D1_ITEMPC
			RestArea(aArea)

		Else
			cNumPcSD1  := (cAliasSD1)->D1_PEDIDO
			cItemPcSD1 := (cAliasSD1)->D1_ITEMPC
		Endif
		
		dDataSav  := dDataBase
		dDataBase := (cAliasSD1)->D1_DTDIGIT
		
		cDoc := (cAliasSD1)->D1_DOC + (cAliasSD1)->D1_SERIE + (cAliasSD1)->D1_FORNECE + (cAliasSD1)->D1_LOJA
		
		dbSelectArea("SC7")
		SC7->(dbSetOrder(1))
		If dbSeek(xFilial("SC7")+cNumPcSD1+cItemPcSD1)
			
			nValorSC7 := Round(IIf(Empty(SC7->C7_REAJUST),xMoeda(SC7->C7_PRECO,SC7->C7_MOEDA,1,(cAliasSD1)->D1_EMISSAO,2,SC7->C7_TXMOEDA),Formula(SC7->C7_REAJUST)), 2)
			
			cCondPagto := (cAliasSD1)->F1_COND
			
			If SC7->C7_COND  <> cCondPagto .Or. SC7->C7_DATPRF <> (cAliasSD1)->D1_DTDIGIT .Or. ;
				SC7->C7_QUANT <> (cAliasSD1)->D1_QUANT .Or. nValorSC7 <> (cAliasSD1)->D1_VUNIT
				
				oSection1:Init()
				oSection1:PrintLine()
				oSection2:Init()
				oSection2:PrintLine()
				
				oSection1:Finish()
			EndIf
			
		Else
			
			oSection1:Init()
			oSection1:PrintLine()
			oReport:PrintText(STR0010,,oSection1:Cell("D1_DOC"):ColPos()) // "Nao ha' pedido de compra colocado"
			oSection1:Finish()
			
		EndIf
		
		dDataBase := dDataSav
		
		dbSelectArea(cAliasSD1)
		dbSkip()
		
	EndDo
	
EndIf

oSection2:Finish()	

Return Nil
