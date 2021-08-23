#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "TBICONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BDLML004  ºAutor  ³ Douglas Silva      º Data ³ 28/11/2019  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Importação planilha TOTVS Protheus - 3 Sabores Promoção    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio Di Latte - RVacari                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function BLM311AUT()

LOCAL oDlg
LOCAL nOpca:=0
Local aPergs 	  := {}
Local cCaminho  := Space(60)

Private aRet 	  := {}
Private nGet1 := 0


aAdd( 	aPergs ,{6,"Diretorio do Arquivo",cCaminho,"@!",,'.T.',80,.T.,"Arquivos .xlsx |*.csv " })
aAdd(	aPergs,{1,"Lote",Space(10),"","","","",0,.T.}) // Tipo caractere

If ParamBox(aPergs ,"Parametros ",aRet)
		
	DEFINE MSDIALOG oDlg FROM  96,9 TO 310,592 TITLE OemToAnsi("Importacao Planilha CAMPANHA") PIXEL    //"Recï¿½lculo do Custo de Reposiï¿½ï¿½o"
	@ 18, 4 TO 80, 287 LABEL "" OF oDlg  PIXEL
	@ 29, 15 SAY OemToAnsi("Esta rotina realiza a importacao de Planilha - Produto Campanha") SIZE 268, 8 OF oDlg PIXEL
	@ 38, 15 SAY OemToAnsi("Da empresa Bacio diLatte.") SIZE 268, 8 OF oDlg PIXEL
	@ 48, 15 SAY OemToAnsi("Confirma Geracao Transferencia?") SIZE 268, 8 OF oDlg PIXEL
    
	DEFINE SBUTTON FROM 90, 223 TYPE 1 ACTION (oDlg:End(),nOpca:=1) ENABLE OF oDlg
	DEFINE SBUTTON FROM 90, 250 TYPE 2 ACTION oDlg:End() ENABLE OF oDlg
	ACTIVATE MSDIALOG oDlg CENTER
	
	If nOpca == 1

		processa(  {|| fImpExcel(9999999) } ,'Aguarde Efetuando Importacao da Planilha')
	
	Endif
	
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BDLML004  ºAutor  ³ Douglas Silva      º Data ³ 28/11/2019  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Importação planilha TOTVS Protheus - 3 Sabores Promoção    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio Di Latte - RVacari                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function FImpExcel(nGet1)

Local cDir		  	:= Alltrim(MV_PAR01)
Local cArq		  	:= Alltrim(MV_PAR02)
Local aDadoscab     := {}
Local aDadosIte     := {}
Local aItens 		:= {}
Local cLinha  := ""
Local lPrim   := .T.
Local aCampos := {}
Local aDados  := {}
Local cLocalAnt	:= ""
Local _cCodTran	:= "" 
 
