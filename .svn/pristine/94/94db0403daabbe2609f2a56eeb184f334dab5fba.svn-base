#include 'protheus.ch'
#include 'parmtype.ch'

/*
��������������������������������������������������������������
��������������������������������������������������������������
�����������������������������������������������������������ͻ���
���Programa  � BLPONA140  �Autor  � Rodolfo Vacari            � Data �  19/06/19              ���
�������������������������������������������������������������������������͹��
���Desc.     � Filtro na tela de Cadastro de Funcionário                                        ���
���          �                                                                                  ���
�������������������������������������������������������������������������͹��
���Uso       � Bacio                                                      ���
������������������������������������������������������������ͼ��
��������������������������������������������������������������
���������������������������������������������������������������
*/


User Function BLPONA140()

//Local _cFiltro := ""
//Local cCCUser := ""
//Local aArea := GetArea()
Local _cOk := ""
Local _cAlias := "SRA"

///_cFiltro := SUBSTR(UsrRetName(RetCodUsr()),3,4)+"01"

If SUBSTR(UsrRetName(RetCodUsr()),1,2) == "lj"
    dbSelectArea(_cAlias)
    Set Filter To alltrim(SRA->RA_CC) = SUBSTR(UsrRetName(RetCodUsr()),3,4)+"01"     //&(cFiltro)
    (_cAlias)->(dbGoTop())
        PONA140()
    Set Filter to 
    (_cAlias)->(DbGotop())  
Else
    PONA140()
Endif    

//RestArea(aArea)
Return