#include "protheus.ch"
//#include "pmsxfun.ch"
#include "dbtree.ch"
//#include "pmsicons.ch"
#include "tbiconn.ch"

#DEFINE FILTER_AFN 01
#DEFINE FILTER_AFS 02
#DEFINE FILTER_AFI 03
#DEFINE FILTER_AFU 04
#DEFINE FILTER_AJC 05
#DEFINE FILTER_AFR 06
#DEFINE FILTER_AJE 07
#DEFINE FILTER_AFM 08
#DEFINE FILTER_LENGTH 08


STATIC cCrteFSB1 := ""
STATIC cCrteFAE8 := ""
STATIC cCrteFAF9 := ""

STATIC nTimeAtu
STATIC nProcAtu
STATIC nEscalaAtu

STATIC nQtMaxNF   := 0
STATIC nQtMaxSC   := 0
STATIC nQtMaxSA   := 0
STATIC nQtMaxCP   := 0
STATIC nQtMaxOP   := 0
STATIC nProcRegua := 0

STATIC aHeaderAFN := {}
STATIC aHeaderAFZ := {}
STATIC aHeaderAFG := {}
STATIC aHeaderAFH := {}
STATIC aHeaderAFL := {}
STATIC aHeaderAFM := {}
STATIC aHeaderAFR := {}
STATIC aHeaderAJE := {}
STATIC aHeaderAFT := {}
STATIC aChkExc	  := {}
STATIC aCrteProc  := {.T.,.T.,.T.,.T.,.T.,.T.,.T.}
STATIC oBPMSEDT1
STATIC oBPMSEDT2
STATIC oBPMSEDT3
STATIC oBPMSEDT4
STATIC oBPMSTASK1
STATIC oBPMSTASK2
STATIC oBPMSTASK3
STATIC oBPMSTASK4
STATIC oBPMSTASK5

STATIC lECMDisp		:= Iif(SuperGetMv("MV_KBFLUIG",,.F.),FwGedRootFld() > 0,.F.) //Verifica se a integração com ECM esta ativa

//Static para uso do Template de CCTR
STATIC cCCTRFrente := Space(15)

STATIC lBlockDel := .T. // Criada para o controle de validacao na exclusão da linha na GetDados, pois a getdados executa 2x a função de validacao.
STATIC lMsgUnica
STATIC lAF8TpCus
STATIC lPmsFilAFM
STATIC lPmsSD3CRTE
STATIC lPmsSD3Qry
STATIC lPMSQRCRTE
STATIC lPmsAFLCP
STATIC lPMSDELAFF
Static lNewCalend
Static __lTopConn	:= .T.
Static _oPMSXFUN1
Static _oPMSXFUN2
Static _oPMSXFUN3
Static _oPMSXFUN4

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ParamBox³ Autor ³ Edson Maricate          ³ Data ³ 09-02-2001 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Cria uma tela de parametros.                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpA1 : Array contendo os parametros                          ³±±
±±³          ³        [1] Tipo do parametro -                               ³±±
±±³          ³         1 - MsGet                                            ³±±
±±³          ³           [2] : Descricao                                    ³±±
±±³          ³           [3] : String contendo o inicializador do campo     ³±±
±±³          ³           [4] : String contendo a Picture do campo           ³±±
±±³          ³           [5] : String contendo a validacao                  ³±±
±±³          ³           [6] : Consulta F3                                  ³±±
±±³          ³           [7] : String contendo a validacao When             ³±±
±±³          ³           [8] : Tamanho do MsGet                             ³±±
±±³          ³           [9] : Flag .T./.F. Parametro Obrigatorio ?         ³±±
±±³          ³         2 - Combo                                            ³±±
±±³          ³           [2] : Descricao                                    ³±±
±±³          ³           [3] : Numerico contendo a opcao inicial do combo   ³±±
±±³          ³           [4] : Array contendo as opcoes do Combo            ³±±
±±³          ³           [5] : Tamanho do Combo                             ³±±
±±³          ³           [6] : Validacao                                    ³±±
±±³          ³           [7] : Flag .T./.F. Parametro Obrigatorio ?         ³±±
±±³          ³         3 - Radio                                            ³±±
±±³          ³           [2] : Descricao                                    ³±±
±±³          ³           [3] : Numerico contendo a opcao inicial do Radio   ³±±
±±³          ³           [4] : Array contendo as opcoes do Radio            ³±±
±±³          ³           [5] : Tamanho do Radio                             ³±±
±±³          ³           [6] : Validacao                                    ³±±
±±³          ³           [7] : Flag .T./.F. Parametro Obrigatorio ?         ³±±
±±³          ³           [8] : String contendo a validacao When             ³±±
±±³          ³         4 - CheckBox ( Com Say )                             ³±±
±±³          ³           [2] : Descricao                                    ³±±
±±³          ³           [3] : Indicador Logico contendo o inicial do Check ³±±
±±³          ³           [4] : Texto do CheckBox                            ³±±
±±³          ³           [5] : Tamanho do Radio                             ³±±
±±³          ³           [6] : Validacao                                    ³±±
±±³          ³           [7] : Flag .T./.F. Parametro Obrigatorio ?         ³±±
±±³          ³         5 - CheckBox ( linha inteira )                       ³±±
±±³          ³           [2] : Descricao                                    ³±±
±±³          ³           [3] : Indicador Logico contendo o inicial do Check ³±±
±±³          ³           [4] : Tamanho do Radio                             ³±±
±±³          ³           [5] : Validacao                                    ³±±
±±³          ³           [6] : Flag .T./.F. Parametro Obrigatorio ?         ³±±
±±³          ³         6 - File                                             ³±±
±±³          ³           [2] : Descricao                                    ³±±
±±³          ³           [3] : String contendo o inicializador do campo     ³±±
±±³          ³           [4] : String contendo a Picture do campo           ³±±
±±³          ³           [5] : String contendo a validacao                  ³±±
±±³          ³           [6] : String contendo a validacao When             ³±±
±±³          ³           [7] : Tamanho do MsGet                             ³±±
±±³          ³           [8] : Flag .T./.F. Parametro Obrigatorio ?         ³±±
±±³          ³           [9] : Texto contendo os tipos de arquivo           ³±±
±±³          ³                 Ex.: "Arquivos .CSV |*.CSV"                  ³±±
±±³          ³           [10]: Diretorio inicial do cGetFile                ³±±
±±³          ³           [11]: PARAMETROS do cGETFILE                       ³±±
±±³          ³           [12]: Se .T. apresenta árvore do servidor          ³±±
±±³          ³         7 - Montagem de expressao de filtro                  ³±±
±±³          ³           [2] : Descricao                                    ³±±
±±³          ³           [3] : Alias da tabela                              ³±±
±±³          ³           [4] : Filtro inicial                               ³±±
±±³          ³           [5] : Opcional - Clausula When Botao Editar Filtro ³±±
±±³          ³         8 - MsGet Password                                   ³±±
±±³          ³           [2] : Descricao                                    ³±±
±±³          ³           [3] : String contendo o inicializador do campo     ³±±
±±³          ³           [4] : String contendo a Picture do campo           ³±±
±±³          ³           [5] : String contendo a validacao                  ³±±
±±³          ³           [6] : Consulta F3                                  ³±±
±±³          ³           [7] : String contendo a validacao When             ³±±
±±³          ³           [8] : Tamanho do MsGet                             ³±±
±±³          ³           [9] : Flag .T./.F. Parametro Obrigatorio ?         ³±±
±±³          ³         9 - MsGet Say                                        ³±±
±±³          ³           [2] : String Contendo o Texto a ser apresentado    ³±±
±±³          ³           [3] : Tamanho da String                            ³±±
±±³          ³           [4] : Altura da String                             ³±±
±±³          ³           [5] : Negrito (logico)                             ³±±
±±³          ³         10- Range (experimental)                             ³±±
±±³          ³           [2] : Descricao                                    ³±±
±±³          ³           [3] : Range Inicial                                ³±±
±±³          ³           [4] : ConsultaF3                                   ³±±
±±³          ³           [5] : Largo em pixels do Get                       ³±±
±±³          ³           [6] : Tipo                                         ³±±
±±³          ³           [7] : Tamanho do campo (em chars)                  ³±±
±±³          ³           [8] : String contendo a validacao When             ³±±
±±³          ³         11-MultiGet (MEMO)                                   ³±±
±±³          ³           [2] : Descrição                                    ³±±
±±³          ³           [3] : Inicializador padrão                         ³±±
±±³          ³           [4] : String contendo o VALID                      ³±±
±±³          ³           [5] : String contendo o WHEN                       ³±±
±±³          ³           [6] : Flag .T./.F. Parametro Obrigatorio ?         ³±±
±±³          ³         12-Filtro de usuario por rotina                      ³±±
±±³          ³           [2] : Titulo do filtro                             ³±±
±±³          ³           [3] : Alias da tabela onde vai aplicar o filtro    ³±±
±±³          ³           [4] : Expressao de filtro de inicio                ³±±
±±³          ³           [5] : String contendo o WHEN                       ³±±
±±³          ³ExpC2  : Titulo da Janela                                     ³±±
±±³          ³ExpA3  : Array passado por referencia que contem o retorno    ³±±
±±³          ³         dos parametros.                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³Generico                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function ParamBoZ(aParametros,cTitle,aRet,bOk,aButtons,lCentered,nPosx,nPosy, oDlgWizard, cLoad, lCanSave,lUserSave)

