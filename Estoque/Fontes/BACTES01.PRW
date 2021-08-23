#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE "TBICONN.CH"
#INCLUDE "TBICODE.CH"        

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ºPrograma ³   BACTES01     ºAutor³ Andrï¿½ Sarraipa 	      º Data Ini³ 11/01/2017 º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ºDesc.    ³ 	Gatilha a TES de entrada nas solicitaï¿½ï¿½o de transferencia		  ±±
±±				Tabela NNT rotina mata311  											  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ºUso      ³ 	BACIO di LATTE                                            		  	  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ºRequisitos ³  Definir na APSDU Fornec '07XPHH' para  cOPER == '53'			      ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function BACTES01(cOPER,cFilDes,cProd)

	Local aAreaAnt 	  := GetArea()
	Local cTESeNT     := ""
	Local cGRPROD     := "" 
    Local cChave      := ""   
	Local cTesPad     := SuperGetMv('MV_BDTESTR',,'294')    //ALTERADO A TES     
//	Local cFil_orig   := xFilial("NNT") /*Comentado por Felipe Mayer 30/01/2020 para alteração da rotina*/
   
	Default cOPER     := ""
	Default cFilDes   := ""
	Default cProd     := ""

	
	dbSelectArea("SB1") 
	SB1->(dbSetOrder(1))
	If SB1->(DbSeek(XFilial("SB1") + cProd))
		cGRPROD := SB1->B1_GRTRIB
	EndIf 


	/*Alterado por Felipe Mayer 30/01/2020 para funcionamento homologação/produção*/
	
	//BUSCA A TES COM FORNECEDOR DE ORIGEM MAIS O GRUPO DO PRODUTO

  	dbSelectArea("SFM")
	SFM->(dbSetOrder(2))  
 
   cChave := xFilial("SFM")+cOPER+AvKey("","FM_CLIENTE")+AvKey("","FM_LOJACLI")+"07XPHH"+AvKey("","FM_LOJAFOR")+AvKey("","FM_GRTRIB")+AvKey("","FM_PRODUTO")+Alltrim(cGRPROD)+AvKey("","FM_EST")+AvKey("","FM_POSIPI")
//cChave := cFilDes+cOPER+AvKey("","FM_CLIENTE")+AvKey("","FM_LOJACLI")+"07XPHH"+ALLTRIM(cFil_orig)+AvKey("","FM_GRTRIB")+AvKey("","FM_PRODUTO")+Alltrim(cGRPROD)+AvKey("","FM_EST")+AvKey("","FM_POSIPI")

	If SFM->(dbSeek(cChave))
	   cTESeNT := SFM->FM_TE
	EndIf          
       
	If Empty(cTESeNT)   	
	//BUSCA A TES COM O GRUPO DO PRODUTO
	   cChave := cFilDes+cOPER+AvKey("","FM_CLIENTE")+AvKey("","FM_LOJACLI")+AvKey("","FM_FORNECE")+AvKey("","FM_LOJAFOR")+AvKey("","FM_GRTRIB")+AvKey("","FM_PRODUTO")+Alltrim(cGRPROD)+AvKey("","FM_EST")+AvKey("","FM_POSIPI")
		
	   dbSelectArea("SFM")
	   SFM->(dbSetOrder(2))
	           
	   If SFM->(dbSeek(cChave))
			cTESeNT := SFM->FM_TE
	   EndIf
	EndIf
		
	//CASO NAO ENCONTRE TES PEGA O PARAMETRO  'MV_BDTESTR'            
	If Empty(cTESeNT)   
		cTESeNT := cTesPad
	EndIf
      
	RestArea(aAreaAnt)   // Retorna o ambiente anterior  

Return cTESeNT