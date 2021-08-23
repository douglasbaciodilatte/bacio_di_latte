#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "TBICONN.CH"
#define CMD_OPENWORKBOOK			1
#define CMD_CLOSEWORKBOOK			2
#define CMD_ACTIVEWORKSHEET			3
#define CMD_READCELL				4

/*/
{Protheus.doc} BLFINCR3
Description

	Importacao de Planilha Excel para transferência de valores

@param xParam Parameter Description
@return Nil
@author  - Douglas Rodrigues da Silva
@since 21/10/2019
/*/

User Function BLFINCR3()

LOCAL oDlg
LOCAL nOpca:=0
Local aPergs 	  := {}
Local cCaminho  := Space(60)
Local oSay1

Private aRet 	  := {}
Private nGet1 := 0


aAdd( aPergs ,{6,"Diretorio do Arquivo",cCaminho,"@!",,'.T.',80,.F.,"Arquivos .xlsx |*.csv " })

	If ParamBox(aPergs ,"Parametros ",aRet)
			
		DEFINE MSDIALOG oDlg FROM  96,9 TO 310,592 TITLE OemToAnsi("Importação Transferências") PIXEL   
			@ 18, 4 TO 80, 287 LABEL "" OF oDlg  PIXEL
			@ 29, 15 SAY OemToAnsi("Esta rotina realiza a importacao de Planilha Excel Com  os dados para Geracao de Baixas") SIZE 268, 8 OF oDlg PIXEL
			@ 38, 15 SAY OemToAnsi("Da empresa Bacio diLatte.") SIZE 268, 8 OF oDlg PIXEL
			@ 48, 15 SAY OemToAnsi("Confirma Geracao de Baixas?") SIZE 268, 8 OF oDlg PIXEL
		    @ 58, 15 SAY oSay1 PROMPT "Informe a quantidade de titulos." SIZE 089, 007 OF oDlg COLORS 0, 16777215 PIXEL    
	
		DEFINE SBUTTON FROM 90, 223 TYPE 1 ACTION (oDlg:End(),nOpca:=1) ENABLE OF oDlg
		DEFINE SBUTTON FROM 90, 250 TYPE 2 ACTION oDlg:End() ENABLE OF oDlg
		ACTIVATE MSDIALOG oDlg CENTER
			
		Processa( {|| fImpExcel(nGet1) } ,'Aguarde Efetuando Importacao da Planilha' )
		
	Endif

Return

/*/
{Protheus.doc} BLFINCR3
Description

	Importacao de Planilha Excel para transferência de valores

@param xParam Parameter Description
@return Nil
@author  - Douglas Rodrigues da Silva
@since 21/10/2019
/*/

Static Function FImpExcel(nGet1)

Local cDir		  	:= Alltrim(MV_PAR01)
Local cArq		  	:= Alltrim(MV_PAR02)
Local lPrim			:= .T.	
Local aDados		:= {}
Local aCampos		:= {}
Local nReg			:= 0
Local nNReg			:= 0
Local aFINA100		:= {}
Local i				:= 0
Local lMsErroAuto	:= .F.	
Local _dDataBase	:= Date()
Local cLinErro
Local lMsErroAuto	:= .F.
Local cErroTemp		:= ""
	
	cFile   := aRet[1]

	If ! Empty(cFile) 

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
			
			IncProc("Efetuando baixas: " +  aDados[i][10])	
			
			  aFINA100 := {    	{"CBCOORIG"     	,PADR( aDados[i][1] ,TamSx3('E5_BANCO')[1] ) ,Nil},;
	                            {"CAGENORIG"        ,PADR( aDados[i][2] ,TamSx3('E5_AGENCIA')[1]),Nil},;
	                            {"CCTAORIG"         ,PADR( aDados[i][3] ,TamSx3('E5_CONTA')[1])  ,Nil},;
	                            {"CNATURORI"        ,PADR( aDados[i][4] ,TamSx3('E5_NATUREZ')[1]),Nil},;
	                            {"CBCODEST"         ,PADR( aDados[i][5] ,TamSx3('E5_BANCO')[1] ) ,Nil},;
	                            {"CAGENDEST"        ,PADR( aDados[i][6] ,TamSx3('E5_AGENCIA')[1]),Nil},;
	                            {"CCTADEST"         ,PADR( aDados[i][7] ,TamSx3('E5_CONTA')[1])  ,Nil},;
	                            {"CNATURDES"        ,PADR( aDados[i][8] ,TamSx3('E5_NATUREZ')[1]),Nil},;
	                            {"CTIPOTRAN"        ,PADR( aDados[i][9] ,2)   ,Nil},;
	                            {"CDOCTRAN"         ,PADR( aDados[i][10],TamSx3('E5_DOCUMEN')[1]),Nil},;
	                            {"NVALORTRAN"       ,VAL( STRTRAN(aDados[i][11],",",".") )		 ,Nil},;
	                            {"CHIST100"         ,PADR( aDados[i][12],TamSx3('E5_HISTOR')[1]) ,Nil},;
	                            {"CBENEF100"        ,PADR( aDados[i][13],TamSx3('E5_BENEF')[1])  ,Nil} } 
	   
				//Altera data base
				_dDataBase 	:= dDataBase
				dDataBAse 	:= CTOD(aDados[i][14])                         	
	                            
				MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aFINA100,7)
				
				//Guarda Erro:
				cErroTemp += Mostraerro("C:\temp\", "BLFINCR3" + ".log")
						      
		        dDataBase := _dDataBase
		        
			Next i
		
		End Transaction
	
	EndIf

	MemoWrite("C:\TOTVS\" + "BLFINCR3_" + DTOS(DATE()) + SUBSTR( TIME() ,1,2) + SUBSTR( TIME() ,4,2) + ".Log",cErroTemp)
	
	If Empty( cErroTemp ) 
		MsgInfo("Arquivo processado com sucesso, nao houve erros!")
	Else
		
		MsgInfo("ATENÇÃO: Arquivo processado, verifique o log de processamento: C\TOTVS\BLFINCR3" )
	EndIf
	
Return