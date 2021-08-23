#Include "Protheus.ch"
#Include "TopConn.ch"    
#include "apwebsrv.ch"
#include "apwebex.ch"
#include "ap5mail.ch"  
 

 
User Function A010TOK()
    Local aArea     := GetArea()
    Local cEmAlter  := SuperGetMV("MV_XALTSB1", .F., "andre.sarraipa@agilitysolutions.com.br")
    Local cMsg      := ""
    Local cProduto  := SB1->B1_COD
	Local lExecuta  := .T.// Validações do usuário para inclusão ou alteração do produto    
	local lBdl      := .F. //Valida se teve alguma altera��o nos campos de controle
     
	 
	 
	If ALTERA 
           
        
        //cMsg += "<p><b>Dados alterados:</b></p>"+cMsg
        
        
		cMsg += "Produto: "+cProduto+" - Descri&ccedil;&atilde;o: "+Alltrim(SB1->B1_DESC)+"<br>"
        cMsg += "Data: "+dToC(Date())+"<br>"
        cMsg += "Hora: "+Time()+"<br>"
        cMsg += "Usu&aacute;rio: "+RetCodUsr()+" - "+cUserName+" - Nome: "+Alltrim(UsrFullName(__CUSERID))+"<br><br>"
		
		cMsg +="<b>Dados Alterados:</b> <br><br>"
		
		If M->B1_DESC <> SB1->B1_DESC 
		 cMsg +="<b>Descri&ccedil;&atilde;o</b><br>"
		 cMsg += "Descri&ccedil;&atilde;o Antiga: "+SB1->B1_DESC+"<br>"
		 cMsg += "Descri&ccedil;&atilde;o Nova: "+M->B1_DESC+"<br><br>"     
		 lBdl      := .T.				
		Endif 
		
		If M->B1_XDESCR <> SB1->B1_XDESCR 
		 cMsg +="<b>Descri&ccedil;&atilde;o para Pedido</b><br>"
		 cMsg += "Descri&ccedil;&atilde;o Antiga: "+SB1->B1_XDESCR+"<br>"
		 cMsg += "Descri&ccedil;&atilde;o Nova:   "+M->B1_XDESCR+"<br><br>"
         lBdl      := .T.		
		Endif    
		
		If M->B1_GRUPO <> SB1->B1_GRUPO 
         cMsg +="<b>Grupo</b><br>"
		 cMsg += "Grupo Antigo: "+SB1->B1_GRUPO+"<br>"
		 cMsg += "Grupo Novo: "+M->B1_GRUPO+"<br><br>"
		 lBdl      := .T.		
		Endif      
		
		If M->B1_GRTRIB <> SB1->B1_GRTRIB 
         cMsg +="<b>Grupo Tributario</b><br>"
		 cMsg += "Grupo Antigo: "+SB1->B1_GRTRIB+"<br>"
		 cMsg += "Grupo Novo: "+M->B1_GRTRIB+"<br><br>"
		 lBdl      := .T.		
		Endif   
		
		If M->B1_UM <> SB1->B1_UM 
         cMsg +="<b>Unidade de Medida</b><br>"
		 cMsg += "Unidade de Medida Antiga: "+SB1->B1_UM+"<br>"
		 cMsg += "Unidade de Medida Nova: "+M->B1_UM+"<br><br>"
		 lBdl      := .T.		
		Endif    
		
		If M->B1_SEGUM <> SB1->B1_SEGUM 
         cMsg +="<b>Segunda Unidade de Medida</b><br>"
		 cMsg += "Segunda unidade de Medida Antiga: "+SB1->B1_SEGUM+"<br>"
		 cMsg += "Segunda unidade de Medida Nova: "+M->B1_SEGUM+"<br><br>"
		 lBdl      := .T.		
		Endif 
		
		If M->B1_CONV <> SB1->B1_CONV 
         cMsg +="<b>Fator de Convers&atilde;o</b><br>"
		 cMsg += "Fator de Convers&atilde;o Antigo: "+cValToChar(SB1->B1_CONV)+"<br>"     
		 
		 cMsg += "Fator de Convers&atilde;o Novo: "+cValToChar(M->B1_CONV)+"<br><br>"
		 lBdl      := .T.		
		Endif
		
		If M->B1_CONTA <> SB1->B1_CONTA 
         cMsg +="<b>Conta Contabil</b><br>"
		 cMsg += "Conta Antiga: "+SB1->B1_CONTA+"Desc: "+Alltrim(Posicione('CT1',1,xFilial('CT1')+SB1->B1_CONTA,'CT1_DESC01'))+"<br>"
		 cMsg += "Conta Nova:   "+M->B1_CONTA+"Desc:   "+Alltrim(Posicione('CT1',1,xFilial('CT1')+M->B1_CONTA,'CT1_DESC01'))+"<br><br>"
		 lBdl      := .T.		
		Endif   

		If M->B1_XCTATV <> SB1->B1_XCTATV 
         cMsg +="<b>Conta Contabil ativo</b><br>"
		 cMsg += "Conta Antiga: "+SB1->B1_XCTATV+"Desc: "+Alltrim(Posicione('CT1',1,xFilial('CT1')+SB1->B1_XCTATV,'CT1_DESC01'))+"<br>"
		 cMsg += "Conta Nova:   "+M->B1_XCTATV+"Desc:   "+Alltrim(Posicione('CT1',1,xFilial('CT1')+M->B1_XCTATV,'CT1_DESC01'))+"<br><br>"
		 lBdl      := .T.		
		Endif   
		
		
		If M->B1_POSIPI <> SB1->B1_POSIPI 
         cMsg +="<b>NCM</b><br>"
		 cMsg += "NCM Antigo: "+SB1->B1_POSIPI+"<br>"
		 cMsg += "NCM Novo:   "+M->B1_POSIPI+"<br><br>"
		 lBdl      := .T.		
		Endif     
		
		If M->B1_CUSTD <> SB1->B1_CUSTD 
         cMsg +="<b>Custo Standard</b><br>"
		 cMsg += "Custo Standard Antigo: "+cValToChar(SB1->B1_CUSTD)+"<br>"
		 cMsg += "Custo Standard Novo:   "+cValToChar(M->B1_CUSTD)+"<br><br>"
		 lBdl      := .T.		
		Endif 
		
		If M->B1_MSBLQL <> SB1->B1_MSBLQL 
         cMsg +="<b>Status do Produto</b><br>"
         	if SB1->B1_MSBLQL  = '1'
				 cMsg += "Status Antigo: 1 - Bloqueado <br>"  
				 cMsg += "Status Novo:   2 - Desbloqueado <br>"	   
		    else
		  		 cMsg += "Status Antigo: 2 - Desbloqueado <br>"	
		  		 cMsg += "Status Novo:   1 - Bloqueado <br>"  
			endif 		 
		 lBdl      := .T.		
		Endif  
		 
		if !lBdl
		   cMsg +="<b>Nenhum campo monitorado foi alterado:</b><br>"
				 cMsg += "-	Descri&ccedil;&atilde;o <br>"
				 cMsg += "-	Descri&ccedil;&atilde;o para pedido <br>"
				 cMsg += "-	Grupo <br>"
				 cMsg += "-	Grupo Tribut&aacute;rio <br>"  
				 cMsg += "-	Unidade de Medida <br>"
				 cMsg += "-	Segunda Unidade de Medida <br>"
				 cMsg += "-	Fator de Convers&atilde;o <br>"
				 cMsg += "-	Conta cont&aacute;bil <br>"
				 cMsg += "-	Conta cont&aacute;bil ativo <br>"
				 cMsg += "-	NCM <br>"
				 cMsg += "-	Custo Standard <br>"
				 cMsg += "-	Status do produto <br>"
		   
		endif
		
		cMsg := "<h1>Informativo de altera&ccedil;&atilde;o de produto:</h1><br><br>"+cMsg    		
        EnviarSB1(cEmAlter, "Alteracao em cadastro de produto.", cMsg)  
	EndIf 
	
