#Include "Totvs.ch"

/*/{Protheus.doc} User Function BDLML006
    (long_description)
    @type  Function 
    @author Douglas Silva
    @since 09/12/2020
    @version 2.2
	@update Felipe Mayer 02/06/2021 - Grupo de venda nas consultas
	@update Felipe Mayer 09/07/2021 - Inclusão de campos chamado #68947 / #69036 
/*/

User Function BDLML006()
    
    Local aParamBox := {}
	Local aCombo := {"Pedidos em Aberto","Notas Faturamento"}
	Private aRet := {}

RPCSetType(3) 
RpcSetEnv('01','0101',,,,GetEnvServer(),{ })

	aAdd(aParamBox,{2,"Tabela",2,aCombo,90,"",.T.})	//01
    //aAdd(aParamBox,{1,"Filial",Space(4),"","","NNR","",0,.F.}) // 02

	aAdd(aParamBox,{1,"Emissão De" ,Ctod(Space(8)),"","","","",50,.F.}) //03
	aAdd(aParamBox,{1,"Emissão Ate",Ctod(Space(8)),"","","","",50,.F.}) //04
	
	
	If ParamBox(aParamBox,"Relatório Faturamento SM...",@aRet)
	
		If ( ValType( aRet [1] ) == "N" .And. aRet [1] == 1 ) .Or.  ( ValType( aRet [1] ) == "C" .And. aRet [1] == "Pedidos em Aberto" )
			xProc1()
		ElseIf ( ValType( aRet [1] ) == "N" .And. aRet [1] == 2 ) .Or.  ( ValType( aRet [1] ) == "C" .And. aRet [1] == "Notas Faturamento" )
			xProc2()							
		EndIf
	  
	Endif

Return 

Static Function xProc1()

	cQuery := CRLF + " SELECT A1_COD, A1_LOJA, A1_NOME, A1_NREDUZ, SC6.C6_NUM, "
	cQuery += CRLF + "		SUBSTRING(SC6.C6_ENTREG,7,2) + '/' + SUBSTRING(SC6.C6_ENTREG ,5,2) + '/' + SUBSTRING(SC6.C6_ENTREG ,1,4) "
	cQuery += CRLF + "		C6_ENTREG, SC6.C6_PRODUTO, SB1.B1_DESC, SC6.C6_PRCVEN, SC6.C6_QTDVEN, SC6.C6_VALOR , "
	cQuery += CRLF + "		ISNULL(A1_GRPVEN,'') GRUPO_VEND,ISNULL(ACY_DESCRI,'') DESC_GPVEND, ISNULL(C5_XPEDCLI,'') PEDIDO_CLIENTE "
	cQuery += CRLF + " FROM "+RetSqlName('SA1')+" SA1 "
	cQuery += CRLF + " JOIN "+RetSqlName('SC6')+" SC6 "
	cQuery += CRLF + "		ON SC6.C6_FILIAL = '0072' "
	cQuery += CRLF + "		AND SC6.C6_CLI = SA1.A1_COD "
	cQuery += CRLF + "		AND SC6.C6_LOJA = SA1.A1_LOJA "
	cQuery += CRLF + "		AND SC6.C6_NOTA = '' "
	cQuery += CRLF + "		AND SC6.D_E_L_E_T_ != '*' "
	cQuery += CRLF + " JOIN "+RetSqlName('SC5')+" SC5 "
	cQuery += CRLF + "		ON SC6.C6_FILIAL=SC5.C5_FILIAL "
	cQuery += CRLF + "		AND SC6.C6_NUM=SC5.C5_NUM "
	cQuery += CRLF + "		AND SC6.C6_CLI=SC5.C5_CLIENTE "
	cQuery += CRLF + "		AND SC6.C6_LOJA=SC5.C5_LOJACLI "
	cQuery += CRLF + "		AND SC5.D_E_L_E_T_ != '*' "
	cQuery += CRLF + " JOIN "+RetSqlName('SB1')+" SB1 "
	cQuery += CRLF + " 		ON SB1.B1_FILIAL = '"+xFilial('SB1')+"' "
	cQuery += CRLF + "		AND SB1.B1_COD = SC6.C6_PRODUTO  "
	cQuery += CRLF + "		AND SB1.D_E_L_E_T_ != '*' "
	cQuery += CRLF + " LEFT JOIN "+RetSqlName('ACY')+" ACY "
	cQuery += CRLF + " 		ON ACY_FILIAL='"+xFilial('ACY')+"' "
	cQuery += CRLF + "		AND ACY_GRPVEN=A1_GRPVEN "
	cQuery += CRLF + " WHERE SA1.D_E_L_E_T_ != '*'  "
	cQuery += CRLF + " ORDER BY 1,2 "

	U_QRYCSV(cQuery,"Pedidos em Aberto")

