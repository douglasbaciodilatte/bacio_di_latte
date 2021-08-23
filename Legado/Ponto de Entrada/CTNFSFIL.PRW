#Include 'Protheus.ch'
#Include 'TbiConn.ch'

User Function CTNFSFIL()
 
Local cFilAux := ParamIxb[1]
Local lRet := .F.
 
If (cFilAux)->D2_ORIGLAN = "LO" .And. MV_PAR02 = 1
lRet := .T.
Elseif (cFilAux)->D2_ORIGLAN <> "LO" .And. MV_PAR02 = 2 
lRet := .T.
EndIf

Return lRet 
           
//O retorno falso não contabiliza.
