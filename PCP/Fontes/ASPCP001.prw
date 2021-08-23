#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

Static cCposF := 'D3_FILIAL|D3_TM|D3_OP|D3_UM|D3_LOCAL|D3_DESCRI|'
Static cCposG := 'D3_FILIAL|D3_OP|D3_UM|D3_LOCAL|D3_DESCRI|'

/*/{Protheus.doc} ASPCP001
Rotina para geração do apontamento customizado de produção

@Author Wanderley Ramos Neto
@Since 16/05/2017
@Menu PCP\Atualizações\Movimentos\Produção\Apontamento Bacio
	/*/
User Function ASPCP001()
/*
Local oBrowse		:= Nil

Private aRotina		:= MenuDef()

dbSelectArea('SD3')
SD3->(DBSetOrder(1))

// Instancia Browse
oBrowse:= FWMBrowse():New()
oBrowse:SetAlias("SD3")
oBrowse:SetDescription("Apontamento de Produção - Bacio") 

oBrowse:Activate()
*/

FwExecView('Apontamento Produção - Bacio','ASPCP001',MODEL_OPERATION_INSERT)

Return 

/*/{Protheus.doc} MenuDef
Define menu da rotina

@Author Wanderley Ramos Neto
@Since 16/05/2017
@Return aRotina
/*/
Static Function MenuDef()

Local aRotina		:= {}

ADD OPTION aRotina Title 'Visualizar'	Action 'VIEWDEF.ASPCP001' OPERATION 2 ACCESS 0
ADD OPTION aRotina Title 'Incluir'		Action 'VIEWDEF.ASPCP001' OPERATION 3 ACCESS 0
//ADD OPTION aRotina Title 'Alterar'		Action 'VIEWDEF.ASPCP001' OPERATION 4 ACCESS 0
//ADD OPTION aRotina Title 'Excluir'		Action 'VIEWDEF.ASPCP001' OPERATION 5 ACCESS 0

Return aRotina

/*/{Protheus.doc} ModelDef
Definição do modelo de dados

@Author Wanderley Ramos Neto
@Since 16/05/2017
@Return oModel
/*/
Static Function ModelDef()

Local oModel			:= Nil
Local aRelacSD3			:= {}
Local bCommit			:= {|oModel| aComMd(oModel)}

// Estruturas
Local oStruSD3F			:= FwFormStruct(1, "SD3",{|cCpo| AllTrim(cCpo) $ cCposF })
Local oStruSD3G			:= FwFormStruct(1, "SD3",{|cCpo| AllTrim(cCpo) $ cCposG })

// Adiciona campos especificos
AddCampos(oStruSD3F,.T.,.F.)
AddCampos(oStruSD3G,.T.,.T.)

// Alterando Validações dos campos
oStruSD3F:SetProperty('D3_TM',		MODEL_FIELD_VALID, FwBuildFeature( STRUCT_FEATURE_VALID,"u_aVldCpo()" ))
oStruSD3F:SetProperty('D3_LOCAL',	MODEL_FIELD_VALID, FwBuildFeature( STRUCT_FEATURE_VALID,".T." ))
oStruSD3F:SetProperty('D3_OP',		MODEL_FIELD_VALID, FwBuildFeature( STRUCT_FEATURE_VALID,"u_CarrOPGr()" ))
oStruSD3G:SetProperty('D3_LOCAL',	MODEL_FIELD_VALID, FwBuildFeature( STRUCT_FEATURE_VALID,".T." ))
oStruSD3G:SetProperty('D3_OP',		MODEL_FIELD_VALID, FwBuildFeature( STRUCT_FEATURE_VALID,".T." ))

// Alterando Inicializador Padrao
oStruSD3F:SetProperty('D3_DESCRI',	MODEL_FIELD_INIT, FwBuildFeature( STRUCT_FEATURE_INIPAD,"''" ))
oStruSD3G:SetProperty('D3_DESCRI',	MODEL_FIELD_INIT, FwBuildFeature( STRUCT_FEATURE_INIPAD,"''" ))

