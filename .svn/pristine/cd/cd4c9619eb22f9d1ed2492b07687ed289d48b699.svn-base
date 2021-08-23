#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "TopConn.ch"

static eol := char(13)+char(10)

/*/{Protheus.doc} User Function BDINVIMP
    (long_description)
    @type  Function
    @author user
    @since 10/04/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description222
    @example
    (examples)
    @see (links_or_references)
/*/

User Function bdlinv3() 
Local aPergs := {}
Local dDtInv := GetMV('BDIL_DTINV',.t.,"")

Private cDoc    := Space(9)
Private _cFil   := Space(4)
Private dData   := SToD('')
Private _cLocal := Space(6)
Private aCont   := {"001","002","003","004"}
Private MV_PAR04
Private MV_PAR05
Private cBloqTel := GetMV("BDIL_BLOINV",.T.,"0031,0072")

if Empty(dDtInv)
  alert('Parametro  BDIL_DTINV inesxistente ou não preenchido')
  Return
endif

IF dDtInv + 3 < Date()
  Alert('Ajustar o Paramnetro BDIL_DTINV com a Data do Inventario'+eol + " Parametro Atual: " + DtoC(dDtInv ))
  Return
EndIF

  //cAux  := Str(Year(Date()),4) + StrZero(Month(Date())+1,2)+"01"
  cData := dDtInv
  cAux  := DtoS(cData) + "C"
  CDoc := cAux
  cAux := ""

  aAdd(aPergs, {1, "Filial"         , _cFil  , "", ".T.", "SM0", ".T.", 35, .F.})
  aAdd(aPergs, {1, "Local"          , _cLocal, "", ".T.", "NNR", ".T.", 35, .F.})
  //aAdd(aPergs, {1, "Documento"      , cDoc   , "", ".T.", ""   , ".T.", 35, .F.})
  //aAdd(aPergs, {1, "Data Inventário", dData  , "", ".T.", ""   , ".T.", 60, .F.})
  aAdd(aPergs, {2, "Contagem"       , "001"  ,aCont  , 099, ".T.", .F.  })

  
  If ParamBox(aPergs, "Informe os parâmetros para consulta")
    
    dbSelectArea("ZZ5")
    ZZ5->(dbSetOrder(7))
    ZZ5->(DBGoBottom())
    
    MV_PAR05 := MV_PAR03
    MV_PAR03 := CDoc
    MV_PAR04 := cData
    
    fTelaLact()
      
  EndIf

Return

//********************************************************************************************************************

//********************************************************************************************************************

Static Function fTelaLact()

Local aSize       := {}
//Local oObjects  := {} 
Local aInfo       := {} 

Private oDlg

Private oButton1
Private oButton2
Private oButton3
Private oButton4

Private oGet1
Private oGet2
Private oGet3
Private oGet4
Private oGet5
Private oGet6
Private oGet7
Private oGet8
Private oGet9
Private oGet10
Private oGet11
Private oGet12
//Private oGet13

Private oSay1
Private oSay2
Private oSay3
Private oSay4
Private oSay5
Private oSay6
Private oSay7
Private oSay8
Private oSay9
Private oSay10
Private oSay11
Private oSay12
Private oSay13
Private oSay14

Private oCombo

Private cStyle  := ""
Private cStyleB := ""
Private cSayCSS := ""
Private cSayCSSB:= ""
Private cButton := ""
Private cGetCSS := ""
Private cGetCSSB:= ""

Private aObjects := {}

Private oFont12N    := TFont():New('Arial',,30,,.t.,,,,,.F.,.F.)
Private oFont20     := TFont():New('Arial',,20,,.t.,,,,,.F.,.F.)
//Private cDoc := Space(9)
Private cGet1 := SPACE(15)
Private cGet2 := SPACE(60)
Private cGet4 := SPACE(2)
Private cGet6 := SPACE(2)
Private nGet5 := 0
Private nGet7 := 0
Private cGet3 := SPACE(len(ZZ5->ZZ5_LOTECT))
Private dGet8 := Ctod("  /  /  ")
Private cFiltro := "ZZ5_DOC == cDoc"
Private cGet9  := MV_PAR02 //SPACE(16)
Private cGet10 := SPACE(LEN(ZZ5->ZZ5_ENDER))
Private cGet11 := SPACE(6)
Private cGet12 := SPACE(6)
Private aItems := {'D=Direito','E=Esquerdo'}
Private cCombo := aItems[1]

