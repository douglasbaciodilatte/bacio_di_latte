#INCLUDE "totvs.ch"

/*/{Protheus.doc} User Function BDINVA01
description)
    @type  Function
    @author user
    @since 18/01/2021
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function BDINVA01(_cFilial, _cLocal, lExec)
 
    c3Query := " SELECT  TEMP.PRODUTO, SB1.B1_DESC 'DESCRICAO', TEMP.NOTAS, TEMP.INVENTA, TEMP.PRODUCAO " + CRLF
    c3Query += " FROM ( SELECT B5_COD AS 'PRODUTO', " + CRLF
	c3Query += " IIF(ISNULL(SD1.D1_COD,'NAO') != 'NAO', 'SIM','NAO') AS 'NOTAS', " + CRLF 
	c3Query += "  IIF(ISNULL(B7_COD,'NAO') != 'NAO', 'SIM','NAO') AS 'INVENTA', " + CRLF
	c3Query += "  IIF(ISNULL(C2_PRODUTO,'NAO') != 'NAO', 'SIM','NAO') AS 'PRODUCAO' " + CRLF
    c3Query += " FROM "+RETSQLNAME("SB5")+" SB5 WITH (NOLOCK) " + CRLF
	c3Query += " LEFT JOIN "+RETSQLNAME("SD1")+" SD1 WITH (NOLOCK)	ON SD1.D1_FILIAL != ''	AND SB5.B5_COD = SD1.D1_COD " + CRLF 
    c3Query += "     AND D1_CC = '"+_cLocal+"' " + CRLF 
	c3Query += " 	AND SUBSTRING(SD1.D1_EMISSAO,1,6) IN ('"+SUBSTR( DTOS( DATE() - 90 ),1,6)+"', '"+SUBSTR( DTOS( DATE() - 60 ),1,6)+"', '"+SUBSTR( DTOS( DATE() - 30 ),1,6)+"', '"+SUBSTR( DTOS( DATE() ),1,6)+"') " + CRLF
	c3Query += " LEFT JOIN "+RETSQLNAME("SB7")+" SB7 WITH (NOLOCK) ON B7_FILIAL != '' AND B7_COD = SB5.B5_COD AND B7_LOCAL = '"+_cLocal+"' AND SUBSTRING(B7_DATA ,1,6) = '"+SUBSTR( DTOS( DATE() - 30 ),1,6)+"' AND B7_QUANT != 0  AND SB7.D_E_L_E_T_ != '*'  " + CRLF
	c3Query += " LEFT JOIN "+RETSQLNAME("SC2")+" SC2 WITH (NOLOCK) ON SB5.B5_COD = C2_PRODUTO AND C2_LOCAL = '"+_cLocal+"' AND SUBSTRING(C2_DATRF,1,6) = '"+SUBSTR( DTOS( DATE() - 30 ),1,6)+"' AND SC2.D_E_L_E_T_ != '*' " + CRLF
    c3Query += " WHERE SB5. B5_FILIAL = '' AND B5_XDESINV != '' ) TEMP " + CRLF
    c3Query += " JOIN "+RETSQLNAME("SB1")+" SB1 ON B1_FILIAL = '' AND B1_COD = TEMP.PRODUTO " + CRLF
    c3Query += " GROUP BY TEMP.PRODUTO, SB1.B1_DESC, TEMP.NOTAS, TEMP.INVENTA, TEMP.PRODUCAO " + CRLF
    c3Query += " ORDER BY 1 " + CRLF

    dbUseArea(.T.,"TOPCONN",TcGenQry(,,c3Query),"TRD")

    If lExec

        Do While TRD->(!eof())

            If ALLTRIM(TRD->NOTAS) == "NAO" .And. ALLTRIM(TRD->INVENTA) == "NAO" .And. ALLTRIM(TRD->PRODUCAO) == "NAO" 
                
                ZZ3->(dbSelectArea("ZZ3"))
                ZZ3->(dbSetOrder(1))
                If ! ZZ3->(DBSeek( _cFilial + TRD->PRODUTO +  _cLocal ))
                    RecLock("ZZ3",.T.)
                        ZZ3->ZZ3_FILIAL := _cFilial
                        ZZ3->ZZ3_COD    := TRD->PRODUTO
                        ZZ3->ZZ3_LOCAL  := _cLocal
                    ZZ3->(MsUnlock())
                EndIf
            
            Else

                //Verifica se est? lista de bloqueados, deleta
                ZZ3->(dbSelectArea("ZZ3"))
                ZZ3->(dbSetOrder(1))
                If ZZ3->(DBSeek( _cFilial + TRD->PRODUTO +  _cLocal ))
                    RecLock("ZZ3",.F.)
                        dbDelete()
                    ZZ3->(MsUnlock())
                EndIf
              
            EndIf
        
            TRD->(dbSkip())
        Enddo    
    EndIf

    TRD->(dbCloseArea())

Return(.T.)