Local oDlg
Local oPanel
Local oPanelB
Local oFntVerdana

Local nx
Local nBottom
Local nPos
Local nLinha	:= 8

Local cPath     := ""
Local cTextSay
Local cArquivos := ""
Local cOpcoes	:=	""
Local cBlkWhen2
Local cRotina
Local cAux
Local cAlias
Local cWhen		:= ""
Local cCodUsr 	:= ""
Local cFilAN7	:= xFilial("AN7")

Local aOpcoes

Local lOk		:= .F.
Local lWizard   := .F.
Local lServidor	:= .T.
Local lGrpAdm 	:= .F.
Local loMainWnd := .F.

DEFAULT bOk			:= {|| (.T.)}
DEFAULT nPosX		:= 0
DEFAULT nPosY		:= 0
DEFAULT cLoad     	:= ProcName(1)
DEFAULT lCentered	:= .T.
DEFAULT lCanSave	:= .F.
DEFAULT lUserSave	:= .F.
DEFAULT aButtons	:= {}

cRotina := PADR(cLoad,10)

If Type("cCadastro") == "U"
	cCadastro := ""
EndIf

If !lCanSave
	lUserSave	:= .F.
	cLoad := "99_NOSAVE_"
Else
	//Se nao esta bloqueado
	If u_ParaLoad(cLoad,aParametros,0,"1")== "2"
	
		lUserSave:= .F.
	
	//Se o usuario pode ter a sua propria configuracao
	ElseIf lUserSave
		cLoad	:=	__cUserID+"_"+cLoad
	Endif

Endif

DEFINE FONT oFntVerdana NAME "Verdana" SIZE 0, -10 BOLD

If oDlgWizard == NIL

	If Type("oMainWnd") == "U"
		DEFINE MSDIALOG oDlg TITLE cCadastro+" - "+cTitle FROM nPosX,nPosY TO nPosX+300,nPosY+445 Pixel
		loMainWnd := .F.
	Else
		If IsInCallStack("Pms320Per") .OR. IsInCallStack("P320ExPer")
			DEFINE MSDIALOG oDlg TITLE cCadastro+" - "+cTitle FROM nPosX,nPosY TO nPosX+300,nPosY+500 OF oMainWnd Pixel
		Else
			DEFINE MSDIALOG oDlg TITLE cCadastro+" - "+cTitle FROM nPosX,nPosY TO nPosX+300,nPosY+445 OF oMainWnd Pixel
		EndIf
		loMainWnd := .T.
	EndIF
	lWizard := .F.
Else
	oDlg := oDlgWizard
	lWizard := .T.
EndIf

oPanel := TScrollBox():New( oDlg, 8,10,104,203)
oPanel:Align := CONTROL_ALIGN_ALLCLIENT

