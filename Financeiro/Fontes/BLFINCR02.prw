#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "TBICONN.CH"
#define CMD_OPENWORKBOOK			1
#define CMD_CLOSEWORKBOOK			2
#define CMD_ACTIVEWORKSHEET			3
#define CMD_READCELL				4

/*/
{Protheus.doc} BLFINCR0
Description

	Importacao de Planilha Excel para Baixar TÃ­tulos CR 

@param xParam Parameter Description
@return Nil
@author  - Rodolfo Vacari
@since 23/05/19 
/*/

User Function BLFINCR2()

LOCAL oDlg
LOCAL nOpca:=0
Local aPergs 	  := {}
Local cCaminho  := Space(60)
Local oSay1

Private aRet 	  := {}
Private nGet1 := 0


aAdd( aPergs ,{6,"Diretorio do Arquivo",cCaminho,"@!",,'.T.',80,.F.,"Arquivos .xlsx |*.csv " })
aAdd( aPergs ,{3,"Somente Processamento",1,{"Não","Sim"},50,"",.T.})

If ParamBox(aPergs ,"Parametros ",aRet)
		
	DEFINE MSDIALOG oDlg FROM  96,9 TO 310,592 TITLE OemToAnsi("Importacao Pedido de Venda") PIXEL    //"Recï¿½lculo do Custo de Reposiï¿½ï¿½o"
	@ 18, 4 TO 80, 287 LABEL "" OF oDlg  PIXEL
	@ 29, 15 SAY OemToAnsi("Esta rotina realiza a importacao de Planilha Excel Com  os dados para Geracao de Baixas") SIZE 268, 8 OF oDlg PIXEL
	@ 38, 15 SAY OemToAnsi("Da empresa Bacio diLatte.") SIZE 268, 8 OF oDlg PIXEL
	@ 48, 15 SAY OemToAnsi("Confirma Geracao de Baixas?") SIZE 268, 8 OF oDlg PIXEL
    @ 58, 15 SAY oSay1 PROMPT "Informe a quantidade de titulos." SIZE 089, 007 OF oDlg COLORS 0, 16777215 PIXEL    
//    @ 58, 118 MSGET oGet1 VAR nGet1 SIZE 030, 010 OF oDlg PICTURE "99999" COLORS 0, 16777215 PIXEL	

	DEFINE SBUTTON FROM 90, 223 TYPE 1 ACTION (oDlg:End(),nOpca:=1) ENABLE OF oDlg
	DEFINE SBUTTON FROM 90, 250 TYPE 2 ACTION oDlg:End() ENABLE OF oDlg
	ACTIVATE MSDIALOG oDlg CENTER
		
	If nOpca == 1 .And. ( aRet[2] == 1 .And. !Empty( aRet[1] ) )
		processa( {|| fImpExcel(nGet1) } ,'Aguarde Efetuando Importacao da Planilha' )
	ElseIf aRet[2] == 1 .And. Empty( aRet[1] )
		MsgAlert("ATENÇÃO: Informar para não porcessar, necessário selecionar o arquivo!")
	ElseIf aRet[2] == 2 
		processa( {|| fImpExcel(nGet1) } ,'Aguarde Efetuando Importacao da Planilha' )
	Endif
	
Endif

Return

/*/
{Protheus.doc} BLFINCR0
Description

	Importacao de Planilha Excel para Baixar TÃ­tulos CR 

@param xParam Parameter Description
@return Nil
@author  - Rodolfo Vacari
@since 23/05/19 
/*/

Static Function FImpExcel(nGet1)

Local nJuros    	:= 0
Local cDir		  	:= Alltrim(MV_PAR01)
Local cArq		  	:= Alltrim(MV_PAR02)
Local lPrim			:= .T.	
Local aDados		:= {}
Local aCampos		:= {}
Local lBaixa		:= .F.	
Local nReg			:= 0

