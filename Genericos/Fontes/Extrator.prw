#Include "Totvs.ch"
#include "fileio.ch"
  
/*/{Protheus.doc} Extrator
	@Desc Fun??o tem como objetivo gerar querys e exportar em excel
	@author Douglas Silva
	@since 03/01/2019
	@update 24/05/2021 - Felipe Mayer
	@version 2.0
	@obs Cuidado com colunas com mais de 200 caracteres, pode ser que o Excel d? erro ao abrir o XML
/*/
  
User Function Extrator()

	Local aParamBox := {}
	Local aCombo := {"SD1 - Itens Doc Entrada","SD2 - Itens Doc Sa?da","SD2 - Itens Doc Sa?da Sumarizado","SE2 - Contas a Pagar",;
					"SE2 - Contas a Pagar x Natureza","SFT - Livros Fiscais","SC7 - Pedido de Compras","CENTRAL XML","CENTRAL XML CTE",;
					"INVENTARIO","INVENTARIO PENDENTE",'Pedidos Venda em Aberto SM', "Corte de Pedidos - SM" }
	Private aRet := {}
		
	aAdd(aParamBox,{2,"Tabela",2,aCombo,90,"",.T.})
	aAdd(aParamBox,{1,"Emiss?o De"  ,Ctod(Space(8)),"","","","",50,.T.})
	aAdd(aParamBox,{1,"Emiss?o Ate"  ,Ctod(Space(8)),"","","","",50,.T.})
	aAdd(aParamBox,{3,"Tipo Lanc",1,{"Entrada","Sa?da","Ambos"},50,"",.F.})
	
	
	If ParamBox(aParamBox,"Extrator Dados...",@aRet)
		If (ValType(aRet[1])=="N".And.aRet[1]==1).Or.(ValType(aRet[1])=="C".And.aRet[1]=="SD1 - Itens Doc Entrada")
			xProc1()
		ElseIf (ValType(aRet[1])=="N".And.aRet[1]==2).Or.(ValType(aRet[1])=="C".And.aRet[1]=="SD2 - Itens Doc Sa?da")
			xProc2()	
		ElseIf (ValType(aRet[1])=="N".And.aRet[1]==3).Or.(ValType(aRet[1])=="C".And.aRet[1]=="SD2 - Itens Doc Sa?da Sumarizado")
			xProc3()		
		ElseIf (ValType(aRet[1])=="N".And.aRet[1]==4).Or.(ValType(aRet[1])=="C".And.aRet[1]=="SE2 - Contas a Pagar")
			xProc4()
		ElseIf (ValType(aRet[1])=="N".And.aRet[1]==5).Or.(ValType(aRet[1])=="C".And.aRet[1]=="SE2 - Contas a Pagar x Natureza")
			xProc5()
		ElseIf (ValType(aRet[1])=="N".And.aRet[1]==6).Or.(ValType(aRet[1])=="C".And.aRet[1]=="SFT - Livros Fiscais")
			xProc6()
		ElseIf (ValType(aRet[1])=="N".And.aRet[1]==7).Or.(ValType(aRet[1])=="C".And.aRet[1]=="CENTRAL XML")
			xProc7()
		ElseIf (ValType(aRet[1])=="N".And.aRet[1]==8).Or.(ValType(aRet[1])=="C".And.aRet[1]=="CENTRAL XML CTE")
			xProc8()
		ElseIf (ValType(aRet[1])=="N".And.aRet[1]==9).Or.(ValType(aRet[1])=="C".And.aRet[1]=="Pedidos Venda em Aberto SM")
			xProc13()	
		ElseIf (ValType(aRet[1])=="N".And.aRet[1]==10).Or.(ValType(aRet[1])=="C".And.aRet[1]=="Corte de Pedidos - SM")
			xProc14()							
		EndIf
	Endif

Return

