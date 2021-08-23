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

Local lProcWF	:= .F.
Local lStatusWF	:= .F.		
Local cProcWF	:= 'NOTFAT'			
Local cStatusWF := '10001'
Local nX	 	:= 0
Local nSoma1 	:= 0
Local nSoma2 	:= 0
Local nSoma3 	:= 0
Local nSoma4 	:= 0
Local cEmailCom
Local cArquivo
Local cIniFile 	
Local cDirDest	
Local _cSubject

	RPCSetType(3)
	RpcSetEnv("01","0001",,,,GetEnvServer(),{ })

	aList1 	  := QUERY1()
	aList1Aux := QUERY2(@aList1)
	aList2 	  := QUERY3()
	aList2Aux := QUERY4(@aList2)

	cEmailCom := SuperGetMV('MV_BDWFFAT',,'sistemas@bdil.com.br')
	cIniFile  := GetADV97()
	cDirDest  := GetPvProfString(GetEnvServer(),"RootPath","ERROR", cIniFile )+'workflow\SAIDA\copia.html\' 

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

	_cSubject := Upper("Relatorio Faturamento 01 A "+SubsTr(DToS(Date()-1),7,2)+" "+;
				 MesExtenso(SubsTr(DToS(Date()),5,2))+" De "+SubsTr(DToS(Date()),1,4)+" Protheus ")

	oProcess := TWFProcess():New(cProcWF,"Notificacao de Faturamento")  
	oProcess :NewTask(_cSubject,"\WORKFLOW\BDWFFAT2.htm")
	
	oHtml := oProcess:oHTML

	For nX := 1 To Len(aList2)
		aAdd( (oHtml:ValByName( "at.loja"	))	, aList2[nX,1] )
		aAdd( (oHtml:ValByName( "at.qtde_vend")), cValToChar(aList2[nX,2]) )
		aAdd( (oHtml:ValByName( "at.total"))	, Alltrim(Transform( aList2[nX,4] , "@E 999,999,999.99")) )
		aAdd( (oHtml:ValByName( "at.total_dev")), Alltrim(Transform( aList2[nX,6] , "@E 999,999,999.99")) )
		aAdd( (oHtml:ValByName( "at.total_liq")), Alltrim(Transform( aList2[nX,4] - aList2[nX,6] , "@E 999,999,999.99")) )
	Next nX

	For nX := 1 To Len(aList1)
		aAdd( (oHtml:ValByName( "it.loja"	))	, aList1[nX,1] )
		aAdd( (oHtml:ValByName( "it.qtde_vend")), cValToChar(aList1[nX,2]) )		
		aAdd( (oHtml:ValByName( "it.total"	))	, Alltrim(Transform( aList1[nX,4] , "@E 999,999,999.99")) )
		aAdd( (oHtml:ValByName( "it.total_dev")), Alltrim(Transform( aList1[nX,6] , "@E 999,999,999.99")) )	
		aAdd( (oHtml:ValByName( "it.total_liq")), Alltrim(Transform( aList1[nX,4] - aList1[nX,6] , "@E 999,999,999.99")) )			
	
		nSoma1 := nSoma1 + aList1[nX,2] 
		nSoma2 := nSoma2 + aList1[nX,4]
		nSoma3 := nSoma3 + aList1[nX,6]
		nSoma4 := nSoma4 + aList1[nX,4] - aList1[nX,6]		
	Next nX

	oHtml:ValByName("soma1",cValToChar(nSoma1))
	oHtml:ValByName("soma2",Alltrim(Transform(nSoma2, "@E 999,999,999.99")))
	oHtml:ValByName("soma3",Alltrim(Transform(nSoma3, "@E 999,999,999.99")))
	oHtml:ValByName("soma4",Alltrim(Transform(nSoma4, "@E 999,999,999.99")))
		
	oHtml := oProcess:oHTML
	
	oProcess:cSubject := _cSubject
	oProcess:cTo 	  := cEmailCom
	
	cArquivo := oProcess:Start("\workflow\copia.html")
	
	oProcess:AttachFile("\workflow\copia.html\" + cArquivo + ".htm")
			
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,WF1->WF1_COD,WF2->WF2_STATUS,"Email enviado com sucesso")
	
	oProcess:Finish()
	WFSendMail()

	RpcClearEnv()

