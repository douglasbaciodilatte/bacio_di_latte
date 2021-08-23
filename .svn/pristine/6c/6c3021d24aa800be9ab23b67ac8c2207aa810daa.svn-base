#INCLUDE "RWMAKE.CH" 
#INCLUDE "TOPCONN.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "PARMTYPE.CH"
#INCLUDE "TOTVS.CH"

#DEFINE CMD_OPENWORKBOOK			1
#DEFINE CMD_CLOSEWORKBOOK			2
#DEFINE CMD_ACTIVEWORKSHEET			3
#DEFINE CMD_READCELL				4
#DEFINE ENTER chr(13)+chr(10)


/*/{Protheus.doc} DELXCODX
    @type User Function
    @author Felipe Mayer - RVacari
    @since 30/10/2020
    @Desc Chamada parametros iniciais
/*/
User Function DELXCODX()

Local cUsrPerm := GetMv("MV_XDELNFS")
SetPrvt('oButton1','oButton2','oButton3','oDlg')

    If !RetCodUsr() $ cUsrPerm
        MsgAlert('Usuário não possui permissão para acessar a rotina!','MV_XDELNFS')
		Return
    EndIf

    DEFINE MSDIALOG oDlg FROM 003,001 To 150,520 TITLE OemToAnsi("Excluir NFs Saída") PIXEL   
    @ 005,003 To 068,258 LABEL "" OF oDlg  PIXEL
    @ 015,015 SAY OemToAnsi("Esta rotina realiza a processamento de NFs de Saída para exclusão") SIZE 268, 8 OF oDlg PIXEL
     @ 050,218 BUTTON oButton2 PROMPT "Cancelar"      SIZE 30,12   OF oDlg PIXEL ACTION oDlg:End()
    @ 050,180 BUTTON oButton2 PROMPT "Processar"      SIZE 30,12   OF oDlg PIXEL ACTION fProcess()
    ACTIVATE MSDIALOG oDlg CENTER
			
Return


/*/{Protheus.doc} fProcess
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 30/10/2020
    @Desc Responsavel pelo processamento
/*/
Static Function fProcess()