Static Function xProc1()

	cQuery := " SELECT "                                 
	cQuery += " D1_FILIAL,D1_DOC,D1_SERIE, D1_COD, B1_DESC, D1_CC,D1_TOTAL,D1_BASEICM,D1_PICM,D1_VALICM,D1_ICMSRET ICMS_Solid, "
	cQuery += " D1_DIFAL ICMS_Difal,D1_TES,D1_OPER,D1_CF,D1_DESC, SUBSTRING(D1_EMISSAO,7,2) + '/' + SUBSTRING(D1_EMISSAO ,5,2) + '/' + SUBSTRING(D1_EMISSAO ,1,4) D1_EMISSAO, "                                
	cQuery += " SUBSTRING(D1_DTDIGIT,7,2) + '/' + SUBSTRING(D1_DTDIGIT ,5,2) + '/' + SUBSTRING(D1_DTDIGIT ,1,4) D1_DTDIGIT, D1_BASEICM "                                
	cQuery += " FROM "+RETSQLNAME("SD1")+" D1 "                                 
	cQuery += " JOIN "+RETSQLNAME("SB1")+" B1 ON B1_FILIAL = '' AND D1_COD = B1_COD AND B1.D_E_L_E_T_ = '' "
	cQuery += " WHERE " 
	cQuery += " 	D1.D1_FILIAL != '' "
	cQuery += " 	AND D1.D_E_L_E_T_=''  "
	cQuery += " 	AND D1_DTDIGIT BETWEEN '"+Dtos(aRet[2])+"' AND '"+Dtos(aRet[3])+"' "                                
	cQuery += " ORDER BY D1_FILIAL,D1_DOC,D1_SERIE,D1_FORNECE,D1_LOJA "

	U_QRYCSV(cQuery,"SD1 - Itens NF Entrada")

Return

Static Function xProc2()

	cQuery := " SELECT " 
	cQuery += " D2_FILIAL, D2_DOC, D2_SERIE,D2_ESPECIE, D2_COD, B1_DESC, D2_QUANT ,D2_CCUSTO,D2_PDV,D2_TOTAL,D2_BASEICM,D2_VALIPI,D2_PICM, " 
	cQuery += " D2_VALICM,D2_ICMSRET ICMS_Solid,D2_DIFAL ICMS_Difal, D2_TES, D2_CF, D2_DESC ,SUBSTRING(D2_EMISSAO,7,2) + '/' + SUBSTRING(D2_EMISSAO ,5,2) + '/' + SUBSTRING(D2_EMISSAO ,1,4) D2_EMISSAO , " 
	cQuery += " D2_BASEICM,D2_BASIMP6 BASE_PIS, D2_VALIMP6 VALOR_PIS, F4_CSTPIS CST_PIS, D2_BASIMP5 BASE_COFINS, D2_VALIMP5 VALOR_COFINS, F4_CSTCOF CST_COFINS "
	cQuery += " FROM "+RETSQLNAME("SD2")+" D2 (NOLOCK) "
	cQuery += " JOIN "+RETSQLNAME("SB1")+" B1 ON B1_FILIAL = '' AND D2_COD = B1_COD AND B1.D_E_L_E_T_ = '' "
	cQuery += " JOIN "+RETSQLNAME("SF4")+" F4  (NOLOCK)ON F4_FILIAL = '' AND F4_CODIGO = D2_TES AND F4.D_E_L_E_T_ = '' "
	cQuery += " WHERE D2.D2_FILIAL != '' " 
	cQuery += " 	AND D2.D_E_L_E_T_='' " 
	cQuery += " 	AND D2_EMISSAO BETWEEN '"+Dtos(aRet[2])+"' AND '"+Dtos(aRet[3])+"' "
	cQuery += " ORDER BY D2_FILIAL,D2_DOC,D2_SERIE "
	
	U_QRYCSV(cQuery,"SD2 - Itens NF Saida")
	
Return	