Return


/*/{Protheus.doc} fAjustList
	Ajusta o Array com a lista de itens, concatenando devolução com venda
	@type Static Function
	@author Felipe Mayer
	@since 21/07/2021
	@version 1
	@param aListAtu, aListAux
	@return aListAtu
/*/
Static Function fAjustList(aListAtu,aListAux)

Local nPos := 0
Local nX   := 0

	For nX := 1 To Len(aListAux)
		nPos := AScan(aListAtu,{|x| AllTrim(x[1]) == aListAux[nX,1]})
		If nPos > 0
			Aadd(aListAtu[nPos],aListAux[nX,2])
			Aadd(aListAtu[nPos],aListAux[nX,3])
		Else
			Aadd(aListAtu,{aListAux[nX,1],0,0,0,aListAux[nX,2],aListAux[nX,3]})
		EndIf
	Next nX

	For nX := 1 To Len(aListAtu)
		If Len(aListAtu[nX]) < 6
			Aadd(aListAtu[nX],0)
			Aadd(aListAtu[nX],0)
		EndIf
	Next nX

Return aListAtu


/*/{Protheus.doc} QUERY1
	Query com a primeira consulta de vendas
	@type Static Function
	@author Felipe Mayer
	@since 21/07/2021
	@version 1
/*/
Static Function QUERY1()

Local cAliasSQL := GetNextAlias()
Local cQuery 	:= ""
Local aRet 		:= {}

	cQuery := CRLF + " SELECT DISTINCT "
	cQuery += CRLF + " 		TEMP.LOJA AS LOJA,  "
 	cQuery += CRLF + " 		ROUND(SUM(TEMP.QTDE_VEND),2) AS 'QTDE_VEND',  "
 	cQuery += CRLF + " 		ROUND(SUM(TEMP.TOTAL_SI),2) AS 'TOTAL_SI', "
 	cQuery += CRLF + " 		ROUND(SUM(TOTAL_CI),2) AS 'TOTAL_CI' "
 	cQuery += CRLF + " FROM ( "
 	cQuery += CRLF + " 		SELECT  "
 	cQuery += CRLF + " 			SA1.A1_COD + '-' + SA1.A1_LOJA + '-' + SA1.A1_NREDUZ AS 'LOJA',  "
 	cQuery += CRLF + " 			SD2.D2_COD 'PRODUTO', SB1.B1_DESC 'DESCRICAO', " 
 	cQuery += CRLF + " 			SD2.D2_PRCVEN 'PRC_VENDA', SD2.D2_QUANT 'QTDE_VEND', SD2.D2_TOTAL 'TOTAL_SI', SD2.D2_VALBRUT 'TOTAL_CI' "
  	cQuery += CRLF + " 		FROM "+RetSqlName('SA1')+" SA1  "
  	cQuery += CRLF + " 		JOIN "+RetSqlName('SD2')+" SD2 ON  "
 	cQuery += CRLF + " 			SD2.D2_FILIAL = '0072'  "
  	cQuery += CRLF + " 			AND SD2.D2_CLIENTE = SA1.A1_COD 	"
	cQuery += CRLF + " 			AND SD2.D2_LOJA = SA1.A1_LOJA  "
  	cQuery += CRLF + " 			AND SD2.D2_TIPO = 'N'  "
  	cQuery += CRLF + " 			AND SD2.D_E_L_E_T_ != '*'  "
  	cQuery += CRLF + " 		JOIN "+RetSqlName('SB1')+" SB1 ON   "
  	cQuery += CRLF + " 			SB1.B1_FILIAL = ''  "
  	cQuery += CRLF + " 			AND SB1.B1_COD = SD2.D2_COD  "
  	cQuery += CRLF + " 			AND SB1.D_E_L_E_T_ != '*'  "
  	cQuery += CRLF + " 		JOIN "+RetSqlName('SF4')+" SF4 ON  "
  	cQuery += CRLF + " 			SF4.F4_FILIAL = ''  "
  	cQuery += CRLF + " 			AND SF4.F4_CODIGO = SD2.D2_TES  "
  	cQuery += CRLF + " 			AND SF4.D_E_L_E_T_ != '*' "
  	cQuery += CRLF + " 		WHERE SA1.D_E_L_E_T_ != '*'  "
  	cQuery += CRLF + " 			AND SD2.D2_FILIAL = '0072'  "
  	cQuery += CRLF + " 			AND SF4.F4_DUPLIC = 'S'  "
	cQuery += CRLF + " 			AND SA1.A1_NATUREZ= '10107'  "
  	cQuery += CRLF + " 			AND SUBSTRING( SD2.D2_EMISSAO ,1,6 ) = '"+SubsTr( DToS(Date() - 1),1,6 )+"' ) TEMP  "
	cQuery += CRLF + " GROUP BY TEMP.LOJA "
	cQuery += CRLF + " ORDER BY 1 DESC "

	MPSysOpenQuery(cQuery,cAliasSQL)

	While (cAliasSQL)->(!EoF())
		Aadd(aRet,{;
			Alltrim((cAliasSQL)->LOJA),;
			(cAliasSQL)->QTDE_VEND,;
			(cAliasSQL)->TOTAL_SI,;
			(cAliasSQL)->TOTAL_CI})
		(cAliasSQL)->(DbSkip())
	EndDo

	(cAliasSQL)->(DbCloseArea())