For nx := 1 to Len(aParametros)
	Do Case
		Case aParametros[nx,1]==1 // SAY + GET
			
			If ! lWizard
				SetPrvt("MV_PAR"+AllTrim(STRZERO(nx,2,0)))
				&("MV_PAR"+AllTrim(STRZERO(nx,2,0))) := u_ParaLoad(cLoad,aParametros,nx,aParametros[nx,3],Iif(Len(aParametros[nx])>9,aParametros[nx,10],.F.))
			EndIf
			
			if aParametros[nx,9] // Campo Obrigatorio
				cTextSay :="{||'<b>"+STRTRAN(aParametros[nx,2],"'",'"')+" ? "+ "<font color=red size=2 face=verdana,helvetica>*</font></b>"+"'}"
				TSay():New( nLinha, 15 , MontaBlock(cTextSay)  , oPanel , ,,,,,.T.,CLR_BLACK,,100,  ,,,,,,.T.)
			else
				cTextSay:= "{||'"+STRTRAN(aParametros[nx,2],"'",'"')+" ? "+"'}"
				TSay():New( nLinha, 15 , MontaBlock(cTextSay) , oPanel , ,,,,,.T.,CLR_BLACK,,100,,,,,,)
			endif	
			
			cWhen	:= Iif(Empty(aParametros[nx,7]),".T.",aParametros[nx,7])
			cValid	:=Iif(Empty(aParametros[nx,5]),".T.",aParametros[nx,5])
			cF3		:=Iif(Empty(aParametros[nx,6]),NIL,aParametros[nx,6])
			
			If ! lWizard
				cBlkGet := "{ | u | If( PCount() == 0, "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+","+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
			Else
				cBlkGet := "{ | u | If( PCount() == 0, "+"aRet["+AllTrim(STRZERO(nx,2,0))+"],"+"aRet["+AllTrim(STRZERO(nx,2,0))+"] := "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
			EndIf
			
			cBlKVld  := "{|| " + cValid + "}"
			cBlKWhen := "{|| " + cWhen  + "}"
			
			If u_ParaLoad(cLoad,aParametros,0,"1")=="2"
				cBlKWhen := "{|| .F. }"
			EndIf

			//*****************************************************
			// Auto Ajusta da Get para Campos Caracter e Numerico *
			// Somente para o Modulo PCO - Acacio Egas            *
			//*****************************************************
			
			If Type("cModulo")=="C" .and. cModulo=="PCO" .and. !lWizard
			
				cType := Type("MV_PAR"+AllTrim(STRZERO(nx,2,0)))
			
				If cType $ "C"
			
					nWidth	:= CalcFieldSize(cType,Len(aParametros[nx,3]),,aParametros[nx,4],"") + 10 + If(!Empty(cF3),10,0)
			
				ElseIf cType $ "N"
			
					nWidth	:= CalcFieldSize(cType,,,aParametros[nx,4],"") + 10
			
				Else
			
					nWidth	:= aParametros[nx,8]
			
				EndIf
			
			Else
			
				nWidth	:= aParametros[nx,8]
			
			EndIf
			
			// 'If' para corrigir um problema do campo get quando possui F3 (Lupa) em um panel do wizard. Quando campo menor que 50, a lupa some.
			If lWizard
			
				IF Type("nWidth")<> "U"
			
					TGet():New( nLinha,100,&cBlKGet,oPanel,If(nWidth<30,30,nWidth),,aParametros[nx,4], &(cBlkVld),,,, .T.,, .T.,, .T., &(cBlkWhen), .F., .F.,, .F., .F. ,cF3,"MV_PAR"+AllTrim(STRZERO(nx,2,0)),,,,.T.)
			
				Else
			
					cType := ValType(aRet[nx])
					nWidth := ParBGetSize(cType,aParametros,cF3,nx)
					TGet():New( nLinha,100,&cBlKGet,oPanel,nWidth,,aParametros[nx,4], &(cBlkVld),,,, .T.,, .T.,, .T., &(cBlkWhen), .F., .F.,, .F., .F. ,cF3,"MV_PAR"+AllTrim(STRZERO(nx,2,0)),,,,.T.)
			
				Endif
			
			Else
			
				TGet():New( nLinha,100,&cBlKGet,oPanel,nWidth,,aParametros[nx,4], &(cBlkVld),,,, .T.,, .T.,, .T., &(cBlkWhen), .F., .F.,, .F., .F. ,cF3,"MV_PAR"+AllTrim(STRZERO(nx,2,0)),,,,.T.)
			
			Endif
		
		Case aParametros[nx,1]==2 // SAY + COMBO
		
			If ! lWizard
		
				SetPrvt("MV_PAR"+AllTrim(STRZERO(nx,2,0)))
				&("MV_PAR"+AllTrim(STRZERO(nx,2,0))) := u_ParaLoad(cLoad,aParametros,nx,aParametros[nx,3])
		
			EndIf
			
    		if aParametros[nx,7] // Campo Obrigatorio
		
				cTextSay :="{||'<b>"+STRTRAN(aParametros[nx,2],"'",'"')+" ? "+ "<font color=red size=2 face=verdana,helvetica>*</font></b>"+"'}"
				TSay():New( nLinha, 15 , MontaBlock(cTextSay)  , oPanel , ,,,,,.T.,CLR_BLACK,,100,  ,,,,,,.T.)
		
			else
		
				cTextSay:= "{||'"+STRTRAN(aParametros[nx,2],"'",'"')+" ? "+"'}"
				TSay():New( nLinha, 15 , MontaBlock(cTextSay) , oPanel , ,,,,,.T.,CLR_BLACK,,100,,,,,,)
		
			endif	
			
			cWhen   := ".T."
		
			If Len(aParametros[nx]) > 7
		
				If aParametros[nx,8] != NIL .And. ValType(aParametros[nx,8])=="L"
					cWhen	:=If(aParametros[nx,8],".T.",".F.")
				Else
					cWhen	:= Iif(Len(aParametros[nx]) < 8 .Or. Empty(aParametros[nx,8]) .Or. aParametros[nx,8] == Nil,".T.",aParametros[nx,8])
				EndIf
		
			EndIf
		
			cValid	:=Iif(Empty(aParametros[nx,6]),".T.",aParametros[nx,6])
			cBlKVld := "{|| "+cValid+"}"
		
			If ! lWizard
			
				cBlkGet := "{ | u | If( PCount() == 0, "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+","+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
        	
			Else
			
				cBlkGet := "{ | u | If( PCount() == 0, "+"aRet["+AllTrim(STRZERO(nx,2,0))+"],"+"aRet["+AllTrim(STRZERO(nx,2,0))+"] := "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
			
			EndIf
			
			cBlkWhen := "{|| "+cWhen+" }"
			
			If u_ParaLoad(cLoad,aParametros,0,"1")=="2"
				cBlKWhen := "{|| .F. }"
			EndIf
			
			TComboBox():New( nLinha,100, &cBlkGet,aParametros[nx,4], aParametros[nx,5], 10, oPanel, ,,       ,,,.T.,,,.F.,&(cBlkWhen),.T.,,,,"MV_PAR"+AllTrim(STRZERO(nx,2,0)))

		Case aParametros[nx,1]==3 // SAY + RADIO
			
			nLinha += 8
			
			If ! lWizard
			
				SetPrvt("MV_PAR"+AllTrim(STRZERO(nx,2,0)))
				&("MV_PAR"+AllTrim(STRZERO(nx,2,0))) := u_ParaLoad(cLoad,aParametros,nx,aParametros[nx,3])
			
			EndIf
			
			cTextSay:= "{||'"+aParametros[nx,2]+" ? "+"'}"
			TGroup():New( nLinha-8,15, nLinha+(Len(aParametros[nx,4])*9)+7,205,aParametros[nx,2]+ " ? ",oPanel,If(aParametros[nx,7],CLR_HBLUE,CLR_BLACK),,.T.)
			cWhen   := ".T."
			
			If Len(aParametros[nx]) > 7
				If aParametros[nx,8] != NIL .And. ValType(aParametros[nx,8])=="L"
					cWhen	:=If(aParametros[nx,8],".T.",".F.")
				Else
					cWhen	:= Iif(Len(aParametros[nx]) < 8 .Or. Empty(aParametros[nx,8]) .Or. aParametros[nx,8] == Nil,".T.",aParametros[nx,8])
				EndIf
			EndIf
			
			If ! lWizard
				cBlkGet := "{ | u | If( PCount() == 0, "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+","+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
            Else
				cBlkGet := "{ | u | If( PCount() == 0, "+"aRet["+AllTrim(STRZERO(nx,2,0))+"],"+"aRet["+AllTrim(STRZERO(nx,2,0))+"] := "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
			EndIf
			
			cBlkWhen := "{|| " + cWhen  +  "}"
			
			If u_ParaLoad(cLoad,aParametros,0,"1")=="2"
			
				cBlKWhen := "{|| .F. }"
			
			EndIf
			
			TRadMenu():New( nLinha, 30, aParametros[nx,4],&cBlkGet, oPanel,,,,,,,&(cBlkWhen),aParametros[nx,5],9, ,,,.T.)
			
			nLinha += (Len(aParametros[nx,4])*10)-3

		Case aParametros[nx,1]==4 // SAY + CheckBox
			
			If ! lWizard
			
				SetPrvt("MV_PAR"+AllTrim(STRZERO(nx,2,0)))
				&("MV_PAR"+AllTrim(STRZERO(nx,2,0))) := u_ParaLoad(cLoad,aParametros,nx,aParametros[nx,3])
			
			EndIf
			
			If ! lWizard
			
				cBlkGet := "{ | u | If( PCount() == 0, "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+","+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
			
			Else
			
				cBlkGet := "{ | u | If( PCount() == 0, "+"aRet["+AllTrim(STRZERO(nx,2,0))+"],"+"aRet["+AllTrim(STRZERO(nx,2,0))+"] := "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
			
			EndIf
			
			if aParametros[nx,7] // Campo Obrigatorio
			
				cTextSay :="{||'<b>"+STRTRAN(aParametros[nx,2],"'",'"')+"  "+ "<font color=red size=2 face=verdana,helvetica>*</font></b>"+"'}"
				TSay():New( nLinha, 15 , MontaBlock(cTextSay)  , oPanel , ,,,,,.T.,CLR_BLACK,,100,  ,,,,,,.T.)
			
			else
			
				cTextSay:= "{||'"+STRTRAN(aParametros[nx,2],"'",'"')+"  "+"'}"
				TSay():New( nLinha, 15 , MontaBlock(cTextSay) , oPanel , ,,,,,.T.,CLR_BLACK,,100,,,,,,)
			
			endif	
			
			cBlkWhen := Iif(Len(aParametros[nx]) > 7 .And. !Empty(aParametros[nx,8]),aParametros[nx,8],"{|| .T. }")
			
			If (Len(aParametros[nx]) > 6 .And. aParametros[nx,7]).Or. u_ParaLoad(cLoad,aParametros,0,"1")=="2"
				cBlKWhen := "{|| .F. }"
			EndIf
			
			TCheckBox():New(nLinha,100,aParametros[nx,4], &cBlkGet,oPanel, aParametros[nx,5],10,,,,,,,,.T.,,,&(cBlkWhen))

		Case aParametros[nx,1]==5 // CheckBox Linha Inteira
			
			If ! lWizard
			
				SetPrvt("MV_PAR"+AllTrim(STRZERO(nx,2,0)))
				&("MV_PAR"+AllTrim(STRZERO(nx,2,0))) := u_ParaLoad(cLoad,aParametros,nx,aParametros[nx,3])
			
			EndIf
			
			If ! lWizard
				cBlkGet := "{ | u | If( PCount() == 0, "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+","+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
            Else
				cBlkGet := "{ | u | If( PCount() == 0, "+"aRet["+AllTrim(STRZERO(nx,2,0))+"],"+"aRet["+AllTrim(STRZERO(nx,2,0))+"] := "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
			EndIf
			
			cBlkWhen := "{|| .T. }"
			
			If (Len(aParametros[nx]) > 6 .And. aParametros[nx,7]) .Or. u_ParaLoad(cLoad,aParametros,0,"1")=="2"
				cBlKWhen := "{|| .F. }"
			EndIf
			
			TCheckBox():New(nLinha,15,aParametros[nx,2], &cBlkGet,oPanel, aParametros[nx,4],10,,,,,,,,.T.,,,&(cBlkWhen))

		Case aParametros[nx,1]==6 // File + Procura de Arquivo
			
			If ! lWizard
			
				SetPrvt("MV_PAR"+AllTrim(STRZERO(nx,2,0)))
				&("MV_PAR"+AllTrim(STRZERO(nx,2,0))) := u_ParaLoad(cLoad,aParametros,nx,aParametros[nx,3])
			
			EndIf
			
			if aParametros[nx,8] // Campo Obrigatorio
			
				cTextSay :="{||'<b>"+STRTRAN(aParametros[nx,2],"'",'"')+" ? "+ "<font color=red size=2 face=verdana,helvetica>*</font></b>"+"'}"
				TSay():New( nLinha, 15 , MontaBlock(cTextSay)  , oPanel , ,,,,,.T.,CLR_BLACK,,100,  ,,,,,,.T.)
			
			else
			
				cTextSay:= "{||'"+STRTRAN(aParametros[nx,2],"'",'"')+" ? "+"'}"
				TSay():New( nLinha, 15 , MontaBlock(cTextSay) , oPanel , ,,,,,.T.,CLR_BLACK,,100,,,,,,)
			
			endif	
			
			cWhen	:= Iif(Empty(aParametros[nx,6]),".T.",aParametros[nx,6])
			cValid	:= Iif(Empty(aParametros[nx,5]),".T.","("+aParametros[nx,5]+").Or.Vazio("+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+")")
			
			If ! lWizard
			
				cBlkGet := "{ | u | If( PCount() == 0, "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+","+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
            
			Else
			
				cBlkGet := "{ | u | If( PCount() == 0, "+"aRet["+AllTrim(STRZERO(nx,2,0))+"],"+"aRet["+AllTrim(STRZERO(nx,2,0))+"] := "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
			
			EndIf
			
			cBlKVld   := "{|| " + cValid + "}"
			cBlKWhen  := "{|| " + cWhen + "}"
			cArquivos := aParametros[nx,9]

			If Len(aParametros[nx]) >= 10
			
				cPath := aParametros[nx,10]
			
			EndIf

			If u_ParaLoad(cLoad,aParametros,0,"1")=="2"
			
				cBlKWhen := "{|| .F. }"
			
			EndIf

			If Len(aParametros[nX]) >= 11
			
				cOpcoes := AllTrim(Str(aParametros[nx,11]))
			Else
			
				cOpcoes := AllTrim(Str(GETF_LOCALHARD+GETF_LOCALFLOPPY))
			
			Endif

			If Len(aParametros[nX]) >= 12
			
				lServidor := aParametros[nx,12]
			
			Else
			
				lServidor := .T.
			
			Endif

			If lWizard
            
				cGetfile := "{|| aRet["+AllTrim(STRZERO(nx,2,0))+"] := MV_PAR"+AllTrim(STRZERO(nx,2,0))+" := cGetFile(cArquivos,'"+;
								"Arquivos ',0,cPath,.T.,"+cOpcoes+;
			            		",lServidor)+SPACE(40), If(Empty(MV_PAR"+AllTrim(STRZERO(nx,2,0))+;
            					"), MV_PAR"+AllTrim(STRZERO(nx,2,0))+" := '"+;
		               			aParametros[nx,3]+"',)  }"
		 	Else
				
				cGetfile := "{|| MV_PAR"+AllTrim(STRZERO(nx,2,0)) + " := cGetFile(cArquivos,'" + ;
								"Arquivos ',0,cPath,.T.," + cOpcoes + ;
								",lServidor) + SPACE(40), If(Empty(MV_PAR" + AllTrim(STRZERO(nx,2,0)) + ;
								"), MV_PAR"+AllTrim(STRZERO(nx,2,0)) + " := '" + ;
								aParametros[nx,3]+"',)  }"
			EndIf

			TGet():New( nLinha,100 ,&cBlKGet,oPanel,aParametros[nx,7],,aParametros[nx,4], &(cBlkVld),,,, .T.,, .T.,, .T., &(cBlkWhen), .F., .F.,, .F., .F. ,,"MV_PAR"+AllTrim(STRZERO(nx,2,0)))
			TButton():New( nLinha,100+aParametros[nx,7], "Procura de Arquivo", oPanel,&(cGetFile), 29, 12, , oDlg:oFont, ,.T.,.F.,,.T., ,, .F.)

		Case aParametros[nx,1]==7 //.And. ! lWizard// Filtro de Arquivos

			nLinha += 8

			If !lWizard

				SetPrvt("MV_PAR"+AllTrim(STRZERO(nx,2,0)))
				&("MV_PAR"+AllTrim(STRZERO(nx,2,0))) := u_ParaLoad(cLoad,aParametros,nx,aParametros[nx,4])
				SetPrvt("MV_FIL"+AllTrim(STRZERO(nx,2,0)))
				&("MV_FIL"+AllTrim(STRZERO(nx,2,0))) := MontDescr(aParametros[nx,3],u_ParaLoad(cLoad,aParametros,nx,aParametros[nx,4]))

			EndIf

			TGroup():New( nLinha-8,15, nLinha+40,170,aParametros[nx,2]+ " ? ",oPanel,,,.T.)
			cWhen   := ".T."

			If Len(aParametros[nx]) > 4

				If aParametros[nx,5] != NIL .And. ValType(aParametros[nx,5])=="L"
					cWhen	:=If(aParametros[nx,5],".T.",".F.")
				Else
					cWhen	:= Iif(Len(aParametros[nx]) < 5 .Or. Empty(aParametros[nx,5]) .Or. aParametros[nx,5] == Nil,".T.",aParametros[nx,5])
				EndIf

			EndIf

			cValid	:=".T."

			If !lWizard
				cBlkGet := "{ | u | If( PCount() == 0, "+"MV_FIL"+AllTrim(STRZERO(nx,2,0))+","+"MV_FIL"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
			Else
				cBlkGet := "{ | u | If( PCount() == 0, MontDescr('"+aParametros[nx,3]+"',aRet["+AllTrim(STRZERO(nx,2,0))+"]),"+;
																	" MV_FIL"+AllTrim(STRZERO(nx,2,0))+":= u ) }"

			EndIf

			cBlKVld := "{|| "+cValid+"}"
			cBlKWhen := "{|| "+cWhen+"}"

			If u_ParaLoad(cLoad,aParametros,0,"1")=="2"
				cBlKWhen := "{|| .F. }"
			EndIf

			If !lWizard
				cGetFilter := "{|| MV_PAR"+AllTrim(STRZERO(nx,2,0))+" := BuildExpr('"+aParametros[nx,3]+"',,MV_PAR"+AllTrim(STRZERO(nx,2,0))+"),MV_FIL"+AllTrim(STRZERO(nx,2,0))+":=MontDescr('"+aParametros[nx,3]+"',MV_PAR"+AllTrim(STRZERO(nx,2,0))+") }"
			Else
				cGetFilter := "{|| aRet["+AllTrim(STRZERO(nx,2,0))+"] := MV_PAR"+AllTrim(STRZERO(nx,2,0))+" := BuildExpr('"+aParametros[nx,3]+"',,aRet["+AllTrim(STRZERO(nx,2,0))+"]),MV_FIL"+AllTrim(STRZERO(nx,2,0))+":=MontDescr('"+aParametros[nx,3]+"',aRet["+AllTrim(STRZERO(nx,2,0))+"]) }"
			EndIf

			TButton():New( nLinha,18, "Editar", oPanel,&(cGetFilter), 35, 14, , oDlg:oFont, ,.T.,.F.,,.T.,&(cBlkWhen),, .F.)
			TMultiGet():New( nLinha, 55, &cBlKGet,oPanel,109,33,,,,,,.T.,,.T.,&(cBlkWhen),,,.T.,&(cBlkVld),,.T.,.F., )
			nLinha += 31

		Case aParametros[nx,1]==8 // SAY + GET PASSWORD

			If ! lWizard

				SetPrvt("MV_PAR"+AllTrim(STRZERO(nx,2,0)))
				&("MV_PAR"+AllTrim(STRZERO(nx,2,0))) := u_ParaLoad(cLoad,aParametros,nx,aParametros[nx,3])

			EndIf

			if aParametros[nx,9] // Campo Obrigatorio

				cTextSay :="{||'<b>"+STRTRAN(aParametros[nx,2],"'",'"')+" ? "+ "<font color=red size=2 face=verdana,helvetica>*</font></b>"+"'}"
				TSay():New( nLinha, 15 , MontaBlock(cTextSay)  , oPanel , ,,,,,.T.,CLR_BLACK,,100,  ,,,,,,.T.)

			else

				cTextSay:= "{||'"+STRTRAN(aParametros[nx,2],"'",'"')+" ? "+"'}"
				TSay():New( nLinha, 15 , MontaBlock(cTextSay) , oPanel , ,,,,,.T.,CLR_BLACK,,100,,,,,,)

			endif	
			
			cWhen	:= Iif( Empty( aParametros[nx,7] ), ".T.", aParametros[nx,7] )
			cValid	:= Iif( Empty( aParametros[nx,5] ), ".T.", aParametros[nx,5] )
			cF3		:= Iif( Empty( aParametros[nx,6] ),  NIL , aParametros[nx,6] )
			
			If ! lWizard
			
				cBlkGet := "{ | u | If( PCount() == 0, "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+","+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
            
			Else
			
				cBlkGet := "{ | u | If( PCount() == 0, "+"aRet["+AllTrim(STRZERO(nx,2,0))+"],"+"aRet["+AllTrim(STRZERO(nx,2,0))+"] := "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
			
			EndIf
			
			cBlKVld  := "{|| " + cValid + "}"
			cBlKWhen := "{|| " + cWhen  + "}"
			
			If u_ParaLoad(cLoad,aParametros,0,"1")=="2"
				
				cBlKWhen := "{|| .F. }"
			
			EndIf
			
			TGet():New( nLinha,100 ,&cBlKGet,oPanel,aParametros[nx,8],,aParametros[nx,4], &(cBlkVld),,,, .T.,, .T.,, .T., &(cBlkWhen), .F., .F.,, .F., .T. ,cF3,"MV_PAR"+AllTrim(STRZERO(nx,2,0)),,,,.T.)
		
		Case aParametros[nx,1]==9 // SAY
        
		    cTextSay:= "{||'"+STRTRAN(aParametros[nx,2],"'",'"')+"'}"
		
			If aParametros[nx,5]
				TSay():New( nLinha, 15 , MontaBlock(cTextSay) , oPanel , ,oFntVerdana,,,,.T.,CLR_BLACK,,aParametros[nx,3],aParametros[nx,4],,,,,)
			Else
				TSay():New( nLinha, 15 , MontaBlock(cTextSay) , oPanel , ,,,,,.T.,CLR_BLACK,,aParametros[nx,3],aParametros[nx,4],,,,,)
			EndIf
		
		Case aParametros[nx,1]==10 // Range (fase experimental)
		
			nLinha += 8
			SetPrvt("MV_PAR"+AllTrim(STRZERO(nx,2,0)))
			&("MV_PAR"+AllTrim(STRZERO(nx,2,0))) := u_ParaLoad(cLoad,aParametros,nx,aParametros[nx,3])
			
			SetPrvt("MV_RAN"+AllTrim(STRZERO(nx,2,0)))
			&("MV_RAN"+AllTrim(STRZERO(nx,2,0))) := PMSRangeDesc(	&("MV_PAR"+AllTrim(STRZERO(nx,2,0))),aParametros[nx,7])
			
			TGroup():New( nLinha-8,15, nLinha+40,170,"Range de "+aParametros[nx,2],oPanel,,,.T.)		//"Range de "
		
			If Type(aParametros[nx,8])=="L" .And. !Empty(aParametros[nx,8])
				cWhen	:= aParametros[nx,8]
			Else
				cWhen	:= ".T."
			EndIf
			
			cValid	 := ".T."
			cBlkGet  := "{ | u | If( PCount() == 0, "+"MV_RAN"+AllTrim(STRZERO(nx,2,0))+","+"MV_RAN"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
			cBlKWhen := "{|| "+cWhen+"}"
			
			If u_ParaLoad(cLoad,aParametros,0,"1")=="2"
				cBlKWhen := "{|| .F. }"
			EndIf
			
			cGetRange := "{|| MV_PAR"+AllTrim(STRZERO(nx,2,0))+" := PmsRange('"+aParametros[nx,2]+"','"+aParametros[nx,4]+"',"+Str(aParametros[nx,5])+",MV_PAR"+AllTrim(STRZERO(nx,2,0))+",'"+aParametros[nx,6]+"',"+Str(aParametros[nx,7])+"),	MV_RAN"+AllTrim(STRZERO(nx,2,0))+" := PMSRangeDesc( MV_PAR"+AllTrim(STRZERO(nx,2,0))+","+Str(aParametros[nx,7])+") }"
	   		
			TButton():New( nLinha-2,18, "Editar", oPanel,MontaBlock(cGetRange), 35, 14, , oDlg:oFont, ,.T.,.F.,,.T.,&(cBlkWhen),, .F.) //"Editar"
			TMultiGet():New( nLinha, 55, &cBlKGet,oPanel,109,33,,,,,,.T.,,.T.,&(cBlkWhen),,,.T.,/*&(cBlkVld)*/,,.T.,.F., )
			
			nLinha += 31
		
		Case aParametros[nx,1]==11 // MULTIGET - campo memo
		
			nLinha += 10
			SetPrvt("MV_PAR"+AllTrim(STRZERO(nx,2,0)))
			&("MV_PAR"+AllTrim(STRZERO(nx,2,0))) := u_ParaLoad(cLoad,aParametros,nx,aParametros[nx,3])
			TGroup():New( nLinha-8,15, nLinha+40,200,"",oPanel,,,.T.)
		
			if aParametros[nx,6] // Campo Obrigatorio
				cTextSay :="{||'<b>"+STRTRAN(aParametros[nx,2],"'",'"')+" ? "+ "<font color=red size=2 face=verdana,helvetica>*</font></b>"+"'}"
				TSay():New( nLinha - 6, 23 , MontaBlock(cTextSay)  , oPanel , ,,,,,.T.,CLR_BLACK,,100,  ,,,,,,.T.)
			else
				cTextSay:= "{||'"+STRTRAN(aParametros[nx,2],"'",'"')+" ? "+"'}"
				TSay():New( nLinha - 6, 23 , MontaBlock(cTextSay) , oPanel , ,,,,,.T.,CLR_BLACK,,100,,,,,,)
			endif	
			
			cValid   := Iif(Empty(aParametros[nx,4]),".T.",aParametros[nx,4])
			cWhen    := Iif(Empty(aParametros[nx,5]),".T.",aParametros[nx,5])
			cBlkGet  := "{ | u | If( PCount() == 0, "+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+","+"MV_PAR"+AllTrim(STRZERO(nx,2,0))+":= u ) }"
			cBlkVld  := "{|| " + cValid + "}"
			cBlkWhen := "{|| " + cWhen + "}"
		
			If u_ParaLoad(cLoad,aParametros,0,"1")=="2"
				cBlKWhen := "{|| .F. }"
			Endif

			TMultiGet():New(nLinha+1,23,&cBlkGet,oPanel,170,33,/*oFont*/,/*lHScroll*/,/*nClrFore*/,/*nClrBack*/,/*oCursor*/,.T.,/*cMg*/,;
			.T.,&(cBlkWhen),/*lCenter*/,/*lRight*/,.F.,&(cBlkVld),/*bChange*/,.T.,.F.)
		
			nLinha += 31
		
		Case aParametros[nx,1]==12 // FILTROS DE USUARIO POR ROTINA
			
			nLinha += 8
			SetPrvt("MV_FIL"+AllTrim(STRZERO(nx,2,0)))
			
			If len(aParametros[nx])>3
				&("MV_FIL"+AllTrim(STRZERO(nx,2,0))) := u_ParaLoad(cLoad,aParametros,nx,aParametros[nx,4])
			Else
				&("MV_FIL"+AllTrim(STRZERO(nx,2,0))) := ""
			EndIf
			
			SetPrvt("MV_PAR"+AllTrim(STRZERO(nx,2,0)))
			&("MV_PAR"+AllTrim(STRZERO(nx,2,0))) := ""
			cTextSay := ""
			
			If Len(aParametros[nx]) > 1
				If aParametros[nx,2] != Nil .And. ValType(aParametros[nx,2])=="C"
					cTextSay := aParametros[nx,2]
				EndIf
			Else
				AADD(aParametros[nx], "")
			EndIf
			
			cAlias := ""
			
			If Len(aParametros[nx]) > 2
			
				If aParametros[nx,3] != Nil .And. ValType(aParametros[nx,3])=="C"
					cAlias	:= aParametros[nx,3]
				EndIf
			
			Else
			
				AADD(aParametros[nx], "")
			
			EndIf
			
			If empty(cAlias)
			
				If PcoX2ConPad(cAlias)
			
					cAlias := PcoSX2Cons()
				Else
					cAlias := ALIAS()
				EndIf
			EndIf
			
			If empty(aParametros[nx,3])
				aParametros[nx,3] := cAlias
			EndIf
			
			cWhen   := ".T."
			
			If Len(aParametros[nx]) > 4
			
				If aParametros[nx,5] != Nil .And. ValType(aParametros[nx,5])=="L"
					cWhen	:= If(aParametros[nx,5],".T.",".F.")
				EndIf
			EndIf
			
			cBlkWhen := "{|| "+cWhen+" }"
			
			If u_ParaLoad(cLoad,aParametros,0,"1")=="2"
				cBlKWhen := "{|| .F. }"
			EndIf
			
			aOpcoes := {"Visualizar todos os registros"}
			cBlkWhen2:=cBlKWhen
			dbSelectArea("AN7")
			
			AN7->(dbSetOrder(1))
			AN7->(MsSeek(cFilAN7+oApp:cUserID+cRotina+cAlias))
			
			Do While !AN7->(Eof()) .And. AN7->(AN7_FILIAL+AN7_USER+AN7_FUNCAO+AN7_ALIAS)==cFilAN7+oApp:cUserID+cRotina+cAlias
				AADD(aOpcoes, AN7->AN7_FILTR)
				AN7->(dbSkip())
			EndDo
			
			TGroup():New( nLinha-8,15, nLinha+20,170, cTextSay,oPanel,,,.T.)
			cBlKVld := "{|| .T.}"
			cBlkGet := "{ | u | If( PCount() == 0, MV_FIL"+AllTrim(STRZERO(nx,2,0))+", MV_FIL"+AllTrim(STRZERO(nx,2,0))+":= u) }"
			
			SetPrvt("oCombo"+AllTrim(STRZERO(nx,2,0)))
			&("oCombo"+AllTrim(STRZERO(nx,2,0))) := TComboBox():New( nLinha+4, 20, &cBlkGet, aOpcoes, 100, 10, oPanel,,,,,,.T.,,,.F.,&(cBlkWhen),.T.,,,,"MV_FIL"+AllTrim(STRZERO(nx,2,0)))

			cAux := "{|| MV_PAR"+AllTrim(STRZERO(nx,2,0))+" := PmsGetFilt( oApp:cUserID, cRotina, '"+cAlias+"', MV_FIL"+AllTrim(STRZERO(nx,2,0))+" )}"
	   		TBtnBmp2():New( (nLinha+4)*2, 120*2, 25, 25, "FILTRO1"  , , , , &cAux , oPanel, "Aplicar filtro selecionado", &(cBlkWhen), )
			
			cAux := "{|| PmsIncFilt( aParametros, oApp:cUserID, cRotina, '"+cAlias+"' )}"
	   		TBtnBmp2():New( (nLinha+4)*2, 132*2, 25, 25, "BPMSDOCI" , , , , &cAux , oPanel, "Novo filtro", &(cBlkWhen2), )
			
			cAux := "{|| PmsAltFilt( aParametros, oCombo"+AllTrim(STRZERO(nx,2,0))+":nAt, oApp:cUserID, cRotina, '"+cAlias+"', MV_FIL"+AllTrim(STRZERO(nx,2,0))+" )}"
	   		TBtnBmp2():New( (nLinha+4)*2, 144*2, 25, 25, "BPMSDOCA" , , , , &cAux , oPanel, "Editar filtro selecionado", &(cBlkWhen2), )
			cAux := "{|| PmsExcFilt( aParametros, oCombo"+AllTrim(STRZERO(nx,2,0))+":nAt, oApp:cUserID, cRotina, '"+cAlias+"', MV_FIL"+AllTrim(STRZERO(nx,2,0))+" )}"
	   		
			TBtnBmp2():New( (nLinha+4)*2, 156*2, 25, 25, "BPMSDOCE" , , , , &cAux , oPanel, "Excluir o filtro selecionado", &(cBlkWhen2), )
			nLinha += 11

    EndCase

	nLinha += 17

