#Include 'Protheus.ch'
#Include 'FWMVCDEF.ch'
#Include "TOTVS.ch"
#Include "FWMVCDEF.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#include 'RWMAKE.CH'


/*/{Protheus.doc} SINCBDL
    @type User Function
    @author Felipe Mayer - RVacari
    @since 21/08/2020
    @Desc Sincronizar ZA1/ZA2 com NNS/NNT
/*/
User Function SINCBDL()

Local cCodVld   := ''
Local cQuery    := ''
Local cQryDl    := ''
Local cStsZA1   := ''
Local aAux      := {}
Local nX        := 0
Local nY        := 0
Local lStsZA1   := .T.
Public cCodNNS  := NNS->NNS_COD
Public cFilNNS  := NNS->NNS_FILIAL
Public cStsNNS  := NNS->NNS_STATUS

/*/ =====================================
    -----Status ZA1------
    1 -> Rejeitado (aceita parcial)
    2 -> Aceita
    Vazio -> Pendente

    -----Status NNS------
    1 -> Liberado
    2 -> Efetivado
    5 -> Aceita
    6 -> Rejeitado (aceita parcial)
========================================/*/


    If cStsNNS == "1" // se a solicit estiver em aberto
        MsgAlert("Operação não realizada!<br><br><b>Motivo: </b>Essa solicitação não está efetivada","NaoReceb")
    
    ElseIf cStsNNS == "5" //se estiver aceita total
        DbSelectArea("ZA1")
        DbSetOrder(1)
        If DbSeek(cFilNNS+AvKey(cCodNNS,"ZA1_COD"))
            If MsgYesNo("Essa transferência ja foi recebida, deseja visualizar recebimento?")
                FWExecView("Visualizar", "VIEWDEF.CONFMVC", MODEL_OPERATION_VIEW)
            EndIf
        EndIf

    ElseIf cStsNNS $ "2 | 6" // se a solicit estiver transferida ou rejeitada(aceita parcial)
        cQuery := " SELECT ZA1_COD,ZA1_STATUS FROM "+RetSqlName("ZA1")+" WHERE ZA1_COD='"+cCodNNS+"' AND ZA1_FILIAL='"+cFilNNS+"' "

        If Select("TRB") <> 0
            DbSelectArea("TRB")
            DbCloseArea()
        EndIf	

        DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),'TRB',.F.,.T.)

        cStsZA1 := TRB->ZA1_STATUS

        If !Empty(TRB->ZA1_COD)
            If cStsZA1 == '2' // se tiver aceita
                lStsZA1 := .F.

                DbSelectArea("ZA1")
                DbSetOrder(1)
                If DbSeek(cFilNNS+AvKey(cCodNNS,"ZA1_COD"))
                    If MsgYesNo("Essa transferência ja foi recebida, deseja visualizar recebimento?")
                        FWExecView("Visualizar", "VIEWDEF.CONFMVC", MODEL_OPERATION_VIEW)
                    EndIf
                EndIf
            EndIf
        EndIf

        If lStsZA1
            cQuery := " SELECT NNS_COD,NNS_DATA,NNT_PROD,B1_DESC,NNT_QUANT,NNT_QTSEG,NNT_FILORI,NNT_FILDES,NNS_FILIAL,NNS_SOLICT, "
            cQuery += " NNS_XNOMSO,NNS_CLASS,NNS_ESPECI,NNS_XTPFRE,NNT_UM FROM "+RetSqlName("NNS")+" NNS "
            cQuery += " INNER JOIN "+RetSqlName("NNT")+" NNT ON NNT_COD=NNS_COD AND NNT_FILIAL=NNS_FILIAL AND NNT.D_E_L_E_T_='' "
            cQuery += " LEFT JOIN "+RetSqlName("SB1")+" SB1 ON B1_COD=NNT_PROD AND SB1.D_E_L_E_T_='' "
            cQuery += " WHERE NNS.D_E_L_E_T_='' AND NNS_COD='"+cCodNNS+"' AND NNS_FILIAL='"+cFilNNS+"' "

            If Select("TMP") <> 0
                DbSelectArea("TMP")
                DbCloseArea()
            EndIf	

            DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),'TMP',.F.,.T.)
            
            While TMP->(!EOF())
                aadd(aAux,{;
                    TMP->NNS_COD     ,;
                    TMP->NNS_DATA    ,;
                    TMP->NNT_PROD    ,;
                    TMP->B1_DESC     ,;
                    TMP->NNT_QUANT   ,;
                    TMP->NNT_QTSEG   ,;
                    TMP->NNT_FILORI  ,;
                    TMP->NNT_FILDES  ,;
                    TMP->NNS_FILIAL  ,;
                    TMP->NNS_SOLICT  ,;
                    TMP->NNS_XNOMSO  ,;
                    TMP->NNS_CLASS   ,;
                    TMP->NNS_ESPECI  ,;
                    TMP->NNS_XTPFRE  ,;
                    TMP->NNT_UM      })
                TMP->(DbSkip())
            EndDo

            If !Empty(aAux)
                For nX := 1 To Len(aAux)

                    DbSelectArea("ZA1")
                    DbSetOrder(1)

                    If !DbSeek(cFilNNS+AvKey(cCodNNS,"ZA1_COD"))  // Cria Cabec
                        If cCodVld <> aAux[nX,01]
                            Reclock('ZA1',.T.)
                                ZA1->ZA1_FILIAL := cFilNNS
                                ZA1->ZA1_COD    := cCodNNS
                                ZA1->ZA1_DATA   := Iif(ValType(aAux[nX,02]) == 'C',SToD(aAux[nX,02]),aAux[nX,02])
                                ZA1->ZA1_SOLICT := Alltrim(aAux[nX,10])
                                ZA1->ZA1_NSOLIC := Alltrim(aAux[nX,11])
                                ZA1->ZA1_CLASS  := aAux[nX,12]
                                ZA1->ZA1_ESPECI := aAux[nX,13]
                                ZA1->ZA1_TPFRET := aAux[nX,14]
                            MsUnlock()
                            cCodVld := aAux[nX,01]
                        EndIf 
                    ElseIf DbSeek(cFilNNS+AvKey(cCodNNS,"ZA1_COD"))
                        If cCodVld <> aAux[nX,01]
                            Reclock('ZA1',.F.)
                                ZA1->ZA1_FILIAL := cFilNNS
                                ZA1->ZA1_COD    := cCodNNS
                                ZA1->ZA1_DATA   := Iif(ValType(aAux[nX,02]) == 'C',SToD(aAux[nX,02]),aAux[nX,02])
                                ZA1->ZA1_SOLICT := Alltrim(aAux[nX,10])
                                ZA1->ZA1_NSOLIC := Alltrim(aAux[nX,11])
                                ZA1->ZA1_CLASS  := aAux[nX,12]
                                ZA1->ZA1_ESPECI := aAux[nX,13]
                                ZA1->ZA1_TPFRET := aAux[nX,14]
                            MsUnlock()
                            cCodVld := aAux[nX,01]
                        EndIf 
                    EndIf
                    
                    DbSelectArea("ZA2")
                    DbSetOrder(1)

                    If !Empty(cStsZA1) // se for diferente de pendente nao entra no If
                        If cStsZA1 <> '1' // se for diferente de aceito parcial
                            If DbSeek(cFilNNS+AvKey(cCodNNS,"ZA2_COD"))
                                cQryDl := " DELETE FROM "+RetSqlName("ZA2")+" WHERE ZA2_COD='"+cCodNNS+"' AND ZA2_FILIAL='"+cFilNNS+"' AND D_E_L_E_T_='' "
                                TCSQLExec(cQryDl)
                            EndIf
                        EndIf
                    EndIf

                    If !DbSeek(cFilNNS+AvKey(cCodNNS,"ZA2_COD"))  // Cria Grid
                        For nY := 1 To Len(aAux)
                            If cCodVld == aAux[nY,01]
                                Reclock('ZA2',.T.)
                                    ZA2->ZA2_COD    := cCodNNS
                                    ZA2->ZA2_FILIAL := cFilNNS
                                    ZA2->ZA2_DATA   := Iif(ValType(aAux[nY,02]) == 'C',SToD(aAux[nY,02]),aAux[nY,02])
                                    ZA2->ZA2_PROD   := aAux[nY,03]
                                    ZA2->ZA2_DESC   := aAux[nY,04]
                                    ZA2->ZA2_QTDUM  := aAux[nY,05]
                                    ZA2->ZA2_QTSGUM := aAux[nY,06]
                                    ZA2->ZA2_FILORI := aAux[nY,07]
                                    ZA2->ZA2_FILDES := aAux[nY,08]
                                    ZA2->ZA2_UM     := aAux[nY,15]
                                MsUnlock()
                                cCodVld := aAux[nY,01]	
                                nX++
                            EndIf
                        Next nY
                    EndIf
                Next nX
            EndIf
            Processa( {|| TelaOk(cFilNNS,cCodNNS) }, "CONFMVC", "Processando aguarde...", .F.)
        EndIf
    EndIf
