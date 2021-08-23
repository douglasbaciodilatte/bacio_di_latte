#include "protheus.ch"
#include "ap5mail.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณENVIAEMAILบAutor  ณAlexandre Goncalves บ Data ณ 16/12/2010  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina generica para enviar email autenticado               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function EnviaEmail(cAssunto,cMsg,cEmail,cAnexo)

Local cSrv  	:= GetMv("MV_RELSERV") 				// Servidor Smtp
Local cConta	:= AllTrim(GetMv("MV_RELACNT"))     // conta
Local cPass 	:= GetMv("MV_RELPSW")  				// Senha
Local lAuth 	:= GetMv("MV_RELAUTH") 				// Requer autenticacao?
Local lResult	:= .T.
Local lOK 		:= .T.
Local cFrom    := Alltrim(cConta)+"@bdil.com.br"   // Para conectar e autenticar ้ necessแrio apenas login, mas campo from ้ obrigat๓rio e-mail completo. 


Default cAnexo := ""

CONNECT SMTP SERVER cSrv ACCOUNT cConta PASSWORD cPass RESULT lResult

If lAuth
	
    lOk := MailAuth(cConta,cPass)
	
    SEND MAIL FROM cFrom TO cEmail SUBJECT cAssunto BODY cMsg ATTACHMENT cAnexo RESULT lResult

EndIf

DISCONNECT SMTP SERVER

Return(lOK)
