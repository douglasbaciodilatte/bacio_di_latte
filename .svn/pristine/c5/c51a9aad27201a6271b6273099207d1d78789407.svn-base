#include "rwmake.ch"
#include "topconn.ch"
#include "totvs.ch"

/*/{Protheus.doc} BLMRP0001
Função que irá subir para a tabela SZ7 os EDI dos clientes
@author Rodolfo Vacari
@since 07/07/16
@version 1.0
@return Nil
/*/

#DEFINE OPEN_FILE_ERROR -1
User Function WRFATA01()
	Private cCadastro 	:= "Forecasts Clientes"
	Private cString		:= "SZ7" //Tabela relacionada aos chamados. 
	
	Private bImporta	:= {|| fIncluir()	}
	Private bLegenda	:= {|| fLegenda()	}
	Private bImprime 	:= {|| fReport()	}
		
	Private aRotina 	:= {	{"Pesquisar",			"AxPesqui",			0,1}	,;
								{"Visualizar",			"AxVisual",			0,2}	,;
								{"Importar Forecasts",	"eval(bImporta)",	0,3}	,;
								{"Alterar Forecast",	"AxAltera",			0,4}	,;
								{"Excluir Forecast",	"AxDelete",			0,5}	,;
								{"Relação Forecast",	"eval(bImprime)",	0,6}	,;
								{"Legenda",				"eval(bLegenda)",	0,7}	}	
							
	Private aCores 		:= {	{"Empty(SZ7->Z7_STATUS)"	, 	"BR_VERDE"		} 	,;
								{"!Empty(SZ7->Z7_STATUS)"	,	"BR_VERMELHO"	}	}
	
	dbSelectArea("SZ7")
	dbSetOrder(1)
	dbGoTop()
	mBrowse(6,1,22,75,cString,,,,,,aCores)
Return

//|-------------------------------|
//|Função de criação do relatorio |
//|-------------------------------|
Static function fReport()
	Local aBtn := {}
	Local aSay := {}
	Local cPerg 	:= Alltrim(UPPER(funName()))
	
	fValidPerg(cPerg)
	
	aAdd(aSay,"Relatório em excel de com a relação dos programas de previsões enviado")
	aAdd(aSay,"pelos clientes.")
	aAdd(aSay,"Relatório será impresso em excel.")
	aAdd(aSay,"")
	aAdd(aSay,Replicate("-",120))
	aAdd(aSay,"Após Configurado os Parâmetros Clique no botão OK para executar a rotina.")
	aAdd(aSay,Replicate("-",120))
	
	aAdd(aBtn,{5,.T.,{|| Pergunte(cPerg,.T.)}})
	aAdd(aBtn,{1,.T.,{|| FechaBatch(), MsgRun("Aguarde, Localizando Informações...","", {|| CursorWait(), Processa({|| fImprime(cPerg)}, "Processando...","Aguarde !!",.T.), CursorArrow()})  }})
	aAdd(aBtn,{2,.T.,{|| FechaBatch()}})   
	
	FormBatch(FunDesc(),aSay,aBtn)
Return

//|-----------------------------------------------|
//|Funcao principal de processamento do relatorio |
//|-----------------------------------------------|
Static function fImprime(cPerg)
	Local cOrigem := ""
	Local cDestino := ""
	
	if fQuery(cPerg)
		ProcRegua(RecCount())
		fCriaArq(@cOrigem)
		
		Processa({|| fCarga()}," Carregando relatorio...")
		
		cTempSZ7->(dbCLoseArea())
		
		cDestino := cGetFile("Arquivo XLS (*.XLS)|*.XLS","Selecione o diretório a ser salvo o arquivo...",0,"",.F.,GETF_RETDIRECTORY+GETF_LOCALHARD+GETF_NETWORKDRIVE,.F.)
		cFile 	 := cDestino+"Forecasts_Bacio_"+Dtos(ddatabase)+"_"+Alltrim(cUserName)+".xls"
				
		__CopyFile(cOrigem,cFile)   
		fClose(cOrigem)
		fErase(cOrigem)
			
		oExcel:= MsExcel():New()
		oExcel:WorkBooks:Open(cFile)
		oExcel:SetVisible(.T.)		
	endIf
