#Include 'Totvs.ch'

/*/{Protheus.doc} BDVLDP
    @type User Function
    @author Felipe Mayer 
    @since 17/05/2021
    @Desc Validação de classe de produto X3_VALID == NNT_PROD
/*/

User Function BDVLDP()

Local lRet := .T.

    If Alltrim(FunName()) == 'BDTRASF' .And. Upper(SubsTr(UsrRetName(RetCodUsr()),0,2))=='LJ'
        dbSelectArea('SB1')
        dbSetOrder(1)

        If dbSeek(xFilial('SB1')+AvKey(M->NNT_PROD,'B1_COD'))
            If Empty(SB1->B1_XCLASPR)
                MsgAlert('<b>ATENÇÃO:</b> Produto não existe classe identificada, favor verificar com Compras Bacio','BDVLDP')
                lRet := .F.
            Else
                If M->NNS_XCLASP != SB1->B1_XCLASPR
                
                    cClasSB1 := Iif(SB1->B1_XCLASPR=='2','Congelado',Iif(SB1->B1_XCLASPR=='3','Bacio Casa','Seco'))
                    cClasNNT := Iif(M->NNS_XCLASP=='2','Congelado',Iif(M->NNS_XCLASP=='3','Bacio Casa','Seco'))

                    MsgAlert('<b>ATENÇÃO:</b> Produto classe '+cClasSB1 +', essa solicitação só pode entrar produto '+cClasNNT+'!','BDVLDP')
                    lRet := .F.
                EndIf
            EndIf
        EndIf

        SB1->(dbCloseArea())
    EndIf

Return lRet
