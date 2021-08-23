#INCLUDE "Protheus.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SISPAG01  �Autor  �Rodrigo leite       � Data �  04/30/15   ���
�������������������������������������������������������������������������͹��
���Desc.     � Retorna o Numero da Conta Bancaria.                        ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function SISPAG01()

Local cRet   := ""        
Local cConta := ""

cConta := SUBSTR(SA2->A2_NUMCON,1,LEN(ALLTRIM(SA2->A2_NUMCON))-1)
cRet := STRZERO(VAL(cConta),12)                                           

Return(cRet)