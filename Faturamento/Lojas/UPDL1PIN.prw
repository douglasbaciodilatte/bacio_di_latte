#Include "RWMAKE.CH" 
#Include "TOPCONN.CH"
#Include "TOTVS.CH"

/*/{Protheus.doc} UPDL1PIN
    @type User Function
    @author Felipe Mayer
    @since 09/08/2021
    @Desc Chamada parametros iniciais
/*/
User Function UPDL1PIN()

Private dDataDe  := SToD("")
Private dDataAt  := SToD("")

SetPrvt('oButton1','oButton2','oDlg')

    If !RetCodUsr() $ GetMv("MV_XDELNFS")
        MsgAlert('Usuário não possui permissão para acessar a rotina!','MV_XDELNFS')
		Return
    EndIf

    DEFINE MSDIALOG oDlg FROM 003,001 To 170,520 TITLE OemToAnsi("SL1/PIN") PIXEL   
        @ 005,003 To 080,258 LABEL "" OF oDlg  PIXEL
        @ 015,015 SAY OemToAnsi("Esta rotina realiza a atualização dos status de vendas com erro e duplicidade na camada") SIZE 268, 8 OF oDlg PIXEL
        @ 032,015 SAY OemToAnsi("Data de: ") SIZE 268, 8 OF oDlg PIXEL
        @ 030,040 MsGet dDataDe Size 50,10 OF oDlg PIXEL
        @ 032,120 SAY OemToAnsi("Data até: ") SIZE 268, 8 OF oDlg PIXEL
        @ 030,145 MsGet dDataAt Size 50,10 OF oDlg PIXEL
        @ 060,180 BUTTON oButton1 PROMPT "Cancelar"  SIZE 30,12   OF oDlg PIXEL ACTION oDlg:End()
        @ 060,218 BUTTON oButton2 PROMPT "Processar" SIZE 30,12   OF oDlg PIXEL ACTION (fProcess(),oDlg:End())
    ACTIVATE MSDIALOG oDlg CENTER
			
Return


/*/{Protheus.doc} fProcess
    @type Static Function
    @author Felipe Mayer
    @since 09/08/2021
    @Desc Responsavel pelo processamento
/*/
Static Function fProcess()

Local cQuery       := ''
Local nX           := 0
Local aAuxQry      := {}
Local nJanLarg     := 500
Local nJanAltu     := 250
Local oFontAno     := TFont():New("Tahoma",,-38)
Local oFontSub     := TFont():New("Tahoma",,-20)
Local oFontSubN    := TFont():New("Tahoma",,-20,,.T.)
Local oFontBtn     := TFont():New("Tahoma",,-14)
Local _stru        := {}
Local aCpoBro      := {}
Local lInverte     := .F.
Local oBtnSalv
Local oBtnFech

