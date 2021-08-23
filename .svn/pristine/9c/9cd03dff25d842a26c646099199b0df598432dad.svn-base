#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#include "ap5mail.ch"
#include "TOPCONN.CH"
#include "tbiconn.ch"

/*/
{Protheus.doc} BDWFFAT1
Description

	Relatório tem objetivo envio das vendas apuradas pela integração STOQ x Protheus

@param xParam Parameter Description
@return Nil
@author  - Douglas R. Silva
@since 03/11/2019
/*/

User Function BDWFFAT1()

Local lProcWF			:= .F.
Local lStatusWF			:= .F.
Local cEmailCom			
Local cProcWF			
Local cStatusWF	
Local cEmp      := "01"  //codigo da empresa
Local cFil      := "0001"  //codigo da filial		
Local nTotal	:= 0
Local cNomeLoja
Local cArquivo

RPCSetType(3)  //Nao consome licensas
RpcSetEnv(cEmp,cFil,,,,GetEnvServer(),{ }) //Abertura do ambiente em rotinas automáticas

cEmailCom			:= SuperGetMV('MV_BDWFFAT',,'bacio@bexcell.com.br')
cProcWF				:= 'NOTFAT'
cStatusWF			:= '10001'

lProcWF := WF1->(DbSeek(xFilial("WF1") + cProcWF))
IF !lProcWF
	Conout("Processo "+cProcWF+" do WorkFlow nao cadastrado!","Erro")
	Return
Endif

lStatusWF := WF2->(DbSeek(xFilial("WF2") + WF1->WF1_COD + cStatusWF))
IF !lStatusWF
	Conout("Status "+cStatusWF+" do processo do "+cProcWF+" do WorkFlow nao cadastrado!","Erro")
	Return
Endif

	//Monta Query com Dados	
	cQuery := " SELECT " + CRLF
	cQuery += " SUBSTRING(F2_EMISSAO,5,2) 'MES', " + CRLF
	cQuery += " SUBSTRING(F2_EMISSAO,1,4) 'ANO', " + CRLF
	cQuery += " ISNULL(CTT.CTT_DESC01,'') AS 'LOJA', " + CRLF
	cQuery += " F2_FILIAL AS 'FILIAL', " + CRLF 
	cQuery += " Format( Round ( SUM(SF2.F2_VALBRUT),2), 'C', 'pt-br') AS 'TOTAL', " + CRLF
	cQuery += " ROUND(SUM(SF2.F2_VALBRUT),2) AS VALBRUT " + CRLF
	cQuery += " FROM "+RETSQLNAME("SF2")+" SF2 (NOLOCK) " + CRLF
	cQuery += " LEFT JOIN "+RETSQLNAME("CTT")+" CTT ON CTT.CTT_FILIAL = '' AND CTT.CTT_CUSTO = SF2.F2_FILIAL AND CTT.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " WHERE SF2.F2_EMISSAO BETWEEN '"+ SUBSTR( DTOS(DATE()),1,6) + "01" +"' AND '"+ DTOS(DATE()-1)+"' " + CRLF
	cQuery += " AND SF2.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " AND SF2.F2_PDV != ' ' " + CRLF
	cQuery += " GROUP BY F2_FILIAL,CTT.CTT_DESC01, SUBSTRING(F2_EMISSAO,5,2),SUBSTRING(F2_EMISSAO,1,4) " + CRLF
	cQuery += " ORDER BY 4 " + CRLF

	If ( Select("TMP1") ) > 0
		DbSelectArea("TMP1")
		TMP1->(DbCloseArea())
	EndIf

	TCQUERY cQuery NEW ALIAS "TMP1"

	DbSelectArea("TMP1")
	DbGoTop()

	oProcess := TWFProcess():New( cProcWF, "Notificação de Pré-Nota" )  
	oProcess :NewTask( "Relatorio Faturamento - Protheus", "\WORKFLOW\BDWFFAT1.htm" )
	
	oHtml    := oProcess:oHTML
	
	While TMP1->(!Eof())
		
		
		If Empty( TMP1->LOJA )
		
			dbselectarea("NNR")
			dbsetorder(1)     
		    If NNR->(DbSeek( TMP1->FILIAL ))
		    	cNomeLoja := Alltrim(NNR->NNR_DESCRI) 
	        ENDIF 
	       
	    Else	        
	        cNomeLoja := Alltrim( TMP1->LOJA )
	    EndIf    
		
		aAdd( (oHtml:ValByName( "it.ano"	)), TMP1->ANO )
		aAdd( (oHtml:ValByName( "it.mes"	)), TMP1->MES )		
		aAdd( (oHtml:ValByName( "it.loja"	)), cNomeLoja )
		aAdd( (oHtml:ValByName( "it.filial"	)), TMP1->FILIAL )
		aAdd( (oHtml:ValByName( "it.valor"	)), Transform( TMP1->VALBRUT , "@E 999,999,999.99")  )
		
		nTotal += TMP1->VALBRUT
					
		TMP1->(DbSkip())		
	EndDo

	oHtml:ValByName( "soma_total", Transform( nTotal , "@E 999,999,999.99") )
		
	oHtml    := oProcess:oHTML
	
	// --------------------------------------------------------------------------
	// Inicia o Processo de WorkFlow para envio de E-mail ao fornecedor
	// --------------------------------------------------------------------------
	oProcess:cSubject	:= UPPER( "Relatório Faturamento 01 A " + SUBSTR( DTOS(DATE()-1), 7,2) + " " + MesExtenso( SUBSTR( DTOS(DATE()),5,2) ) + " De " + SUBSTR( DTOS(DATE()), 1,4) + " Protheus " )
	
	//Anexa arquivo gerado html
	//AttachFile("\workflow\enviados\copia.html")
		
	oProcess:cTo	:= cEmailCom
	cArquivo 		:= oProcess:Start("\workflow\copia.html")
	
	oProcess:AttachFile("\workflow\copia.html\"+cArquivo + ".html")
		
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,WF1->WF1_COD,WF2->WF2_STATUS,"Email enviado com sucesso")
	
	// --------------------------------------------------------------------------
	// Encerra o processo do WorkFlow logo em seguida, 
	//  pois não há resposta do Fornecedor
	// --------------------------------------------------------------------------
	oProcess:Finish()
	WFSendMail()

Return