Next


lGrpAdm := .F.
cCodUsr := RetCodUsr()

If !Empty(cCodUsr)
	lGrpAdm := PswAdmin( /*cUser*/, /*cPsw*/,cCodUsr)==0
EndIf

If !lWizard .And.  lGrpAdm .And. lCanSave

	@ nlinha+8,10 BUTTON oButton PROMPT "+" SIZE 10 ,7   ACTION {|| ParamSave(cLoad,aParametros,"1") } OF oPanel PIXEL
	@ nlinha+8,22 SAY "Administrador: Salvar configuações" SIZE 120,7 Of oPanel FONT oFntVerdana COLOR RGB(80,80,80) PIXEL //"Administrador: Salvar configuações"
	oButton:cToolTip := "Clique aqui para salvar as configurações de: " + cTitle //"Clique aqui para salvar as configurações de: "

	@ nlinha+15,10 BUTTON oButton PROMPT "+" SIZE 10 ,7   ACTION {|| ParamSave(cLoad,aParametros,"2"),Alert("Bloqueio efetuado. Os parametros estarão bloqueados a partir da próxima chamada.") } OF oPanel PIXEL  //"Bloqueio efetuado. Os parametros estarão bloqueados a partir da próxima chamada."
	@ nlinha+15,22 SAY "Administrador: Bloquear" SIZE 120,7 Of oPanel FONT oFntVerdana COLOR RGB(80,80,80) PIXEL //"Administrador: Bloquear"
	oButton:cToolTip := "Clique aqui para bloquear as configurações de: " + cTitle //"Clique aqui para bloquear as configurações de: "

	@ nlinha+22,10 BUTTON oButton PROMPT "+" SIZE 10 ,7   ACTION {|| ParamSave(cLoad,aParametros,"1"),Alert("Desbloqueio efetuado. Os parametros estarão desbloqueados a partir da próxima chamada.")  } OF oPanel PIXEL  //"Desbloqueio efetuado. Os parametros estarão desbloqueados a partir da próxima chamada."
	@ nlinha+22,22 SAY "Administrador: Desbloquear" SIZE 120,7 Of oPanel FONT oFntVerdana COLOR RGB(80,80,80) PIXEL //"Administrador: Desbloquear"
	oButton:cToolTip := "Clique aqui para desbloquear as configurações de: "+ cTitle //"Clique aqui para desbloquear as configurações de: "

