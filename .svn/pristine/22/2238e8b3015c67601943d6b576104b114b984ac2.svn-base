#Include "Protheus.ch"
#Include "TopConn.ch"    
#include "apwebsrv.ch"
#include "apwebex.ch"
#include "ap5mail.ch"    


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FA290     ºAutor  ³Andre Sarraipa      º Data ³  02/14/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Executado durante a gravação dos dados da fatura no SE2     ±±
±±º          ³ Grava o centro de custo do titulo na fatura                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

 

 
User Function FA290()       

LOCAL cQuery   :=""
LOCAL aCustbdl :=""   
LOCAL aHistndl :=""                                                       

cQuery := " SELECT TOP 1 E2_CCUSTO,E2_HIST FROM " + RetSqlName("SE2") + " E2 WHERE D_E_L_E_T_='' "
cQuery += " AND E2_FATPREF = '"+SE2->E2_PREFIXO+"' AND E2_FATURA= '"+SE2->E2_NUM+"'  AND E2_FATFOR= '"+SE2->E2_FORNECE+"' "
cQuery += " AND E2_FATLOJ= '"+SE2->E2_LOJA+"'  "
cQuery += " ORDER BY  E2_PREFIXO, E2_NUM  "
 
//fecha o alias temporário 
If Select("RESCCUSTO") > 0 
     dbSelectArea("RESCCUSTO") 
     dbCloseArea() 
EndIf 

cQuery := changequery(cQuery) 
dbUsearea(.T.,"TOPCONN",TCGenQry(,,cQuery), "RESCCUSTO")    

aCustbdl := RESCCUSTO->E2_CCUSTO         
aHistndl := RESCCUSTO->E2_HIST  
 
	
SE2->E2_CCUSTO := aCustbdl     
SE2->E2_HIST      := aHistndl          

Return