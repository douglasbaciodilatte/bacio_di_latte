#include 'protheus.ch'
#include 'parmtype.ch'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � BPCPG01  �Autor  � Agility            � Data �  25/10/17   ���
�������������������������������������������������������������������������͹��
���Desc.     � Gatilho para validacao da quantidade a ser apontadada.     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Bacio                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

user function BPCPG01(_cQtdApon)
Local _nRet    := 0	
Local _nPosQtd := AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_QUANT"})
Local _nPosOp  := AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_OP"})
//Local _cMesFec := Month(GetMV("MV_ULMES"))
Local _cMesFec := Substr(DTOS(GetMV("MV_ULMES")),1,6)
Local _cMesOP  := ""

dbSelectArea("SC2")
dbSetOrder(1)
IF dbSeek(XFILIAL("SC2")+aColDad1[n][_nPosOp])
	//_cMesOP := Month(SC2->C2_EMISSAO)
	_cMesOP := Substr(DTOS(SC2->C2_EMISSAO),1,6)
	IF _cMesOP <= _cMesFec
		ShowHelpDlg('BPCPG01',{'O m�s de emiss�o da Ordem de Produ��o est� fora do m�s de fechamento do estoque.'},1,{'Somente Ordens de Produ��o com m�s superior ao m�s de fechamento podem sem apontadas.'},1)
		Return(_nRet)
	ENDIF
ENDIF

IF _cQtdApon > aColDad1[n][_nPosQtd] 
	ShowHelpDlg('BPCPG01',{'A quantidade informada para apontamento � superior ao saldo da Ordem de Produ��o.'},1,{'Informe a quantidade menor ou igual ao saldo da Ordem de Produ��o.'},1)
	Return(_nRet)
ELSE
	_nRet := _cQtdApon
ENDIF
	
Return(_nRet)