#Include 'Totvs.ch'

/*/{Protheus.doc} BDWFFAT3
    @Desc Envio de vendas di?rias por email
    @type User Function
    @author Felipe Mayer
    @since 06/07/2021
/*/
User Function BDWFFAT3()

RPCSetType(3) 
RpcSetEnv('01','0101',,,,GetEnvServer(),{ }) 

cProcWF   := 'WFVDSD' 
cStatusWF := '10001'
cTitle    := 'VENDAS DIARIAS'	
cAliasSQL := GetNextAlias() 

	If !WF1->(DbSeek(xFilial("WF1")+cProcWF))
		Conout("Processo "+cProcWF+" do WorkFlow nao cadastrado!","Erro")
		Return
	EndIf

	If !WF2->(DbSeek(xFilial("WF2")+WF1->WF1_COD+cStatusWF))
		Conout("Status "+cStatusWF+" do processo do "+cProcWF+" do WorkFlow nao cadastrado!","Erro")
		Return
	EndIf

    cQuery := CRLF + "  WITH DIA1 AS ( "
    cQuery += CRLF + "  SELECT PIN1.PIN_FILIAL FILIAL, "
    cQuery += CRLF + "  	PIN1.PIN_LOJA LOJA, "
    cQuery += CRLF + "  	PIN1.PIN_EMISSA EMISSA, "
    cQuery += CRLF + "  	ROUND(SUM(PIO_QUANT*PIO_VRUNIT),2) VALOR1 "
    cQuery += CRLF + "  FROM "+RetSqlName('PIN')+" PIN1 "
    cQuery += CRLF + "  	INNER JOIN "+RetSqlName('PIO')+" PIO ON "
    cQuery += CRLF + "  		PIO_CHVORI=PIN_CHVORI "
    cQuery += CRLF + "  		AND PIO.D_E_L_E_T_!='*' "
    cQuery += CRLF + "  WHERE PIN1.D_E_L_E_T_!='*' "
    cQuery += CRLF + "  	AND PIN_EMISSA='"+DToS(Date()-2)+"' "
    cQuery += CRLF + "  GROUP BY PIN1.PIN_FILIAL,PIN1.PIN_LOJA,PIN1.PIN_EMISSA) "
    cQuery += CRLF + "  SELECT PIN.PIN_LOJA LOJA2, "
    cQuery += CRLF + "  	CTT_DESC01 DESCL, "
    cQuery += CRLF + "  	D1.EMISSA EMISSA1, "
    cQuery += CRLF + "  	D1.VALOR1 VALOR1, "
    cQuery += CRLF + "  	PIN.PIN_EMISSA EMISSA2, "
    cQuery += CRLF + "  	ROUND(SUM(PIO_QUANT*PIO_VRUNIT),2) VALOR2 "
    cQuery += CRLF + "  FROM "+RetSqlName('PIN')+" PIN "
    cQuery += CRLF + "  	INNER JOIN DIA1 D1 ON  "
    cQuery += CRLF + "  		D1.FILIAL=PIN_FILIAL "
    cQuery += CRLF + "  		AND D1.LOJA=PIN_LOJA "
    cQuery += CRLF + "  	INNER JOIN "+RetSqlName('PIO')+" PIO ON "
    cQuery += CRLF + "  		PIO_CHVORI=PIN_CHVORI "
    cQuery += CRLF + "  		AND PIO.D_E_L_E_T_!='*' "
    cQuery += CRLF + "  	INNER JOIN "+RetSqlName('CTT')+" CTT ON "
    cQuery += CRLF + "  		CTT_CUSTO=PIN_LOJA "
    cQuery += CRLF + "  		AND CTT.D_E_L_E_T_!='*' "
    cQuery += CRLF + "  WHERE PIN.D_E_L_E_T_!='*' "
    cQuery += CRLF + "  	AND PIN_EMISSA='"+DToS(Date()-1)+"' "
    cQuery += CRLF + "  GROUP BY PIN_LOJA,CTT_DESC01,PIN_EMISSA,D1.VALOR1,D1.EMISSA "
    cQuery += CRLF + "  ORDER BY PIN_LOJA "

    MPSysOpenQuery(cQuery,cAliasSQL)

	oProcess := TWFProcess():New(cProcWF,cTitle)  
	oProcess :NewTask(cTitle,"\WORKFLOW\WFVENDAS.htm")
	oHtml := oProcess:oHTML

    While (cAliasSQL)->(!EoF())
        aAdd((oHtml:ValByName("it.cDados1")),Alltrim((cAliasSQL)->DESCL))
        aAdd((oHtml:ValByName("it.cDados2")),DToC(SToD((cAliasSQL)->EMISSA1)))
        aAdd((oHtml:ValByName("it.cDados3")),cValToChar((cAliasSQL)->VALOR1))
        aAdd((oHtml:ValByName("it.cDados4")),DToC(SToD((cAliasSQL)->EMISSA2)))
        aAdd((oHtml:ValByName("it.cDados5")),cValToChar((cAliasSQL)->VALOR2))
        (cAliasSQL)->(DbSkip())
    EndDo

    (cAliasSQL)->(DbCloseArea())

	oHtml := oProcess:oHTML
		
	oProcess:cSubject := 'BDWFFAT3 - '+Capital(cTitle)
	oProcess:cTo := 'sistemas@bdil.com.br;t1.suporte@bdil.com.br'

	oProcess:Start()		
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,WF1->WF1_COD,WF2->WF2_STATUS,"Email enviado com sucesso")
	
	oProcess:Finish()
	WFSendMail()

    RpcClearEnv()

Return