EndIf

If loMainWnd
	oMainWnd:CoorsUpdate()
EndIf

If ! lWizard
	oPanelB := TPanel():New(0,0,'',oDlg, oDlg:oFont, .T., .T.,, ,40,20,.T.,.T. )
	oPanelB:Align := CONTROL_ALIGN_BOTTOM

	For nx := 1 to Len(aButtons)
		SButton():New( 4, 157-(nx*33), aButtons[nx,1],aButtons[nx,2],oPanelB,.T.,IIf(Len(aButtons[nx])==3,aButtons[nx,3],Nil),)
	Next

	//DEFINE SBUTTON FROM 4, 114   TYPE 4 ENABLE OF oDlg ACTION ParamSave(cLoad,aParametros)

	DEFINE SBUTTON FROM 4, 157   TYPE 1 ENABLE OF oPanelB ACTION (If(ParamOk(aParametros,@aRet).And.Eval(bOk),(oDlg:End(),lOk:=.T.),(lOk:=.F.)))
	DEFINE SBUTTON FROM 4, 190   TYPE 2 ENABLE OF oPanelB ACTION (lOk:=.F.,oDlg:End())

	If loMainWnd .AND. (nLinha*2) + 80 > oMainWnd:nBottom-oMainWnd:nTop
		nBottom  := oDLg:nTop + oMAinWnd:nBottom-oMAinWnd:nTop - 105
	Else
		nBottom := oDLg:nTop + (nLinha*2) + 80
	EndIf

	nBottom := MAX(310,nBottom)
	oDlg:nBottom := nBottom

