#INCLUDE "PROTHEUS.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BACDM030   �Autor  �Elaine Mazaro      � Data �  15/02/17   ���
�������������������������������������������������������������������������͹��
���Desc.     �  Gatilho para TES na Solicita��o de Transfer�ncia          ���
��		     �                                         					  ���
�������������������������������������������������������������������������͹��
���Uso       � Bacio                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function BACDM030(cFilDes,cProd)

Local cTES := ""   
Local cClieFor := ""
Local cLoja:= ""
Local cCgcFil := ""                 
local cTpOper := SuperGetMV("ES_TPOPTRA",," ")
Local _aAreaSM0		:= SM0->( GetArea() )					//Salva a Area da tabela SM0 - Empresas
Local _aAreaSA1		:= SA1->( GetArea() )					//Salva a Area da tabela SA1 - Cadastro de Clientes

Default cFilDes := ""
Default cProd := ""

//Busca CGC da Filial
SM0->( dbGoTop() )
While !SM0->( Eof() )
	If Alltrim(SM0->M0_CODFIL) == cFilDes
		cCgcFil:= SM0->M0_CGC
		Exit
	EndIf
	SM0->( dbskip() )
End        

RestArea(_aAreaSM0)

dbSelectArea("SA1")
dbSetorder(3) 
SA1->( dbGoTop() )

If SA1->(dbSeek(xFilial("SA1") + cCgcFil))

	cClieFor := SA1->A1_COD
	cLoja := SA1->A1_LOJA
	cTES := MaTesInt(2,cTpOper,cClieFor,cLoja,"C",cProd,NIL)    

Endif

RestArea(_aAreaSA1)

Return cTES

