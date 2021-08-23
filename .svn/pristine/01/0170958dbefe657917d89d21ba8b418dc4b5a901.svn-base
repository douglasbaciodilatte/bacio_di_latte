/*/{Protheus.doc} WRUPDSB1
	Rotina que busca uma planilha em CSV e realiza o ajuste da tabela SB1 conforme desejado, sempre seguindo os campos informados na planilha

@author Rodrigo Bighetti
@since 03/05/2019
@version 1.1
@return Nil
/*/

#Include 'Protheus.ch'
#Include "topconn.ch"

#DEFINE OPEN_FILE_ERROR -1

User Function WRUPDSB1()
	Local cFile := ""
	Local aCampos := {}
	Local aDados 	:= {}
	Private nOpc 	:= 4
	
	Private lResp	:= .f.
	
	if fSelArquivo(@cFile)
		//|Faz a leitura do arquivo importado
		lResp := MsgYesNo("Deseja considerar a estrutura para atualizar as informações ?","Considera Estrutura ?")
		Processa({|| fCarga(cFile,@aCampos,@aDados)},	"Aguarde, carregando...")
		Processa({|| fGravaSB1(aCampos,aDados)}, 		"Gravando informações na SB1...")
	endIf

Return

//|----------------------------------------------------------------------|
//|Funcao que faz a leitura do arquivo importado e atualiza a tabela SB1 |
//|----------------------------------------------------------------------|
Static function fCarga(cFile,aCampos,aDados)
	Local xBuffer := ""
	Local nCol		:= 1
	Local cAux 	:= ""	
	Local nLin		:= 0
	
	Local i,x := 0
	
	//|Funcao para fazer a abertura do arquivo para leitura
	if FT_FUSE(cFile) != OPEN_FILE_ERROR
		ProcRegua(FT_FLASTREC())
		
		While !FT_FEOF()
			incProc()
			nLin ++
			
			//|Tratamento para a primeira linha para pegar os campos que sofrerão atualização
			if nLin == 1
				xBuffer	:= FT_FREADLN()+';'
				
				for i:=1 to len(alltrim(xBuffer))
					If	Substr(xBuffer,i,1) <> ";"
						cAux	:= cAux + Substr(xBuffer,i,1)						
					else
						
						aAdd(aCampos,	{cAux,nCol})	
						cAux := ""
						nCol++							
					endif										
				next i
			//|Se não for a primeira linha			
			else	
				xBuffer	:= FT_FREADLN()+';'
	 			nCol := 1
				cAux := ""
				
				_aAux := {}
				for i:=1 to len(alltrim(xBuffer))
					If	Substr(xBuffer,i,1) <> ";"
						cAux	:= cAux + Substr(xBuffer,i,1)						
					else	
						for x:=1 to len(aCampos)
							if aCampos[x][02] == nCol
								aAdd(_aAux, cAux) 
							endIf						
						next x																										
							
						cAux := ""
						nCol++							
					endif										
				next i
				
				aAdd(aDados,	_aAux)
				if lResp
					fBuscaSG1(@aDados, _aAux)
				endIf
			endIf			
				
			FT_FSKIP()
		endDo		
	endif
	
Return

//|-------------------------------------------------------------------------------|
//|Função que busca os produtos "PI" da estrutura para alimentar o Batch Quantity |
//|-------------------------------------------------------------------------------|
Static function fBuscaSG1(aDados, _aAux)
	
	if select("ESTRUT") <> 0
		ESTRUT->(dbCloseArea())
	endIf
	
	U_fEstrutura(_aAux[1])
	
	ESTRUT->(dbGoTop())
	while ESTRUT->(!Eof())
		if RetField("SB1",1,xFilial("SB1")+ESTRUT->COMP,"B1_TIPO") == "PI"
			aTemp := {}
			aAdd(aTemp,	ESTRUT->COMP)
			aAdd(aTemp, 	_aAux[2])
			
			aAdd(aDados, aTemp)
		endif
	
		ESTRUT->(dbSkip())
	endDo
	
Return

//|--------------------------------------------------------|
//|Função que faz a gravação das informações na tabela SB1 |
//|--------------------------------------------------------|
Static function fGravaSB1(aCampos,aDados)
	Local i,x := 0
	Local aMata010 := {}
	Local xValor := Nil

	ProcRegua(len(aDados))
	
	dbSelectArea("SX3")	
	
	dbSelectArea("SB1")
	SB1->(dbSetOrder(1))
	
	for i:=1 to len(aDados)
		incProc()
		aMata010 := {}	
		
		Begin Transaction	
			for x:=1 to len(aCampos)
					
				SX3->(dbSetOrder(2))	
				if SX3->(dbSeek(aCampos[x][01]))			
					//|Faz a conversão dos dados
					do Case
						case SX3->X3_TIPO == "N"
							xValor := val(aDados[i][aCampos[x][02]])
							
						case SX3->X3_TIPO $ "C|M"
							xValor := aDados[i][aCampos[x][02]]
							
						case SX3->X3_TIPO == "D"
							xValor := CtoD(aDados[i][aCampos[x][02]])		
					endCase
				
					aTemp := {}
					aAdd(aTemp,	aCampos[x][01])
					aAdd(aTemp, 	xValor)	
					aAdd(aTemp,	NIL)
					
					aAdd(aMata010, aTemp)	
				else
					MsgInfo("O produto "+Alltrim(aDados[i][02])+" não foi atualizado !!","PRODUTO NAO ENCONTRADO NO SX3")
				endIf
			next x
			
			if SB1->(dbSeek(xFilial("SB1")+Alltrim(aMata010[01][02]))		)
				//|Realiza a gravação das informações na tabela SB1
				lMsErroAuto := .F.
				MSExecAuto({|x,y| Mata010(x,y)},aMata010,4) //Alteracao					
				if lMsErroAuto
					MostraErro()
					DisarmTransactio()
					
					MsgStop("Verificar cadastro do produto "+Alltrim(aMata010[01][02])+" !","INCONSISTENCIAS")
				endIf
			else
				MsgStop("Produto não encontrado "+Alltrim(aMata010[01][02])+" !!")
			endIf
		End Transaction		
	next i

Return

//|------------------|
//|Seleciona Arquivo |
//|------------------|
Static Function fSelArquivo(cFile)

	cFile := cGetFile("Arquivo CSV (*.csv)|*.csv","Selecione o diretório a ser carregado o arquivo...",1,"C:\",.F.,GETF_LOCALHARD+GETF_NETWORKDRIVE,.F.)
	
	if Empty(cFile)
		Return .F.	
	endIf

Return .T.

