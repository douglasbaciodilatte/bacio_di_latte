
User Function TRFBD001()

    Local oBrowse
    Private cCadastro  := "Registro de Transferência de Materiais - Bacio"

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias('NNS')
    oBrowse:SetDescription("Registro de Transferência de Materiais - Bacio")
    
    //Legendas
    oBrowse:AddLegend( "NNS_STATUS == '1'", "GREEN"		, STR0004 	)//"Liberado"
    oBrowse:AddLegend( "NNS_STATUS == '2'", "RED"		, STR0005 	)//"Transferido"
    oBrowse:AddLegend( "NNS_STATUS == '3'", "BLUE"		, STR0006 	)//"Em Aprovação"
    oBrowse:AddLegend( "NNS_STATUS == '4'", "YELLOW"	, STR0007 	)//"Rejeitado"
   
    If Existblock("MT311Leg")
        ExecBlock('MT311Leg', .F., .F., {@oBrowse})
    Endif

    SetKey(VK_F4,{|| A311SetKey() })

    oBrowse:Activate()

        
Return 
