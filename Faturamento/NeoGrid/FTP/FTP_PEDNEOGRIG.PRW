
#Include "Totvs.ch"
#include 'protheus.ch'
#include "vkey.ch"
#INCLUDE "SPEDNFE.ch"
#INCLUDE "APWIZARD.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
/*/
+-------------------------------------------------------------------------+
|+----------+----------+-------+-----------------------+------+----------+|
||Programa  |fUpFile ()| Autor |Reinaldo Rabelo da Silva Data |02.03.2021||
|+----------+----------+-------+-----------------------+------+----------+|
||Descri‡…o |Rotina envia os arquivos xml do servidor protheus para      ||
||          | o FTP do Google onde será consumido pelo NeoGrig           ||
|+----------+------------------------------------------------------------+|
||Retorno   |Nenhum                                                      ||
|+----------+------------------------------------------------------------+|
||Parametros|Nenhum                                                      ||
|+----------+---------------+--------------------------------------------+|
||   DATA   | Programador   |Manutencao efetuada                         ||
|+----------+---------------+--------------------------------------------+|
||          |               |                                            ||
|+----------+---------------+--------------------------------------------+|
+-------------------------------------------------------------------------+
/*/

Static cServer    := "34.95.129.163" //GetMV("BL_FTPSERV",.T.,"34.95.129.163")  //"127.0.0.1" //
Static nPort      := 21 //GetMV("BL_FTPPORT",.T.,21             )
Static cUser      := "neogrid.bacio" ///GetMV("BL_FTPUSER",.T.,"neogrid.bacio") //"teste" // //
Static cPass      := "Gel@102315" ///alltrim(GetMV("BL_FTPPASS",.T.,"Gel@102315"   ))    //"123456" //
Static cFTPPath   := "/in/" ///GetMV("BL_FTPPED",.T.,"/in/"        )
Static cFTPIMP    := "/importados/" ///GetMV("BL_FTPPED",.T.,"/in/"        )

Static nTimeOut   := 60
Static lClose     := .F.
Static bPasv      := .F.
Static bUseIP     := .T.
Static bAnonymous := .F.

User Function FTPPED(lVisual)

  Local aLList   := {} 
  Local aLFiles  := {}
  Local cLPath   := "\"
  Local aRList   := {}
  Local aRFiles  := {}
  Local cRPath   := "FTP Client (Não Conectado)"
  Local oFtp
  Local aGetsL   := {} 
  Local aGetsR   := {}
  Local aFTPInfo := {}
  
  Default lVisual := .T.

  aadd(aFTPInfo, cServer   )   // 1 Endereço FTP (IP ou URL)         Caracter
  aadd(aFTPInfo, nPort     )   // 2 Porta de conexão FTP Padrão 21   Numerico
  aadd(aFTPInfo, nTimeOut  )   // 3 TimeOut de conexão do FTP (sec)  Numerico
  aadd(aFTPInfo, bPasv     )   // 4 Firewall Mode (passive) .T. ou (ativo) .F.
  aadd(aFTPInfo, bUseIP    )   // 5 Usa IP de Conexão .T.
  aadd(aFTPInfo, bAnonymous)   // 6 Loga com usuario Anonymous se o FTP estiver configurado
  aadd(aFTPInfo, cUser     )   // 7 Usuario de Login do FTP
  aadd(aFTPInfo, cPass     )   // 8 Senha do FTP

  // Cria o objeto Client de FTP
  oFtp := tFtpClient():New()

  //Cria uma Lista dos Arquivos do Lado do Protheus
  aLList := GetLFiles(cLPath,@aLFiles)

  //Carrega as pasta e arquivos do Lado do Protheus
  doLChange(aGetsL,@aLList,@aLFiles) 
  EnterLeft(@aLList,@aLFiles,@cLPath) 
  LocalPath(@aLList,@aLFiles,@cLPath) 

  //Faz a Conexão com o servidor FTP
  FTPConn(oFtp,@aFTPInfo,@aRList,@aRFiles,@cRPath)

  //Cria a Lista dos Arquivos que serão lidos do FTP
  doRChange(aGetsR,@aRList,@aRFiles) 
  EnterRight(oFtp,aFtpInfo,@aRList,@aRFiles,@cRPath)

  // Copia os Arquivo do FTP para o Protheus
  CallKey(aLFiles,aLList,aRFiles,aRList,cLPath,cRPath,oFtp,lVisual)

  // Fecha a conexao com o FTP caso esteja aberta
  oFtp:Close()