// Alterando Gatilho
oStruSD3F:AddTrigger( 'D3_OP', 'PRODBD',,;
				{ |oModel| Posicione("SC2",1,xFilial("SC2") + oModel:GetValue('D3_OP'),"C2_PRODUTO") } )								 
oStruSD3F:AddTrigger( 'D3_OP', 'QUANTBD',,;
				{ |oModel| Posicione("SC2",1,xFilial("SC2") + oModel:GetValue('D3_OP'),"C2_QUANT") } )
oStruSD3F:AddTrigger( 'D3_OP', 'PERDABD',,;
				{ |oModel| Posicione("SC2",1,xFilial("SC2") + oModel:GetValue('D3_OP'),"C2_PERDA") } )
oStruSD3F:AddTrigger( 'D3_OP', 'D3_LOCAL',,;
				{ |oModel| Posicione("SC2",1,xFilial("SC2") + oModel:GetValue('D3_OP'),"C2_LOCAL") } )
				
oStruSD3G:AddTrigger( 'D3_OP', 'PRODKG',,;
				{ |oModel| Posicione("SC2",1,xFilial("SC2") + oModel:GetValue('D3_OP'),"C2_PRODUTO") } )								 
oStruSD3G:AddTrigger( 'D3_OP', 'QUANTKG',,;
				{ |oModel| Posicione("SC2",1,xFilial("SC2") + oModel:GetValue('D3_OP'),"C2_QUANT") } )
oStruSD3G:AddTrigger( 'D3_OP', 'PERDAKG',,;
				{ |oModel| Posicione("SC2",1,xFilial("SC2") + oModel:GetValue('D3_OP'),"C2_PERDA") } )
oStruSD3G:AddTrigger( 'D3_OP', 'D3_LOCAL',,;
				{ |oModel| Posicione("SC2",1,xFilial("SC2") + oModel:GetValue('D3_OP'),"C2_LOCAL") } )

												
// Instanciando modelo
oModel := MPFormModel():New("MODEL_ASPCP001",  /*bPreMd*/ , /*bPosMd*/ , bCommit,/*bCancel*/ )
oModel:SetDescription("Apontamento de Produção - Bacio")


// Adicionando componentes ao modelo
oModel:AddFields("MdFieldSD3",,oStruSD3F )
oModel:GetModel("MdFieldSD3"):SetDescription('Produtos Balde')

// Adicionando componente de grid
oModel:AddGrid('MdGridSD3','MdFieldSD3',oStruSD3G)

AAdd( aRelacSD3, { "D3_FILIAL"			, "xFilial('SD3')"} )
AAdd( aRelacSD3, { SubStr("D3_OP",1,6)	, SubStr("D3_OP",1,6)} )
//AAdd( aRelacSD3, { "D3_TM"		, "D3_TM"} )

oModel:SetRelation( "MdGridSD3", aRelacSD3, SD3->( IndexKey(1) ) )
	oModel:GetModel('MdGridSD3'):SetDescription('Produtos KG')
	oModel:GetModel('MdGridSD3'):SetOptional(.F.)
	oModel:GetModel('MdGridSD3'):SetUniqueLine({'D3_OP','PRODKG'})

oModel:SetPrimaryKey({"D3_TM",'D3_OP','PRODBD','PRODKG'})


Return oModel

/*/{Protheus.doc} ViewDef
Definição da tela

@Author Wanderley Ramos Neto
@Since 16/05/2017
@Return oView
/*/
Static Function ViewDef()

Local oModel		:= FWLoadModel("ASPCP001")
Local oView			:= FwFormView():New()

//Estruturas
Local oStruSD3F		:= FWFormStruct(2, 'SD3',{|cCpo| AllTrim(cCpo) $ cCposF })
Local oStruSD3G		:= FWFormStruct(2, 'SD3',{|cCpo| AllTrim(cCpo) $ cCposG })
Local nCpo			:= 0	

// Adiciona campos especificos
AddCampos(oStruSD3F,.F.,.F.)
AddCampos(oStruSD3G,.F.,.T.)