Local cQuery := ''
Local nX           := 0
Private aAuxQry    := {}
Private nJanLarg   := 700
Private nJanAltu   := 400
Private cFontUti   := "Tahoma"
Private oFontAno   := TFont():New(cFontUti,,-38)
Private oFontSub   := TFont():New(cFontUti,,-20)
Private oFontSubN  := TFont():New(cFontUti,,-20,,.T.)
Private oFontBtn   := TFont():New(cFontUti,,-14)
Private _stru      := {}
Private aCpoBro    := {}
Private aCores     := {}
Private lInverte   := .F.
Private lMarkOk    := .F.
Private cMark      := GetMark()  
Private oDlgPvt
Private oMsGetZYE
Private oBtnSalv
Private oBtnFech
Private oMark

    cQuery := CRLF + " SELECT "
    cQuery += CRLF + " L1_FILIAL, L1_DOC, L1_SERIE, L1_XCODEX, L1_EMISSAO, L1_CLIENT, L1_LOJA "
    cQuery += CRLF + " FROM "+RetSqlName('SL1')+" SL1 "
    cQuery += CRLF + "  JOIN "+RetSqlName('ZZB')+" ZZB ON L1_KEYNFCE = ZZB_CHAVE AND ZZB_XCODEX = L1_XCODEX"
    cQuery += CRLF + "  JOIN "+RetSqlName('SD2')+" SD2 ON "
	cQuery += CRLF + "    SD2.D2_FILIAL = SL1.L1_FILIAL" 
	cQuery += CRLF + "    AND SD2.D2_DOC = SL1.L1_DOC "
	cQuery += CRLF + "    AND SD2.D2_SERIE = SL1.L1_SERIE " 
	cQuery += CRLF + "    AND SD2.D_E_L_E_T_ != '*' "
    cQuery += CRLF + " WHERE "
    cQuery += CRLF + "   SL1.D_E_L_E_T_=''"
	cQuery += CRLF + "   AND SL1.L1_FILIAL != ''"
	cQuery += CRLF + "   AND SUBSTRING(SL1.L1_EMISSAO,1,4) IN ( '2021', '2022', '2023' )"
    cQuery += CRLF + " ORDER BY 1"


	If Select("TMP1") > 0
		Dbselectarea("TMP1")
		TMP1->(DbClosearea())
	EndIf

    TcQuery cQuery New Alias "TMP1"

    While TMP1->(!EOF())
        aadd(aAuxQry,{;
            TMP1->L1_FILIAL ,;
            TMP1->L1_DOC    ,;
            TMP1->L1_SERIE  ,;
            TMP1->L1_XCODEX ,;
            TMP1->L1_EMISSAO,;
            TMP1->L1_CLIENT,;
            TMP1->L1_LOJA   })
        TMP1->(DbSkip())
    Enddo
        
    Aadd(_stru,{"OK"        ,"C" ,2	  ,0})
    Aadd(_stru,{"FILIAL"    ,"C" ,4	  ,0})
    Aadd(_stru,{"DOCUMENTO" ,"C" ,9	  ,0})
    Aadd(_stru,{"SERIE"     ,"C" ,5	  ,0})
    Aadd(_stru,{"XCODEX"    ,"C" ,100 ,0})
    Aadd(_stru,{"EMISS"     ,"C" ,8   ,0})
    Aadd(_stru,{"CLIENTE"   ,"C" ,8   ,0})
    Aadd(_stru,{"LOJA"      ,"C" ,4   ,0})

    cArq:=Criatrab(_stru,.T.)

    DbUseArea(.T.,,cArq,"TTRB")

    For nX := 1 To Len(aAuxQry)
        DbSelectArea("TTRB")	
        RecLock("TTRB",.T.)		
            TTRB->FILIAL     :=  Alltrim(aAuxQry[nX,01])	
            TTRB->DOCUMENTO  :=  Alltrim(aAuxQry[nX,02])	
            TTRB->SERIE      :=  Alltrim(aAuxQry[nX,03])
            TTRB->XCODEX     :=  Alltrim(aAuxQry[nX,04])
            TTRB->EMISS      :=  aAuxQry[nX,05]
            TTRB->CLIENTE    :=  Alltrim(aAuxQry[nX,06])
            TTRB->LOJA       :=  Alltrim(aAuxQry[nX,07])
        MsunLock()	
    Next nX

    aCpoBro	:= {;
        { "OK"			,, "Mark"       ,"@!"},;
        { "FILIAL"	    ,, "Filial"     ,"@!"},;
        { "DOCUMENTO"	,, "Documento"  ,"@!"},;
        { "SERIE"		,, "Serie"      ,"@!"},;
        { "XCODEX"		,, "XCodX"      ,"@!"} }


    DEFINE MSDIALOG oDlgPvt TITLE "Excluir NFs de Saída" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL

    @ 004, 005 SAY "BDIL"         SIZE 200,030 FONT oFontAno  OF oDlgPvt COLORS RGB(149,179,215) PIXEL
    @ 004, 050 SAY "Excluir"      SIZE 200,030 FONT oFontSub  OF oDlgPvt COLORS RGB(031,073,125) PIXEL
    @ 014, 050 SAY "NFs de Saída" SIZE 200,030 FONT oFontSubN OF oDlgPvt COLORS RGB(031,073,125) PIXEL

    @ (nJanAltu/2)-20, (nJanLarg/2-001)-(0052*02) BUTTON oBtnFech  PROMPT "Fechar"  SIZE 035, 017 OF oDlgPvt ACTION (oDlgPvt:End()) FONT oFontBtn PIXEL
    @ (nJanAltu/2)-20, (nJanLarg/2-001)-(0052*01) BUTTON oBtnSalv  PROMPT "Excluir"  SIZE 035, 017 OF oDlgPvt ACTION (fExcluir())       FONT oFontBtn PIXEL
    @ (nJanAltu/2)-20, (nJanLarg/2-001)-(0052*06) BUTTON oBtnFech  PROMPT "Marcar/Desmarcar Todos"  SIZE 080, 017 OF oDlgPvt ACTION (fMarkAll()) FONT oFontBtn PIXEL
    
    DbSelectArea("TTRB")
    DbGotop()
    
    oMark := MsSelect():New("TTRB","OK","",aCpoBro,@lInverte,@cMark,{040,003,(nJanAltu/2)-30,(nJanLarg/2)-3},,,,,,)
    oMark:bMark := {| | fMarkNow()}
    
    ACTIVATE MSDIALOG oDlgPvt CENTERED

    TTRB->(DbCloseArea())
    Iif(File(cArq + GetDBExtension()),FErase(cArq  + GetDBExtension()) ,Nil)
        
