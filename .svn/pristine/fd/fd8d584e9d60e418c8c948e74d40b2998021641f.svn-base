/*Importar as bibliotecas*/
#Include "TOTVS.ch"
#Include "FWMVCDEF.ch"

/*Iniciando sua função*/
User Function BDESTA04()

	Local oBrowse
	
	oBrowse := FWmBrowse():New()
	oBrowse:SetAlias("ZCC")
	oBrowse:SetDescription("Bacio Di Latte - Controle de Cotas")
	oBrowse:SetProfileID('1')
	oBrowse:Activate()

Return 

/*---------------------------------------------------------------------------
MenuDef
---------------------------------------------------------------------------*/

Static Function MenuDef()
	
	Local aRotina := {}
	
    ADD OPTION aRotina Title 'Visualizar'		Action 'VIEWDEF.BDESTA04'	OPERATION 2 ACCESS 0
	ADD OPTION aRotina Title 'Incluir'			Action 'VIEWDEF.BDESTA04'	OPERATION 3	ACCESS 0
	ADD OPTION aRotina Title 'Alterar'			Action 'VIEWDEF.BDESTA04'	OPERATION 4 ACCESS 0
	ADD OPTION aRotina Title 'Excluir'			Action 'VIEWDEF.BDESTA04' 	OPERATION 5 ACCESS 0
	ADD OPTION aRotina Title 'Exportar/Importar' Action 'U_xBDEST01' 		OPERATION 6 ACCESS 0
	
Return aRotina

/*---------------------------------------------------------------------------
ModelDef
---------------------------------------------------------------------------*/

Static Function ModelDef()
	
	Local oModel
	Local oStruct := FWFormStruct(1,'ZCC') //Principal
		
	oModel:= MPFormModel():New('xBDESTA04')
	oModel:AddFields('ZCCMASTER', /*cOwner*/, oStruct )
	oModel:SetPrimaryKey( {} )
	oModel:SetDescription("Bacio Di Latte - Controle de Cotas")

	//jj,,oModel:SetPrimaryKey({'ZCC_FILIAL','ZCC_COD', 'ZCC_LOCAL'})
	  
	oModel:GetModel("ZCCMASTER"):SetDescription("Formulário de cadastro")
	
Return oModel	

/*---------------------------------------------------------------------------
ViewDef
---------------------------------------------------------------------------*/
Static Function ViewDef()

	Local oView
	Local oModel  := FWLoadModel('BDESTA04')
	Local oStruct := FWFormStruct(2,'ZCC')

	oStruct:RemoveField('ZCC_MSBLQL')

	oStruct:SetNoFolder()
	
	//Grupo de Campos
	oStruct:AddGroup('GRPPRD','Produto','', 2 )
	oStruct:AddGroup('GRPLOC','Armazém'				,'', 2 )
	oStruct:AddGroup('GRPQTD','Quantidade'			,'', 2 )
	
	oStruct:SetProperty("ZCC_COD"		,MVC_VIEW_GROUP_NUMBER,'GRPPRD')
	oStruct:SetProperty("ZCC_DESC"		,MVC_VIEW_GROUP_NUMBER,'GRPPRD')
	
	oStruct:SetProperty("ZCC_LOCAL"		,MVC_VIEW_GROUP_NUMBER,'GRPLOC')
	oStruct:SetProperty("ZCC_DESCLO"	,MVC_VIEW_GROUP_NUMBER,'GRPLOC')
	
	oStruct:SetProperty("ZCC_QTDE1"		,MVC_VIEW_GROUP_NUMBER,'GRPQTD')
	oStruct:SetProperty("ZCC_QTDE2"		,MVC_VIEW_GROUP_NUMBER,'GRPQTD')
		
	oView := FWFormView():New() //construindo o modelo de dados
	
	oView:SetModel(oModel) //Passando o modelo de dados informado
	
	oView:AddField("VIEW_ZCC", oStruct, "ZCCMASTER")
	
	oView:CreateHorizontalBox("TELA",100) //Criando um container com o identificador TELA
	
	oView:EnableTitleView("VIEW_ZCC") //Adicionando titulo ao formulário
	
	oView:SetCloseOnOk({||.T.}) //força o fechamento da janela
	
	oView:SetOwnerView("VIEW_ZCC","TELA") //adicionando o formulário da inerface ao container
	
Return oView