Private nGet12 := 0
Private nGet13 := 0 
Private nGet14 := 0
Private nAux1  := 0
Private nAux2  := 0 
Private cLote  := ''
Private lSalva := .F.
Private aCols  := {{"",""} }
Private n      := 1
Private nPosCProd := 1
  dbSelectArea("ZZ5")

  cFiltro := "ZZ5_FILIAL == '" +MV_PAR01 + "' .AND. ZZ5_LOCAL == '" + MV_PAR02 + "' .AND. ZZ5_DOC == '" + MV_PAR03 + "' " // .AND. DtoS(ZZ5_DATA) ==  '" + DTOS(MV_PAR04) + "' "

  Set Filter to &cFiltro 

  ZZ5->(dbSetOrder(3))
  ZZ5->(DBGoBottom())
  ZZ5->(DBSEEK(MV_PAR01+MV_PAR03,.T.))

  cConta := IIF(EMPTY(ZZ5->ZZ5_CONTAG), '000',ZZ5->ZZ5_CONTAG)
  cDoc   := MV_PAR03//ZZ5->ZZ5_DOC

  //fCarga()
  fLimpa()

  // Obtém a a área de trabalho e tamanho da dialog
  aSize := MsAdvSize()
  AAdd( aObjects, { 100, 100, .T., .T. } ) // Dados da Enchoice 
  AAdd( aObjects, { 200, 200, .T., .T. } ) // Dados da getdados 

  // Dados da área de trabalho e separação
  aInfo   := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 } // Chama MsObjSize e recebe array e tamanhos
  aPosObj := MsObjSize( aInfo, aObjects,.T.) // Usa tamanhos da dialog
  nAlt    := 20
  nLarg   := 200
  nPosX   := 30
  nPosY   := 5
  nEspac  := 25
  nEspal  := 100
  nCol2   := 350
  nCorLetra := 0
  nCorFundo := 16777215

  lTransparent := .T.

  oDlg:= TDialog():New(aSize[7],0,aSize[6],aSize[5],'Lançamento Inventário',,,,nOr(WS_VISIBLE,WS_POPUP),CLR_BLACK,CLR_WHITE,,,.T.,,,,,,lTransparent)

      oPanel := TPanelCss():New(0,0,nil,oDlg,nil,nil,nil,nil,nil,aSize[5], aSize[6],nil,nil)
      
      oSay13 := TSay():New(nPosX += nEspac,nPosY ,{||'Documento:  ' + cDoc + "            Contagem :" + MV_PAR05 },oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg+100,nAlt+10  )
      
      oSay1 := TSay():New(nPosX += nEspac,nPosY ,{||'Produto'},oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg,nAlt+10  )
      oGet1 := TGet():New( nPosX, nPosY + nEspal , {|u|iif(PCount()>0,cGet1 := u, cGet1)}, oPanel, nLarg+200, nAlt, "@!"      , {||GetProduto()/*BuscDados(1)*/}, nCorLetra, nCorFundo  , oFont12N,,, .t.,,, /*{||.t.}*/,,,, .F.,.F.,, "cGet1","cGet1",,,.F., .F.,, "", 2, oFont12N, 0, "",, )
      
      oSay2 := TSay():New(nPosX += nEspac,nPosY ,{||'Descrição'},oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg,nAlt+10  )
      oGet2 := TGet():New( nPosX, nPosY + nEspal , {|u|iif(PCount()>0,cGet2 := u, cGet2)}, oPanel, nLarg+200, nAlt, "@!"      , {||.t.}        , nCorLetra, nCorFundo, oFont12N,,, .t.,,, /*{||.t.}*/,,,, .T.,.F.,, "cGet2","cGet2",,,.F., .F.,, "", 2, oFont12N, 0, "",, )

      oSay9 := TSay():New(nPosX += nEspac,nPosY ,{||'Armazem'  },oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg,nAlt+10  )
      oGet9 := TGet():New( nPosX, nPosY + nEspal , {|u|iif(PCount()>0,cGet9 := u, cGet9)}, oPanel, nLarg, nAlt, "@!"           , {||.t.} , nCorLetra, nCorFundo, oFont12N,,, .t.,,, /*{||.t.}*/,,,, .T.,.F.,, "cGet9","cGet9",,,.F., .F.,, "", 2, oFont12N, 0, "",, )
   
      oSay10 := TSay():New(nPosX /*+= nEspac*/,nPosY+nCol2 ,{||'Endereço'},oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg,nAlt+10  )
      oGet10 := TGet():New( nPosX, nPosY + nEspal+nCol2 , {|u|iif(PCount()>0,cGet10 := u, cGet10)}, oPanel, nLarg, nAlt, "@!"  , {|| fEnder() /*BuscDados(3)*/ } , nCorLetra, nCorFundo, oFont12N,,, .t.,,, /*{||.t.}*/,,,, .F.,.F.,, "cGet10","cGet10",,,.F., .F.,, "", 2, oFont12N, 0, "",, )
  
      oSay3 := TSay():New(nPosX += nEspac,nPosY ,{||'Lote'},oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg,nAlt+10  )
      oGet3 := TGet():New( nPosX, nPosY + nEspal , {|u|iif(PCount()>0,cGet3 := u, cGet3)}, oPanel, nLarg, nAlt, "@!"           , {||fValLote()}        , nCorLetra, nCorFundo, oFont12N,,, .t.,,, /*{||.t.}*/,,,, .F.,.F.,, "cGet3","cGet3",,,.F., .F.,, "", 2, oFont12N, 0, "",, )
    
      oSay8 := TSay():New(nPosX /*+= nEspac*/,nPosY+nCol2 ,{||'Data de Validade'},oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg,nAlt+10  )
      oGet8 := TGet():New( nPosX , nPosY + nEspal+nCol2 , {|u|iif(PCount()>0,dGet8 := u, dGet8)}, oPanel, nLarg, nAlt, "@!"    , {||fValData()}        , nCorLetra, nCorFundo, oFont12N,,, .t.,,, /*{||.t.}*/,,,, .F.,.F.,, "dGet8","dGet8",,,.F., .F.,, "", 2, oFont12N, 0, "",, )
    
      oSay4 := TSay():New(nPosX += nEspac,nPosY ,{||'Unidade 1'},oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg,nAlt+10  )
      oGet4 := TGet():New( nPosX, nPosY + nEspal , {|u|iif(PCount()>0,cGet4 := u, cGet4)}, oPanel, nLarg, nAlt, "@!"           , {||.t.}        , nCorLetra, nCorFundo, oFont12N,,, .t.,,, /*{||.t.}*/,,,, .T.,.F.,, "cGet4","cGet4",,,.F., .F.,, "", 2, oFont12N, 0, "",, )
      
      oSay6 := TSay():New(nPosX /*+= nEspac*/,nPosY +nCol2,{||'Unidade 2'},oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg,nAlt+10  )
      oGet6 := TGet():New( nPosX, nPosY + nEspal+nCol2 , {|u|iif(PCount()>0,cGet6 := u, cGet6)}, oPanel, nLarg, nAlt, "@!"     , {||.T.}        , nCorLetra, nCorFundo, oFont12N,,, .t.,,, /*{||.t.}*/,,,, .T.,.F.,, "cGet6","cGet6",,,.F., .F.,, "", 2, oFont12N, 0, "",, )

      oSay5 := TSay():New(nPosX += nEspac,nPosY ,{||'Quant.Total 1'},oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg,nAlt+10  )
      oGet5 := TGet():New( nPosX, nPosY + nEspal , {|u|iif(PCount()>0,nGet5 := u, nGet5)}, oPanel, nLarg, nAlt, "@E 999,999.99", {||Positivo()/*,Conv1Un()*/} , nCorLetra, nCorFundo, oFont12N,,, .t.,,, /*{||.t.}*/,,,, .T.,.F.,, "nGet5","nGet5",,,.F., .F.,, "", 2, oFont12N, 0, "",, )
      
      oSay7 := TSay():New(nPosX /*+= nEspac*/,nPosY+nCol2 ,{||'Quant.Total 2'},oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg,nAlt+10  )
      oGet7 := TGet():New( nPosX, nPosY + nEspal+nCol2 , {|u|iif(PCount()>0,nGet7 := u, nGet7)}, oPanel, nLarg, nAlt, "@E 999,999.99", {||Positivo()/*,Conv2Un()*/} , nCorLetra, nCorFundo/7, oFont12N,,, .t.,,, /*{||.t.}*/,,,, .T.,.F.,, "nGet7","nGet7",,,.F., .F.,, "", 2, oFont12N, 0, "",, )
            
      oSay12 := TSay():New(nPosX += nEspac,nPosY ,{||'Quantidade 1'},oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg,nAlt+10  )
      oGet12 := TGet():New( nPosX, nPosY + nEspal , {|u|iif(PCount()>0,nGet12 := u, nGet12)}, oPanel, nLarg, nAlt, "@E 999,999.99", {||fPosit(nGet12),Conv1Un(),fSoma(1)} , nCorLetra, nCorFundo, oFont12N,,, .t.,,, /*{||.t.}*/,,,, .F.,.F.,, "nGet12","nGet12",,,.F., .F.,, "", 2, oFont12N, 0, "",, )
      
      oSay14 := TSay():New(nPosX /*+= nEspac*/,nPosY+nCol2 ,{||'Quantidade 2'},oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg,nAlt+10  )
      oGet14 := TGet():New( nPosX, nPosY + nEspal+nCol2 , {|u|iif(PCount()>0,nGet14 := u, nGet14)}, oPanel, nLarg, nAlt, "@E 999,999.99", {||fPosit(nGet14),Conv2Un(),fSoma(2)} , nCorLetra, nCorFundo/7, oFont12N,,, .t.,,, /*{||.t.}*/,,,, .F.,.F.,, "nGet14","nGet14",,,.F., .F.,, "", 2, oFont12N, 0, "",, )

      //oGet1:BlostFocus := {||alert("Produto" + cGet1)}
      //oSay11 := TSay():New(nPosX += nEspac,nPosY ,{||'Rua'},oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg,nAlt+10  )
      //oGet11 := TGet():New( nPosX, nPosY + nEspal  , {|u|iif(PCount()>0,cGet11 := u, cGet11)}, oPanel, nLarg, nAlt, "@!", {|| .t. } , nCorLetra, nCorFundo/7, oFont12N,,, .t.,,, /*{||.t.}*/,,,, .F.,.F.,, "cGet11","cGet11",,,.F., .F.,, "", 2, oFont12N, 0, "",, )
      
      //oSay12 := TSay():New(nPosX /*+= nEspac*/,nPosY+nCol2 ,{||'Lado'},oPanel,,oFont12N,,,,.T.,CLR_RED,CLR_WHITE,nLarg,nAlt+10  )
      //oGet12 := TGet():New( nPosX, nPosY + nEspal+nCol2 , {|u|iif(PCount()>0,cGet12 := u, cGet12)}, oPanel, nLarg, nAlt, "@!", {|| .t. } , nCorLetra, nCorFundo/7, oFont12N,,, .t.,,, /*{||.t.}*/,,,, .F.,.F.,, "cGet12","cGet12",,,.F., .F.,, "", 2, oFont12N, 0, "",, )
      //oCombo := TComboBox():New(nPosX, nPosY + nEspal+nCol2 ,{|u|if(PCount()>0,cCombo:=u,cCombo)}, aItems,nLarg,nAlt,oPanel,,{||.t.},,,,.T.,oFont12N,,,,,,,,'cCombo')

      //oCombo:SetHeight( nAlt + 30)    
      
      oGet1:cF3 := "SB1"
      oGet3:cF3 := "SB8"
      oGet10:cF3 := "SBE"

      oButton1:= TButton():New(005, 050, "Salvar "               ,oPanel,{|| pSalvar(.T.), oDlg:Refresh() }, 120, 030,,,.F.,.T.,.F.,,.F.,,,.F. ) 
      oButton2:= TButton():New(005, 360, "Fechar"                ,oPanel,{|| oDlg:End()                   }, 080, 030,,,.F.,.T.,.F.,,.F.,,,.F. ) 
      oButton3:= TButton():New(005, 260, "Limpar"                ,oPanel,{|| fLimpa()    , oDlg:Refresh() }, 080, 030,,,.F.,.T.,.F.,,.F.,,,.F. ) 
      oButton5:= TButton():New(005, 550, "Relatorio de Contagem" ,oPanel,{|| pFinal() ,fLimpa() ,oDlg:Refresh() }, 130, 030,,,.F.,.T.,.F.,,.F.,,,.F. ) 
      
      //oButton3:= TButton():New(005, 260, "<< Anterior"         ,oPanel,{|| fAnterior() , oDlg:Refresh()}, 80, 030,,,.F.,.T.,.F.,,.F.,,,.F. ) 
      //oButton4:= TButton():New(005, 350, "Proximo >>"          ,oPanel,{|| fProximo()  , oDlg:Refresh()}, 80, 030,,,.F.,.T.,.F.,,.F.,,,.F. ) 
      //oButton5:= TButton():New(005, 550, "Bloquear Contagem"  ,oPanel,{|| iif(pFinal() , oDlg:End(),oGet1:SetFocus() ) }, 120, 030,,,.F.,.T.,.F.,,.F.,,,.F. ) 
      oDlg:lEscClose := .F.
      fCSS()
    oDlg:Activate(,,,.T.,{||},,{||} )
   
