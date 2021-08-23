#Include "TOTVS.ch"
#Include "FWMVCDEF.ch"

#DEFINE OP_ALT	"004" // Alterar

/*/{Protheus.doc} BDTRASF
    @type User Function
    @author Felipe Mayer 
    @since 27/07/2020
    @Desc Funcao responsavel por criar tela Solicit Transf new
/*/
User Function BDTRASF()

Local oBrowse     := FwLoadBrw("BDTRASF")
Public __cClasPrd := ''
Public __cBkpFila := cFilAnt

    If Upper(SubsTr(UsrRetName(RetCodUsr()),0,2))=='LJ'
       oBrowse:SetFilterDefault("NNS_SOLICT== "+RetCodUsr())
    EndIf
    
    oBrowse:Activate()
Return (NIL)


/*/{Protheus.doc} BrowseDef
    @type Static Function
    @author Felipe Mayer 
    @since 27/07/2020
    @Desc Criacao do Browser
/*/
Static Function BrowseDef()

Local oBrowse := FwMBrowse():New()

    oBrowse:SetAlias("NNS")
    oBrowse:SetDescription("Solicitação de Transferência")

    oBrowse:AddLegend("NNS_STATUS == '1'","GREEN" ,'Incluido'   )
    oBrowse:AddLegend("NNS_STATUS == '2'","RED"   ,'Em Transito')
    oBrowse:AddLegend("NNS_STATUS == '5'","BLUE"  ,'Recebido'   )
    oBrowse:AddLegend("NNS_STATUS == '6'","YELLOW",'Rejeitado'  )

    oBrowse:SetMenuDef("BDTRASF")

Return (oBrowse)


/*/{Protheus.doc} MenuDefq
    @type Static Function
    @author Felipe Mayer 
    @since 27/07/2020
    @Desc Criacao do menu
/*/
Static Function MenuDef()

Local aRotina := {}

    ADD OPTION aRotina TITLE 'Incluir'      ACTION 'VIEWDEF.BDTRASF'   OPERATION MODEL_OPERATION_INSERT    ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.BDTRASF'   OPERATION OP_ALTERAR                ACCESS 0 ID OP_ALT
    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.BDTRASF'   OPERATION MODEL_OPERATION_VIEW      ACCESS 0
    ADD OPTION aRotina TITLE 'Legenda'      ACTION 'U_LEGBDLTR'         OPERATION 6                         ACCESS 0
    //ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.BDTRASF'   OPERATION MODEL_OPERATION_DELETE    ACCESS 3
    ADD OPTION aRotina TITLE "Receber NF-e" ACTION "U_SINCBDL"          OPERATION 9 ACCESS 0

Return (aRotina)


/*/{Protheus.doc} ModelDef
    @type Static Function
    @author Felipe Mayer 
    @since 27/07/2020
    @Desc Criacao do modelo de dados 
/*/

Static Function ModelDef()

Local oModel
Local oStrNNS	:= FWFormStruct(1,'NNS')
Local oStrNNT	:= FWFormStruct(1,'NNT')
Local aNoCopy	:= {'NNS_STATUS','NNS_SOLICT','NNS_DATA'}
Local aNoCopyNNT:= {'NNT_DOC','NNT_SERIE'}
Local aGatilho  := FwStruTrigger('NNT_PROD','NNT_PROD',"A311FillGrd()",.F.,,,,)

Local aUnique := oStrNNT:GetTable()[FORM_STRUCT_TABLE_ALIAS_PK]
Local nCodPos := AScan(aUnique,'NNT_COD')

    oModel := MPFormModel():New("311MODELS",,{|oModel|A311VLD(oModel)})

    oModel:AddFields('NNSMASTER',,oStrNNS)
    oModel:AddGrid('NNTDETAIL','NNSMASTER',oStrNNT,{|| fLinOK()},,)

    oModel:SetRelation('NNTDETAIL',{{'NNT_FILIAL','xFilial("NNT")'},{'NNT_COD','NNS_COD'}},NNT->(IndexKey(1)))

    oModel:GetModel('NNSMASTER'):SetDescription('Cabeçalho')
    oModel:GetModel('NNTDETAIL'):SetDescription('Itens')

    oStrNNT:AddTrigger(aGatilho[1],aGatilho[2],aGatilho[3],aGatilho[4])

    oModel:SetPrimaryKey({'NNS_FILIAL','NNS_COD'})

    If nCodPos > 0
        ADel(aUnique, nCodPos)
        ASize(aUnique, Len(aUnique)-1)
    EndIf

    oModel:GetModel('NNTDETAIL'):SetUniqueLine(aUnique)
    oModel:GetModel('NNSMASTER'):SetFldNoCopy(aNoCopy)
    oModel:GetModel('NNTDETAIL'):SetFldNoCopy(aNoCopyNNT)

    oModel:SetActivate({|oModel| A311ActMod(oModel,2)})

