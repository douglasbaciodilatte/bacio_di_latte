
//Bibliotecas
#Include "TOTVS.ch"
#Include "TopConn.ch"
#include "fileio.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"


static eol := chr(13) + chr(10)
//************************************************************************************
//Relatorio que demonstra os lotes dos produtos que não foram inventariado
//
//************************************************************************************
User Function BLESTR21()
   
    Local cQuery := space(1)
    Private cPerg := 'BLESTR2103' 
    ValidPerg()

    //while
     Pergunte(cPerg)
        MV_PAR08 := MV_PAR07

        cQuery := eol + "SELECT "
        cQuery += eol + "	    B8_FILIAL  "
        cQuery += eol + "  	    ,B8_PRODUTO  "
        cQuery += eol + "  	    ,B1_DESC "
        cQuery += eol + "  	    ,B8_LOCAL  "
        cQuery += eol + "  	    ,B8_LOTECTL "
        cQuery += eol + "  	    ,B1_UM "
        cQuery += eol + "  	    ,SUM(Saldo_1_UM ) AS Saldo_1_UM "
        /*
        cQuery += eol + "  	    ,SUM(Inventario_1_UM ) AS Inventario_1_UM  "
        cQuery += eol + "       ,SUM(Saldo_1_UM-Inventario_1_UM) as Dif_Saldo1_Invent1  "
        cQuery += eol + "  	    ,B1_SEGUM"
        cQuery += eol + "  	    ,SUM(Saldo_2_UM ) AS Saldo_2_UM "
        cQuery += eol + "  	    ,SUM(INVENT_2UM ) AS INVENT_2UM "
        cQuery += eol + "       ,SUM(Saldo_2_UM  - INVENT_2UM ) as Dif_Saldo2_Invent2"
        cQuery += eol + "       ,CASE WHEN Ocorrencia = '2'  "
 		cQuery += eol + "	            THEN 'Processado'  "
 		cQuery += eol + "	            ELSE 'Não Processado' "   
 		cQuery += eol + "           END AS Ocorrencia "
         */
        cQuery += eol + "	FROM ( "
        
        cQuery += eol + "       SELECT   B8_FILIAL  "
        cQuery += eol + "  	            ,B8_PRODUTO  "
        cQuery += eol + "  	            ,B1_DESC  "
        cQuery += eol + "  	            ,B8_LOCAL  "
        cQuery += eol + "  	            ,B8_LOTECTL as B8_LOTECTL "
        cQuery += eol + "  	            ,('  /  /    ') AS Data_Inventario   "
        cQuery += eol + "       	    ,B1_UM "
        cQuery += eol + "  	            ,B8_SALDO as Saldo_1_UM  "
        cQuery += eol + "  	            ,0 AS Inventario_1_UM  "
        cQuery += eol + "  	            ,B1_SEGUM"
        cQuery += eol + "  	            ,B8_SALDO2 as Saldo_2_UM  "
        cQuery += eol + "  	            ,0 AS INVENT_2UM  "
        cQuery += eol + "  	            ,2 as Ocorrencia"
        cQuery += eol + "  FROM " + RetSqlName("SB8") + " AS B8  "
        cQuery += eol + "  	INNER JOIN " + RetSqlName("SB1") + "  AS B1   "
        cQuery += eol + "  		ON  B1_COD        = B8_PRODUTO "
        cQuery += eol + "  		AND B1.D_E_L_E_T_ = ''  "
        cQuery += eol + "  WHERE   "
        cQuery += eol + "  	        B8.D_E_L_E_T_ = ''  "
        cQuery += eol + "  	    AND B8_SALDO <> 0 "
        cQuery += eol + "  	    AND B8_FILIAL  BETWEEN  '" + MV_PAR01 + "'  AND '" + MV_PAR02 + "'   "
        cQuery += eol + "  	    AND B8_LOCAL   BETWEEN  '" + MV_PAR05 + "'  AND '" + MV_PAR06 + "'  "
        cQuery += eol + "  	    AND B8_PRODUTO BETWEEN  '" + MV_PAR03 + "'  AND '" + MV_PAR04 + "'   "
        cQuery += eol + "  	    AND B8_DATA <  '" + DTOS(MV_PAR07) + "'  "
        
        cQuery += eol + "UNION  "

        cQuery += eol + "   SELECT   B7_FILIAL AS  B8_FILIAL  "
        cQuery += eol + "  	        ,B7_COD    AS B8_PRODUTO  "
        cQuery += eol + "  	        ,B1_DESC  "
        cQuery += eol + "  	        ,B7_LOCAL AS B8_LOCAL  "
        cQuery += eol + "  	        ,B7_LOTECTL as B8_LOTECTL "
        cQuery += eol + "  	        ,(SUBSTRING(ISNULL(B7_DATA,'          '),7,2)+'/'+SUBSTRING(ISNULL(B7_DATA,'          '),5,2)+'/'+SUBSTRING(ISNULL(B7_DATA,'          '),1,4)) AS Data_Inventario   "
        cQuery += eol + "  	        ,B1_UM "
        cQuery += eol + "  	        ,0 as Saldo_1_UM  "
        cQuery += eol + "  	        ,ISNULL(B7_QUANT,0) AS Inventario_1_UM  "
        cQuery += eol + "  	        ,B1_SEGUM "
        cQuery += eol + "  	        ,0 as Saldo_2_UM  "
        cQuery += eol + "  	        ,ISNULL(B7_QTSEGUM,0) AS INVENT_2UM  "
        cQuery += eol + "  	        ,B7_STATUS AS Ocorrencia"
            
        cQuery += eol + "   FROM " + RetSqlName("SB7") + "  AS B7  "
                  
        cQuery += eol + "  	    INNER JOIN " + RetSqlName("SB1") + "  AS B1   "
        cQuery += eol + "  		    ON  B1_COD        = B7_COD "
        cQuery += eol + "  		    AND B1.D_E_L_E_T_ = ''  "
        cQuery += eol + "       WHERE   "
        cQuery += eol + "  	        B7.D_E_L_E_T_  = ''  "
        cQuery += eol + "  	        AND B7_STATUS  = '2'  "
        cQuery += eol + "	        AND B7_DATA    BETWEEN  '" + dtos(MV_PAR07) + "' AND '" + dtos(MV_PAR08) + "'  "
        cQuery += eol + "  	        AND B7_FILIAL  BETWEEN  '" + MV_PAR01       + "' AND '" + MV_PAR02 + "'  "
        cQuery += eol + "  	        AND B7_LOCAL   BETWEEN  '" + MV_PAR05       + "' AND '" + MV_PAR06 + "'  "
        cQuery += eol + "  	        AND B7_COD     BETWEEN  '" + MV_PAR03       + "' AND '" + MV_PAR04 + "'  "
        cQuery += eol + "	) AS TRB "
        cQuery += eol + "	GROUP BY B8_FILIAL  "
        cQuery += eol + "  	        ,B8_PRODUTO  "
        cQuery += eol + "  	        ,B1_DESC  "
        cQuery += eol + "  	        ,B8_LOCAL  "
        cQuery += eol + "  	        ,B8_LOTECTL, B1_UM "  //, B1_SEGUM,Ocorrencia "
        cQuery += eol + "       having sum(Inventario_1_UM) = 0 "
        cQuery += eol + "       ORDER BY 1,2,3,4,5  "


        MEMOWRITE('C:\1\QUERY.SQL',cQuery)
        //U_QRYCSV(cQuery,"Saldo Lote x Inventario Lote")
        TCQUERY cQuery NEW ALIAS "TRB"
        
        Processa( {|| fGeraExel()}, "Gerando Planilha...")
        
    //EndDo
        
    