return .T.

//********************************************************************************************************************
//
//********************************************************************************************************************

Static function fPosit(nCampo)
Local lRet := .T.
Default nCampo := 0

  if nCampo < 0
    lRet := .T.
  Endif

Return lRet

//********************************************************************************************************************
//
//********************************************************************************************************************

static Function fSoma(nCampo)
Default nCampo := 1

  Do case
   
    case MV_PAR05 == '001'
   
      nAux1 := ZZ5->ZZ5_QTD11
      nAux2 := ZZ5->ZZ5_QTD21
   
    case MV_PAR05 == '002' 
   
      nAux1 := ZZ5->ZZ5_QTD12
      nAux2 := ZZ5->ZZ5_QTD22
   
    case MV_PAR05 == '003' 
   
      nAux1 := ZZ5->ZZ5_QTD13
      nAux2 := ZZ5->ZZ5_QTD23
   
    case MV_PAR05 == '004' 
   
      nAux1 := ZZ5->ZZ5_QTD14
      nAux2 := ZZ5->ZZ5_QTD24
   
    Otherwise
   
      nAux1 := 0
      nAux2 := 0
  
  EndCase
  
  if Alltrim (cGet9) $ "700003/800003"
      
    if nGet12 <> 0 .or. nAux1 == 0 .or. nGet14 <> 0 .or. nAux2 == 0
      nGet5 := nGet12
      nGet7 := nGet14
    else
      nGet5 := nAux1
      nGet7 := nAux2
    Endif
 
  Else
 
    if nGet12 <> 0 .or. nAux1 == 0 .or. nGet14 <> 0 .or. nAux2 == 0
      nGet5 := nGet12 + nAux1
      nGet7 := nGet14 + nAux2
    else
      nGet5 := nAux1
      nGet7 := nAux2
    Endif
 
  endif

Return .T.

//********************************************************************************************************************

//********************************************************************************************************************
Static Function pSalvar(lNovo)
Local cTexto := ""

  cTexto += "Preencher todos os CAMPOS" + eol
  cTexto += "Caso o Item não Tenha Lote Preencher com '*'. " + eol
  cTexto += "Caso o Tenha Data de Validade Preencher com 31/12/2050  " + eol

  Default lNovo := .T.		

  Processa( {|| fGrava(lNovo)}, "Salvando Produtos...")
  fCarga(0,.f.,lNovo)
  oGet1:SetFocus()
  oDlg:Refresh()

Return

//********************************************************************************************************************

//********************************************************************************************************************
Static Function pFinal()
Local lRet := .T.

Private aCols   := {}
Private aHeader := {}

   if lRet 		

    Processa( {|| fFinaliza() }, "Finalizando Contagem...")

    if len(aCols) > 0
      Processa( {|| fGeraExel() }, "Gerando Relatóro de Contagem" )
    else

      MsgAlert("Contagem não encontrada")
    endif

  endif

Return lRet

//********************************************************************************************************************


//********************************************************************************************************************

Static Function Conv1Un()
Local lRet := .T.
 
  //nGet7  := ConvUM(cGet1, nGet5,0,   2)
  nGet14 := ConvUM(cGet1, nGet12,0,   2)

 
Return(lRet)
//********************************************************************************************************************

//********************************************************************************************************************
Static Function Conv2Un()
Local lRet := .T.

  //nGet5  := ConvUM(cGet1,0, nGet7 ,  1)
  nGet12 := ConvUM(cGet1,0, nGet14,  1)

Return(lRet)

//********************************************************************************************************************

//********************************************************************************************************************

Static Function fCarga(nChave,lMov,lNovo)