Return

//|---------------------------------------------|
//|Função que faz a carga no arquivo temporario |
//|---------------------------------------------|
Static function fCarga()

	ProcRegua(RecCount())
	cQrySZ7->(dbGoTop())
	
	Begin Transaction
		while cQrySZ7->(!Eof())
			incProc()
			
			cTempSZ7->(RecLock("cTempSZ7",.t.))
				cTempSZ7->DOCUMENTO		:= cQrySZ7->Z7_DOC
				cTempSZ7->PRD_WIN		:= cQrySZ7->Z7_PRODUTO
				cTempSZ7->PRD_CLI		:= cQrySZ7->Z7_PRODCLI
				cTempSZ7->DESCRICAO		:= cQrySZ7->Z7_DESC
				cTempSZ7->LOCAL			:= cQrySZ7->Z7_LOCAL
				cTempSZ7->QTDE			:= cQrySZ7->Z7_QUANT
				cTempSZ7->DT_ENTREGA	:= cQrySZ7->Z7_ENTREGA
				ctempSZ7->SEM_ENTREG	:= cQrySZ7->Z7_SEMENTR 
				cTempSZ7->CLIENTE		:= cQrySZ7->Z7_CLIENTE
				cTempSZ7->LOJA			:= cQrySZ7->Z7_LOJA
				cTempSZ7->NOME			:= cQrySZ7->Z7_NOME
				cTempSZ7->GRUPO			:= cQrySZ7->Z7_GRUPO
				cTempSZ7->DT_UPLOAD		:= cQrySZ7->Z7_UPLOAD
				cTempSZ7->SEM_UPLOAD	:= cQrySZ7->Z7_SEMUP				
				
				if Empty(cQrySZ7->Z7_STATUS)
					cTempSZ7->STATUS := "ABERTO"
				else
					cTempSZ7->STATUS := "FECHADO"
				endIf
				
			cTempSZ7->(Msunlock())
			Commit			
		
			cQrySZ7->(dbSkip())
		endDo
	End Transaction

Return

//|-----------------------------------------------|
//|Função que faz a criação do arquivo temporario |
//|-----------------------------------------------|
Static function fCriaArq(cOrigem)
	Local cArq 		:= ""
	Local cPath		:= GetSrvProfString("StartPath","") 
	Local cIndex	:= "PRD_WIN"
	Local aCampos	:= {}   
	Local cFile 	:= ""
	
	aCampos := {}
	aAdd(aCampos,	{"DOCUMENTO",	"C",	tamsx3("Z7_DOC")[1],		tamsx3("Z7_DOC")[2]		})
	aAdd(aCampos,	{"PRD_WIN",		"C",	tamsx3("Z7_PRODUTO")[1],	tamsx3("Z7_PRODUTO")[2]	})
	aAdd(aCampos,	{"PRD_CLI",		"C",	tamsx3("Z7_PRODCLI")[1],	tamsx3("Z7_PRODCLI")[2]	})
	aAdd(aCampos,	{"DESCRICAO",	"C",	tamsx3("Z7_DESC")[1],		tamsx3("Z7_DESC")[2]	})
	aAdd(aCampos,	{"LOCAL",		"C",	tamsx3("Z7_LOCAL")[1],		tamsx3("Z7_LOCAL")[2]	})
	aAdd(aCampos,	{"QTDE",		"N",	tamsx3("Z7_QUANT")[1],		tamsx3("Z7_QUANT")[2]	})
	aAdd(aCampos,	{"DT_ENTREGA",	"D",	8,		0	})
	aAdd(aCampos,	{"SEM_ENTREG",	"C",	2,		0	})
	aAdd(aCampos,	{"CLIENTE",		"C",	tamsx3("Z7_CLIENTE")[1],	tamsx3("Z7_CLIENTE")[2]	})
	aAdd(aCampos,	{"LOJA",		"C",	tamsx3("Z7_LOJA")[1],		tamsx3("Z7_LOJA")[2]	})
	aAdd(aCampos,	{"NOME",		"C",	tamsx3("Z7_NOME")[1],		tamsx3("Z7_NOME")[2]	})
	aAdd(aCampos,	{"GRUPO",		"C",	tamsx3("Z7_GRUPO")[1],		tamsx3("Z7_GRUPO")[2]	})
	aAdd(aCampos,	{"DT_UPLOAD",	"D",	8,		0	})
	aAdd(aCampos,	{"SEM_UPLOAD",	"C",	2,		0	})
	aAdd(aCampos,	{"STATUS",		"C",	10,		0	})
	
	cArq := CriaTrab(aCampos,.T.)
	
	cOrigem := cPath+cArq+".dbf"	
	if select("cTempSZ7") <> 0
		cTempSZ7->(dbCloseArea())
	endIf
	
	dbUseArea(.T.,__LocalDrive,cArq,"cTempSZ7",.F.,.F.)                      
