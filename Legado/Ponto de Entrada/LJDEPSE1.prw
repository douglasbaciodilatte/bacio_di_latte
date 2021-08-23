#Include 'protheus.ch'

/*---------------------------------------------------------------------------------------
{Protheus.doc} LJDEPSE1
@class      Nao Informado
@from       Nao Informado
@param      Nao Informado
@attrib     Nao Informado
@protected  Nao Informado
@author     TOTVS
@Date     	20/03/2017
@version    P.12
@since      Nao Informado  
@return     NIL
@sample     Nao Informado
@obs        Ponto de Entrada para atualizar campos do contas a receber
@project    Integração de arquivos - Motor de Integração
@menu       Nao Informado
@history    
---------------------------------------------------------------------------------------*/

User Function LJDEPSE1()

Local _aReceb	:= ParamIXB[1]
Local _aDados	:= {}
Local _cCCusto	:= ""
Local _cAgencia	:= ""
Local _cConta	:= ""

ConOut("LJDEPSE1 - Inicio")

If !Empty(SL1->L1_ESTACAO)
	_aDados := U_BACAA011(SL1->L1_ESTACAO)
	
	ConOut("LJDEPSE1 - Filial: " + SL1->L1_FILIAL + " Orcamento: " + SL1->L1_NUM + " Estacao: " + SL1->L1_ESTACAO)
		
	/*==============================\
	| Elementos do Array _aDados	|
	|-------------------------------|
	|_aDados[1] - Deposito			|
	|_aDados[2] - Centro de Custo	|
	|_aDados[3] - Conta Corrente	|
	\==============================*/

	If Alltrim(SL1->L1_OPERADO) <> Alltrim(SuperGetMV("ES_CXAFIL",,"CXA"))
		RecLock("SL1",.F.)
		SL1->L1_OPERADO := Alltrim(SuperGetMV("ES_CXAFIL",,"CXA"))
		SL1->( MsUnLock() )
	EndIf
	
	If Len(_aDados) > 0
		If !Empty(_aDados[3])
			ConOut("LJDEPSE1 - Pesquisa o banco: " + xFilial("SA6") + SL1->L1_OPERADO + PadR(cFilAnt,TamSX3("A6_AGENCIA")[1]) + _aDados[3])
			dbSelectArea("SA6")
			dbSetorder(1)	//A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
			If SA6->( dbSeek( xFilial("SA6") + SL1->L1_OPERADO + PadR(cFilAnt,TamSX3("A6_AGENCIA")[1]) + _aDados[3] ) )
				_cAgencia	:= SA6->A6_AGENCIA
				_cConta		:= SA6->A6_NUMCON
			EndIf
		EndIf	 
		If !Empty(_aDados[2])
			ConOut("LJDEPSE1 - Centro de Custo: " + _aDados[2])
			_cCCusto := _aDados[2]
		EndIf
	EndIf 
	
	If !Empty(_cCCusto) .Or. !Empty(_cAgencia) .Or. !Empty(_cConta) 
		RecLock("SE1",.F.)
		SE1->E1_CCUSTO	:= _cCCusto
		SE1->E1_AGEDEP	:= _cAgencia
		SE1->E1_CONTA	:= _cConta
		SE1->( MsUnLock() )
		ConOut("LJDEPSE1 - Atualizou o SE1: E1_CCUSTO: " + SE1->E1_CCUSTO + " E1_AGEDEP: " + SE1->E1_AGEDEP + " E1_CONTA: " + SE1->E1_CONTA) 
	EndIf
EndIf

//Limpa o filtro do banco - Filtro realizado no fonte LJ010SF3
//dbSelectArea("SA6")
//SET FILTER TO
	
Return