Return


/* 
----------------------------------------------------------------------
Funçao usada para encapsular a busca dos arquivos locais
Retorna array para a lista de tela - visualização
E alimenta por referçncia uma lista paralela com todos
os detalhes dos arquivos
---------------------------------------------------------------------- 
*/

STATIC Function GetLFiles(cPath,aLFiles)
  Local aRet := {} 
  Local aTmp := {}
  Local nI 
  Local nT 
  Local cFName
  aSize(aLFiles,0)
  aTmp := Directory(cPath+"*.*","AD",NIL,.F.,1)
  nT := len(aTmp)
  For nI := 1 to nT

    cFName := alltrim(aTmp[nI][1])
  
    IF cFName == '.'
      // Diretorio atual, pula
      LOOP
    ElseIf cFName == '..' 
      // Diretorio anterior, sç se eu nço estiver no RootPAth "\"
      LOOP
    Else
      aadd(aRet , cFName)
      aadd(aLFiles , aclone(aTmp[nI]) )
    Endif

  Next nI

return aRet

/*
----------------------------------------------------------------------
Função disparada na troca de posição da lista de arquivos
do lado esquerdo -- arquivos locais
Atualiza as informaçães do arquivo selecionado no painel inferior
---------------------------------------------------------------------- 
*/

STATIC Function doLChange(aGetsL,aLList,aLFiles)
  Local cFname 
  Local cFDate
  local nFSize 
  local cFAttr
  Local nOp := 4 

  If nOp > 0 .and. nOp <= Len(aLList)
    cFname := aLFiles[nOp][1]
    nFSize := aLFiles[nOp][2]
    cFDate := dtoc(aLFiles[nOp][3])+' ' +aLFiles[nOp][4]
    cFattr := aLFiles[nOp][5]
  Endif

return


/* 
----------------------------------------------------------------------
Função disparada na troca de posição da lista de arquivos FTP
do lado direito.
Atualiza as informaçães do arquivo selecionado no painel inferior
---------------------------------------------------------------------- 
*/

STATIC Function doRChange(aGetsR,aRList,aRFiles)
  Local cFname 
  Local cFDate
  Local nFSize 
  Local cFAttr
  Local nOp := 1

  If nOp > 0 .and. nOp <= Len(arList)
    
    cFname := aRFiles[nOp][1]
    nFSize := aRFiles[nOp][2]
    cFDate := dtoc(aRFiles[nOp][3])+' ' +aRFiles[nOp][4]
    cFattr := aRFiles[nOp][5]
    
  Endif

return

/* 
----------------------------------------------------------------------
Permite trocar a pasta atual navegando diretamente
na estrutura de pastas do Servidor a partir do RootPath
----------------------------------------------------------------------
*/