Return

//|---------------------------------------|
//|Funçao de execução da query de seleção |
//|---------------------------------------|
Static function fQuery(cPerg)
	Local cQry := ""
	
	Pergunte(cPerg,.f.)
	
	cQry := " SELECT * FROM "+RetSQLName("SZ7")+" SZ7 "
	cQry += " WHERE "
	cQry += "		SZ7.D_E_L_E_T_ = ' ' "
	cQry += " 		AND SZ7.Z7_ENTREGA BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"' "
	cQry += " 		AND SZ7.Z7_PRODUTO BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"' "
	cQry += " 		AND SZ7.Z7_CLIENTE BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' "
	
	//Apenas em aberto
	if MV_PAR07 == 1
		cQry += " 	AND SZ7.Z7_STATUS = ' ' "
	endIf
	
	//Apenas fechado
	if MV_PAR07 == 2
		cQry += " 	AND SZ7.Z7_STATUS = 'X' "
	endIf	
		
	cQry += " ORDER BY SZ7.Z7_ENTREGA, SZ7.Z7_PRODUTO "
	
	if select("cQrySZ7") <> 0
		cQrySZ7->(dbCloseArea())
	endIf
	
	TcQuery cQry ALIAS "cQrySZ7" NEW
	TcSetField("cQrySZ7",	"Z7_QUANT",	"N",	tamsx3("Z7_QUANT")[1],	tamsx3("Z7_QUANT")[2]	)
	TcSetField("cQrySZ7",	"Z7_ENTREGA",	"D",	8,0)
	TcSetField("cQrySZ7",	"Z7_UPLOAD",	"D",	8,0)	
	
	dbSelectArea("cQrySZ7")
	count to nSZ7
	
	if nSZ7 <= 0
		MsgStop("Sem dados para apresentar !","VERIFICAR PARAMETROS")
		Return .f.
	endIf	
Return .t.

//|--------------------------|
//| Faz a chamada da legenda |
//|--------------------------|
Static Function fLegenda(cString)
	BrwLegenda(cCadastro, "Legenda", {	{"BR_VERMELHO" 		,"Forecast Inativo" 	}	,;										
										{"BR_VERDE"			,"Forecast Ativo"		}	})											
Return       	

