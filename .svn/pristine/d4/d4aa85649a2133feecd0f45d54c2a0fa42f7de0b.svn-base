#Include 'Protheus.ch'
#Include 'FWMVCDEF.ch'
#Include "TOTVS.ch"
#Include "FWMVCDEF.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#include 'RWMAKE.CH'



/*/{Protheus.doc} LEG311
    @type User Function
    @author Felipe Mayer - RVacari
    @since 21/08/2020
    @Desc Tela de legenda MATA311
/*/
User Function LEG311()
    
Local aLegAux := {}
     
    AADD(aLegAux,{"BR_VERDE"     ,  "Incluido"    })
    AADD(aLegAux,{"BR_VERMELHO"  ,  "Em Transito" })
    AADD(aLegAux,{"BR_AZUL"      ,  "Recebido"    })
    AADD(aLegAux,{"BR_AMARELO"   ,  "Rejeitado"   })

    BrwLegenda("Solicitação de Transferência - Legendas", "Legendas", aLegAux)

Return
