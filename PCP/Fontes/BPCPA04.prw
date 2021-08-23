/*Importar as bibliotecas*/
#Include "TOTVS.ch"
#Include "FWMVCDEF.ch"


//-------------------------------------------------------------------
/*/{Protheus.doc} U_MVCGRID
Função principal da rotina MVC

@author Daniel Mendes
@since 10/07/2020
@version 1.0
/*/
//-------------------------------------------------------------------

User Function BPCPA04()

	Local oBrowse
	
	oBrowse := FWmBrowse():New()
	oBrowse:SetAlias("SB8")
	oBrowse:SetDescription("Bacio Di Latte - Consultar Lotes")
	oBrowse:SetProfileID('1')
	oBrowse:Activate()


Return

/*---------------------------------------------------------------------------
MenuDef
---------------------------------------------------------------------------*/

Static Function MenuDef()
	
	Local aRotina := {}
	
    ADD OPTION aRotina Title 'Visualizar'		Action 'VIEWDEF.BPCPA04'	OPERATION 2 ACCESS 0
	ADD OPTION aRotina Title 'Alterar'			Action 'VIEWDEF.BPCPA04'	OPERATION 4 ACCESS 0
	
Return aRotina

Static Function ModelDef()
	
	Local oModel
	Local oStruct := FWFormStruct(1,'SB8') //Principal
		
	oModel:= MPFormModel():New('xBPCPA04')
	oModel:AddFields('SB8MASTER', /*cOwner*/, oStruct )
	oModel:SetPrimaryKey( {} )
	oModel:SetDescription("Bacio Di Latte - Consultar Lotes")

	//jj,,oModel:SetPrimaryKey({'ZCC_FILIAL','ZCC_COD', 'ZCC_LOCAL'})
	  
	oModel:GetModel("SB8MASTER"):SetDescription("Controle de Lote - SB8")
	
Return oModel	

Static Function ViewDef()

	Local oView
	Local oModel  := FWLoadModel('BPCPA04')
	Local oStruct := FWFormStruct(2,'SB8')

	oStruct:RemoveField('B8_MSBLQL')

	oStruct:SetNoFolder()
	
	//Grupo de Campos
	oStruct:AddGroup('GRPPRD','Produto','', 2 )
	oStruct:AddGroup('GRPLOC','Armazém'				,'', 2 )
	oStruct:AddGroup('GRPQTD','Quantidade'			,'', 2 )
    oStruct:AddGroup('GRPLOT','Lote'    			,'', 2 )
    oStruct:AddGroup('GRPEMP','Empenho'    			,'', 2 )
	
	oStruct:SetProperty("B8_PRODUTO"	,MVC_VIEW_GROUP_NUMBER,'GRPPRD')
	oStruct:SetProperty("B8_DESC"		,MVC_VIEW_GROUP_NUMBER,'GRPPRD')
    oStruct:SetProperty("B8_DATA"		,MVC_VIEW_GROUP_NUMBER,'GRPPRD')

	
	oStruct:SetProperty("B8_LOCAL"		,MVC_VIEW_GROUP_NUMBER,'GRPLOC')
	
	oStruct:SetProperty("B8_SALDO"		,MVC_VIEW_GROUP_NUMBER,'GRPQTD')
	oStruct:SetProperty("B8_SALDO2"		,MVC_VIEW_GROUP_NUMBER,'GRPQTD')

    oStruct:SetProperty("B8_LOTECTL"	,MVC_VIEW_GROUP_NUMBER,'GRPLOT')
    oStruct:SetProperty("B8_DTVALID"	,MVC_VIEW_GROUP_NUMBER,'GRPLOT')

    oStruct:SetProperty("B8_EMPENHO"	,MVC_VIEW_GROUP_NUMBER,'GRPEMP')
    oStruct:SetProperty("B8_EMPENH2"	,MVC_VIEW_GROUP_NUMBER,'GRPEMP')
		
	oView := FWFormView():New() //construindo o modelo de dados
	
	oView:SetModel(oModel) //Passando o modelo de dados informado
	
	oView:AddField("VIEW_SB8", oStruct, "SB8MASTER")
	
	oView:CreateHorizontalBox("TELA",100) //Criando um container com o identificador TELA
	
	oView:EnableTitleView("VIEW_SB8") //Adicionando titulo ao formulário
	
	oView:SetCloseOnOk({||.T.}) //força o fechamento da janela
	
	oView:SetOwnerView("VIEW_SB8","TELA") //adicionando o formulário da inerface ao container
	
Return oView