Return

//*********************************************************************************************

//*********************************************************************************************

Static Function ValidPerg()
Local _sAlias := Alias()

    dbSelectArea("SX1")
    dbSetOrder(1)

    cPerg := PADR(cPerg,10)
    aRegs :={}

    aAdd(aRegs,{cPerg,"01","De Filial"         ,"","","mv_ch1","C",TamSX3("B1_FILIAL")[1],0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SM0","","",""})
    aAdd(aRegs,{cPerg,"02","Até Filial"        ,"","","mv_ch2","C",TamSX3("B1_FILIAL")[1],0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SM0","","",""})
    aAdd(aRegs,{cPerg,"03","De Produto"        ,"","","mv_ch3","C",TamSX3("B1_COD")[1]   ,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","",""})
    aAdd(aRegs,{cPerg,"04","Até Produto"       ,"","","mv_ch4","C",TamSX3("B1_COD")[1]   ,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","",""})
    aAdd(aRegs,{cPerg,"05","De Armazem"        ,"","","mv_ch5","C",TamSX3("B1_LOCPAD")[1],0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","NNR","","",""})
    aAdd(aRegs,{cPerg,"06","Até Armazem"       ,"","","mv_ch6","C",TamSX3("B1_LOCPAD")[1],0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","NNR","","",""})
    aAdd(aRegs,{cPerg,"07","Data Do Inventário","","","mv_ch7","D",10                    ,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","",""})
    //aAdd(aRegs,{cPerg,"08","Data Referencia"  ,"","","mv_ch8","D",10                    ,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","",""})
    For i := 1 to Len(aRegs)

        If !dbSeek(cPerg+aRegs[i,2])

            RecLock("SX1", .T. )

                For j := 1 to FCount()
                    If j <= Len(aRegs[i])
                        FieldPut(j,aRegs[i,j])
                    Else
                        exit
                    Endif
                Next

            SX1->(MsUnlock())

        Endif

    Next

    dbSelectArea(_sAlias)

Return


Static Function fGeraExel()

Local cPlanilha := "Saldo Lote a Zerar " //x Inventario Lote" 
Local cTabela   := "Armazém"
Local cPasta 	:= ""
Local cArq   	:= "Armazem_" + StrTran(time(),":","")
Local aDados 	:= {}
Local lX 		:= .T.
Default nSlv    := 1
	cPasta := cGetFile("", "Salvar Arquivo em", 1, "C:\", .T., GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY) 

	//Cria o Objeto para criar a Planilha XML
	oExcel := FwMsExcelEx():New()

	//Define a Planilha
	oExcel:AddWorkSheet(cPlanilha)

	//Define a Tabela na Planilha
	oExcel:AddTable(cPlanilha,cTabela)

    oExcel:AddColumn(cPlanilha , cTabela , "Filial"                         , 1 , 1 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Produto"                        , 1 , 1 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Descrição"                      , 1 , 1 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Armazem"                        , 1 , 1 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Lote"                           , 1 , 1 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Unid.Med. 1"                    , 1 , 1 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Saldo Atual 1 UM"               , 3 , 2 , .f. )
    /*
    oExcel:AddColumn(cPlanilha , cTabela , "Inventario 1 UM"                , 3 , 2 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Dif. Saldo - Inventario 1 UM"   , 3 , 2 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Unid.Med. 2"                    , 1 , 1 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Saldo Atual 2 UM"               , 3 , 2 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Inventario 2 UM"                , 3 , 2 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Dif. Saldo - Inventario 2 UM "  , 3 , 2 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Ocorrencia"                     , 1 , 1 , .f. )
    */
    DbSelectArea('TRB')
    TRB->(DbGotop())

	While TRB->(!EOF())
        aDados := {}

        AAdd(aDados,TRB->B8_FILIAL          )
        AAdd(aDados,TRB->B8_PRODUTO         )
        AAdd(aDados,TRB->B1_DESC            )
        AAdd(aDados,TRB->B8_LOCAL           )
        AAdd(aDados,TRB->B8_LOTECTL         )
        AAdd(aDados,TRB->B1_UM              )
        AAdd(aDados,TRB->Saldo_1_UM         )
        /*
        AAdd(aDados,TRB->Inventario_1_UM    )
        AAdd(aDados,TRB->Dif_Saldo1_Invent1 )
        AAdd(aDados,TRB->B1_SEGUM           )
        AAdd(aDados,TRB->Saldo_2_UM         )
        AAdd(aDados,TRB->INVENT_2UM         )
        AAdd(aDados,TRB->Dif_Saldo2_Invent2 )
        AAdd(aDados,TRB->Ocorrencia         )
        */
        TRB->(DBSKIP())
        
        IF lX

			oExcel:SetCelBgColor("#F4B084")
			//oExcel:SetLineBold(lBold)
			//oExcel:SetCelBold(lBold)
		ELSE

			oExcel:SetCelBgColor("#FADCCA")
			//oExcel:Set2LineBold(lBold)
			//oExcel:SetCelBold(lBold)
        ENDIF
        lX := !lX
        oExcel:AddRow(cPlanilha,cTabela, aDados)//,aCor)

    Enddo
	
    //Cria a Planilha em XML no formato Excel
	oExcel:Activate()
	
	If !Empty(cPasta)
		
		//Verifica se o Excel esta instalado
		If !ApOleClient("MSExcel")

			MsgAlert("Microsoft Excel não instalado!","Atenção")

		Else

			//Salva o Excel em arquivo
			oExcel:GetXMLFile(cPasta + cArq+".XML")

			//Abre o Excel
			oEx := MsExcel():New()

			//Abre o Arquivo
			oEx:WorkBooks:Open(cPasta + cArq+".XML")

			//Apresenta em Tela
			oEx:SetVisible(.T.)
		
		Endif
	
	Endif
    TRB->(DbCloseArea())
Return
