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

User Function BLESTR20()

    Local aParamBox := {}
    Local aRet := {}
    
    aAdd(aParamBox,{1,"Emiss?o De"  ,Ctod(Space(8)),"","","","",50,.T.})
	aAdd(aParamBox,{1,"Emiss?o Ate"  ,Ctod(Space(8)),"","","","",50,.T.})

    If ParamBox(aParamBox,"Extrator Dados...",@aRet)
        /*
        cQuery := CRLF + " SELECT SC6.C6_FILIAL, SC6.C6_NUM, SC6.C6_CLI, SC6.C6_LOJA, SA1.A1_NREDUZ, SB1.B1_COD, SB1.B1_DESC, SC6.C6_QTDVEN, SC6.C6_XQTDREF, SC6.C6_XLTREF,
        cQuery += CRLF + " CONVERT(VARCHAR,DATEADD(DAY,((ASCII(SUBSTRING(C6_USERLGA,12,1)) - 50) * 100 + (ASCII(SUBSTRING(C6_USERLGA,16,1)) - 50)),'19960101'), 112) as 'DT_Corte' "

        cQuery += CRLF + ",'ITEM CORTADO' AS 'MOTIVO' "
        cQuery += CRLF + " FROM "+RetSqlName('SC6')+"  SC6 "
        cQuery += CRLF + " JOIN "+RetSqlName('SB1')+"  SB1 ON SB1.B1_FILIAL = '' AND SB1.B1_COD = SC6.C6_PRODUTO AND SB1.D_E_L_E_T_ != '*' "
        cQuery += CRLF + " LEFT JOIN "+RetSqlName('SA1')+"  SA1 ON SA1.A1_FILIAL = '' AND SA1.A1_COD = SC6.C6_CLI AND SA1.A1_LOJA = SC6.C6_LOJA AND SA1.D_E_L_E_T_ != '*'  "
        cQuery += CRLF + " 		INNER JOIN "+RetSqlName('SC5')+" SC5 ON C6_FILIAL=C5_FILIAL AND C5_NUM=C6_NUM  "
        cQuery += CRLF + " 			AND C5_CLIENTE=C6_CLI AND C5_LOJACLI=C6_LOJA AND C6_NOTA='' AND SC6.D_E_L_E_T_='' "
        cQuery += CRLF + " WHERE C5_EMISSAO BETWEEN '"+Dtos(MV_PAR01)+"' AND '"+Dtos(MV_PAR02)+"' AND C5_NOTA = '' AND C5_FILIAL = '0072' "
        */
        cQuery := CRLF + " SELECT  C6_FILIAL, "
        cQuery += CRLF + " 		C6_NUM, "
        cQuery += CRLF + " 		C6_CLI, "
        cQuery += CRLF + " 		C6_LOJA, "
        cQuery += CRLF + " 		A1_NREDUZ, "
        cQuery += CRLF + " 		C6_ITEM, "
        cQuery += CRLF + " 		B1_COD, "
        cQuery += CRLF + " 		B1_DESC, "
        cQuery += CRLF + " 		C6_QTDVEN, "
        cQuery += CRLF + " 		SUBSTRING(C6_VDOBS,1,CHARINDEX('Usuario' ,C6_VDOBS)-3) AS MOTIVO, "
        cQuery += CRLF + " 		SUBSTRING(C6_VDOBS,  CHARINDEX('Data'    ,C6_VDOBS)+15,10) AS DATA_CORTE, "
        cQuery += CRLF + " 		SUBSTRING(C6_VDOBS,  CHARINDEX('Hora'    ,C6_VDOBS)+6  ,8) AS HORA "
        cQuery += CRLF + "  FROM ( "

        cQuery += CRLF + " 	 SELECT  "
        cQuery += CRLF + " 			C6_VDOBS = substring(ISNULL(CONVERT(VARCHAR(2047), CONVERT(VARBINARY(2047), SC6.C6_VDOBS)),''),8,150), "
        cQuery += CRLF + " 			SC6.C6_FILIAL,   "
        cQuery += CRLF + " 			SC6.C6_NUM,   "
        cQuery += CRLF + " 			SC6.C6_CLI,  "
        cQuery += CRLF + " 			SC6.C6_LOJA,  "
        cQuery += CRLF + " 			ISNULL(SA1.A1_NREDUZ,  "
        cQuery += CRLF + " 						(SELECT SA2.A2_NREDUZ   "
        cQuery += CRLF + " 							FROM " + RetSqlName("SA2") + " SA2   "
        cQuery += CRLF + " 							WHERE SA2.A2_COD = SC6.C6_CLI  AND SA2.A2_LOJA = SC6.C6_LOJA)  "
        cQuery += CRLF + " 						) AS A1_NREDUZ,  "
        cQuery += CRLF + " 			SC6.C6_ITEM,  "
        cQuery += CRLF + " 			SB1.B1_COD,   "
        cQuery += CRLF + " 			SB1.B1_DESC,   "
        cQuery += CRLF + " 			SC6.C6_QTDVEN,   "
        cQuery += CRLF + " 			SC6.C6_XQTDREF,   "
        cQuery += CRLF + " 			(SC6.C6_XQTDREF - SC6.C6_QTDVEN)as Diferenca,   "
        cQuery += CRLF + " 			SC6.C6_XLTREF  "

        cQuery += CRLF + " 	 FROM " + RetSqlName("SC6") + "  SC6   "

        cQuery += CRLF + " 		 JOIN SB1010  SB1   "
        cQuery += CRLF + " 			 ON SB1.B1_FILIAL = ''   "
        cQuery += CRLF + " 			AND SB1.B1_COD    = SC6.C6_PRODUTO   "
        cQuery += CRLF + " 			AND SB1.D_E_L_E_T_ <> '*'   "

        cQuery += CRLF + " 		 JOIN " + RetSqlName("SA1") + "  SA1   "
        cQuery += CRLF + " 			 ON SA1.A1_FILIAL   = ''   "
        cQuery += CRLF + " 			AND SA1.A1_COD      = SC6.C6_CLI   "
        cQuery += CRLF + " 			AND SA1.A1_LOJA     = SC6.C6_LOJA   "
        cQuery += CRLF + " 			AND SA1.D_E_L_E_T_ <> '*'    "

        cQuery += CRLF + " 		 JOIN " + RetSqlName("SC5") + " SC5   "
        cQuery += CRLF + " 			 ON SC5.C5_FILIAL  =  C6_FILIAL   "
        cQuery += CRLF + " 			AND SC5.C5_NUM     =  C6_NUM  "
        cQuery += CRLF + " 			AND SC5.C5_CLIENTE =  C6_CLI   "
        cQuery += CRLF + " 			AND SC5.C5_LOJACLI =  SC6.C6_LOJA   "
        //cQuery += CRLF + " 			AND SC5.D_E_L_E_T_ =  ''  "

        cQuery += CRLF + " 	 WHERE  "
        cQuery += CRLF + " 			C5_FILIAL = '0072'   "
        cQuery += CRLF + " 		AND IsNull(Cast(Cast(C6_VDOBS As VarBinary)as VarChar(Max)),'') like 'Motivo%' "
        cQuery += CRLF + " 		AND SC5.C5_EMISSAO BETWEEN '" + Dtos(MV_PAR01) + "' AND '" + Dtos(MV_PAR02) + "' " 
            
        cQuery += CRLF + " ) AS TRB "
        cQuery += CRLF + " ORDER BY 1,2,3,4,5,6 "

        //mEMOWRITE('C:\1\QUERY.SQL',cQuery)
        U_QRYCSV(cQuery,"Corte Pedidos SM")

    EndIf    
    
Return