Return oModel


/*/{Protheus.doc} ViewDef
    @type Static Function
    @author Felipe Mayer 
    @since 27/07/2020
    @Desc Criacao da view do modelo de dados
/*/
Static Function ViewDef()

Local oView
Local nX        := 0
Local oModel	:= ModelDef()
Local oStrNNS	:= FWFormStruct(2,'NNS',{|cCampo| !AllTrim(cCampo) $ "NNS_STATUS"})
Local oStrNNT	:= FWFormStruct(2,'NNT',{|cCampo| !AllTrim(cCampo) $ "NNT_COD"})
Local aRemNNT   := {"NNT_LOCALI","NNT_NSERIE","NNT_LOTECT","NNT_NUMLOT","NNT_DTVALI","NNT_POTENC","NNT_LOCDES","NNT_LOTED",;
                    "NNT_DTVALD","NNT_XHORA","NNT_XDATA","NNT_USERGI","NNT_USERGA","NNT_XOBSCO","NNT_XCUSTD","NNT_XMOTIV","NNT_XDTEXC"}

    oView := FWFormView():New()

    oView:SetModel(oModel)

    oView:AddField('NNSMASTER',oStrNNS,'NNSMASTER')
    oView:AddGrid('NNTDETAIL' ,oStrNNT,'NNTDETAIL')

    oView:CreateHorizontalBox('BOXCIMA',40)
    oView:CreateHorizontalBox('BOXBAIXO',60)

    oView:SetOwnerView('NNSMASTER','BOXCIMA')
    oView:SetOwnerView('NNTDETAIL','BOXBAIXO')

    oView:EnableTitleView('NNSMASTER','Cabeçalho')
    oView:EnableTitleView('NNTDETAIL','Itens')

    oView:AddUserButton('Replicar TES','CLIPS',{||A311RepTES()})

    For nX := 1 To Len(aRemNNT)
        oStrNNT:RemoveField(aRemNNT[nX])
    Next nX

    oStrNNS:RemoveField("NNS_JUSTIF")
    oStrNNS:RemoveField("NNS_XNSTAT")
    
Return oView


/*/{Protheus.doc} fLinOK
    @type Static Function
    @author Felipe Mayer 
    @since 29/09/2020
    @Desc Pre-Validacao de linhas do Grid (Gatilho Grid -> Cabec - Status rejeita)
/*/
Static Function fLinOK()

Local oModel  := FwModelActive()
    oModel:SetValue('NNSMASTER','NNS_STATUS','1')
Return .T.


/*/{Protheus.doc} LEGBDLTR
    @type Static Function
    @author Felipe Mayer 
    @since 14/08/2020
    @Desc Tela de legenda
/*/
User Function LEGBDLTR()
    
Local aLegAux := {}
     
    aAdd(aLegAux,{"BR_VERDE"   ,"Liberado"    })
    aAdd(aLegAux,{"BR_VERMELHO","Transferido" })
    aAdd(aLegAux,{"BR_AZUL"    ,"Em Aprovação"})
    aAdd(aLegAux,{"BR_AMARELO" ,"Rejeitado"   })

    BrwLegenda("Tela Conferência - Legendas", "Legendas", aLegAux)
Return


/*/{Protheus.doc} STATNNS1
    @type User Function
    @author Felipe Mayer 
    @since 29/09/2020
    @Desc Criar nome do status
/*/
User Function STATNNS1()

Local cRet := ''

    If Alltrim(NNS->NNS_STATUS) == '1'
        cRet := 'Liberado'
    ElseIf Alltrim(NNS->NNS_STATUS) == '2'
        cRet := 'Transferido'
    ElseIf Alltrim(NNS->NNS_STATUS) == '3'
        cRet := 'Em Aprovação'
    ElseIf Alltrim(NNS->NNS_STATUS) == '4'
        cRet := 'Rejeitado'
    EndIf

