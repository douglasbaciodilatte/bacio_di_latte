#INCLUDE 'TOTVS.CH'
/*//#########################################################################################
Projeto : Bacio di Latte
Modulo  : Compras
Fonte   : blcomr11
Objetivo: Relatório para imprimir as divergências entre as quantidades solicitadas e as
          atendidas pelo CD
Autor   : Renan Paiva
Tabelas : SB1, NNS, NNT, NNR
Data    : 30/01/2019
*///#########################################################################################

/*/{Protheus.doc} blcomr11
   Gerenciador de Processamento
   @author  Renan Paiva   
/*/
User Function blcomr11()
    Local cPergRel := PadR('blcomr11',10)
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

    oReport    := TReport():New(cPerg,'Divergência Solicitação e Quantidade Atendida',cPerg,{|oReport|ReportPrint(oReport,ccAlias)},'')
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
    TRCell():New(oSection2,"NNT_QTSEG",ccAlias, "Qtd. Entregue")
    TRCell():New(oSection2,"DIVERGEN",ccAlias,"Divergência", "@R 999,999,999.99", 25)
    TRCell():New(oSection2,"STATUS",ccAlias,"Status Atend.", "@!", 25)

Return oReport


/*/{Protheus.doc} ReportPrint
   Montar query e abrir em tabela temporária
   @author  Renan Paiva   
   @since   30-01-2019
/*/
static function ReportPrint(oReport, ccAlias,cOrdem)
    local oSection1b := oReport:Section(1)
    local oSection2b := ''

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
            CASE WHEN NT.D_E_L_E_T_ = '' THEN NNT_QTSEG ELSE 0 END NNT_QTSEG,
            NNT_XQTORI,
            DIVERGEN = CASE WHEN NT.D_E_L_E_T_ = '*' THEN NNT_XQTORI * -1 ELSE NNT_QTSEG - NNT_XQTORI END,
            CASE WHEN NT.D_E_L_E_T_ = '*' THEN 'NAO ATENDIDO'
                WHEN NNT_XQTORI = 0 THEN 'ADICIONADO'
                WHEN NNT_QTSEG < NNT_XQTORI THEN 'PARCIAL'
                WHEN NNT_QTSEG > NNT_XQTORI THEN 'ATENDIDO A MAIOR'
            ELSE 'OK'
            END STATUS
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
            AND NNS_STATUS = '2' //TRANSFERIDO
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
Aadd(_aPerg,{"Produto De:","mv_ch3","C",15,0,"G","","mv_par03","","","","SB1",""})
Aadd(_aPerg,{"Produto Ate:","mv_ch4","C",15,0,"G","","mv_par04","","","","SB1",""})
Aadd(_aPerg,{"Armazem De:","mv_ch3","C",6,0,"G","","mv_par05","","","","NNR",""})
Aadd(_aPerg,{"Armazem Ate:","mv_ch4","C",6,0,"G","","mv_par06","","","","NNR",""})


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