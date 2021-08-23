#include "tbiconn.ch"
#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณJSXMLMAIL บAutor  ณDouglas Silva       บ Data ณ  30/03/2015 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณEste programa tem como objetivo exportar XML de acordo com  บฑฑ
ฑฑบ          ณos parametros informados na rotina.                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ SIGAFAT                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function JSXMLMAIL()

Local aFilial := {"0072"}
Local nX
Local cEMailSis

Private cQuery 	:= ""

RpcSetEnv("01","0072" ,,,'FRT')

PtInternal(1,'JOB Envio XML ' + "0072" + DTOC( DATE() ) + ' Hora ' + Time()  )

	cEMailSis	:= Alltrim(GETMV("MV_XEMAXML"))

While Time() < '23:59:59'

	FOR nX := 1 to Len(aFilial)

		//Chamada dos Jobs para Envio dos arquivos XML
		Conout("Inicio do Job Empresa 01 Filial " +aFilial[nX]+ " - Envio de XML Hora " + Time() + " Data " + DTOc(date()) )

		cQuery := " SELECT SF2.F2_SERIE, SF2.F2_DOC, " + CRLF 
		cQuery += " RTRIM(LTRIM(SA1.A1_EMAIL)) + ';'+ RTRIM(LTRIM(ISNULL(SA4.A4_EMAIL,''))) + " + CRLF 
		cQuery += " ('"+cEMailSis+"' ) AS EMAILXML " + CRLF 
		
		cQuery += " FROM "+RETSQLNAME("SF2")+" SF2 " + CRLF 
		
		cQuery += " JOIN "+RETSQLNAME("SA1")+" SA1 ON SA1.D_E_L_E_T_ != '*' " + CRLF 
		cQuery += "  				AND SA1.A1_FILIAL = '  ' " + CRLF 
		cQuery += " 				AND SA1.A1_COD = SF2.F2_CLIENTE " + CRLF 
		cQuery += "  				AND SA1.A1_LOJA = SF2.F2_LOJA " + CRLF 
	
		cQuery += " LEFT JOIN "+RETSQLNAME("SC5")+" SC5 ON SC5.D_E_L_E_T_ != '*' " + CRLF
		cQuery += " 				AND SC5.C5_FILIAL = SF2.F2_FILIAL " + CRLF
		cQuery += " 					AND SC5.C5_NOTA = SF2.F2_DOC " + CRLF
		cQuery += " 					AND SC5.C5_SERIE = SF2.F2_SERIE " + CRLF
		cQuery += " 					AND SC5.C5_CLIENTE = SF2.F2_CLIENTE " + CRLF
		cQuery += " 					AND SC5.C5_LOJACLI = SF2.F2_LOJA " + CRLF
		cQuery += "	LEFT JOIN "+RETSQLNAME("SA4")+" SA4 ON SA4.A4_FILIAL = '' AND SA4.A4_COD = SF2.F2_TRANSP AND SA4.D_E_L_E_T_ != '*' " + CRLF
		
		cQuery += " WHERE SF2.D_E_L_E_T_ != '*' " + CRLF 
		cQuery += " AND SF2.F2_FILIAL = '"+aFilial[nX]+"' " + CRLF 
		cQuery += " AND SF2.F2_FIMP = 'S' " + CRLF 
		cQuery += " AND SF2.F2_DAUTNFE >= '20201201' AND F2_ESPECIE = 'SPED' AND F2_EMINFE = '' " + CRLF 
		
		cQuery += " ORDER BY F2_FILIAL, F2_DOC " + CRLF  
		
		dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),"TRB", .F., .F.)
		
		Do While !TRB->(EOF())
		
			//Chamada rotina de gera็ใo e envio de nota fiscal
			If  EMPTY(ALLTRIM(TRB->EMAILXML))   //Todos os EMail estiverm vazio envia para TOTVS
				U_SPEDXMLEX(aFilial[nX],TRB->F2_SERIE,TRB->F2_DOC,TRB->F2_DOC,'douglas.silva@bdil.com.br')
			
			ElseIf !EMPTY(ALLTRIM(TRB->EMAILXML))  // Se Apenas o Email do Cliente estiver vazio envia para Transportadora
				U_SPEDXMLEX(aFilial[nX],TRB->F2_SERIE,TRB->F2_DOC,TRB->F2_DOC,(TRB->EMAILXML) )
			
			EndIf		
			
			TRB->(DBSKIP())
		Enddo
			
		TRB->(DBCLOSEAREA())
		
	Next Nx
	
	Sleep(5*60000)
EndDo

RpcClearEnv()
	
Return
