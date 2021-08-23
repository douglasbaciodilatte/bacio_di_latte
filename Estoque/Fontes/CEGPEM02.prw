#include 'protheus.ch'
#include 'parmtype.ch'
#Include "Protheus.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} CEGPEM02
// 				Exibe tela para usuário selecionar as Empresas/Filiais, servindo
				como filtro a rotinas e relatórios.
@author 		Eduardo Pessoa
@since 			31/07/2019
@version 		1.0
@type 			User function
@example		u_CEGPEM02(_lCheckUser, _lAllEmp, _lOnlySelect, _aRetInfo)
@param  		_lCheckUser	, Lógico, Indica se exibirá apenas as filiais que o usuário possui acesso. Valor default: .T.
@param  		_lAllEmp 	, Lógico, Indica se exibirá todas as empresas do grupo ou apenas unidade de negócio e filiais da empresa logada. Valor default: .F.
@param  		_lOnlySelect, Lógico, Indica se o retorno da função irá considerar todos registros apresentados ou apenas os registros marcados. Valor default: .T.
@param  		_aRetInfo 	, Array , Indica os campos que serão retornados no término da rotina. 
@param  							  Valor Default: { 'FLAG', 'SM0_CODFIL', 'SM0_NOMRED', 'SM0_CGC', 'SM0_INSC', 'SM0_INSCM' }

@return 		_aInfoRet	, Array , Array Multi-Dimencional com informações solicitadas no Parâmetro: _aRetInfo com as filiais selecionada(s). 
@return 							  A estrutura de retorno respeita os parâmetros informados. 
@return								  Valor Default: { 	'FLAG', 'SM0_CODFIL', 'SM0_NOMRED', 'SM0_CGC', 'SM0_INSC', 'SM0_INSCM' }
@return			Posição '01'						  	'FLAG' - indica se o registro foi marcado ou não
@return			Posição '02'							'SM0_CODFIL' - Código completo da filial
@return			Posição '03'							'SM0_EMPRESA'- Código da empresa
@return			Posição '04'							'SM0_UNIDNEG'- Código da unidade de negócio
@return			Posição '05'							'SM0_FILIAL' - Código da filial
@return			Posição '06'							'SM0_DESCEMP'- Nome da empresa
@return			Posição '07'							'SM0_NOMRED' - Nome da filial
@return			Posição '08'							'SM0_CGC' 	 - CNPJ
@return			Posição '09'							'SM0_INSC'   - Inscrição Estadual
@return			Posição '10'							'SM0_INSCM'  - Inscrição Municipal

@obs 			Exclusivo CIEE7
				Exemplos de uso: http://tdn.totvs.com/pages/releaseview.action?pageId=427052751
 /*/
 
User function CEGPEM02(_lCheckUser, _lAllEmp, _lOnlySelect, _aRetInfo )

Local _aInfoRet := {}
 
Default _lCheckUser := .T.
Default _lAllEmp	:= .F.
Default _lOnlySelect:= .T.
Default _aRetInfo   :=  { 'FLAG', 'SM0_CODFIL', 'SM0_NOMRED', 'SM0_CGC', 'SM0_INSC', 'SM0_INSCM' }
 
_aInfoRet := FwListBranches( _lCheckUser, _lAllEmp, _lOnlySelect, _aRetInfo ) 
	
Return _aInfoRet