Private cDTHRIn		:= DTOC( Date() ) + " " + Time()
Private cDTHRFi		:= DTOC( Date() ) + " " + Time()
Private _nProcSuce	:= 0
Private _nProcFalh	:= 0

	//Busca tabela no protheus
	ZCZ->(dbSelectArea("ZCZ"))
	ZCZ->(dbSetOrder(1))
	
	cFile   := aRet[1]

	If ! Empty(cFile) .And. aRet[2] == 1 

		FT_FUSE(cFile)
		ProcRegua(FT_FLASTREC())
		FT_FGOTOP()
		While !FT_FEOF()
			
			IncProc("Selecionando Registros...")
	 
			cLinha := FT_FREADLN()
			
			If lPrim
				aCampos := Separa(cLinha,";",.T.)
				lPrim := .F.
			Else
				AADD(aDados,Separa(cLinha,";",.T.))
							
			EndIf
			
			FT_FSKIP()
		EndDo
		
		//Efetua leitura dos dados
		ProcRegua( Len(aDados) )
		Begin Transaction
			For i := 1 to Len(aDados) //Leitura do Array importação dos dados
			
				IncProc("Importando dados tabela ZCZ...")
			
				ZCZ->(dbSelectArea("ZCZ"))
				ZCZ->(dbSetOrder(1)) //ZCZ_FILORI, ZCZ_PREFIX, ZCZ_NUM, ZCZ_PARCEL, ZCZ_TIPO, ZCZ_CLIENT, ZCZ_LOJA
				
				If ! ZCZ->(dbSeek( 	PADR( aDados[i][1] , TamSx3('ZCZ_FILORI')[1]) +;
				 					PADR( aDados[i][4] ,TamSx3('ZCZ_PREFIX')[1]) +;
				 					PADR( aDados[i][5] ,TamSx3('ZCZ_NUM')[1]) +;
				 					PADR( aDados[i][6] ,TamSx3('ZCZ_PARCEL')[1]) +;
				 					PADR( aDados[i][3] ,TamSx3('ZCZ_TIPO')[1]) +;
				 					PADR( aDados[i][8] ,TamSx3('ZCZ_CLIENT')[1]) +;
				 					PADR( aDados[i][9] ,TamSx3('ZCZ_LOJA')[1]) ) ) 
				 									
				 	//Resposta para inicio das baixas
				 	lBaixa	:= .T.					
				
				 	nReg++
				
					RecLock("ZCZ", .T.)
						ZCZ->ZCZ_PREFIX 	:= aDados[i][4]
					    ZCZ->ZCZ_NUM		:= aDados[i][5]
					    ZCZ->ZCZ_PARCEL 	:= aDados[i][6]
					    ZCZ->ZCZ_TIPO		:= aDados[i][3]
					    ZCZ->ZCZ_NATURE		:= aDados[i][10]
					    ZCZ->ZCZ_CLIENT		:= aDados[i][8]
					    ZCZ->ZCZ_LOJA		:= aDados[i][9]
					    ZCZ->ZCZ_NOMCLI		:= aDados[i][7]
					    ZCZ->ZCZ_EMISSA		:= CTOD(aDados[i][11])
					    ZCZ->ZCZ_VENCTO		:= CTOD(aDados[i][12])
					    ZCZ->ZCZ_VENCRE		:= CTOD(aDados[i][13])
					    ZCZ->ZCZ_VALOR		:= VAL( STRTRAN(aDados[i][14],",",".") )
					    ZCZ->ZCZ_BAIXA		:= CTOD(aDados[i][22])
					    ZCZ->ZCZ_SALDO		:= VAL( STRTRAN(aDados[i][15],",",".") )
					    ZCZ->ZCZ_VALREA		:= VAL( STRTRAN(aDados[i][16],",",".") )
					    ZCZ->ZCZ_FILORI		:= aDados[i][1]
					    ZCZ->ZCZ_CUSTO		:= aDados[i][2]
					    ZCZ->ZCZ_VLRBAI		:= VAL( STRTRAN(aDados[i][26],",",".") )
					    ZCZ->ZCZ_DESCON		:= VAL( STRTRAN(aDados[i][25],",",".") )
					    ZCZ->ZCZ_DTPG		:= CTOD(aDados[i][22])
					    ZCZ->ZCZ_BANCO		:= aDados[i][18]
					    ZCZ->ZCZ_AGENCI		:= aDados[i][19]
					    ZCZ->ZCZ_CONTA		:= aDados[i][20]
					    ZCZ->ZCZ_FMR		:= "1"
					    ZCZ->ZCZ_PROC		:= "N"					    
					    ZCZ->ZCZ_MOTBX		:= aDados[i][17]
					    ZCZ->ZCZ_MULTNA		:= "2" //Definido em reunião 30/09/2020  
					    ZCZ->ZCZ_LOGIN		:= "DATA " + DTOC( Date() ) + " HORA " + TIME() + " USUARIO " +  Alltrim(UPPER(UsrRetName(__CUSERID)))
				    MsUnLock() 
				Else
				  RecLock("ZCZ", .F.)
				  	ZCZ->ZCZ_PROC		:= "N"
				  	ZCZ->ZCZ_LOGIN		:= "DATA " + DTOC( Date() ) + " HORA " + TIME() + " USUARIO " +  Alltrim(UPPER(UsrRetName(__CUSERID)))
				  MsUnLock() 
				EndIf
			Next i
		
		End Transaction
	
	EndIf
		
	//Apos geração dos dados envia para gerar baixas
	If aRet[2] == 2
		BXTITREC()
	Else
		MsgInfo("Importação concluída com sucesso, numero de registros: " + cValToChar(nReg))
	EndIf

