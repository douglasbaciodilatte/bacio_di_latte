#INCLUDE 'TOTVS.CH'
/*//#########################################################################################
Projeto : Menu Lojas
Modulo  : Estoque
Fonte   : blestr10
Objetivo: Relatorio para imprimir as movimentações de estoque
*///#########################################################################################

/*/{Protheus.doc} blestr10
   Gerenciador de Processamento
   @author  Renan Paiva
   @table   SD3, SB1, NNR
   @since   30-01-2019
/*/
User Function blestr10()
    Local cPergRel := PadR('blestr10',10)
    Local oReport
    local ccAlias := getNextAlias()

    xCriaPerg(cPergRel)

    Pergunte(cPergRel,.T.)

    oReport := xPrintRel(ccAlias,cPergRel)
    oReport:PrintDialog()

Return

/*/{Protheus.doc} xPrintRel
   Imprimir Relatório
   @author  Nome
   @table   Tabelas
   @since   30-01-2019
/*/
Static Function xPrintRel(ccAlias,cPerg)

    local oReport
    local oSection1

    oReport    := TReport():New(cPerg,'Movimentações de Estoque',cPerg,{|oReport|ReportPrint(oReport,ccAlias)},'')
    oReport:SetLandScape()
    oReport:SetTotalInLine(.F.)
    oReport:nDevice := 4

    oSection1 := TRSection():New(oReport)
    oSection1:SetTotalInLine(.F.)

    TRCell():New(oSection1,"B1_COD",ccAlias, "Cod. Produto")
    TRCell():New(oSection1,"B1_DESC",ccAlias)
    TRCell():New(oSection1,"D3_DOC",ccAlias)
    TRCell():New(oSection1,"D3_EMISSAO",ccAlias)
    TRCell():New(oSection1,"B1_UM",ccAlias)
    TRCell():New(oSection1,"D3_QUANT",ccAlias)
    TRCell():New(oSection1,"B1_SEGUM",ccAlias)
    TRCell():New(oSection1,"D3_QTSEGUM",ccAlias)
    TRCell():New(oSection1,"DESCTIPMOV",ccAlias, "Tipo Movimento")

Return oReport


/*/{Protheus.doc} ReportPrint
   Montar query e abrir em tabela temporária
   @author  Nome
   @table   Tabelas
   @since   30-01-2019
/*/
static function ReportPrint(oReport, ccAlias,cOrdem)

    local oSection1b := oReport:Section(1)
    local _cWhere := "%" + iif(MV_PAR07 > 1,"WHERE TIPMOV = " + str(MV_PAR07,1) + "", "") + "%"
    local _cTMPesagem := SuperGetMv("MV_XTMPESA", .F., "502")
    local _cTMsDescarte := "%D3_TM IN " + FormatIn( SuperGetMv("MV_XTMSDCT", .F., "510|520|530|540|550"), "|") + "%"

    //seta o armazem conforme o usuario quando o mesmo é uma loja
    if upper(left(cUserName,2)) == "LJ"
        MV_PAR03 := right(trim(cUserName),4) + "01"
        MV_PAR04 := right(trim(cUserName),4) + "01"
    endif
    
    oSection1b:BeginQuery()
    BeginSQL Alias ccAlias
        COLUMN D3_EMISSAO AS DATE
        %noparser%
        WITH MOV AS (
        SELECT 
            B1_COD,
            B1_DESC,
            D3_DOC,
            D3_EMISSAO,
            B1_UM,
            D3_QUANT * CASE WHEN D3_TM >= '500' THEN -1 ELSE 1 END D3_QUANT,
            B1_SEGUM,
            D3_QTSEGUM * CASE WHEN D3_TM >= '500' THEN -1 ELSE 1 END D3_QTSEGUM,
            CASE 
                WHEN D3_OP != '' THEN 2
                WHEN D3_TM = %exp:_cTMPesagem% THEN 3
                WHEN D3_DOC = 'INVENT' THEN 4
                WHEN %exp:_cTMsDescarte% THEN 5
            END TIPMOV,
            CASE 
                WHEN D3_OP != '' AND LEFT(D3_CF,2) = 'PR' AND D3_ESTORNO = '' THEN 'PRODUCAO'
                WHEN D3_OP != '' AND LEFT(D3_CF,2) = 'RE' AND D3_ESTORNO = '' THEN 'CONSUMO PRODUCAO'
                WHEN D3_OP != '' AND LEFT(D3_CF,2) = 'PR' AND D3_ESTORNO != '' THEN 'ESTORNO PRODUCAO'
                WHEN D3_OP != '' AND LEFT(D3_CF,2) = 'RE' AND D3_ESTORNO != '' THEN 'ESTORNO CONSUMO PRODUCAO'                
                WHEN D3_TM = %exp:_cTMPesagem% THEN 'CONSUMO GELATO'
                WHEN D3_DOC = 'INVENT' THEN 'INVENTARIO'
                WHEN %exp:_cTMsDescarte% THEN 'DESCARTE'
                ELSE 'OUTRAS MOVIMENTACOES'
            END DESCTIPMOV
        FROM %table:SD3% D3
        JOIN %table:SB1% B1
        ON
            D3_FILIAL = %xFilial:SD3%
            AND B1_FILIAL = %xFilial:SB1%
            AND D3_COD = B1_COD
            AND D3_COD BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02%
            AND D3_LOCAL BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
            AND D3_EMISSAO BETWEEN %exp:MV_PAR04% AND %exp:MV_PAR05%
            AND D3.%notdel%
            AND B1.%notdel%
        )
        SELECT 
            B1_COD,
            B1_DESC,
            D3_DOC,
            D3_EMISSAO,
            B1_UM,
            D3_QUANT, 
            B1_SEGUM,
            D3_QTSEGUM, 
            DESCTIPMOV
        FROM MOV
        %exp:_cWhere%
        ORDER BY B1_COD, D3_EMISSAO
    EndSql
    oSection1b:EndQuery()

    //caso seja de um tipo de movimento especifico não faz sentido mostrar a coluna de tipo de movimento
    if MV_PAR07 > 1
        oSection1b:Cell("DESCTIPMOV"):Hide()
    endif
        
    oReport:SetMeter((ccAlias)->(RecCount()))

    oSection1b:Print()
return

/*/{Protheus.doc} xCriaPerg
   Ajustar Grupo de perguntas ou criá-lo caso não exista
   @author  Renan Paiva
   @table   SX1
   @since   30-01-2019
/*/
Static Function xCriaPerg(cPerg)

Local _aPerg  := {}
Local _ni

Aadd(_aPerg,{"Produto De:","mv_ch1","C",15,0,"G","","mv_par01","","","","","","SB1",""})
Aadd(_aPerg,{"Produto Ate:","mv_ch2","C",15,0,"G","","mv_par02","","","","","","SB1",""})
Aadd(_aPerg,{"Arm. De:","mv_ch3","C",6,0,"G","","mv_par03","","","","","","NNR",""})
Aadd(_aPerg,{"Arm. Ate:","mv_ch4","C",6,0,"G","","mv_par04","","","","","","NNR",""})
Aadd(_aPerg,{"Data De:","mv_ch5","D",8,0,"G","","mv_par05","","","","","","",""})
Aadd(_aPerg,{"Data Ate:","mv_ch6","D",8,0,"G","","mv_par06","","","","","","",""})
Aadd(_aPerg,{"Tipo Movimento:","mv_ch7","N",1,0,"C","","mv_par07","Todas","Produção","Consumo Gelato","Inventário","Descarte","",""})

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