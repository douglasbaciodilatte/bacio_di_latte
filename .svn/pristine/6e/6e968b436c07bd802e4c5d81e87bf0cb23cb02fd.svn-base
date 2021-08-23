#INCLUDE "RWMAKE.CH" 
#INCLUDE "TOPCONN.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "PARMTYPE.CH"

#DEFINE CMD_OPENWORKBOOK			1
#DEFINE CMD_CLOSEWORKBOOK			2
#DEFINE CMD_ACTIVEWORKSHEET			3
#DEFINE CMD_READCELL				4
#DEFINE ENTER chr(13)+chr(10)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑบPrograma ณ BLFINPR1    บAutorณ Felipe Mayer	      		  บ Data Iniณ 10/02/2020 บฑฑ
ฑฑฬอออออออออุอออออออออออออออออสอออออฯออออออออออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.    ณ 	Importa็ใo de mov. bancarios Pagar/Receber							  ฑฑ
ฑฑฬอออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso      ณ 		Bacio di Latte	- RVACARI                                  		 บฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

User Function BLFINPR1()

Private oDlg
			
			DEFINE MSDIALOG oDlg FROM 003,001 To 120,520 TITLE OemToAnsi("Importa็ใo de Movimentos Bancarios") PIXEL   
			@ 005,003 To 048,258 LABEL "" OF oDlg  PIXEL
			@ 015,015 SAY OemToAnsi("Esta rotina realiza a importa็ใo de mov. bancarios Pagar/Receber da empresa Bacio di Latte.") SIZE 268, 8 OF oDlg PIXEL
			@ 027,015 SAY OemToAnsi("Confirma a importa็ใo de mov. bancarios?") SIZE 268, 8 OF oDlg PIXEL
			DEFINE SBUTTON FROM 032,188 TYPE 1 ACTION MNTCSV() ENABLE OF oDlg
			DEFINE SBUTTON FROM 032,218 TYPE 2 ACTION oDlg:End() ENABLE OF oDlg
			ACTIVATE MSDIALOG oDlg CENTER
			
Return

Static Function MNTCSV()

	Processa( {|| LINCSV() }, "BDLINV01", "Processando aguarde...", .F.)
	    
    MsgInfo("Movimentos Bancarios incluidos com sucesso !!!")
    oDlg:End()

Return

Static Function LINCSV()

Local cLinha	  := ""
Local cArqAux	  := ""
Local cRateio	  := "N"
Local aCampos 	  := {}
Local cMascara	  := 'Arquivo CSV|*.csv| Arquivo TXT|*.txt'
Local cTitulo  	  := 'Selecao de Arquivos'
Local cDirinicial := 'C:\'
Local lMsErroAuto := .F.
Local lSalvar	  := .F.
Local lArvore	  := .T.
Local lPrim   	  := .T.
Local aDados  	  := {}    
Local aPagar 	  := {}
Local aReceber	  := {}
Local nX		  := 0
Local nMascpadrao := 0
Local nOpcoes	  := GETF_LOCALHARD + GETF_NETWORKDRIVE


    cArqAux := cGetFile(cMascara, cTitulo, nMascpadrao, cDirinicial, lSalvar, nOpcoes, lArvore)
     
	If !File(cArqAux)
		MsgStop("O arquivo " +cArqAux + " nใo foi encontrado. A importa็ใo serแ abortada!","[BLFINPR1] - ATENCAO")
		Return
	EndIf
	
	FT_FUSE(cArqAux)
	ProcRegua(FT_FLASTREC())
	FT_FGOTOP()
	
	While !FT_FEOF()
		
		IncProc("Lendo arquivo ...")
		
		cLinha := FT_FREADLN()
		
			If lPrim  
				aCampos := Separa(cLinha,";",.T.)
				lPrim := .F.
			Else                     
				AAdd(aDados,Separa(cLinha,";",.T.))
			EndIf
		
		FT_FSKIP()
	EndDo          
	    

	Begin Transaction
		For nX := 1 to len(aDados)
			If Alltrim(aDados[nX,10]) == 'P'
			 aPagar:={}
			 aPagar:={     {"E5_DATA"	 	, dDataBase 							,  Nil},;
						   {"E5_MOEDA"    	, Alltrim(aDados[nX,01])				,  Nil},;
						   {"E5_VALOR"  	, Val(StrTran(aDados[nX,02],",","."))	,  Nil},;
						   {"E5_NATUREZ"   	, Alltrim(aDados[nX,03])				,  Nil},;
						   {"E5_BANCO"   	, Alltrim(aDados[nX,04])				,  Nil},;
						   {"E5_AGENCIA"	, Alltrim(aDados[nX,05])				,  Nil},;
						   {"E5_CONTA"		, Alltrim(aDados[nX,06])				,  Nil},;
						   {"E5_DOCUMEN"	, Alltrim(aDados[nX,07])				,  Nil},;
						   {"E5_HISTOR"		, Upper(Alltrim(aDados[nX,08])) 		,  Nil},;
						   {"E5_RATEIO"		, cRateio						 		,  Nil},;
						   {"E5_CCUSTO"		, Alltrim(aDados[nX,09])				,  Nil} }
					   
		        MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aPagar,3)
		   
		        If lMsErroAuto
		           	MostraErro()
		           	MsgAlert("Erro na inclusao, verificar arquivo importado")
		        EndIf      
					        
			ElseIf Alltrim(aDados[nX,10]) == 'R'
			 aReceber:={}	   
			 aReceber:={   {"E5_DATA"	 	, dDataBase 							,  Nil},;
						   {"E5_MOEDA"    	, Alltrim(aDados[nX,01])				,  Nil},;
						   {"E5_VALOR"  	, Val(StrTran(aDados[nX,02],",","."))	,  Nil},;
						   {"E5_NATUREZ"   	, Alltrim(aDados[nX,03])				,  Nil},;
						   {"E5_BANCO"   	, Alltrim(aDados[nX,04])				,  Nil},;
						   {"E5_AGENCIA"	, Alltrim(aDados[nX,05])				,  Nil},;
						   {"E5_CONTA"		, Alltrim(aDados[nX,06])				,  Nil},;
						   {"E5_DOCUMEN"	, Alltrim(aDados[nX,07])				,  Nil},;
						   {"E5_HISTOR"		, Upper(Alltrim(aDados[nX,08])) 		,  Nil},;
						   {"E5_RATEIO"		, cRateio						 		,  Nil},;
						   {"E5_CCUSTO"		, Alltrim(aDados[nX,09])				,  Nil} }
						   			   
			   		MSExecAuto({|x,y,z| FinA100(x,y,z)},0,aReceber,4)
			   	
		        If lMsErroAuto
		            MostraErro()
		            MsgAlert("Erro na inclusao, verificar arquivo importado")
		        EndIf
		             
		    EndIf    
		Next nX
	End Transaction

Return