Return (cRet)

//-------------------------------------------------------------------
/*/{Protheus.doc} A311ActMod()
Valida ativação do modelo

@author desconhecido
@since desconhecido
@version P12.0
/*/
//-------------------------------------------------------------------

Static Function A311VLD(oModel)

Local oModelNNT := oModel:GetModel('NNTDETAIL')
Local lRet		:= .T.
Local nX		:= 0
Local aFilDes	:= {}

    For nX := 1 To oModelNNT:Length()
        oModelNNT:GoLine(nX)
        
        If !oModelNNT:IsDeleted()
            If cFilAnt # oModelNNT:GetValue('NNT_FILDES')
                
                aAdd(aFilDes,oModelNNT:GetValue('NNT_FILDES'))
                
                If Empty(oModelNNT:GetValue('NNT_TS'))
                    Alert("O campo NNT_TS não foi preenchido. Preencha o campo com o código da TES de saida.")
                    lRet := .F.
                Endif
                
                If lRet
                    If Empty(oModelNNT:GetValue('NNT_TE'))
                        Alert("O campo NNT_TE não foi preenchido. Preencha o campo com o código da TES de entrada.")
                        lRet := .F.
                    Endif
                Endif

                //validação Douglas Silva 15/01/2021 - Verifica quantidade 0 Primeira ou Seunda
                If lRet
                    If (oModelNNT:GetValue('NNT_QUANT')) == 0 .Or. (oModelNNT:GetValue('NNT_QTSEG')) == 0 
                        Alert("O campo NNT_QUANT ou NNT_QTSEG não foi preenchido. Preencha a quantidade solicitada.")
                        lRet := .F.
                    Endif
                Endif

                //Validação Douglas Silva 15/01/2021 - Verifica saldo de cotas
                If lRet
                    cChave := oModelNNT:GetValue('NNT_FILDES')+;  //Filial Destino
                              oModelNNT:GetValue('NNT_PROD')+;    //Codigo Produto destino	
                              oModelNNT:GetValue('NNT_LOCLD')     // Armazem Destino  			

                    //Verifica tabela de cotas
                    ZCC->(dbSelectArea("ZCC"))
                    ZCC->(dbSetOrder(1))
                    If ZCC->(dbSeek(cChave))
                    
                        //Verifica saldo em Cota
                        nQtde1 := oModelNNT:GetValue('NNT_QUANT')
                        nQtde2 := oModelNNT:GetValue('NNT_QTSEG')
                        
                        If ZCC->ZCC_QTDE1 > 0 
                            If nQtde1 > ZCC->ZCC_QTDE1 	       			
                                Alert("ATENÇÃO: Quantidade solicitada maior que o saldo em cotas, solicite revisão ao Consultor<br>"+;
                                "Saldo: "+cValToChar(ZCC->ZCC_QTDE1)+"<br>"+;
                                "Produto: "+Alltrim(oModelNNT:GetValue('NNT_PROD'))) 
                                lRet := .F.
                            EndIf	

                        ElseIf ZCC->ZCC_QTDE2 > 0	
                            If nQtde2 > ZCC->ZCC_QTDE2  		       			
                                Alert("ATENÇÃO: Quantidade solicitada maior que o saldo em cotas, solicite revisão ao Consultor<br>"+;
                                "Saldo: "+cValToChar(ZCC->ZCC_QTDE2)+"<br>"+;
                                "Produto: "+Alltrim(oModelNNT:GetValue('NNT_PROD'))) 
                                lRet := .F.	       			
                            EndIf

                        ElseIf ZCC->ZCC_QTDE1 == 0 .And. ZCC->ZCC_QTDE2 == 0	
                            Alert("ATENÇÃO: Não é possível solicitar o item pois não existe saldo de cotas, Saldo = 0 Solicite revisão ao Consultor<br>"+;
                            "Produto: "+Alltrim(oModelNNT:GetValue('NNT_PROD'))) 
                            lRet := .F.	       			
                        EndIf
                    EndIf
                EndIf    
            EndIf            
        EndIf           
    Next nX

Return lRet
