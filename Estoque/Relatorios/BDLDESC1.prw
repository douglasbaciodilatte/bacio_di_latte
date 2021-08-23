#Include "Totvs.ch"

/*/{Protheus.doc} User Function BDLDESC1
    @desc Relatorio de descarte
    @type user function
    @author Daniel Torres
    @since 13/08/2021
/*/
User Function BDLDESC1()
    
Local aParamBox := {}
Private aRet := {}

	//adiciona os parametros no array do parambox
	aAdd(aParamBox,{1,"Emissão De" ,Ctod(Space(8)),"","","","",50,.F.}) //aRet[1]
	aAdd(aParamBox,{1,"Emissão Ate",Ctod(Space(8)),"","","","",50,.F.}) //aRet[2]
	
	//monta o parambox
	//aRet é o retorno do parambox
	If ParamBox(aParamBox,"Relatorio Descarte",@aRet)
		xProc1()		
	Endif

Return 

Static Function xProc1()

	cQuery := CRLF + " SELECT " 
	cQuery += CRLF + " D3_FILIAL AS XX_FILIAL, "
	cQuery += CRLF + " D3_COD     AS XX_COD  , "
	cQuery += CRLF + " B1_DESC    AS XX_DESC , "
	cQuery += CRLF + " D3_TM      AS XX_TM   , "
	cQuery += CRLF + " D3_UM      AS XX_UM   , "
	cQuery += CRLF + " D3_QUANT   AS XX_QUANT, "
	cQuery += CRLF + " D3_SEGUM   AS XX_UM2  , "
	cQuery += CRLF + " D3_QTSEGUM AS XX_QUANT2  , "
	cQuery += CRLF + " SUBSTRING(D3_EMISSAO,7,2)+'/'+ SUBSTRING(D3_EMISSAO,5,2)+'/'+SUBSTRING(D3_EMISSAO,1,4) AS XX_EMISSAO , "
	cQuery += CRLF + " ROUND((D3_QUANT * B1_CUSTD),2) AS CUSTO "
	cQuery += CRLF + " FROM "+RetSqlName('SD3')+" D3 "
	cQuery += CRLF + " INNER JOIN "+RetSqlName('SB1')+" B1 "
	cQuery += CRLF + " ON B1_COD = D3_COD "
	cQuery += CRLF + " AND B1.D_E_L_E_T_!='*' "
	cQuery += CRLF + " WHERE D3_TM IN('510','520','530','540','550') "
	cQuery += CRLF + " AND D3_CF = 'RE0' "
	cQuery += CRLF + " AND D3.D_E_L_E_T_!='*' "
	cQuery += CRLF + " AND D3_EMISSAO BETWEEN '"+DTOS(aRet[1])+"' AND '"+DTOS(aRet[2])+"' "

	U_QRYCSV(cQuery,"Relatorio Descarte")

Return
