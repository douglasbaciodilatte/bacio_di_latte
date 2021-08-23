#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "TopConn.ch"

/*/{Protheus.doc} User Function BDINVIMP
    (long_description)
    @type  Function
    @author user
    @since 10/04/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
/*/

User Function BDESTA11()

Local aPergs   := {}

Private cDoc    := Space(9)
Private _cFil   := Space(4)
Private dData   := SToD('')
Private _cLocal := Space(6)
Private cCont   := SPACE(3)
 
    aAdd(aPergs, {1, "Filial", _cFil, "", ".T.", "SM0", ".T.", 35, .T.})
    aAdd(aPergs, {1, "Local", _cLocal, "", ".T.", "NNR", ".T.", 35, .T.})
    aAdd(aPergs, {1, "Documento", cDoc, "", ".T.", "", ".T.", 35, .T.})
    aAdd(aPergs, {1, "Data Inventário", dData,  "",  ".T.",  "",  ".T.", 60,  .T.})
    aAdd(aPergs, {1, "Contagem", cCont,  "",  ".T.",  "",  ".T.", 60,  .T.})

    If ParamBox(aPergs, "Informe os parâmetros para consulta")
      TelaLacto()
    EndIf

Return

Static Function TelaLacto()
Local oButton1
Local oButton2
Local oGet1
Local oGet2
Local oGet3
Local oGet4
Local oGet5
Local oGet6
Local oGet7
Local oGet8
Local oSay1
Local oSay2
Local oSay3
Local oSay4
Local oSay5
Local oSay6
Local oSay7
Local oSay8
Static oDlg

Private cGet1 := SPACE(15)
Private cGet2 := SPACE(60)
Private cGet4 := SPACE(2)
Private cGet6 := SPACE(2)
Private nGet5 := 0
Private nGet7 := 0
Private cGet3 := SPACE(16)
Private dGet8 := Ctod("  /  /  ")

  DEFINE MSDIALOG oDlg TITLE "Lançamento Inventário" FROM 000, 000  TO 380, 500 COLORS 0, 16777215 PIXEL

    @ 030, 014 SAY oSay1 PROMPT "Cod Produto" SIZE 030, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 030, 060 MSGET oGet1 VAR cGet1 VALID ( BuscDados() ) SIZE 120, 010 OF oDlg COLORS 0, 16777215 F3 "SB1" PIXEL HASBUTTON

    @ 045, 014 SAY oSay2 PROMPT "Descrição" SIZE 030, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 045, 060 MSGET oGet2 VAR cGet2 SIZE 120, 010 OF oDlg COLORS 0, 16777215 READONLY PIXEL

    @ 060, 014 SAY oSay3 PROMPT "Lote" SIZE 030, 012 OF oDlg COLORS 0, 16777215 PIXEL
    @ 060, 060 MSGET oGet3 VAR cGet3 SIZE 120, 010 OF oDlg COLORS 0, 16777215 PIXEL

    @ 075, 014 SAY oSay4 PROMPT "Unidade 1" SIZE 030, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 075, 060 MSGET oGet4 VAR cGet4 SIZE 120, 010 OF oDlg COLORS 0, 16777215 READONLY PIXEL

    @ 090, 014 SAY oSay5 PROMPT "Quantidade 1" SIZE 030, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 090, 060 MSGET oGet5 VAR nGet5 VALID ( Conv1Un() ) PICTURE "@E 999,999.99" SIZE 120, 010 OF oDlg COLORS 0, 16777215 PIXEL 

    @ 105, 014 SAY oSay6 PROMPT "Unidade 2" SIZE 030, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 105, 060 MSGET oGet6 VAR cGet6 SIZE 120, 010 OF oDlg COLORS 0, 16777215 READONLY PIXEL 

    @ 120, 014 SAY oSay7 PROMPT "Quantidade 2" SIZE 030, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 120, 060 MSGET oGet7 VAR nGet7 VALID ( Conv2Un() ) PICTURE "@E 999,999.99" SIZE 120, 010 OF oDlg COLORS 0, 16777215 PIXEL

    @ 135, 014 SAY oSay8 PROMPT "Dt Valid Lote" SIZE 030, 007 OF oDlg COLORS 0, 16777215 PIXEL
    @ 135, 060 MSGET oGet8 VAR dGet8 SIZE 120, 010 OF oDlg COLORS 0, 16777215 PIXEL   
    
    @ 160, 160 BUTTON oButton1 PROMPT "Salvar" SIZE 037, 012 OF oDlg ACTION ( Gravar() ) PIXEL
    @ 160, 206 BUTTON oButton2 PROMPT "Fechar" SIZE 037, 012 OF oDlg ACTION ( oDlg:End()) PIXEL

  ACTIVATE MSDIALOG oDlg CENTERED