//Se for inclusão 	
	
	if Inclui
		cMsg += "Produto: "+cProduto+" - Descri&ccedil;&atilde;o: "+Alltrim(M->B1_DESC)+"<br>"
        cMsg += "Data: "+dToC(Date())+"<br>"
        cMsg += "Hora: "+Time()+"<br>"
        cMsg += "Usu&aacute;rio: "+RetCodUsr()+" - "+cUserName+" - Nome: "+Alltrim(UsrFullName(__CUSERID))+"<br><br>"
		
		cMsg +="<b>Dados da Inclus&atilde;o:</b> <br><br>"
		
		 cMsg +="<b>Descri&ccedil;&atilde;o</b><br>"
		 cMsg += "Descri&ccedil;&atilde;o: "+M->B1_DESC+"<br><br>"     
				 

		 cMsg +="<b>Descri&ccedil;&atilde;o para Pedido</b><br>"
		 cMsg += "Descri&ccedil;&atilde;o:   "+M->B1_XDESCR+"<br><br>"
      		

         cMsg +="<b>Grupo</b><br>"
		 cMsg += "Grupo: "+M->B1_GRUPO+"<br><br>"

         cMsg +="<b>Grupo Tributario</b><br>"
		 cMsg += "Grupo Tributario: "+M->B1_GRTRIB+"<br><br>"

	
         cMsg +="<b>Unidade de Medida</b><br>"
		 cMsg += "Unidade de Medida: "+M->B1_UM+"<br><br>"

         cMsg +="<b>Segunda Unidade de Medida</b><br>"
		 cMsg += "Segunda unidade de Medida: "+M->B1_SEGUM+"<br><br>"


         cMsg +="<b>Fator de Convers&atilde;o</b><br>"
		 cMsg += "Fator de Convers&atilde;o: "+cValToChar(M->B1_CONV)+"<br><br>"

		

         cMsg +="<b>Conta Contabil</b><br>"
		 cMsg += "Conta:   "+M->B1_CONTA+"Desc:   "+Alltrim(Posicione('CT1',1,xFilial('CT1')+M->B1_CONTA,'CT1_DESC01'))+"<br><br>"

	
         cMsg +="<b>Conta Contabil ativo</b><br>"
		 cMsg += "Conta:   "+M->B1_XCTATV+"Desc:   "+Alltrim(Posicione('CT1',1,xFilial('CT1')+M->B1_XCTATV,'CT1_DESC01'))+"<br><br>"

		

         cMsg +="<b>NCM</b><br>"
		 cMsg += "NCM:   "+M->B1_POSIPI+"<br><br>"
  
		

         cMsg +="<b>Custo Standard</b><br>"
		 cMsg += "Custo Standard :   "+cValToChar(M->B1_CUSTD)+"<br><br>"

         cMsg +="<b>Status do Produto</b><br>"
         	if M->B1_MSBLQL  = '1'
				 cMsg += "Status: 1 - Bloqueado <br>"  
		    else
		  		 cMsg += "Status: 2 - Desbloqueado <br>"	
			endif 		


		cMsg := "<h1>Informativo de inclus&atilde;o de novo produto:</h1><br><br>"+cMsg    		
        EnviarSB1(cEmAlter, "Inclusao de novo produto.", cMsg) 
	
	Endif
	 
	RestArea(aArea)