//Função que inclui o forecast no sistema tabela - SZ7
Static function fIncluir()
	Local oDlg := oGroup1 := oBtn := Nil
	Local cCodCli 	:= space(tamsx3("A1_COD")[1])
	Local cLoja 	:= ""
	Local cRazao	:= ""
	Local cArquivo 	:= Space(100)	
	Local aBtn		:= {}
	Local nLin 	:= 30
	
	bOK := {|| Processa({|| fProcessa(cCodCli,cLoja,cRazao,cArquivo)},"Realizando upload...")}
	DEFINE MSDIALOG oDlg TITLE "Importação de Forecast" FROM 000, 000  TO 165, 470 COLORS 0, 16777215 PIXEL

	    @ 000, 000 GROUP oGroup1 TO 055, 235 PROMPT "  Importação de Forecast  " OF oDlg COLOR 16711680, 16777215 PIXEL
	    
	    @ 008+nLin, 004 SAY "Cod.Cliente" SIZE 038, 007 OF oDlg COLORS 0, 16777215 PIXEL
	    @ 017+nLin, 004 MSGET oGet1 VAR cCodCli F3 "SA1" SIZE 060, 010 OF oDlg COLORS 0, 16777215 PIXEL valid fValCliente(cCodCli,@cLoja,@cRazao)
	    
	    @ 008+nLin, 069 SAY "Loja" SIZE 025, 007 OF oDlg COLORS 0, 16777215 PIXEL	    
	    @ 017+nLin, 069 MSGET oGet3 VAR cLoja SIZE 025, 010 OF oDlg COLORS 0, 16777215 PIXEL when .f.
	    
	    @ 008+nLin, 099 SAY "Razão Social" SIZE 051, 007 OF oDlg COLORS 0, 16777215 PIXEL
	    @ 017+nLin, 099 MSGET oGet4 VAR cRazao SIZE 131, 010 OF oDlg COLORS 0, 16777215 PIXEL when .f.
	    
	    @ 030+nLin, 004 SAY "Arquivo CSV" SIZE 064, 007 OF oDlg COLORS 0, 16777215 PIXEL
	    @ 039+nLin, 004 MSGET oGet2 VAR cArquivo SIZE 182, 010 OF oDlg COLORS 0, 16777215 PIXEL when .f.
	    
	    @ 039+nLin, 193 BUTTON oBtn PROMPT "Buscar" SIZE 037, 012 OF oDlg PIXEL action fBuscaArq(@cArquivo)	    
	  	
	    // Don't change the Align Order
	    oGroup1:Align := CONTROL_ALIGN_ALLCLIENT

	ACTIVATE MSDIALOG oDlg CENTERED on Init (EnchoiceBar(oDlg,{|| Eval(bOK)	, oDlg:end() }, {||oDlg:End()},,@aBtn))
Return

