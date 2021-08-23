//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'
#INCLUDE "FWMVCDEF.CH"
//Variáveis Estáticas
Static cTitulo := "Consulta de Contagem"

//********************************************************************************************************************

//********************************************************************************************************************

User Function bdlinv4()
	Local aArea   := GetArea()
	Local oBrowse
	Local cFunBkp := FunName()
	Local aLeg := {}
	Private dDtInv := GetMV('BDIL_DTINV',.t.,"")
	Private cAlias := ""

	SetFunName("bdlinv4")

	aLeg := aClone(U_fBwLeg(.f.))

	//Cria um browse para a SX5, filtrando somente a tabela 00 (cabeçalho das tabelas
	oBrowse := FWMBrowse():New()
	oBrowse:SetAlias("ZZ5")
	oBrowse:SetDescription(cTitulo)
	oBrowse:SetFilterDefault("ZZ5->ZZ5_DATA == '" + DtoS(dDtInv) + "' ")

	For nX := 1 to len(aLeg)
		oBrowse:AddLegend( aLeg[nX,1], aLeg[nX,2],aLeg[nX,3] )
	Next nX

	oBrowse:Activate()

	SetFunName(cFunBkp)
	RestArea(aArea)

Return Nil

/*---------------------------------------------------------------------*
 | Func:  MenuDef                                                      |
 | Autor:                                                              |
 | Data:  14/01/2017                                                   |
 | Desc:  Criação do menu MVC                                          |
 *---------------------------------------------------------------------*/

Static Function MenuDef()
Local aRot := {}

	//aadd(aRot,{'Incluir'   ,'VIEWDEF.bdlinv4',0,MODEL_OPERATION_INSERT,0,nil,nil,nil})
	//aadd(aRot,{'Alterar'   ,'VIEWDEF.bdlinv4',0,MODEL_OPERATION_UPDATE,0,nil,nil,nil})
	//aadd(aRot,{'Excluir'   ,'VIEWDEF.bdlinv4',0,MODEL_OPERATION_DELETE,0,nil,nil,nil})
	aadd(aRot,{'Visualizar','VIEWDEF.bdlinv4',0,MODEL_OPERATION_VIEW  ,0,nil,nil,nil})
	aadd(aRot,{'Legenda'   ,'U_fBwLeg()'     ,0,9                     ,0,nil,nil,nil})

Return aRot
//********************************************************************************************************************
/*---------------------------------------------------------------------*
 | Func:  ModelDef                                                     |
 | Autor:                                                              |
 | Data:  14/01/2021                                                   |
 | Desc:  Criação do modelo de dados MVC                               |
 *---------------------------------------------------------------------*/
//********************************************************************************************************************