Return

/*/
{Protheus.doc} BLFINCR0
Description

	Importacao de Planilha Excel para Baixar TÃ­tulos CR 

@param xParam Parameter Description
@return Nil
@author  - Rodolfo Vacari
@since 23/05/19 
/*/
	
Static Function BXTITREC()	

	Local _nSomaLin		:= 0
	Local _nProcSuce	:= 0
	Local nRecTRB		:= 0
	Local aFinA080
		
	cQuery1 := " SELECT COUNT(*) AS COUNT FROM "+RETSQLNAME("ZCZ")+" WHERE ZCZ_FMR = '2' AND ZCZ_PROC = 'N' AND D_E_L_E_T_ != '*' " + CRLF
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery1 ),"TRB",.F.,.T.)
	
	nRecTRB := TRB->COUNT
	
	TRB->(dbCloseArea("TRB"))		
		
	ZCZ->(dbSelectArea("ZCZ"))
	ZCZ->(DbSetFilter( {|| ZCZ_FMR == "1" .AND. ZCZ_PROC == "N"  }, 'ZCZ_FMR == "1" .AND. ZCZ_PROC == "N" '))	
	ZCZ->(dbGoTop())		
	
	Procregua( nRecTRB )
								
	Do While ZCZ->(!EOF())
		
		//Registra barra de processamento
		incproc("Efetivando baixas de títulos " + cValToChar(_nSomaLin) + "/" + cValToChar(nRecTRB))	
		
		//Busca Titulo SE2
		SE2->( DbSeek(xFilial("SE2")+;
		   	   				PadR(ZCZ->ZCZ_PREFIX,TamSx3('E2_PREFIXO')[1]) +; 
		   	   				PadR(ZCZ->ZCZ_NUM	,TamSx3('E2_NUM')[1]) +;	
		   	   				PadR(ZCZ->ZCZ_PARCEL,TamSx3('E2_PARCELA')[1]) +;  
		   	   				PadR(ZCZ->ZCZ_TIPO	,TamSx3('E2_TIPO')[1]) +;
		   	   				PadR(ZCZ->ZCZ_CLIENT,TamSx3('E2_FORNECE')[1]) +;
		   	   				PadR(ZCZ->ZCZ_LOJA	,TamSx3('E2_LOJA')[1]) ))
		
		//Verifica se contém Juros
		nJuros := 0
		If ZCZ->ZCZ_VLRBAI > ZCZ->ZCZ_SALDO .And. SE2->E2_ACRESC = 0
			nJuros := ZCZ->ZCZ_VLRBAI - ZCZ->ZCZ_SALDO	 
		Endif  
	    
		//Array do titulo a receber, para a baixa do titulo
		
		aFinA080 :={{'E2_FILIAL',xFilial("SE2")									,Nil},;
					{"E2_PREFIXO" 			,padr(ZCZ->ZCZ_PREFIX	,TamSx3('E2_PREFIXO')[1])	,Nil},;
					{"E2_NUM"  				,padr(ZCZ->ZCZ_NUM		,TamSx3('E2_NUM')[1])		,Nil},;
					{"E2_TIPO" 				,padr(ZCZ->ZCZ_TIPO		,TamSx3('E2_TIPO')[1])		,Nil},;
					{"E2_NATUREZ"			,padr(ZCZ->ZCZ_NATURE	,TamSx3('E2_NATUREZ')[1])	,Nil},;
					{"E2_PARCELA"			,padr(ZCZ->ZCZ_PARCEL	,TamSx3('E2_PARCELA')[1])	,Nil},;
				 	{"E2_FORNECE" 			,padr(ZCZ->ZCZ_CLIENT	,TamSx3('E2_FORNECE')[1])	,Nil},;
					{"E2_LOJA"				,padr(ZCZ->ZCZ_LOJA		,TamSx3('E2_LOJA')[1])		,Nil},;
					{"E2_NOMFOR"			,ZCZ->ZCZ_NOMCLI					   			,Nil},;
					{"AUTMOTBX"	    		,ZCZ->ZCZ_MOTBX									,Nil},;
					{"AUTDTBAIXA"			,ZCZ->ZCZ_DTPG					      			,Nil},;
					{"E2_DTDIGIT"			,dDatabase		   								,Nil},;
					{"AUTDTDEB"				,ZCZ->ZCZ_BAIXA		       						,Nil},;
					{"AUTDESCONT"			,ZCZ->ZCZ_DESCON								,Nil},;
					{"AUTMULTA"	   			,IIF(nJuros <> 0,nJuros,0)						,Nil},;
					{"E2_ORIGEM" 			,'AUTBAIXA'    	  		   						,Nil},;
					{"E2_FLUXO"				,"S"          									,Nil},;
					{"AUTBANCO"				,padr(ZCZ->ZCZ_BANCO	,TamSx3('E5_BANCO')[1] ),Nil},;
					{"AUTAGENCIA"			,padr(ZCZ->ZCZ_AGENCI	,TamSx3('E5_AGENCIA')[1]),Nil},;
					{"AUTCONTA"				,padr(ZCZ->ZCZ_CONTA	,TamSx3('E5_CONTA')[1] ),Nil},;   
					{"AUTHIST"				,"VALOR PAGO S/ TITULO"  						,Nil},;	
					{"AUTVLRPG"				,ZCZ->ZCZ_VLRBAI								,Nil}}		   	
			        
		//verifica se ha erro no execauto
		lMsErroAuto := .F.
		
		//Altera data base
		_dDataBase 	:= dDataBase
		dDataBAse 	:= ZCZ->ZCZ_DTPG
	
		// Extrai os Dados das Celulas Cabeï¿½alho pedido
		If ZCZ->ZCZ_PROC == "N" //Verifica se ainda está Não
			
			SE5->(dbSelectArea("SE5"))
			SE5->(dbSetOrder(7)) //E5_FILIAL, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, E5_CLIFOR, E5_LOJA, E5_SEQ
			If SE5->(dbSeek( xFilial("SE5") + ZCZ->ZCZ_PREFIX + ZCZ->ZCZ_NUM + ZCZ->ZCZ_PARCEL + ZCZ->ZCZ_TIPO + ZCZ->ZCZ_CLIENT + ZCZ->ZCZ_LOJA ))
				lMsErroAuto := .F.
			Else
				FINA080(aFinA080,6) 
			EndIf
									
			dDataBase := _dDataBase
	
			cErro := ''
			
			If lMsErroAuto
								 
				//Verifica se baixa já ocorreu em outro processameento							 
				Reclock("ZCZ",.F.)
					ZCZ->ZCZ_PROC	:= "S"
					ZCZ->ZCZ_LOG	:= "LOG PROCESSO ERRO DATA " + DTOC( Date() ) + " HORA " + TIME() + " USUARIO " +  Alltrim(UPPER(UsrRetName(__CUSERID)))
					ZCZ->ZCZ_DATAP	:= Date()
					ZCZ->ZCZ_HORAP	:= TIME()    
				ZCZ->(MsUnlock())
			
				_nProcFalh++
														
			Else
			
				//Atualiza status e Log de Processamento:
				Reclock("ZCZ",.F.)
					ZCZ->ZCZ_PROC	:= "S"
					ZCZ->ZCZ_LOG	:= "LOG PROCESSO SUCESSO DATA " + DTOC( Date() ) + " HORA " + TIME() + " USUARIO " + Alltrim(UPPER(UsrRetName(__CUSERID)))
					ZCZ->ZCZ_DATAP	:= Date()
					ZCZ->ZCZ_HORAP	:= TIME()  
				ZCZ->(MsUnlock())
									
			    _nProcSuce++
			    
			EndIf
	     
	     EndIf
	        
		_nSomaLin++
					
		ZCZ->(dbSkip())
	Enddo

	//Finaliza Filtro
	ZCZ->(DBClearFilter())
		
	//Alimenta Final Rotina
	cDTHRFi		:= DTOC( Date() ) + " " + Time()
	
	MsgAlert(	'Total processado: ' + cValToChar(_nSomaLin) + '.' 	+ chr(13) + chr(10) + ;
				'Total processado com sucesso: ' + cValToChar(_nProcSuce) + '.' 	+ chr(13) + chr(10) + ;
				'Total processado com falha: ' + cValToChar(_nProcFalh) + '.'  + chr(13) + chr(10) + ;
				'Inicio: ' + cDTHRIn + ' Fim ' + cDTHRFi, 'Processamento finalizado')
	
Return