STATIC Function LocalPath(aLList,aLFiles,cLPath)
  Local cRet
  Local nRet := 0
 
  cRet := "NeoGridClient\documents\in\"

  IF !ExistDir( "\NeoGridClient" ) 
    nRet := MakeDir("\NeoGridClient\" )
  ENDIF
 
  IF !ExistDir( "\NeoGridClient\documents" ) 
      nRet := MakeDir("\NeoGridClient\documents" )
  ENDIF
  
  IF !ExistDir( "\NeoGridClient\documents\in" ) 
      nRet := MakeDir("\NeoGridClient\documents\in" )
  ENDIF
   IF !ExistDir( "\NeoGridClient\documents\in\Importados" ) 
      nRet := MakeDir("\NeoGridClient\documents\in\Importados" )
  ENDIF
     IF !ExistDir( "\NeoGridClient\documents\in\erro" ) 
      nRet := MakeDir("\NeoGridClient\documents\in\erro" )
  ENDIF
  If !empty(cRet) .and. nRet == 0
    // Troca o path e atualiza a lista de arquivos na tela
         
    cLPath := cRet
    aLList := GetLFiles(cLPath,aLFiles)
  else
    conout("Erro ao verificar a pasta " + cRet)  
  Endif

Return

/* 
----------------------------------------------------------------------
Funcao disparada em caso de [ENTER] ou Duplo Click em um arquivo
na lista de arquivos locais -- lado esquerdo. Permite a navegação
entre os diretorios.
---------------------------------------------------------------------- 
*/

STATIC Function EnterLeft(aLList,aLFiles,cLPath)
  Local cFile
  Local aTmp
  Local nI
  Local nOp := 5

  If nOp > 0
    
    cFile := alltrim(aLList[nOp])
    
    If cFile == '..'
    
      // Tenta ir para o nivel anterior
      aTmp := StrTokarr(cLPath,'\')
      cLPath := ''
    
      For nI := 1 to len(aTmp)-1
        cLPath += ( aTmp[nI] + '\')
      Next
    
      if empty(cLPath)
        cLPath := '\'
      Endif
    
      aLList := GetLFiles(cLPath,aLFiles)
    
    Else
      // SE for um diretorio, entra nele
      aTmp := aLFiles[nOp]
      
      if 'D' $ aTmp[5]
        // Se for um diretorio , entra
        cLPath += ( cFile+'\' )
        aLList := GetLFiles(cLPath,aLFiles)
        
      Endif
    Endif
  Endif
Return


/* 
----------------------------------------------------------------------
Funcao disparada em caso de [ENTER] ou Duplo Click em um arquivo
na lista de arquivos de FTP - Lado direito -- Permite navegar
entre os diretorios.
---------------------------------------------------------------------- 
*/              
STATIC Function EnterRight(oFTP,aFtpInfo,aRList,aRFiles,cRPath)
  Local cFile
  Local nOp := 1
  Local cCurrDir

  If nOp > 0
    
    cFile := cFTPPath //"/out/"
    
    If cFile == '..'
      
      // Volta ao nivel anterior
      nStat := oFTP:CDUP()
      
      If nStat != 0
        
        conout("Falha ao mudar de Diretorio - Erro "+cValToChar(nStat) + oFtp:CERRORSTRING)
        
      Else
        
        cCurrDir := ''
        nStat := oFtp:GETCURDIR(@cCurrDir)
        
        cRPath := "ftp://"+aFtpInfo[1]+cCurrDir
      
        // Pega os arquivos do diretorio atual
        MsgRun("Obtendo lista de arquivos" + cRPath)
        aRFiles := oFtp:Directory("*",.T.) 
          
              
      Endif
      
    Else
      
      // SE for um diretorio, entra nele
      
      if .t.
        
        // Se for um diretorio , entra
        // Troca o diretorio atual
        nStat := oFTP:CHDIR(cFile)
        
        If nStat != 0
          conout("Falha ao mudar de Diretorio - Erro "+cValToChar(nStat) + oFtp:CERRORSTRING)
          
        Else
          cRPath += ( cFile+'/' )
          // Pega os arquivos do diretorio atual
          conout("Obtendo lista de arquivos" + cRPath)
          aRFiles := oFtp:Directory("*.txt",.T.) 
            
        Endif
        
      Endif
      
    Endif
    
  Endif
return


/*
---------------------------------------------------------------------
Diálogo de Conexço com FTP
Armazema parametros de conexao, e em caso de sucesso,
já alimenta a lista de arquivos do lado direito
---------------------------------------------------------------------- 
*/

STATIC Function FTPConn(oFtp,aFTPInfo,aRList,aRFiles,cRPath)

Local cFTPAddr 	 := padr(aFTPInfo[1],40)
Local nFtpPort 	 := aFTPInfo[2]
Local nTimeOut 	 := aFTPInfo[3]
Local bPasv    	 := aFTPInfo[4]
Local bUseIP   	 := aFTPInfo[5]
Local bAnonymous := aFTPInfo[6]
Local cUser    	 := padr(aFTPInfo[7],40)
Local cPass      := padr(aFTPInfo[8],40)
Local nStat

// Fecha qqer conexao existente anteriormente
	oFTP:Close()
	
	// Ajusta os parametros
	cFTPAddr := alltrim(cFTPAddr)
	cUser    := alltrim(cUser   )
	cPass    := alltrim(cPass   )
	
	// Guarda os parametros utilizados
	aFTPInfo[1] := cFTPAddr
	aFTPInfo[2] := nFtpPort
	aFTPInfo[3] := nTimeOut
	aFTPInfo[4] := bPasv
	aFTPInfo[5] := bUseIP
	aFTPInfo[6] := bAnonymous
	aFTPInfo[7] := cUser
	aFTPInfo[8] := cPass
	
	// Seta parametros na classe
	oFtp:BFIREWALLMODE     := bPasv
	oFtp:NCONNECTTIMEOUT   := nTimeOut
	oFtp:BUSESIPCONNECTION := bUseIP
	
	// Conecta no FTP
	If !bAnonymous
		Conout("FTP Connect:" + cFtpAddr)
     nStat := oFtp:FtpConnect(cFtpAddr,nFTPPort,cUser,cPass)
	Else
		Conout("FTP Connect" + cFtpAddr)
    nStat := oFtp:FtpConnect(cFtpAddr,nFTPPort,"anonymous","anonymous")
	Endif
	
	If nStat == 0
		
		cCurrDir := ''
		nStat := oFtp:GETCURDIR(@cCurrDir)
		
		If nStat <> 0
			
			cRPath := "ftp://"+cFtpAddr+"/"
			Conout("Falha ao recuperar executar GetCurDir() - Erro "+cValtoChar(nStat) + oFtp:CERRORSTRING)
			
		Else
			// Atualiza pasta atual do FTP
			cRPath := "ftp://"+cFtpAddr+cCurrDir
					
		Endif
		// Conectou com sucesso, recupera pasta atual e lista de arquivos
		conout("Obtendo lista de arquivos" ) //+cRPath,{|| aRFiles := oFtp:Directory("*",.T.) })
			
	Else
			
		conout("Falha de Conexço -- Erro "+cValToChar(nStat) + oFtp:CERRORSTRING)
		cRPath := "FTP Client (Nço Conectado)"

	Endif
	
Return

/* 
----------------------------------------------------------------------
Teclas de Atalho de funcionalidades do FTP
F5 = Copiar Arquivo ( Download ou Upload ) 
---------------------------------------------------------------------- 
*/

STATIC Function CallKey(aLFiles,aLList,aRFiles,aRList,cLPath,cRPath,oFtp,lVisual)

  Local cFile
  Local cSource
  Local cTarget
  Local cCurrDir
  Local lExist
  Local lRun

  Local nPos   := 1
  Local nStat  := 0
  Local lEnvia := .F.
  
  Default lVisual := .T.
  // Pega Handle do componente de interface que estava com o foco
  // quando a tecla de atalho foi pressionada

  If lEnvia 
    
    // Caso o foco esteja na lista de arquivos locais
    // E exista um arquivo posicionado ... 

    If nPos > 0 .and. Len(aLFiles) > 0
      
      for nPos := 1 to len(aLFiles)

        cFile := alltrim(aLFiles[nPos][1])
        cAttr := aLFiles[nPos][5]
     
        If cFile == '.' .or. cFile == '..'

          conout("Operação com pasta nço implementada. Selecione um arquivo.")
          return

        ElseIf 'D'$cAttr

          conout("Operação com pasta nço implementada. Selecione um arquivo.")
          return

        Endif
        
        If .t.
          // Copia de arquivo Local para o FTP
          cSource := cLPath+cFile
          cTarget := cRPath+cFile
          conout("Copiando o arquivo local ["+cSource+"] para o FTP ["+cTarget+"]" )
          if lVisual
            ProcRegua(nPos)
          endif
          nStat := oFTP:SENDFILE(cSource,cFile) 
          If nStat <> 0
            Conout("Falha no UPLOAD de Arquivo - Erro "+cValToChar(nStat) + oFtp:CERRORSTRING)
          Else
            
            conout("Upload realizado com sucesso.")
           /* If FERASE(cSource) == -1
              Conout("Erro ao tentar excluir o arquivo :"+cSource)
            else
              Conout("Arquivo excluido:"+cSource)
            endif*/

            cCurrDir := ''
            oFtp:GETCURDIR(@cCurrDir)
            // Pega os arquivos do diretorio atual
            conout("Obtendo lista de arquivos" + cRPath)
              
            aRFiles := oFtp:Directory("*.txt",.T.) 
            
            // Acrescenta um atalho para voltar para o nivel anterior
            // SE eu nao estiver no niver RAIZ ...
              
          Endif
          //Endif
        Else
          conout("Operação com Arquivo Local ainda nço implementada.")
        Endif
      next nPos
    Endif
    
  ElseIf !lEnvia
    
    // Copia arquivo do FTP para pasta Local
    // e exista algum arquivo posicionado
    for nPos := 1 to len(aRFiles)
      cFile := alltrim(aRFiles[nPos][1])
      cAttr := aRFiles[nPos][5]
      
      If cFile == '.' .or. cFile == '..'
      
        conout("Operação com pasta nço implementada. Selecione um arquivo.")
        return
      
      ElseIf 'D'$cAttr
      
        conout("Operação com pasta nço implementada. Selecione um arquivo.")
        return
      
      Endif
      // Ajusta o nome vindo do FTP 
      AdjustFTP(@cFile)
    
        // Copia de arquivo do FTP para a pasta local 
      cSource := cRPath+cFile
      cTarget := cLPath+cFile
      cNewSrc := cRPath+"importados\"+cFile
      lExist  := File(cLPath+cFile)
      lRun    := .F. 

      IF lExist
        If .F. 
          conout("O Arquivo local já existe. Deseja continuar o Download ? ")
          lRun := .T.
          conout("FTP Resume Download"+cFile)
          nStat := oFTP:RESUMERECEIVEFILE(cFile,cTarget)
        
        ElseIf .F. 
        
          conout("Apaga o arquivo local e reinicia o Download ?")
          lRun := .T.
          Ferase(cLPath+cFile)
           
          conout("FTP Download " +cFile)
          nStat := oFTP:RECEIVEFILE(cFile,cTarget) 
        
        Endif			
        
      Else
        
        If .t.
          conout("Baixando o arquivo do FTP ["+cSource+"] para a pasta local ["+cTarget+"] ?")
          lRun := .T.
          conout("FTP Download" + cFile)
          nStat := oFTP:RECEIVEFILE(cFile,cTarget) 
          if nStat == 0
            
            nStat :=  oFTP:ChDir("/in"+cFTPIMP)
            if nStat == 0
              Conout("Aterando Pasta")
            Else
              Conout("Não foi possivel alterar a pasta:" + oFtp:CERRORSTRING)
            Endif
            
            nStat := oFTP:SENDFILE(cTarget,cFile) 
            
            if nStat == 0
              Conout("Arquivo enviado")
            Else
              Conout("Não foi possivel enviar arquivo :" + oFtp:CERRORSTRING)
            Endif
            
            nStat :=  oFTP:CdUp()
            
            if nStat == 0
              Conout("Voltando a pasta inicial")
            Else
              Conout("Não foi possivel retornar a pasta:" + oFtp:CERRORSTRING)
            Endif
            
            nStat :=  oFTP:ChDir("/in/")
            
            nStat  := oFTP:DeleteFile(cFile)
            
            if nStat == 0
              Conout("Deletando Arquivo")
            Else
              Conout("Não foi possivel deletar o arquivo:" + oFtp:CERRORSTRING)
            Endif
            
          endif
        Endif
        
      Endif

      If lRun			
        If nStat <> 0
          conout("Falha no DOWNLOAD de Arquivo - Erro "+cValToChar(nStat) + oFtp:CERRORSTRING)
        Else
          conout("Download realizado com sucesso.")
          // Atualiza lista de arquivos 
          
        Endif
        
      Endif
      
    Next nPos
	
  Else
	
      Conout("Operação com Arquivo do FTP ainda nço implementada.")
	
  Endif
	
Return


/*
----------------------------------------------------------------------------------
Alguns FTPs podem criar link para o arquivo, e retornar o link nas informaçães
Esta informação deve ser ignorada, o que importa ç o nome do arquivo 
Normalmente o link vem no formato arquivo -> link 
----------------------------------------------------------------------------------
*/

STATIC Function AdjustFTP(cFile)
  Local nPos
  nPos := at("->",cFile)
  IF nPos > 0 
    cFile := alltrim(substr(cFile,1,nPos-1))
  Endif
return

//**********************************************************************************************************************************************
//**********************************************************************************************************************************************
//**********************************************************************************************************************************************
//**********************************************************************************************************************************************
//**********************************************************************************************************************************************
//**********************************************************************************************************************************************
//**********************************************************************************************************************************************
//**********************************************************************************************************************************************
//**********************************************************************************************************************************************
//**********************************************************************************************************************************************
//**********************************************************************************************************************************************
//**********************************************************************************************************************************************






