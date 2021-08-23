//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"
#include "fileio.ch"

/*/{Protheus.doc} User Function nomeFunction
    (long_description)
    @type  Function
    @author user
    @since 27/04/2021
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (exa22222222222mples)
    @see (links_or_references)
    /*/

User Function BLESTR31()

    //Local aParamBox := {}
    //Local aRet := {}
    //local cQuery := ""
    Local cPasta 	:= ""
    Private cPerg := "BLESTR3101"

    ValidPerg()

 
    //aAdd(aParamBox,{1,"De Data"   ,Ctod(Space(8)),"","","","",50,.T.})
	//aAdd(aParamBox,{1,"At� Data"  ,Ctod(Space(8)),"","","","",50,.T.})

    IF Pergunte(cPerg,.T.)
        ///If ParamBox(aParamBox,"Extrator Dados...",@aRet)
        
        //mEMOWRITE('C:\1\QUERY.SQL',cQuery)
        //U_QRYCSV(cQuery,"CMV - Teorico")
        fQCONSTo()
        Processa( {|| fGeraExel(cPasta)}, "Gerando Planilha Consumo Te�rico...")
    EndIf    
    
Return


//*********************************************************************************************

//*********************************************************************************************

Static Function ValidPerg()
Local _sAlias := Alias()

    dbSelectArea("SX1")
    dbSetOrder(1)

    cPerg := PADR(cPerg,10)
    aRegs :={}

    aAdd(aRegs,{cPerg,"01","De Filial"    ,"","","mv_ch1","C",TamSX3("B1_FILIAL")[1],0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SM0","","",""})
    aAdd(aRegs,{cPerg,"02","At� Filial"   ,"","","mv_ch2","C",TamSX3("B1_FILIAL")[1],0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SM0","","",""})
    aAdd(aRegs,{cPerg,"03","De Produto"   ,"","","mv_ch3","C",TamSX3("B1_COD")[1]   ,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","",""})
    aAdd(aRegs,{cPerg,"04","At� Produto"  ,"","","mv_ch4","C",TamSX3("B1_COD")[1]   ,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","",""})
    //aAdd(aRegs,{cPerg,"05","De Armazem" ,"","","mv_ch5","C",TamSX3("B1_LOCPAD")[1],0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","NNR","","",""})
    //aAdd(aRegs,{cPerg,"06","At� Armazem","","","mv_ch6","C",TamSX3("B1_LOCPAD")[1],0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","NNR","","",""})
    aAdd(aRegs,{cPerg,"05","De Data"      ,"","","mv_ch5","D",10                    ,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","",""})
    aAdd(aRegs,{cPerg,"06","At� Data"     ,"","","mv_ch6","D",10                    ,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","",""})
    //aAdd(aRegs,{cPerg,"07","Impostos %"   ,"","","mv_ch7","N",5                     ,2,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","",""})
    
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

   // dbSelectArea(_sAlias)

Return

Static Function fQCONSTo()
Local cQuery := ""

    cQuery += CRLF + "  SELECT D2_FILIAL as FILIAL ,COD"
    cQuery += CRLF + "          , DESCR"
    cQuery += CRLF + " 	        , COMP"
    cQuery += CRLF + " 	        , DESCRCOMP"
    cQuery += CRLF + " 	        , UM"
    cQuery += CRLF + " 	        , QUANT"
    cQuery += CRLF + " 	        , IIF(NIVEL = '01' AND CUSTO = 0,CUS, CUSTO) AS CUSTO   "
    cQuery += CRLF + " 	        , IIF(NIVEL = '01' AND CUSTO = 0,(CUS * QUANT), (CUSTO * QUANT)) as CUSTO_UNI"
    cQuery += CRLF + " 	        , SUM(ISNULL(D2_QUANT,0)) AS QUANT_VEN"
    cQuery += CRLF + "          , (SUM(ISNULL(D2_QUANT,0))  * QUANT ) AS CONSUMO"
    cQuery += CRLF + " 	        , SUM(ISNULL(D2_PRCVEN*D2_QUANT,0))/SUM(ISNULL(D2_QUANT,1)) AS PRECO"
    cQuery += CRLF + " 	        , IIF(NIVEL = '01' AND CUSTO = 0 "
    cQuery += CRLF + "    				, ((CUS  *QUANT) * (SUM(ISNULL(D2_QUANT,0)) )) "
    cQuery += CRLF + "    				, ((CUSTO*QUANT) * (SUM(ISNULL(D2_QUANT,0)) )) "
    cQuery += CRLF + "    			) AS CUSTO_TEORICO"

    cQuery += CRLF + " 		    ,SUM(ISNULL(D2_QUANT*D2_PRCVEN,0)) AS CUSTO_VENDA"
	    
    cQuery += CRLF + " 		    , IIF(NIVEL = '01' AND CUSTO = 0 "
    cQuery += CRLF + " 			    , IIF(((CUS  *QUANT)* SUM(ISNULL(D2_QUANT,0))) = 0 ,0, ((CUS  *QUANT)* SUM(ISNULL(D2_QUANT,0)))/SUM(ISNULL(D2_QUANT*D2_PRCVEN,0)) *100 )"
    cQuery += CRLF + " 			    , IIF(((CUSTO*QUANT)* SUM(ISNULL(D2_QUANT,0))) = 0 ,0, ((CUSTO*QUANT)* SUM(ISNULL(D2_QUANT,0)))/SUM(ISNULL(D2_QUANT*D2_PRCVEN,0)) *100 ))"
    cQuery += CRLF + " 		    AS CUSTO_TOTAL"
 
    cQuery += CRLF + "  FROM ( "
    
    cQuery += CRLF + "	    select B1_COD AS COD"
    cQuery += CRLF + "		    , B1_DESC AS DESCR"
    cQuery += CRLF + "		    , ISNULL(G1_COMP,B1_COD) AS COMP"
    cQuery += CRLF + "		    , (SELECT B1C.B1_DESC FROM SB1010 AS B1C WHERE B1C.B1_COD = ISNULL(G1.G1_COMP,B1.B1_COD) AND B1C.D_E_L_E_T_ = '') AS DESCRCOMP"
    cQuery += CRLF + "		    , (SELECT B1B.B1_UM FROM SB1010 AS B1B WHERE B1B.B1_COD = ISNULL(G1.G1_COMP,B1.B1_COD) AND B1B.D_E_L_E_T_ = '') AS UM"
    cQuery += CRLF + "		    , ISNULL(G1_QUANT,1) AS QUANT"
    cQuery += CRLF + "		    , (SELECT B1A.B1_CUSTD FROM SB1010 AS B1A WHERE B1A.B1_COD = ISNULL(G1.G1_COMP,B1.B1_COD) AND B1A.D_E_L_E_T_ = '') AS CUSTO"
    cQuery += CRLF + "		    , ISNULL(G1_REVINI,'') AS REVISAO,B1_TIPO, ISNULL(G1_NIV,'00') AS NIVEL"
    
    cQuery += CRLF + "          ,( "
 	cQuery += CRLF + "          	    SELECT SUM(B1_CUSTD)/SUM(D1_QUANT)  AS CUSTO "
 	cQuery += CRLF + "          		    FROM " + RetSqlName("SD1") + " D1 "
 	cQuery += CRLF + "          		    INNER JOIN " + RetSqlName("SB1") + " B1 "
 	cQuery += CRLF + "          			    ON  B1_COD  = D1_COD "
 	cQuery += CRLF + "          			    AND B1_TIPO in ('PA','PI') "
 	cQuery += CRLF + "          		    INNER JOIN " + RetSqlName("SF4") + " F4 "
 	cQuery += CRLF + "          			    ON  F4_CODIGO  = D1_TES "
 	cQuery += CRLF + "          				AND F4_ESTOQUE = 'S' "
 	cQuery += CRLF + "          				AND F4.D_E_L_E_T_ = '' "
 	cQuery += CRLF + "          	    WHERE   D1_FILIAL   BETWEEN '" +      MV_PAR01  + "' AND '" + MV_PAR02 + "' "
 	cQuery += CRLF + "          		    AND D1_DTDIGIT  BETWEEN '" + DTOS(MV_PAR05) + "' AND '" + DTOS(MV_PAR06) + "' "
    cQuery += CRLF + "          		    AND D1_TIPO = 'N' "
 	cQuery += CRLF + "          		    AND D1.D_E_L_E_T_ = '' "
 	cQuery += CRLF + "          	    GROUP BY D1_FILIAL ) AS CUS "

    cQuery += CRLF + "		from " + RetSqlName("SB1") + " B1 WITH(NOLOCK)"
    cQuery += CRLF + "		    LEFT OUTER JOIN " + RetSqlName("SG1") + " G1 WITH(NOLOCK) "
    cQuery += CRLF + "              ON  G1_COD = B1_COD "
    cQuery += CRLF + "              AND G1_NIV = '01' "
    cQuery += CRLF + "              AND G1.D_E_L_E_T_ = ''"
    cQuery += CRLF + "		    WHERE "
    cQuery += CRLF + "              B1.D_E_L_E_T_ = '' "
    cQuery += CRLF + "              AND B1_TIPO IN( 'VE','ME','PA','PI') "
    cQuery += CRLF + "  ) TRB "
    cQuery += CRLF + "  LEFT OUTER JOIN " + RetSqlName("SD2") + " D2 WITH(NOLOCK)"
    cQuery += CRLF + "      ON  D2_COD = COD "
    cQuery += CRLF + "      AND D2.D_E_L_E_T_ = '' "
    cQuery += CRLF + "      AND D2_TIPO = 'N' "
    cQuery += CRLF + "      AND D2_EMISSAO BETWEEN '" + DTOS(MV_PAR05) + "' AND '" + DTOS(MV_PAR06) + "' "
    cQuery += CRLF + "  	AND D2_FILIAL  BETWEEN '" +      MV_PAR01  + "' AND '" + MV_PAR02 + "' "
    cQuery += CRLF + "      AND D2_COD     BETWEEN '" +      MV_PAR03  + "' AND '" + MV_PAR04 + "' "
   
    cQuery += CRLF + "  INNER JOIN " + RetSqlName("SF4") + " F4 WITH(NOLOCK) "
    cQuery += CRLF + "      ON  F4_CODIGO  = D2_TES "
    cQuery += CRLF + "		AND F4_DUPLIC  = 'S' "
    cQuery += CRLF + "		AND F4_ESTOQUE = 'S' "
    /*
    cQuery += CRLF + "	WHERE "
    cQuery += CRLF + "          D2_EMISSAO BETWEEN '" + DTOS(MV_PAR05) + "' AND '" + DTOS(MV_PAR06) + "' "
    cQuery += CRLF + "  	AND D2_FILIAL  BETWEEN '" +      MV_PAR01  + "' AND '" + MV_PAR02 + "' "
    cQuery += CRLF + "      AND D2_COD     BETWEEN '" +      MV_PAR03  + "' AND '" + MV_PAR04 + "' "
    */
    cQuery += CRLF + "	GROUP BY COD,DESCR,COMP, DESCRCOMP,UM,QUANT, CUSTO, D2_FILIAL, NIVEL, CUS   "
    cQuery += CRLF + "	ORDER BY 1,3"

    //MEMOWRITE('C:\1\QUERY_CONSUMO.SQL',cQuery) 
    if select('TCOT') == 1
        TCOT->(DbCloseArea)
    Endif
    TCQUERY cQuery NEW ALIAS "TCOT"
        
    
Return
 
 //*************************************************************************************************
 

 //*************************************************************************************************

Static Function fGeraExel(cPasta)

Local cPlanilha := "" //x Inventario Lote" 
Local cTabela   := ""
Local cArq   	:= "Consumo_Teorico_" + StrTran(time(),":","")
//Local aDados 	:= {}
Local cLjFil    := ""
Private oExcel 
Default nSlv    := 1
    
    if empty(cPasta)
	    cPasta := cGetFile("", "Salvar Arquivo em", 1, "C:\", .T., GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY) 
    EndIf
	
    //Cria o Objeto para criar a Planilha XML
	oExcel := FwMsExcelEx():New()
    
    DbSelectArea('TCOT')
    TCOT->(DbGotop())

    while !TCOT->(EOF())
        cLjFil    := TCOT->FILIAL
        cPlanilha := "Consumo Loja: " + cLjFil 
        cTabela   := "Consumo Te�rico: " + cLjFil 
        
        //Define a Planilha
        fPCMV(oExcel,cPlanilha,cTabela,cLjFil )
    
    Enddo
    
    //Cria a Planilha em XML no formato Excel
	oExcel:Activate()
	
	If !Empty(cPasta)
		
		//Verifica se o Excel esta instalado
		If !ApOleClient("MSExcel")

			MsgAlert("Microsoft Excel n�o instalado!","Aten��o")

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
    TCOT->(DbCloseArea())
Return

//********************************************************************************************************


//********************************************************************************************************

Static Function fPCMV(oExcel,cPlanilha,cTabela,cLjFil)
Local aDados := {}
Local lX := .T.
Local nX := 3
//Local nVendas := 0
//Local nValor := 0
//Local nCustoTotal := 0
//Local cImposto := 0

//Define a Tabela na Planilha
    oExcel:AddWorkSheet(cPlanilha)

	oExcel:AddTable(cPlanilha,cTabela)

    oExcel:AddColumn(cPlanilha , cTabela , "Filial"                 , 1 , 1 , .f. ) //A
    oExcel:AddColumn(cPlanilha , cTabela , "Produto Venda"          , 1 , 1 , .f. ) //B
    oExcel:AddColumn(cPlanilha , cTabela , "Descri��o"              , 1 , 1 , .f. ) //C
    oExcel:AddColumn(cPlanilha , cTabela , "Produto Comp"           , 1 , 1 , .f. ) //D
    oExcel:AddColumn(cPlanilha , cTabela , "Descri��o"              , 1 , 1 , .f. ) //E
    oExcel:AddColumn(cPlanilha , cTabela , "Unid.Medida"            , 2 , 1 , .f. ) //F

    oExcel:AddColumn(cPlanilha , cTabela , "Quant"                  , 3 , 2 , .f. ) //G
    oExcel:AddColumn(cPlanilha , cTabela , "Custo Unit."            , 3 , 2 , .f. ) //H
    oExcel:AddColumn(cPlanilha , cTabela , "Custo Total"            , 3 , 2 , .f. ) //I
    oExcel:AddColumn(cPlanilha , cTabela , "Quant.Vend"             , 3 , 2 , .f. ) //J
    oExcel:AddColumn(cPlanilha , cTabela , "Consumo Teorico"        , 3 , 2 , .f. ) //K
    oExcel:AddColumn(cPlanilha , cTabela , "Custo Teorico"          , 3 , 2 , .f. ) //L

    //oExcel:AddColumn(cPlanilha , cTabela , "Pre�o Medio"            , 3 , 2 , .f. )
    //oExcel:AddColumn(cPlanilha , cTabela , "Pre�o Cardapio"         , 3 , 2 , .f. )
    //oExcel:AddColumn(cPlanilha , cTabela , "Diferen�a(%)"           , 3 , 2 , .f. )
    //oExcel:AddColumn(cPlanilha , cTabela , "Inventario 2 UM"                , 3 , 2 , .f. )
    //oExcel:AddColumn(cPlanilha , cTabela , "Dif. Saldo - Inventario 2 UM "  , 3 , 2 , .f. )
    //oExcel:AddColumn(cPlanilha , cTabela , "Ocorrencia"                     , 1 , 1 , .f. )
    
    aCor := {}

	While TCOT->(!EOF()) .and. cLjFil  == TCOT->FILIAL
        aDados := {}
       // FILIAL	COD	DESCR	COMP	DESCRCOMP	UM	QUANT	CUSTO	QUANT_VEN	PRECO	CUSTO_TOTAL	CUSTO_VENDA	CUSTO_TEORICO

        //nVendas     += TCMV->VENDAS
        //nValor      += TCMV->VALOR
        //nCustoTotal += TCMV->CUSTO_TOTAL
        
        AAdd(aDados,TCOT->FILIAL        )//A
        AAdd(aDados,TCOT->COD           )//B
        AAdd(aDados,TCOT->DESCR         )//C
        AAdd(aDados,TCOT->COMP          )//D
        AAdd(aDados,TCOT->DESCRCOMP     )//E
        AAdd(aDados,TCOT->UM            )//F
        AAdd(aDados,TCOT->QUANT         )//G
        AAdd(aDados,TCOT->CUSTO         )//H
        AAdd(aDados,TCOT->CUSTO_UNI     )//I
        AAdd(aDados,TCOT->QUANT_VEN     )//J
        AAdd(aDados,TCOT->CONSUMO       )//K
        AAdd(aDados,TCOT->CUSTO_TEORICO )//L

        nX++
        /*
        AAdd(aDados,TRB->Inventario_1_UM    )
        AAdd(aDados,TRB->Dif_Saldo1_Invent1 )
        AAdd(aDados,TRB->B1_SEGUM           )
        AAdd(aDados,TRB->Saldo_2_UM         )
        AAdd(aDados,TRB->INVENT_2UM         )
        AAdd(aDados,TRB->Dif_Saldo2_Invent2 )
        AAdd(aDados,TRB->Ocorrencia         )
        */
        TCOT->(DBSKIP())
        /*
        IF lX

			oExcel:SetCelBgColor("#F4B084")
			//oExcel:SetLineBold(lBold)
			//oExcel:SetCelBold(lBold)
		ELSE

			oExcel:SetCelBgColor("#FADCCA")
			//oExcel:Set2LineBold(lBold)
			//oExcel:SetCelBold(lBold)
        ENDIF
        */
        lX := !lX
        oExcel:SetCelBgColor("#FFFFFF")
        oExcel:AddRow(cPlanilha,cTabela, aDados ,aCor)

    Enddo
    /*
    //aCor :={1,2,3,4,5,6,7,8,9,10,11,12}
    For nX := 1 to 3
        
        aDados := {"","","",0,0,0,0,0,"",0,0,0}
        oExcel:AddRow(cPlanilha,cTabela, aDados,aCor)

    Next nX
    aCor :={8,9,10,11,12}
    aDados := {"","","Total Bruto R$" ,0,nValor,nCustoTotal,(nCustoTotal/nValor)*100,0,"",0,0,0}
    oExcel:AddRow(cPlanilha,cTabela, aDados,aCor)
    aCor :={6,7,8,9,10,11,12}    
    aDados := {"","","Impostos %"   ,MV_PAR07,nValor*(MV_PAR07/100),0,0,0,"",0,0,0}
    oExcel:AddRow(cPlanilha,cTabela, aDados,aCor)
    
    nValor := nValor - (nValor * (MV_PAR07 / 100 ) )
    aCor :={8,9,10,11,12}
    aDados := {"","","Total Liquido R$",0,nValor,nCustoTotal,(nCustoTotal/nValor)*100,0,"",0,0,0}
    oExcel:AddRow(cPlanilha,cTabela, aDados,aCor)
    */
Return
