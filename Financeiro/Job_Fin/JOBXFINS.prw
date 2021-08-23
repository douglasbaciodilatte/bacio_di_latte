#INCLUDE "Protheus.ch"

/*/
{Protheus.doc} JOBXFINS
Description

	Job Start Processo

@param xParam Parameter Description
@return Nil
@author  - Douglas R. Silva
@since 08/10/2019
/*/

User Function JOBXFINS()
	
  Local lret1 := .F.
  
  lret1 := Startjob("U_JOBXFIN1()",Getenvserver(),.T.,"Data Atual " + cvaltochar(date()))
  
  If !lret1
    Return -1
  Endif
    
Return