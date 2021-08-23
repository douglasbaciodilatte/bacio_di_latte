/*---------------------------------------------------------------------------------------
{Protheus.doc} IN210AL2
Rdmake Responsável pelo retorno de campos a serem gravados na tabela SL2 Loja
@class      Nao Informado
@from       Nao Informado
@param      _nRecno -> Registro relacionado ao PIO esta posicionado
			aAuxSL2 -> Array com o dados do item que serao gerados na tabela SL2
@attrib     Nao Informado
@protected  Nao Informado
@author     DAC - Denilso Almeida Carvalho
@Date     	17/01/2017
@version    P.11 - P.12
@since      Nao Informado  
@return     ARRAY
@sample     Nao Informado
@obs        Esta funcionalidade deve retornar um ARRAY bidimensional com duas posições ex {"CAMPO",CONTEUDO}
			Já esta posicionado o registro da tabela PIO e PIN
@project    Integração de arquivos - Motor de Integração
@menu       Nao Informado
@history    
			

---------------------------------------------------------------------------------------*/

User Function IN210AL2(_nRecPIO,aAuxSL2)

Local _aRet 	:= {}				//Array de retorno
Local _nPos		:= 0				//Variavel de tratamento para posicionamento no Array
Local _cEstacao	:= ""				//Estacao da Venda
Local _aArmPDV	:= {}				//Array contendo os dados de amarracao com a Estacao X PDV X  

Begin Sequence
	//Valor da Comissão do Vendedor
	If PIO->( FieldPos("PIO_XPCOMI") ) > 0	.and. SL2->( FieldPos("L2_XPCOMI") ) > 0 //Validando a Camada do Motor de Integração e verificando existência no Padrão do Campo		
		Aadd( _aRet, {"L2_XPCOMI"	, PIO->PIO_XPCOMI} ) 
	Endif
	//Valor da Comissão do Gerente
	If PIO->( FieldPos("PIO_XPCOMG") ) > 0	.and. SL2->( FieldPos("L2_XPCOMG") ) > 0  //Validando a Camada do Motor de Integração e verificando existência no Padrão do Campo				
		Aadd( _aRet, {"L2_XPCOMG"	, PIO->PIO_XPCOMI} ) 
	Endif
	//Percentual de Juros aplicado no item em caso de vendas financiadas 
	If PIO->( FieldPos("PIO_XJURFI") ) > 0	.and. SL2->( FieldPos("L2_XJURFI") ) > 0 //Validando a Camada do Motor de Integração e verificando existência no Padrão do Campo				
		Aadd( _aRet, {"L2_XJURFI"	, PIO->PIO_XPCOMI} ) 
	Endif

	//Filiais do Legado
	If PIO->( FieldPos("PIO_XFILEX") ) > 0	.and. SL2->( FieldPos("L2_XFILEX") ) > 0 //Validando a Camada do Motor de Integração e verificando existência no Padrão do Campo		
		Aadd( _aRet, {"L2_XFILEX"	, PIO->PIO_XFILEX} ) 
	Endif
	
	//Verifica se existe o Array do cabeçalho do Orcamento
	If Type("_aSL1") <> "U" .And. ValType(_aSL1) == "A"
		//Busca a posicao do campo de Operador no array
		If (_nPos := aScan(_aSL1,{|x| Alltrim(x[1]) == "L1_ESTACAO" })) > 0
			_cEstacao := _aSL1[_nPos][2]
			
			//Busca os dados de amarracao 
			_aArmPDV := U_BACAA011(_cEstacao)                 					
			/*==============================\
			|	Elementos do array _aArmPDV	|
			|_aArmPDV[1] - Deposito			|
			|_aArmPDV[2] - Centro de Custo	| 
			|_aArmPDV[3] - Conta Corrente	|
			\==============================*/
		EndIf
	EndIf

	//Verifica se existe amarracao para a Estacao X PDV X Centro de Custo X Conta Corrente
	If Len(_aArmPDV) > 0
		//Verifica se existe o Array do cabeçalho do Orcamento
		If ValType(aAuxSL2) == "A"
			//Busca a posicao do campo de Deposito no array
			If (_nPos := aScan(aAuxSL2,{|x| Alltrim(x[1]) == "L2_LOCAL" })) > 0
				aAuxSL2[_nPos][2] := _aArmPDV[1]
			EndIf
			
			//Busca a posicao do campo de Centro de Custo no array
			If (_nPos := aScan(aAuxSL2,{|x| Alltrim(x[1]) == "L2_XCCUSTO" })) > 0
				aAuxSL2[_nPos][2] := _aArmPDV[2]
			ElseIf SL2->( FieldPos("L2_XCCUSTO") ) > 0
				Aadd( _aRet, {"L2_XCCUSTO"	, _aArmPDV[2] } ) 
			EndIf
			
			//Busca a posicao do campo Vendedor no ARRAY
			If (_nPos := aScan(aAuxSL2,{|x| Alltrim(x[1]) == "L2_VEND" })) > 0
				aAuxSL2[_nPos][2] := _aArmPDV[1]
			ElseIf SL2->( FieldPos("L2_VEND") ) > 0
				Aadd( _aRet, {"L2_VEND"	, _aArmPDV[1] } ) 
			EndIf
		EndIf
	EndIf
End Sequence

Return _aRet 
