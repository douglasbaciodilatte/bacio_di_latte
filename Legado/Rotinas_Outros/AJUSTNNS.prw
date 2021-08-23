#Include 'Protheus.ch'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO3     ºAutor  ³Andre Sarraipa      º Data ³  11/12/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ajusta o Status da solicitação de transferencia finsalizada º±±
±±º          ³indevidamente pois não tem doc                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/



User Function AJUSTNNS()

Local cNumSt  := ""
LOCAL cStat   := .F.
Local cNundc  := ""

Private cPerg 	 := "AJTNNS"


//ÃšÃ„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Â¿
//Criacao e apresentacao das perguntas      ?
//Ã€Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã„Ã™
putSx1(cPerg, '01', 'Sol. Transferencia.'         , '', '', 'mv_ch1', 'C', 10, 0, 0, 'G', '', '', '', '', 'mv_par01')
                                                                   

//Pergunte(cPerg, .T.)       

If !pergunte(cPerg,.T.)
     Return
EndIf

IF EMPTY(MV_PAR01)
   
    MSGALERT("Informe um numero da solicitacao")
	return()

EndIf

cNumSt := MV_PAR01


NNT->( dbSetOrder(1) )
NNT->( dBSeek(xFilial('NNT')+cNumSt) )     


While !( NNT->( EOF() ) ) .And. NNT->NNT_COD == cNumSt // .And. EMPTY(NNT->NNT_DOC)      

       if EMPTY(NNT->NNT_DOC)

	    	cStat   := .T.   
	    	
	    else
	    	            
	  		cNundc := NNT->NNT_DOC
	  		
		endif
		
		NNT->(DbSkip())
EndDo
                                    
                                    
if  !EMPTY(cNundc)     
    
    MSGALERT("A solicitacao: "+cNumSt+" esta vinculada a nota: "+cNundc+" nao pode sofrer alteracao!")
	return()
	
endif                                                    
         


NNS->(DbSetOrder(1))
If cStat .And. NNS->(DbSeek(xFilial("NNS")+cNumSt)) .AND. NNS->NNS_STATUS != "1"               
	RecLock("NNS",.F.)
	NNS->NNS_STATUS := '1'
	MsUnlock()
	MsgInfo ("Solicitacao: "+cNumSt+" - Status ajustado!")
EndIf


return()