Static Function xProc3()

	cQuery := " SELECT D2_FILIAL, D2_COD, B1_DESC, SUM(D2_QUANT) D2_QUANT ,D2_CCUSTO, SUM(D2_TOTAL) D2_TOTAL, " 
	cQuery += " 	SUM(D2_BASEICM) D2_BASEICM,D2_VALIPI, AVG(D2_PICM) D2_PICM, SUM(D2_VALICM) D2_VALICM, SUM(D2_ICMSRET) ICMS_Solid, " 
	cQuery += " 	SUM(D2_DIFAL) ICMS_Difal, D2_TES, D2_CF, SUM(D2_DESC) D2_DESC ,SUBSTRING(D2_EMISSAO,7,2) + '/' + SUBSTRING(D2_EMISSAO ,5,2) + '/' + SUBSTRING(D2_EMISSAO ,1,4) D2_EMISSAO, " 
	cQuery += " 	SUM(D2_BASEICM) D2_BASEICM,SUM(D2_BASIMP6) BASE_PIS, SUM(D2_VALIMP6) VALOR_PIS, F4_CSTPIS CST_PIS, " 
	cQuery += " 	SUM(D2_BASIMP5) BASE_COFINS, SUM(D2_VALIMP5) VALOR_COFINS, F4_CSTCOF CST_COFINS, B1_POSIPI NCM "
	cQuery += " FROM "+RETSQLNAME("SD2")+" D2 (NOLOCK) "
	cQuery += " JOIN "+RETSQLNAME("SB1")+" B1 (NOLOCK) ON B1_FILIAL = '' AND D2_COD = B1_COD AND B1.D_E_L_E_T_ = '' "
	cQuery += " JOIN "+RETSQLNAME("SF4")+" F4  (NOLOCK) ON F4_FILIAL = '' AND F4_CODIGO = D2_TES AND F4.D_E_L_E_T_ = '' "
	cQuery += " WHERE D2.D2_FILIAL != '' " 
	cQuery += " 	AND D2.D_E_L_E_T_='' " 
	cQuery += " 	AND D2_EMISSAO BETWEEN '"+Dtos(aRet[2])+"' AND '"+Dtos(aRet[3])+"' "
	cQuery += " GROUP BY D2_FILIAL, D2_COD, B1_DESC, D2_CCUSTO, D2_TES, D2_CF, F4_CSTCOF, SUBSTRING(D2_EMISSAO,7,2) + '\/' + SUBSTRING(D2_EMISSAO ,5,2) + '\/' + SUBSTRING(D2_EMISSAO ,1,4),F4_CSTPIS, B1_POSIPI "
	cQuery += " ORDER BY D2_FILIAL, D2_CCUSTO, D2_EMISSAO, D2_TES "
	
	U_QRYCSV(cQuery,"SD2 - Itens NF Saida - Sumarizado")
	
Return	

Static Function xProc4()

	cQuery := " SELECT ISNULL(F1_ESPECIE,'FIN') F1_ESPECIE,ISNULL(F1_FILIAL,E2_FILORIG)F1_FILIAL ,E2_FILORIG, E2_PREFIXO,E2_NUM,E2_PARCELA, "  + CRLF  
 	cQuery += " E2_TIPO,E2_NATUREZ,E2_FORNECE,E2_LOJA,E2_FATURA,E2_FATPREF,E2_NOMFOR, "  + CRLF  
 	cQuery += " SUBSTRING(E2_EMISSAO,7,2) + '/' + SUBSTRING(E2_EMISSAO ,5,2) + '/' + SUBSTRING(E2_EMISSAO ,1,4) E2_EMISSAO, "  + CRLF  
 	cQuery += " ISNULL(SUBSTRING(F1_DTDIGIT,7,2) + '/' + SUBSTRING(F1_DTDIGIT ,5,2) + '/' + SUBSTRING(F1_DTDIGIT ,1,4),'') F1_DTDIGIT, "  + CRLF 
	cQuery += " ISNULL(SUBSTRING(F1_RECBMTO,7,2) + '/' + SUBSTRING(F1_RECBMTO ,5,2) + '/' + SUBSTRING(F1_RECBMTO ,1,4),'') F1_RECBMTO, "  + CRLF  
 	cQuery += " SUBSTRING(E2_VENCTO,7,2) + '/' + SUBSTRING(E2_VENCTO ,5,2) + '/' + SUBSTRING(E2_VENCTO ,1,4) E2_VENCTO, "  + CRLF  
 	cQuery += " E2_VALOR,ISNULL(F1_VALBRUT,E2_VALOR) F1_VALBRUT, E2_BASEIRF,E2_IRRF,E2_VRETIRF, "  + CRLF  
 	cQuery += " SUBSTRING(E2_BAIXA,7,2) + '/' + SUBSTRING(E2_BAIXA ,5,2) + '/' + SUBSTRING(E2_BAIXA ,1,4) E2_BAIXA, "  + CRLF  
	cQuery += " SUBSTRING(E2_EMIS1,7,2) + '/' + SUBSTRING(E2_EMIS1 ,5,2) + '/' + SUBSTRING(E2_EMIS1 ,1,4) E2_EMIS1, "  + CRLF  
 	cQuery += " E2_INSS,E2_PIS,E2_COFINS,E2_CSLL,E2_VRETPIS,E2_VRETCOF,E2_VRETCSL,E2_BASEPIS,E2_VRETISS,E2_BASEISS,E2_VRETINS,E2_BASEINS "  + CRLF  
	cQuery += " FROM "+RETSQLNAME("SE2")+" (nolock) SE2 "  + CRLF  
 	cQuery += " LEFT JOIN "+RETSQLNAME("SF1")+" F1 ON F1_FILIAL != '' AND F1_DOC = E2_NUM AND F1_FORNECE = E2_FORNECE AND F1_LOJA = E2_LOJA AND F1_SERIE = E2_PREFIXO "  + CRLF  
 	cQuery += " WHERE SE2.E2_FILIAL = '' "  + CRLF   
 	cQuery += " AND SE2.D_E_L_E_T_='' "  + CRLF  
 	cQuery += " AND SE2.E2_EMIS1 BETWEEN '"+Dtos(aRet[2])+"' AND '"+Dtos(aRet[3])+"' "  + CRLF 
	cQuery += " ORDER BY F1_FILIAL,E2_NUM "  + CRLF 

	U_QRYCSV(cQuery,"SE2 - Contas a Pagar")
	
