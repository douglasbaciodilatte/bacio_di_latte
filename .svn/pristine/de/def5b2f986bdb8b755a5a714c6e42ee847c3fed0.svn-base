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

/*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºPrograma ³ BDLFIS04         ºAutor³ RVACARI Felipe Mayer	    º Data Ini³ 16/11/2020   º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºDesc.    ³ Ajustar base de calculo reduzida p/ SPED  -  CD2                               ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºUso      ³ BACIO DI LATTE	                                            		  		  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/

User Function BDLFIS04()

Private nJanLarg   := 300
Private nJanAltu   := 200
Private cFontUti   := "Tahoma"
Private oFontAno   := TFont():New(cFontUti,,-38)
Private oFontSub   := TFont():New(cFontUti,,-20)
Private oFontSubN  := TFont():New(cFontUti,,-20,,.T.)
Private oFontBtn   := TFont():New(cFontUti,,-14)
Private oDlgPvt
Private oBtnSalv
Private cTGet1
    

    cTGet1 := StrZero(Month(Date()),2)+'/'+cValToChar(Year(Date()))

    DEFINE MSDIALOG oDlgPvt TITLE "Ajuste redução Base de Cálculo" style 128 FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL

    @ 004, 005 SAY "BDIL"            SIZE 200,030 FONT oFontAno  OF oDlgPvt COLORS RGB(149,179,215) PIXEL
    @ 004, 050 SAY "Ajuste redução"  SIZE 200,030 FONT oFontSub  OF oDlgPvt COLORS RGB(031,073,125) PIXEL
    @ 014, 050 SAY "Base de Cálculo" SIZE 200,030 FONT oFontSubN OF oDlgPvt COLORS RGB(031,073,125) PIXEL
    @ 044, 014 SAY "Período: "       SIZE 050,012 FONT oFontSub  OF oDlgPvt COLORS RGB(031,073,125) PIXEL
    @ 044, 055 MSGET cTGet1          SIZE 050,008                OF oDlgPvt PIXEL PICTURE '@E 99/9999' VALID NaoVazio()
    @ (nJanAltu/2)-20, (nJanLarg/2-001)-(0042*01) BUTTON oBtnSalv  PROMPT "Confirmar" SIZE 035, 017 OF oDlgPvt ACTION MsAguarde({|| fQryUpd()}, "Aguarde...", "Processando Registros...") FONT oFontBtn PIXEL

    ACTIVATE MSDIALOG oDlgPvt CENTERED
        
Return


Static Function fQryUpd()

Local cQuery := ''

    cPar := SubsTr(cTGet1,4,7)+SubsTr(cTGet1,1,2)

    cQuery := CRLF + " UPDATE CD2010 SET CD2_PREDBC = SF4.F4_BASEICM "
    cQuery += CRLF + " FROM "+RetSqlName('CD2')+" CD2 "
    cQuery += CRLF + "      JOIN "+RetSqlName('SD2')+" SD2 "
    cQuery += CRLF + "      ON SD2.D2_FILIAL = CD2.CD2_FILIAL "
    cQuery += CRLF + "          AND SD2.D2_DOC = CD2.CD2_DOC "
    cQuery += CRLF + "          AND SD2.D2_SERIE = CD2.CD2_SERIE "
    cQuery += CRLF + "          AND SD2.D2_CLIENTE = CD2.CD2_CODCLI "
    cQuery += CRLF + "          AND SD2.D2_LOJA = CD2.CD2_LOJCLI "
    cQuery += CRLF + "          AND SD2.D2_COD = CD2.CD2_CODPRO "
    cQuery += CRLF + "      JOIN "+RetSqlName('SF4')+" SF4 "
    cQuery += CRLF + "      ON SF4.F4_FILIAL = '' "
    cQuery += CRLF + "          AND SF4.F4_CODIGO = SD2.D2_TES "
    cQuery += CRLF + "          AND SF4.D_E_L_E_T_ != '*' "
    cQuery += CRLF + " WHERE CD2_FILIAL != ''  "
    cQuery += CRLF + "      AND CD2_TPMOV = 'S' "
    cQuery += CRLF + "      AND CD2_IMP = 'ICM' "
    cQuery += CRLF + "      AND CD2_PREDBC = 0 "
    cQuery += CRLF + "      AND CD2.D_E_L_E_T_ != '*'  "
    cQuery += CRLF + "      AND SF4.F4_BASEICM != 0 "
    cQuery += CRLF + "      AND SUBSTRING(SD2.D2_EMISSAO,1,6) = '"+cPar+"' "

    TCSQLExec(cQuery)


	MsgInfo('Processo realizado!')

    oDlgPvt:End()

Return
