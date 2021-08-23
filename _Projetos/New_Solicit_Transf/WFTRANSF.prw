#Include "Totvs.ch"
#Include "ap5mail.ch"

/*/
{Protheus.doc} WFTRANSF
	@Description: Envio de dados de nova solicitacao de transferencia incluida no sistema
	@Func Orig: BDTRASF
	@author: Felipe Mayer
	@since: 19/05/2021
/*/

User Function WFTRANSF(cSolicit,dData,cHora,aItens,cEmailCom)

Local cProcWF 	:= 'TRANSF' 
Local cStatusWF := '10001'
Local lProcWF	:= WF1->(DbSeek(xFilial("WF1")+cProcWF))
Local lStatusWF := WF2->(DbSeek(xFilial("WF2")+WF1->WF1_COD+cStatusWF))	
Local nX	    := 0

Default cEmailCom := ''

	If !lProcWF
		Conout("Processo "+cProcWF+" do WorkFlow nao cadastrado!","Erro")
		Return
	EndIf

	If !lStatusWF
		Conout("Status "+cStatusWF+" do processo do "+cProcWF+" do WorkFlow nao cadastrado!","Erro")
		Return
	EndIf
	
	If Empty(cEmailCom)
		Return	
	EndIf

	oProcess := TWFProcess():New(cProcWF,"NOVA SOLICITACAO DE TRANSFERENCIA LOJA")  
	oProcess :NewTask("NOVA SOLICITACAO DE TRANSFERENCIA LOJA","\WORKFLOW\WFTRANSF.htm")
	oHtml := oProcess:oHTML

	For nX := 1 To Len(aItens)
		aAdd((oHtml:ValByName("it.cDados1")),aItens[nX,3])
		aAdd((oHtml:ValByName("it.cDados2")),aItens[nX,4])		
		aAdd((oHtml:ValByName("it.cDados3")),aItens[nX,5])
		aAdd((oHtml:ValByName("it.cDados4")),aItens[nX,6])
		aAdd((oHtml:ValByName("it.cDados5")),aItens[nX,7])
	Next nX
	
	oHtml:ValByName("cDados6" ,cSolicit)
	oHtml:ValByName("cDados7" ,aItens[1,1])
	oHtml:ValByName("cDados8" ,DToC(dData))
	oHtml:ValByName("cDados9" ,aItens[1,2])
	oHtml:ValByName("cDados10",cHora)

	oHtml := oProcess:oHTML
		
	oProcess:cSubject := 'Nova Solicitação de Transferência: '+cSolicit
	oProcess:cTo := cEmailCom

	oProcess:Start()		
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,WF1->WF1_COD,WF2->WF2_STATUS,"Email enviado com sucesso")
	
	oProcess:Finish()
	WFSendMail()

Return
