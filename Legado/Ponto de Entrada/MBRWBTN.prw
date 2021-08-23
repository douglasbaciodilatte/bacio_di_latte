#include "PROTHEUS.CH"
#include "RWMAKE.CH"


User Function MBRWBTN()  

local cReturn := .T.             		
//Local cUserlogado := FWLeUserlg(__cUserID,1)  
Local cUserlogado := UsrRetName(RetCodUsr()) 



IF UPPER(SubStr( trim(cUserlogado), 1, 2 )) == "LJ" .AND. cFilAnt == "0031" .AND. !AllTrim(FunName()) $ "MATA311/BDTRANSF" 
	cReturn := .F.
	MSGALERT("Na filial do CD � permitido apenas incluir solicita��o de transfer�ncia. Acesse sua filial para uso das demais rotinas!.","Milano - MBRWBTN ")
	
ENDIF
  
Return cReturn
