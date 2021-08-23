#Include "TOTVS.ch"
#Include "FWMVCDEF.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#INCLUDE 'RWMAKE.CH'


/*/{Protheus.doc} CONFMVC
    @type User Function
    @author Felipe Mayer - RVacari
    @since 27/07/2020
    @Desc Funcao responsavel por criar tela MVC Conf UM p/ Solicit Transf
/*/
User Function CONFMVC()

Local oBrowse := FwLoadBrw("CONFMVC")
    
    oBrowse:Activate()
Return (NIL)


/*/{Protheus.doc} BrowseDef
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 27/07/2020
    @Desc Criacao do Browser
/*/
Static Function BrowseDef()

Local oBrowse := FwMBrowse():New()

    oBrowse:SetAlias("ZA1")
    oBrowse:SetDescription("Tela Conferência UM")

	oBrowse:AddLegend("Val(ZA1->ZA1_STATUS) < 1 ","BR_VERDE" , "Pendente")
    oBrowse:AddLegend("ZA1->ZA1_STATUS == '1'", "BR_AMARELO" , "Rejeitado")
    oBrowse:AddLegend("ZA1->ZA1_STATUS == '2'", "BR_AZUL"    , "Aceito")

    oBrowse:SetFilterDefault("ZA1->ZA1_FILIAL == '"+cFilNNS+"' .And. ZA1->ZA1_COD =='"+cCodNNS+"' ")
    oBrowse:SetMenuDef("CONFMVC")

Return (oBrowse)


/*/{Protheus.doc} MenuDef
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 27/07/2020
    @Desc Criacao do menu
/*/
Static Function MenuDef()

Local aRotina := {}

    ADD OPTION aRotina TITLE 'Aceite'       ACTION 'u_Efetivar'       OPERATION 3                      ACCESS 0
    ADD OPTION aRotina TITLE 'Rejeitar'     ACTION 'VIEWDEF.CONFMVC'  OPERATION MODEL_OPERATION_UPDATE ACCESS 0
    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.CONFMVC'  OPERATION MODEL_OPERATION_VIEW   ACCESS 0
    ADD OPTION aRotina TITLE 'Legenda'      ACTION 'u_LEGBDL'         OPERATION 6                      ACCESS 0 

Return (aRotina)


/*/{Protheus.doc} ModelDef
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 27/07/2020
    @Desc Criacao do modelo de dados 
/*/
Static Function ModelDef()

Local oModel := MPFormModel():New("BDLTRNSF")
Local oCabec := FwFormStruct(1, "ZA1")
Local oGrid  := FwFormStruct(1, "ZA2")

    oModel:AddFields("ZA1MASTER", NIL, oCabec)
    oModel:AddGrid("ZA2DETAIL", "ZA1MASTER", oGrid, {|| fLinOK()},,,,)
    
    oModel:SetPrimaryKey( { "ZA1_FILIAL", "ZA1_COD"} )
    oModel:SetRelation("ZA2DETAIL",{{"ZA2_FILIAL", "FwXFilial('ZA2')"}, {"ZA2_COD", "ZA1_COD"}}, ZA2->(IndexKey(1)))

    oModel:SetDescription("Conferência")

    oGrid:AddTrigger("ZA2_CONF1", "ZA2_USERCF",{|| .T.}, {|| UsrRetName(RetCodUsr())})
    oGrid:AddTrigger("ZA2_CONF2", "ZA2_USERCF",{|| .T.}, {|| UsrRetName(RetCodUsr())})
    oGrid:AddTrigger("ZA2_CONF1", "ZA2_DTCONF",{|| .T.}, {|| DATE()})
    oGrid:AddTrigger("ZA2_CONF2", "ZA2_DTCONF",{|| .T.}, {|| DATE()})
    oGrid:AddTrigger("ZA2_CONF1", "ZA2_HRCONF",{|| .T.}, {|| TIME()})
    oGrid:AddTrigger("ZA2_CONF2", "ZA2_HRCONF",{|| .T.}, {|| TIME()})
    oGrid:AddTrigger("ZA2_CONF1", "ZA2_DIF1UM",{|| .T.}, {|| CalcDif('1')})
    oGrid:AddTrigger("ZA2_CONF2", "ZA2_DIF1UM",{|| .T.}, {|| CalcDif('1')})
    oGrid:AddTrigger("ZA2_CONF2", "ZA2_DIF2UM",{|| .T.}, {|| CalcDif('2')})
    oGrid:AddTrigger("ZA2_CONF1", "ZA2_DIF2UM",{|| .T.}, {|| CalcDif('2')})
    oGrid:AddTrigger("ZA2_CONF1", "ZA2_CONF2",{|| .T.}, {|| fConvPrd('1')})
    oGrid:AddTrigger("ZA2_CONF2", "ZA2_CONF1",{|| .T.}, {|| fConvPrd('2')})

    oModel:GetModel("ZA1MASTER"):SetDescription("Cabeçalho")
    oModel:GetModel("ZA2DETAIL"):SetDescription("Itens")
    