Return	

Static Function xProc5()

	cQuery := " SELECT  " 
	cQuery += " 	E2_FILORIG, "
	cQuery += " 	E2_NUM, "
	cQuery += " 	E2_PREFIXO, "
	cQuery += " 	E2_PARCELA,
	cQuery += " 	E2_FORNECE, "
	cQuery += " 	E2_LOJA, "
	cQuery += " 	E2_NOMFOR, "
	cQuery += " 	E2_VALOR, "
	cQuery += " 	SUBSTRING(E2_EMISSAO,7,2) + '/' + SUBSTRING(E2_EMISSAO ,5,2) + '/' + SUBSTRING(E2_EMISSAO ,1,4) E2_EMISSAO, "
	cQuery += " 	SUBSTRING(E2_VENCREA,7,2) + '/' + SUBSTRING(E2_VENCREA ,5,2) + '/' + SUBSTRING(E2_VENCREA ,1,4) E2_VENCREA, "
	cQuery += " 	SUBSTRING(E2_EMIS1,7,2) + '/' + SUBSTRING(E2_EMIS1 ,5,2) + '/' + SUBSTRING(E2_EMIS1 ,1,4) E2_EMIS1, "
	cQuery += " 	CASE WHEN EV_NATUREZ IS NULL THEN E2_NATUREZ ELSE EV_NATUREZ END EV_NATUREZ, "
	cQuery += " 	CASE WHEN ED.ED_DESCRIC IS NULL THEN ED2.ED_DESCRIC ELSE ED.ED_DESCRIC END ED_DESCRIC, "
	cQuery += " 	CASE WHEN EV_VALOR IS NULL THEN E2_VALOR ELSE EV_VALOR END VALOR, "
	cQuery += " 	CASE WHEN EZ_CCUSTO IS NULL THEN E2_CCUSTO ELSE EZ_CCUSTO END EZ_CCUSTO, "
	cQuery += " 	CTT_DESC01 CTT_DESC01, "
	cQuery += " 	EZ_VALOR EZ_VALOR, "
	cQuery += " 	EZ_PERC * 100 EZ_PERC " 
	cQuery += " FROM "+RETSQLNAME("SE2")+" E2 "                            
	cQuery += " LEFT JOIN "+RETSQLNAME("SEV")+" EV ON E2_PREFIXO = EV_PREFIXO AND E2_NUM = EV_NUM AND E2_PARCELA = EV_PARCELA AND E2_FORNECE = EV_CLIFOR AND E2_LOJA = EV_LOJA AND EV_SEQ = '' AND EV_RECPAG = 'P' AND EV.D_E_L_E_T_ = '' "                                                                
	cQuery += " LEFT JOIN "+RETSQLNAME("SED")+" ED ON EV_NATUREZ = ED_CODIGO AND ED.D_E_L_E_T_ = '' "                            
	cQuery += " LEFT JOIN "+RETSQLNAME("SED")+" ED2 ON E2_NATUREZ = ED2.ED_CODIGO AND ED2.D_E_L_E_T_ = '' "                            
	cQuery += " LEFT JOIN "+RETSQLNAME("SEZ")+" EZ ON E2_PREFIXO = EZ_PREFIXO AND E2_NUM = EZ_NUM AND E2_PARCELA = EZ_PARCELA AND E2_FORNECE = EZ_CLIFOR AND E2_LOJA = EV_LOJA AND EV.EV_NATUREZ = EZ_NATUREZ AND EZ_RECPAG = 'P' " 
	cQuery += " AND EZ_SEQ = '' AND EV.D_E_L_E_T_ = '' "                            
	cQuery += " LEFT JOIN CTT010 CTT ON EZ_CCUSTO = CTT_CUSTO AND CTT.D_E_L_E_T_ = '' "
	cQuery += " WHERE E2.D_E_L_E_T_ = '' "                                    
	cQuery += " AND E2_EMIS1 BETWEEN '"+Dtos(aRet[2])+"' AND '"+Dtos(aRet[3])+"' "
	
	U_QRYCSV(cQuery,"SE2 - Contas a Pagar x Natureza")
	
