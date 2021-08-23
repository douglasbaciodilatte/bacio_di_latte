#Include "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BLRECXML    ºAutor  ³Vanito Rocha      º Data ³  27/10/2020 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Função que trata da recuperacao do XM da Nota Fiscal       º±±
±±º          ³ e grava o arquivo para que a Neogrid faça o processamento  º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Especifico Bacio                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
/*
Exemplo abaixo
U_BLRECXML("000000001", "1", "C:\Neogrid\documents\sent\arquivo1.xml", .F.) //Não mostra mensagem com o XML

U_BLRECXML("000000001", "1", "C:\Neogrid\documents\sent\arquivo2.xml", .T.) //Mostra mensagem com o XML
*/

User Function BLRECXML(cDocumento, cSerie)
Local aArea        := GetArea()
Local cURLTss      := PadR(GetNewPar("MV_SPEDURL","http://"),250)
Local oWebServ
Local cIdEnt       := StaticCall(SPEDNFE, GetIdEnt)
Local cTextoXML    := ""
Local xClient      :=""
Local xLoja        :=""
Default cDocumento := ""
Default cSerie     := ""
Default cArqXML    := "C:\Neogrid\documents\sent\"+cSerie+cDocumento+".xml"

//Se tiver documento
If !Empty(cDocumento)
	cDocumento := PadR(cDocumento, TamSX3('F2_DOC')[1])
	cSerie     := PadR(cSerie,     TamSX3('F2_SERIE')[1])
	
	//Instancia a conexão com o WebService do TSS
	oWebServ:= WSNFeSBRA():New()
	oWebServ:cUSERTOKEN        := "TOTVS"
	oWebServ:cID_ENT           := cIdEnt
	oWebServ:oWSNFEID          := NFESBRA_NFES2():New()
	oWebServ:oWSNFEID:oWSNotas := NFESBRA_ARRAYOFNFESID2():New()
	aAdd(oWebServ:oWSNFEID:oWSNotas:oWSNFESID2,NFESBRA_NFESID2():New())
	aTail(oWebServ:oWSNFEID:oWSNotas:oWSNFESID2):cID := (cSerie+cDocumento)
	oWebServ:nDIASPARAEXCLUSAO := 0
	oWebServ:_URL              := AllTrim(cURLTss)+"/NFeSBRA.apw"
	
	//Se tiver notas
	If oWebServ:RetornaNotas()
		
		//Se tiver dados
		If Len(oWebServ:oWsRetornaNotasResult:OWSNOTAS:oWSNFES3) > 0
			
			//Se tiver sido cancelada
			If oWebServ:oWsRetornaNotasResult:OWSNOTAS:oWSNFES3[1]:oWSNFECANCELADA != Nil
				cTextoXML := oWebServ:oWsRetornaNotasResult:OWSNOTAS:oWSNFES3[1]:oWSNFECANCELADA:cXML
				
				//Senão, pega o xml normal
			Else
				cTextoXML := oWebServ:oWsRetornaNotasResult:OWSNOTAS:oWSNFES3[1]:oWSNFE:cXML
			EndIf
			
			//Gera o arquivo
			MemoWrite(cArqXML, cTextoXML)
			//Caso não encontre as notas, mostra mensagem
		Else
			ConOut("BLRECXML > Verificar parâmetros, documento e série não encontrados ("+cDocumento+"/"+cSerie+")...")
			
		EndIf
		
		//Senão, houve erros na classe
	Else
		ConOut("BLRECXML > "+IIf(Empty(GetWscError(3)), GetWscError(1), GetWscError(3))+"...")
	EndIf
EndIf
RestArea(aArea)
Return


