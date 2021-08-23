#Include 'Protheus.ch'
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �NOVO3     �Autor  �Andre Sarraipa      � Data �  11/12/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ajusta o Status da solicita��o de transferencia finsalizada ���
���          �indevidamente pois n�o tem doc                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Bacio                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/



User Function AJUSTNNS()

Local cNumSt  := ""
LOCAL cStat   := .F.
Local cNundc  := ""

Private cPerg 	 := "AJTNNS"


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//Criacao e apresentacao das perguntas      ?
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
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