//|Funcao que processa o upload
Static function fProcessa(cCliente,cLoja,cRazao,cArquivo)
	Local xBuffer := ""
	Local nLin := 0
	Local nCol := 0
	Local cAux := ""
	Local cProdCli := ""
	Local cProduto := ""
	Local dData := CtoD("  /  /  ")
	Local nQuant := 0.00
	Local aLog := {}
	Local cDoc := ""
	
	//Variaveis para o log
	Local cEnvServ		:= GetEnvServer()
	Local cIniFile		:= GetADV97()
	Local cEnd			:= GetPvProfString(cEnvServ,"StartPath","",cIniFile)   
	Local cDtHr 		:= DtoS(dDataBase)+"-"+Substr(time(),1,2)+"-"+Substr(time(),4,2)+"-"+Substr(time(),7,2)
	Local cPath			:= "\CSV\"
	Local cTipoLog		:= "Importação_"
	Local cNomeLog		:=	cPath+cTipoLog+cDtHr+"_Log.txt"
	Local cArq			:=	cEnd+cNomeLog
	Local nQtos			:= 0.00
	Local nHdl 			:= 0
	
	MAKEDIR(cEnd+cPath)
	
	//|-------------------------|
	//|Inicia a gravação do log |
	//|-------------------------|
	AAdd(aLog, Replicate( '=', 80 ) )
	AAdd(aLog, 'INICIANDO O LOG - I M P O R T A Ç Ã O  C S V  F O R E C A S T' )
	AAdd(aLog, Replicate( '-', 80 ) )
	AAdd(aLog, 'DATABASE...........: ' + DtoC( dDataBase ) )
	AAdd(aLog, 'DATA...............: ' + DtoC( Date() ) )
	AAdd(aLog, 'HORA...............: ' + Time() )
	AAdd(aLog, 'ENVIRONMENT........: ' + GetEnvServer() )
	AAdd(aLog, 'PATCH..............: ' + GetSrvProfString( 'StartPath', '' ) )
	AAdd(aLog, 'ROOT...............: ' + GetSrvProfString( 'RootPath', '' ) )
	AAdd(aLog, 'VERSÃO.............: ' + GetVersao() )
	AAdd(aLog, 'MÓDULO.............: ' + 'SIGA' + cModulo )
	AAdd(aLog, 'EMPRESA / FILIAL...: ' + SM0->M0_CODIGO + '/' + SM0->M0_CODFIL )
	AAdd(aLog, 'NOME EMPRESA.......: ' + Capital( Trim( SM0->M0_NOME ) ) )
	AAdd(aLog, 'NOME FILIAL........: ' + Capital( Trim( SM0->M0_FILIAL ) ) )
	AAdd(aLog, 'USUÁRIO............: ' + SubStr( cUsuario, 7, 15 ) )
	Aadd(aLog, 'CLIENTE............: ' + Alltrim(cCliente) + " - " + Alltrim(cRazao))
	Aadd(aLog, 'Arquivo Upload.....: ' + Alltrim(cArquivo))
	AAdd(aLog, Replicate( ':', 80 ) )
	AAdd(aLog, '' )	
	AAdd(aLog, "Importação CSV = INICIO - Data "+DtoC(dDataBase)+ " as "+Time() )
	AAdd(aLog, '' )
	
	//|Antes de iniciar o carregamento do novo arquivo, alterar o status da programação antiga
	fAltOldPrg(cCliente)

	//Começa a abertura do programa
	if FT_FUSE(cArquivo) != OPEN_FILE_ERROR
		ProcRegua(FT_FLASTREC())
		
		dbSelectArea("SZ7")
		
		While !FT_FEOF()
			incProc()
			
			nLin++	
			
			If nLin == 1
	 			FT_FSKIP()
	 			loop
	 		EndIf
	 		
	 		nQtos++
	 		
	 		xBuffer	:= FT_FREADLN()+';'
	 		nCol := 1
	 		cAux := ""
	 		
	 		for i:=1 to len(alltrim(xBuffer))
	 			If	Substr(xBuffer,i,1) <> ";"
					cAux	:= cAux + Substr(xBuffer,i,1)
				else
					Do Case
						Case nCol == 1
							cProdCli	:= Alltrim(cAux)		
							
							cQry := " SELECT SB1.R_E_C_N_O_ AS RECSB1 "
							cQry += " FROM "+RetSQLName("SB1")+" SB1 "
							cQry += " WHERE "
							cQry += " 		SB1.D_E_L_E_T_ = ' ' "
							cQry += " 		AND SB1.B1_ZZPRCLI = '"+cProdCli+"' "
							
							if select("cQrySB1") <> 0
								cQrySB1->(dbCloseArea())
							endIf
							
							TcQuery cQry ALIAS "cQrySB1" NEW
							TcSetField("cQrySB1", "RECSB1", "N", 6,0)
							
							dbSelectArea("cQrySB1")
							cQrySB1->(dbGoTop())
							
							dbSelectArea("SB1")
							SB1->(dbGoTo(cQrySB1->RECSB1))
																	
							cProduto	:=	SB1->B1_COD
						Case nCol == 2
							dData		:=	CTOD(cAux)							
						Case nCol == 3
							nQuant		:=	val(alltrim(cAux))						
					EndCase
					
					cAux:= ""
					nCol++
				endIf	 				 		
	 		next i	 
	 		
	 		if Empty(cProduto) .or. Empty(cProdCli)
	 			//aAdd(aLog, cProdCli)
	 			AAdd(aLog, "Importação CSV = Produto Cliente - "+alltrim(cProdCli)+ " não encontrada referencia no cadastro de produtos!!!")
	 		else	
	 			cDoc := Alltrim(cCliente)+SubStr(cValtochar(Year(dDatabase)),3,2)+StrZero(Val(SubStr(RetSem(dDatabase),1,2)),3)
	 			SZ7->(RecLock("SZ7",.T.))
	 				SZ7->Z7_FILIAL 	:= xFilial("SZ7")
	 				SZ7->Z7_DOC		:= cDoc
	 				SZ7->Z7_PRODUTO := cProduto
	 				SZ7->Z7_UM		:= RetField("SB1",1,xFilial("SB1")+cProduto,"B1_UM")
	 				SZ7->Z7_LOCAL	:= RetField("SB1",1,xFilial("SB1")+cProduto,"B1_LOCPAD")
	 				SZ7->Z7_DESC	:= RetField("SB1",1,xFilial("SB1")+cProduto,"B1_DESC")			 				
	 				SZ7->Z7_QUANT	:= nQuant
	 				SZ7->Z7_ENTREGA := dData
	 				SZ7->Z7_UPLOAD	:= dDatabase
	 				SZ7->Z7_CLIENTE	:= cCliente
	 				SZ7->Z7_LOJA	:= RetField("SA1",1,xFilial("SA1")+cCliente,"A1_LOJA")
	 				SZ7->Z7_NOME	:= RetField("SA1",1,xFilial("SA1")+cCliente,"A1_NREDUZ")
	 				SZ7->Z7_PRODCLI	:= cProdCli
	 				SZ7->Z7_GRUPO	:= RetField("SB1",1,xFilial("SB1")+cProduto,"B1_GRUPO")
	 				SZ7->Z7_STATUS	:= ""
	 				SZ7->Z7_SEMUP	:= StrZero(Val(SubStr(RetSem(dDatabase),1,2)),2)
	 				SZ7->Z7_SEMENTR := StrZero(Val(SubStr(RetSem(dData),1,2)),2)	 				
	 			SZ7->(Msunlock())
	 			Commit
	 			
				AAdd(aLog, "Importação CSV = Produto - "+alltrim(cProduto)+ " - Quant.: "+alltrim(Transform((nQuant),"@E 999,999,999.99"))+" - Data: "+DTOC(dData) )				
	 		endIf
	 			 		
	 		FT_FSKIP()
		endDo 
		
		AAdd(aLog, '' )
		AAdd(aLog, "Importação CSV = Total de Registros = "+ Alltrim(Str(nQtos)))
		AAdd(aLog, "Importação CSV = FIM Data "+DtoC(dDataBase)+ " as "+Time() )
		
		nHdl  := 	fCreate(cArq)
		
		If nHdl == -1
			MsgAlert("O arquivo  "+cArq+" nao pode ser criado!","Atencao!")
			fClose(nHdl)
			fErase(cArq)
		 	Return()
		EndIf	
	endIf
	
	cLin := ""
	For nCont := 1 to Len(aLog)
			
		cLin :=""
		cLin := aLog[nCont] + CHR(13)+CHR(10)
		
		If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
			fClose(nHdl)
		    fErase(cArq)
		    Return()
		EndIf		
	Next nCont
		
	fClose(nHdl)
	
	ApMsgInfo("Verifique arquivo de log "+cArq)	