oStruSD3F:RemoveField('D3_FILIAL')
oStruSD3G:RemoveField('D3_FILIAL')

oView:SetModel(oModel)

// Adicionando Componentes
oView:AddField('VwFieldSD3', oStruSD3F, 'MdFieldSD3')
oView:AddGrid('VwGridSD3', oStruSD3G,'MdGridSD3')

// Montando estrutura de visualização
oView:CreateVerticallBox("MAIN",100)
	oView:CreateHorizontalBox("BOX_FIELD",30,"MAIN")
	oView:CreateHorizontalBox("BOX_GRID",70,"MAIN")

// Associando componentes às estruturas de visualização
oView:SetOwnerView('VwFieldSD3', 'BOX_FIELD')
oView:SetOwnerView('VwGridSD3', 'BOX_GRID')

// -----------------------------------------------------------------------
// Habilitando descrição dos componentens
// -----------------------------------------------------------------------
oView:EnableTitleView("VwFieldSD3")
oView:EnableTitleView("VwGridSD3")


Return oView

/*/{Protheus.doc} AddCampos
Adiciona os campos especificos na rotina

@Author Wanderley Ramos Neto
@Since 16/05/2017
@Return oStru Estrutura carregada com os novos campos
/*/
Static Function AddCampos(oStru,lModel, lGrid)

Local cSulfix		:= iif(lGrid,'KG','BD')

If lModel

	oStru:AddField('Prod '+cSulfix	,'Prod '+cSulfix	,'PROD'+cSulfix		,'C',TamSX3('B1_COD')[1]	,0,,,,,,,,.T.)
//	oStru:AddField('Desc '+cSulfix	,'Desc '+cSulfix	,'Desc'+cSulfix		,'C',TamSX3('B1_DESC')[1]	,0,,,,,,,,.T.)
	oStru:AddField('Qtd '+cSulfix	,'Qtd '+cSulfix		,'QUANT'+cSulfix	,'N',TamSX3('D3_QUANT')[1]	,TamSX3('D3_QUANT')[2],,,,,,,,.T.)
	oStru:AddField('Perda '+cSulfix	,'Perda '+cSulfix	,'PERDA'+cSulfix	,'N',TamSX3('D3_PERDA')[1]	,TamSX3('D3_PERDA')[2],,,,,,,,.T.)

	// Adiciona validação no campo de Produto
	oStru:SetProperty('PROD'+cSulfix, MODEL_FIELD_VALID, FwBuildFeature( STRUCT_FEATURE_VALID,"u_aVldCpo()" ))
	
	// Adiciona gatilho na estrutura
	oStru:AddTrigger( 'PROD'+cSulfix, 'D3_DESCRI',,;
						{ |oModel| Posicione("SB1",1,xFilial("SB1") + oModel:GetValue('PROD'+cSulfix),"B1_DESC") } )

	oStru:AddTrigger( 'PROD'+cSulfix, 'D3_LOCAL',,;
						{ |oModel| Posicione("SB1",1,xFilial("SB1") + oModel:GetValue('PROD'+cSulfix),"B1_LOCPAD") } )

	oStru:AddTrigger( 'PROD'+cSulfix, 'D3_UM',,;
						{ |oModel| Posicione("SB1",1,xFilial("SB1") + oModel:GetValue('PROD'+cSulfix),"B1_UM") } )								 

Else

	oStru:AddField('PROD'+cSulfix	,'01','Prod '+cSulfix	,'Prod '+cSulfix	,, 'C','@!'				,,'SB1'	,.T.,,,,,,.T.)
//	oStru:AddField('Desc'+cSulfix	,'5','Desc '+cSulfix	,'Desc '+cSulfix	,, 'C','@!'				,,		,.T.,,,,,,.T.)
	oStru:AddField('QUANT'+cSulfix	,'6','Quant '+cSulfix	,'Quant '+cSulfix	,, 'C','@E 99999999.99'	,,		,.T.,,,,,,.T.)
	oStru:AddField('PERDA'+cSulfix	,'7','Perda '+cSulfix	,'Perda '+cSulfix	,, 'C','@E 99999999.99'	,,		,.T.,,,,,,.T.)
	
