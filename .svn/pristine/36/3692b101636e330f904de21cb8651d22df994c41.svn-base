#Include "Totvs.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "TopConn.ch"


User Function MT010INC()

Local aArea := GetArea()

    
    Processa( {|| U_fGeraSaldo(M->B1_COD)}, "Aguarde Gerando Saldo Inicial nos Armazéns")
    RestArea(aArea)   

Return Nil

//***********************************************************************

//***********************************************************************

User Function fGeraSaldo(cProduto)

Private lMsErroAuto := .F.        
    
    dbselectarea('SB9')
    dbsetorder(1)

    dbSelectArea('SB2')
    dbsetorder(1)

    DbSelectArea('NNR')
    NNR->(dbSetOrder(1))
    NNR->(DbGoTop())
    //NNR->(LASTREC())
    ProcRegua(RecCount())

    While NNR->(!EOF())

        IncProc("Armazém: " +NNR->NNR_CODIGO + " Da Filial: " + NNR->NNR_FILIAL )
        if NNR->NNR_MSBLQL == '1'
            NNR->(DBSKIP())
            LOOP
        Endif
        
        Begin Transaction
            
            IF !SB2->(DBSEEK(NNR->NNR_FILIAL + cProduto + NNR->NNR_CODIGO ))
                
                RecLock("SB2",.T.)
                    SB2->B2_FILIAL  := NNR->NNR_FILIAL
                    SB2->B2_COD     := cProduto
                    SB2->B2_LOCAL   := NNR->NNR_CODIGO
                    SB2->B2_LOCALIZ := NNR->NNR_DESCRI
                    SB2->B2_HMOV    := Time()
                    SB2->B2_DMOV    := Date()
                SB2->(MSUnlock())
            ENDIF

        End Transaction
        
        NNR->(DBSKIP())
    Enddo
    
Return
