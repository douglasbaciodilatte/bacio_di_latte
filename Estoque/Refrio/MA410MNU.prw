#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"

//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������
//�������������������������������������������������������������������������ͻ��
//���Programa  �MA410MNU  |Autor  �Vanito Rocha        | Data �  18/12/20   ���
//�������������������������������������������������������������������������͹��
//���Desc.     �Ponto de entrada utilizado para adicionar op��es ao Menu    ���
//���          �                                                            ���
//�������������������������������������������������������������������������ͼ��
//�����������������������������������������������������������������������������
//�����������������������������������������������������������������������������
User Function MA410MNU()

aAdd(aRotina,{"Enviar Refrio"   ,"U_BLENVRE",0,2,0,NIL})
aAdd(aRotina,{"Consulta Refrio"   ,"U_BLCONRE",0,2,0,NIL})

Return

User Function BLENVRE()

Local cNumPe:=SC5->C5_NUM

    Processa( {|| U_XMLREFR(cNumPe) }, "Refrio x Bacio", "Carregando defini��o do pedido: " + cNumPe,.F.)

Return()                                                                           


User Function BLCONRE()

Local cNumPe:=SC5->C5_NUM

    Processa( {|| U_BLCONSPE(cNumPe) }, "Refrio x Bacio", "Carregando defini��o do pedido: " + cNumPe,.F.)

Return()                                                                           