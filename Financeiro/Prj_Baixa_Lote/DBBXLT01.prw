//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

Static cTitulo := "Front End Baixa Por Lote"
 
/*/
{Protheus.doc} DBBXLT01
Description

	Projeto: Baixa por Lote - Contas a Receber
	Função tem como objetivo baixar os cupons e criar lotes sumarizados para baixas

@param xParam Parameter Description
@return Nil
@author  - Douglas R. Silva
@since 15/11/2019
/*/
	
User Function DBBXLT01()

 /*Declarando as variáveis que serão utilizadas*/
	Local lRet := .T.
	Local aArea := ZCT->(GetArea())
	Private oBrowse
	Private cChaveAux := ""

	//Iniciamos a construção básica de um Browse.
	oBrowse := FWMBrowse():New()

	//Definimos a tabela que será exibida na Browse utilizando o método SetAlias
	oBrowse:SetAlias("ZCT")

	//Definimos o título que será exibido como método SetDescription
	oBrowse:SetDescription(cTitulo)

	//Adiciona um filtro ao browse
	oBrowse:SetFilterDefault( "" )
		
	//Ativamos a classe
	oBrowse:Activate()
	RestArea(aArea)
	
Return

//-------------------------------------------------------------------
// Montar o menu Funcional
//-------------------------------------------------------------------

Static Function MenuDef()
	
	Local aRotina := {}
	
	ADD OPTION aRotina TITLE "Pesquisar"  	ACTION 'PesqBrw' 			OPERATION 1 ACCESS 0
	ADD OPTION aRotina TITLE "Lista Cupons"	ACTION "U_DBBXLT02"			OPERATION 2 ACCESS 0
	ADD OPTION aRotina TITLE "Simular"		ACTION "U_DBBXLT03"			OPERATION 3 ACCESS 0
	
Return aRotina

//-------------------------------------------------------------------
// Lista de cupons 
//-------------------------------------------------------------------

User Function DBBXLT02()

	Alert("Teste")
Return


//-------------------------------------------------------------------
// Simular 
//-------------------------------------------------------------------

User Function DBBXLT03()

Local oOK := LoadBitmap(GetResources(),'br_verde')
Local oNO := LoadBitmap(GetResources(),'br_vermelho')  

	DEFINE DIALOG oDlg TITLE "Exemplo TWBrowse" FROM 180,180 TO 900,1400 PIXEL	    

		oBrowse := TWBrowse():New( 01 , 01, 400,300,,{'','Data','Banco','Agencia','Conta','Adm Finan','Valor'},{20,30,30},;                              
		oDlg,,,,,{||},,,,,,,.F.,,.T.,,.F.,,, )    
		
		aBrowse   := {	{.T.,'CLIENTE 001','RUA CLIENTE 001','BAIRRO CLIENTE 001','BAIRRO CLIENTE 001','BAIRRO CLIENTE 001'},;                    
						{.F.,'CLIENTE 002','RUA CLIENTE 002','BAIRRO CLIENTE 002','BAIRRO CLIENTE 001','BAIRRO CLIENTE 001'},;
						{.F.,'CLIENTE 002','RUA CLIENTE 002','BAIRRO CLIENTE 003','BAIRRO CLIENTE 001','BAIRRO CLIENTE 001'},;                    
						{.F.,'CLIENTE 002','RUA CLIENTE 002','BAIRRO CLIENTE 004','BAIRRO CLIENTE 001','BAIRRO CLIENTE 001'},;
						{.F.,'CLIENTE 002','RUA CLIENTE 002','BAIRRO CLIENTE 005','BAIRRO CLIENTE 001','BAIRRO CLIENTE 001'},;
						{.T.,'CLIENTE 003','RUA CLIENTE 003','BAIRRO CLIENTE 006','BAIRRO CLIENTE 001','BAIRRO CLIENTE 001'} }    
		
		oBrowse:SetArray(aBrowse)    
		oBrowse:bLine := {||{If(aBrowse[oBrowse:nAt,01],oOK,oNO),;
								aBrowse[oBrowse:nAt,02],;                      
								aBrowse[oBrowse:nAt,03],;
								aBrowse[oBrowse:nAt,04],;
								aBrowse[oBrowse:nAt,05],;
								aBrowse[oBrowse:nAt,06] } }    
		
		// Troca a imagem no duplo click do mouse    
		oBrowse:bLDblClick := {|| aBrowse[oBrowse:nAt][1] := !aBrowse[oBrowse:nAt][1], oBrowse:DrawSelect()}  
		
		@ 400,05 BUTTON oBtn1 PROMPT 'Sair' ACTION ( oDlg:End() ) SIZE 40, 013 OF oDlg PIXEL

	ACTIVATE DIALOG oDlg CENTERED 
	
Return