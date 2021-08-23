/*//#########################################################################################
Modulo  : Estoque
Fonte   : blestr12
Objetivo: Exibir a produção por Produto em uma matrix dia a dia
*///#########################################################################################

#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

/*/{Protheus.doc} blestr12
   Gerenciador de Processamento
   @author  Nome
   @table   Tabelas
   @since   14-02-2019
/*/
User Function BLESTR12()
    Local cPergRel := PadR('BLESTR12',10)
    Local oReport
    
    private ccAlias := getNextAlias()    
    private _dDataDe
    private _dDataAte

    xCriaPerg(cPergRel)

    Pergunte(cPergRel,.T.)

    oReport := xPrintRel(ccAlias,cPergRel)
    oReport:PrintDialog()

Return

/*/{Protheus.doc} xPrintRel
   Imprimir Relatório
   @author  Nome
   @table   Tabelas
   @since   14-02-2019
/*/
Static Function xPrintRel(ccAlias,cPerg)

    local oReport
    local oSection1

    oReport    := TReport():New(cPerg,'Produções do Mês',cPerg,{|oReport|ReportPrint(oReport,ccAlias)},'')
    oReport:SetLandScape()
    oReport:SetTotalInLine(.F.)
    oReport:nDevice := 4 //Planilha como default    

    oSection1 := TRSection():New(oReport)
    oSection1:SetTotalInLine(.F.)

    TRCell():New(oSection1,"DESCRICAO",ccAlias, "Descrição", "@!", 40)
    TRCell():New(oSection1,"D1",ccAlias, "1", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D2",ccAlias, "2", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D3",ccAlias, "3", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D4",ccAlias, "4", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D5",ccAlias, "5", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D6",ccAlias, "6", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D7",ccAlias, "7", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D8",ccAlias, "8", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D9",ccAlias, "9", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D10",ccAlias, "10", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D11",ccAlias, "11", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D12",, "12", "@E 999,999,999.99", 15,,{|| (ccAlias)->D12},/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D13",ccAlias, "13", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D14",ccAlias, "14", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D15",ccAlias, "15", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D16",ccAlias, "16", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D17",ccAlias, "17", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D18",ccAlias, "18", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D19",ccAlias, "19", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D20",ccAlias, "20", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D21",ccAlias, "21", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D22",ccAlias, "22", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D23",ccAlias, "23", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D24",ccAlias, "24", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D25",ccAlias, "25", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D26",ccAlias, "26", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D27",ccAlias, "27", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D28",ccAlias, "28", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D29",ccAlias, "29", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D30",ccAlias, "30", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"D31",ccAlias, "31", "@E 999,999,999.99", 15,/*lpixel*/,/*code block*/,/*align*/,/*line break*/,"RIGHT")
    TRCell():New(oSection1,"TOTAL",, "Total", "@E 999,999,999.99", 15,,{|| xGetTotInLine()},/*align*/,/*line break*/,"RIGHT")


    oBrkTot := TRBreak():New( oSection1, { || (ccAlias)->(!EOF()) }, "Total Produzido", )

    TRFunction():New( oSection1:Cell("D1")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D2")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D3")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D4")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D5")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D6")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D7")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D8")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D9")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D10")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D11")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D12")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D13")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D14")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D15")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D16")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D17")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D18")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D19")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D20")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D21")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D22")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D23")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D24")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D25")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D26")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D27")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D28")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D29")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D30")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("D31")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)
    TRFunction():New( oSection1:Cell("TOTAL")	, ,"SUM", oBrkTot,/*Titulo*/,,,.F.,.F.,.F.,oSection1)


Return oReport


