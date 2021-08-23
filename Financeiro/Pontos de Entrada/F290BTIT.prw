#Include "Protheus.ch"
#Include "TopConn.ch"    
#include "apwebsrv.ch"
#include "apwebex.ch"
#include "ap5mail.ch"    


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �FA290     �Autor  �Rodolfo Vacari      � Data �  02/14/18   ���
�������������������������������������������������������������������������͹��
���Desc.     � Executado durante a grava��o dos dados da fatura no SE2     ��
���          � Grava o centro de custo do titulo na fatura                ���
�������������������������������������������������������������������������͹��
���Uso       �  Bacio                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/

User Function F290BTIT()

Local aCPO := aClone(paramixb)
    aCPO := {}
    AADD(aCPO,{"E2_OK","","  ",""})
    AADD(aCPO,{"E2_PREFIXO","","Prefixo","@!"})
    AADD(aCPO,{"E2_NUM","","Número","@!"})
    AADD(aCPO,{"E2_VALOR","","Valor","@E 999,999,999,999.99"})
    AADD(aCPO,{"E2_EMISSAO","","EMISSAO","@!"})
    AADD(aCPO,{"E2_EMISSAO","","EMISSAO","@!"})
Return aCPO