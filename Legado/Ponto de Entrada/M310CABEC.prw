#include "PROTHEUS.CH"
#include "RWMAKE.CH"


User Function M310CABEC() 
  
Local aArea    := GetArea()
Local _cFunc   := ParamIxb[1]
Local _aCabec  := PARAMIXB[2]
Local cMennota := "Entreg em: "   
Local cArmloja := ""
LOCAL cFildest := ""     
Local _nPos	   := 0      
                            
// alterar a esp?cie da pr?-nota (NF p/SPED ), gerada a partir da solicita??o de transfer?ncia.
If Alltrim(_cFunc) $ "MATA103|MATA140"
	If  (_nPos := aScan(_aCabec,{|x| Alltrim(x[1]) == "F1_ESPECIE" })) <> 0
		_aCabec[_nPos][2] := "SPED"
	EndIf
EndIf


//inclui o nome na loja nos dados adicionais da nota    
IF Alltrim(_cFunc) == 'MATA410'                                  

	//nBDL_vol := u_BdilVols() em valida??o
	
	dbselectarea("NNT")
	dbsetorder(1)   
	if dbseek( xFilial("NNT") + NNS->NNS_COD)		
	
	  
		cFildest := NNT_FILDES   
		cArmloja := NNT->NNT_LOCLD  

	    dbselectarea("NNR")
   		dbsetorder(1)
		if dbseek( cFildest+cArmloja)    
		
			cMennota += Alltrim(NNR->NNR_DESCRI) + " Cod. Transf.: "+ Alltrim(NNT->NNT_COD) 
  			aadd(_aCabec,{'C5_MENNOTA',cMennota,Nil})  		
    		
		ENDIF  
	  	
	ENDIF    
	
ENDIF 

RestArea(aArea)

Return(_aCabec)
                                       



/*BEGINDOC
//???????????????????????????????????????????????????????Ŀ
//?Monta tela para ser inforamado a quantidade de volumes.?
//?????????????????????????????????????????????????????????
ENDDOC*/


User Function BdilVols()
Local Confirmar
Local oGet1
Local nGet1 := 0
Local oSay1
Static oDlg

  DEFINE MSDIALOG oDlg TITLE "Volumes para Nota" FROM 000, 000  TO 200, 400 COLORS 0, 16777215 PIXEL

    @ 045, 048 BUTTON Confirmar PROMPT "Confirmar" SIZE 037, 012 OF oDlg PIXEL Action oDlg:End() 
    @ 024, 118 MSGET oGet1 VAR nGet1 SIZE 030, 010 OF oDlg PICTURE "99999" COLORS 0, 16777215 PIXEL
    @ 024, 013 SAY oSay1 PROMPT "Informe a quantidade de volumes." SIZE 089, 007 OF oDlg COLORS 0, 16777215 PIXEL

  ACTIVATE MSDIALOG oDlg CENTERED
  


Return(nGet1)