Return

Static Function BuscDados()

  Local lRet := .T.

    SB1->(dbSelectArea("SB1"))
    SB1->(dbSetOrder(1))

    If SB1->(dbSeek( xFilial("SB1") + cGet1 ))

        cGet2 := SB1->B1_DESC
        cGet4 := SB1->B1_UM
        cGet6 := SB1->B1_SEGUM

    EndIf

Return(lRet)

Static Function Conv1Un()

  Local lRet := .T.

  nGet7 := ConvUM(cGet1, nGet5, 0,   2)

Return(lRet)

Static Function Conv2Un()

  Local lRet := .T.

  nGet5 := ConvUM(cGet1, 0, nGet7,   1)

Return(lRet)

Static Function Gravar()

  Local lRet := .T.

  SB1->(dbSelectArea("SB1"))
  SB1->(dbSetOrder(1))

  If SB1->(dbSeek( xFilial("SB1") + cGet1 ))

    If SB1->B1_RASTRO == "L"
      
      If lRet .And. Empty(cGet3)

        Alert("ATENÇÃO: Produco controla Lote, favor preencher numero!")
        lRet := .f.  
      
      ElseIf lRet .And. Empty(dGet8)

        Alert("ATENÇÃO: Produco controla Lote, favor preencher data validade!")
        lRet := .f.  

      EndIf

      SB7->(dbSelectArea("SB7"))
      SB7->(dbSetOrder(1)) //B7_FILIAL, B7_DATA, B7_COD, B7_LOCAL, B7_LOCALIZ, B7_NUMSERI, B7_LOTECTL, B7_NUMLOTE, B7_CONTAGE

      If lRet .And. SB7->(dbSeek( MV_PAR01 + DTOS(MV_PAR04) + cGet1 + MV_PAR02 + SB7->B7_LOCALIZ + SB7->B7_NUMSERI + cGet3 ))

          If MsgYesNo('ATENÇÃO: Confirma gravação contagem do item ' + Alltrim(cGet2) )
          
           RecLock("SB7", .T.)

              SB7->B7_FILIAL  := MV_PAR01
              SB7->B7_COD     := cGet1
              SB7->B7_LOCAL   := MV_PAR02
              SB7->B7_TIPO    := SB1->B1_TIPO
              SB7->B7_DOC     := DTOS(MV_PAR04) + "B"               
              SB7->B7_QUANT   := nGet5
              SB7->B7_QTSEGUM := nGet7
              SB7->B7_DATA    := MV_PAR04
              SB7->B7_ORIGEM  := "BDESTA11"
              SB7->B7_STATUS  := "1"                    
              SB7->B7_LOTECTL := cGet3
              SB7->B7_DTVALID := dGet8
              SB7->B7_CONTAGE := MV_PAR05  
                        
            MsUnLock() 
        EndIf
     
      Else
            RecLock("SB7", .F.)
                                
                    SB7->B7_QUANT   := SB7->B7_QUANT + nGet5
                    SB7->B7_QTSEGUM := SB7->B7_QTSEGUM + nGet7
                
            MsUnLock() 

            MsgInfo("Contagem já existe para esse produto / lote os valores foram somadas!")

      EndIf

    EndIf

  EndIf

Return(lRet)