Default lNovo := .F.
Default lMov  := .T.
Default nChave := 1

  if lMov 
    nPasso := 1
  else
    nPasso := -1
  EndIf
  
  if type('oGet1') == 'O'
  
    if MV_PAR05 >= '003' .and. ZZ5->ZZ5_DIF12 == 0 .and. !empty(cGet1) .and. !empty(cGet10) .and. (iif(ZZ5->ZZ5_CLOTE == 'L',!empty(cGet3),.T.))
  
      Alert("O Produto Informado não necessita da contagem: " + MV_PAR05)
      lSalva := .T.
      oGet1:SetFocus()
  
    endif
  
  endif

  if lSalva

    cGet1  := SPACE(Len(ZZ5->ZZ5_COD))
    cGet2  := SPACE(Len(ZZ5->ZZ5_DESCR))
    cGet3  := Space(len(ZZ5->ZZ5_LOTECT))
    dGet8  := Ctod("  /  /  ")
    cGet9  := mv_par02 //Space(6)

    IF MV_PAR02 $ "700003/800003"
      cGet10 := Space(len(ZZ5->ZZ5_ENDER))
    ELSE
      cGet10 := PadR(MV_PAR02, Len(ZZ5->ZZ5_ENDER)," ") //Space(len(ZZ5->ZZ5_ENDER))
    ENDIF

    cGet4  := SPACE(2)
    cGet6  := SPACE(2)
    nGet5  := 0 //ZZ5->ZZ5_QTD11
    nGet7  := 0 //ZZ5->ZZ5_QTD21.
    nGet12 := 0
    nGet14 := 0
    cLote  := ''

  Else

    nGet12 := 0
    nGet14 := 0

    if nChave > 1  
      cGet3  := ZZ5->ZZ5_LOTECT
    endif
    
    if nChave > 2

      if cGet9 $ "700003/800003"
        cGet10 := ZZ5->ZZ5_ENDER
      Else
        cGet10 := PadR(iif(empty(ZZ5->ZZ5_ENDER),MV_PAR02,ZZ5->ZZ5_ENDER), Len(ZZ5->ZZ5_ENDER)," ") 
      EndIf

    Endif

    dGet8  := ZZ5->ZZ5_DTVALI
    
    Do Case

      Case MV_PAR05 == "001"

        cGet4 := ZZ5->ZZ5_UM11
        cGet6 := ZZ5->ZZ5_UM21

        if lNovo
          nGet5 := 0
          nGet7 := 0 
        else
          nGet5 := ZZ5->ZZ5_QTD11
          nGet7 := ZZ5->ZZ5_QTD21
        endif

      Case MV_PAR05 == "002" 

        cGet4 := ZZ5->ZZ5_UM12
        cGet6 := ZZ5->ZZ5_UM22

        if lNovo
          nGet5 := 0
          nGet7 := 0
        else
          nGet5 := ZZ5->ZZ5_QTD12
          nGet7 := ZZ5->ZZ5_QTD22
        endif

      Case MV_PAR05 == "003" 

        cGet4 := ZZ5->ZZ5_UM13
        cGet6 := ZZ5->ZZ5_UM23 

        if lNovo
          nGet5 := 0
          nGet7 := 0
        else
          nGet5 := ZZ5->ZZ5_QTD13
          nGet7 := ZZ5->ZZ5_QTD23
        endif

      Case MV_PAR05 == "004" 

        cGet4 := ZZ5->ZZ5_UM14
        cGet6 := ZZ5->ZZ5_UM24

        if lNovo
          nGet5 := 0
          nGet7 := 0
        else
          nGet5 := ZZ5->ZZ5_QTD14
          nGet7 := ZZ5->ZZ5_QTD24
        endif

      OtherWise 

        cGet4 := SPACE(2)
        cGet6 := Space(2)
        nGet5 := 0
        nGet7 := 0

      EndCase
    endif

    lSalva := .F.

    if type('oDlg') == 'O'
      oDlg:Refresh()
    endif
    
Return
//********************************************************************************************************************
 
//********************************************************************************************************************
Static Function fGrava(lNovo)
local lSoma := .F.

Default lNovo := .F.

  lSalva := lNovo

  if AllTrim(MV_PAR02) $ "700003/800003"
    lSoma := .F.
  Else
    lSoma := .F.
  endif

  if lNovo

    dDt   := MV_PAR04
    cHora := ZZ5->ZZ5_HORA
    cBlq  := ZZ5->ZZ5_PROBLO

  endif
  
  nRec := ZZ5->(Recno())

  cChave := MV_PAR01 + cDoc + cGet1 + MV_PAR02 + cGet3 + cGet10 //+ DtoS(dGet8)

    ZZ5->(DbSetOrder(6))
  
    IF ZZ5->(DBSEEK(cChave))

      While cChave == ZZ5->(ZZ5_FILIAL + ZZ5_DOC + ZZ5_COD + ZZ5_LOCAL + ZZ5_LOTECT + ZZ5_ENDER )

        IF dGet8 == ZZ5->ZZ5_DTVALI
          lNovo := .F.
          Exit
        ELSE
          lNovo := .T.
        EndiF

        ZZ5->(dbSKip())

      EndDo
      
    Else
      lNovo := .T.
    EndIf

  lSoma := .F.

  BEGIN TRANSACTION

    RecLock("ZZ5",lNovo) 
  
      if lNovo

        ZZ5->ZZ5_FILIAL := MV_PAR01
        ZZ5->ZZ5_COD    := cGet1
        ZZ5->ZZ5_DESCR  := cGet2
        ZZ5->ZZ5_DOC    := cDoc
        ZZ5->ZZ5_DATA   := dDt
        ZZ5->ZZ5_PROBLO := cBlq
        ZZ5->ZZ5_CLOTE  := cLote

      endif  

      ZZ5->ZZ5_LOTECT := cGet3
      ZZ5->ZZ5_DTVALI := dGet8
      ZZ5->ZZ5_LOCAL  := cGet9
      ZZ5->ZZ5_ENDER  := cGet10
      ZZ5->ZZ5_HORA   := Time() 
      ZZ5->ZZ5_OBS    := RetCodUsr() +'-'+ substr(UsrFullName(RetCodUsr()),1,12) +"-"+ DtoC(DATE()) + '-' + time()

      ZZ5->ZZ5_UM11 := cGet4 
      ZZ5->ZZ5_UM21 := cGet6
      
      ZZ5->ZZ5_UM12 := cGet4 
      ZZ5->ZZ5_UM22 := cGet6
      
      ZZ5->ZZ5_UM13 := cGet4 
      ZZ5->ZZ5_UM23 := cGet6
      
      ZZ5->ZZ5_UM14 := cGet4 
      ZZ5->ZZ5_UM24 := cGet6
      
      if ZZ5->ZZ5_CONTAG < MV_PAR05
        ZZ5->ZZ5_CONTAG := MV_PAR05
      endif
      
      
      Do Case
        Case MV_PAR05 == "001"

          ZZ5->ZZ5_STATUS := "10"
          ZZ5->ZZ5_QTD11  := iif(lSoma, ZZ5->ZZ5_QTD11 + nGet5 , nGet5)
          ZZ5->ZZ5_QTD21  := iif(lSoma, ZZ5->ZZ5_QTD21 + nGet7 , nGet7)
          ZZ5->ZZ5_DIF12  := ZZ5->ZZ5_QTD11 - ZZ5->ZZ5_QTD12
          ZZ5->ZZ5_CONT3  := "2" 

        Case MV_PAR05 == "002"
          
          ZZ5->ZZ5_QTD12  := iif(lSoma, ZZ5->ZZ5_QTD12 + nGet5 , nGet5)
          ZZ5->ZZ5_QTD22  := iif(lSoma, ZZ5->ZZ5_QTD22 + nGet7 , nGet7)
          ZZ5->ZZ5_DIF12  := ZZ5->ZZ5_QTD11 - ZZ5->ZZ5_QTD12
          ZZ5->ZZ5_STATUS := "10"
          
          IF ZZ5->ZZ5_DIF12 <> 0
            ZZ5->ZZ5_CONT3  := "1" 
          ELSE
            ZZ5->ZZ5_CONT3  := "2" 
          ENDIF
          
        Case MV_PAR05 == "003"
          
          ZZ5->ZZ5_QTD13 := iif(lSoma, ZZ5->ZZ5_QTD13 + nGet5 , nGet5)
          ZZ5->ZZ5_QTD23 := iif(lSoma, ZZ5->ZZ5_QTD23 + nGet7 , nGet7)
          
          a1 := ZZ5->ZZ5_QTD13 - ZZ5->ZZ5_QTD11
          a2 := ZZ5->ZZ5_QTD13 - ZZ5->ZZ5_QTD12
          
          ZZ5->ZZ5_DIF3  := fValDif(a1,a2)
          ZZ5->ZZ5_STATUS := "10"
        
          IF ZZ5->ZZ5_QTD11 == ZZ5->ZZ5_QTD13 .or. ZZ5->ZZ5_QTD12 == ZZ5->ZZ5_QTD13
            ZZ5->ZZ5_CONT4  := "2" 
          ELSE
            ZZ5->ZZ5_CONT4  := "1" 
          ENDIF

        Case MV_PAR05 == "004"
                    
          ZZ5->ZZ5_QTD14 := iif(lSoma, ZZ5->ZZ5_QTD14 + nGet5 , nGet5) 
          ZZ5->ZZ5_QTD24 := iif(lSoma, ZZ5->ZZ5_QTD24 + nGet7 , nGet7)
          ZZ5->ZZ5_DIF4  := ZZ5->ZZ5_QTD14 - ZZ5->ZZ5_QTD13
          ZZ5->ZZ5_STATUS := "10"
          
          IF ZZ5->ZZ5_DIF3 <> 0 .AND. ZZ5->ZZ5_DIF4 <> 0
            ZZ5->ZZ5_CONT4  := "1" 
          ELSE
            ZZ5->ZZ5_CONT4  := "2" 
          ENDIF

      EndCase

    ZZ5->(MsUnLock())
  
  END TRANSACTION
  
  oDlg:Refresh()
  ZZ5->(dbSetOrder(3))

