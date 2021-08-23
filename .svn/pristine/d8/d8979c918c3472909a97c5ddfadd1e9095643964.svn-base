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
���Desc.     � Filtro da Fatura no SE2     ��
���          �                                                                                  ���
�������������������������������������������������������������������������͹��
���Uso       �  Bacio                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������*/


User Function F290BFIL()
Local cFiltro:= ""
Local oMemo1         := NIL
Local oRadioGrp1     := NIL
Private cMemo1	     := ""
Private nRadioGrp1	 := 1
Private aArquivos    := {}
Private cDirectory   := IIF(nRadioGrp1 == 1,"c:\","\")
Private cMask        := ""
Private cMask1       := ""
// Variaveis Private da Funcao
Private _oDlg				// Dialog Principal
Private INCLUI := .F.	// (na Enchoice) .T. Traz registro para Inclusao / .F. Traz registro para Alteracao/Visualizacao

DEFINE MSDIALOG _oDlg TITLE OemtoAnsi("Filtrar Título - Fatura CP") FROM C(178),C(181) TO C(548),C(717) PIXEL
// Cria Componentes Padroes do Sistema
@ C(004),C(003) TO C(042),C(267) LABEL "Filtro" PIXEL OF _oDlg
//@ C(015),C(006) Radio oRadioGrp1 Var nRadioGrp1 Items "Enviar","Receber" 3D Size C(142),C(010) PIXEL OF _oDlg
@ C(017),C(169) Say "Data Vencimento De:" Size C(022),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(017),C(194) MsGet oEdit1 Var cMask Size C(060),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(019),C(169) Say "Data Vencimento Ate:" Size C(022),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
@ C(019),C(194) MsGet oEdit2 Var cMask1 Size C(060),C(009) COLOR CLR_BLACK PIXEL OF _oDlg
//@ C(043),C(005) Button OemtoAnsi("Selecionar ") Size C(037),C(012) PIXEL OF _oDlg ACTION( Processa({|| RunProc(1)}) )
@ C(043),C(152) Button OemtoAnsi("Sair") Size C(037),C(012) PIXEL OF _oDlg ACTION( _oDlg:End() )
@ C(061),C(003) GET oMemo1 Var cMemo1 MEMO Size C(264),C(118) PIXEL OF _oDlg
ACTIVATE MSDIALOG _oDlg CENTERED 


If MsgYesNo("Filtra?")

cFiltro := "E2_PREFIXO = 'TST' AND E2_NUM = '0001'"

EndIf

Return cFiltro