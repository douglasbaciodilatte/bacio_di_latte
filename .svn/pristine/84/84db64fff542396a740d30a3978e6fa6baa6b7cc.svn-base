#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#include "ap5mail.ch"
#include "TOPCONN.CH"
#include "tbiconn.ch"
#include "Fileio.ch"
#Include "ParmType.ch"

/*/
{Protheus.doc} BDWFFAT1
Description

	Relatório tem objetivo envio das vendas apuradas pela integração STOQ x Protheus

@param xParam Parameter Description
@return Nil
@author  - Douglas R. Silva
@since 03/11/2019
/*/

User Function BDWFFAT2()

Local lProcWF			:= .F.
Local lStatusWF			:= .F.
Local cEmailCom			
Local cProcWF			
Local cStatusWF	
Local cEmp      := "01"  //codigo da empresa
Local cFil      := "0001"  //codigo da filial		
Local cArquivo
Local cIniFile 	
Local cDirDest	
Local _cSubject
Local nSoma1 := 0
Local nSoma2 := 0
Local nSoma3 := 0
Local nSoma4 := 0

Private cQuery := ""

RPCSetType(3)  //Nao consome licensas
RpcSetEnv(cEmp,cFil,,,,GetEnvServer(),{ }) //Abertura do ambiente em rotinas automáticas

cEmailCom			:= SuperGetMV('MV_BDWFFAT',,'sistemas@bdil.com.br')
cProcWF				:= 'NOTFAT'
cStatusWF			:= '10001'

cIniFile 		:= GetADV97()
cDirDest	:= GetPvProfString(GetEnvServer(),"RootPath","ERROR", cIniFile )+'workflow\SAIDA\copia.html\' 

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
	cQuery := QUERYE()
	TCQUERY cQuery NEW ALIAS "TMP1"

	cQuery := QUERYA()	
	TCQUERY cQuery NEW ALIAS "TTP1"

	_cSubject := UPPER( "Relatorio Faturamento 01 A " + SUBSTR( DTOS(DATE()-1), 7,2) + " " + MesExtenso( SUBSTR( DTOS(DATE()),5,2) ) + " De " + SUBSTR( DTOS(DATE()), 1,4) + " Protheus " )

	oProcess := TWFProcess():New( cProcWF, "Notificacao de Faturamento" )  
	oProcess :NewTask( _cSubject, "\WORKFLOW\BDWFFAT2.htm" )
	
	oHtml    := oProcess:oHTML

	While TTP1->(!Eof())
		
		aAdd( (oHtml:ValByName( "at.loja"	)), TTP1->CLIENTE )
		aAdd( (oHtml:ValByName( "at.qtde_vend")), Transform( TTP1->QTDE_VEND 	, "@E 999,999,999") )
		aAdd( (oHtml:ValByName( "at.total")), Transform( TTP1->TOTAL_CI 	, "@E 999,999,999") )
		aAdd( (oHtml:ValByName( "at.total_dev")), Transform( TTP1->TOTAL_DEV 	, "@E 999,999,999") )
		aAdd( (oHtml:ValByName( "at.total_liq")), Transform( TTP1->TOTAL_CI - TTP1->TOTAL_DEV 	, "@E 999,999,999") )
		
		TTP1->(DbSkip())		
	EndDo

	While TMP1->(!Eof())
		
		
		aAdd( (oHtml:ValByName( "it.loja"	)), TMP1->LOJA )
		aAdd( (oHtml:ValByName( "it.qtde_vend")), Transform( TMP1->QTDE_VEND 	, "@E 999,999,999") )		
		aAdd( (oHtml:ValByName( "it.total"	))	, Transform( TMP1->TOTAL_CI 	, "@E 999,999,999") )
		aAdd( (oHtml:ValByName( "it.total_dev")), Transform( TMP1->TOTAL_DEV 	, "@E 999,999,999") )	
		aAdd( (oHtml:ValByName( "it.total_liq")), Transform( TMP1->TOTAL_CI - TMP1->TOTAL_DEV 	, "@E 999,999,999") )			
		
		nSoma1 := nSoma1 + TMP1->QTDE_VEND 
		nSoma2 := nSoma2 + TMP1->TOTAL_CI
		nSoma3 := nSoma3 + TMP1->TOTAL_DEV 
		nSoma4 := nSoma4 + TMP1->TOTAL_CI - TMP1->TOTAL_DEV 
					
		TMP1->(DbSkip())		
	EndDo

	oHtml:ValByName( "soma1", Transform( nSoma1 , "@E 999,999,999") )
	oHtml:ValByName( "soma2", Transform( nSoma2 , "@E 999,999,999") )
	oHtml:ValByName( "soma3", Transform( nSoma3 , "@E 999,999,999") )
	oHtml:ValByName( "soma4", Transform( nSoma4 , "@E 999,999,999") )
		
	oHtml    := oProcess:oHTML
	
	// --------------------------------------------------------------------------
	// Inicia o Processo de WorkFlow para envio de E-mail ao fornecedor
	// --------------------------------------------------------------------------
	oProcess:cSubject	:= _cSubject
	
	//Anexa arquivo gerado html
	//AttachFile("\workflow\enviados\copia.html")
		
	oProcess:cTo	:= cEmailCom
	cArquivo 		:= oProcess:Start("\workflow\copia.html")
	
	oProcess:AttachFile("\workflow\copia.html\" + cArquivo + ".htm")
			
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,WF1->WF1_COD,WF2->WF2_STATUS,"Email enviado com sucesso")
	
	// --------------------------------------------------------------------------
	// Encerra o processo do WorkFlow logo em seguida, 
	//  pois não há resposta do Fornecedor
	// --------------------------------------------------------------------------
	oProcess:Finish()
	WFSendMail()

