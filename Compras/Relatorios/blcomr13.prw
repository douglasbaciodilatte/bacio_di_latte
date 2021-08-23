#INCLUDE 'TOTVS.CH'
/*//#########################################################################################
Projeto : Bacio di Latte
Modulo  : Compras
Fonte   : blcomr13
Objetivo: Relatório para imprimir os itens das solicitações de transferencia ao CD          
Autor   : Renan Paiva
Tabelas : SB1, NNS, NNT, NNR
Data    : 30/01/2019
*///#########################################################################################

/*/{Protheus.doc} blcomr13
   Gerenciador de Processamento 
   @author  Renan Paiva   
/*/
User Function blcomr13()
    Local cPergRel := PadR('blcomr13',10)
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
    local oSection2    

    oReport    := TReport():New(cPerg,'Itens das Solicitações de Transferência',cPerg,{|oReport|ReportPrint(oReport,ccAlias)},'')
    oReport:SetLandScape()
    oReport:SetTotalInLine(.F.)
    oReport:nDevice := 4

    oSection1 := TRSection():New(oReport)
    oSection1:SetTotalInLine(.F.)

    TRCell():New(oSection1,"NNS_COD",ccAlias, "Numero Solic.")
    TRCell():New(oSection1,"NNS_DATA",ccAlias)
    TRCell():New(oSection1,"NNS_XNOMSO",ccAlias)
    TRCell():New(oSection1,"STATSOL",ccAlias, "Status Solicitação","@!", 50)

    oSection2 := TRSection():New(oSection1)
    oSection2:SetTotalInLine(.F.)

    TRCell():New(oSection2,"NNR_DESCRI",ccAlias)
    TRCell():New(oSection2,"NNT_PRODD",ccAlias)
    TRCell():New(oSection2,"B1_DESC",ccAlias)    
    TRCell():New(oSection2,"NNT_XQTORI",ccAlias, "Qtd. Solicitada")  
    TRCell():New(oSection2,"VALOR",ccAlias, "Valor Total Item", "@R 999,999,999,999.99",,,{|| (ccAlias)->(NNT_XQTORI * B1_CUSTD) })

    oBrkTot := TRBreak():New( oSection2, { || (ccAlias)->NNS_COD }, "Valor Total da Transferência", )

    TRFunction():New( oSection2:Cell("VALOR")	, ,"SUM", oBrkTot,/*Titulo*/,,{ || (ccAlias)->(NNT_XQTORI * B1_CUSTD) },.F.,.F.,.F.,oSection2)

Return oReport


/*/{Protheus.doc} ReportPrint
   Montar query e abrir em tabela temporária
   @author  Renan Paiva   
   @since   30-01-2019
/*/
static function ReportPrint(oReport, ccAlias,cOrdem)
    local oSection1b := oReport:Section(1)
    local ccExp := "%" + iif(MV_PAR07 > 1, " AND NNS_STATUS = '" + STR(MV_PAR07-1,1) + "'", "") + "%"

    oSection2b := oReport:Section(1):Section(1)

    oSection1b:BeginQuery()
    BeginSQL Alias ccAlias
        COLUMN NNS_DATA AS DATE
        COLUMN NNT_QTSEG AS NUMERIC(18,2)
        COLUMN NNT_XQTORI AS NUMERIC(18,2)
        COLUMN DIVERGEN AS NUMERIC(18,2)
        %noparser%
        SELECT
            NNS_COD,
            NNS_DATA,
            NNS_XNOMSO,
            CASE WHEN NNS_STATUS = '1' THEN 'Liberado'
                 WHEN NNS_STATUS = '2' THEN 'Transferido'
                 WHEN NNS_STATUS = '3' THEN 'Em Aprovação'
                 WHEN NNS_STATUS = '4' THEN 'Rejeitado'
            END STATSOL, 
            NNR_DESCRI,
            NNT_PRODD,
            B1_DESC,
            B1_CUSTD,
            NNT_XQTORI            
        FROM %table:NNS% NS
        JOIN %table:NNT% NT 
        ON
            NNS_FILIAL = NNT_FILIAL
            AND NNT_FILDES = %xFilial:NNT%
            AND NNS_COD = NNT_COD
            AND NNS_DATA BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02%
            AND NNT_PRODD BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
            AND NNT_LOCLD BETWEEN %exp:MV_PAR05% AND %exp:MV_PAR06%
            AND NS.%notdel%
            %exp:ccExp% //expressao para filtrar status da solicitacao
        JOIN %table:SB1% B1
        ON
            B1_FILIAL = %xFilial:SB1%
            AND B1_COD = NNT_PRODD
            AND B1.%notdel%
        JOIN %table:NNR% NR
        ON
            NNR_FILIAL = NNT_FILDES
            AND NNR_CODIGO = NNT_LOCLD
            AND NR.%notdel%

    EndSql
    oSection1b:EndQuery()

    oSection2b:SetParentQuery()

    oReport:SetMeter((ccAlias)->(RecCount()))

    oSection2b:SetParentFilter({|cParam| (ccAlias)->NNS_COD == cParam}, {|| (ccAlias)->NNS_COD})

    oSection1b:Print()
return

/*/{Protheus.doc} xCriaPerg
   Ajustar Grupo de perguntas ou criá-lo caso não exista
   @author  Nome
   @table   Tabelas
   @since   30-01-2019
/*/
Static Function xCriaPerg(cPerg)

Local _aPerg  := {}
Local _ni

Aadd(_aPerg,{"Data De:","mv_ch1","D",8,0,"G","","mv_par01","","","","",""})
Aadd(_aPerg,{"Data Ate:","mv_ch2","D",8,0,"G","","mv_par02","","","","",""})
Aadd(_aPerg,{"Produto De:","mv_ch3","C",15,0,"G","","mv_par03","","","","","","SB1",""})
Aadd(_aPerg,{"Produto Ate:","mv_ch4","C",15,0,"G","","mv_par04","","","","","","SB1",""})
Aadd(_aPerg,{"Armazem De:","mv_ch5","C",6,0,"G","","mv_par05","","","","","","NNR",""})
Aadd(_aPerg,{"Armazem Ate:","mv_ch6","C",6,0,"G","","mv_par06","","","","","","NNR",""})
Aadd(_aPerg,{"Status Solicitacao:","mv_ch7","N",1,0,"C","","mv_par07","Todos","Liberado","Transferido","Em Aprovacao", "Rejeitado","",""})


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