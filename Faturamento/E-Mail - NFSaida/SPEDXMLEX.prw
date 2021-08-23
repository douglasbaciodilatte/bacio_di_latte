#INCLUDE "PROTHEUS.CH"
#INCLUDE "FILEIO.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "TOTVS.CH"
#include "TbiConn.ch"
#include "TbiCode.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SPEDXMLEX ºAutor  ³Douglas Silva       º Data ³  30/03/2015 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Este programa tem como objetivo exportar XML de acordo com  º±±
±±º          ³os parametros informados na rotina.                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFAT                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function SPEDXMLEX(cXFilial,cNFSerie,cNotaIni,cNotaFim,cEmailC)

Local aDeleta  		:= {}             
Local cIniFile 		:= GetADV97()
Local nHandle  		:= 0
Local cURL     		:= PadR(GetNewPar("MV_SPEDURL","http://"),250)

Local cDestino 		:= ""
Local cDrive   		:= ""
Local cModelo  		:= ""/**/
Local cPrefixo 		:= ""
Local cCNPJDEST 		:= Space(14)
Local cIdflush  		//:= cSerie+cNotaIni
Local cXmlInut  		:= ""
Local cXml				:= ""
Local cAnoInut  		:= ""
Local cAnoInut1 		:= ""
Local nX        		:= 0
Local oWS
Local oRetorno
Local oXML
Local lOk      		:= .F.
Local lFlush   		:= .T.
Local lFinal   		:= .F.
Local cIdEnt 			:= WSAT01GetIdEnt()
Local cSerie			:= cNFSerie
Local dDataDe			:= STOD("20150101") 
Local dDataAte		:= STOD("20500101")
Local cCnpjDIni 		:= ""
Local cCnpjDFim		:= "99999999999999"
Local c1Idflush		:= ""

