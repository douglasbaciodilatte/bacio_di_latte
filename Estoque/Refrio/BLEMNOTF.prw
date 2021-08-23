#INCLUDE "totvs.ch"
#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "ap5mail.ch"
#INCLUDE "TbiConn.ch"
#INCLUDE "TbiCode.ch"
#INCLUDE "TOPCONN.CH"
#INCLUDE "Print.ch"
#include "ap5mail.ch"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ EnvMail  บAutor  ณ Vanito Rocha   บ Data ณ  29/12/2020    บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Envia email com ate dois anexos                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Bacio                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function BLEMNOTF(_cEmailTo,_cEmailBcc,_cAssunto,_aMsg,_aAttach,_lMostraMsg)

Local _ni          := j:= 0
Local _lOk         := .F.
Local _lSendOk     := .F.
Local _lRet        := .T.
Local _cError      := ""
Local _cAttach1    := ""
Local _cAttach2    := ""
Local _cMsg        := ""                                                        			
Local _cArqLog     := ""
Local _cMailConta  := GETMV("MV_RELFROM")
Local _cMailServer := GETMV("MV_RELSERV")
Local _cMailLogin  := GETMV("MV_RELACNT")
Local _cMailSenha  := GETMV("MV_RELPSW")


// Monta o corpo do e-mail e cria o arquivo de log no sigaadv
_cMsg := "<html>"
_cMsg += "<style>"
_cMsg += "table {"
_cMsg += "  border: 1px solid black;"
_cMsg += "}"
_cMsg += "</style>"
_cMsg += "<div><span><FONT face=Verdana color=#ff0000 size=2>"
_cMsg += "<strong>Workflow - Servi็o Envio de Mensagens</strong></font></span></div><hr>"
_cMsg+="<table border='1' style='bwidth: 100%' >"
_cMsg+="	<tr>"
_cMsg+="		<td style='text-align:left' ><b>Produto</b></td>"
_cMsg+="		<td style='text-align:left'><b>Descri็ใo</b></td>"
_cMsg+="		<td style='text-align:left'><b>Qtd. Requisitada</b></td>"
_cMsg+="		<td style='text-align:left'><b>Qtd. Separada</b></td>"
_cMsg+="		<td style='text-align:left'><b>Lote Requisitado</b></td>"
_cMsg+="		<td style='text-align:left'><b>Lote Separado</b></td>"
_cMsg+="	</tr>"

For _ni := 1 To Len(_aMsg)
	_cMsg   	+= "<tr>"
	for j:= 1 To Len(_aMsg[_ni])
		_cMsg+="		<td style='text-align:left'>"+_aMsg[_ni,j,1]+"</td>"
		_cMsg+="		<td style='text-align:left'>"+_aMsg[_ni,j,2]+"</td>"
		_cMsg+="		<td style='text-align:left'>"+_aMsg[_ni,j,3]+"</td>"
		_cMsg+="		<td style='text-align:left'>"+_aMsg[_ni,j,4]+"</td>"
		_cMsg+="		<td style='text-align:left'>"+_aMsg[_ni,j,5]+"</td>"
		_cMsg+="		<td style='text-align:left'>"+_aMsg[_ni,j,6]+"</td>"
	next j
	_cMsg   	+= "</tr>"
Next _ni
_cMsg+="</table>"
_cMsg += "</html>"

//Verifica se existe o SMTP Server
If Empty(_cMailServer)
	If _lMostraMsg
		Help(" ",1,"SEMSMTP")
	EndIf
	Return(.F.)
EndIf
//Verifica se existe a CONTA
If Empty(_cMailConta)
	If _lMostraMsg
		Help(" ",1,"SEMCONTA")
	EndIf
	Return(.F.)
EndIf
//Verifica se existe a Senha
If Empty(_cMailSenha)
	If _lMostraMsg
		Help(" ",1,"SEMSENHA")
	EndIf
	Return(.F.)
EndIf
// Verifica se existe destinatario
If Empty(_cEmailTo)
	Return(.F.)
EndIf
// Envia e-mail com os dados necessarios
CONNECT SMTP SERVER _cMailServer ACCOUNT _cMailConta PASSWORD _cMailSenha RESULT _lOk
If !_lOk .And. _lMostraMsg
	Aviso("Erro ao envio de e-mail","Erro ao conectar ao servidor SMTP",{"Fechar"})
EndIf
// Caso o sistema exija autenticacao, faz a autenticacao
If GetMv("MV_RELAUTH")
	If !MailAuth(_cMailLogin,_cMailSenha)
		If _lMostraMsg
			MsgInfo("Nao foi possivel autenticar no servidor "+_cMailServer,OemToAnsi("Erro na autenticacao"))
		EndIf
	EndIf
EndIf
If _lOk
	//Alterado: Douglas Rodrigues da Silva, cri็ใo de uma nova verifica็ใo antes da leitura do array.
	If ! ValType(_aAttach) == "U" 		
		If Len(_aAttach) > 0
			_cAttach1 := _aAttach[1]
			If Len(_aAttach) > 1
				_cAttach2 := _aAttach[2]
			EndIf
		EndIf
	EndIf
	
	//SEND MAIL FROM GETMV("MV_EMCONTA") TO _cEmailTo BCC _cEmailBcc SUBJECT _cAssunto BODY _cMsg ATTACHMENT _cAttach1, _cAttach2 RESULT _lSendOk  // Alterado Tiberio
	SEND MAIL FROM GETMV("MV_RELFROM") TO _cEmailTo BCC _cEmailBcc SUBJECT _cAssunto BODY _cMsg ATTACHMENT _cAttach1, _cAttach2 RESULT _lSendOk
	If !_lSendOk
		//Erro no Envio do e-mail
		GET MAIL ERROR _cError
		If _lMostraMsg
			MsgInfo(_cError,OemToAnsi("Erro no envio do e-mail"))
		EndIf
	EndIf
	
	DISCONNECT SMTP SERVER
	
Else
	
	//Erro na conexao com o SMTP Server
	GET MAIL ERROR _cError
	If _lMostraMsg
		MsgInfo(_cError,OemToAnsi("Erro na conexao com o SMTP Server"))
	EndIf
	
EndIf

Return(_lSendOk)
