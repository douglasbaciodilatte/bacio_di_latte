#INCLUDE "totvs.ch"

/*/{Protheus.doc} BDGESTMP()
    (long_description)
    @type  Function
    @author user
    @since date
    @version version
    @param param, param_type, param_descr
    @return return, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function BDGESTMP()
    
    Local aRet := {}
    Local aParamBox := {}

    aAdd(aParamBox,{3,"Itens para inventario",1,{"Relatorio","Executar"},50,"",.F.}) //1
	aAdd(aParamBox,{1,"Filial "	,Space(4),"","","SM0","",50,.F.})  //2
	aAdd(aParamBox,{1,"Armazem ",Space(6),"","","NNR","",50,.F.})  //3
	
   	If ParamBox(aParamBox,"Rotina itens para Inventario...",@aRet)

        If MV_PAR01 == 1
            RETEXEC1()
		ElseIf MV_PAR01 == 2
			ROTEXEC2()	
        EndIf

   	Endif

Return 

Static Function RETEXEC1()

	Local cQuery := ""
	Local c2Query

    c3Query := " SELECT  TEMP.PRODUTO, SB1.B1_DESC 'DESCRICAO', TEMP.NOTAS, TEMP.INVENTA, TEMP.PRODUCAO " + CRLF
    c3Query += " FROM ( SELECT B5_COD AS 'PRODUTO', " + CRLF
	c3Query += " IIF(ISNULL(SD1.D1_COD,'NAO') != 'NAO', 'SIM','NAO') AS 'NOTAS', " + CRLF 
	c3Query += "  IIF(ISNULL(B7_COD,'NAO') != 'NAO', 'SIM','NAO') AS 'INVENTA', " + CRLF
	c3Query += "  IIF(ISNULL(C2_PRODUTO,'NAO') != 'NAO', 'SIM','NAO') AS 'PRODUCAO' " + CRLF
    c3Query += " FROM "+RETSQLNAME("SB5")+" SB5 WITH (NOLOCK) " + CRLF
	c3Query += " LEFT JOIN "+RETSQLNAME("SD1")+" SD1 WITH (NOLOCK)	ON SD1.D1_FILIAL != ''	AND SB5.B5_COD = SD1.D1_COD " + CRLF 
    c3Query += "     AND D1_CC = '"+MV_PAR03+"' " + CRLF 
	c3Query += " 	AND SUBSTRING(SD1.D1_EMISSAO,1,6) IN ('"+SUBSTR( DTOS( DATE() - 90 ),1,6)+"', '"+SUBSTR( DTOS( DATE() - 60 ),1,6)+"', '"+SUBSTR( DTOS( DATE() - 30 ),1,6)+"', '"+SUBSTR( DTOS( DATE() ),1,6)+"') " + CRLF
	c3Query += " LEFT JOIN "+RETSQLNAME("SB7")+" SB7 WITH (NOLOCK) ON B7_FILIAL != '' AND B7_COD = SB5.B5_COD AND B7_LOCAL = '"+MV_PAR03+"' AND SUBSTRING(B7_DATA ,1,6) = '"+SUBSTR( DTOS( DATE() - 30 ),1,6)+"' AND B7_QUANT != 0  AND SB7.D_E_L_E_T_ != '*'  " + CRLF
	c3Query += " LEFT JOIN "+RETSQLNAME("SC2")+" SC2 WITH (NOLOCK) ON SB5.B5_COD = C2_PRODUTO AND C2_LOCAL = '"+MV_PAR03+"' AND SUBSTRING(C2_DATRF,1,6) = '"+SUBSTR( DTOS( DATE() - 30 ),1,6)+"' AND SC2.D_E_L_E_T_ != '*' " + CRLF
    c3Query += " WHERE SB5. B5_FILIAL = '' AND B5_XDESINV != '' ) TEMP " + CRLF
    c3Query += " JOIN "+RETSQLNAME("SB1")+" SB1 ON B1_FILIAL = '' AND B1_COD = TEMP.PRODUTO " + CRLF
    c3Query += " GROUP BY TEMP.PRODUTO, SB1.B1_DESC, TEMP.NOTAS, TEMP.INVENTA, TEMP.PRODUCAO " + CRLF
    c3Query += " ORDER BY 1 " + CRLF

    //Chamada fun??o para gerar em Excel
	U_QRYCSV(c3Query,"ITENS INVENTARIO")
	
Return

Static Function ROTEXEC2()
    
    NNR->(DbSetOrder(1))
	NNR->(DbGoTop())
	Do While NNR->(!Eof())
              
        If NNR->NNR_CODIGO != '000001' .And. NNR->NNR_XINV == 'S' 
            U_BDINVA01(NNR->NNR_FILIAL, NNR->NNR_CODIGO, .T.)
        EndIf
    NNR->(dbSkip())    
    Enddo
    	
Return
