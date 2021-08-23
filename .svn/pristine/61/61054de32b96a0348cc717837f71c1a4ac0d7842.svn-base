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

User Function BLESTR30()

    Local cPasta 	:= ""
    Private cPerg := "BLESTR3001"

    ValidPerg()
 
    IF Pergunte(cPerg,.T.)

        fQCMVTo()
        Processa( {|| fGeraExel(cPasta)}, "Gerando Planilha CMV Teórico...")

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
    aAdd(aRegs,{cPerg,"02","Até Filial"   ,"","","mv_ch2","C",TamSX3("B1_FILIAL")[1],0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SM0","","",""})
    aAdd(aRegs,{cPerg,"03","De Produto"   ,"","","mv_ch3","C",TamSX3("B1_COD")[1]   ,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","",""})
    aAdd(aRegs,{cPerg,"04","Até Produto"  ,"","","mv_ch4","C",TamSX3("B1_COD")[1]   ,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","SB1","","",""})
    //aAdd(aRegs,{cPerg,"05","De Armazem" ,"","","mv_ch5","C",TamSX3("B1_LOCPAD")[1],0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","NNR","","",""})
    //aAdd(aRegs,{cPerg,"06","Até Armazem","","","mv_ch6","C",TamSX3("B1_LOCPAD")[1],0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","NNR","","",""})
    aAdd(aRegs,{cPerg,"05","De Data"      ,"","","mv_ch5","D",10                    ,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","",""})
    aAdd(aRegs,{cPerg,"06","Até Data"     ,"","","mv_ch6","D",10                    ,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","",""})
    aAdd(aRegs,{cPerg,"07","Impostos %"   ,"","","mv_ch7","N",5                     ,2,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","",""   ,"","",""})
    
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

Static Function fQCMVTo()
LocaL cQuery := ""
 
//************************************************************************************
    cQuery += CRLF + " SELECT 
  
    cQuery += CRLF + "       D2_FILIAL  "
 	cQuery += CRLF + "       , COD as D2_COD  "
 	cQuery += CRLF + "       , DESCR as B1_DESC  "
 	cQuery += CRLF + "       , UM  "
 	cQuery += CRLF + "       , QUANT AS QUANT_BASE  "
 	cQuery += CRLF + "       , IIF(NIVEL = '01' AND CUSTO = 0,CUS, CUSTO) AS CUSTO_BASE   "
	cQuery += CRLF + "   	 , IIF(NIVEL = '01' AND CUSTO = 0,(CUS * QUANT), (CUSTO * QUANT)) AS CUSTO "
	cQuery += CRLF + "   	 , SUM(ISNULL(D2_QUANT,0)) AS VENDAS  "
	cQuery += CRLF + "   	 , (SUM(ISNULL(D2_QUANT,0))  * QUANT ) AS CONSUMO_TEORICO  "
 	cQuery += CRLF + "       , SUM(ISNULL(D2_PRCVEN*D2_QUANT,0))/SUM(ISNULL(D2_QUANT,1)) AS PRECO_MEDIO  "
 	cQuery += CRLF + "       , IIF(NIVEL = '01' AND CUSTO = 0 "
	cQuery += CRLF + "   	    , ((CUS  *QUANT) * (SUM(ISNULL(D2_QUANT,0)) )) "
 	cQuery += CRLF + "   	    , ((CUSTO*QUANT) * (SUM(ISNULL(D2_QUANT,0)) )) "
	cQuery += CRLF + "   	 ) AS CUSTO_TOTAL  "
	cQuery += CRLF + "   	 , SUM(ISNULL(D2_QUANT*D2_PRCVEN,0)) AS VALOR  "
 	cQuery += CRLF + "       , IIF(NIVEL = '01' AND CUSTO = 0 "
	cQuery += CRLF + "   		, IIF(((CUS  *QUANT)* SUM(ISNULL(D2_QUANT,0))) = 0  ,0, ((CUS  *QUANT)* SUM(ISNULL(D2_QUANT,0)))/SUM(ISNULL(D2_QUANT*D2_PRCVEN,1)) *100 ) "
	cQuery += CRLF + "   		, IIF(((CUSTO*QUANT)* SUM(ISNULL(D2_QUANT,0))) = 0  ,0, ((CUSTO*QUANT)* SUM(ISNULL(D2_QUANT,0)))/SUM(ISNULL(D2_QUANT*D2_PRCVEN,1)) *100 )  "
	cQuery += CRLF + "   	) AS CMV  "
	cQuery += CRLF + "   	, NIVEL "

    cQuery += CRLF + " FROM ( "
    cQuery += CRLF + " 	select B1_COD AS COD "
    cQuery += CRLF + " 		, B1_DESC AS DESCR "
    cQuery += CRLF + " 		, ISNULL(G1_COMP,B1_COD) AS COMP "
    cQuery += CRLF + " 		, (SELECT B1C.B1_DESC FROM " + RetSqlName("SB1") + " AS B1C WHERE B1C.B1_COD = ISNULL(G1.G1_COMP,B1.B1_COD) AND B1C.D_E_L_E_T_ = '') AS DESCRCOMP "
    cQuery += CRLF + " 		, (SELECT B1B.B1_UM   FROM " + RetSqlName("SB1") + " AS B1B WHERE B1B.B1_COD = ISNULL(G1.G1_COMP,B1.B1_COD) AND B1B.D_E_L_E_T_ = '') AS UM "
    cQuery += CRLF + " 		, ISNULL(G1_QUANT,1) AS QUANT "
    cQuery += CRLF + " 		, (SELECT B1A.B1_CUSTD FROM " + RetSqlName("SB1") + " AS B1A WHERE B1A.B1_COD = ISNULL(G1.G1_COMP,B1.B1_COD) AND B1A.D_E_L_E_T_ = '') AS CUSTO "
    cQuery += CRLF + " 		, ISNULL(G1_REVINI,'') AS REVISAO,B1_TIPO ,G1_NIV as NIVEL"
    
    cQuery += CRLF + " 		,( "
	cQuery += CRLF + " 		    SELECT SUM(B1_CUSTD)/SUM(D1_QUANT)  AS CUSTO "
	cQuery += CRLF + " 			    FROM " + RetSqlName("SD1") + " D1 "
	cQuery += CRLF + " 			    INNER JOIN " + RetSqlName("SB1") + " B1 "
	cQuery += CRLF + " 				    ON  B1_COD  = D1_COD "
	cQuery += CRLF + " 				    AND B1_TIPO in ('PA','PI') "
	cQuery += CRLF + " 			    INNER JOIN " + RetSqlName("SF4") + " F4 "
	cQuery += CRLF + " 				    ON  F4_CODIGO  = D1_TES "
	cQuery += CRLF + " 					AND F4_ESTOQUE = 'S' "
	cQuery += CRLF + " 					AND F4.D_E_L_E_T_ = '' "
	cQuery += CRLF + " 		    WHERE D1_FILIAL  BETWEEN '" +      MV_PAR01  + "' AND '" + MV_PAR02 + "' "
	cQuery += CRLF + " 			    AND D1_TIPO = 'N' "
	cQuery += CRLF + " 			    AND D1_DTDIGIT BETWEEN '" + DTOS(MV_PAR05) + "' AND '" + DTOS(MV_PAR06) + "'  "
	cQuery += CRLF + " 			    AND D1.D_E_L_E_T_ = '' "
	cQuery += CRLF + " 		    GROUP BY D1_FILIAL ) AS CUS "
    
    cQuery += CRLF + " 		from " + RetSqlName("SB1") + " B1 "
    cQuery += CRLF + " 		LEFT OUTER JOIN " + RetSqlName("SG1") + " G1 ON G1_COD = B1_COD AND G1_NIV = '01' AND G1.D_E_L_E_T_ = '' "

    cQuery += CRLF + " 		WHERE B1.D_E_L_E_T_ = '' AND B1_TIPO IN( 'VE','ME','PA','PI') "
    cQuery += CRLF + " 	) TRB  "
    cQuery += CRLF + " 	LEFT OUTER JOIN " + RetSqlName("SD2") + " D2 WITH (NOLOCK)  "
    cQuery += CRLF + " 			ON  D2_COD = COD  "
    cQuery += CRLF + " 			AND D2.D_E_L_E_T_ = ''   "
    cQuery += CRLF + " 			AND D2_TIPO = 'N' "
    cQuery += CRLF + "  		AND D2_EMISSAO BETWEEN '" + DTOS(MV_PAR05) + "' AND '" + DTOS(MV_PAR06) + "'  "
    CQuery += CRLF + "  		AND D2_FILIAL  BETWEEN '" +      MV_PAR01  + "' AND '" + MV_PAR02 + "' "

    cQuery += CRLF + " 	INNER JOIN " + RetSqlName("SF4") + " F4 with(NOLOCK) "
    cQuery += CRLF + " 				ON  F4_CODIGO  = D2_TES  "
    cQuery += CRLF + " 				AND F4_DUPLIC  = 'S'  "
    cQuery += CRLF + " 				AND F4_ESTOQUE = 'S' "
    cQuery += CRLF + " 	WHERE COD BETWEEN '" +  MV_PAR03  + "' AND '" + MV_PAR04 + "' ""
        
        
    cQuery += CRLF + " 	GROUP BY  "
    cQuery += CRLF + "      COD, "
    cQuery += CRLF + "      DESCR, "
    cQuery += CRLF + "      UM, "
    cQuery += CRLF + "      QUANT,  "
    cQuery += CRLF + "      CUSTO,  "
    cQuery += CRLF + "      D2_FILIAL,NIVEL,CUS "
    cQuery += CRLF + " 	ORDER BY 3 "
    //************************************************************************************

    //MEMOWRITE('C:\1\QUERY.SQL',cQuery) 
    
    if select('TCMV') == 1
        TCMV->(DbCloseArea)
    Endif
    TCQUERY cQuery NEW ALIAS "TCMV"
        
    
Return

//****************************************************************************************

//****************************************************************************************

Static Function fGeraExel(cPasta)

Local cPlanilha := "" //x Inventario Lote" 
Local cTabela   := ""
Local cArq   	:= "CMV_Teorico_" + StrTran(time(),":","")
//Local aDados 	:= {}
Local cLjFil    := ""
Private oExcel 
Default nSlv    := 1
    
    if empty(cPasta)
	    cPasta := cGetFile("", "Salvar Arquivo em", 1, "C:\", .T., GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY) 
    EndIf
	
    //Cria o Objeto para criar a Planilha XML
	oExcel := FwMsExcelEx():New()
    
    DbSelectArea('TCMV')
    TCMV->(DbGotop())

    while !TCMV->(EOF())
        cLjFil    := TCMV->D2_FILIAL
        cPlanilha := "CMV Loja: " + cLjFil 
        cTabela   := "CMV Teorio: " + cLjFil 
        
        //Define a Planilha
        fPCMV(oExcel,cPlanilha,cTabela,cLjFil )
    
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
    TCMV->(DbCloseArea())
Return

//********************************************************************************************************


//********************************************************************************************************

Static Function fPCMV(oExcel,cPlanilha,cTabela,cLjFil)
Local aDados := {}
Local lX := .T.
Local nX := 3
Local nVendas := 0
Local nValor := 0
Local nCustoTotal := 0
//Local cImposto := 0

//Define a Tabela na Planilha
    oExcel:AddWorkSheet(cPlanilha)

	oExcel:AddTable(cPlanilha,cTabela)

    oExcel:AddColumn(cPlanilha , cTabela , "Filial"                 , 1 , 1 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Produto"                , 1 , 1 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Descrição"              , 1 , 1 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Vendas"                 , 3 , 2 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Valor"                  , 3 , 2 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Custo"                  , 3 , 2 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Custo Total"            , 3 , 2 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "CMV Teorico(Bruto)(%)"  , 3 , 2 , .f. )
    
    oExcel:AddColumn(cPlanilha , cTabela , space(10)                , 1 , 1 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Preço Medio"            , 3 , 2 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Preço Cardapio"         , 3 , 2 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Diferença(%)"           , 3 , 2 , .f. )
    /*oExcel:AddColumn(cPlanilha , cTabela , "Inventario 2 UM"                , 3 , 2 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Dif. Saldo - Inventario 2 UM "  , 3 , 2 , .f. )
    oExcel:AddColumn(cPlanilha , cTabela , "Ocorrencia"                     , 1 , 1 , .f. )
    */
    aCor := {9}

	While TCMV->(!EOF()) .and. cLjFil  == TCMV->D2_FILIAL
        aDados := {}
        nCusto := 0
        nTotal := 0
        nCMV   := 0
        cCod   := TCMV->D2_COD 

        nVendas     += TCMV->VENDAS
        nValor      += TCMV->VALOR
        
        cMedio      := TCMV->PRECO_MEDIO

        AAdd(aDados, TCMV->D2_FILIAL )//A
        AAdd(aDados, TCMV->D2_COD    )//B
        AAdd(aDados, TCMV->B1_DESC   )//C
        AAdd(aDados, TCMV->VENDAS    )//D
        AAdd(aDados, TCMV->VALOR     )//E
                
        while TCMV->D2_COD == cCod
            nCusto  += TCMV->CUSTO 
            nTotal  += TCMV->CUSTO_TOTAL
            nCMV    += TCMV->CMV
            nCustoTotal += TCMV->CUSTO_TOTAL
        
            nX++
        
            TCMV->(DBSKIP())
        Enddo
        AAdd(aDados, nCusto          )//F
        AAdd(aDados, nTotal          )//G
        AAdd(aDados, nCMV            )//H

        AAdd(aDados,Space(10)        )//I
        AAdd(aDados,cMedio           )//J
        AAdd(aDados,0                )//K
        AAdd(aDados,0                )//L

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
    aCor :={1,2,3,4,5,6,7,8,9,10,11,12}
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
	
Return