Return aRet


/*/{Protheus.doc} QUERY2
	Query com a primeira consulta de devoluções
	@type Static Function
	@author Felipe Mayer
	@since 21/07/2021
	@param aList1
	@version 1
/*/
Static Function QUERY2(aList1)

Local cAliasSQL := GetNextAlias()
Local cQuery 	:= ""
Local aRet 		:= {}

	cQuery := CRLF + " SELECT DISTINCT "
	cQuery += CRLF + " 		SA1.A1_COD + '-' + SA1.A1_LOJA + '-' + SA1.A1_NREDUZ AS 'LOJA', "
	cQuery += CRLF + " 		ISNULL(ROUND(SUM(SD1.D1_QUANT),2),0) AS QTDE_DEV,"
	cQuery += CRLF + " 		ISNULL(ROUND(SUM(SD1.D1_TOTAL + SD1.D1_VALIPI + SD1.D1_ICMSRET - SD1.D1_VALDESC),2),0) AS TOTAL_DEV "
	cQuery += CRLF + " FROM "+RetSqlName('SD1')+" SD1 "
	cQuery += CRLF + " INNER JOIN "+RetSqlName('SA1')+" SA1 "
	cQuery += CRLF + " 		ON A1_COD=D1_FORNECE "
	cQuery += CRLF + " 		AND A1_LOJA=D1_LOJA "
	cQuery += CRLF + " 		AND A1_NATUREZ='10107' "
	cQuery += CRLF + " INNER JOIN "+RetSqlName('SB1')+" SB1 "
	cQuery += CRLF + " 		ON B1_COD=D1_COD "
	cQuery += CRLF + " WHERE SD1.D_E_L_E_T_ != '*' "
	cQuery += CRLF + " 		AND D1_FILIAL='0072' "
	cQuery += CRLF + " 		AND D1_NFORI!='' "
	cQuery += CRLF + " 		AND SUBSTRING( SD1.D1_EMISSAO ,1,6 ) = '"+SubsTr( DToS(Date() - 1),1,6 )+"' "
	cQuery += CRLF + " GROUP BY SA1.A1_COD + '-' + SA1.A1_LOJA + '-' + SA1.A1_NREDUZ "

	MPSysOpenQuery(cQuery,cAliasSQL)

	While (cAliasSQL)->(!EoF())
		Aadd(aRet,{;
			Alltrim((cAliasSQL)->LOJA),;
			(cAliasSQL)->QTDE_DEV,;
			(cAliasSQL)->TOTAL_DEV})
		(cAliasSQL)->(DbSkip())
	EndDo

	(cAliasSQL)->(DbCloseArea())

	aRet := fAjustList(aList1,aRet)

