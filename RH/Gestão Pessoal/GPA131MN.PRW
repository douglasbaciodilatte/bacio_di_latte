#INCLUDE 'RWMAKE.CH'
#INCLUDE 'PROTHEUS.CH'

/*/{Protheus.doc} User Function GPA131MN
    (long_description)
    @type  Function
    @author Douglas Silva
    @since 04/06/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function GPA131MN()
    
    Local aRotina := ParamIXB[ 01 ]

    aAdd(aRotina, { "Zerar VT" ,"U_1GPA131MN()" , 0 , Len(aRotina) + 1 })
    aAdd(aRotina, { "Zerar VR" ,"U_2GPA131MN()" , 0 , Len(aRotina) + 1 })

Return (aRotina)

User Function 1GPA131MN()

    //Busca informações tabela de beneficios 
    SM7->(dbSelectArea("SM7"))
    SM7->(dbSetOrder(3)) //M7_FILIAL+M7_MAT+M7_TPVALE+M7_CODIGO
    If SM7->(dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + "0"))

        //Zerar compra VT
        If MsgYesNo("ATENÇÃO: Deseja zerar a compra de VT Filial + Matricula " + SRA->RA_FILIAL + SRA->RA_MAT)

            Do While SM7->(!EOF()) .And. SRA->RA_FILIAL + SRA->RA_MAT + "0" == SM7->(M7_FILIAL+M7_MAT+M7_TPVALE)

                RecLock("SM7", .F.)	
                    SM7->M7_QDIAINF := 0
                MsUnLock()

                SM7->(dbSkip())
            Enddo    

        EndIf

    EndIf

    MsgInfo("Valor zerado com sucesso!")

Return

User Function 2GPA131MN()

    //Busca informações tabela de beneficios 
    SM7->(dbSelectArea("SM7"))
    SM7->(dbSetOrder(3)) //M7_FILIAL+M7_MAT+M7_TPVALE+M7_CODIGO
    If SM7->(dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + "1"))

        //Zerar compra VT
        If MsgYesNo("ATENÇÃO: Deseja zerar a compra de VR Filial + Matricula " + SRA->RA_FILIAL + SRA->RA_MAT)

            Do While SM7->(!EOF()) .And. SRA->RA_FILIAL + SRA->RA_MAT + "1" == SM7->(M7_FILIAL+M7_MAT+M7_TPVALE)

                RecLock("SM7", .F.)	
                    SM7->M7_QDIAINF := 0
                MsUnLock()

                SM7->(dbSkip())
            Enddo    
        
        EndIf

    EndIf

    MsgInfo("Valor zerado com sucesso!")

Return