Static Function ModelDef()
Local oStTmp   := FWFormModelStruct():New()
Local oStFilho := FWFormStruct(1, 'ZZ5')
Local bVldPos  := {|| u_VldX5Tab()}
//Local bVldCom  := {|| u_SaveMd2()}
Local aSX5Rel  := {}
Local aAux := {}
Private oModel   := Nil

	//Adiciona a tabela na estrutura temporária
	oStTmp:AddTable('ZZ5', {/*'ZZ5_FILIAL',*/ 'ZZ5_DOC','ZZ5_LOCAL'}, "Cabecalho ZZ5")
	
	//Adiciona o campo de Filial
	oStTmp:AddField(;
					"Filial",;                                                                                  // [01]  C   Titulo do campo
					"Filial",;                                                                                  // [02]  C   ToolTip do campo
					"ZZ5_FILIAL",;                                                                              // [03]  C   Id do Field
					"C",;                                                                                       // [04]  C   Tipo do campo
					TamSX3("ZZ5_FILIAL")[1],;                                                                   // [05]  N   Tamanho do campo
					0,;                                                                                         // [06]  N   Decimal do campo
					Nil,;                                                                                       // [07]  B   Code-block de validação do campo
					Nil,;                                                                                       // [08]  B   Code-block de validação When do campo
					{},;                                                                                        // [09]  A   Lista de valores permitido do campo
					.F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigatório
					FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,ZZ5->ZZ5_FILIAL,FWxFilial('ZZ5'))" ),;  // [11]  B   Code-block de inicializacao do campo
					.T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
					.F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma operação de update.
					.F.)                                                                                        // [14]  L   Indica se o campo é virtual
	
	//Adiciona o campo de Código da Tabela
	oStTmp:AddField(;
					"Documento",;                                                                  // [01]  C   Titulo do campo
					"Documento",;                                                                  // [02]  C   ToolTip do campo
					"ZZ5_DOC",;                                                                    // [03]  C   Id do Field
					"C",;                                                                          // [04]  C   Tipo do campo
					TamSX3("ZZ5_DOC")[1],;                                                         // [05]  N   Tamanho do campo
					0,;                                                                            // [06]  N   Decimal do campo
					Nil,;                                                                          // [07]  B   Code-block de validação do campo
					Nil,;                                                                          // [08]  B   Code-block de validação When do campo
					{},;                                                                           // [09]  A   Lista de valores permitido do campo
					.T.,;                                                                          // [10]  L   Indica se o campo tem preenchimento obrigatório
					FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,ZZ5->ZZ5_DOC,'')" ),;      // [11]  B   Code-block de inicializacao do campo
					.T.,;                                                                          // [12]  L   Indica se trata-se de um campo chave
					.F.,;                                                                          // [13]  L   Indica se o campo pode receber valor em uma operação de update.
					.F.)                                                                           // [14]  L   Indica se o campo é virtual
	
	//Adiciona o campo de Código da Tabela
	oStTmp:AddField(;
					"Armazem",;                                                                   // [01]  C   Titulo do campo
					"Documento",;                                                                 // [02]  C   ToolTip do campo
					"ZZ5_LOCAL",;                                                                 // [03]  C   Id do Field
					"C",;                                                                         // [04]  C   Tipo do campo
					TamSX3("ZZ5_LOCAL")[1],;                                                      // [05]  N   Tamanho do campo
					0,;                                                                           // [06]  N   Decimal do campo
					Nil,;                                                                         // [07]  B   Code-block de validação do campo
					Nil,;                                                                         // [08]  B   Code-block de validação When do campo
					{},;                                                                          // [09]  A   Lista de valores permitido do campo
					.T.,;                                                                         // [10]  L   Indica se o campo tem preenchimento obrigatório
					FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,ZZ5->ZZ5_LOCAL,'')" ),;   // [11]  B   Code-block de inicializacao do campo
					.T.,;                                                                         // [12]  L   Indica se trata-se de um campo chave
					.F.,;                                                                         // [13]  L   Indica se o campo pode receber valor em uma operação de update.
					.F.)                                                                          // [14]  L   Indica se o campo é virtual
	
	//Adiciona o campo de Descrição
	oStTmp:AddField(;
					"Data",;                                                                     // [01]  C   Titulo do campo
					"Data",;                                                                     // [02]  C   ToolTip do campo
					"ZZ5_DATA",;                                                                 // [03]  C   Id do Field
					"D",;                                                                        // [04]  C   Tipo do campo
					TamSX3("ZZ5_DATA")[1],;                                                      // [05]  N   Tamanho do campo
					0,;                                                                          // [06]  N   Decimal do campo
					Nil,;                                                                        // [07]  B   Code-block de validação do campo
					Nil,;                                                                        // [08]  B   Code-block de validação When do campo
					{},;                                                                         // [09]  A   Lista de valores permitido do campo
					.T.,;                                                                        // [10]  L   Indica se o campo tem preenchimento obrigatório
					FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,ZZ5_DATA,'')" ),;        // [11]  B   Code-block de inicializacao do campo
					.F.,;                                                                        // [12]  L   Indica se trata-se de um campo chave
					.F.,;                                                                        // [13]  L   Indica se o campo pode receber valor em uma operação de update.
					.F.)                                                                         // [14]  L   Indica se o campo é virtual

	oStFilho:AddField( ;
                    AllTrim('') , ;             // [01] C Titulo do campo
                    AllTrim('') , ;             // [02] C ToolTip do campo
                    'ZZ5_STATUS1' , ;           // [03] C identificador (ID) do Field
                    'C' , ;                     // [04] C Tipo do campo
                    50 , ;                      // [05] N Tamanho do campo
                    0 , ;                       // [06] N Decimal do campo
                    NIL , ;                     // [07] B Code-block de validação do campo
                    NIL , ;                     // [08] B Code-block de validação When do campo
                    NIL , ;                     // [09] A Lista de valores permitido do campo
                    NIL , ;                     // [10] L Indica se o campo tem preenchimento obrigatório
                    {||U_fTLeg() } , ;  // [11] B Code-block de inicializacao do campo
                    NIL , ;                     // [12] L Indica se trata de um campo chave
                    NIL , ;                     // [13] L Indica se o campo pode receber valor em uma operação de update.
                    .T. )                      // [14] L Indica se o campo é virtual
	
	oStFilho:AddField( ;
                    AllTrim('Filial') , ;             // [01] C Titulo do campo
                    AllTrim('Filial') , ;             // [02] C ToolTip do campo
                    'ZZ5_FILOR' , ;           // [03] C identificador (ID) do Field
                    'C' , ;                     // [04] C Tipo do campo
                    04 , ;                      // [05] N Tamanho do campo
                    0 , ;                       // [06] N Decimal do campo
                    NIL , ;                     // [07] B Code-block de validação do campo
                    NIL , ;                     // [08] B Code-block de validação When do campo
                    NIL , ;                     // [09] A Lista de valores permitido do campo
                    NIL , ;                     // [10] L Indica se o campo tem preenchimento obrigatório
                    FwBuildFeature( STRUCT_FEATURE_INIPAD, "Iif(!INCLUI,ZZ5->ZZ5_FILIAL,FWxFilial('ZZ5'))" ),;  // [11] B Code-block de inicializacao do campo
                    NIL , ;                     // [12] L Indica se trata de um campo chave
                    NIL , ;                     // [13] L Indica se o campo pode receber valor em uma operação de update.
                    .T. )                      // [14] L Indica se o campo é virtual

	//Setando as propriedades na grid, o inicializador da Filial e Tabela, para não dar mensagem de coluna vazia
	oStFilho:SetProperty('ZZ5_FILIAL', MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"'))
	oStFilho:SetProperty('ZZ5_DOC'   , MODEL_FIELD_INIT, FwBuildFeature(STRUCT_FEATURE_INIPAD, '"*"'))
	//oStFilho:SetProperty("ZZ5_LOCAL" , "MODEL_FIELD_WHEN", {|| .F.})
    oStFilho:SetProperty("ZZ5_COD"   , MODEL_FIELD_WHEN, {|| .F.})
	oStFilho:SetProperty("ZZ5_DESCR" , MODEL_FIELD_WHEN, {|| .F.})
	/*oStFilho:SetProperty("ZZ5_UM11"  , MODEL_FIELD_WHEN, {|| .F.})
	oStFilho:SetProperty("ZZ5_UM12"  , MODEL_FIELD_WHEN, {|| .F.})
	oStFilho:SetProperty("ZZ5_QTD11" , MODEL_FIELD_WHEN, {|| .F.})
	oStFilho:SetProperty("ZZ5_QTD21" , MODEL_FIELD_WHEN, {|| .F.})
	oStFilho:SetProperty("ZZ5_UM21"  , MODEL_FIELD_WHEN, {|| .F.})
	oStFilho:SetProperty("ZZ5_UM22"  , MODEL_FIELD_WHEN, {|| .F.})
	oStFilho:SetProperty("ZZ5_UM13"  , MODEL_FIELD_WHEN, {|| .F.})
	oStFilho:SetProperty("ZZ5_UM23"  , MODEL_FIELD_WHEN, {|| .F.})
	oStFilho:SetProperty("ZZ5_UM14"  , MODEL_FIELD_WHEN, {|| .F.})
	oStFilho:SetProperty("ZZ5_UM24"  , MODEL_FIELD_WHEN, {|| .F.})
	
	oStFilho:SetProperty("ZZ5_LOCAL" , MODEL_FIELD_WHEN, {|| .F.})
	/*
	oStFilho:SetProperty("ZZ5_UM12"  , MODEL_FIELD_WHEN, {|| .F.})
	oStFilho:SetProperty("ZZ5_UM11"  , MODEL_FIELD_WHEN, {|| .F.})
	oStFilho:SetProperty("ZZ5_UM12"  , MODEL_FIELD_WHEN, {|| .F.})
	oStFilho:SetProperty("ZZ5_UM11"  , MODEL_FIELD_WHEN, {|| .F.})
	oStFilho:SetProperty("ZZ5_UM12"  , MODEL_FIELD_WHEN, {|| .F.})
	*/

	//oStFilho:SetProperty("ZZ5_COD"  , MVC_VIEW_ORDEM, "04")
	//oStFilho:SetProperty("ZZ5_DESCR", MVC_VIEW_ORDEM, "03")

	//Criando o FormModel, adicionando o Cabeçalho e Grid
	//oModel := MPFormModel():New('Descricao', /*bPreValidacao*/, { | oModel | fEXPMVC1V( oModel ) } , /*{ | oMdl | fEXPMVC1C( oMdl ) }*/ ,, /*bCancel*/ )
	oModel := MPFormModel():New("bdlinv4M", , bVldPos, /*bVldCom*/,,,)
	oModel:AddFields("FORMCAB",/*cOwner*/,oStTmp)
	oModel:AddGrid( 'ZZ5DETAIL','FORMCAB'   ,oStFilho, { |oGrid, nLine,cAction,cField,TT,RR,DD| fLinOK(oGrid, nLine, cAction, cField,TT,RR,DD)},{|oGrid|U_SaveMd2(oGrid)},/*bProsGrid*/)
	//oModel:AddGrid( 'ZA2DETAIL','ZA1MASTER', oStruZA2, { |oModelGrid, nLine, cAction,cField| COMP021LPRE(oModelGrid, nLine, cAction, cField) }
	//oModel:GetModel( 'ZZ5DETAIL' ):SetLoadFilter( { { 'ZZ5_STATUS', "'99'" } } )
	oModel:GetModel( 'ZZ5DETAIL' ):SetLoadFilter( , " ZZ5_COD <> '" + space(len(ZZ5->ZZ5_COD)) + "' ")

	//Adiciona o relacionamento de Filho, Pai
	aAdd(aSX5Rel, {'ZZ5_FILIAL', 'Iif(!INCLUI, ZZ5->ZZ5_FILIAL, FWxFilial("ZZ5"))'} )
	aAdd(aSX5Rel, {'ZZ5_DOC'   , 'Iif(!INCLUI, ZZ5->ZZ5_DOC   ,   "")'} )
	aAdd(aSX5Rel, {'ZZ5_LOCAL' , 'Iif(!INCLUI, ZZ5->ZZ5_LOCAL ,   "")'} )
	aAdd(aSX5Rel, {'ZZ5_DATA'  , 'Iif(!INCLUI, ZZ5->ZZ5_DATA  ,   "")'} )

	//Criando o relacionamento
	oModel:SetRelation('ZZ5DETAIL', aSX5Rel, ZZ5->(IndexKey(7)))

	//Setando o campo único da grid para não ter repetição
	//oModel:GetModel('ZZ5DETAIL'):SetUniqueLine({"ZZ5_FILIAL","ZZ5_COD","ZZ5_LOCAL","ZZ5_CLOTE","ZZ5_ENDER" })
	oModel:GetModel('ZZ5DETAIL'):SetUniqueLine({})

	//Setando outras informações do Modelo de Dados
	oModel:SetDescription("Modelo de Dados do Cadastro "+cTitulo)
	oModel:SetPrimaryKey({})
	oModel:GetModel("FORMCAB"):SetDescription("Formulário do Cadastro "+cTitulo)



Return oModel

/*---------------------------------------------------------------------*
 | Func:  ViewDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  14/01/2017                                                   |
 | Desc:  Criação da visão MVC                                         |
 *---------------------------------------------------------------------*/

Static Function ViewDef()
Local oModel     := FWLoadModel("bdlinv4")
Local oStTmp     := FWFormViewStruct():New()
Local oStFilho   := FWFormStruct(2, 'ZZ5')
Local oView      := Nil
Local aAux 	
	
	//aAux := FWStruTrigger("ZZ5_QTD11","ZZ5_QTD21","tConVer1(M->ZZ5_COD,M->ZZ5_QTD11,1)",.F.,,,) 
	//oStFilho:AddTrigger( aAux[1],aAux[2],aAux[3],aAux[4])
	
	//Adicionando o campo Chave para ser exibido
	oStTmp:AddField(;
				"ZZ5_DOC",;                	// [01]  C   Nome do Campo
				"01",;                      // [02]  C   Ordem
				"Tabela",;                  // [03]  C   Titulo do campo
				'ZZ5_DOC',;   			 	// [04]  C   Descricao do campo
				Nil,;                       // [05]  A   Array com Help
				"C",;                       // [06]  C   Tipo do campo
				"@!",;    					// [07]  C   Picture
				Nil,;                       // [08]  B   Bloco de PictTre Var
				Nil,;                       // [09]  C   Consulta F3
				Iif(INCLUI, .T., .F.),;     // [10]  L   Indica se o campo é alteravel
				Nil,;                       // [11]  C   Pasta do campo
				Nil,;                       // [12]  C   Agrupamento do campo
				Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
				Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
				Nil,;                       // [15]  C   Inicializador de Browse
				Nil,;                       // [16]  L   Indica se o campo é virtual
				Nil,;                       // [17]  C   Picture Variavel
				Nil)                        // [18]  L   Indica pulo de linha após o campo
	
	//Adicionando o campo Chave para ser exibido
	oStTmp:AddField(;
				"ZZ5_LOCAL",;                	// [01]  C   Nome do Campo
				"02",;                      // [02]  C   Ordem
				"Armazem",;                  // [03]  C   Titulo do campo
				'ZZ5_LOCAL',;   			 	// [04]  C   Descricao do campo
				Nil,;                       // [05]  A   Array com Help
				"C",;                       // [06]  C   Tipo do campo
				"@!",;    					// [07]  C   Picture
				Nil,;                       // [08]  B   Bloco de PictTre Var
				Nil,;                       // [09]  C   Consulta F3
				Iif(INCLUI, .T., .F.),;     // [10]  L   Indica se o campo é alteravel
				Nil,;                       // [11]  C   Pasta do campo
				Nil,;                       // [12]  C   Agrupamento do campo
				Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
				Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
				Nil,;                       // [15]  C   Inicializador de Browse
				Nil,;                       // [16]  L   Indica se o campo é virtual
				Nil,;                       // [17]  C   Picture Variavel
				Nil)                        // [18]  L   Indica pulo de linha após o campo


	oStTmp:AddField(;
				"ZZ5_DATA",;                // [01]  C   Nome do Campo
				"03",;                      // [02]  C   Ordem
				"Data",;                    // [03]  C   Titulo do campo
				X3Descric('ZZ5_DATA'),;     // [04]  C   Descricao do campo
				Nil,;                       // [05]  A   Array com Help
				"C",;                       // [06]  C   Tipo do campo
				X3Picture("X5_DESCRI"),;    // [07]  C   Picture
				Nil,;                       // [08]  B   Bloco de PictTre Var
				Nil,;                       // [09]  C   Consulta F3
				.T.,;                       // [10]  L   Indica se o campo é alteravel
				Nil,;                       // [11]  C   Pasta do campo
				Nil,;                       // [12]  C   Agrupamento do campo
				Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
				Nil,;                       // [14]  N   Tamanho maximo da maior opção do combo
				Nil,;                       // [15]  C   Inicializador de Browse
				Nil,;                       // [16]  L   Indica se o campo é virtual
				Nil,;                       // [17]  C   Picture Variavel
				Nil)                        // [18]  L   Indica pulo de linha após o campo
	
  	oStFilho:AddField(;						// Ord. Tipo Desc.
				'ZZ5_STATUS1',;    	    	// [01] C   Nome do Campo
				"00",;              		// [02] C   Ordem
				AllTrim( '' ),;    	 		// [03] C   Titulo do campo
				AllTrim( '' ),;     		// [04] C   Descricao do campo
				{ 'Legenda' },;     		// [05] A   Array com Help
				'C',;     					// [06] C   Tipo do campo
				'@BMP',;				    // [07] C   Picture
				NIL,;					    // [08] B   Bloco de Picture Var
				'',;					    // [09] C   Consulta F3
				.T.,;     					// [10] L   Indica se o campo é alteravel
				NIL,;    					// [11] C   Pasta do campo
				NIL,;    					// [12] C   Agrupamento do campo
				NIL,;     					// [13] A   Lista de valores permitido do campo (Combo)
				NIL,;     					// [14] N   Tamanho maximo da maior opção do combo
				NIL,;     					// [15] C   Inicializador de Browse
				.T.,;     					// [16] L   Indica se o campo é virtual
				NIL,;     					// [17] C   Picture Variavel
				NIL)       					// [18] L   Indica pulo de linha após o campo

	
  	oStFilho:AddField(;						// Ord. Tipo Desc.
				'ZZ5_FILOR',;    	    	// [01] C   Nome do Campo
				"01",;              		// [02] C   Ordem
				AllTrim( 'Filial' ),;    	// [03] C   Titulo do campo
				AllTrim( 'Filial' ),;       // [04] C   Descricao do campo
				{ '' },;     		        // [05] A   Array com Help
				'C',;     					// [06] C   Tipo do campo
				'@!',;				        // [07] C   Picture
				NIL,;					    // [08] B   Bloco de Picture Var
				'',;					    // [09] C   Consulta F3
				.T.,;     					// [10] L   Indica se o campo é alteravel
				NIL,;    					// [11] C   Pasta do campo
				NIL,;    					// [12] C   Agrupamento do campo
				NIL,;     					// [13] A   Lista de valores permitido do campo (Combo)
				NIL,;     					// [14] N   Tamanho maximo da maior opção do combo
				NIL,;     					// [15] C   Inicializador de Browse
				.T.,;     					// [16] L   Indica se o campo é virtual
				NIL,;     					// [17] C   Picture Variavel
				NIL)       					// [18] L   Indica pulo de linha após o campo

	//oStFilho:SetProperty("ZZ5_FILIAL"  , MVC_VIEW_ORDEM, "01")
	//oStFilho:SetProperty("ZZ5_DESCR", MVC_VIEW_ORDEM, "03")


	//Criando a view que será o retorno da função e setando o modelo da rotina
	oView := FWFormView():New()
	oView:SetModel(oModel)
	
	oView:AddField("VIEW_CAB", oStTmp, "FORMCAB")
	oView:AddGrid('VIEW_ZZ5',oStFilho,'ZZ5DETAIL')
	
	//If !ALTERA
	oView:AddUserButton( 'Efetiva Inventario', 'Efetiva', {|oView| fEfetiva(oView)},,,,.t.)
	//EndIf

	oView:AddUserButton( 'Exporta Excel'     , 'Excel'  , {|oView| fExcel(oView  )},,,,.t.)
	
	//Setando o dimensionamento de tamanho
	oView:CreateHorizontalBox('CABEC',20)
	oView:CreateHorizontalBox('GRID',80)
	
	//Amarrando a view com as box
	oView:SetOwnerView('VIEW_CAB','CABEC')
	oView:SetOwnerView('VIEW_ZZ5','GRID')
	
	//Habilitando título
	oView:EnableTitleView('VIEW_CAB','Cabeçalho - Conferencia de Contgem')
	oView:EnableTitleView('VIEW_ZZ5','Itens - Contagem')
	
	//Tratativa padrão para fechar a tela
	oView:SetCloseOnOk({||.T.})

	oView:CanInsertLine('VIEW_ZZ5')
	
	//Remove os campos de Filial e Tabela da Grid
	oStFilho:RemoveField('ZZ5_FILIAL')
	oStFilho:RemoveField('ZZ5_DOC'   )
	oStFilho:RemoveField('ZZ5_DATA'  )
	oStFilho:RemoveField('ZZ5_STATUS')
	oStFilho:RemoveField('ZZ5_LOCAL' )
	oStFilho:RemoveField('ZZ5_UM12'  )
	oStFilho:RemoveField('ZZ5_UM13'  )
	oStFilho:RemoveField('ZZ5_UM14'  )
	oStFilho:RemoveField('ZZ5_UM22'  )
	oStFilho:RemoveField('ZZ5_UM23'  )
	oStFilho:RemoveField('ZZ5_UM24'  )
	oStFilho:RemoveField('ZZ5_STATUS')

	
Return oView

//********************************************************************************************************************


//********************************************************************************************************************

Static Function fLinOK(oModel, nLine, cAction, cField,TT,RR,DD)
Local oModelZZ5 := oModel:GetModel( 'bdlinv4M' )    
	If (oModel:GetOperation() == MODEL_OPERATION_UPDATE)
       

	EndIf
	if cAction == "SETVALUE"
		
	endif

Return (.T.)

//********************************************************************************************************************

//********************************************************************************************************************

User Function VldX5Tab()
Local aArea      := GetArea()
Local lRet       := .T.
Local oModelDad  := FWModelActive()
//Local cFilZZ5    := oModelDad:GetValue('FORMCAB', 'ZZ5_FILIAL')
//Local cCodigo    := SubStr(oModelDad:GetValue('FORMCAB', 'ZZ5_DOC'), 1, TamSX3('ZZ5_DOC')[01])
Local nOpc       := oModelDad:GetOperation()
	
	//Se for Inclusão
	If nOpc == MODEL_OPERATION_INSERT

		DbSelectArea('ZZ5')
		ZZ5->(DbSetOrder(1)) //X5_FILIAL + X5_TABELA + X5_CHAVE
		
		//Se conseguir posicionar, tabela já existe
		Aviso('Atenção', 'Esse código de tabela já existe!', {'OK'}, 02)
		//lRet := .F.
	
	EndIf
	
	RestArea(aArea)

Return lRet

//********************************************************************************************************************

//********************************************************************************************************************

User Function SaveMd2(oModel)
Local aArea      := GetArea()
Local lRet       := .T.
Local nOpc := 1
	
	DbSelectArea('ZZ5')
	ZZ5->(DbSetOrder(3)) //X5_FILIAL + X5_TABELA + X5_CHAVE
	
	//Se for Inclusão
	If nOpc == MODEL_OPERATION_INSERT
			
	//Se for Alteração
	ElseIf nOpc == MODEL_OPERATION_UPDATE
		
	//Se for Exclusão
	ElseIf nOpc == MODEL_OPERATION_DELETE
		
	EndIf
	
	//Se não for inclusão, volta o INCLUI para .T. (bug ao utilizar a Exclusão, antes da Inclusão)
	If nOpc != MODEL_OPERATION_INSERT
		INCLUI := .T.
	EndIf
	
	RestArea(aArea)

Return lRet

//***********************************************************************************************************


//**********************************************************************************************************

Function U_fBwLeg(lVisual)
Local xLeg := {}

DEFAULT lVisual := .T.

	AADD( xLeg,{"ZZ5_CONTAG == '000' .and. ZZ5_STATUS <> 'ZZ' "  ,"BR_VERDE"       ,"Contagem Iniciada"      })
	AADD( xLeg,{"ZZ5_CONTAG == '001' .and. ZZ5_STATUS <> 'ZZ' "  ,"BR_AMARELO"     ,"Contagem 1 Finalizado"  })
	AADD( xLeg,{"ZZ5_CONTAG == '002' .and. ZZ5_STATUS <> 'ZZ' "  ,"BR_AZUL"        ,"Contagem 2 Finalizado"  })
	AADD( xLeg,{"ZZ5_CONTAG == '003' .and. ZZ5_STATUS <> 'ZZ' "  ,"BR_VIOLETA"     ,"Contagem 3 Finalizado"  })
	AADD( xLeg,{"ZZ5_CONTAG == '004' .and. ZZ5_STATUS <> 'ZZ' "  ,"BR_BRANCO"      ,"Contagem 4 finalizada"  })
	AADD( xLeg,{"ZZ5_STATUS == 'ZZ' .and. !empty(ZZ5_CONTAG) "   ,"BR_VERMELHO"    ,"Finalizado"             })

	if lVisual .and. .f.
		BrwLegenda("Liberação de Nota - Controle de Qualidade",;
				"Legenda",{;
						{"BR_VERDE"       ,"Não Coontado"           },;
						{"BR_AMARELO"     ,"Contagem 1 Inicializada"},;
						{"BR_AZUL_CLARO"  ,"Contagem 1 Finalizado"  },;
						{"BR_LARANJA"     ,"Contagem 2 Inicializada"},;
						{"BR_AZUL"        ,"Contagem 2 Finalizado"  },;
						{"BR_CINZA"       ,"Contagem 3 Inicializada"},;
						{"BR_VERDE_ESCURO","Contagem 3 Finalizado"  },;
						{"BR_VIOLETA"     ,"Contagem 4 Inicializada"},;
						{"BR_BRANCO"      ,"Contagem 4 Finalizado"  },;
						{"BR_VERMELHO"    ,"Finalizado"             };
				})
	endif

Return xLeg

//*************************************************************************************************



//*************************************************************************************************


Function U_fTLeg(lVisual)
Local cRet := "BR_VERDE" 

DEFAULT lVisual := .T.

	Do Case
	case ZZ5->ZZ5_CONTAG == '001' .and. ZZ5_STATUS <> 'ZZ'
			cRet := "BR_AMARELO"    
	case ZZ5->ZZ5_CONTAG == '002' .and. ZZ5_STATUS <> 'ZZ'
			cRet := "BR_AZUL"       
	case ZZ5->ZZ5_CONTAG == '003' .and. ZZ5_STATUS <> 'ZZ'
			cRet := "BR_VIOLETA"    
	case ZZ5->ZZ5_CONTAG == '004' .and. ZZ5_STATUS <> 'ZZ'
			cRet := "BR_BRANCO"     
	case ZZ5->ZZ5_STATUS == 'ZZ' .AND. !empty(ZZ5_CONTAG)
			cRet := "BR_VERMELHO"   
	OtherWise
			cRet := "BR_VERDE"      
	EndCase
	/*	
	if lVisual
		BrwLegenda("Liberação de Nota - Controle de Qualidade",;
				"Legenda",{;
						{"BR_VERDE"       ,"Não Coontado"           },;
						{"BR_AMARELO"     ,"Contagem 1 Inicializada"},;
						{"BR_AZUL_CLARO"  ,"Contagem 1 Finalizado"  },;
						{"BR_LARANJA"     ,"Contagem 2 Inicializada"},;
						{"BR_AZUL"        ,"Contagem 2 Finalizado"  },;
						{"BR_CINZA"       ,"Contagem 3 Inicializada"},;
						{"BR_VERDE_ESCURO","Contagem 3 Finalizado"  },;
						{"BR_VIOLETA"     ,"Contagem 4 Inicializada"},;
						{"BR_BRANCO"      ,"Contagem 4 Finalizado"  },;
						{"BR_VERMELHO"    ,"Finalizado"             };
				})
	endif
	*/
Return cRet

/*

GREEN - Para a cor Verde
RED - Para a cor Vermelha
YELLOW - Para a cor Amarela
ORANGE - Para a cor Laranja
BLUE - Para a cor Azul
GRAY - Para a cor Cinza
BROWN - Para a cor Marrom
BLACK - Para a cor Preta
PINK - Para a cor Rosa
WHITE - Para a cor Branca
*/
//Monta as legendas (Cor, Legenda)
    /*
	aAdd(aLegenda,{"BR_AMARELO",      "Teste 01"})
    aAdd(aLegenda,{"BR_AZUL",         "Teste 02"})
    aAdd(aLegenda,{"BR_AZUL_CLARO",   "Teste 03"})
    aAdd(aLegenda,{"BR_BRANCO",       "Teste 04"})
    aAdd(aLegenda,{"BR_CANCEL",       "Teste 05"})
    aAdd(aLegenda,{"BR_CINZA",        "Teste 06"})
    aAdd(aLegenda,{"BR_LARANJA",      "Teste 07"})
    aAdd(aLegenda,{"BR_MARROM",       "Teste 08"})
    aAdd(aLegenda,{"BR_MARRON",       "Teste 09"})
    aAdd(aLegenda,{"BR_PINK",         "Teste 10"})
    aAdd(aLegenda,{"BR_PRETO",        "Teste 11"})
    aAdd(aLegenda,{"BR_VERDE",        "Teste 12"})
    aAdd(aLegenda,{"BR_VERDE_ESCURO", "Teste 13"})
    aAdd(aLegenda,{"BR_VERMELHO",     "Teste 14"})
    aAdd(aLegenda,{"BR_VIOLETA"    ,     "Teste 15"})
	*/

//********************************************************************************************************************

//********************************************************************************************************************

Static Function fEfetiva(oView)
	//Alert("Rotina em Desenvolvimento")
Return 	Processa({||fExcel(oView,.T.) },"Aguarde Efetivado Contagem")


//********************************************************************************************************************
//oModelGrid:aDataModel[1,1,1,1] == oModelGrid:aDataModel[2,1,1,1]
//********************************************************************************************************************

Static Function fExcel(oView,lSB7)
//Local aArea      := GetArea()
//Local lRet       := .T.
	Local oModelDad  := FWModelActive()
//Local cFilZZ5    := oModelDad:GetValue('FORMCAB', 'ZZ5_FILIAL')
//Local cCodigo    := SubStr(oModelDad:GetValue('FORMCAB', 'ZZ5_DOC'), 1, TamSX3('ZZ5_DOC')[01])
//Local cDescri    := oModelDad:GetValue('FORMCAB', 'ZZ5_DATA')
//Local nOpc       := oModelDad:GetOperation()
	Local oModelGrid := oModelDad:GetModel('ZZ5DETAIL')
	Local aHeadAux   := oModelGrid:aHeader
	Local aCols 	:= {}
	Local aColsAux 	:= {}
	Local nX := 0
	Local nY := 0

	Local nPosQtd13   := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD13" )})
	Local nPosCont3   := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_CONT3" )})

	Default lSB7 := .F.

	For nX := 1 to len(oModelGrid:aDataModel)

		aColsAux := {}

		For nY := 1 to len(aHeadAux)

			aadd(aColsAux,oModelGrid:aDataModel[nX, 1, 1, nY] )

		Next nY

		IF aColsAux[nPosCont3] == '2' .or. (aColsAux[nPosCont3] == '1' .and. aColsAux[nPosQtd13] > 0)
			aadd(aColsAux,.T.)
		ELSE
			aadd(aColsAux,.F.)
		ENDIF

		aadd(aCols,aColsAux)

	Next nX

	if !lSB7
		Processa({||fGeraExel(aHeadAux,aCols,1)},"Aguarde Gerando Planilha")
	Else
		if oView:GetOperation() == 1
			aCols2 := aClone(fEfe(aHeadAux,aCols))
			fSalva(aHeadAux,aCols2)
			fGeraExel(aHeadAux,aCols2,2)
		Else
			Alert("Opção disponivel na Visualização")
		EndIf
	EndIf

Return

//********************************************************************************************************************

//********************************************************************************************************************
Static Function fEfe(aHeadAux,aCols)
	Local nPosFil     := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_FILIAL"  )})
	Local nPosProd    := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_COD"     )})
	Local nPosLocal   := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_LOCAL"   )})
//Local nPosEnder   := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_ENDER"   )})
	Local nPosLote    := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_LOTECT"  )})
//Local nPosVenc    := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_DTVALI"  )})
//Local nPosDoc     := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_DOC"     )})
	Local nPosDat     := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_DATA"    )})
//Local nPosStat    := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_STATUS"  )})
//Local nPosCont    := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_CONTAG"  )})
	Local nPosQtd11   := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD11"  )})
	Local nPosQtd21   := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD21"  )})
	Local nPosQtd12   := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD12"  )})
	Local nPosQtd22   := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD22"  )})
	Local nPosQtd13   := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD13"  )})
	Local nPosQtd23   := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD23"  )})
	Local nPosQtd14   := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD14"  )})
	Local nPosQtd24   := aScan(aHeadAux, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD24"  )})

	Local nTam     := 0
	Local nX       := 0
	Local aAux     := {}
	Local aColsAux := {}

	nTam := len(aAux)

	//B7_FILIAL+ DTOS(B7_DATA) + B7_COD + B7_LOCAL+B7_LOTECTL
	For nX := 1 to Len(acols)

		nTam := len(aColsAux)

		if nX == 1

			//aAux := {}
			//aadd(aAux,aCols[nX])
			aadd(aColsAux,aCols[nX])

		else

			if aCols[ nX , nPosFil  ] == aColsAux[ nTam , nPosFil  ] .and. aCols[ nX , nPosDat   ] == aColsAux[ nTam , nPosDat   ] .and. ;
					aCols[ nX , nPosProd ] == aColsAux[ nTam , nPosProd ] .and. aCols[ nX , nPosLocal ] == aColsAux[ nTam , nPosLocal ] .and. ;
					aCols[ nX , nPosLote ] == aColsAux[ nTam , nPosLote ]

				aColsAux[nTam, nPosQtd11] += aCols[nX,nPosQtd11]
				aColsAux[nTam, nPosQtd21] += aCols[nX,nPosQtd21]

				aColsAux[nTam, nPosQtd12] += aCols[nX,nPosQtd12]
				aColsAux[nTam, nPosQtd22] += aCols[nX,nPosQtd22]

				aColsAux[nTam, nPosQtd13] += aCols[nX,nPosQtd13]
				aColsAux[nTam, nPosQtd23] += aCols[nX,nPosQtd23]

				aColsAux[nTam, nPosQtd14] += aCols[nX,nPosQtd14]
				aColsAux[nTam, nPosQtd24] += aCols[nX,nPosQtd24]

			Else
				//aAux := {}
				//aadd(aAux,aCols[nX])
				aadd(aColsAux,aCols[nX])//aAux)

			EndIf

		endif

	Next nX

Return aColsAux

//********************************************************************************************************************

//********************************************************************************************************************

Static Function hfGeraExel(xHeader, xCols,nSlv)
	Local oModelDad := FWModelActive()
	Local cDoc      := SubStr(oModelDad:GetValue('FORMCAB', 'ZZ5_DOC'  ), 1, TamSX3('ZZ5_DOC'  )[01])
	Local cLocal    := SubStr(oModelDad:GetValue('FORMCAB', 'ZZ5_LOCAL'), 1, TamSX3('ZZ5_LOCAL')[01])
	Local nPosQtd11   := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD11"  )})
	Local nPosQtd12   := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD12"  )})
	Local nPosQtd13   := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD13"  )})
	Local nPosQtd14   := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD14"  )})
	Local nPosdif     := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_DIF12"  )})

	Local cPlanilha := "Contagem - " + cDoc + " - " + cLocal
	Local cTabela   := "Armazém - " + cLocal
	Local cPasta 	:= ""
	Local cArq   	:= "Armazem_" + cDoc + "_" + cLocal+"_" + StrTran(time(),":","")
	Local nX        := 0
	Local nTipo     := 1
	Local nAlinha   := 1
	Local aDados 	:= {}
	Local aCor 		:= {}
	Local lX 		:= .T.
	Default nSlv    := 1
	cPasta := cGetFile("", "Salvar Arquivo em", 1, "C:\", .T., GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY)

	//Cria o Objeto para criar a Planilha XML
	oExcel := FwMsExcelEx():New()

	//Define a Planilha
	oExcel:AddWorkSheet(cPlanilha)

	//Define a Tabela na Planilha
	oExcel:AddTable(cPlanilha,cTabela)

	for nX := 1 to len(xHeader)-6

		Do Case

		Case xHeader[nX,8] == 'N'

			nTipo   := 2
			nAlinha := 3

		Case xHeader[nX,8] == 'D'

			nTipo   := 1
			nAlinha := 1

		OtherWise

			nTipo   := 1
			nAlinha := 1

		EndCase

		//Define as Colunas da Planilha
		oExcel:AddColumn(cPlanilha , cTabela , xHeader[nX,1] , nAlinha , nTipo , .f. ) //1

	Next nX

	oExcel:AddColumn(cPlanilha , cTabela , "Ocorrencia" , 1, 1 , .f. )

	lBold := .F.

	For nX := 1 to Len(xCols)

		aDados := {}
		aCor := {}

		For nY := 1 to Len(xCols[nX]) - 7

			if Valtype(xCols[nX,nY]) == 'D'
				aAdd(aDados,DtoS(xCols[nX,nY]))
			else
				aAdd(aDados,xCols[nX,nY])
			endif

			IF nY == nPosQtd11 .OR. nY == nPosQtd12 .OR. nY == nPosQtd13 .OR. nY == nPosQtd14 .OR. nY == nPosdif

				IF nY == nPosdif .AND. xCols[nX,nY] <> 0
					aadd(aCor,nY)
					//lBold := .T.
				ENDIF

				IF nY <> nPosdif
					aadd(aCor,nY)
				ENDIF

			ENDIF

		Next nY

		nImp := xCols[nX,Len(xCols[nX])]

		IF lX

			oExcel:SetCelBgColor("#F4B084")
			//oExcel:SetLineBold(lBold)
			//oExcel:SetCelBold(lBold)
		ELSE

			oExcel:SetCelBgColor("#FADCCA")
			//oExcel:Set2LineBold(lBold)
			//oExcel:SetCelBold(lBold)

		EndIf

		lX := !lX

		if nSlv == 1
			if nImp
				aadd(aDados,'Ok')
			else
				aadd(aDados,'Não será Integrado')
			endif
		Else
			if nImp
				aadd(aDados,'Ok')
			else
				aadd(aDados,'Não Integrado')
			endif

		endif
		//Inseri os Dados nas Celulas
		oExcel:AddRow(cPlanilha,cTabela, aDados,aCor)

	Next nX

	//Cria a Planilha em XML no formato Excel
	oExcel:Activate()

	If !Empty(cPasta)

		//Verifica se o Excel esta instalado
		If !ApOleClient("MSExcel")

			MsgAlert("Microsoft Excel não instalado!","Atenção")

		Else

			//Salva o Excel em arquivo
			oExcel:GetXMLFile(cPasta + cArq+".XML")

			//Abre o Excel
			oEx:=MsExcel():New()

			//Abre o Arquivo
			oEx:WorkBooks:Open(cPasta + cArq+".XML")

			//Apresenta em Tela
			oEx:SetVisible(.T.)

		Endif

	Endif

Return
//******************************************************************************************************
Static Function fGeraExel(xHeader, xCols,nSlv)
	Local oModelDad := FWModelActive()
	Local cDoc      := SubStr(oModelDad:GetValue('FORMCAB', 'ZZ5_DOC'  ), 1, TamSX3('ZZ5_DOC'  )[01])
	Local cLocal    := SubStr(oModelDad:GetValue('FORMCAB', 'ZZ5_LOCAL'), 1, TamSX3('ZZ5_LOCAL')[01])

//Local cDoc      := MV_PAR03
//Local cLocal    := MV_PAR02
	Local cPlanilha := "Contagem - " + cDoc + " - " + cLocal
	Local cTabela   := "Armazém - " + cLocal + "-" + MV_PAR05
	Local cPasta 	  := ""
	Local cArq   	  := "Armazem_" + cLocal + "_" + MV_PAR05 + "_" + StrTran(time(),":","")
	Local nX        := 0
//Local nTipo     := 1
//Local nAlinha   := 1
	Local aDados 	  := {}
	Local aCor 		  := {}
	Local lX 		    := .T.

	Local nPosFil   := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_FILIAL" )})
//Local nPosDoc   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_DOC"    )})
	Local nPosProd  := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_COD"    )})
	Local nPosDes   := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_DESCR"  )})
	Local nPosLocal := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_LOCAL"  )})
	Local nPosEnder := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_ENDER"  )})
	Local nPosCLote := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_CLOTE"  )})

	Local nPosLote  := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_LOTECT" )})
	Local nPosDtVal := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_DTVALI" )})

	Local nPos1UM   := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_UM11"   )})
	Local nPos2UM   := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_UM21"   )})

	Local nPosQtd11 := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD11"  )})
	Local nPosQtd12 := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD12"  )})
	Local nPosQtd13 := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD13"  )})
//Local nPosQtd14 := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD14"  )})
	Local nPosQtd21 := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD21"  )})
	Local nPosQtd22 := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD22"  )})
	Local nPosQtd23 := aScan(xHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD23"  )})
//Local nPosQtd24 := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD24"  )})
//Local nPosdif   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_DIF12"  )})

	cPasta := cGetFile("", "Salvar Arquivo em", 1, "C:\", .T., GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY)

	//Cria o Objeto para criar a Planilha XML
	oExcel := FwMsExcelEx():New()

	//Define a Planilha
	oExcel:AddWorkSheet(cPlanilha)

	//Define a Tabela na Planilha
	oExcel:AddTable(cPlanilha,cTabela)

	//Define as Colunas da Planilha
	oExcel:AddColumn(cPlanilha , cTabela , "Filial"                 , 1 , 1 , .f. ) //1
	//oExcel:AddColumn(cPlanilha , cTabela , "Documento"              , 1 , 1 , .f. ) //1
	//oExcel:AddColumn(cPlanilha , cTabela , "Data"                   , 1 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Produto"                , 1 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Descrição"              , 1 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Local"                  , 1 , 1 , .f. ) //1

	if nSlv <> 2
		oExcel:AddColumn(cPlanilha , cTabela , "Endereço"               , 1 , 1 , .f. ) //1
	Endif

	oExcel:AddColumn(cPlanilha , cTabela , "Controle de Lote"       , 2 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Lote"                   , 1 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Data de Validade"       , 2 , 1 , .f. ) //1

	//oExcel:AddColumn(cPlanilha , cTabela , "-"                      , 2 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Primeira Unid. Medida " , 2 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Primeira Contagem"      , 3 , 2 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Segunda Contagem"       , 3 , 2 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Diferença"              , 3 , 2 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Terceira Contagem"      , 3 , 2 , .f. ) //1

	//oExcel:AddColumn(cPlanilha , cTabela , "-"                      , 2 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Segunda Unid. Medida"   , 2 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Primeira Contagem"      , 3 , 2 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Segunda Contagem"       , 3 , 2 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Diferença"              , 3 , 2 , .f. ) //
	oExcel:AddColumn(cPlanilha , cTabela , "Terceira Contagem"      , 3 , 2 , .f. ) //1


	lBold := .F.
	cFilDe := xCols[ 1 , nPosFil   ]
	For nX := 1 to Len(xCols)

		aDados := {}
		aCor   := {}

		aadd( aDados , xCols[ nX , nPosFil   ] )              // 01    Filial
		//aadd( aDados , xCols[ nX , nPosDoc   ] )            // 02    Documento
		//aadd( aDados , xCols[ nX , nPosDat   ] )            // 03    Data
		aadd( aDados , xCols[ nX , nPosProd  ] )              // 04    Produto
		aadd( aDados , xCols[ nX , nPosDes   ] )              // 05    Descrição
		aadd( aDados , cLocal /*xCols[ nX , nPosLocal ]*/ )              // 06    Local
		if nSlv <> 2
			aadd( aDados , xCols[ nX , nPosEnder ] )              // 07    Endereço
		endif
		aadd( aDados , iif(xCols[ nX , nPosCLote ] == 'L',"Sim"," " ))              // 08    Controla Lote
		aadd( aDados , xCols[ nX , nPosLote  ] )              // 09    Lote
		aadd( aDados , iif(empty(xCols[nX,nPosDtVal]) , "" , DtoC(xCols[ nX , nPosDtVal ]) ) )        // 10    Data de Validade

		//aadd( aDados , "*"                     )              // 11    Separador
		aadd( aDados , xCols[ nX , nPos1UM   ] )              // 12    Primeira Unidade de Medida
		aadd( aDados , xCols[ nX , nPosQtd11 ] )              // 13    Primeira Contagem
		aadd( aDados , xCols[ nX , nPosQtd12 ] )              // 14    Segunda Contagem
		aadd( aDados , xCols[ nX , nPosQtd11 ] - xCols[ nX , nPosQtd12 ] )  // 15    Diferença
		aadd( aDados , xCols[ nX , nPosQtd13 ] )              // 16

		if ( xCols[ nX , nPosQtd11 ] - xCols[ nX , nPosQtd12 ]) <> 0
			if nSlv <> 2
				aadd(aCor,12)
			else
				aadd(aCor,11)
			endif

		endif

		//aadd( aDados , "*"                     )              // 17    Separador
		aadd( aDados , xCols[ nX , nPos2UM   ] )              // 18    Segunda Unidade de Medida
		aadd( aDados , xCols[ nX , nPosQtd21 ] )              // 19    Primeira Contagem
		aadd( aDados , xCols[ nX , nPosQtd22 ] )              // 20    Segunda Contagem
		aadd( aDados , xCols[ nX , nPosQtd21 ] - xCols[ nX , nPosQtd22 ] )  // 21    Diferenca
		aadd( aDados , xCols[ nX , nPosQtd23 ] )              // 22    Terceira Contagem

		if (xCols[ nX , nPosQtd21 ] - xCols[ nX , nPosQtd22 ]) <> 0
			//aadd(aCor,17)
			if nSlv <> 2
				aadd(aCor,17)
			else
				aadd(aCor,16)
			endif

		endif

		IF lX

			oExcel:SetCelBgColor("#F4B084")
			//oExcel:SetLineBold(lBold)
			//oExcel:SetCelBold(lBold)

		ELSE

			oExcel:SetCelBgColor("#FADCCA")
			//oExcel:Set2LineBold(lBold)
			//oExcel:SetCelBold(lBold)

		EndIf

		lX := !lX

		//Inseri os Dados nas Celulas
		oExcel:AddRow(cPlanilha,cTabela, aDados,aCor)

	Next nX

	//Cria a Planilha em XML no formato Excel
	oExcel:Activate()

	If !Empty(cPasta)

		//Verifica se o Excel esta instalado
		If !ApOleClient("MSExcel")
			MsgAlert("Microsoft Excel não instalado!","Atenção")
		Else
			//Salva o Excel em arquivo
			oExcel:GetXMLFile(cPasta + cArq+".XML")
			//Abre o Excel
			oEx := MsExcel():New()
			//Abre o Arquivo
			oEx:WorkBooks:Open(cPasta + cArq+".XML")
			//Apresenta em Tela
			oEx:SetVisible(.T.)

		Endif

	Endif
	if nSlv == 2
		aPar :={cFilDe,cFilDe,"","ZZZZZZZZZZZZZZZZ",cLocal,cLocal,dDtInv,dDtInv}
		U_BLESTR21(.T.,aPar,cPasta)
	endif

Return

//******************************************************************************************************


//******************************************************************************************************

static function fSalva(aHeader,aCols)
	Local nQtd1   := 0
	Local nQtd2   := 0
	Local cCont   := ""
	Local nPosFil     := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_FILIAL"  )})
	Local nPosProd    := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_COD"     )})
	Local nPosLocal   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_LOCAL"   )})
	Local nPosLote    := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_LOTECT"  )})
	Local nPosDat     := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_DATA"    )})

	Local nPosQtd11   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD11"  )})
	Local nPosQtd21   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD21"  )})
	Local nPosQtd12   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD12"  )})
	Local nPosQtd22   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD22"  )})
	Local nPosQtd13   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD13"  )})
	Local nPosQtd23   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD23"  )})
	Local nPosQtd14   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD14"  )})
	Local nPosQtd24   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD24"  )})

	Local nPosEnder   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_ENDER"   )})
	Local nPosVenc    := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_DTVALI"  )})
	Local nPosDoc     := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_DOC"     )})
	Local nPosStat    := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_STATUS"  )})
//Local nPosCont    := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_CONTAG"  )})

	Local lB7 := .F.
	Local cCont := "001"

	_NUMSERI := SPACE(LEN(SB7->B7_NUMSERI))
	_NUMLOTE := SPACE(LEN(SB7->B7_NUMLOTE))


	For nX := 1 to len(aCols)
		nQtd1  := 0
		nQtd2  := 0
		for nY := 4 to 1 step -1

			nCount1 := &("nPosQtd1"+str(nY,1))
			nCount2 := &("nPosQtd2"+str(nY,1))
			//??????????????????????????????????????????????/
			if aCols [nX,nCount1] > 0

				nQtd1   += aCols[nX,nCount1]
				nQtd2   += aCols[nX,nCount2]
				cCont   := StrZero(nY,3)
				lB7 := .T.

				Exit

			EndIf
			//???????????????????????????????????????????????
		Next nY

		IF aCols[nX,nPosStat] == 'ZZ' .or. !aCols[nX , len(aCols[nX])]
			lB7 := .F.
		ENDIF

		_FILIAL  := aCols[nX , nPosFil   ]
		_COD     := aCols[nX , nPosProd  ]
		_LOCAL   := aCols[nx , nPosLocal ]
		_TIPO    := posicione("SB1",1,xFilial('SB1') +_COD ,"B1_TIPO" )
		_DOC     := aCols[nX , nPosDoc   ]
		_QUANT   := nQtd1 //aCols[nX , nPosQtd1  ]
		_QTSEGUM := nQtd2 //aCols[nX , nPosQtd2  ]
		_DATA    := aCols[nX , nPosDat   ]
		_ORIGEM  := "BDLINV4"
		_STATUS  := "1"
		_CONTAGE := cCont//aCols[nX , nPosCont  ]
		_LOCALIZ := space(len(aCols[nX , nPosEnder ]))

		DbSelectArea('SB1')
		SB1->(DbSetOrder(1))
		SB1->(dBsEEK(Xfilial('SB1')+_COD ))

		IF SB1->B1_RASTRO == 'L'

			_LOTECTL := aCols[nX , nPosLote  ]
			_DTVALID := aCols[nX , nPosVenc  ]

		ELSE

			_LOTECTL := space(len(aCols[nX , nPosLote  ]))
			_DTVALID := ctod(' /  /  ')

		ENDIF

		//Chave Unica SB7
		//B7_FILIAL+ DTOS(B7_DATA) + B7_COD + B7_LOCAL+B7_LOTECTL
		DbSelectArea('SB7')
		SB7->(DbSetOrder(1)) //X5_FILIAL + X5_TABELA + X5_CHAVE

		if lB7

			BEGIN TRANSACTION

				if !SB7->(DBSEEK(_FILIAL + DTOS(_DATA) + _COD + _LOCAL + _LOCALIZ + _NUMSERI + _LOTECTL + _NUMLOTE /*+ _CONTAGE*/) )

					RecLock("SB7", .T.)
					SB7->B7_FILIAL  := _FILIAL   	//oModelGrid:aDataModel[nX, 1, 1, 1  ]
					SB7->B7_COD     := _COD      	//oModelGrid:aDataModel[nX, 1, 1, nPosProd  ]
					SB7->B7_LOCAL   := _LOCAL    	//oModelGrid:aDataModel[nx, 1, 1, nPosLocal ]
					SB7->B7_TIPO    := _TIPO
					SB7->B7_DOC     := _DOC      	//oModelGrid:aDataModel[nX, 1, 1, nPosDoc   ]
					SB7->B7_QUANT   := _QUANT    	//oModelGrid:aDataModel[nX, 1, 1, nPosQtd1  ]
					SB7->B7_QTSEGUM := _QTSEGUM 	//oModelGrid:aDataModel[nX, 1, 1, nPosQtd2  ]
					SB7->B7_DATA    := _DATA    	//oModelGrid:aDataModel[nX, 1, 1, nPosDat   ]
					SB7->B7_ORIGEM  := "BDLINV4"
					SB7->B7_STATUS  := "1"
					SB7->B7_LOTECTL := _LOTECTL		//oModelGrid:aDataModel[nX, 1, 1, nPosLote  ]
					SB7->B7_DTVALID := _DTVALID 	//oModelGrid:aDataModel[nX, 1, 1, nPosVenc  ]
					SB7->B7_CONTAGE := _CONTAGE 	//oModelGrid:aDataModel[nX, 1, 1, nPosCont  ]
					//SB7->B7_LOCALIZ := _LOCALIZ		//oModelGrid:aDataModel[nX, 1, 1, nPosEnder ]
					SB7->(MsUnLock())
				else

					RecLock("SB7", .F.)
					SB7->B7_QUANT   += _QUANT    	//oModelGrid:aDataModel[nX, 1, 1, nPosQtd1  ]
					SB7->B7_QTSEGUM += _QTSEGUM 	//oModelGrid:aDataModel[nX, 1, 1, nPosQtd2  ]
					SB7->(MsUnLock())

				endif

				dbSelectArea("ZZ5")
				ZZ5->(dbSetOrder(7))

				IF ZZ5->(DBSEEK(_FILIAL + _DOC +  _LOCAL + _COD ))

					While ZZ5->(!EOF()) .AND. _FILIAL + _DOC +  _LOCAL + _COD == ZZ5->ZZ5_FILIAL + ZZ5->ZZ5_DOC + ZZ5->ZZ5_LOCAL+ZZ5->ZZ5_COD

						Reclock("ZZ5",.F.)
						ZZ5->ZZ5_STATUS := "ZZ"
						ZZ5->(MsUnLock())
						ZZ5->(dbSKip())

					EndDo

				EndIf

			END TRANSACTION

		endif

	Next nX

Return

Static Function tConVer1(oGrid, nLine, cAction, cField,TT,RR,DD)
	Local nConvert := 0
	If nOpc == 1
		nConvert := 0
	Else
		nConvert := 1
	Endif

Return nConvert
