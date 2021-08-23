
#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "TopConn.ch"

/*/{Protheus.doc} User Function BDPROCINV
    (long_description)
    @type  Function
    @author user
    @since 06/01/2021
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function BDPROCINV()

    Local aPergs 	 := {}
    Local aRet      := {}

    aAdd( aPergs, {1,"Filial"  			        ,Space(4),"","","SM0","",50,.F.})
    aAdd( aPergs, {1,"Armazem" 			        ,Space(6),"","","NNR","",50,.F.})
    aAdd( aPergs, {1,"Data Inventario?"			,Ctod(Space(8)),"","","","",50,.F.})
    aAdd( aPergs, {1,"Documento"    			,Space(9),"","","","",50,.F.})
    
    If ParamBox(aPergs ,"Parametros ",aRet)
        processa( {|| Process() } ,'Aguarde Processando Inventario...' )
    EndIf
    
Return 

Static Function Process()

    Local lRet := .T.

    //Atualiza saldo SB2
    cQuery := "SELECT " + CRLF
	cQuery += "     B7_FILIAL, B7_COD, B7_LOCAL, SUM(B7_QUANT) B7_QUANT, SUM(B7_QTSEGUM) B7_QTSEGUM " + CRLF
    cQuery += " FROM "+RetSQLName("SB7")+" " + CRLF
    cQuery += " WHERE B7_FILIAL = '"+MV_PAR01+"' " + CRLF
	cQuery += "     AND B7_LOCAL = '"+MV_PAR02+"' " + CRLF
    cQuery += "     AND B7_DATA = '"+DTOS(MV_PAR03)+"' " + CRLF
	cQuery += "     AND B7_DOC = '"+MV_PAR04+"' " + CRLF
	cQuery += "     AND D_E_L_E_T_ != '*' " + CRLF
	cQuery += " GROUP BY B7_FILIAL, B7_COD, B7_LOCAL " + CRLF

    cQuery := ChangeQuery(cQuery)
    DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),'TMP',.F.,.T.)

    dbSelectArea("TMP")
    TMP->(dbGoTop())

    Do While TMP->(!EOF())

        SB2->(dbSelectArea("SB2"))
        SB2->(DBSetOrder(1)) //B2_FILIAL, B2_COD, B2_LOCAL

        If SB2->(dbSeek( TMP->B7_FILIAL + TMP->B7_COD + TMP->B7_LOCAL ))

            RecLock("SB2", .F.)

				SB2->B2_QFIM    := TMP->B7_QUANT
                SB2->B2_QFIM2   := TMP->B7_QTSEGUM
             
                SB2->B2_CMFIM1  := SB2->B2_CM1 

                SB2->B2_QATU    := TMP->B7_QUANT    
	            SB2->B2_QTSEGUM := TMP->B7_QTSEGUM

                SB2->B2_QEMP    := 0
	            SB2->B2_QEMP2   := 0
	            SB2->B2_SALPEDI := 0
	            SB2->B2_SALPED2 := 0
                SB2->B2_RESERVA := 0
                SB2->B2_RESERV2 := 0

                SB2->B2_DINVENT := MV_PAR03

                SB2->B2_VFIM2   := 0
                SB2->B2_VFIM1   := 0
                SB2->B2_VATU1   := 0

			MsUnLock()

            //Busca Lotes e grava tabela SB8

            cQuery := " SELECT " + CRLF 
            cQuery += "     B7_FILIAL, B7_COD, B7_LOCAL, B7_LOTECTL, B7_DTVALID, SUM(B7_QUANT) B7_QUANT, SUM(B7_QTSEGUM) B7_QTSEGUM " + CRLF
            cQuery += " FROM "+RetSQLName("SB7")+" " + CRLF 
            cQuery += " WHERE B7_FILIAL = '"+MV_PAR01+"' " + CRLF 
            cQuery += "     AND B7_LOCAL = '"+MV_PAR02+"' " + CRLF 
            cQuery += "     AND B7_DATA = '"+DTOS(MV_PAR03)+"' " + CRLF 
            cQuery += "     AND B7_DOC = '"+MV_PAR04+"' " + CRLF 
            cQuery += "     AND D_E_L_E_T_ != '*' " + CRLF 
	        cQuery += "     AND B7_COD = '"+SB2->B2_COD+"' " + CRLF
            cQuery += "     AND B7_LOTECTL != '' " + CRLF
            cQuery += " GROUP BY B7_FILIAL, B7_COD, B7_LOCAL, B7_LOTECTL, B7_DTVALID " + CRLF
            
            cQuery := ChangeQuery(cQuery)
            DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),'TML',.F.,.T.)

            dbSelectArea("TML")
            TML->(dbGoTop())

            Do While TML->(!EOF())
                
                SB8->(dbSelectArea("SB8"))
                SB8->(dbSetOrder(3)) //B8_FILIAL, B8_PRODUTO, B8_LOCAL, B8_LOTECTL, B8_NUMLOTE, B8_DTVALID
                If SB8->(dbSeek ( TML->B7_FILIAL + TML->B7_COD + TML->B7_LOCAL + TML->B7_LOTECTL))
                    RecLock("SB8", .F.)
                Else    
                    RecLock("SB8", .T.)    
                EndIf         
                        SB8->B8_FILIAL  := TML->B7_FILIAL
                        SB8->B8_PRODUTO := TML->B7_COD
                        SB8->B8_LOCAL   := TML->B7_LOCAL
                        SB8->B8_DATA    := MV_PAR03
                        SB8->B8_DTVALID := STOD(TML->B7_DTVALID)
                        SB8->B8_LOTECTL := TML->B7_LOTECTL
                                
                        SB8->B8_QTDORI  := TML->B7_QUANT
                        SB8->B8_QTDORI2 := TML->B7_QTSEGUM

                        SB8->B8_SALDO   := TML->B7_QUANT
                        SB8->B8_SALDO2  := TML->B7_QTSEGUM
                        
                        SB8->B8_DOC     := MV_PAR04       

                        SB8->B8_EMPENHO := 0                 
                        SB8->B8_EMPENH2 := 0

                    MsUnLock() 
                   

                TML->(dbSkip())
            Enddo

            TML->(DBCloseArea())

        EndIf

        TMP->(dbSkip())
    Enddo
    
Return(lRet)