Return


/*/{Protheus.doc} TelaOk
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 21/08/2020
    @Desc Tela botao aceite
/*/
Static Function TelaOk(cFilNNS,cCodNNS)

SetPrvt("oFont1","oDlg1","oBtn3","oGrp1","oSay1","oSay2","oSay3","oBtn4")

    DbSelectArea("ZA1")
    DbSetOrder(1)
    If DbSeek(cFilNNS+AvKey(cCodNNS,"ZA1_COD"))

        oFont1     := TFont():New( "Myanmar Text",0,-13,,.T.,0,,600,.F.,.F.,,,,,, )
        oDlg1      := MSDialog():New( 092,232,301,767,"Conferência UM",,,.F.,,,,,,.T.,,,.T. )
        oBtn2      := TButton():New( 078,213,"Aceitar",oDlg1, {||Processa( {|| fEfetiva(cFilNNS,cCodNNS) }, "CONFMVC", "Processando aguarde...", .F.),oDlg1:End()},042,018,,oFont1,,.T.,,"",,,,.F. )
        oBtn3      := TButton():New( 078,162,"Rejeitar",oDlg1,{||Processa( {|| fRejeita(cFilNNS,cCodNNS) }, "CONFMVC", "Processando aguarde...", .F.),oDlg1:End()},042,018,,oFont1,,.T.,,"",,,,.F. )
        oGrp1      := TGroup():New( 004,008,064,263,"",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
        oSay1      := TSay():New( 012,016,{||'Solicitação: '+cCodNNS},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,112,008)
        oSay2      := TSay():New( 012,148,{||"Data Solicit: "+DToC(ZA1->ZA1_DATA)},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,096,008)
        oSay3      := TSay():New( 040,016,{||"Solicitante: "+Alltrim(ZA1->ZA1_SOLICT)+' - '+Alltrim(ZA1->ZA1_NSOLIC)},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,204,008)
        oDlg1:Activate(,,,.T.)
    EndIf

Return


/*/{Protheus.doc} fRejeita
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 21/08/2020
    @Desc chama funçao de rejeite
/*/
Static Function fRejeita(cFilNNS,cCodNNS)

    DbSelectArea("ZA1")
    DbSetOrder(1)
    If DbSeek(cFilNNS+AvKey(cCodNNS,"ZA1_COD"))
        FWExecView("Conferir", "VIEWDEF.CONFMVC", MODEL_OPERATION_UPDATE)
    EndIf

Return



/*/{Protheus.doc} fEfetiva
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 21/08/2020
    @Desc Efetiva o Aceite total
/*/
Static Function fEfetiva(cFilNNS,cCodNNS)

Local aArea   := GetArea()
Local lEfetiv := .T.

    DbSelectArea('ZA1')
    DbSetOrder(1)

    If DbSeek(cFilNNS+AvKey(cCodNNS,"ZA1_COD"))

        If Alltrim(ZA1->ZA1_STATUS) == '2'
            MsgAlert('Não foi possível realizar a operação!<br><br>Motivo: <b>Essa transferência ja está aceita.</b>',"NaoAceita")
            lEfetiv := .F.
            Return
        EndIf

        If lEfetiv
            If MsgYesNo("Deseja aceitar a transferência: <b>"+cCodNNS+"</b> ?","Aceite")

                If Alltrim(ZA1->ZA1_FILIAL) == Alltrim(cFilNNS)
                    RecLock("ZA1",.F.)
                        ZA1->ZA1_STATUS := '2' //Aceito
                    ZA1->(MsUnlock())
                EndIf
                
                DbSelectArea('NNS')
                DbSetOrder(1)
                
                If DbSeek(cFilNNS+AvKey(cCodNNS,"NNS_COD"))
                    RecLock("NNS",.F.)
                        NNS->NNS_STATUS := '5' //Aceito
                    NNS->(MsUnlock())
                EndIf

                DbSelectArea('ZA2')
                DbSetOrder(1)

                If DbSeek(cFilNNS+AvKey(cCodNNS,"ZA2_COD"))
                    While ZA2->(!EOF()) .And. Alltrim(ZA2->ZA2_COD) == Alltrim(cCodNNS) .And. Alltrim(ZA2->ZA2_FILIAL) == Alltrim(cFilNNS)
                        RecLock("ZA2",.F.)
                            ZA2->ZA2_CONF1  := ZA2->ZA2_QTDUM
                            ZA2->ZA2_CONF2  := ZA2->ZA2_QTSGUM
                            ZA2->ZA2_USERCF := UsrRetName(RetCodUsr())
                            ZA2->ZA2_DTCONF := Date()
                            ZA2->ZA2_HRCONF := Time()
                        ZA2->(MsUnlock())
                        ZA2->(Dbskip())
                    EndDo
                EndIf
                MsgInfo("Aceite Realizado!")
            Else
                MsgAlert("Processo abortado!")
            EndIf
        EndIf
    EndIf
    RestArea(aArea)
Return