EndIf

Return oStru

/*/{Protheus.doc} bVldProd
Valida

@Author Wanderley Ramos Neto
@Since 16/05/2017
@Return Retorno
/*/
User Function aVldCpo()

Local oModel			:= FWModelActive()
Local cCpo				:= ReadVar()
Local lValid			:= .F.
Local cUMValid			:= ''

If cCpo == 'M->D3_TM'
	
//	lValid := ExistCpo('SF5',oModel:Getmodel('MdFieldSD3'):GetValue('D3_TM'), 1)
	lValid := ExistCpo('SF5',&(cCpo), 1)
	If !lValid
		Help(,,'VLDCPO',, "Tipo de movimentação inválida.",1)
	EndIf
	
ElseIf 'M->PROD' $ Upper(cCpo)

	lValid := ExistCpo('SB1',&(cCpo), 1)
	If !lValid
		Help(,,'VLDCPO',, "Produto inválido.",1)
	EndIf
	
	cUMValid := SubStr(Upper(cCpo),8,2)

	lValid := (Posicione('SB1',1,xFilial('SB1')+&(cCpo),'B1_UM') == cUMValid)
	If !lValid
		
		Help(,,'VLDCPO',, "Unidade de medida inválida. O produto deve ser apontado em "+iif(cUMValid=='BD','Balde','Kilos')+".",1)
		
	EndIf
			
EndIf

Return lValid

/*/{Protheus.doc} aComMd
Tratamento para gravação do apontamento

@Author Wanderley Ramos Neto
@Since 17/05/2017
/*/
Static Function aComMd(oModel)

Local oMdGrid			:= oModel:GetModel('MdGridSD3')
Local oMdField			:= oModel:GetModel('MdFieldSD3')
Local cOp				:= oMdField:GetValue('D3_OP')
Local cTM				:= oMdField:GetValue('D3_TM')
Local cProdBD			:= oMdField:GetValue('PRODBD')
Local cArmBD			:= oMdField:GetValue('D3_LOCAL')
Local nQuantBD			:= oMdField:GetValue('QUANTBD')
Local nPerdaBD			:= oMdField:GetValue('PERDABD')
Local cProdKG			:= ''
Local cArmazem			:= ''
Local cOpKG				:= ''
Local nQuant			:= 0
Local nPerda			:= 0
Local nQtdOP			:= 0
Local nQtdOPKg			:= 0
Local nLinha			:= 0
Local lContinua			:= .T.

Begin Transaction

For nLinha := 1 To oMdGrid:Length()
	
	If lContinua
		// Posiciona na linha
		oMdGrid:GoLine(nLinha)
		
		
		If ! oMdGrid:IsDeleted()

			cProdKG	:= oMdGrid:GetValue('PRODKG')
			cArmazem:= oMdGrid:GetValue('D3_LOCAL')
			cOpKG	:= oMdGrid:GetValue('D3_OP')
			nQuant	:= oMdGrid:GetValue('QUANTKG')
			nPerda	:= oMdGrid:GetValue('PERDAKG')

			nQtdOPKg :=  Posicione('SC2',1,xFilial('SC2')+cOpKg,'C2_QUANT')
			// ---------------------------------------------------------------------
			// Gera Produção dos Produtos Kg
			// ---------------------------------------------------------------------
			lContinua := GeraProd(  cTM,;
									cProdKG,;
									cArmazem,;
									cOpKG,;
									nQuant,;
									nPerda,;
									0,;
									iif(nQuant < nQtdOPKg .And. nPerda == 0,'P','T'))
			
			// ---------------------------------------------------------------------
			// Exclui Empenho do saldo de produtos KG
			// ---------------------------------------------------------------------
			If lContinua

					lContinua := AjuEmpKg(cProdKG,;
										  cArmazem,;
										  cOp)
					
			Else
				
				// Log de processamento indicando a falha na Produção do Prod Kg.
				Help(,,'COMMD',, "Falha na produção do componente.",nLinha)
				DisarmTransaction()
				
				
			EndIf
			
			
			// ---------------------------------------------------------------------
			// Gera Req Manual dos produtos KG
			// ---------------------------------------------------------------------
			If lContinua

				lContinua := GerReqKg(cProdKG,;
									  cArmazem,;
									  cOp,;
									  nQuant)
		  
				If !lContinua
					// Log de processamento indicando a falha na Requsição do Prod Kg.
					Help(,,'COMMD',, "Falha na requisição do componente.",nLinha)
					DisarmTransaction()
				EndIf
				
			Else
				// Log de processamento indicando a falha no ajuste de empenho do Prod Kg.
				Help(,,'COMMD',, "Falha na exclusão do ajuste de empenho do componente.",nLinha)
				DisarmTransaction()
			EndIf
		EndIf
	Else
	
		// Se houver falha no processamento de qualquer PI, sai da rotina
		Exit
	
	EndIf