/*/{Protheus.doc} ReportPrint
   Montar query e abrir em tabela temporária
   @author  Renan Paiva
   @table   SD3, SB1
   @since   14-02-2019
/*/
static function ReportPrint(oReport, ccAlias,cOrdem)
    
    local oSection1b := oReport:Section(1)    
    local i := 0    
    local _nMaxDia 
    local _oCell
    local _cTitulo
    local _oFont
    
    _dDataDe := StoD(MV_PAR02 + strzero(val(MV_PAR01),2) + "01")
    _dDataAte := LastDay(_dDataDe)
    _nMaxDia := Day(_dDataAte)
    
    oReport:SetTitle("Produções do Mês - " + {"Janeiro", "Fevereiro", "Março", "Abril", "Março", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"}[Month(_dDataAte)] + "/" + Str(Year(_dDataAte)))
    

    //desabilita as celulas fora do periodo
    for i := _nMaxDia + 1 to 31
        _oCell := oSection1b:Cell(("D" + AllTrim(Str(i)))):Disable()             
    next

    oSection1b:BeginQuery()
    BeginSQL Alias ccAlias        
        %noparser%
         SELECT 
            DESCRICAO,
            ISNULL(D1, 0) D1,
            ISNULL(D2, 0) D2,
            ISNULL(D3, 0) D3,
            ISNULL(D4, 0) D4,
            ISNULL(D5, 0) D5,
            ISNULL(D6, 0) D6,
            ISNULL(D7, 0) D7,
            ISNULL(D8, 0) D8,
            ISNULL(D9, 0) D9,
            ISNULL(D10, 0) D10,
            ISNULL(D11, 0) D11,
            ISNULL(D12, 0) D12,
            ISNULL(D13, 0) D13,
            ISNULL(D14, 0) D14,
            ISNULL(D15, 0) D15,
            ISNULL(D16, 0) D16,
            ISNULL(D17, 0) D17,
            ISNULL(D18, 0) D18,
            ISNULL(D19, 0) D19,
            ISNULL(D20, 0) D20,
            ISNULL(D21, 0) D21,
            ISNULL(D22, 0) D22,
            ISNULL(D23, 0) D23,
            ISNULL(D24, 0) D24,
            ISNULL(D25, 0) D25,
            ISNULL(D26, 0) D26,
            ISNULL(D27, 0) D27,
            ISNULL(D28, 0) D28,
            ISNULL(D29, 0) D29,
            ISNULL(D30, 0) D30,
            ISNULL(D31, 0) D31
        FROM (
            SELECT 
                B1_DESC DESCRICAO,
                'D' + LTRIM(STR(DAY(D3_EMISSAO))) DIA,
                D3_QUANT
            FROM 
                %table:SD3% D3
            JOIN 
                %table:SB1% B1 
            ON
                D3_FILIAL = %xFilial:SD3%
                AND B1_COD = D3_COD
                AND D3_LOCAL BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
                AND D3_EMISSAO BETWEEN %exp:_dDataDe% AND %exp:_dDataAte%
                AND D3_CF = 'PR0'
                AND D3_ESTORNO = ' '
                AND D3.%notdel%
                AND B1.%notdel%
        )  PRD
        PIVOT
        (
            SUM(PRD.D3_QUANT)
            FOR DIA IN
            (D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20, D21, D22, D23, D24, D25, D26, D27, D28, D29, D30, D31)
        ) PVT
        ORDER BY 1

    EndSql

    oSection1b:EndQuery()

    oReport:SetMeter((ccAlias)->(RecCount()))
   
    _cTitulo := "Período: " + {"Janeiro", "Fevereiro", "Março", "Abril", "Março", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"}[Month(_dDataAte)] + "/" + Str(Year(_dDataAte),4)    
        
    oReport:PrintText(_cTitulo)
    oReport:SkipLine(2)
    
    oSection1b:print()
    
return

Static Function xGetTotInLine()

local _nTot := 0
local i := 0

for i := 1 to day(_dDataAte)
    _nTot += (ccAlias)->&(FieldName(i+1))
next

Return _nTot

/*/{Protheus.doc} xCriaPerg
   Ajustar Grupo de perguntas ou criá-lo caso não exista
   @author  Nome
   @table   Tabelas
   @since   14-02-2019
/*/
Static Function xCriaPerg(cGrpPerg)

Local _aPerg  := {}
Local _ni

Aadd(_aPerg,{"Mês:","mv_ch1","C",2,0,"G","","mv_par01","","","","","","",""})
Aadd(_aPerg,{"Ano:","mv_ch2","C",4,0,"G","","mv_par02","","","","","","",""})
Aadd(_aPerg,{"Arm. De:","mv_ch3","C",6,0,"G","","mv_par03","","","","","","NNR",""})
Aadd(_aPerg,{"Arm. Ate:","mv_ch4","C",6,0,"G","","mv_par04","","","","","","NNR",""})

dbSelectArea("SX1")
For _ni := 1 To Len(_aPerg)
	If !dbSeek(cGrpPerg+StrZero(_ni,2))
		RecLock("SX1",.T.)
		SX1->X1_GRUPO    := cGrpPerg
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
        SX1->X1_DEF04    := _aPerg[_ni][12]
		SX1->X1_DEFSPA4  := _aPerg[_ni][12]
		SX1->X1_DEFENG4  := _aPerg[_ni][12]
        SX1->X1_DEF05    := _aPerg[_ni][13]
		SX1->X1_DEFSPA5  := _aPerg[_ni][13]
		SX1->X1_DEFENG5  := _aPerg[_ni][13]
        SX1->X1_F3       := _aPerg[_ni][14]
		SX1->X1_CNT01    := _aPerg[_ni][15]
		MsUnLock()
	EndIf
Next _ni
Return