Return aRet


/*/{Protheus.doc} QUERY3
	Query com a segunda consulta de vendas
	@type Static Function
	@author Felipe Mayer
	@since 21/07/2021
	@version 1
/*/
Static Function QUERY3()

Local cAliasSQL := GetNextAlias()
Local cQuery 	:= ""
Local aRet 		:= {}

	cQuery := CRLF + " 	SELECT DISTINCT "
	cQuery += CRLF + " 		CLIENTE,  "
	cQuery += CRLF + " 		ROUND(SUM(TEMP.QTDE_VEND),2) AS 'QTDE_VEND',  "
	cQuery += CRLF + " 		ROUND(SUM(TEMP.TOTAL_SI),2) AS 'TOTAL_SI',  "
	cQuery += CRLF + " 		ROUND(SUM(TOTAL_CI),2) AS 'TOTAL_CI' "
	cQuery += CRLF + " 	FROM (  "
	cQuery += CRLF + " 	SELECT  "
	cQuery += CRLF + " 		ACY.ACY_DESCRI AS 'CLIENTE', "
	cQuery += CRLF + " 		SD2.D2_COD 'PRODUTO', SB1.B1_DESC 'DESCRICAO', "
	cQuery += CRLF + " 		SD2.D2_PRCVEN 'PRC_VENDA', SD2.D2_QUANT 'QTDE_VEND', SD2.D2_TOTAL 'TOTAL_SI', SD2.D2_VALBRUT 'TOTAL_CI' "
	cQuery += CRLF + " 	FROM "+RetSqlName('SA1')+" SA1 "
	cQuery += CRLF + " 	JOIN "+RetSqlName('SD2')+" SD2 "
	cQuery += CRLF + " 		ON SD2.D2_FILIAL = '0072' "
	cQuery += CRLF + " 	 	AND SD2.D2_CLIENTE = SA1.A1_COD "
	cQuery += CRLF + " 		AND SD2.D2_LOJA = SA1.A1_LOJA "
	cQuery += CRLF + " 		AND SD2.D2_TIPO = 'N' "
	cQuery += CRLF + " 		AND SD2.D_E_L_E_T_ != '*' "
	cQuery += CRLF + " 	JOIN "+RetSqlName('SB1')+" SB1 "
	cQuery += CRLF + " 		ON SB1.B1_FILIAL = '' "
	cQuery += CRLF + " 		AND SB1.B1_COD = SD2.D2_COD "
	cQuery += CRLF + "  	AND SB1.D_E_L_E_T_ != '*' "
	cQuery += CRLF + " 	JOIN "+RetSqlName('SF4')+" SF4 "
	cQuery += CRLF + " 		ON SF4.F4_FILIAL = '' "
	cQuery += CRLF + " 		AND SF4.F4_CODIGO = SD2.D2_TES "
	cQuery += CRLF + " 		AND SF4.D_E_L_E_T_ != '*' "
	cQuery += CRLF + " 	LEFT JOIN "+RetSqlName('ACY')+" ACY "
	cQuery += CRLF + " 		ON ACY.ACY_FILIAL = '' "
	cQuery += CRLF + " 		AND ACY.ACY_GRPVEN = SA1.A1_GRPVEN "
	cQuery += CRLF + " 		AND ACY.D_E_L_E_T_ != '*' "
	cQuery += CRLF + " 	WHERE SA1.D_E_L_E_T_ != '*'  "
	cQuery += CRLF + " 		AND SD2.D2_FILIAL = '0072' "
	cQuery += CRLF + " 		AND SF4.F4_DUPLIC = 'S' "
	cQuery += CRLF + " 		AND SA1.A1_NATUREZ= '10107'  "
	cQuery += CRLF + " 		AND SUBSTRING( SD2.D2_EMISSAO ,1,6 ) = '"+SubsTr( DToS(Date() - 1),1,6 )+"' ) TEMP "
	cQuery += CRLF + " 	GROUP BY CLIENTE "
	cQuery += CRLF + " 	ORDER BY 1 DESC "

	MPSysOpenQuery(cQuery,cAliasSQL)

	While (cAliasSQL)->(!EoF())
		Aadd(aRet,{;
			Alltrim((cAliasSQL)->CLIENTE),;
			(cAliasSQL)->QTDE_VEND,;
			(cAliasSQL)->TOTAL_SI,;
			(cAliasSQL)->TOTAL_CI})
		(cAliasSQL)->(DbSkip())
	EndDo

	(cAliasSQL)->(DbCloseArea())