Private lMarkOk    := .F.
Private cMark      := GetMark()
Private oDlgPvt
Private oMark

    cQuery := CRLF + " SELECT COUNT(PIN_STAIMP) QUANTIDADE, 'PIN' TABELA "
    cQuery += CRLF + " FROM "+RetSqlName('PIN')+" (NOLOCK) "
    cQuery += CRLF + " WHERE PIN_STAIMP = '3' "
    cQuery += CRLF + "  	AND PIN_EMISNF BETWEEN '"+DToS(dDataDe)+"' AND '"+DToS(dDataAt)+"' "
    cQuery += CRLF + "  	AND PIN_LOGINT IN ('STR0130','STR0132') "
    cQuery += CRLF + "  	AND D_E_L_E_T_!='*' "
    cQuery += CRLF + " UNION "
    cQuery += CRLF + " SELECT COUNT(L1_SITUA) QUANTIDADE, 'SL1' TABELA "
    cQuery += CRLF + " FROM "+RetSqlName('SL1')+" (NOLOCK) "
    cQuery += CRLF + " WHERE L1_EMISNF BETWEEN '"+DToS(dDataDe)+"' AND '"+DToS(dDataAt)+"' "
    cQuery += CRLF + "  	AND L1_SITUA='ER' "
    cQuery += CRLF + "  	AND D_E_L_E_T_!='*' "

	If Select("TMP1") > 0
		DbSelectArea("TMP1")
		TMP1->(DbCloseArea())
	EndIf

    TcQuery cQuery New Alias "TMP1"

    While TMP1->(!EoF())
        aadd(aAuxQry,{;
            cValToChar(TMP1->QUANTIDADE) ,;
            TMP1->TABELA    })
        TMP1->(DbSkip())
    EndDo
        
    Aadd(_stru,{"OK"        ,"C" ,2	  ,0})
    Aadd(_stru,{"QUANTIDADE","C" ,4	  ,0})
    Aadd(_stru,{"TABELA"    ,"C" ,9	  ,0})

    cArq := Criatrab(_stru,.T.)

    DbUseArea(.T.,,cArq,"TTRB")

    For nX := 1 To Len(aAuxQry)
        DbSelectArea("TTRB")	
        RecLock("TTRB",.T.)		
            TTRB->QUANTIDADE :=  Alltrim(aAuxQry[nX,01])	
            TTRB->TABELA     :=  Alltrim(aAuxQry[nX,02])
        MsunLock()	
    Next nX

    aCpoBro	:= {;
        { "OK"			,, "Mark"       ,"@!"},;
        { "QUANTIDADE"	,, "Quantidade" ,"@!"},;
        { "TABELA"	    ,, "Tabela"     ,"@!"} }

    DEFINE MSDIALOG oDlgPvt TITLE "SL1/PIN" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL

    @ 004, 005 SAY "BDIL"            SIZE 200,030 FONT oFontAno  OF oDlgPvt COLORS RGB(149,179,215) PIXEL
    @ 004, 050 SAY "Ajuste Tabelas"  SIZE 200,030 FONT oFontSub  OF oDlgPvt COLORS RGB(031,073,125) PIXEL
    @ 014, 050 SAY "SL1/PIN"         SIZE 200,030 FONT oFontSubN OF oDlgPvt COLORS RGB(031,073,125) PIXEL

    @ (nJanAltu/2)-20,(nJanLarg/2-001)-(0052*02) BUTTON oBtnFech PROMPT "Fechar"  SIZE 035, 017 OF oDlgPvt ACTION (oDlgPvt:End()) FONT oFontBtn PIXEL
    @ (nJanAltu/2)-20,(nJanLarg/2-001)-(0052*01) BUTTON oBtnSalv PROMPT "Ajustar" SIZE 035, 017 OF oDlgPvt ACTION (fAjustar(),oDlgPvt:End()) FONT oFontBtn PIXEL
    
    DbSelectArea("TTRB")
    DbGotop()
    
    oMark := MsSelect():New("TTRB","OK","",aCpoBro,@lInverte,@cMark,{040,003,(nJanAltu/2)-30,(nJanLarg/2)-3},,,,,,)
    oMark:bMark := {| | fMarkNow()}
    
    ACTIVATE MSDIALOG oDlgPvt CENTERED

    TTRB->(DbCloseArea())
    Iif(File(cArq + GetDBExtension()),FErase(cArq  + GetDBExtension()) ,Nil)
        
Return
              

/*/{Protheus.doc} fMarkNow
    @type Static Function
    @author Felipe Mayer
    @since 09/08/2021
    @Desc Auxiliar Mark
/*/
Static Function fMarkNow()
   
    RecLock("TTRB",.F.)
        If Marked("OK")	
            TTRB->OK := cMark
        Else	
            TTRB->OK := ""
        Endif             
    MsunLock()

    oMark:oBrowse:Refresh()

Return


/*/{Protheus.doc} fAjustar
    @type Static Function
    @author Felipe Mayer
    @since 09/08/2021
/*/
Static Function fAjustar()

Local cQuery := ''

    DbSelectArea("TTRB")
    DbGotop()
    
    While TTRB->(!Eof())
        If !Empty(TTRB->OK)
        
            If Alltrim(TTRB->TABELA) == 'SL1' .And. Val(TTRB->QUANTIDADE) > 0
                cQuery := " UPDATE "+RetSqlName('SL1')+" SET L1_SITUA='RX' "
                cQuery += " WHERE L1_EMISNF BETWEEN '"+DToS(dDataDe)+"' AND '"+DToS(dDataAt)+"' "
                cQuery += " AND L1_SITUA='ER' "
                cQuery += " AND D_E_L_E_T_!='*' "

            ElseIf Alltrim(TTRB->TABELA) == 'PIN' .And. Val(TTRB->QUANTIDADE) > 0
                cQuery := " UPDATE "+RetSqlName('PIN')+" SET PIN_STAIMP='9' "
                cQuery += " WHERE PIN_STAIMP='3' "
                cQuery += " AND D_E_L_E_T_!='*' "
                cQuery += " AND PIN_EMISNF BETWEEN '"+DToS(dDataDe)+"' AND '"+DToS(dDataAt)+"' "
                cQuery += " AND PIN_LOGINT IN ('STR0130','STR0132') "
            EndIf
           
            TCSQLExec(cQuery)

        EndIf
    TTRB->(DbSkip())
    EndDo

    MsgInfo('Processo Cloncluído!')

Return
