#Include 'Protheus.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �A140EXC   �Autor  �Elaine Mazaro       � Data �  15/02/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de Entrada usado para validar se a Pre Nota Fiscal de ���
���          �Entrada pode ser Excluido									  ���
�������������������������������������������������������������������������͹��
���Uso       �Bacio      												  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function A140EXC()

Local _lRet		:= .T.

If _lRet .And. !l140Auto 
	//Rotina que verifica se e possivel excluir a Pre Nota Fiscal de Entrada
	_lRet := U_BACDM020()
EndIf

Return _lRet