Next nLinha

If lContinua
	
	nQtdOP := Posicione('SC2',1,xFilial('SC2')+cOp,'C2_QUANT')
	
	// ---------------------------------------------------------------------
	// Gera Produção do Produto BALDE.
	// ---------------------------------------------------------------------
	lContinua := GeraProd(  cTM,;
							cProdBD,;
							cArmBD,;
							cOp,;
							nQuantBD,;
							nPerdaBD,;
							max(nQuantBD-nQtdOP,0),;
							iif(nQuantBD<nQtdOP .And. nPerdaBD==0,'P','T'))
				
	If !lContinua
//		MsgAlert('Rotina concluída com sucesso!')
//	Else
		Help(,,'COMMD',, "Falha na produção do PA.",1)
		DisarmTransaction()
	EndIf
	
EndIf

End Transaction

Return .T.


/*/{Protheus.doc} GeraProd
Gera as Produções baseadas na grid do apontamento

@Author Wanderley Ramos Neto
@Since 17/05/2017
/*/
Static Function GeraProd(cTM, cCodProd, cArmazem, cOP, nQuant, nPerda,nQtMaior, cParTot)

Local lSucess			:= .F.
Local cCCProd			:= SuperGetMV('AS_CCPROD',,'800002')


// ------------------------------------------------------------------------------
// Gera registro de saldo no SB2
// ------------------------------------------------------------------------------
CriaSB2(cCodProd, cArmazem)

oFabr 	:= uProducao():New()

	//oFabr:AddValues("D3_FILIAL"		, xFilial("SD3"))
	oFabr:AddValues("D3_TM"			,cTM)
	oFabr:AddValues("D3_OP"			,cOp)
	oFabr:AddValues("D3_COD"		,cCodProd)
	oFabr:AddValues("D3_QUANT"		,nQuant)
	oFabr:AddValues("D3_QTMAIOR"	,nQtMaior)
	oFabr:AddValues("D3_PERDA"		,nPerda)
	oFabr:AddValues("D3_CC"			,cCCProd) 
	oFabr:AddValues("D3_EMISSAO"	,dDataBase )
	oFabr:AddValues("D3_PARCTOT"	,cParTot)
	
	oFabr:aValues := FWVetByDic( oFabr:aValues, 'SD3' )

lSucess := oFabr:Gravacao(3)
oFabr := Nil

Return lSucess

/*/{Protheus.doc} GerReq
Gera as requisiçies baseadas na grid do apontamento

@Author Wanderley Ramos Neto
@Since 17/05/2017
@Param Param Param_Descricao
@Return Retorno
/*/
Static Function GerReqKg(cCodProd, cArmazem, cOP, nQuant)

Local cTMReq			:= SuperGetMv('AS_TMREQ',,'501')
Local cCCProd			:= SuperGetMV('AS_CCPROD',,'800002')
Local lSucess			:= .F.

