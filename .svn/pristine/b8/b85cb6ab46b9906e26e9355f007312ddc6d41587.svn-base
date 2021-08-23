#INCLUDE 'TOTVS.CH'
/*//#########################################################################################
Projeto : Bacio di Latte
Modulo  : Compras
Fonte   : blcomr12
Objetivo: Relatório para imprimir o resumo das solicitações de transferencia ao CD
Autor   : Renan Paiva
Tabelas : SB1, NNS, NNT, NNR
Data    : 30/01/2019
*///#########################################################################################

/*/{Protheus.doc} blcomr12
   Gerenciador de Processamento
   @author  Renan Paiva   
/*/
User Function blcomr12()
    Local cPergRel := PadR('blcomr12',10)
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
    
    oReport    := TReport():New(cPerg,'Resumo das Solicitações ao CD',cPerg,{|oReport|ReportPrint(oReport,ccAlias)},'')
    oReport:SetLandScape()
    oReport:SetTotalInLine(.F.)
    oReport:nDevice := 4

    oSection1 := TRSection():New(oReport)
    oSection1:SetTotalInLine(.F.)

    TRCell():New(oSection1,"NNS_COD",ccAlias, "Numero Solic.")
    TRCell():New(oSection1,"NNS_DATA",ccAlias)
    TRCell():New(oSection1,"NNS_XNOMSO",ccAlias)
    TRCell():New(oSection1,"NNR_DESCRI",ccAlias ,"Destino")
    TRCell():New(oSection1,"STATSOL",ccAlias, "Status Solicitação","@!", 50)    

Return oReport


/*/{Protheus.doc} ReportPrint
   Montar query e abrir em tabela temporária
   @author  Renan Paiva   
   @since   30-01-2019
/*/
static function ReportPrint(oReport, ccAlias,cOrdem)
    local oSection1b := oReport:Section(1)    

    oSection2b := oReport:Section(1):Section(1)

    oSection1b:BeginQuery()
    BeginSQL Alias ccAlias
        COLUMN NNS_DATA AS DATE
        %noparser%
        SELECT DISTINCT //TEM QUE FAZER O JOIN COM A NNT PARA PEGAR A FILIAL DE DESTINO
            NNS_COD,
            NNS_DATA,
            NNS_XNOMSO,
            NNR_DESCRI,
            CASE WHEN NNS_STATUS = '1' THEN 'Liberado'
                 WHEN NNS_STATUS = '2' THEN 'Transferido'
                 WHEN NNS_STATUS = '3' THEN 'Em Aprovação'
                 WHEN NNS_STATUS = '4' THEN 'Rejeitado'
            END STATSOL            
        FROM %table:NNS% NS
        JOIN %table:NNT% NNT
        ON
            NNS_FILIAL = NNT_FILIAL
            AND NNT_FILDES = %xFilial:NNT%
            AND NNS_COD = NNT_COD
            AND NNS_COD BETWEEN %exp:MV_PAR01% AND %exp:MV_PAR02%
            AND NNS_DATA BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%  
            AND NNT_LOCLD = %exp:MV_PAR05%                      
            AND NS.%notdel%        
            AND NNT.%notdel%
        JOIN %table:NNR% NNR
        ON
            NNR_FILIAL = NNT_FILDES
            AND NNT_LOCLD = NNR_CODIGO
            AND NNR.%notdel%        
    EndSql
    oSection1b:EndQuery()    

    oReport:SetMeter((ccAlias)->(RecCount()))    

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

Aadd(_aPerg,{"Solicitacao De:","mv_ch1","C",10,0,"G","","mv_par01","","","","",""})
Aadd(_aPerg,{"Solicitacao Ate:","mv_ch2","C",10,0,"G","","mv_par02","","","","",""})
Aadd(_aPerg,{"Data De:","mv_ch3","D",8,0,"G","","mv_par03","","","","",""})
Aadd(_aPerg,{"Data Ate:","mv_ch4","D",8,0,"G","","mv_par04","","","","",""})
Aadd(_aPerg,{"Armazem:","mv_ch5","C",6,0,"G","","mv_par05","","","","NNR",""})

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