Private cDirDest
Private cChvNFe  		:= ""	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Cria Diretorios no Servidor                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeDir(GetPvProfString(GetEnvServer(),"StartPath","ERROR", cIniFile )+'NFE\SAIDA\' )

cDirDest	:= GetPvProfString(GetEnvServer(),"StartPath","ERROR", cIniFile )+'NFE\SAIDA\' 


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Corrigi diretorio de destino                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
ProcRegua(Val(cNotaFim)-Val(cNotaIni))

SplitPath(cDirDest,@cDrive,@cDestino,"","")
cDestino := cDirDest
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia processamento                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//Verifica se a Entidade está vazia.

Do While lFlush  

	oWS:= WSNFeSBRA():New()
	oWS:cUSERTOKEN        := "TOTVS"
	oWS:cID_ENT           := cIdEnt
	oWS:_URL              := AllTrim(cURL)+"/NFeSBRA.apw"
	oWS:cIdInicial        := cSerie+cNotaIni
	oWS:cIdFinal          := cSerie+cNotaFim
	oWS:dDataDe           := dDataDe
	oWS:dDataAte          := dDataAte
	oWS:cCNPJDESTInicial  := cCnpjDIni
	oWS:cCNPJDESTFinal    := cCnpjDFim
	oWS:nDiasparaExclusao := 0
	lOk:= oWS:RETORNAFX()
	oRetorno := oWS:oWsRetornaFxResult
	
	If lOk
		ProcRegua(Len(oRetorno:OWSNOTAS:OWSNFES3))
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Exporta as notas                                                       ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		
		For nX := 1 To Len(oRetorno:OWSNOTAS:OWSNFES3)
			
			oXml    := oRetorno:OWSNOTAS:OWSNFES3[nX]
			oXmlExp := XmlParser(oRetorno:OWSNOTAS:OWSNFES3[nX]:OWSNFE:CXML,"","","")
			cXML	:= ""
			If Type("oXmlExp:_NFE:_INFNFE:_DEST:_CNPJ")<>"U"
				cCNPJDEST := AllTrim(oXmlExp:_NFE:_INFNFE:_DEST:_CNPJ:TEXT)
			ElseIF Type("oXmlExp:_NFE:_INFNFE:_DEST:_CPF")<>"U"
				cCNPJDEST := AllTrim(oXmlExp:_NFE:_INFNFE:_DEST:_CPF:TEXT)
			Else
				cCNPJDEST := ""
			EndIf
			cVerNfe := IIf(Type("oXmlExp:_NFE:_INFNFE:_VERSAO:TEXT") <> "U", oXmlExp:_NFE:_INFNFE:_VERSAO:TEXT, '')
			cVerCte := Iif(Type("oXmlExp:_CTE:_INFCTE:_VERSAO:TEXT") <> "U", oXmlExp:_CTE:_INFCTE:_VERSAO:TEXT, '')
			If !Empty(oXml:oWSNFe:cProtocolo)
				cNotaIni := oXml:cID
				cIdflush := cNotaIni
				cNFSerie := cNFSerie+cNotaIni+CRLF
				cChvNFe  := NfeIdSPED(oXml:oWSNFe:cXML,"Id")
				cModelo := cChvNFe
				cModelo := StrTran(cModelo,"NFe","")
				cModelo := StrTran(cModelo,"CTe","")
				cModelo := SubStr(cModelo,21,02)
				
				Do Case
					Case cModelo == "57"
						cPrefixo := "CTe"
					OtherWise
						cPrefixo := "NFe"
				EndCase
				
				nHandle := FCreate(cDestino+SubStr(cChvNFe,4,44)+"-"+cPrefixo+".xml")
				If nHandle > 0
					cCab1 := '<?xml version="1.0" encoding="UTF-8"?>'
					If cModelo == "57"
						cCab1  += '<cteProc xmlns="http://www.portalfiscal.inf.br/cte" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.portalfiscal.inf.br/cte procCTe_v'+cVerCte+'.xsd" versao="'+cVerCte+'">'
						cRodap := '</cteProc>'
					Else
						Do Case
							Case cVerNfe <= "1.07"
								cCab1 += '<nfeProc xmlns="http://www.portalfiscal.inf.br/nfe" xmlns:ds="http://www.w3.org/2000/09/xmldsig#" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.portalfiscal.inf.br/nfe procNFe_v1.00.xsd" versao="1.00">'
							Case cVerNfe >= "2.00" .And. "cancNFe" $ oXml:oWSNFe:cXML
								cCab1 += '<procCancNFe xmlns="http://www.portalfiscal.inf.br/nfe" versao="' + cVerNfe + '">'
							OtherWise
								cCab1 += '<nfeProc xmlns="http://www.portalfiscal.inf.br/nfe" versao="' + cVerNfe + '">'
						EndCase
						cRodap := '</nfeProc>'
					EndIf
					FWrite(nHandle,AllTrim(cCab1))
					FWrite(nHandle,AllTrim(oXml:oWSNFe:cXML))
					FWrite(nHandle,AllTrim(oXml:oWSNFe:cXMLPROT))
					FWrite(nHandle,AllTrim(cRodap))
					FClose(nHandle)
					aadd(aDeleta,oXml:cID)
					cXML := AllTrim(cCab1)+AllTrim(oXml:oWSNFe:cXML)+AllTrim(cRodap)
					If !Empty(cXML)
						
						EnviaEmail(cXFilial,"Arquivos XML",(cDirDest+ SubStr(cChvNFe,4,44)+"-"+cPrefixo+".xml"),cEmailC, SUBSTR(cChvNFe,4,44) )
						
						If ExistBlock("FISEXPNFE")
							ExecBlock("FISEXPNFE",.f.,.f.,{cXML})
							
							//Envia arquivo XML por e-mail para os destinatarios
							
						Endif
					EndIF
					
				EndIf
			EndIf
			
			If oXml:OWSNFECANCELADA <> Nil .And. !Empty(oXml:oWSNFeCancelada:cProtocolo)
				cChvNFe  := NfeIdSPED(oXml:oWSNFeCancelada:cXML,"Id")
				cNotaIni := oXml:cID
				cIdflush := cNotaIni
				cNFSerie := cNFSerie+cNotaIni+CRLF
				
				If !"INUT"$oXml:oWSNFeCancelada:cXML
					nHandle := FCreate(cDestino+SubStr(cChvNFe,3,44)+"-ped-can.xml")
					If nHandle > 0
						FWrite(nHandle,oXml:oWSNFeCancelada:cXML)
						FClose(nHandle)
						aadd(aDeleta,oXml:cID)
					EndIf
					nHandle := FCreate(cDestino+"\"+SubStr(cChvNFe,3,44)+"-can.xml")
					If nHandle > 0
						FWrite(nHandle,oXml:oWSNFeCancelada:cXMLPROT)
						FClose(nHandle)
					EndIf
				Else
					
					//						If Type("oXml:OWSNFECANCELADA:CXML")<>"U"
					cXmlInut  := oXml:OWSNFECANCELADA:CXML
					cAnoInut1 := At("<ano>",cXmlInut)+5
					cAnoInut  := SubStr(cXmlInut,cAnoInut1,2)
					//					 	EndIf
					nHandle := FCreate(cDestino+SubStr(cChvNFe,3,2)+cAnoInut+SubStr(cChvNFe,5,38)+"-ped-inu.xml")
					If nHandle > 0
						FWrite(nHandle,oXml:oWSNFeCancelada:cXML)
						FClose(nHandle)
						aadd(aDeleta,oXml:cID)
					EndIf
					nHandle := FCreate(cDestino+"\"+cAnoInut+SubStr(cChvNFe,5,38)+"-inu.xml")
					If nHandle > 0
						FWrite(nHandle,oXml:oWSNFeCancelada:cXMLPROT)
						FClose(nHandle)
					EndIf
				EndIf
			EndIf
			IncProc()
		Next nX

		aDeleta  := {}
	
		If !IsInCallStack("GERANFE")
			If Len(oRetorno:OWSNOTAS:OWSNFES3) == 0 .And. Empty(cNFSerie)
				//Aviso("SPED","Não há dados",{"Ok"})	// "Não há dados"
				lFlush := .F.
			EndIf
		EndIf
		
	Else
		//Aviso("SPED",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3))+CRLF+"Informe o nome do arquivo da private key",{"OK"},3)
		lFinal := .T.
	EndIf
	
	If ! valtype(cIdflush) == "U"
		c1Idflush := AllTrim(Substr(cIdflush,1,3) + StrZero((Val( Substr(cIdflush,4,Len(AllTrim("999999"))))) + 1 ,Len(AllTrim("999999"))))
	EndIf
	
	If c1Idflush <= AllTrim(cNotaIni) .Or. Len(oRetorno:OWSNOTAS:OWSNFES3) == 0 .Or. Empty(cNFSerie) .Or. ;
	   c1Idflush <= Substr(cNotaIni,1,3)+Replicate('0',Len(AllTrim("999999"))-Len(Substr(Rtrim(cNotaIni),4)))+Substr(Rtrim(cNotaIni),4)// Importou o range completo
		lFlush := .F.
		If !IsInCallStack("GERANFE")
			If !Empty(cNFSerie)
				/*
				If Aviso("SPED","Deseja visualizar os dados.",{"Sim","Não"}) == 1	//
					Aviso("Atenção","Solicitação processada com sucesso."+" "+Upper(cDestino)+CRLF+CRLF+cNFSerie,{"Ok"})
								
				EndIf
				*/
			EndIf
		EndIf
	EndIf
EndDo

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SPEDXMLEX ºAutor  ³Douglas Silva       º Data ³  30/03/2015 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Este programa tem como objetivo exportar XML de acordo com  º±±
±±º          ³os parametros informados na rotina.                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFAT                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function EnviaEmail(cXFilial,cTitulo,cAnexo,cEmailC,cChvNFe)

Local cAssunto	:= "BACIO DI LATTE NFE " + cChvNFe
Local cBody		:= ""
Local cEmail 		:= cEmailC 

cBody := '<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">'
cBody +='<html>'
cBody +='<head>'
cBody +='	<title>Bacio di Latte </title>'
cBody +='	<meta charset="utf-8">'
cBody +='</head>'
cBody +='<body>'
cBody +='	<div style="margin-top: 20px">'
cBody +='		<dir>'
cBody +='			<center>'	
cBody +='				<h3>Envio Automatico de Nota Fiscal Eletronica</h3>'
cBody +='			</center>'
cBody +='		</dir>'
cBody +='		<div>
cBody +='			<center>'
cBody +='			<h5>Voce esta recebendo em anexo arquivo XML referente a uma nota fiscal Eletronica</h5>'
cBody +='			<h5>Serie '+ SUBSTR(cChvNFe,25,1) + '</h5>'
cBody +='			<h5>Nota '+ SUBSTR(cChvNFe,26,9) + '</h5>'
cBody +='			<h5>Chave '+ cChvNFe + '</h5>'
cBody +='			</center>'
cBody +='		</div>'
cBody +='		<div>'
cBody +='			<center>'
cBody +='				<h5> Emitente: MILANO COMERCIO VAREJISTA ALIMENTOS S.A </h5>'
cBody +='			</center>'
cBody +='		</div>'
cBody +='	</div>	'
cBody +='</body>'
cBody +='</html>'

	//Atualiza data de envio XML
	SF2->(DBSelectArea(("SF2")))
	SF2->(dbSetOrder(1)) //F2_FILIAL, F2_DOC, F2_SERIE, F2_CLIENTE, F2_LOJA, F2_FORMUL, F2_TIPO, R_E_C_N_O_, D_E_L_E_T_
	If SF2->(DBSeek( cXFilial + SUBSTR(cChvNFe,26,9) + SUBSTR(cChvNFe,25,1) ))

		RecLock("SF2",.F.)
            SF2->F2_EMINFE:= Date() 
        SF2->(MsUnlock())

		( U_EnviaEmail(cAssunto,cBody,cEmail,cAnexo) )

	EndIf

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³GetIdEnt  ³ Autor ³Eduardo Riera          ³ Data ³18.06.2007³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Obtem o codigo da entidade apos enviar o post para o Totvs  ³±±
±±³          ³Service                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpC1: Codigo da entidade no Totvs Services                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function WSAT01GetIdEnt()

Local aArea  := GetArea()
Local cIdEnt := ""
Local cURL   := PadR(GetNewPar("MV_SPEDURL","http://"),250)
Local oWs
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Obtem o codigo da entidade                                              ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oWS := WsSPEDAdm():New()
oWS:cUSERTOKEN := "TOTVS"

oWS:oWSEMPRESA:cCNPJ       := IIF(SM0->M0_TPINSC==2 .Or. Empty(SM0->M0_TPINSC),SM0->M0_CGC,"")
oWS:oWSEMPRESA:cCPF        := IIF(SM0->M0_TPINSC==3,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cIE         := SM0->M0_INSC
oWS:oWSEMPRESA:cIM         := SM0->M0_INSCM
oWS:oWSEMPRESA:cNOME       := SM0->M0_NOMECOM
oWS:oWSEMPRESA:cFANTASIA   := SM0->M0_NOME
oWS:oWSEMPRESA:cENDERECO   := FisGetEnd(SM0->M0_ENDENT)[1]
oWS:oWSEMPRESA:cNUM        := FisGetEnd(SM0->M0_ENDENT)[3]
oWS:oWSEMPRESA:cCOMPL      := FisGetEnd(SM0->M0_ENDENT)[4]
oWS:oWSEMPRESA:cUF         := SM0->M0_ESTENT
oWS:oWSEMPRESA:cCEP        := SM0->M0_CEPENT
oWS:oWSEMPRESA:cCOD_MUN    := SM0->M0_CODMUN
oWS:oWSEMPRESA:cCOD_PAIS   := "1058"
oWS:oWSEMPRESA:cBAIRRO     := SM0->M0_BAIRENT
oWS:oWSEMPRESA:cMUN        := SM0->M0_CIDENT
oWS:oWSEMPRESA:cCEP_CP     := Nil
oWS:oWSEMPRESA:cCP         := Nil
oWS:oWSEMPRESA:cDDD        := Str(FisGetTel(SM0->M0_TEL)[2],3)
oWS:oWSEMPRESA:cFONE       := AllTrim(Str(FisGetTel(SM0->M0_TEL)[3],15))
oWS:oWSEMPRESA:cFAX        := AllTrim(Str(FisGetTel(SM0->M0_FAX)[3],15))
oWS:oWSEMPRESA:cEMAIL      := UsrRetMail(RetCodUsr())
oWS:oWSEMPRESA:cNIRE       := SM0->M0_NIRE
oWS:oWSEMPRESA:dDTRE       := SM0->M0_DTRE
oWS:oWSEMPRESA:cNIT        := IIF(SM0->M0_TPINSC==1,SM0->M0_CGC,"")
oWS:oWSEMPRESA:cINDSITESP  := ""
oWS:oWSEMPRESA:cID_MATRIZ  := ""
oWS:oWSOUTRASINSCRICOES:oWSInscricao := SPEDADM_ARRAYOFSPED_GENERICSTRUCT():New()
oWS:_URL := AllTrim(cURL)+"/SPEDADM.apw"
If oWs:ADMEMPRESAS()
	cIdEnt  := oWs:cADMEMPRESASRESULT
Else
	//Aviso("SPED",IIf(Empty(GetWscError(3)),GetWscError(1),GetWscError(3)),{"Ok"},3)
EndIf

RestArea(aArea)

Return(cIdEnt)