Return	

Static Function xProc6()

	cQuery := " SELECT FT_FILIAL,FT_TIPOMOV, "
	cQuery += " 	SUBSTRING(FT_ENTRADA,7,2) + '/' + SUBSTRING(FT_ENTRADA ,5,2) + '/' + SUBSTRING(FT_ENTRADA ,1,4) FT_ENTRADA, "
	cQuery += " 	SUBSTRING(FT_EMISSAO,7,2) + '/' + SUBSTRING(FT_EMISSAO ,5,2) + '/' + SUBSTRING(FT_EMISSAO ,1,4) FT_EMISSAO, "
	cQuery += " 	FT_ESPECIE,FT_NFISCAL,FT_SERIE, "
	cQuery += " 	FT_CLIEFOR,FT_LOJA,FT_ITEM,FT_PRODUTO,B1_DESC,B1_POSIPI,FT_TES, "
	cQuery += " 	FT_POSIPI,FT_CEST,FT_ESTADO, "
	cQuery += " 	FT_CFOP,FT_VALCONT,FT_CLASFIS,FT_BASEICM,FT_ALIQICM,FT_VALICM,FT_ISENICM, "
	cQuery += " 	FT_OUTRICM,FT_FRETE,FT_DIFAL,FT_ICMSDIF,FT_DESPESA,FT_CTIPI,FT_BASEIPI, "
	cQuery += " 	FT_ALIQIPI,FT_VALIPI,FT_ISENIPI,FT_OUTRIPI,FT_GRPCST,FT_IPIOBS,FT_CREDST, "
	cQuery += " 	FT_CSTPIS,FT_BASEPIS,FT_ALIQPIS,FT_VALPIS,FT_CSTCOF,FT_BASECOF,FT_ALIQCOF, "
	cQuery += " 	FT_VALCOF,FT_CODBCC,FT_CHVNFE,FT_INDNTFR,FT_OBSERV,FT_VALFECP,FT_VFECPST,FT_ICMSRET,FT_ICMSCOM "                                 
	cQuery += " FROM "+RETSQLNAME("SFT")+" FT "                                 
	cQuery += " LEFT JOIN "+RETSQLNAME("SB1")+" B1 ON B1_COD = FT_PRODUTO AND B1.D_E_L_E_T_='' "                                 
	cQuery += " WHERE FT.FT_FILIAL != '' "
	cQuery += " AND FT.D_E_L_E_T_='' "                                   
	cQuery += " AND FT_ENTRADA BETWEEN '"+Dtos(aRet[2])+"' AND '"+Dtos(aRet[3])+"' "
	
	If aRet[4] != 3
		cQuery += " AND FT_TIPOMOV = '"+ IIF(aRet[4] == 1, "E", "S") +"' "
	EndIf
		
	cQuery += " AND FT_DTCANC = '' "                                
	cQuery += " ORDER BY FT_FILIAL ,FT_NFISCAL,FT_ITEM "
	
	U_QRYCSV(cQuery,"SFT - Livros Fiscais")
	
Return	

Static Function xProc7()
	Alert("ATEN??O: Rotina n?o est? dispon?vel...")
Return