RpcClearEnv()   //Libera o Ambiente

Return

Static Function QUERYE()

	cQuery := " SELECT " + CRLF 
	cQuery += " 	TEMP.LOJA, " + CRLF 
	cQuery += " 	ROUND(SUM(TEMP.QTDE_VEND),0) AS 'QTDE_VEND', " + CRLF 
	cQuery += " 	ROUND(SUM(TEMP.TOTAL_SI),0) AS 'TOTAL_SI', " + CRLF
	cQuery += " 	ROUND(SUM(TOTAL_CI),0) AS 'TOTAL_CI', " + CRLF 
	cQuery += " 	ROUND(SUM(TEMP.QTDE_DEV),0) AS 'QTDE_DEV', " + CRLF 
	cQuery += " 	ROUND(SUM(TEMP.TOTAL_DEV),0) AS 'TOTAL_DEV' " + CRLF
	cQuery += " FROM ( " + CRLF
	cQuery += " SELECT " + CRLF 
	cQuery += " 	SA1.A1_COD + '-' + SA1.A1_LOJA + '-' + SA1.A1_NREDUZ AS 'LOJA', " + CRLF 
	cQuery += " 	SD2.D2_COD 'PRODUTO', SB1.B1_DESC 'DESCRICAO', " + CRLF
	cQuery += " 	SD2.D2_PRCVEN 'PRC_VENDA', SD2.D2_QUANT 'QTDE_VEND', SD2.D2_TOTAL 'TOTAL_SI', SD2.D2_VALBRUT 'TOTAL_CI', " + CRLF
	cQuery += " 	ISNULL(SD1.D1_QUANT,0) AS 'QTDE_DEV', " + CRLF
	cQuery += " 	ISNULL(SD1.D1_TOTAL + SD1.D1_VALIPI + SD1.D1_ICMSRET,0) AS 'TOTAL_DEV' " + CRLF	
	cQuery += "  FROM "+RETSQLNAME("SA1")+" SA1 " + CRLF 
	cQuery += "  JOIN "+RETSQLNAME("SD2")+" SD2 ON " + CRLF 
	cQuery += " 	SD2.D2_FILIAL = '0072' " + CRLF 
	cQuery += "  	AND SD2.D2_CLIENTE = SA1.A1_COD 	AND SD2.D2_LOJA = SA1.A1_LOJA " + CRLF 
	cQuery += "  	AND SD2.D2_TIPO = 'N' " + CRLF 
	cQuery += "  	AND SD2.D_E_L_E_T_ != '*' " + CRLF 
	cQuery += "  JOIN "+RETSQLNAME("SB1")+" SB1 ON " + CRLF  
	cQuery += "  	SB1.B1_FILIAL = '' " + CRLF 
	cQuery += "  	AND SB1.B1_COD = SD2.D2_COD " + CRLF 
	cQuery += "  	AND SB1.D_E_L_E_T_ != '*' " + CRLF 
	cQuery += "  JOIN "+RETSQLNAME("SF4")+" SF4 ON " + CRLF 
	cQuery += "  	SF4.F4_FILIAL = '' " + CRLF 
	cQuery += "  	AND SF4.F4_CODIGO = SD2.D2_TES " + CRLF 
	cQuery += "  	AND SF4.D_E_L_E_T_ != '*'  " + CRLF
	cQuery += "  LEFT JOIN "+RETSQLNAME("SD1")+" SD1 ON " + CRLF 
	cQuery += "  	SD1.D1_FILIAL = SD2.D2_FILIAL " + CRLF 
	cQuery += "  	AND SD1.D1_COD = SD2.D2_COD " + CRLF 
	cQuery += "  	AND SD1.D1_NFORI = SD2.D2_DOC " + CRLF 
	cQuery += "  	AND SD1.D1_SERIORI = SD2.D2_SERIE " + CRLF 
	cQuery += "  	AND SD1.D1_FORNECE = SD2.D2_CLIENTE " + CRLF 
	cQuery += "  	AND SD1.D1_LOJA = SD2.D2_LOJA " + CRLF 
	cQuery += "  	AND SD2.D2_ITEM = SD1.D1_ITEMORI " + CRLF
	cQuery += "  	AND SD1.D_E_L_E_T_ != '*' " + CRLF 
	cQuery += "  WHERE SA1.D_E_L_E_T_ != '*' " + CRLF 
	cQuery += "  	AND SD2.D2_FILIAL = '0072' " + CRLF 
	cQuery += "  	AND SF4.F4_DUPLIC = 'S' " + CRLF 
	cQuery += "  	AND SUBSTRING( SD2.D2_EMISSAO ,1,6 ) = '"+SUBSTR( DTOS(DATE() - 1),1,6 )+"' ) TEMP " + CRLF
	cQuery += " GROUP BY TEMP.LOJA " + CRLF
	cQuery += " ORDER BY 1 DESC " + CRLF

