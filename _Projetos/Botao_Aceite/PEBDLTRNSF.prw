#Include 'Protheus.ch'
#Include 'FWMVCDEF.ch'
#Include "TOTVS.ch"
#Include "FWMVCDEF.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#include 'RWMAKE.CH'


/*/{Protheus.doc} BDLTRNSF
    @type  Ponto de Entrada - Conf UM Solicit Transf
    @author Felipe Mayer - RVacari
    @since 21/08/2020
/*/

User Function BDLTRNSF()

Local aParam     := PARAMIXB
Local oObj       := NIL      
Local cIdPonto   := Space(0)
Local nOper      := 0
Local lRet       := .T.
Local cStats     := ''
Local cCodAux    := ''
Local cFilAux    := ''

    If aParam <> NIL
        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]

        If cIdPonto == "MODELVLDACTIVE"
            nOper := oObj:nOperation

            If nOper == 4
                If Alltrim(ZA1->ZA1_STATUS) == '2' //Aceita total
                    lRet := .F.
                    MsgInfo('Essa transferência ja está aceita - Não será possível Alterar',"NAOALTERA")
                EndIf
            EndIf

        ElseIf cIdPonto == 'MODELCOMMITNTTS'

            oModelZA1 := oObj:AALLSUBMODELS[1] // Cabecalho
            oModelZA2 := oObj:AALLSUBMODELS[2] // Itens
                        
            cStats  := oModelZA1:GetValue("ZA1_STATUS")
            cCodAux := oModelZA1:GetValue("ZA1_COD")
            cFilAux := oModelZA1:GetValue("ZA1_FILIAL")
            
            If cStats == '1' // rejeitada(aceita parcial)
                DbSelectArea("NNS")
                DbSetOrder(1)

                If DbSeek(cFilAux+AvKey(cCodAux,"NNS_COD"))
                    
                    RecLock("NNS",.F.)
                        NNS->NNS_STATUS := '6'
                    NNS->(MsUnlock())
                    
                EndIf
            EndIf
                
        EndIf
    EndIf

Return lRet