Static Function xProc8()

	cQuery := CRLF + " SELECT D1_FILIAL FILIAL,F1_ESPECIE ESPECIE,D1_DOC DOCUMENTO, "
	cQuery += CRLF + " 		D1_SERIE SERIE,F1_FORNECE COD_FORN,A2_NOME FORNECEDOR,D1_COD CODIGO, "
	cQuery += CRLF + " 		B1_DESC DESCRICAO,D1_CC C_CUSTO,D1_TOTAL TOTAL,D1_VALICM,D1_ICMSRET ICMS_SOLID, "
	cQuery += CRLF + " 		D1_DIFAL ICMS_DIFAL,D1_TES TIPO_ENTRADA,D1_CF COD_FISCAL, "
	cQuery += CRLF + " 		SUBSTRING(D1_EMISSAO,7,2)+'/'+SUBSTRING(D1_EMISSAO ,5,2)+'/'+SUBSTRING(D1_EMISSAO ,1,4) DT_EMISSAO, "
	cQuery += CRLF + " 		SUBSTRING(D1_DTDIGIT,7,2)+'/'+SUBSTRING(D1_DTDIGIT ,5,2)+'/'+SUBSTRING(D1_DTDIGIT ,1,4) DT_DIGITACAO "
	cQuery += CRLF + " FROM "+RetSqlName('SD1')+" D1 "
	cQuery += CRLF + " INNER JOIN "+RetSqlName('SB1')+" B1 ON B1_FILIAL='"+xFilial('SB1')+"' AND D1_COD=B1_COD "
	cQuery += CRLF + " INNER JOIN "+RetSqlName('SF1')+" F1 ON F1_FILIAL=D1_FILIAL AND F1_DOC=D1_DOC AND F1_LOJA=D1_LOJA "
	cQuery += CRLF + " 		AND F1_EMISSAO=D1_EMISSAO AND F1.F1_ESPECIE='CTE' AND F1.D_E_L_E_T_!='*' "
	cQuery += CRLF + " INNER JOIN "+RetSqlName('SA2')+" A2 ON A2.A2_FILIAL='"+xFilial('SA2')+"' AND A2.A2_COD=F1.F1_FORNECE "
	cQuery += CRLF + " WHERE D1.D_E_L_E_T_!='*' AND D1_EMISSAO BETWEEN '"+Dtos(aRet[2])+"' AND '"+Dtos(aRet[3])+"' "
	cQuery += CRLF + " GROUP BY D1_FILIAL,F1_ESPECIE,D1_DOC,D1_SERIE,F1_FORNECE,D1_COD,A2_NOME,B1_DESC,D1_CC, "
	cQuery += CRLF + " 		D1_TOTAL,D1_VALICM,D1_ICMSRET,D1_DIFAL,D1_TES,D1_CF,D1_EMISSAO,D1_DTDIGIT "
	cQuery += CRLF + " ORDER BY FILIAL,DOCUMENTO,CODIGO,DT_EMISSAO "

	U_QRYCSV(cQuery,"CTE - Entradas CTE")

Return


Static Function xProc9()
	Alert("ATEN??O: Rotina n?o est? dispon?vel...")
Return

Static Function xProc10()
	
	cQuery := " WITH INV AS (SELECT DISTINCT B7_FILIAL, B7_LOCAL FROM "+RETSQLNAME("SB7")+" 
	cQuery += " 	WHERE B7_DATA = CONVERT(VARCHAR(8), '20191231', 112) AND D_E_L_E_T_ = '')
	cQuery += " 	SELECT NNR_CODIGO, NNR_DESCRI
	cQuery += " 	FROM NNR010 NNR
	cQuery += " 	LEFT JOIN INV ON NNR_CODIGO = B7_LOCAL AND NNR.D_E_L_E_T_ = ''WHERE B7_LOCAL IS NULL AND NNR_XINV = 'S'
	
	U_QRYCSV(cQuery,"SB7 - Invent?rio Pendente")

Return


Static Function xProc11()
	
	cQuery := " SELECT C7_FILIAL FILIAL,C7_NUM PEDIDO,C7_ITEM ITEM,C7_PRODUTO PRODUTO,C7_XDESCR DESCRICAO, " 
	cQuery += " C7_UM PRIM_UM,C7_SEGUM SEGU_UM,C7_QUANT QTD_PRMUM,C7_QTSEGUM QTD_SEGUM,C7_PRECO VLR_UNIT,C7_TOTAL TOTAL, "
	cQuery += " C7_TES TES,C7_OPER OPERACAO,C7_LOCAL ARMAZEM,C7_FORNECE COD_FORNECE,A2_NOME NOME_FORNECE, "
	cQuery += " A2_CGC CPF_CNPJ,C7_LOJA LOJA,C7_COND COND_PGTO,CONVERT(VARCHAR(10), CAST(C7_EMISSAO AS DATE),103) EMISSAO "
	cQuery += " FROM "+RetSqlName('SC7')+" C7 "
	cQuery += " INNER JOIN "+RetSqlName('SA2')+" A2 ON A2_COD=C7_FORNECE AND A2_LOJA=C7_LOJA AND A2.D_E_L_E_T_='' "
	cQuery += " WHERE C7.D_E_L_E_T_='' "
	cQuery += " AND C7_EMISSAO BETWEEN '"+Dtos(aRet[2])+"' AND '"+Dtos(aRet[3])+"' "
	cQuery += " ORDER BY C7_FILIAL,C7_EMISSAO,C7_NUM,C7_ITEM "
	
	U_QRYCSV(cQuery,"SC7 - Pedido de Compras")

