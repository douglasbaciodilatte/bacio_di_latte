#Include "TOTVS.ch"
#Include "FWMVCDEF.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#INCLUDE 'RWMAKE.CH'


/*/{Protheus.doc} STATNNS
    @type User Function
    @author Felipe Mayer - RVacari
    @since 14/09/2020
    @Desc Criar nome do status
/*/
User Function STATNNS()

Local cRet := ''

    If Alltrim(NNS->NNS_STATUS) == '1'
        cRet := 'Incluido'
    ElseIf Alltrim(NNS->NNS_STATUS) == '2'
        cRet := 'Em Transito'
    ElseIf Alltrim(NNS->NNS_STATUS) == '5'
        cRet := 'Recebido'
    ElseIf Alltrim(NNS->NNS_STATUS) == '6'
        cRet := 'Rejeitado'
    EndIf

Return (cRet)