Return

Static Function xProc2()

	cQuery := CRLF + " SELECT  A1_COD,A1_LOJA,A1_NOME,A1_NREDUZ,A1_END,A1_BAIRRO,A1_MUN,A1_EST,ENTRADA,EMISSAO,DIAA, "
	cQuery += CRLF + " 		MESS,ANOO,Tipo,D2_FILIAL,D2_PEDIDO,D2_DOC,D2_CF,D2_SERIE,D2_ITEM,D2_COD,B1_DESC, "
	cQuery += CRLF + " 		D2_PRCVEN,D2_QUANT,D2_TOTAL,D2_VALBRUT,BASE_ICMS,VLR_ICMS,BASE_IPI,VLR_IPI,VLR_BASE_RET, "
	cQuery += CRLF + " 		ST,BASE_PIS,ALIQ_PIS,VLR_PIS,BASE_COFINS,ALIQ_COFINS,VAL_COFINS,VLR_ICMS,TB.Quant_Origem, "
	cQuery += CRLF + " 		Valor_Original,Dt_Dev,Doc_Dev,Serie_Dev,Item_Dev,D2_LOTECTL,ISNULL(A1_GRPVEN,'') GRUPO_VEND, "
	cQuery += CRLF + " 		ISNULL(ACY_DESCRI,'') DESC_GPVEND,ISNULL(C5_XPEDCLI,'') PEDIDO_CLIENTE "
	cQuery += CRLF + " FROM ( SELECT "
	cQuery += CRLF + "  		SD1.D1_FORNECE D2_CLIENTE, "
	cQuery += CRLF + "  		SD1.D1_LOJA D2_LOJA, "
	cQuery += CRLF + " 			SD1.D1_EMISSAO EMISSAO, "
	cQuery += CRLF + " 			SD1.D1_DTDIGIT ENTRADA, "
	cQuery += CRLF + "  		SUBSTRING(SD1.D1_EMISSAO,7,2) 'DIAA' , "
	cQuery += CRLF + "  		SUBSTRING(SD1.D1_EMISSAO,5,2) 'MESS' , "
	cQuery += CRLF + "  		SUBSTRING(SD1.D1_EMISSAO,1,4) 'ANOO' , "
	cQuery += CRLF + "  		'Devolucao' Tipo, "
	cQuery += CRLF + "  		SD2.D2_FILIAL, "
	cQuery += CRLF + "  		SD2.D2_PEDIDO, "
	cQuery += CRLF + "  		SD2.D2_DOC , "
	cQuery += CRLF + " 			SD2.D2_CF, "
	cQuery += CRLF + "  		SD2.D2_SERIE, "
	cQuery += CRLF + "  		SD2.D2_ITEM , "
	cQuery += CRLF + "  		SD2.D2_COD, "
	cQuery += CRLF + "  		SD2.D2_PRCVEN, "
	cQuery += CRLF + "  		(SD2.D2_QUANT* (-1)) D2_QUANT, "
	cQuery += CRLF + "  		(SD1.D1_TOTAL + SD1.D1_VALIPI + SD1.D1_ICMSRET) AS D2_TOTAL, "
	cQuery += CRLF + "  		(SD1.D1_TOTAL + SD1.D1_VALIPI + SD1.D1_ICMSRET) AS D2_VALBRUT,  "
	cQuery += CRLF + " 			SD1.D1_BASEICM BASE_ICMS, "
	cQuery += CRLF + " 			SD1.D1_VALICM VLR_ICMS, "
	cQuery += CRLF + " 			SD1.D1_BASEIPI BASE_IPI, "
	cQuery += CRLF + " 			SD1.D1_VALIPI VLR_IPI, "
	cQuery += CRLF + " 			SD1.D1_BRICMS VLR_BASE_RET, "
	cQuery += CRLF + " 			SD1.D1_ICMSRET ST, "
	cQuery += CRLF + " 			SD1.D1_BASIMP5 BASE_PIS, "
	cQuery += CRLF + " 			SD1.D1_ALQPIS ALIQ_PIS, "
	cQuery += CRLF + " 			SD1.D1_VALIMP6 VLR_PIS, "
	cQuery += CRLF + " 			SD1.D1_BASIMP6 BASE_COFINS, "
	cQuery += CRLF + " 			SD1.D1_ALQIMP5 ALIQ_COFINS, "
	cQuery += CRLF + " 			SD1.D1_VALIMP5 VAL_COFINS, "
	cQuery += CRLF + "  		ISNULL(SD2.D2_QUANT  ,0  ) AS 'Quant_Origem', "
	cQuery += CRLF + "  		ISNULL(SD2.D2_VALBRUT,0  ) As 'Valor_Original', "
	cQuery += CRLF + "  		ISNULL(SD1.D1_EMISSAO, '') AS 'Dt_Dev', "
	cQuery += CRLF + "  		ISNULL(SD1.D1_DOC    , '') AS 'Doc_Dev', "
	cQuery += CRLF + "  		ISNULL(SD1.D1_SERIE  , '') As 'Serie_Dev', "
	cQuery += CRLF + "  		ISNULL(SD1.D1_ITEM   , '') As 'Item_Dev', "
	cQuery += CRLF + "  		SD2.D2_LOTECTL, "
	cQuery += CRLF + "  		D2_DTVALID "
	cQuery += CRLF + "  	FROM "+RetSqlName('SD1')+" SD1   "
	cQuery += CRLF + "  		INNER JOIN "+RetSqlName('SD2')+" SD2 ON  "
	cQuery += CRLF + "  			SD1.D1_FILIAL      = SD2.D2_FILIAL  "
	cQuery += CRLF + "  			AND SD1.D1_COD     = SD2.D2_COD  "
	cQuery += CRLF + "  			AND SD1.D1_NFORI   = SD2.D2_DOC  "
	cQuery += CRLF + "  			AND SD1.D1_SERIORI = SD2.D2_SERIE  "
	cQuery += CRLF + "  			AND SD1.D1_FORNECE = SD2.D2_CLIENTE  "
	cQuery += CRLF + "  			AND SD1.D1_LOJA    = SD2.D2_LOJA  "
	cQuery += CRLF + "  			AND SD2.D2_ITEM    = SD1.D1_ITEMORI "
	cQuery += CRLF + "  			AND SD2.D_E_L_E_T_ != '*'  "
	cQuery += CRLF + "  		INNER JOIN "+RetSqlName('SF4')+" SF4 ON  "
	cQuery += CRLF + "  			SF4.F4_FILIAL = '"+xFilial('SF4')+"'  "
	cQuery += CRLF + "  			AND SF4.F4_CODIGO  = SD2.D2_TES  "
	cQuery += CRLF + "  			AND SF4.D_E_L_E_T_ != '*'  "
	cQuery += CRLF + "  			AND SF4.F4_DUPLIC  = 'S'  "
	cQuery += CRLF + "  	WHERE  "
	cQuery += CRLF + "  		SD2.D2_FILIAL  = '0072'  "
	cQuery += CRLF + "  		AND SD2.D2_TIPO    = 'N'  "
	cQuery += CRLF + "  		AND SD2.D_E_L_E_T_ != '*' "
	cQuery += CRLF + "  		AND SD1.D1_TIPO     = 'D' "
	cQuery += CRLF + "  		AND SD1.D1_DTDIGIT  BETWEEN '"+DToS(MV_PAR02)+"' AND '"+DToS(MV_PAR03)+"' "
	cQuery += CRLF + "  	UNION "
	cQuery += CRLF + "  	SELECT   "
	cQuery += CRLF + "  		D2_CLIENTE, "
	cQuery += CRLF + "  		D2_LOJA, "
	cQuery += CRLF + " 			SD2.D2_EMISSAO ENTRADA, "
	cQuery += CRLF + " 			SD2.D2_EMISSAO EMISSAO, "
	cQuery += CRLF + "  		SUBSTRING(SD2.D2_EMISSAO,7,2) 'DIAA' ,   "
	cQuery += CRLF + "  		SUBSTRING(SD2.D2_EMISSAO,5,2) 'MESS' ,   "
	cQuery += CRLF + "  		SUBSTRING(SD2.D2_EMISSAO,1,4) 'ANOO' ,   "
	cQuery += CRLF + "  		CASE WHEN substring(F4_CF,2,3) = '910'  "
	cQuery += CRLF + "  			THEN 'Bonificacao'  "
	cQuery += CRLF + "  			ELSE 'Venda'   "
	cQuery += CRLF + "  		END AS Tipo, "
	cQuery += CRLF + "  		SD2.D2_FILIAL, "
	cQuery += CRLF + "  		SD2.D2_PEDIDO, "
	cQuery += CRLF + "  		SD2.D2_DOC, "
	cQuery += CRLF + " 			SD2.D2_CF, "
	cQuery += CRLF + "  		SD2.D2_SERIE,  "
	cQuery += CRLF + "  		SD2.D2_ITEM,  "
	cQuery += CRLF + "  		SD2.D2_COD, "
	cQuery += CRLF + "  		SD2.D2_PRCVEN, "
	cQuery += CRLF + "  		SD2.D2_QUANT, "
	cQuery += CRLF + "  		SD2.D2_TOTAL, "
	cQuery += CRLF + "  		SD2.D2_VALBRUT, "
	cQuery += CRLF + " 			SD2.D2_BASEICM BASE_ICMS, "
	cQuery += CRLF + " 			SD2.D2_VALICM VLR_ICMS, "
	cQuery += CRLF + " 			SD2.D2_BASEIPI BASE_IPI, "
	cQuery += CRLF + " 			SD2.D2_VALIPI VLR_IPI, "
	cQuery += CRLF + " 			SD2.D2_BRICMS VLR_BASE_RET, "
	cQuery += CRLF + " 			SD2.D2_ICMSRET ST, "
	cQuery += CRLF + " 			SD2.D2_BASIMP5 BASE_PIS, "
	cQuery += CRLF + " 			SD2.D2_ALQPIS ALIQ_PIS, "
	cQuery += CRLF + " 			SD2.D2_VALIMP6 VLR_PIS, "
	cQuery += CRLF + " 			SD2.D2_BASIMP6 BASE_COFINS, "
	cQuery += CRLF + " 			SD2.D2_ALQIMP5 ALIQ_COFINS, "
	cQuery += CRLF + " 			SD2.D2_VALIMP5 VAL_COFINS, "
	cQuery += CRLF + "  		0 AS 'Quant_Origem',  "
	cQuery += CRLF + "  		0 AS 'Valor_Original', "
	cQuery += CRLF + "  		'        '  AS 'Dt_Dev', "
	cQuery += CRLF + "  		'        '  AS 'Doc_Dev',  "
	cQuery += CRLF + "  		' '         AS 'Serie_Dev',  "
	cQuery += CRLF + "  		' '         AS 'Item_Dev',  "
	cQuery += CRLF + "  		SD2.D2_LOTECTL, "
	cQuery += CRLF + "  		SD2.D2_DTVALID "
	cQuery += CRLF + "  	FROM "+RetSqlName('SD2')+" SD2 "
	cQuery += CRLF + "  	JOIN "+RetSqlName('SF4')+" SF4  "
	cQuery += CRLF + "  		ON SF4.F4_FILIAL = '"+xFilial('SF4')+"'  "
	cQuery += CRLF + "  		AND SF4.F4_CODIGO = SD2.D2_TES  "
	cQuery += CRLF + "  		AND SF4.D_E_L_E_T_ != '*'  "
	cQuery += CRLF + "  		AND (SF4.F4_DUPLIC = 'S' OR F4_CF in ('5910','6910'))  "
	cQuery += CRLF + "  	WHERE "
	cQuery += CRLF + "    		SD2.D2_FILIAL = '0072'  "
	cQuery += CRLF + "  		AND SD2.D2_TIPO = 'N' "
	cQuery += CRLF + "  		AND SD2.D_E_L_E_T_ != '*' "
	cQuery += CRLF + "  		AND SD2.D2_EMISSAO  BETWEEN '"+DToS(MV_PAR02)+"' AND '"+DToS(MV_PAR03)+"') AS TB "
	cQuery += CRLF + "		JOIN "+RetSqlName('SF2')+" SF2 "
	cQuery += CRLF + "			ON F2_FILIAL=D2_FILIAL "
	cQuery += CRLF + "			AND F2_DOC=D2_DOC "
	cQuery += CRLF + "			AND F2_SERIE=D2_SERIE "
	cQuery += CRLF + "			AND F2_CLIENTE=D2_CLIENTE "
	cQuery += CRLF + "			AND F2_LOJA=D2_LOJA "
	cQuery += CRLF + "			AND F2_EMISSAO=EMISSAO "
	cQuery += CRLF + "		LEFT JOIN "+RetSqlName('SC5')+" SC5 "
	cQuery += CRLF + "			ON C5_FILIAL = F2_FILIAL "
	cQuery += CRLF + "			AND C5_CLIENTE = F2_CLIENTE "
	cQuery += CRLF + "			AND C5_LOJACLI = F2_LOJA "
	cQuery += CRLF + "			AND C5_NOTA = F2_DOC "
	cQuery += CRLF + "			AND C5_SERIE = F2_SERIE "
	cQuery += CRLF + "  	JOIN "+RetSqlName('SA1')+" SA1  "
	cQuery += CRLF + "  		ON SA1.A1_FILIAL   = '"+xFilial('SA1')+"' "
	cQuery += CRLF + "  		AND SA1.A1_COD     = D2_CLIENTE "
	cQuery += CRLF + "  		AND SA1.A1_LOJA    = D2_LOJA  "
	cQuery += CRLF + "  		AND SA1.D_E_L_E_T_ <> '*'  "
	cQuery += CRLF + "  	JOIN "+RetSqlName('SB1')+" SB1  "
	cQuery += CRLF + "  		ON  B1_COD    = D2_COD "
	cQuery += CRLF + "  		AND B1_FILIAL = '"+xFilial('SB1')+"' "
	cQuery += CRLF + " 	 	LEFT JOIN "+RetSqlName('ACY')+" ACY ON "
	cQuery += CRLF + "  		ACY_FILIAL='"+xFilial('ACY')+"' "
	cQuery += CRLF + " 			AND ACY_GRPVEN=A1_GRPVEN "
	cQuery += CRLF + "  ORDER BY 5,6,7 "


   	//Chamada função para gerar em Excel
	U_QRYCSV(cQuery,"Notas Faturamento")

Return