Return(cQuery)

Static Function QUERYA()

	cQuery := "SELECT " + CRLF 
 	cQuery += "		CLIENTE, " + CRLF 
 	cQuery += "		ROUND(SUM(TEMP.QTDE_VEND),0) AS 'QTDE_VEND',  " + CRLF 
 	cQuery += "		ROUND(SUM(TEMP.TOTAL_SI),0) AS 'TOTAL_SI',  " + CRLF 
 	cQuery += "		ROUND(SUM(TOTAL_CI),0) AS 'TOTAL_CI', " + CRLF  
 	cQuery += "		ROUND(SUM(TEMP.QTDE_DEV),0) AS 'QTDE_DEV',  " + CRLF 
 	cQuery += "		ROUND(SUM(TEMP.TOTAL_DEV),0) AS 'TOTAL_DEV' " + CRLF  
 	cQuery += "FROM (  " + CRLF 
 	cQuery += "SELECT " + CRLF  
 	cQuery += "		ACY.ACY_DESCRI AS 'CLIENTE', " + CRLF  
 	cQuery += "		SD2.D2_COD 'PRODUTO', SB1.B1_DESC 'DESCRICAO', " + CRLF  
 	cQuery += "		SD2.D2_PRCVEN 'PRC_VENDA', SD2.D2_QUANT 'QTDE_VEND', SD2.D2_TOTAL 'TOTAL_SI', SD2.D2_VALBRUT 'TOTAL_CI', " + CRLF  
 	cQuery += "		ISNULL(SD1.D1_QUANT,0) AS 'QTDE_DEV', " + CRLF  
 	cQuery += "		ISNULL(SD1.D1_TOTAL + SD1.D1_VALIPI + SD1.D1_ICMSRET,0) AS 'TOTAL_DEV'  " + CRLF 
  	cQuery += "FROM SA1010 SA1  " + CRLF 
  	cQuery += "JOIN SD2010 SD2 ON  " + CRLF 
 	cQuery += "SD2.D2_FILIAL = '0072' " + CRLF  
  	cQuery += "AND SD2.D2_CLIENTE = SA1.A1_COD 	AND SD2.D2_LOJA = SA1.A1_LOJA  " + CRLF 
  	cQuery += "AND SD2.D2_TIPO = 'N' " + CRLF  
  	cQuery += "AND SD2.D_E_L_E_T_ != '*'  " + CRLF 
  	cQuery += "JOIN SB1010 SB1 ON  " + CRLF 
  	cQuery += "SB1.B1_FILIAL = '' 
  	cQuery += "AND SB1.B1_COD = SD2.D2_COD  " + CRLF 
  	cQuery += "AND SB1.D_E_L_E_T_ != '*' " + CRLF  
 	cQuery += " JOIN SF4010 SF4 ON  " + CRLF 
  	cQuery += "SF4.F4_FILIAL = '' " + CRLF  
  	cQuery += "AND SF4.F4_CODIGO = SD2.D2_TES " + CRLF  
  	cQuery += "AND SF4.D_E_L_E_T_ != '*'  " + CRLF  
  	cQuery += "LEFT JOIN SD1010 SD1 ON 
  	cQuery += "SD1.D1_FILIAL = SD2.D2_FILIAL " + CRLF  
  	cQuery += "AND SD1.D1_COD = SD2.D2_COD  " + CRLF 
  	cQuery += "AND SD1.D1_NFORI = SD2.D2_DOC  " + CRLF 
  	cQuery += "AND SD1.D1_SERIORI = SD2.D2_SERIE  " + CRLF 
  	cQuery += "AND SD1.D1_FORNECE = SD2.D2_CLIENTE  " + CRLF 
  	cQuery += "AND SD1.D1_LOJA = SD2.D2_LOJA  " + CRLF 
  	cQuery += "AND SD2.D2_ITEM = SD1.D1_ITEMORI  " + CRLF 
  	cQuery += "AND SD1.D_E_L_E_T_ != '*'  " + CRLF 
  	cQuery += "LEFT JOIN ACY010 ACY ON " + CRLF 
	cQuery += "ACY.ACY_FILIAL = '' " + CRLF 
	cQuery += "AND ACY.ACY_GRPVEN = SA1.A1_GRPVEN " + CRLF 
	cQuery += "AND ACY.D_E_L_E_T_ != '*' " + CRLF 
  	cQuery += "WHERE SA1.D_E_L_E_T_ != '*'  " + CRLF 
  	cQuery += "AND SD2.D2_FILIAL = '0072'  " + CRLF 
  	cQuery += "AND SF4.F4_DUPLIC = 'S'  " + CRLF 
  	cQuery += "AND SUBSTRING( SD2.D2_EMISSAO ,1,6 ) = '"+SUBSTR( DTOS(DATE() - 1),1,6 )+"' ) TEMP  " + CRLF 
 	cQuery += "GROUP BY CLIENTE " + CRLF 
 	cQuery += "ORDER BY 1 DESC  " + CRLF 

Return(cQuery)
