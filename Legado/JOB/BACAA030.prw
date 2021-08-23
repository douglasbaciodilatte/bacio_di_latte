#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

User Function BACAA030(_cEmp,_cFil)

Local _cJob			:= ""
Local _oLocker
Local _cQry			:= ""
Local _cAlias		:= ""
Local _nQtdRep		:= 0
Local _nSlpProc		:= (1000 * 120) //1000 igual a 1 segundo e 120 para 2 minutos
Local _lL1_ANOFVEI	:= .F.

Default _cEmp	:= "01"
Default _cFil	:= "0001"

//Prepara o ambiente
RpcSetType(3)
RpcSetEnv(_cEmp, _cFil)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//?erifica se o JOB ja esta executando.?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
_cJob := "BACAA030"
_oLocker := LJCGlobalLocker():New()
If !_oLocker:GetLock( _cJob )
	Conout(" * * " + DtoC(dDataBase) + " " + Time() + " - <<< " + _cJob + " >>> Processo ja esta em execucao.")
	RpcClearEnv()
	Return
EndIf

//SELECT para filtrar os dados
_cAlias		:= GetNextAlias()
_nQtdRep	:= SuperGetMV("ES_NREPRER",,5)
_lL1_ANOFVEI:= SL1->( FieldPos("L1_ANOFVEI") ) > 0 

_cQry := "SELECT R_E_C_N_O_ RECTAB FROM " + RetSqlName("SL1")
_cQry += " WHERE L1_SITUA = 'ER'"
_cQry += "   AND D_E_L_E_T_ = ' '"
If _lL1_ANOFVEI
	_cQry += "   AND L1_ANOFVEI < " + cValToChar(_nQtdRep)
EndIf
DbUseArea( .T., "TOPCONN", TcGenQry(,,_cQry), _cAlias, .T., .F. )

dbSelectArea("SL1")

While !(_cAlias)->( Eof() )
	SL1->( dbGoTo( (_cAlias)->RECTAB ) )
	
	RecLock("SL1",.F.)
	SL1->L1_SITUA 	:= "RX"
	
	If _lL1_ANOFVEI
		SL1->L1_ANOFVEI := SL1->L1_ANOFVEI + 1
	EndIf
	
	SL1->( msUnLock() )
	
	(_cAlias)->( dbSkip() )
End

//Fecha o Alias 
(_cAlias)->( dbCloseArea() )

//Sleep para aguardar o processamento
Sleep(_nSlpProc)

//libera a variavel global para uma nova execucao
_oLocker:ReleaseLock( _cJob )

//Limpa o Ambiente
RpcClearEnv()

Return