Private _nProcSuce	:= 0
Private _nProcFalh	:= 0
Private _aStruLog   := {}
Private _cLog 		:= ""
Private _nRegLin    := 0
Private _aCelulas   := {}
Private oModel      := Nil
Private lMsErroAuto := .F.
Private aRotina    := {}
 
	cFile   := cDir

	If !File( cFile )
	MsgStop("Aquivo " + cFile + " não foi encontrado. A importação será abortada!","ATENCAO")
		Return
	EndIf
	
	//Verifica se usuário está logado filial 0031
	If xFilial("NNS") != "0031"
		Alert("Atenção, rotina utilziada somente para filial 0031!")
		Return
	EndIf 
	
	FT_FUSE(cFile)
	ProcRegua(FT_FLASTREC())
	FT_FGOTOP()

	// Extrai os Dados das Celulas Cabeï¿½alho pedido
	While !FT_FEOF()
 
		IncProc("Lendo arquivo texto...")
 
		cLinha := FT_FREADLN()
	 
		If lPrim
			aCampos := Separa(cLinha,";",.T.)
			lPrim := .F.
		Else
			AADD(aDados,Separa(cLinha,";",.T.))
		EndIf
	 
		FT_FSKIP()
	EndDo
	
	
	Begin Transaction
	ProcRegua(Len(aDados))
	For i:=1 to Len(aDados)
 
		IncProc("Gravando registros Transferencias...")
		
		aDadoscab := {}
		aDadosIte := {}
		aItens := {}
		
		//Verifica se Quantidade está zero
		If Val( aDados[i][3] ) .Or. Val( aDados[i][2] ) != 0
		
			//Verifica se trata da mesma filial
			If 	ALLTRIM(padr(aDados[i][5],TamSx3('NNT_LOCLD')[1])) != cLocalAnt
			
				_cCodTran :=GetSx8Num("NNS","NNS_COD")
				
				NNS->( Reclock("NNS", .T.) )
					NNS->NNS_FILIAL := xFilial("NNS")
					NNS->NNS_COD    := _cCodTran
					NNS->NNS_DATA   := dDataBase
					NNS->NNS_SOLICT := "000305"
					NNS->NNS_XNOMSO := UPPER(SUBSTR(CUSUARIO,7,15) + ALLTRIM( cArq ))  
					NNS->NNS_CLASS  := "1"
					NNS->NNS_STATUS := "1"
					NNS->NNS_ESPECI := "SPED"
					ConfirmSx8()
				NNS->( MsUnlock('NNS') )
					
		      EndIf
		      
		      	//Erro verificar codigo de transferencia
		      	If Empty(_cCodTran)
		      		Return
		      	EndIf		      	
		      	
				NNT->( Reclock("NNT", .T.) )
					//Adicionando os dados do ExecAuto Item
					NNT->NNT_COD 		:= _cCodTran
		            NNT->NNT_FILIAL 	:= xFilial("NNT")
					NNT->NNT_FILORI 	:= xFilial("NNT")
					NNT->NNT_PROD 		:= ALLTRIM(padr(aDados[i][1],TamSx3('NNT_PROD')[1]))
					NNT->NNT_LOCAL 		:= '800003'
		     		NNT->NNT_FILDES 	:= ALLTRIM(padr(aDados[i][4],TamSx3('NNT_FILDES')[1]))
					NNT->NNT_PRODD 		:= ALLTRIM(padr(aDados[i][1],TamSx3('NNT_PROD')[1]))
		
					NNT->NNT_UM := Posicione("SB1",1,xFilial("SB1")+ALLTRIM(padr( ALLTRIM(padr(aDados[i][1],TamSx3('NNT_PROD')[1])) ,TamSx3('NNT_PROD')[1])),"B1_UM")
					NNT->NNT_UMD := NNT->NNT_UM
		
						    If Val( aDados[i][3] ) > 0
						            NNT->NNT_QTSEG 	:= Val( aDados[i][3] )
									NNT->NNT_XQTORI := Val( aDados[i][3] )
							Else
						            NNT->NNT_QUANT 	:= Val( aDados[i][2] )
									NNT->NNT_XQTORI := Val( aDados[i][2] )
							EndIf
					       
					NNT->NNT_LOCLD := ALLTRIM(padr(aDados[i][5],TamSx3('NNT_LOCLD')[1]))
					
					NNT->NNT_TS := U_BACDM030( ALLTRIM(padr(aDados[i][4],TamSx3('NNT_FILDES')[1])) ,ALLTRIM(padr(aDados[i][1],TamSx3('NNT_PROD')[1])) ) 
					NNT->NNT_TE := U_BACTES01("53",ALLTRIM(padr(aDados[i][4],TamSx3('NNT_FILDES')[1])) ,ALLTRIM(padr(aDados[i][1],TamSx3('NNT_PROD')[1])))
		
		            NNT->NNT_XCC 	:= "800004"
					NNT->NNT_DTVALI := dDataBase
			        NNT->NNT_XDATA 	:= dDataBase
					NNT->NNT_XHORA 	:= Time()
	    		NNT->( Msunlock('NNT') )
			
			EndIf
    		
    		cLocalAnt := ALLTRIM(padr(aDados[i][5],TamSx3('NNT_LOCLD')[1]))
			
		Next i
		End Transaction
	
	FT_FUSE()
	
Return