Return lNovo

//************************************************************************************************

//************************************************************************************************

Static function fValLote(lVisual)

Local lRet := .t.
Default lVisual := .T.
  
  cGet3 := PADR(alltrim(cGet3),16)

  if cLote == "L" .and. empty(cGet3)

    Alert("Obrigatório Informar o Lote...")
    lRet := .F.
   
  Else
    
    DbSelectArea('SB8')
    SB8->(DbSetOrder(3))
    
    IF SB8->(DBSEEK(MV_PAR01 + cGet1 + cGet9 + cGet3))

      dGet8 := SB8->B8_DTVALID
      oGet12:SetFocus()
      lRet := fBuscDados(2)
      
      if lRet
        lRet := .T.
      Else
        lRet := .T.
        oGet1:SetFocus()
      EndIf
    
    ELSE
    
      lRet := fBuscDados(2)
      if Alltrim(ZZ5->ZZ5_LOTECT) ==  Alltrim(cGet3)

        dGet8 := ZZ5->ZZ5_DTVALI
        oGet8:SetCss(cGetCSS )
        oGet8:lActive := .T.
        oGet8:SetFocus()
        
        if lRet 
          lRet := .T.
        Else
          oGet1:SetFocus()
          lRet := .T.
        EndIf
        
      Else
      
        oGet8:SetCss(cGetCSS )
        oGet8:lActive := .T.
        oGet8:SetFocus()
        if lRet 
          lRet := .T.
        Else
          oGet1:SetFocus()
          lRet := .T.
        EndIf
        
      EndIf
           
    Endif
      
  EndIf

  //BuscDados(2)
  oDlg:Refresh()

Return lRet

//*************************************************************************************************.


//**************************************************************************************************

Static Function fValData(lVisual)
Local lRet := .T. //fValLote(.f.)

  if cLote == "L" .and. empty(dGet8) 

    Alert("Data de Validade em Branco")
    lRet := .F.
  else 

    lRet := fBuscDados(3)

    if lRet 
      oGet12:SetFocus()
      lRet := .T.
    else
      oGet1:SetFocus()
      lRet := .T.
    EndIf

  EndIf
  
  oDlg:Refresh()

Return lRet

//********************************************************************************************************************
 
//********************************************************************************************************************

Static Function fFinaliza()
  Local aAux   := {}
  Local aCampo := ZZ5->(DBSTRUCT())
  Local cDes   := ''

  For nX := 1 To Len(aCampo)

    cDes := GetSx3Desc(aCampo[nX,1])
    aadd(aHeader,{cDes,aCampo[nX,1],aCampo[nX,2],aCampo[nX,3],aCampo[nX,4]})

  Next nX

  DbSelectArea("ZZ5")
  
  ZZ5->(DbSetOrder(3))
  ZZ5->(DbSeek(MV_PAR01 + cDoc,.T.))

  WHILE ZZ5->(!Eof()) .AND. ZZ5->ZZ5_FILIAL == MV_PAR01.AND. cDoc == ZZ5->ZZ5_DOC .and. MV_PAR02 == ZZ5->ZZ5_LOCAL

    RecLock("ZZ5",.F.)
      ZZ5->ZZ5_STATUS := "99"
    ZZ5->(MsUnLock())

    aAux :={}
    
    For nX := 1 to len(aCampo)
      aadd(aAux,ZZ5->&(aCampo[nX,1]))
    Next nX

    aadd(aCols,aAux)  
  
    ZZ5->(dbSkip())
  
  ENDDO
  
Return

//*******************************************************************

//******************************************************************

Static Function fMCor()
  //conta só uma vez, não pode mexer só na contagem 2 e gera contagem 3
  If cLote == "L"

    oSay3:SetCss(cSayCSSB)
    oSay8:SetCss(cSayCSSB)
    oGet3:SetCss(cGetCSS )
    //oGet8:SetCss(cGetCSS )
    oGet3:lActive := .T.
    //oGet8:lActive := .T.
  else

    oSay3:SetCss(cSayCSS )
    oSay8:SetCss(cSayCSS )
    oGet3:SetCss(cGetCSSB)
    oGet8:SetCss(cGetCSSB)
    oGet3:lActive := .F.
  
  Endif

Return 

//********************************************************************************************************

//********************************************************************************************************

Static Function fLimpa()
local cChave := ""

  lSalva := .T.

  cChave := MV_PAR01 + cDoc + cGet1 + MV_PAR02 + cGet3 + cGet10 //+ DtoS(dGet8)

  fCarga( )

Return

//********************************************************************************************************************
// Configura propriedades dos Get e Say
//********************************************************************************************************************

