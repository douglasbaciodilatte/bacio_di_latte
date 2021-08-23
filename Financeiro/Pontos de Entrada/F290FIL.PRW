#Include 'Protheus.ch'

User Function F290FIL()
Local lQuery := PARAMIXB[1] // .T. retorno deve ser em SQL , .F. retorno deve ser em codebase
Local cRet :=""
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
@ C(043),C(152) Button OemtoAnsi("Confirma") Size C(037),C(012) PIXEL OF _oDlg ACTION( _oDlg:End() )
ACTIVATE MSDIALOG _oDlg CENTERED 


If lQuery
    Ret := "E2_TIPO <> '' and E2_EMISSAO BETWEEN '20190501' AND '20190529' "
Else
    cRet := "E2_TIPO <> '' .and. E2_NATUREZ == 'SEMIMPOSTO' "
EndIf 

//Alert("Passou pelo PE F290FIL") 

Return cRet