Return (lExecuta)



static function EnviarSB1(cDestino,cAssunto,cCorpo)

local cServer         := getMV('MV_RELSERV') //endereÃ§o SMTP
local lAutentic       := getMV('MV_RELAUTH') //utilize em caso de necessidade de autenticaÃ§Ã£o
local cAccount        := getmv('MV_RELACNT') //conta
local cPassword       := getMV('MV_RELAPSW') //senha
local cMailDe  		  := getmv('MV_RELACNT')
LOcal cQL             := CHR(13) + CHR(10)
local cRemoteip       := Getclientip()
local cRemoteComputer := GetComputerName()
local lConectou       := .f.                     



// conecta com o servidor de e-mail
CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword Result lConectou
mailAuth(cAccount, cPassword)
If lConectou 
	
   //	SEND MAIL FROM cMailDe TO cDestino SUBJECT cAssunto BODY cCorpo FORMAT TEXT RESULT lEnviado     
   SEND MAIL FROM "Bacio di Latte" TO cDestino SUBJECT cAssunto BODY cCorpo FORMAT TEXT RESULT lEnviado

else
	alert("NÃ£o foi possivel executar sua solicitaÃ§Ã£o, pois nÃ£o houve resposta do servidor de e-mail."+cQL+cQL+"Informe ao Administrador do Sistema!")
	return .f.
Endif

DISCONNECT SMTP SERVER Result lDisConectou     

Return