#INCLUDE 'totvs.ch'
#INCLUDE 'protheus.ch'

/*/{Protheus.doc} User Function DBRELINV1
    (long_description)
    @type  Function
    @author Douglas Silva
    @since 06/01/2021
    @version 1.0
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function DBRELINV1()
    
    Local aPergs 	 := {}
    Local aRet      := {}

    aAdd( aPergs, {1,"Filial"  			        ,Space(4),"","","SM0","",50,.F.})
    aAdd( aPergs, {1,"Data Inventario?"			,Ctod(Space(8)),"","","","",50,.F.})   
    
    If ParamBox(aPergs ,"Parametros ",aRet)
        processa( {|| Process() } ,'Aguarde Processando Inventario...' )
    EndIf

Return 

Static Function Process()

    cQuery := " SELECT	B7_FILIAL AS 'FILIAL', " + CRLF
    cQuery += " B7_LOCAL AS 'LOCAL', " + CRLF
	cQuery += "	    B7_COD AS 'CODIGO', " + CRLF 
	cQuery += "	    B1_DESC AS 'DESCRICAO', " + CRLF
	cQuery += "	    B7_TIPO AS 'TIPO', " + CRLF 
	cQuery += "	    B7_DOC AS 'DOCUMENTO', " + CRLF 
	cQuery += "	    B7_QUANT AS 'QTDE_1', " + CRLF 
	cQuery += "	    B1_UM AS 'UNIDADE_1', " + CRLF  
	cQuery += "	    B7_QTSEGUM AS 'QTDE_2', " + CRLF 
	cQuery += "	    B1_SEGUM AS 'UNIDADE_2', " + CRLF 
	cQuery += "	    B7_DATA AS 'DATA', " + CRLF 
	cQuery += "	    B7_LOTECTL AS 'LOTE', " + CRLF
	cQuery += "	    B7_DTVALID AS 'VALIDADE', " + CRLF
    cQuery += "	    B1_CUSTD AS CUSTO, " + CRLF
    cQuery += "	    B1_CUSTD * B7_QUANT AS 'CUSTO_TOTAL' " + CRLF
    cQuery += " FROM "+RetSQLName("SB7")+" SB7 " + CRLF
    cQuery += "	JOIN "+RetSQLName("SB1")+" SB1 ON SB1.B1_FILIAL = '' AND SB1.B1_COD = SB7.B7_COD AND SB1.D_E_L_E_T_ != '*' " + CRLF
    cQuery += " WHERE B7_FILIAL = '"+MV_PAR01+"' " + CRLF 
    cQuery += "     AND B7_DATA = '"+DTOS(MV_PAR02)+"' " + CRLF 
    cQuery += "     AND SB7.D_E_L_E_T_ != '*' " + CRLF 
    
    U_QRYCSV(cQuery,"SB7 - Invetário")

Return