EndIf

If ! lWizard

	ACTIVATE MSDIALOG oDlg CENTERED

	If lOk .And. lUserSave
		ParamSave(cLoad,aParametros,"1")
	Endif

EndIf

Return lOk


//*******************************************************************************************************************


//*******************************************************************************************************************

User Function ParaLoad(cLoad,aParametros,nx,xDefault,lDefault)
local ny
Local cBarra 		:= "\"		//If(issrvunix(), "/", "\")
Local cTypeData 	:= NIL
DEFAULT lDefault 	:= .F.

If File(cBarra + "PROFILE" + cBarra +Alltrim(cLoad)+".PRB")
	If FT_FUse(cBarra +"PROFILE"+cBarra+Alltrim(cLoad)+".PRB")<> -1
		FT_FGOTOP()
		If nx == 0
			cLinha := FT_FREADLN()
			FT_FUSE()
			Return Substr(cLinha,1,1)
		EndIf
		For ny := 1 to nx
			FT_FSKIP()
		Next
		cLinha := FT_FREADLN()
		If !lDefault
			cTypeData := Valtype(xDefault)
			Do case
				Case Substr(cLinha,1,1) == "L" .And. cTypeData == "L"
					xRet := If(Substr(cLinha,2,1)=="F",.F.,.T.)
				Case Substr(cLinha,1,1) == "D" .And. cTypeData == "D"
					xRet := CTOD(Substr(cLinha,2,10))
				Case Substr(cLinha,1,1) == "C" .And. cTypeData == "C"
					//**********************************************
					// Tratamento para aumentar o tamanha do campo *
					//**********************************************
					If VALTYPE(xDefault)=="C"
						xRet := Padr(Substr(cLinha,2,Len(cLinha)),Len(xDefault))
					Else
						xRet := Substr(cLinha,2,Len(cLinha))
					EndIf
				Case Substr(cLinha,1,1) == "N" .And. cTypeData == "N"
					xRet := Val(Substr(cLinha,2,Len(cLinha)))
				OtherWise
					xRet := xDefault
			EndCase
		Else
			xRet := xDefault
		Endif
		FT_FUSE()
	EndIf
Else
	xRet := xDefault
EndIf

Return xRet