Return

Static Function xProc12()

	cQuery := " SELECT " + CRLF
    cQuery += " SE1.E1_FILIAL, " + CRLF
    cQuery += "  SE1.E1_PREFIXO, " + CRLF
    cQuery += "  SE1.E1_NUM," + CRLF 
    cQuery += "  SE1.E1_PARCELA," + CRLF 
    cQuery += "  SE1.E1_TIPO," + CRLF  
    cQuery += "  SE1.E1_NATUREZ," + CRLF  
    cQuery += "  SE1.E1_PORTADO," + CRLF  
    cQuery += "  SE1.E1_AGEDEP," + CRLF  
    cQuery += "  SE1.E1_CLIENTE," + CRLF  
    cQuery += "  SE1.E1_LOJA," + CRLF  
   	cQuery += "   SE1.E1_NOMCLI," + CRLF  
    cQuery += "  SE1.E1_EMISSAO," + CRLF  
    cQuery += "  SE1.E1_VENCTO," + CRLF  
    cQuery += "  SE1.E1_VENCREA," + CRLF  
    cQuery += "  SE1.E1_VALOR," + CRLF  
    cQuery += "  SE1.E1_SALDO," + CRLF  
    cQuery += "  SE1.E1_VLRREAL, " + CRLF 
    cQuery += "  SE1.E1_FILORIG," + CRLF  
    cQuery += "  SE1.E1_CCUSTO," + CRLF  
    cQuery += "  SE1.E1_VLRREAL," + CRLF  
    cQuery += "  FIF.FIF_VLLIQ," + CRLF  
    cQuery += "  SE1.E1_DESCONT," + CRLF  
    cQuery += "  FIF.FIF_DTCRED," + CRLF  
    cQuery += "  FIF.FIF_CODBCO," + CRLF  
    cQuery += "  FIF.FIF_CODAGE," + CRLF  
    cQuery += "  FIF.FIF_NUMCC" + CRLF  
 	cQuery += " 	FROM " + CRLF 
    cQuery += " "+RETSQLNAME("FIF")+" FIF " + CRLF 
 	cQuery += " JOIN "+RETSQLNAME("ZZ2")+" ZZ2 " + CRLF 
	cQuery += "  	ON ZZ2.ZZ2_CODRED = FIF.FIF_CODRED " + CRLF 
	cQuery += "  	AND ZZ2.ZZ2_CODBAN = FIF.FIF_CODBAN " + CRLF 
	cQuery += "  	AND ZZ2.D_E_L_E_T_ != '*'" + CRLF 
 	cQuery += " JOIN " + CRLF  
    cQuery += "  "+RETSQLNAME("SE1")+" SE1 " + CRLF 
    cQuery += " 	ON SE1.E1_FILIAL = ''  " + CRLF 
    cQuery += " 	AND SE1.E1_NSUTEF =  IIF ( LEN(FIF_NSUTEF) > 6, FIF_NSUTEF, REPLICATE('0', 6 - LEN(FIF_NSUTEF)) + RTrim(FIF_NSUTEF) ) " + CRLF 
    cQuery += " 	AND SE1.E1_FILORIG = FIF.FIF_CODFIL " + CRLF 
    cQuery += " 	AND SE1.E1_EMISSAO = FIF.FIF_DTTEF " + CRLF 
    cQuery += " 	AND SE1.E1_VLRREAL = FIF.FIF_VLBRUT " + CRLF 
    cQuery += " 	AND SE1.E1_VENCREA = FIF.FIF_DTCRED " + CRLF  
    cQuery += " 	AND SE1.D_E_L_E_T_ != '*' " + CRLF  
	cQuery += " 	AND SE1.E1_CLIENTE = ZZ2.ZZ2_CODADM " + CRLF 
 	cQuery += " LEFT JOIN " + CRLF  
    cQuery += " 	"+RETSQLNAME("ZCZ")+" ZCZ  " + CRLF 
    cQuery += " 	ON ZCZ.ZCZ_FILORI = SE1.E1_FILORIG  " + CRLF 
    cQuery += "  	AND ZCZ.ZCZ_PREFIX = SE1.E1_PREFIXO  " + CRLF 
    cQuery += "  	AND ZCZ.ZCZ_NUM = SE1.E1_NUM  " + CRLF 
    cQuery += "  AND ZCZ.ZCZ_PARCEL = SE1.E1_PARCELA  " + CRLF 
    cQuery += "  AND ZCZ.ZCZ_TIPO = SE1.E1_TIPO " + CRLF  
    cQuery += "  AND ZCZ.ZCZ_CLIENT = SE1.E1_CLIENTE  " + CRLF 
    cQuery += "  AND ZCZ.ZCZ_LOJA = SE1.E1_LOJA  " + CRLF 
    cQuery += "  AND ZCZ.D_E_L_E_T_ != '*'  " + CRLF 
 	cQuery += " WHERE   " + CRLF 
    cQuery += "  FIF_FILIAL = ''  " + CRLF 
    cQuery += "  AND FIF_DTCRED = '"+DTOS(MV_PAR02)+"'   " + CRLF 
    cQuery += "  AND FIF_PREFIX = ''  " + CRLF 
    cQuery += "  AND FIF.D_E_L_E_T_ != '*'  " + CRLF 
  
	U_QRYCSV(cQuery,"SE1 - Match Entre SE1 x FIF")