Return aRet


/*/{Protheus.doc} QUERY4
	Query com a segunda consulta de devoluções
	@type Static Function
	@author Felipe Mayer
	@since 21/07/2021
	@param aList2
	@version 1
/*/
Static Function QUERY4(aList2)

Local cAliasSQL := GetNextAlias()
Local cQuery 	:= ""
Local aRet 		:= {}

	cQuery := CRLF + " SELECT DISTINCT
	cQuery += CRLF + " 		ACY.ACY_DESCRI AS 'CLIENTE', 
	cQuery += CRLF + " 		ISNULL(ROUND(SUM(SD1.D1_QUANT),2),0) AS 'QTDE_DEV',
	cQuery += CRLF + " 		ISNULL(ROUND(SUM(SD1.D1_TOTAL + SD1.D1_VALIPI + SD1.D1_ICMSRET - SD1.D1_VALDESC),2),0) AS 'TOTAL_DEV'
	cQuery += CRLF + " 	FROM "+RetSqlName('SD1')+" SD1
	cQuery += CRLF + " 		INNER JOIN "+RetSqlName('SA1')+" SA1 
	cQuery += CRLF + " 			ON A1_COD=D1_FORNECE 
	cQuery += CRLF + " 			AND A1_LOJA=D1_LOJA 
	cQuery += CRLF + " 			AND A1_NATUREZ='10107'
	cQuery += CRLF + " 			AND SA1.D_E_L_E_T_ != '*'
	cQuery += CRLF + " 		LEFT JOIN "+RetSqlName('ACY')+" ACY 
	cQuery += CRLF + " 			ON ACY.ACY_FILIAL = ''
	cQuery += CRLF + " 			AND ACY.ACY_GRPVEN = SA1.A1_GRPVEN 
	cQuery += CRLF + " 			AND ACY.D_E_L_E_T_ != '*' 
	cQuery += CRLF + " 		INNER JOIN "+RetSqlName('SB1')+" SB1 
	cQuery += CRLF + " 			ON B1_COD=D1_COD
	cQuery += CRLF + " 	WHERE SD1.D_E_L_E_T_ != '*'
	cQuery += CRLF + " 		AND D1_FILIAL='0072'
	cQuery += CRLF + " 		AND D1_NFORI!=''
	cQuery += CRLF + " 		AND SUBSTRING( SD1.D1_EMISSAO ,1,6 ) = '"+SubsTr( DToS(Date() - 1),1,6 )+"' "
	cQuery += CRLF + " 	GROUP BY ACY.ACY_DESCRI

	MPSysOpenQuery(cQuery,cAliasSQL)

	While (cAliasSQL)->(!EoF())
		Aadd(aRet,{;
			Alltrim((cAliasSQL)->CLIENTE),;
			(cAliasSQL)->QTDE_DEV,;
			(cAliasSQL)->TOTAL_DEV})
		(cAliasSQL)->(DbSkip())
	EndDo

	(cAliasSQL)->(DbCloseArea())

	aRet := fAjustList(aList2,aRet)

Return aRet
