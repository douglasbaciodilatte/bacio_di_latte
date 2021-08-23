#include "protheus.ch"
#include "topconn.ch"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �XAJTSX    �Autor  �Rodolfo Vacari      � Data �  09/02/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function xAjtSX() 
cDir	:= "\DIRDOC"
cALIAS	:= "TRB"
cMsg 	:= ""
cMsgx	:= ""                        
aMsg1 	:= {}

dbSelectArea("SX7")
dbSetOrder(1)
SX7->(dbGotop())

ProcRegua(SX7->(RecCount())*5)

aSX7 := {}
aDel := {}

While !SX7->(Eof())
	IncProc("SX7 : "+SX7->X7_CAMPO+SX7->X7_SEQUENC)
	if Ascan(aSX7,{|x| x[1]+x[2] == SX7->X7_CAMPO+SX7->X7_SEQUENC}) == 0
		Aadd(aSX7,{SX7->X7_CAMPO,SX7->X7_SEQUENC})
	Else
		Aadd(aDel,{SX7->X7_CAMPO,SX7->X7_SEQUENC})
	Endif
	dbSelectArea("SX7")
	SX7->(dbSkip())
End

cMsg += "Corre��o SX7 Gatilho duplicado:<br>"

dbSelectArea("SX7")
dbSetOrder(1)
ProcRegua(Len(aDel))

For i:= 1 To Len(aDel)
	IncProc("SX7 Deletando: "+aDel[i][1]+aDel[i,2])
	If dbSeek(aDel[i,1]+aDel[i,2])
		cMsg := SX7->X7_CAMPO+"-"+SX7->X7_SEQUENC+"<br>"
		RecLock("SX7",.F.)
		DbDelete()
		MsUnlock()
	EndIf
	SX7->(dbSkip())
Next 

cMsg	+= "<br><br>"
cMsg  	:= ""
cMsg2 	:= ""
aMsg1 	:= {}

if !Empty(cMsg2)
	Aadd(aMsg1,cMsg2)
	cMsg2 := ""
Endif

cMsg += "<br><br>"
cMsg := ""

dbSelectArea("SXG")
dbSetOrder(1)

dbSelectArea("SX3")
dbSetOrder(1)

ProcRegua(SX3->(RecCount()))
SX3->(dbGotop())

cMsg += "Corre��o SX3 X3_GRPSXG:<br>"

While !SX3->(Eof())
	IncProc("SX3 GRUPO: "+SX3->X3_CAMPO)
	If !Empty(SX3->X3_GRPSXG) .And. SXG->( dbSeek(SX3->X3_GRPSXG,.T.) )
		If 	SX3->X3_TAMANHO <> SXG->XG_SIZE
			cMsg := SX3->X3_CAMPO+"-"+SX3->X3_GRPSXG+"<br>"
		  	SX3->(RecLock("SX3",.f.))
			SX3->X3_TAMANHO:= SXG->XG_SIZE
			SX3->( MsUnlock() )
		Endif
	Endif
	dbSelectArea("SX3")
	SX3->(dbSkip())
End

dbSelectArea("SX2")
dbSetOrder(1)

dbSelectArea("SX3")
dbSetOrder(1)

dbSelectArea("SIX")
dbSetOrder(1)

cMsg += "Ajuste X1_TAMANHO...<br>"
cMsg += "<br><br>"

dbSelectArea("SXG")
dbSetOrder(1)   

dbSelectArea("SX1")
dbSetOrder(1)   
ProcRegua(SX1->(RecCount()))
SX1->(dbGotop())

While !SX1->(Eof())
	IncProc("SX1 : "+X1_GRPSXG)
	If !Empty(X1_GRPSXG)
		dbSelectArea("SXG")
		If dbSeek(SX1->X1_GRPSXG,.T.) 	    
			dbSelectArea("SX1")
			If SX1->X1_TAMANHO <> SXG->XG_SIZE
				cMsg := X1_GRUPO+"<br>"
				RecLock("SX1",.F.)
				X1_TAMANHO := SXG->XG_SIZE
				MsUnlock()
			EndIf
		EndIf
	EndIf          
	dbSelectArea("SX1")
	SX1->(dbSkip())
End

cMsg += "<br><br>"
cMsg := ""

dbSelectArea("SIX")
dbSetOrder(1)

aSX1 := {}    
aDel := {}

ProcRegua(SIX->(RecCount())*5)
SIX->(dbGotop())

While !SIX->(Eof())
	IncProc("SIX : "+INDICE)
	If Ascan(aSX1,{|x| x[1]+x[3] == INDICE+CHAVE}) == 0
		Aadd(aSX1,{INDICE,ORDEM,CHAVE})
	Else
		Aadd(aDel,{INDICE,ORDEM,CHAVE})
	Endif
	SIX->(dbSkip())
