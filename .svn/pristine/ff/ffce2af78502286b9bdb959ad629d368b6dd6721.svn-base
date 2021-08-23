/*---------------------------------------------------------------------------------------
{Protheus.doc} IN210AL2
Rdmake Responsável por gravar/alterar status para cancelamento dos cupons Cupom Fiscal/TAF/NFCe
@class      Nao Informado
@from       Nao Informado
@param      _nRegPIN -> quando vindo da importação Camada deverá ser preenchido, quando do Gravabath o mesmo não vira preenchido
@attrib     Nao Informado
@protected  Nao Informado
@author     Rafael Rosa
@Date     	06/03/2017/01/2017
@version    P.12
@since      Nao Informado  
@return     ARRAY
@sample     Nao Informado
@obs        Devido as alterações demandadas pelo cancelamento foram alterados os indices da camada sendo necessário rodar o UPD UPDIVAR2 indice PIN_002 será atualizado
@project    Integração de arquivos - Motor de Integração/Gravabath
@menu       Nao Informado
@history    Alterado Incluido consistencia para trabalhar com Camada e Gravabath controlado pelo _nRegPIN DAC - Denilso Almeida Carvalho 07/03/2017
			

---------------------------------------------------------------------------------------*/


#Include 'Protheus.ch'

User Function LJ7051(_nRegPIN)
Local _aArea	:= GetArea()
Local _aAreaSL1	:= SL1->( GetArea() )
Local _aAreaPIN	:= PIN->( GetArea() )
Local _aAreaSF2	:= SF2->( GetArea() )
Local _lRet     := .T.       

Default _nRegPin := 0
CONOUT("LJ7051 Acessou")

Begin Sequence
	//Quando esta informado o recno do PIN esta vindo da camada posicionar PIN e SL1 ja esta posicionado
	                                         
	//Quando chamado do Gravabath deve posicionar PIN
	PIN->(DbOrderNickName("PIN_002") )   //PIN_FILIAL+PIN_XCODEX+PIN_STAIMP
	If !PIN->( dbSeek( xFilial("PIN") + SL1->L1_XCODEX) )
		CONOUT("LJ7051 não localizou PIN com XCODEX "+ SL1->L1_XCODEX)
		_lRet := .F. 
		Break
	EndIf
	
	CONOUT("LJ7051 localizou PIN com XCODEX "+ SL1->L1_XCODEX)
	
	/*==========================================================================\
	|								Novos status								|
	|---------------------------------------------------------------------------|
	|Status	Descrição													Tipo	|
	|---------------------------------------------------------------------------|
	|Branco	Disponível para processamento								Legado	|
	|1		Processado corretamente										Legado	|
	|2		Descontinuado												Legado	|
	|3		Erro no processamento										Legado	|
	|4		Erro por dependência de outro processo 						Legado	|
	|5		JOB LJGRVBATCH processado corretamente (Venda explodiu)		Novo	|
	|6		JOB LJGRVBATCH erro de processamento (Venda não explodiu)	Novo	|
	|7		JOB LJCANCNFCE Cancelamento efetuado						Novo	|
	|8		JOB LJCANCNFCE Erro no cancelamento							Novo	|
	\==========================================================================*/
	
	CONOUT("LJ7051 PIN->PIN_STAIMP era "+ PIN->PIN_STAIMP)
	
	RecLock("PIN",.F.)
	PIN->PIN_STAIMP := IIF(SL1->L1_SITUA == "ER","6","5")
	PIN->( MsUNLock() )
	
	CONOUT("LJ7051 PIN->PIN_STAIMP ficou "+ PIN->PIN_STAIMP)

End Begin

RestArea(_aArea)
RestArea(_aAreaSL1)
RestArea(_aAreaPIN)
RestArea(_aAreaSF2)

Return _lRet