Static Function fCSS()

  cStyle := "QFrame{"
  cStyle += " border-style:solid;"
  cStyle += " border-width:1px;"
  cStyle += " border-color:#096A82;"
  cStyle += " background-color:#35ACCA "
  cStyle += "}"

  cStyleB := "QFrame{"
  cStyleB += " border-style:solid;"
  cStyleB += " border-width: 3px;"
  cStyleB += " border-color:#000000;"
  cStyleB += " background-color:#35ACCA "
  cStyleB += "}"
  
  cSayCSS := "TSay{"
  cSayCSS += " border: none;"
  //cSayCSS += " border-radius: 5px;"
  cSayCSS += " background-color: #35ACCA;"
  cSayCSS += " selection-background-color: #ffffff;"
  cSayCSS += " background-repeat: no-repeat; "
  cSayCSS += " background-attachment: fixed; "
  //cSayCSS += " padding-left:25px; "
  //cSayCSS += " font: normal 24px Arial;"
  cSayCSS += " }"

  cSayCSSB := "TSay{"
  cSayCSSB += " border: none;"
  //cSayCSS += " border-radius: 5px;"
  cSayCSSB += " background-color: #35ACCA;"
  cSayCSSB += " selection-background-color: #ffffff;"
  cSayCSSB += " background-repeat: no-repeat; "
  cSayCSSB += " background-attachment: fixed; "
  //cSayCSS += " padding-left:25px; "
  cSayCSSB += " color: #ff0000;"
  cSayCSSB += " }"

  cGetCSS := "TGet{"
  cGetCSS += " background-color: #ffffff;"
  cGetCSS += " }"

  cGetCSSB := "TGet{"
  cGetCSSB += " background-color: #99ccff;"
  cGetCSSB += " }"

  /*
  cGetCSS += "TGet:pressed{"
  cGetCSS += " border: none;"
  cGetCSS += " border-radius: 5px;"
  cGetCSS += " background-color: #35ACCA;"
  cGetCSS += " selection-background-color: #ffffff;"
  cGetCSS += " background-repeat: no-repeat; "
  cGetCSS += " background-attachment: fixed; "
  //cSayCSS += " padding-left:25px; "
  //cSayCSS += " font: normal 24px Arial;"
  cGetCSS += " }"*/

  cButton := "QPushButton {"
  cButton += " background: #0036EC;"
  cButton += "  border: 2px solid #000044;"
  cButton += "  outline:0;"
  cButton += "  border-radius: 5px;"
  cButton += "  font: normal 24px Arial;"
  cButton += "  padding: 6px;"
  cButton += "  color: #ffffff;"
  cButton += "}"

  cButton += " QPushButton:pressed {"
  cButton += "  background-color: #3AAECB;"
  cButton += "  border: 2px ;
  cButton += "  border-style: inset; "
  cButton += "  border-color: #000044; " //35ACCA
  cButton += "  color: #ffffff;"
  cButton += "}"

  oPanel:setCSS(cStyle)
  
  oSay1:SetCss(cSayCSSB)
  oSay2:SetCss(cSayCSS)
  oSay3:SetCss(cSayCSS)
  oSay4:SetCss(cSayCSS)
  oSay5:SetCss(cSayCSS)
  oSay6:SetCss(cSayCSS)
  oSay7:SetCss(cSayCSS)
    
  if cLote == 'L'
    oSay8:SetCss(cSayCSSB )
    oSay9:SetCss(cSayCSSB )
  Else
    oSay8:SetCss(cSayCSS  )
    oSay9:SetCss(cSayCSS  )
  EndIf

  oSay10:SetCss(cSayCSSB)
  //oSay11:SetCss(cSayCSS)
  oSay12:SetCss(cSayCSSB)
  oSay13:SetCss(cSayCSSB)
  oSay14:SetCss(cSayCSSB)
  //oGet2:SetCss(cGetCSS)
  oButton1:SetCss(cButton)
  oButton2:SetCss(cButton)
  oButton3:SetCss(cButton)
  //oButton4:SetCss(cButton)
  oButton5:SetCss(cButton)
  
  oGet2:lActive := .F.
  oGet4:lActive := .F.
  oGet5:lActive := .F.
  oGet6:lActive := .F.
  oGet7:lActive := .F.
  oGet8:lActive := .F.
  oGet9:lActive := .F.
  
  oGet2:SetCss(cGetCSSB)
  oGet4:SetCss(cGetCSSB)
  oGet5:SetCss(cGetCSSB)
  oGet6:SetCss(cGetCSSB)
  oGet7:SetCss(cGetCSSB)
  oGet8:SetCss(cGetCSSB)
  oGet9:SetCss(cGetCSSB)

 Return

//********************************************************************************************************************

//********************************************************************************************************************

Static Function fGeraExel()

Local cDoc      := MV_PAR03
Local cLocal    := MV_PAR02
Local cPlanilha := "Contagem - " + cDoc + " - " + cLocal
Local cTabela   := "Armazém - " + cLocal + "-" + MV_PAR05 
Local cPasta 	  := ""
Local cArq   	  := "Armazem_" + cLocal + "_" + MV_PAR05 + "_" + StrTran(time(),":","")
Local nX        := 0
//Local nTipo     := 1
//Local nAlinha   := 1
Local aDados 	  := {}
Local aCor 		  := {}
Local lX 		    := .T.