Return
              

/*/{Protheus.doc} fXCODXIMP
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 30/10/2020
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


/*/{Protheus.doc} fXCODXIMP
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 30/10/2020
    @Desc Auxiliar Mark todos
/*/
Static Function fMarkAll()

    dbSelectArea( "TTRB" )
    dbGotop()

    If lMarkOk
        While !EoF()
            RecLock( "TTRB", .F. )
            TTRB->OK := cMark
            MsunLock()
        dbSkip()
        EndDo
        lMarkOk := .F.
    Else
        While !EoF()
            RecLock( "TTRB", .F. )
            TTRB->OK := ""
            MsunLock()
        dbSkip()
        EndDo
        lMarkOk := .T.
    Endif 
    
    oMark:oBrowse:Refresh()

Return


/*/{Protheus.doc} fXCODXIMP
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 30/10/2020
    @Desc Excluir SF2 / SD2 / SFT / SE1
/*/
Static Function fExcluir()

Local cQuery := ''

    DbSelectArea("TTRB")
    DbGotop()
    
    While TTRB->(!Eof())
        If !Empty(TTRB->OK)
            
            cFil := Alltrim(TTRB->FILIAL)
            cDoc := Alltrim(TTRB->DOCUMENTO)
            cSer := Alltrim(TTRB->SERIE)
            cEms := Alltrim(TTRB->EMISS)
            cCli := Alltrim( IIF(EMPTY(TTRB->CLIENTE), "000001", TTRB->CLIENTE) )
            cLoj := Alltrim( TTRB->LOJA )

            cQuery := " UPDATE "+RetSqlName('SD2')+" SET D_E_L_E_T_='*', R_E_C_D_E_L_ = R_E_C_N_O_ WHERE D2_FILIAL='"+cFil+"' AND D2_DOC='"+cDoc+"' AND D2_SERIE='"+cSer+"' AND D2_EMISSAO='"+cEms+"' AND D2_CLIENTE='"+cCli+"' AND D2_LOJA='"+cLoj+"' AND D_E_L_E_T_='' "
            TCSQLExec(cQuery)

            cQuery := " UPDATE "+RetSqlName('SF2')+" SET D_E_L_E_T_='*', R_E_C_D_E_L_ = R_E_C_N_O_ WHERE F2_FILIAL='"+cFil+"' AND F2_DOC='"+cDoc+"' AND F2_SERIE='"+cSer+"' AND F2_EMISSAO='"+cEms+"' AND F2_CLIENTE='"+cCli+"' AND F2_LOJA='"+cLoj+"' AND D_E_L_E_T_='' "
            TCSQLExec(cQuery)
        
            cQuery := " UPDATE "+RetSqlName('SFT')+" SET D_E_L_E_T_='*', R_E_C_D_E_L_ = R_E_C_N_O_ WHERE FT_FILIAL='"+cFil+"' AND FT_NFISCAL='"+cDoc+"' AND FT_SERIE='"+cSer+"' AND FT_EMISSAO='"+cEms+"' AND FT_CLIEFOR='"+cCli+"' AND FT_LOJA='"+cLoj+"' AND D_E_L_E_T_='' "
            TCSQLExec(cQuery)

            cQuery := " UPDATE "+RetSqlName('SE1')+" SET D_E_L_E_T_='*', R_E_C_D_E_L_ = R_E_C_N_O_ WHERE E1_FILORIG = '"+cFil+"' AND E1_NUM='"+cDoc+"' AND E1_SERIE='"+cSer+"' AND E1_EMISSAO='"+cEms+"' AND D_E_L_E_T_='' "
            TCSQLExec(cQuery)

            cQuery := " UPDATE  "+RetSqlName('CT2')+"  SET D_E_L_E_T_='*', R_E_C_D_E_L_ = R_E_C_N_O_ WHERE CT2_KEY = ('"+cFil+"'  + '"+cDoc+"' + '"+cSer+"' + '"+cCli+"' + '"+cLoj+"') AND CT2_DATA = '"+cEms+"' AND D_E_L_E_T_='' "
            TCSQLExec(cQuery)

        EndIf
    TTRB->(DbSkip())
    EndDo

    MsgInfo('Processo Cloncluído!')
    oDlgPvt:End()

Return
