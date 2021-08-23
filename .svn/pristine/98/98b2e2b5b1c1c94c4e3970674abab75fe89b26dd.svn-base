#INCLUDE "protheus.ch"

/*/{Protheus.doc} User Function BDFINR04
Relatório tem como objetivo gerar dados de títulos despesas de ocupações com rateio
    @type  Function
    @author Douglas Silva
    @since 19/05/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function BDFINR04()
    
Local cQuery := ""

    cQuery := " SELECT * FROM ( " + CRLF
    cQuery += " 	SELECT " + CRLF 
	cQuery += " 	E2_EMIS1, " + CRLF
	cQuery += " 	SE2.E2_EMISSAO, " + CRLF
    cQuery += " 	SE2.E2_VENCREA, " + CRLF
	cQuery += " 	SE2.E2_NATUREZ, " + CRLF
	cQuery += " 	SE2.E2_PREFIXO, " + CRLF
	cQuery += " 	SE2.E2_NUM, " + CRLF	
	cQuery += " 	SA2.A2_NREDUZ, " + CRLF
	cQuery += " 	SE2.E2_HIST, " + CRLF 
	cQuery += " 	SE2.E2_VALOR, " + CRLF
	cQuery += " 	SE2.E2_ISS, " + CRLF
	cQuery += " 	SE2.E2_IRRF, " + CRLF
	cQuery += " 	SE2.E2_COFINS, " + CRLF
	cQuery += " 	SE2.E2_PIS, " + CRLF
	cQuery += " 	SE2.E2_CSLL, " + CRLF
	cQuery += " 	SE2.E2_CCUSTO, " + CRLF
	cQuery += " 	CTT.CTT_DESC01 as 'CENTRO_CUSTOS', " + CRLF
    cQuery += " 	SE2.E2_RATEIO, " + CRLF
	cQuery += " 	SE2.E2_MULTNAT, " + CRLF	
	cQuery += " 	ISNULL(SEZ.EZ_CCUSTO,'') EZ_CCUSTO, " + CRLF
	cQuery += " 	ISNULL(CTTA.CTT_DESC01,'') CTT_DESC02, " + CRLF
	cQuery += " 	ISNULL(SEZ.EZ_NATUREZ,'') EZ_NATUREZ, " + CRLF
	cQuery += " 	ISNULL(SED.ED_DESCRIC,'') ED_DESCRIC, " + CRLF
	cQuery += " 	ISNULL(SEZ.EZ_VALOR,0) EZ_VALOR " + CRLF
	cQuery += " FROM SA2010 SA2 " + CRLF
	cQuery += " JOIN SE2010 SE2 ON SA2.A2_FILIAL = '' AND SE2.E2_FORNECE = SA2.A2_COD AND SE2.E2_LOJA = SA2.A2_LOJA AND SE2.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " LEFT JOIN CTT010 CTT ON CTT.CTT_FILIAL = '' AND CTT.CTT_CUSTO = SE2.E2_CCUSTO AND CTT.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " LEFT JOIN SEZ010 SEZ ON SE2.E2_FILIAL = SEZ.EZ_FILIAL AND SE2.E2_PREFIXO = SEZ.EZ_PREFIXO AND SE2.E2_PARCELA = SEZ.EZ_PARCELA AND SE2.E2_NUM = SEZ.EZ_NUM  AND SEZ.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " LEFT JOIN SED010 SED ON SED.ED_FILIAL = '' AND SED.ED_CODIGO = SEZ.EZ_NATUREZ AND SED.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " LEFT JOIN CTT010 CTTA ON CTTA.CTT_FILIAL = '' AND CTTA.CTT_CUSTO = SEZ.EZ_CCUSTO AND CTTA.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " WHERE SA2.A2_FILIAL = '' AND SUBSTRING(SE2.E2_EMISSAO,1,4) = '2020' AND SA2.D_E_L_E_T_ != '*'  AND SE2.E2_PREFIXO = 'CO ' " + CRLF
	cQuery += " GROUP BY " + CRLF
	cQuery += " 	E2_EMIS1, " + CRLF
	cQuery += " 	SE2.E2_EMISSAO, " + CRLF
	cQuery += " 	SE2.E2_VENCREA, " + CRLF
	cQuery += " 	SE2.E2_NATUREZ, " + CRLF
	cQuery += " 	SE2.E2_PREFIXO, " + CRLF
	cQuery += " 	SE2.E2_NUM,	 " + CRLF
	cQuery += " 	SA2.A2_NREDUZ, " + CRLF
    cQuery += " 	SE2.E2_HIST,  " + CRLF
	cQuery += " 	SE2.E2_VALOR, " + CRLF
	cQuery += " 	SE2.E2_ISS, " + CRLF
	cQuery += " 	SE2.E2_IRRF, " + CRLF
	cQuery += " 	SE2.E2_COFINS,  " + CRLF
    cQuery += " 	SE2.E2_PIS, " + CRLF
	cQuery += " 	SE2.E2_CSLL, " + CRLF
	cQuery += " 	SE2.E2_CCUSTO, " + CRLF
	cQuery += " 	CTT.CTT_DESC01, " + CRLF
	cQuery += " 	SE2.E2_RATEIO, " + CRLF
	cQuery += " 	SE2.E2_MULTNAT, " + CRLF
	cQuery += " 	SEZ.EZ_VALOR, " + CRLF
	cQuery += " 	SEZ.EZ_NATUREZ, " + CRLF
	cQuery += " 	SEZ.EZ_CCUSTO, " + CRLF
	cQuery += " 	SED.ED_DESCRIC, " + CRLF
	cQuery += " 	CTTA.CTT_DESC01  ) TEMP " + CRLF
    cQuery += " ORDER BY 5,6 " + CRLF

    U_QRYCSV(cQuery,"Relação de Títulos - Rateios")

Return 