Local nPosFil   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_FILIAL" )})
Local nPosProd  := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_COD"    )})
Local nPosDes   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_DESCR"  )})
Local nPosLocal := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_LOCAL"  )})
Local nPosEnder := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_ENDER"  )})
Local nPosCLote := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_CLOTE"  )})
Local nPosLote  := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_LOTECT" )})
Local nPosDtVal := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_DTVALI" )})
Local nPos1UM   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_UM11"   )})
Local nPos2UM   := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_UM21"   )})
Local nPosQtd11 := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD11"  )})
Local nPosQtd12 := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD12"  )})
Local nPosQtd13 := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD13"  )})
Local nPosQtd21 := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD21"  )})
Local nPosQtd22 := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD22"  )})
Local nPosQtd23 := aScan(aHeader, {|x| AllTrim(Upper(x[2])) == AllTrim("ZZ5_QTD23"  )})

	cPasta := cGetFile("", "Salvar Arquivo em", 1, "C:\", .T., GETF_LOCALHARD+GETF_NETWORKDRIVE+GETF_RETDIRECTORY) 

	//Cria o Objeto para criar a Planilha XML
	oExcel := FwMsExcelEx():New()

	//Define a Planilha
	oExcel:AddWorkSheet(cPlanilha)

	//Define a Tabela na Planilha
	oExcel:AddTable(cPlanilha,cTabela)
	
	//Define as Colunas da Planilha
	oExcel:AddColumn(cPlanilha , cTabela , "Filial"                 , 1 , 1 , .f. ) //1
  //oExcel:AddColumn(cPlanilha , cTabela , "Documento"              , 1 , 1 , .f. ) //1
	//oExcel:AddColumn(cPlanilha , cTabela , "Data"                   , 1 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Produto"                , 1 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Descrição"              , 1 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Local"                  , 1 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Endereço"               , 1 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Controle de Lote"       , 2 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Lote"                   , 1 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Data de Validade"       , 2 , 1 , .f. ) //1
 
  //oExcel:AddColumn(cPlanilha , cTabela , "-"                      , 2 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Primeira Unid. Medida " , 2 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Primeira Contagem"      , 3 , 2 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Segunda Contagem"       , 3 , 2 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Diferença"              , 3 , 2 , .f. ) //1
  oExcel:AddColumn(cPlanilha , cTabela , "Terceira Contagem"      , 3 , 2 , .f. ) //1

	//oExcel:AddColumn(cPlanilha , cTabela , "-"                      , 2 , 1 , .f. ) //1
  oExcel:AddColumn(cPlanilha , cTabela , "Segunda Unid. Medida"   , 2 , 1 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Primeira Contagem"      , 3 , 2 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Segunda Contagem"       , 3 , 2 , .f. ) //1
	oExcel:AddColumn(cPlanilha , cTabela , "Diferença"              , 3 , 2 , .f. ) //1
  oExcel:AddColumn(cPlanilha , cTabela , "Terceira Contagem"      , 3 , 2 , .f. ) //1

	lBold := .F.

	For nX := 1 to Len(aCols)

		aDados := {}
		aCor   := {}
    
    aadd( aDados , aCols[ nX , nPosFil   ] )              // 01    Filial
    //aadd( aDados , aCols[ nX , nPosDoc   ] )            // 02    Documento 
    //aadd( aDados , aCols[ nX , nPosDat   ] )            // 03    Data
    aadd( aDados , aCols[ nX , nPosProd  ] )              // 04    Produto
    aadd( aDados , aCols[ nX , nPosDes   ] )              // 05    Descrição
    aadd( aDados , aCols[ nX , nPosLocal ] )              // 06    Local
    aadd( aDados , aCols[ nX , nPosEnder ] )              // 07    Endereço
    aadd( aDados , iif(aCols[ nX , nPosCLote ] == 'L',"Sim"," " ))              // 08    Controla Lote
    aadd( aDados , aCols[ nX , nPosLote  ] )              // 09    Lote
    aadd( aDados , iif(empty(aCols[nX,nPosDtVal]) , "" , DtoC(aCols[ nX , nPosDtVal ]) ) )        // 10    Data de Validade
    
    //aadd( aDados , "*"                     )              // 11    Separador
    aadd( aDados , aCols[ nX , nPos1UM   ] )              // 12    Primeira Unidade de Medida
    aadd( aDados , aCols[ nX , nPosQtd11 ] )              // 13    Primeira Contagem
    aadd( aDados , aCols[ nX , nPosQtd12 ] )              // 14    Segunda Contagem
    aadd( aDados , aCols[ nX , nPosQtd11 ] - aCols[ nX , nPosQtd12 ] )  // 15    Diferença
    aadd( aDados , aCols[ nX , nPosQtd13 ] )              // 16    
    
    if (aCols[ nX , nPosQtd11 ] - aCols[ nX , nPosQtd12 ]) <> 0
      aadd(aCor,12)
    endif
    
    //aadd( aDados , "*"                     )              // 17    Separador
    aadd( aDados , aCols[ nX , nPos2UM   ] )              // 18    Segunda Unidade de Medida
    aadd( aDados , aCols[ nX , nPosQtd21 ] )              // 19    Primeira Contagem
    aadd( aDados , aCols[ nX , nPosQtd22 ] )              // 20    Segunda Contagem
    aadd( aDados , aCols[ nX , nPosQtd21 ]-  aCols[ nX , nPosQtd22 ] )  // 21    Diferenca
    aadd( aDados , aCols[ nX , nPosQtd23 ] )              // 22    Terceira Contagem
    
    if (aCols[ nX , nPosQtd21 ] - aCols[ nX , nPosQtd22 ]) <> 0
      aadd(aCor,17)
    endif
    		
		IF lX

			oExcel:SetCelBgColor("#F4B084")
			//oExcel:SetLineBold(lBold)
			//oExcel:SetCelBold(lBold)

		ELSE

			oExcel:SetCelBgColor("#FADCCA")
			//oExcel:Set2LineBold(lBold)
			//oExcel:SetCelBold(lBold)

		EndIf

		lX := !lX

		//Inseri os Dados nas Celulas
		oExcel:AddRow(cPlanilha,cTabela, aDados,aCor)
	
	Next nX
	
	//Cria a Planilha em XML no formato Excel
	oExcel:Activate()
	
	If !Empty(cPasta)
		
		//Verifica se o Excel esta instalado
		If !ApOleClient("MSExcel")
			MsgAlert("Microsoft Excel não instalado!","Atenção")
		Else
			//Salva o Excel em arquivo
			oExcel:GetXMLFile(cPasta + cArq+".XML")
			//Abre o Excel
			oEx:=MsExcel():New()
			//Abre o Arquivo
			oEx:WorkBooks:Open(cPasta + cArq+".XML")
			//Apresenta em Tela
			oEx:SetVisible(.T.)
		
		Endif
	
	Endif

Return

//*********************************************************************************************************

//*********************************************************************************************************

static Function GetSx3Desc(cCampo)
Local cTitulo := ''
Local aArea := GetArea()

  dbSelectArea('SX3')
  SX3->(dbSetOrder(2))

  If SX3->(dbSeek( cCampo ) )
    cTitulo := X3Titulo()
  endif

  RestArea(aArea)

Return cTitulo

//*********************************************************************************************************

//*********************************************************************************************************

Static Function fValDif(a1,a2,a3)
Local nX  := 1
Local X1  := X2 := X3 := 0
Local nRet := 0

Default a1 := 0
Default a2 := 0
Default a3 := 99999999999

  for nX := 1 to 3
    if &("a" + Str(nX,1) )  < 0
      &("X" + Str(nX,1) ) := &("a" + Str(nX,1) )  * (-1)
    else 
      &("X" + Str(nX,1) ) := &("a" + Str(nX,1) ) 
    endif
  Next nX
  
  For nX := 1 to 3
    if nX == 1
      nRet := &("A" + Str(nX,1) )
      nCont :=&("X" + Str(nX,1) )
    EndIf

    if &("X" + Str(nX,1) ) < nCont
      nRet := &("a" + Str(nX,1) )
    endif
  
  Next nX

Return nRet

//****************************************************************************************************
// Valida Campo de Produto
//****************************************************************************************************

Static Function GetProduto()
Local lRet := .t.
Local nHande := GetFocus()

  DbSelectArea("SB1")
  SB1->(DbSetOrder(1))
        
  IF DbSeek(xFilial("SB1")+cGet1)
          
    if SB1->B1_MSBLQL == "1" 

      Alert("Atenção: Produto Bloqueado!")
      lRet := .F.

    Else
      //cGet1 := SPACE(15)
      cGet2 := SB1->B1_DESC
      cGet4 := SB1->B1_UM
      cGet6 := SB1->B1_SEGUM
      cGet9 := MV_PAR02 //SPACE(16)

      IF MV_PAR02 $ "700003/800003"
        cGet10 := Space(Len(cGet10))
      ELSE
        cGet10 := PadR(MV_PAR02, Len(ZZ5->ZZ5_ENDER)," ") //Space(len(ZZ5->ZZ5_ENDER))
      ENDIF

      cLote := SB1->B1_RASTRO
      cGet3 := Space(len(cGet3))
      dGet8 := CtoD("  /  /    ")
      nGet5 := 0
      nGet7 := 0
      nGet12 := 0
      nGet14 := 0
      lRet := .T.

      oGet10:SetFocus()
    endif

  ELSE
    if nHande>= 4528 .and. nHande <= 4530
  
      lRet := .T.
  
    Else
      
      Alert("Produto não Cadastrado!!!! ")
      lRet := .F.
    
    EndIf
  
  ENDIF
  
  fMCor()
  aCols[1,1] := cGet1

Return lRet

//************************************************************************************************
// Validada o Endereço do produto
//************************************************************************************************

Static Function fEnder()
Local lRet := .T.
  nGet12 := 0
  nGet14 := 0
  nGet5  := 0
  nGet7  := 0

  DbSelectArea('SBE')
  SBE->(dbSetOrder(1))
  IF SBE->(dBsEEK(MV_PAR01+cGet9+cGet10))
  
    lRet := .T.
  
  ELSE
  
    if cGet9 $ "800003/700003"
      Alert("Endereço não Encontrado, Verifique!")
      lRet := .F.
    Else
      lRet:= .T.
    EndIf
  
  ENDIF

  IF cLote == "L"
    oGet3:SetFocus()    
  ELSE

    oGet12:SetFocus()
    lRet := fBuscDados(1)

    if lRet 
      lRet := .T.
    ELSE
      lRet := .T.
      oGet1:SetFocus()
    endif
    
  ENDIF

  oDlg:Refresh()

Return lRet


//********************************************************************************************************************

//********************************************************************************************************************

Static Function fBuscDados(nCampo)
Local lRet := .T.
Local cChave  := ""
Local lValTela := MV_PAR01 $ cBloqTel
Default nCampo := 1
  
  cChave := MV_PAR01 + cDoc + cGet1 + MV_PAR02 + cGet3 + cGet10
  
  if nCampo == 3   
    cChave += DtoS(dGet8)
  endif
  
  dbSelectArea("ZZ5")
  ZZ5->(dbSetOrder(6))

  If ZZ5->(dbSeek( cChave))

    if ZZ5->ZZ5_QTD11 == ZZ5->ZZ5_QTD12 .and. ZZ5->ZZ5_QTD11 > 0 .and.  ZZ5->ZZ5_QTD21 > 0 .and. MV_PAR05 >= '003'

      Alert("Produto + Endereço + Lote, não Necessita da Contagem " + MV_PAR05 )
      oGet1:SetFocus()

    else
      
      cCarga(nCampo)
      
      if (ZZ5->ZZ5_QTD11 <> 0 .and. MV_PAR05 == "001") .or. (ZZ5->ZZ5_QTD12 <> 0 .and. MV_PAR05 == "002") .or.( ZZ5->ZZ5_QTD13 <> 0 .and. MV_PAR05 == "003")
        if lValTela
          fMsg()
          fLimpa()
          lRet := .F.
        EndIf

      endif
    
    endif

  Else  
    /*  
    if nCampo == 3
      lRet := .F.
    endif
    */
    nGet5  := 0
    nGet7  := 0
    nGet12 := 0
    nGet14 := 0  
  
  EndIf
  
  ZZ5->(DbSetOrder(3))

Return(lRet)

//*************************************************************************
//
//*************************************************************************

Static Function cCarga(n)
 
  Do Case

    Case MV_PAR05 == "001" 

      nGet5 := ZZ5->ZZ5_QTD11
      nGet7 := ZZ5->ZZ5_QTD21
 
    Case MV_PAR05 == "002"

      nGet5 := ZZ5->ZZ5_QTD12
      nGet7 := ZZ5->ZZ5_QTD22
 
    Case MV_PAR05 == "003"

      nGet5 := ZZ5->ZZ5_QTD13
      nGet7 := ZZ5->ZZ5_QTD23

    Case MV_PAR05 == "004"

      nGet5 := ZZ5->ZZ5_QTD14
      nGet7 := ZZ5->ZZ5_QTD24

    EndCase

Return

//*****************************************************************************************

//*****************************************************************************************

Static Function fMsg()
Local oMsg
Local oPnl
Local oBtnOk
Local oCaption1
Local oCaption2
Local oCaption3
Local oCaption4
Local oCaption5
Local oCaption6

Local aSize    := {}
Local aInfo    := {} 
Local aObjects := {}

Local cMsg1 := "O Produto: "+ cGet1 + " - " + cGet2 
Local cMsg2 := "Lote: " + cGet3 + " 
Local cMsg3 := "Armazém: "+ cGet9 + "      Endereço " + cGet10
Local cMsg4 := Space(35)+" Primeira Unid.Medida                          Segunda Unid.Medida"
Local cMsg5 := "Foi Contado" + Space(40) + transform(nGet5,"@E 999,999.99") + " " + cGet4  +" -- "+Space(35) + transform(nGet7,"@E 999,999.99") + " " + cGet6
Local cMsg6 := "Qualquer Ajuste será feito na proxima Contagem."

  // Obtém a a área de trabalho e tamanho da dialog
  aSize := MsAdvSize()
  AAdd( aObjects, { 100, 100, .T., .T. } ) // Dados da Enchoice 
  AAdd( aObjects, { 200, 200, .T., .T. } ) // Dados da getdados 

  // Dados da área de trabalho e separação
  aInfo   := { aSize[ 1 ], aSize[ 2 ], aSize[ 3 ], aSize[ 4 ], 3, 3 } // Chama MsObjSize e recebe array e tamanhos
  aPosObj := MsObjSize( aInfo, aObjects,.T.) // Usa tamanhos da dialog

  lTransparent := .F.

  oMsg:= TDialog():New(aSize[7]/2,0,aSize[6]/2,aSize[5]/2,'',,,,nOr(WS_VISIBLE,WS_POPUP),CLR_BLACK,CLR_WHITE,,oPnl,.T.,,,,,,lTransparent)

    oPnl      := TPanelCss():New(0,0,nil,oMSG,nil,nil,nil,nil,nil,aPosObj[2,3]+42, aPosObj[2,1]+41,nil,nil)
    oCaption1 := TSay():New( 10,10 , {||cMsg1 }, oPnl,, oFont20 ,,,,.T., CLR_RED, CLR_WHITE, nLarg + 100, nAlt + 10  )
    oCaption2 := TSay():New( 30,10 , {||cMsg2 }, oPnl,, oFont20 ,,,,.T., CLR_RED, CLR_WHITE, nLarg + 100, nAlt + 10  )
    oCaption3 := TSay():New( 50,10 , {||cMsg3 }, oPnl,, oFont20 ,,,,.T., CLR_RED, CLR_WHITE, nLarg + 100, nAlt + 10  )
    oCaption4 := TSay():New( 70,10 , {||cMsg4 }, oPnl,, oFont20 ,,,,.T., CLR_RED, CLR_WHITE, nLarg + 100, nAlt + 10  )
    oCaption5 := TSay():New( 80,10 , {||cMsg5 }, oPnl,, oFont20 ,,,,.T., CLR_RED, CLR_WHITE, nLarg + 100, nAlt + 10  )
    oCaption6 := TSay():New(110,10 , {||cMsg6 }, oPnl,, oFont20 ,,,,.T., CLR_RED, CLR_WHITE, nLarg + 100, nAlt + 10  )

    oBtnOk   := TButton():New(aPosObj[2,1]+15, aPosObj[2,1], "Ok" ,oPnl,{|| oMsg:End() }, 80, 020,,,.F.,.T.,.F.,,.F.,,,.F. ) 
      
    oPnl:setCSS(cStyleB)
    oBtnOk:setCSS(cButton)
    oCaption1:setCSS(cSayCSS)
    oCaption2:setCSS(cSayCSS)
    oCaption3:setCSS(cSayCSS)
    oCaption4:setCSS(cSayCSS)
    oCaption5:setCSS(cSayCSS)
    oCaption6:setCSS(cSayCSS)
    
    
  oMSG:Activate(,,,.T.,{||},,{||} )
  
  fLimpa()   

return .T.

Static Function fEmpS(cEmp,cFil)
  
  local cempx := cEmp
  Local cFilx := cFil
  dbCloseall()
  cempant := cempx
  cfilant := cfil
  cNumEmp := cempx + cFilx
  FWSM0UTIL():SetSM0PositionBycFilAnt()
  OpenFile(cempx+cFilx)
  lRefresh := .T.
  
Return