End

cMsg += "Corre��o SIX Deletado duplicado:<br>"

SIX->(dbGotop())
ProcRegua(Len(aDel))

For i:= 1 To Len(aDel)
	IncProc("SIX Deletando: "+aDel[i][1]+aDel[i,2])
	If dbSeek(aDel[i,1]+aDel[i,2])
		cMsg := INDICE+"-"+ORDEM+"<br>"
		RecLock("SIX",.F.)
		DbDelete()
		MsUnlock()
	EndIf
Next

cMsgx += "<br><br>"
cMsgx := ""

dbSelectArea("SX3")
dbSetOrder(1)

ProcRegua(SX3->(RecCount()))
SX3->(dbGotop())

cMsg1 := "Corre��o SX3 X3_PROPRI (2):<br>"

While !SX3->(Eof())
	IncProc("SX3  X3_PROPRI (2): "+SX3->X3_CAMPO)
	If Left(SX3->X3_ARQUIVO,2) <> "SZ" .And. X3_PROPRI <> "S"
		If SubStr(SX3->X3_CAMPO,AT("_",X3_CAMPO),2) <> "_X"  
			cMsgx := SX3->X3_CAMPO+"-"+"<br>"
			SX3->(RecLock("SX3",.f.))
			SX3->X3_PROPRI:= "S" 
			SX3->( MsUnlock() )  
		Endif
	Endif
	dbSelectArea("SX3")
	SX3->(dbSkip())
End

cMsg += "<br><br>"
cMsg := ""

dbSelectArea("SX2")
ProcRegua(SX2->(RecCount()))
SX2->(dbGotop())

cMsgx := "Linha 268 Drop SX2 vazio:<br>"

While !SX2->(Eof())
	IncProc("SX2  drop (2): "+SX2->X2_CHAVE)
		If   xRecCount(SX2->X2_CHAVE+cEmpAnt+"0")
				If TcSqlExec("DROP TABLE "+SX2->X2_CHAVE+cEmpAnt+"0" ) < 0
	  				MsgStop("Houveram erros durante o processamento: "+SX2->X2_CHAVE+chr(10)+chr(13)+TCSQLERROR())
				Else
					cMsgx := SX2->X2_CHAVE+"-"+"<br>"
				EndIf
		Endif
	dbSelectArea("SX2")
	SX2->(dbSkip())
End

cMsgx += "<br><br>"
cMsgx := ""

dbSelectArea("SX3")
dbSetOrder(2)

ProcRegua(SX3->(RecCount()))
SX3->(dbGotop())

aSzw := {"ZW_ORIGEM","ZW_DESTINO"}
aTam := {4          ,4           }

For x:= 1 to Len(aSzw)
	IncProc("SX3  deixando igual ao tamanho no banco : "+SX3->X3_CAMPO)
	If SX3->(dbSeek(aSzw[x]))                					       
		cMsgx := SX3->X3_CAMPO+" de "+AllTrim(Str(SX3->X3_TAMANHO))+" para +"+AllTrim(Str(aTam[X]))+"<br>"
		SX3->(RecLock("SX3",.f.))
		SX3->X3_TAMANHO:= aTam[X]
		SX3->( MsUnlock() )  	
	Endif
Next
         
If !Empty(cMsg) .or. !Empty(cMsgx)
	WFNotifyAdmin( "rodolfo@rvacari.com.br" , "Ajuste SXs... "+Capital("  - "+SM0->M0_FILIAL),"Indices Deletados<BR>"+cMsg+cMsgx, {} )
	aEval(aMsg1,{|x| WFNotifyAdmin( "rodolfo@rvacari.com.br" , "Ajuste SXs(X3_PROPRI) "+Capital("  - "+SM0->M0_FILIAL),x, {} )})
Endif

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �xRecCount �Autor  �Microsiga           � Data �  09/02/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �                                                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function xRecCount(cTab)
Local xArea  := GetArea()
Local lRet   := .f.
Local cAlias := GetNextAlias()

dbUseArea(.T., "TOPCONN", TCGenQry(,,"select COUNT(*) ntab from sysobjects where name = '"+cTab+"'"), cAlias, .F., .T.)
dbSelectArea(cAlias)
lRet := ntab > 0    
(cAlias)->(dbCloseArea())

If lRet
	dbUseArea(.T., "TOPCONN", TCGenQry(,,"select COUNT(*)  NREG from "+cTab+" "), cAlias, .F., .T.)
	dbSelectArea(cAlias)
	lRet := NREG  == 0    
	(cAlias)->(dbCloseArea())       
EndIf

RestArea(xArea)

Return lREt