Return oModel


/*/{Protheus.doc} ModelDef
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 27/07/2020
    @Desc Criacao da view do modelo de dados
/*/
Static Function ViewDef()

Local oView := FWFormView():New()
Local oCabec := FwFormStruct(2, "ZA1")
Local oGrid  := FwFormStruct(2, "ZA2")
Local oModel := FWLoadModel("CONFMVC")

    oCabec:RemoveField("ZA1_STATUS")
    oGrid:RemoveField("ZA2_FILIAL")
    oGrid:RemoveField("ZA2_COD")
    oGrid:RemoveField("ZA2_FILORI")
    oGrid:RemoveField("ZA2_FILDES")
    oGrid:RemoveField("ZA2_DATA")
    oGrid:RemoveField("ZA2_DIF1UM")
    oGrid:RemoveField("ZA2_DIF2UM")
    oGrid:RemoveField("ZA2_COLETA")

    oView:SetModel(oModel)
    oView:AddField("VIEW_ZA1", oCabec, "ZA1MASTER")
    oView:AddGrid("VIEW_ZA2", oGrid, "ZA2DETAIL")
    
    oView:AddIncrementField( 'VIEW_ZA2', 'ZA2_ITEM' )

    oView:CreateHorizontalBox("EMCIMA", 40)
    oView:CreateHorizontalBox("MEIO", 60)

    oView:EnableTitleView("VIEW_ZA1")
    oView:EnableTitleView("VIEW_ZA2", "ITENS", RGB(224, 30, 43))

    oView:SetOwnerView("VIEW_ZA1", "EMCIMA")
    oView:SetOwnerView("VIEW_ZA2", "MEIO")
    
Return (oView)


/*/{Protheus.doc} fLinOK
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 21/08/2020
    @Desc Pre-Validacao de linhas do Grid
/*/
Static Function fLinOK()

Local oModel  := FwModelActive()
    oModel:SetValue('ZA1MASTER','ZA1_STATUS','1') //Gatilho Grid -> Cabec - Status rejeita
    oModel:GetModel('ZA2DETAIL'):SetNoInsertLine( .T. ) //Nao deixa inserir linha
Return .T.


/*/{Protheus.doc} CalcDif
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 22/08/2020
    @Desc Calcula a diferença
/*/
Static Function CalcDif(cOper)

Local oModel := FwModelActive()
Local nRet   := 0
Local nQt1   := oModel:GetValue('ZA2DETAIL','ZA2_QTDUM')
Local nQt2   := oModel:GetValue('ZA2DETAIL','ZA2_QTSGUM')
Local nCf1   := oModel:GetValue('ZA2DETAIL','ZA2_CONF1')
Local nCf2   := oModel:GetValue('ZA2DETAIL','ZA2_CONF2')

    If cOper == '1'
        nRet := nQt1 - nCf1
    ElseIf cOper == '2'
        nRet := nQt2 - nCf2
    EndIf
Return nRet


/*/{Protheus.doc} fConvPrd
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 22/08/2020
    @Desc Conversao UM
/*/
Static Function fConvPrd(cOper)

Local oModel := FwModelActive()
Local nRet   := 0
Local nCf1   := oModel:GetValue('ZA2DETAIL','ZA2_CONF1')
Local nCf2   := oModel:GetValue('ZA2DETAIL','ZA2_CONF2')
Local cProd  := oModel:GetValue('ZA2DETAIL','ZA2_PROD')
Local cConv  := 0

    DbSelectArea("SB1")
    DbSetOrder(1)

    If DbSeek(xFilial("SB1")+AvKey(Alltrim(cProd),"B1_COD"))
        If cOper == '1'
            cConv := SB1->B1_CONV
            nRet := ConvUM(cProd,nCf1,0,2)
        ElseIf cOper == '2'
            cConv := SB1->B1_CONV
            nRet := ConvUM(cProd,0,nCf2,1)
        EndIf
    EndIf
Return nRet


/*/{Protheus.doc} LEGBDL
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 14/08/2020
    @Desc Tela de legenda
/*/
User Function LEGBDL()
    
Local aLegenda := {}
     
    AADD(aLegenda,{"BR_VERDE",       "Pendente"         })
    AADD(aLegenda,{"BR_AMARELO",     "Rejeitado"        })
    AADD(aLegenda,{"BR_AZUL",        "Aceito"           })

    BrwLegenda("Tela Conferência - Legendas", "Legendas", aLegenda)
Return


/*/{Protheus.doc} Efetivar
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 21/08/2020
    @Desc Efetiva o Aceite total
/*/
User Function Efetivar()

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
            EndIf
        EndIf
    EndIf
    RestArea(aArea)
Return
