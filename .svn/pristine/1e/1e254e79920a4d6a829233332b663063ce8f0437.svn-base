#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

User Function BACAA040(_cEmp,_cFil)

Local _cJob			:= ""
Local _oLocker
Local _cQry			:= ""
Local _cAlias		:= ""
Local _nQtdRep		:= 0
Local _lL1_ANOFVEI	:= .F.

Default _cEmp	:= "01"
Default _cFil	:= "0001"

//Prepara o ambiente
RpcSetType(3)
RpcSetEnv(_cEmp, _cFil)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica se o JOB ja esta executando.³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
_cJob := "BACAA040"
_oLocker := LJCGlobalLocker():New()
If !_oLocker:GetLock( _cJob )
	Conout(" * * " + DtoC(dDataBase) + " " + Time() + " - <<< " + _cJob + " >>> Processo ja esta em execucao.")
	RpcClearEnv()
	Return
EndIf

//SELECT para filtrar os dados
_cAlias		:= GetNextAlias()

//Busca os registros que estao com "ER" e que estao com status diferente com "6"
_cQry := "SELECT L1_FILIAL, L1_NUM, L1_DOC, L1_SERIE, L1_EMISNF, L1_XCODEX, PIN_STAIMP, PIN.R_E_C_N_O_ RECPIN"
_cQry += "  FROM " + RetSqlName("SL1") + " L1"
_cQry += " INNER JOIN " + RetSqlName("PIN") + " PIN ON PIN_FILIAL = L1_FILIAL AND PIN_XCODEX = L1_XCODEX AND L1.D_E_L_E_T_ = ' ' AND PIN_STAIMP <> '6'"
_cQry += " WHERE L1_SITUA = 'ER'"
_cQry += "   AND L1.D_E_L_E_T_ = ' '"
DbUseArea( .T., "TOPCONN", TcGenQry(,,_cQry), _cAlias, .T., .F. )

dbSelectArea("PIN")

While !(_cAlias)->( Eof() )
	PIN->( dbGoTo( (_cAlias)->RECPIN ) )
	
	RecLock("PIN",.F.)
	PIN->PIN_STAIMP := "6"
	PIN->( MsUnLock() )
	
	(_cAlias)->( dbSkip() )
End

//Fecha o Alias 
(_cAlias)->( dbCloseArea() )

//Busca os registros que estao diferente de "ER" e que estao com status igual a "6"
_cQry := "SELECT L1_FILIAL, L1_NUM, L1_DOC, L1_SERIE, L1_EMISNF, L1_XCODEX, PIN_STAIMP, PIN.R_E_C_N_O_ RECPIN"
_cQry += "  FROM " + RetSqlName("SL1") + " L1"
_cQry += " INNER JOIN " + RetSqlName("PIN") + " PIN ON PIN_FILIAL = L1_FILIAL AND PIN_XCODEX = L1_XCODEX AND L1.D_E_L_E_T_ = ' ' AND PIN_STAIMP IN ('6','1')"
_cQry += " WHERE L1_SITUA <> 'ER'"
_cQry += "   AND L1_DOC <> '         '"
_cQry += "   AND L1.D_E_L_E_T_ = ' '"
DbUseArea( .T., "TOPCONN", TcGenQry(,,_cQry), _cAlias, .T., .F. )

dbSelectArea("PIN")

While !(_cAlias)->( Eof() )
	PIN->( dbGoTo( (_cAlias)->RECPIN ) )
	
	RecLock("PIN",.F.)
	PIN->PIN_STAIMP := "5"
	PIN->( MsUnLock() )
	
	(_cAlias)->( dbSkip() )
End

//Fecha o Alias 
(_cAlias)->( dbCloseArea() )

//libera a variavel global para uma nova execucao
_oLocker:ReleaseLock( _cJob )

//Limpa o Ambiente
RpcClearEnv()

Return