#include "TOTVS.CH"

/*/{Protheus.doc} MailSend
// Classe responsável pelo envio de e-mail utilizando as novas
// classes de e-mail da TOTVS
@author    Renan Paiva
@since     01/07/2018
@version   ${version}
@see 
	TMailMng - http://tdn.totvs.com/display/tec/Classe+TMailMng
	TMailMessage - http://tdn.totvs.com/display/tec/Classe+TMailMessage
/*/
class MailSend 
	
	data serverSMTP
	data userSMTP
	data pwdSMTP
	data portSMTP
	data lSSL
	data lTLS
	data fromReceipt
	data toReceipt
	data ccReceipt
	data subject
	data message 
	data attachment
	
	method new() constructor 
	method send()
	
endclass

/*/{Protheus.doc} new
// Metodo construtor responsavel por iniciar as variaveis
// referentes ao servidor de SMTP
@author Renan Paiva
@since 01/07/2018
@version undefined
@param _pServerSMTP, caractere, URL ou IP do servidor de SMTP
@param _pUserSMTP, caractere, usuário para autenticação no servidor de SMTP 
@param _pPwdSMTP, caractere, senha para autenticação no servidor de SMTP
@param _pPortSMTP, numerico, porta do servidor de SMTP, se não informado será utilizado a porta default 587
@param _pSSL, boolean, utiliza SSL
@param _pTLS, boolean, utiliza TLS
@example
(examples)
@see (links_or_references)
/*/
method new(_pServerSMTP, _pUserSMTP, _pPwdSMTP, _pPortSMTP, _pSSL, _pTLS) class MailSend

local server := _pServerSMTP
default ::portSMTP := 587

if _pServerSMTP != nil
	::serverSMTP := _pServerSMTP
	::userSMTP	 := _pUserSMTP
	::pwdSMTP	 := _pPwdSMTP
	::portSMTP	 := _pPortSMTP
	::lSSL		 := _pSSL
	::lTLS		 := _pTLS
else
	::serverSMTP := server	:= superGetMv("MV_RELSERV", .F., "")
	::userSMTP	 := superGetMv("MV_RELACNT", .F., "")
	::pwdSMTP	 := superGetMv("MV_RELAPSW", .F., "")
	::portSMTP	 := iif(at(":", server) > 0, val(subs(server,at(":", server) + 1)), self::portSMTP)
	::lSSL		 := ::portSMTP == 443
	::lTLS		 := ::portSMTP == 587
	//remove a porta da url
	if at(":", ::serverSMTP) > 0
		::serverSMTP := left(::serverSMTP, at(":", ::serverSMTP) -1 )
	endif
endif

return 

/*/{Protheus.doc} send
// Metodo responsável pelo envio de e-mails
@author Renan Paiva
@since 01/07/2018
@version undefined
@param _pFrom, caractere, remetente do e-mail
@param _pTo, caractere, destinatário(s) do email
@param _pCC, caractere, destinatário(s) em cópia do email
@param _pSubject,caractere , assunto do email
@param _pMessage, caractere, mensagem do email em formato html
@param _pAttach, caractere ou array, Anexo = caminho do arquivo ou array contendo os caminhos dos arquivos
/*/
method send(_pFrom, _pTo, _pCC, _pSubject, _pMessage, _pAttach) class MailSend

local oMessage := TMailMessage():New()
local oServer := TMailManager():New()
local aFullFileName := ""
local i
local connectStat := 0

default ::ccReceipt := ""

oServer:SetUseTLS(::lTLS)
oServer:SetUseSSL(::lSSL)
oServer:Init("", ::serverSMTP, ::userSMTP, ::pwdSMTP, NIL, ::portSMTP)

//seta as propriedades da classe MailSend (_Self)
::fromReceipt := iif(_pFrom != nil, _pFrom, iif(::fromReceipt == "" .or. ::fromReceipt == nil, ::userSMTP, ::fromReceipt))
::toReceipt := iif(_pTo != nil, _pTo, ::toReceipt)
::ccReceipt := iif(_pCC != nil .and. _pCC != "", _pCC, ::ccReceipt)
::subject := iif(_pSubject != nil, _pSubject, ::subject)
::message := iif(_pMessage != nil, _pMessage, ::message)
::attachment := iif(!empty(_pAttach), _pAttach, ::attachment)

//seta as propriedades da classe TMailMng
/*
oServer:cUser := ::userSMTP
oServer:cPass := ::pwdSMTP
oServer:cSMTPAddr := ::serverSMTP
oServer:nSMTPPort := ::portSMTP
*/
//seta as propriedades da class TMailMessage
oMessage:Clear()
oMessage:cFrom := ::fromReceipt
oMessage:cTo := ::toReceipt
oMessage:cCc := ::ccReceipt
oMessage:cDate := cValToChar( Date() )
oMessage:cSubject := ::subject
oMessage:cBody := ::message
oMessage:MsgBodyType( "text/html" )

//adiciona os anexos
if type("::attachment") == "A"
	for i := 1  to len(::attachment)
		if oMessage:AttachFile(::attachment[i]) > 0
			// Quebra caminho completo do arquivo para pegar somente o nome do arquivo
			aFullFileName := StrTokArr2(::attachment[i], "\")
			oMessage:AddAtthTag('Content-Disposition: attachment; filename=' + aFullFileName[len(aFullFileName)])
		else
			return .f.
		endif
	next
elseif type("::attachment") == "C"
	if oMessage:AttachFile(::attachment) > 0
		// Quebra caminho completo do arquivo para pegar somente o nome do arquivo
		aFullFileName := StrTokArr2(::attachment, "\")
		oMessage:AddAtthTag('Content-Disposition: attachment; filename=' + aFullFileName[len(aFullFileName)])
	else
		return .f.
	endif
endif

//seta um tempo de time out com servidor de 1min
If oServer:SetSmtpTimeOut( 60 ) != 0
  Conout( "Falha ao setar o time out" )
  alert( "Falha ao setar o time out" )
  Return .F.
EndIf
   
//realiza a conexão SMTP
If oServer:SmtpConnect() != 0
  Conout( "Falha ao conectar" )
  alert( "Falha ao conectar" )
  Return .F.
EndIf

// Autentica no servidor de SMTP
connectStat := oServer:SMTPAuth(::userSMTP, ::pwdSMTP)
if connectStat != 0
  conout("Error on SMTP Auth: " + oServer:GetErrorString( connectStat ) )
  alert("Error on SMTP Auth: " + oServer:GetErrorString( connectStat ))
  return .f.
endif

// Envia a mensagem
//connectStat:= oMessage:Send2( oServer )
connectStat:= oMessage:Send( oServer )
if connectStat != 0
  conout( "Error on Send: " + oServer:GetErrorString( connectStat ) )
  alert( "Error on Send: " + oServer:GetErrorString( connectStat ) )
endif
   
// Disconecta do servidor de SMTP 
connectStat := oServer:SMTPDisconnect()
if connectStat != 0
  conout( "Error on SMTPDisconnect: " + oServer:GetErrorString( connectStat ) )  
  alert( "Error on SMTPDisconnect: " + oServer:GetErrorString( connectStat ) )
endIf
  
return