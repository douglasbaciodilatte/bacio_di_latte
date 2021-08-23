#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "TBICODE.CH"        


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BACTES01  ºAutor  ³André Sarraipa      º Data ³  11/01/2017 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Gatilha a TES de entrada nas solicitação de transferencia   º±±
±±º          ³Tabela NNT rotina mata311                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ BACIO di LATTE                                             º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/



User Function BACTES01(cOPER,cFilDes,cProd)

	LOCAL aAreaAnt := GETAREA()
	LOCAL   cTESeNT     := ""
	LOCAL   cGRPROD     := "" 
    local   cChave      := ""   
	Local   cTesPad     := SuperGetMv('MV_BDTESTR',,'214')         
	LOCAL   cFil_orig   := xFilial("NNT")
   
	Default cOPER       := ""
	Default cFilDes     := ""
	Default cProd       := ""


   	
dbSelectArea("SB1") 
SB1->(dbSetOrder(1))
If SB1->(DbSeek(XFilial("SB1") + cProd))
	cGRPROD := SB1->B1_GRTRIB
ENDIF 

//BUSCA A TES COM FORNECEDOR DE ORIGEM MAIS O GRUPO DO PRODUTO
cChave := cFilDes+cOPER+AvKey("","FM_CLIENTE")+AvKey("","FM_LOJACLI")+"07XPHH"+ALLTRIM(cFil_orig)+AvKey("","FM_GRTRIB")+AvKey("","FM_PRODUTO")+Alltrim(cGRPROD)+AvKey("","FM_EST")+AvKey("","FM_POSIPI")

dbSelectArea("SFM")
SFM->(dbSetOrder(2))
           
IF SFM->(dbSeek(cChave))
 			
    cTESeNT := SFM->FM_TE       

ENDIF          
       

IF EMPTY(cTESeNT)   

//BUSCA A TES COM O GRUPO DO PRODUTO
   cChave := cFilDes+cOPER+AvKey("","FM_CLIENTE")+AvKey("","FM_LOJACLI")+AvKey("","FM_FORNECE")+AvKey("","FM_LOJAFOR")+AvKey("","FM_GRTRIB")+AvKey("","FM_PRODUTO")+Alltrim(cGRPROD)+AvKey("","FM_EST")+AvKey("","FM_POSIPI")
	
   dbSelectArea("SFM")
   SFM->(dbSetOrder(2))
           
   IF SFM->(dbSeek(cChave))
 			
		cTESeNT := SFM->FM_TE       

   ENDIF
   
ENDIF



//CASO NAO ENCONTRE TES PEGA O PARAMETRO  'MV_BDTESTR'            
IF EMPTY(cTESeNT)   
	
	cTESeNT := cTesPad   

ENDIF
      

RESTAREA(aAreaAnt)   // Retorna o ambiente anterior  

	
Return cTESeNT