Return

//|Função que finaliza o ultimo programa 
Static function fAltOldPrg(cCliente)
	Local cQry := ""
	
	cQry := " UPDATE "+RetSQLName("SZ7")
	cQry += " SET Z7_STATUS = 'X' "
	cQry += " WHERE "
	cQry += " 	D_E_L_E_T_ = ' ' "
	cQry += " 	AND Z7_CLIENTE = '"+cCliente+"' "
	cQry += " 	AND Z7_STATUS = ' ' "
	
	TcSqlExec(cQry)	
	COMMIT

Return

//|Função que busca o cliente
Static function fValCliente(cCodCli,cLoja,cRazao)
	
	if !Empty(cCodCli)
		if ExistCpo("SA1",cCodCli)
			cLoja := Retfield("SA1",1,xFilial("SA1")+cCodCli,"A1_LOJA")
			cRazao := Retfield("SA1",1,xFilial("SA1")+cCodCli,"A1_NOME")
		endIf
	endIf

Return .t.

//Função que busca o arquivo a ser importado 
Static function fBuscaArq(cArquivo)
	cArquivo := Alltrim(cGetFile( '*.CSV|*.CSV' , 'Arquivos do formato CSV', 1, 'C:\', .T., GETF_LOCALHARD+GETF_NETWORKDRIVE,.F.,.F.))
Return

//|-----------------------------------------|
//|Validação e criação das perguntas no SX1 |
//|-----------------------------------------|
Static Function fValidPerg(cPerg)
	Local _sAlias := Alias()
	Local aRegs := {}
	Local i,j
	
	dbSelectArea("SX1")
	dbSetOrder(1)
	
	cPerg := PADR(cPerg,Len(SX1->X1_GRUPO))
	
	// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
	aAdd(aRegs, {cPerg, "01", "de Data Entrega ? "       	,"" ,"" ,"mv_ch1", "D"  , 8, 						0, 							0, "G", ""	, "mv_par01", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
	aAdd(aRegs, {cPerg, "02", "ate Data Entrega? "     		,"" ,"" ,"mv_ch2", "D"  , 8,						0,							0, "G", ""	, "mv_par02", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""})
	aAdd(aRegs, {cPerg, "03", "Produto de ? "      			,"" ,"" ,"mv_ch3", "C"  , TamSx3("B1_COD")[1],		TamSx3("B1_COD")[2],		0, "G", ""	, "mv_par03", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "SB1"})
	aAdd(aRegs, {cPerg, "04", "Produto ate ? "     			,"" ,"" ,"mv_ch4", "C"  , TamSx3("B1_COD")[1],		TamSx3("B1_COD")[2],		0, "G", ""	, "mv_par04", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "SB1"})
	aAdd(aRegs, {cPerg, "05", "Cliente de ? "     			,"" ,"" ,"mv_ch5", "C"  , TamSx3("A1_COD")[1],		TamSx3("A1_COD")[2],		0, "G", ""	, "mv_par05", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "SA1"})
	aAdd(aRegs, {cPerg, "06", "Cliente ate ? "     			,"" ,"" ,"mv_ch6", "C"  , TamSx3("A1_COD")[1],		TamSx3("A1_COD")[2],		0, "G", ""	, "mv_par06", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "SA1"})
	aAdd(aRegs, {cPerg, "07", "Status ? "     				,"" ,"" ,"mv_ch7", "C"  , 1,						0,							0, "C", ""	, "mv_par07", "Em Aberto", "Em Aberto", "Em Aberto", "", "", "Fechado", "Fechado", "Fechado", "", "", "Todos", "Todos", "Todos", "", "", "", "", "", "", "", "", "", "", "", "SA1"})
	
	
	For i:=1 to Len(aRegs)
		If !dbSeek(cPerg+aRegs[i,2])
			RecLock("SX1",.T.)
			For j:=1 to FCount()                                                                    			
				If j <= Len(aRegs[i])
					FieldPut(j,aRegs[i,j])
				Endif
			Next
			MsUnlock()
		Endif
	Next
	
	dbSelectArea(_sAlias)  
Return .T.