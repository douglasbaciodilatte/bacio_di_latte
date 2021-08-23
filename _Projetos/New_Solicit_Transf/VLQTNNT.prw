#Include 'Totvs.ch'

/*/{Protheus.doc} VLQTNNT
    @description Valida When na primeira e segunda unidade de medida
    @type User Function
    @author Felipe Mayer
    @since 02/08/2021
    @version 1
    @Param cPar=='1' === NNT_QUANT / cPar=='2' === NNT_QTSEG
/*/
User Function VLQTNNT(cPar)

Local lRet    := .F.
Local lTransf := Iif(Alltrim(Posicione("SB1",1,xFilial("SB1")+FwFldGet("NNT_PROD"),"B1_XTRANSF"))=='1',.T.,.F.)
        
        If cPar == '1'
            If SubsTr(FwFldGet("NNT_PROD"),1,2) $ "PA|PI"
                lRet := .T.
            ElseIf SubsTr(FwFldGet("NNT_PROD"),1,2) == "BN" .And. lTransf .And. cFilant == '0072'
                lRet := .T.
            EndIf
        ElseIf cPar == '2'
            If !SubsTr(FwFldGet("NNT_PROD"),1,2) $ "PA|PI"
                lRet := .T.
            ElseIf SubsTr(FwFldGet("NNT_PROD"),1,2) == "BN" .And. !lTransf .And. cFilant == '0072'
                lRet := .T.
            EndIf
        EndIf

Return lRet
