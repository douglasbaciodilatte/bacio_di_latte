#include 'protheus.ch'
#include 'parmtype.ch'
#INCLUDE "TopConn.ch"

user function BLESTFINV()

  	Local aPergs 	 := {}
    Local aRet      := {}

    aAdd( aPergs, {1,"Filial"  			        ,Space(4),"","","SM0","",50,.F.})
    aAdd( aPergs, {1,"Armazem" 			        ,Space(6),"","","NNR","",50,.F.})
    aAdd( aPergs, {1,"Data Inventario?"			,Ctod(Space(8)),"","","","",50,.F.})
    aAdd( aPergs, {1,"Documento"    			,Space(9),"","","","",50,.F.})
    
    If ParamBox(aPergs ,"Parametros ",aRet)
        processa( {|| xDELINV01() } ,'Aguarde excluindo Inventario...' )
    EndIf

	MsgInfo("Inventario excluído com sucesso " + MV_PAR04 )

Return

/*/{Protheus.doc} xDELINV01
   Deletar Inventario
   @author  Nome
   @table   Tabelas
   @since   23-01-2020
/*/

Static Function xDELINV01()

  	Local nStatus

	TCLink()

	cQuery := " UPDATE "+RetSQLName("SB7")+"  SET D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ " + CRLF
	 cQuery += " WHERE B7_FILIAL = '"+MV_PAR01+"' " + CRLF
	cQuery += "     AND B7_LOCAL = '"+MV_PAR02+"' " + CRLF
    cQuery += "     AND B7_DATA = '"+DTOS(MV_PAR03)+"' " + CRLF
	cQuery += "     AND B7_DOC = '"+MV_PAR04+"' " + CRLF
	cQuery += "     AND D_E_L_E_T_ != '*' " + CRLF
						
	nStatus := TCSqlExec( cQuery )
	
	if (nStatus < 0)
		conout("TCSQLError() " + TCSQLError())
	endif
	
	TCUnlink()

return
