#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"

User Function MT140TOK

Local lRetorno := PARAMIXB[1]  
Local lRet     :=.T.   //..Customização do cliente
Local cTPRO    := SuperGetMv('MV_BDTIPRO',,'MC/SV')    
Local cMforn   := SuperGetMv('MV_BDLFOR',,'07XPHH')
Local cMret    := ""             
//Local cFornec  := CA100FOR
LOCAL nX       := 0


If cModulo == "EIC" .Or. AllTrim(FunName()) == "MATA310"
	Return(.T.)
EndIf  

IF CA100FOR $ cMforn  
	Return(.T.)
EndIf  


For nX :=1 to Len(aCols)

	If !aCols[nX][Len(aHeader)+1] // Deletado

				IF EMPTY(aCols[nX][gdfieldpos("D1_PEDIDO")])              
				
					dbSelectArea("SB1")
					dbSetOrder(1) 
						IF MsSeek(XFilial("SB1") + aCols[nX][gdfieldpos("D1_COD")] )
																
								IF  !(B1_TIPO $ cTPRO)
							    	 //cMret += "O Produto: "+ B1_DESC + " Tipo: " + B1_TIPO + Chr(13)+Chr(10)     
							    	  cMret += "O Produto: "+  PADR( B1_DESC, TAMSX3("B1_DESC")[1] ) + " Tipo: " + B1_TIPO + Chr(13)+Chr(10)

								ENDIF
						EndIf
				

		
				EndIf
	
	EndIf

	
	
Next nX


IF !EMPTY(cMret)
	lRet := .F.
	MSGALERT("E necess�rio vincular o pedido de compra nos itens:!"+ Chr(13)+Chr(10) + Chr(13)+Chr(10)+ cMret + Chr(13)+Chr(10) + Chr(13)+Chr(10)+ ;
	 "Parametros da rotina: MV_BDTIPRO - MV_BDLFOR","Milano - MT140TOK") 
ENDIF


Return lRet
