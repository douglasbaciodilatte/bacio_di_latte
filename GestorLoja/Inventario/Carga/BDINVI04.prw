#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "TopConn.ch"

/*/{Protheus.doc} User Function BDINVI04
    (long_description)
    @type  Busca dados inventário Gestor e Carrega para tabela SB7
    @author Douglas Silva
    @since 31/03/2021
    @version 1.0
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function BDINVI04()

    Local lRet  := .F.
    Local cQuery

    //Leitura tabela ZZ4
    cQuery := " SELECT * FROM "+RETSQLNAME("ZZ4")+" WHERE D_E_L_E_T_ != '*' AND ZZ4_PROC != '1'  " + CRLF

    dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB")

    Do While TRB->(!EOF())

        //Busca cadastro do produto
        SB1->(dbSelectArea("SB1"))
        SB1->(dbSetOrder(1))

        If SB1->(dbSeek( xFilial("SB1") + TRB->ZZ4_COD ))

            //verifica se n?o ? retentativa de inclus?o de invent?rio
            SB7->(dbSelectArea("SB7"))
            SB7->(dbSetOrder(1)) //B7_FILIAL, B7_DATA, B7_COD, B7_LOCAL, B7_LOCALIZ, B7_NUMSERI, B7_LOTECTL, B7_NUMLOTE, B7_CONTAGE, R_E_C_N_O_, D_E_L_E_T_
            If SB7->(dbSeek( TRB->ZZ4_FILIAL + TRB->ZZ4_DATA + TRB->ZZ4_COD + TRB->ZZ4_LOJA))
                                
                RecLock("SB7", .F.)
                    
                    //Verifica se está na Primeira ou Segunda unidade de medida
                    
                    If SB1->B1_UM == TRB->ZZ4_UM
                        
                        lRet := .T.

                        SB7->B7_QUANT   := SB7->B7_QUANT + TRB->ZZ4_VALOR
                        SB7->B7_QTSEGUM := SB7->B7_QTSEGUM + ConvUm(SB1->B1_COD, TRB->ZZ4_VALOR ,0,2)
                    
                    ElseIf SB1->B1_SEGUM == TRB->ZZ4_UM

                        lRet := .T.

                        SB7->B7_QUANT   := SB7->B7_QUANT + ConvUm(SB1->B1_COD, 0 ,TRB->ZZ4_VALOR,1)
                        SB7->B7_QTSEGUM := SB7->B7_QTSEGUM + TRB->ZZ4_VALOR

                    EndIf    

                MsUnLock() 	

            Else

                If SB1->B1_UM == TRB->ZZ4_UM
                    
                    lRet := .T.

                    RecLock("SB7", .T.)
                        SB7->B7_FILIAL  := TRB->ZZ4_FILIAL 
                        SB7->B7_COD     := TRB->ZZ4_COD
                        SB7->B7_LOCAL   := TRB->ZZ4_LOJA
                        SB7->B7_TIPO    := SB1->B1_TIPO
                        SB7->B7_DOC     := TRB->ZZ4_DOC
                        
                        SB7->B7_QUANT   := TRB->ZZ4_VALOR
                        SB7->B7_QTSEGUM := ConvUm(SB1->B1_COD, TRB->ZZ4_VALOR ,0,2)
                    
                        SB7->B7_DATA    := STOD(TRB->ZZ4_DATA)
                        SB7->B7_DTVALID := DATE()    
                        SB7->B7_CONTAGE := "001"    
                        SB7->B7_ORIGEM  := "BDINVI04"
                        SB7->B7_STATUS  := "1"
                    MsUnLock()    

                ElseIf SB1->B1_SEGUM == TRB->ZZ4_UM
                    
                    lRet := .T.

                    RecLock("SB7", .T.)
                        SB7->B7_FILIAL  := TRB->ZZ4_FILIAL 
                        SB7->B7_COD     := TRB->ZZ4_COD
                        SB7->B7_LOCAL   := TRB->ZZ4_LOJA
                        SB7->B7_TIPO    := SB1->B1_TIPO
                        SB7->B7_DOC     := TRB->ZZ4_DOC

                        SB7->B7_QUANT   := ConvUm(SB1->B1_COD, 0 ,TRB->ZZ4_VALOR,1)
                        SB7->B7_QTSEGUM := TRB->ZZ4_VALOR

                        SB7->B7_DATA    := STOD(TRB->ZZ4_DATA)
                        SB7->B7_DTVALID := DATE()    
                        SB7->B7_CONTAGE := "001"    
                        SB7->B7_ORIGEM  := "BDINVI04"
                        SB7->B7_STATUS  := "1"
                    MsUnLock()

                EndIf    
                 	
            EndIf

        EndIf   

        If lRet
            //Atualiza status do produto
            ZZ4->(dbSelectArea("ZZ4"))
            ZZ4->(dbGoTo(TRB->R_E_C_N_O_))
            If ZZ4->ZZ4_COD == TRB->ZZ4_COD 
                RecLock("ZZ4", .F.)
                    ZZ4->ZZ4_PROC := "1"
                MsUnLock()
            EndIf
        EndIf    

        TRB->(dbSkip())    
    Enddo

    

Return()