oReqs 	:= uMovInterno():New()

	oReqs:AddValues("D3_EMISSAO"	, dDataBase)
	oReqs:AddValues("D3_CC"			, cCCProd) 
	oReqs:AddValues("D3_TM"			, cTMReq)
	oReqs:AddValues("D3_COD"		, cCodProd)
	oReqs:AddValues("D3_LOCAL"		, cArmazem)
	oReqs:AddValues("D3_QUANT"		, nQuant)
	oReqs:AddValues("D3_PARCTOT"	, 'T')
	oReqs:AddValues("D3_OP"			, cOP)
	
	oReqs:aValues := FWVetByDic( oReqs:aValues, 'SD3' )

lSucess := oReqs:Gravacao(3)
oReqs := NIL

Return lSucess


/*/{Protheus.doc} AjuEmpKg
Zera o empenho restante dos componentes do grid do apontamento após a produção dos mesmos.

@Author Wanderley Ramos Neto
@Since 17/05/2017
/*/
Static Function AjuEmpKg(cCodProd, cArmazem, cOP)

Local lSucess			:= .T.
Local cFilSD4			:= xFilial('SD4')
Local aAreas			:= {SD4->(GetArea()),GetArea()}
Local aVetor			:= {}

Private lMsErroAuto		:= .F.

dbSelectArea('SD4')

aVetor :={  {"D4_COD"     , cCodProd		,Nil},; 
            {"D4_LOCAL"   , cArmazem	    ,Nil},;
            {"D4_OP"      , cOP				,Nil}}
//            {"D4_DATA"    , dDatabase      	,Nil}}
//            {"ZERAEMP"	  , "S"				,NIL}}
//            {"D4_QUANT"   , 0		        ,Nil},;


MSExecAuto({|x,y| mata380(x,y)},aVetor,5) 
 
If lMsErroAuto
	lSucess := .F.
    MostraErro()
EndIf


AEval(aAreas, {|x| RestArea(x) })

Return lSucess

/*/{Protheus.doc} CarrOPGr
Verifica se OP é valida e carrega grid automaticamente com as OP's filhas validas

@Author Wanderley Ramos Neto
@Since 19/05/2017
@Return Retorna se OP é valida.
/*/
User Function CarrOPGr()

Local oModel			:= FWModelActive()
Local oMdField			:= oModel:GetModel('MdFieldSD3')
Local oMdGrid			:= oModel:GetModel('MdGridSD3')
Local cCpo				:= ReadVar()
Local cFilSC2			:= xFilial('SC2')
Local cFilSB1			:= xFilial('SB1')
Local nLin				:= 0
Local lValid			:= .F.
Local lPrimLinha		:= .T.

// ---------------------------------------------------------------------
// Valida se OP existe
// ---------------------------------------------------------------------
lValid := ExistCpo('SC2',&(cCpo), 1)
If !lValid
	Help(,,'CARROPGR',, "OP inválida.",1)
EndIf

If lValid
	
	oMdGrid:GoLine(1)
	
	dbSelectArea('SC2')
	SC2->(dbSetOrdeR(1))
	
	If SC2->( dbSeek( cFilSC2 + &(cCpo) ) )
	
		While  SC2->(!Eof());
				.And. SC2->C2_NUM == SubStr(&(cCpo) ,1,6)
			
			// ---------------------------------------------------------------------
			// Carrega a grid com as OP's filhas cujo produto seja apontado em Kg.
			// ---------------------------------------------------------------------
			If SC2->C2_UM == 'KG' ;	// Unidde de Medida tem que ser Kg
					.And. Posicione('SB1',1,cFilSB1+SC2->C2_PRODUTO,'B1_XKGOP')=='K' // Controle no produto se vai ser apontado ou não
					
				If !lPrimLinha
					oMdGrid:AddLine()
				EndIf
				
				oMdGrid:SetValue('D3_OP', SC2->( C2_NUM+C2_ITEM+C2_SEQUEN ))
				
				// Recupera linha caso esteja deletada
				If oMdGrid:IsDeleted()
					oMdGrid:UnDeleteLine()
				EndIf
				
				lPrimLinha := .F.
			EndIf
			
			SC2->(dbSkip())
		End
	
	EndIf
	
	// Se não encontrou nenhum registro, exclui as linhas da grid
	If lPrimLinha	
		oMdGrid:DelAllLine()
	EndIf
	
EndIf

Return lValid