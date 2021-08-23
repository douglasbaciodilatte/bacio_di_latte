#include "rwmake.ch"       
#INCLUDE "PROTHEUS.CH"   

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Rotina    � F420ALMOD.PRW                                              ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � O ponto de entrada foi implantado para que possa ser       ���
���          � inserido um filtro direto no browse da rotina FINA050.     ���
���          �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Desenvolvi� Douglas Silva                                              ���
���mento     � 10/01/2020                                                 ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Utilizado pela rotina de lan�amentos manual SE2 Filtro de  ���
���            Tela                                                       ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

User Function F050FILB()
	
	Local cFiltro 	:= " "
	Local _cUsers	:= SUPERGETMV("MV_XF050CO", .T., "")
	
	 If RetCodUsr() $ _cUsers
		cFiltro := "E2_PREFIXO = 'CO '"
	EndIf
		
Return cFiltro