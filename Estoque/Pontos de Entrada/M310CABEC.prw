#include "PROTHEUS.CH"
#include "RWMAKE.CH"


User Function M310CABEC() 
  
Local aArea    := GetArea()
Local _cFunc   := PARAMIXB[1]
Local _aCabec  := PARAMIXB[2]
Local cMennota := "Entrega em: "   
Local cArmloja := ""
LOCAL cFildest := ""     
Local _nPos	   := 0      
                                        
	//Alterar a esp�cie da pr�-nota (NF p/SPED ), gerada a partir da solicita��o de transfer�ncia.
	If Alltrim(_cFunc) $ "MATA103"
		If  (_nPos := aScan(_aCabec,{|x| Alltrim(x[1]) == "F1_ESPECIE" })) <> 0
			_aCabec[_nPos][2] := "SPED"
		EndIf

	EndIf
	
	//inclui o nome na loja nos dados adicionais da nota    
	If Alltrim(_cFunc) $ 'MATA410'                                  
	
		NNT->(dbSelectArea("NNT"))
		NNT->(dbSetOrder(1))   
		
		If NNT->(dbSeek( xFilial("NNT") + NNS->NNS_COD))		
			  
			cFildest := NNT->NNT_FILDES   
			cArmloja := NNT->NNT_LOCLD  
		
		    NNR->( dbSelectArea("NNR"))
	   		NNR->( dbSetOrder(1))
			If NNR->( dbSeek( cFildest + cArmloja ) )    
			
				cMennota += Alltrim( NNR->NNR_DESCRI ) + " Cod. Transf.: " + Alltrim(NNT->NNT_COD) 
	  			Aadd( _aCabec,{'C5_MENNOTA',UPPER( cMennota )	,Nil})
				Aadd( _aCabec,{'C5_TPFRETE',NNS->NNS_XTPFRE		,Nil})  
				Aadd( _aCabec,{'C5_XSOLTRA',NNS->NNS_COD		,Nil})
						
	    		
			EndIf  
		  	
		EndIf    
	
	EndIf 

RestArea(aArea)

Return(_aCabec)