User Function xBDEST01()
	
	Local aParamBox := {}
	Local cCaminho  := Space(100)
	Private aRet 	:= {}
	
	aAdd(aParamBox,{3,"Tipo de Dados",1,{"Exportar","Importar"},50,"",.F.})
	aAdd(aParamBox ,{6,"Arquivo Importação",cCaminho,"@!",,'.T.',80,.T.,"Arquivos .xlsx |*.csv " })
	
	If ParamBox(aParamBox,"Parâmetros Exportar / Importar...",@aRet)
	
		//Exportar 1
		If aRet[1] == 1
			Processa({|lFim| XARQEXP1(@lFim)},"Processamento","Aguarde a finalização do processamento...")
		ElseIf aRet[1] ==2
			Processa({|lFim| XARQIMP1(@lFim)},"Processamento","Aguarde a finalização do processamento...")
		EndIf
	Endif

Return

Static Function XARQEXP1()

	Local cQuery
	
	cQuery := "SELECT ZCC_FILIAL,ZCC_COD,ZCC_LOCAL,ZCC_QTDE1,ZCC_QTDE2,'N' EXCLUIR  FROM "+RETSQLNAME("ZCC")+" WHERE D_E_L_E_T_ != '*'"

	U_QRYCSV(cQuery)

Return

Static Function XARQIMP1(nGet1)

Local cFile  		:= Alltrim(MV_PAR02)
Local cLinha  := ""
Local lPrim   := .T.
Local aCampos := {}
Local aDados  := {}
 
Private _nProcSuce	:= 0
Private _nProcFalh	:= 0
Private _aStruLog   := {}
Private _cLog 		:= ""
Private _nRegLin    := 0
Private _aCelulas   := {}
Private oModel      := Nil
Private lMsErroAuto := .F.
Private aRotina    := {}
 
	If !File( cFile )
	MsgStop("Aquivo " + cFile + " não foi encontrado. A importação será abortada!","ATENCAO")
		Return
	EndIf
	
	FT_FUSE(cFile)
	ProcRegua(FT_FLASTREC())
	FT_FGOTOP()

	// Extrai os Dados das Celulas Cabeï¿½alho pedido
	While !FT_FEOF()
 
		IncProc("Lendo arquivo texto...")
 
		cLinha := FT_FREADLN()
	 
		If lPrim
			aCampos := Separa(cLinha,";",.T.)
			lPrim := .F.
		Else
			AADD(aDados,Separa(cLinha,";",.T.))
		EndIf
	 
		FT_FSKIP()
	EndDo
	
	
	Begin Transaction
	ProcRegua(Len(aDados))
		For i:=1 to Len(aDados)
	 
			IncProc("Gravando registros Transferencias...")
			
			ZCC->(dbSelectArea("ZCC"))
			ZCC->(dbSetOrder(1)) //ZCC_FILIAL, ZCC_COD, ZCC_LOCAL
			
			If ZCC->(dbSeek( Alltrim(aDados[i][1] ) + PADR( aDados[i][2], TAMSX3("B1_COD")[1] ) + Alltrim( aDados[i][3] ) ))
			 					
			 	If Alltrim( aDados[i][6] ) == "S"
					ZCC->( Reclock("ZCC", .F.) )
						dbDelete()
					ZCC->( MsUnlock('ZCC') )
				Else
					ZCC->( Reclock("ZCC", .F.) )
						ZCC->ZCC_QTDE1 := Val(aDados[i][4]) 
						ZCC->ZCC_QTDE2 := Val(aDados[i][5]) 
					ZCC->( MsUnlock('ZCC') )
				EndIf
				
			Else
				ZCC->( Reclock("ZCC", .T.) )
					ZCC->ZCC_FILIAL	:= Alltrim(aDados[i][1])
					ZCC->ZCC_COD 	:= Alltrim(aDados[i][2])
					ZCC->ZCC_LOCAL 	:= Alltrim(aDados[i][3])
					ZCC->ZCC_QTDE1 	:= Val(aDados[i][4]) 
					ZCC->ZCC_QTDE2 	:= Val(aDados[i][5])
					
					SB1->(dbSelectArea("SB1"))
					SB1->(dbSetOrder(1))
					If SB1->(dbSeek( xFilial("SB1") + PADR( aDados[i][2], TAMSX3("B1_COD")[1] ) ))
						ZCC->ZCC_DESC := SB1->B1_DESC
					EndIf
					
					NNR->(dbSelectArea("NNR"))
					NNR->(dbSetOrder(1))
					If NNR->(dbSeek( Alltrim(aDados[i][1]) + Alltrim(aDados[i][3]) ))
						ZCC->ZCC_DESCLO := NNR->NNR_DESCRI
					EndIf
					 
				ZCC->( MsUnlock('ZCC') )
			EndIf				
			
		Next i
	End Transaction
	
	FT_FUSE()
	
Return