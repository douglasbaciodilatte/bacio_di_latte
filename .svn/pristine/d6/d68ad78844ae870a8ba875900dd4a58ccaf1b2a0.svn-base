#include "PROTHEUS.CH"
#include "RWMAKE.CH"


User Function MBRWBTN()  

local cReturn := .T.             		
//Local cUserlogado := FWLeUserlg(__cUserID,1)  
Local cUserlogado := UsrRetName(RetCodUsr()) 



IF UPPER(SubStr( trim(cUserlogado), 1, 2 )) == "LJ" .AND. cFilAnt == "0031" .AND. AllTrim(FunName()) != "MATA311" 
	cReturn := .F.
	MSGALERT("Na filial do CD é permitido apenas incluir solicitação de transferência. Acesse sua filial para uso das demais rotinas!.","Milano - MBRWBTN ")
	
ENDIF
  
Return cReturn