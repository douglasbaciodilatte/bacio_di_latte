#INCLUDE "PROTHEUS.CH"
#include "TOPCONN.CH"

/*/{Protheus.doc} User Function BDFAT001
    (long_description)
    @type  Function
    @author Douglas Rodrigues da Silva
    @since 21/08/2021
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    Função tem como objetivo gerar aviso de pagamento de GUIA ICMS-ST 
    ao faturar notas que o cliente não possuer Inscrição ST
    @see (links_or_references)
    /*/

User Function BDFAT001()
    
    Local aArea   := GetArea()
    Local cMsg    := ""
    Local cInstST := SUPERGETMV("MV_SUBTRIB", .T., [])
    Local aInstST := []
    Local nx      := 0  
    Local lMostra := .T.  

    aInstST := Separa(cInstST,"/", .F.)
        
    If SC5->C5_TIPO == "N"

        If SF2->F2_ICMSRET != 0

            SA1->(dbselectarea("SA1"))
            SA1->(dbsetorder(1))
            If SA1->(dbSeek( xFilial("SA1") + SC6->C6_CLI + SC6->C6_LOJA))

                //Preenche aviso
                cMsg    := "ATENÇÃO: Estado não possui inscrição ST, Avisar ao fiscal pagamento da GUIA ICMS ST Nota " + SF2->F2_DOC + " Serie " + SF2->F2_SERIE + " Cliente " + Alltrim(SA1->A1_NREDUZ)
                
                For nx := 1 To Len( aInstST ) 

                    If SF2->F2_EST == SUBSTR(aInstST[nx] ,1,2)
                        lMostra := .F.
                    EndIf

                Next nx

                If lMostra
                    //Mensagem grande com ícone
                    Aviso("Pagamento Guia ICMS ST", cMsg, {"OK"}, 3, "Bacio di Latte - BDFAT001", , "BR_AZUL")
                EndIf

            EndIf    
        EndIf

    Endif    
     
    RestArea(aArea)

Return 