Return



Static Function xProc13()

	cQuery := CRLF + " SELECT C6_FILIAL,C6_NUM,C5_EMISSAO, C5_FECENT,  C6_ITEM,C6_PRODUTO,B1_DESC,C6_QTDVEN,A1_NREDUZ,A1_MUN,A1_END "
	cQuery += CRLF + " FROM "+RetSqlName('SC5')+" SC5 "
	cQuery += CRLF + " 		INNER JOIN "+RetSqlName('SC6')+" SC6 ON C6_FILIAL=C5_FILIAL AND C5_NUM=C6_NUM  "
	cQuery += CRLF + " 			AND C5_CLIENTE=C6_CLI AND C5_LOJACLI=C6_LOJA AND C6_NOTA='' AND SC6.D_E_L_E_T_='' "
	cQuery += CRLF + " 		INNER JOIN "+RetSqlName('SA1')+" SA1 ON A1_FILIAL='' AND A1_COD=C5_CLIENTE AND A1_LOJA=C5_LOJACLI  "
	cQuery += CRLF + " 		INNER JOIN "+RetSqlName('SB1')+" SB1 ON B1_FILIAL='' AND B1_COD=C6_PRODUTO "
	cQuery += CRLF + " WHERE SC5.D_E_L_E_T_='' "
	cQuery += CRLF + " 		AND C5_EMISSAO BETWEEN '"+Dtos(aRet[2])+"' AND '"+Dtos(aRet[3])+"' AND C5_NOTA = '' AND C5_FILIAL = '0072' "

	U_QRYCSV(cQuery,"Pedidos Venda em Aberto")

Return


Static Function xProc14()

	cQuery := CRLF + " SELECT SC6.C6_FILIAL, SC6.C6_NUM, SC6.C6_CLI, SC6.C6_LOJA, SA1.A1_NREDUZ, SB1.B1_COD, SB1.B1_DESC, SC6.C6_QTDVEN, SC6.C6_XQTDREF, SC6.C6_XLTREF, 'ITEM CORTADO' AS 'MOTIVO' "
	cQuery += CRLF + " FROM "+RetSqlName('SC6')+"  SC6 "
	cQuery += CRLF + " JOIN "+RetSqlName('SB1')+"  SB1 ON SB1.B1_FILIAL = '' AND SB1.B1_COD = SC6.C6_PRODUTO AND SB1.D_E_L_E_T_ != '*' "
	cQuery += CRLF + " LEFT JOIN "+RetSqlName('SA1')+"  SA1 ON SA1.A1_FILIAL = '' AND SA1.A1_COD = SC6.C6_CLI AND SA1.A1_LOJA = SC6.C6_LOJA AND SA1.D_E_L_E_T_ != '*'  "
	cQuery += CRLF + " 		INNER JOIN "+RetSqlName('SC5')+" SC5 ON C6_FILIAL=C5_FILIAL AND C5_NUM=C6_NUM  "
	cQuery += CRLF + " 			AND C5_CLIENTE=C6_CLI AND C5_LOJACLI=C6_LOJA AND C6_NOTA='' AND SC6.D_E_L_E_T_='' "
	cQuery += CRLF + " WHERE C5_EMISSAO BETWEEN '"+Dtos(aRet[2])+"' AND '"+Dtos(aRet[3])+"' AND C5_NOTA = '' AND C5_FILIAL = '0072' "

	U_QRYCSV(cQuery,"Corte Pedidos SM")

Return
