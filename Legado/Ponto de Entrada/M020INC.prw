#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �M020INC   �Autor  �Andr� Sarraipa      � Data �  07/24/17   ���
�������������������������������������������������������������������������͹��
���Desc.     � Criar o item contabil e atualiza o cadastro do Fornecedor  ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/



User Function M020INC()

Local _cCod			:= SA2->A2_COD 			
Local _cItem		:= SA2->A2_ITEMCC
Local _cNome		:= SA2->A2_NOME		
Local _cChave		:= ""				

_cChave	:= "F"+_cCod
 
//ITEM CONTA
If Empty(_cItem)
	CTD->(dbSetOrder(1)) //CTD_FILIAL+CTD_ITEM
	If !CTD->(dbSeek(xFilial("CTD")+_cChave)) //Caso nao encontre o item correspondente ao fornecedor
		
		//Inclui a classe de valor
		RecLock("CTD",.T.)
			CTD->CTD_FILIAL		:= xFilial("CTD")		//Filial
			CTD->CTD_ITEM		:= _cChave				//Item Contabil
			CTD->CTD_CLASSE		:= "2"					//Analistico ou sintetico
			CTD->CTD_DESC01		:= Substr(_cNome,1,40)	//Descricao
			CTD->CTD_BLOQ		:= "2"					//Bloqueado?	
			CTD->CTD_DTEXIST	:= CTOD("01/12/80")     //dDataBase			//Data
			CTD->CTD_ITLP		:= _cChave				//Item Contabil
			CTD->CTD_CLOBRG		:= "2"
			CTD->CTD_ACCLVL		:= "2"
    	MsUnLock()
    	
    	//Apos a inclusao verifico se incluiu corretamente e atualizo o campo no cadastro de fornecedores
    	CTD->(dbSetOrder(1)) //CTD_FILIAL+CTD_ITEM
		If CTD->(dbSeek(xFilial("CTD")+_cChave)) //Caso nao encontre o item correspondente ao fornecedor
	   		RecLock("SA2",.F.)
	   			SA2->A2_ITEMCC	:= CTD->CTD_ITEM
	   		MsUnLock()
	   	Else	//Caso nao tenha incluido o item na tabela corretamente
			MsgBox("N�o foi poss�vel encontrar o item conta "+Alltrim(_cChave)+" cadastrado. Realize a opera��o manualmente.","Aten��o")
	   	EndIf	 
	
	Else	//Caso encontre o item porem nao preenchida no cliente, atualizo o campo 
   		RecLock("SA2",.F.)
   			SA2->A2_ITEMCC	:= CTD->CTD_ITEM
   		MsUnLock()
	EndIf
EndIf

 

RETURN (.T.)