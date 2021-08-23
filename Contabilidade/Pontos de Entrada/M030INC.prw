#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³M030INC   ºAutor  ³André Sarraipa      º Data ³  07/24/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cria o item contabil e atualiza o cadastro do cliente       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/



USER FUNCTION M030INC()

Local _nOpc			:= ParamIxb	   		
Local _cCod			:= SA1->A1_COD 				
Local _cItem		:= SA1->A1_ITEMCC	
Local _cNome		:= SA1->A1_NOME		
Local _cChave		:= ""				


_cChave	:= "C"+_cCod
	 
If Empty(_cItem)
	CTD->(dbSetOrder(1)) //CTD_FILIAL+CTD_ITEM
	If !CTD->(dbSeek(xFilial("CTD")+_cChave)) //Caso nao encontre o item
		
		//Inclui o item
		RecLock("CTD",.T.)
			CTD->CTD_FILIAL		:= xFilial("CTD")		//Filial
			CTD->CTD_ITEM		:= _cChave				//Item Contabil
			CTD->CTD_CLASSE		:= "2"					//Analistico ou sintetico
			CTD->CTD_DESC01		:= Substr(_cNome,1,40)	//Descricao
			CTD->CTD_BLOQ		:= "2"					//Bloqueado?	
			CTD->CTD_DTEXIST	:= CTOD("01/12/80")			//Data
			CTD->CTD_ITLP		:= _cChave				//Item Contabil
			CTD->CTD_CLOBRG		:= "2"
			CTD->CTD_ACCLVL		:= "2"
    	MsUnLock()
    	
    	//Apos a inclusao verifico se incluiu corretamente e atualizo o campo no cadastro de clientes
    	CTD->(dbSetOrder(1)) //CTD_FILIAL+CTD_ITEM
		If CTD->(dbSeek(xFilial("CTD")+_cChave)) //Caso nao encontre 
	   		RecLock("SA1",.F.)
	   			SA1->A1_ITEMCC	:= CTD->CTD_ITEM
	   		MsUnLock()
	   	Else	//Caso nao tenha incluido o item corretamente
			MsgBox("Não foi possível encontrar a Classe de Valor "+Alltrim(_cChave)+" cadastrada. Realize a operação manualmente.","Atenção")
	   	EndIf	 
	
	Else	//Caso encontre a classe cadastrada porem nao preenchida no cliente, atualizo 
   		RecLock("SA1",.F.)
   			SA1->A1_ITEMCC	:= CTD->CTD_ITEM
   		MsUnLock()
	EndIf
EndIf 

RETURN (.T.)