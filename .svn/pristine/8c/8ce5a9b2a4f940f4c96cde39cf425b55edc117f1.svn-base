#Include "Totvs.ch"
#Include "ap5mail.ch"

/*/{Protheus.doc} JOBZZ6
    @Desc Job para apontamento de Consumo/Producao automatico
    @type User Function
    @author Douglas Silva / Reinaldo / Felipe Mayer
    @since 07/06/2021
/*/
User Function JOBZZ6()

Local _cJob := ""
Local aFil  := u_GETFIL()
Local nX    := 0

    For nX := 1 To Len(aFil)
        If aScan(aFil, {|x| AllTrim(x) == StrZero(nX,4)}) > 0
            u_GRAVFIL(StrZero(nX,4),@_cJob)
        EndIf
    Next nX

Return

/*/{Protheus.doc} GETFIL
    @Desc abre ambiente para retorno de filiais e depois fecha
    @type User Function
    @author Felipe Mayer
    @since 07/06/2021
/*/
User Function GETFIL()

    RPCSetType(3) 
    RpcSetEnv('01','0101',,,,GetEnvServer(),{ })
    
    aFil := FWAllFilial()

    RpcClearEnv()

Return aFil


/*/{Protheus.doc} GRAVFIL
    @Desc abre ambiente filial por filial e chama apontamentos
    @type User Function
    @author Douglas Silva / Reinaldo / Felipe Mayer
    @since 07/06/2021
/*/
User Function GRAVFIL(__cFil,_cJob)

Local cQuery := ''

    RpcSetEnv('01',__cFil,,,,GetEnvServer(),{ })

    Conout("Inicio do Processamento Data " + DToC( Date() ) + " Hora " + Time())

    /*_cJob := "JOBZZ6"
    _oLocker := LJCGlobalLocker():New()

    If !_oLocker:GetLock(_cJob)
        Conout(" * * " + DToC(dDataBase) + " " + Time() + " - <<< " + _cJob + " >>> Processo ja esta em execucao.")
        Return
    EndIf*/    

    dbSelectArea('SC2')
    dbSelectArea("ZZ6")
    ZZ6->(dbSetOrder(1))

    cAliasSQL := GetNextAlias()

    cQuery := " SELECT ZZ6.* FROM "+RetSQLName('ZZ6')+" ZZ6 "
    cQuery += " INNER JOIN "+RetSQLName('SB1')+" SB1 ON "
    cQuery += "	B1_FILIAL='"+xFilial('SB1')+"' "
    cQuery += "	AND B1_COD=ZZ6_PROD "
    cQuery += "	AND B1_MSBLQL!='1'	"
    cQuery += "	AND SB1.D_E_L_E_T_!='*' "
    cQuery += " WHERE ZZ6.D_E_L_E_T_!='*' "
    cQuery += "	AND ZZ6_OPERP=' ' "
    cQuery += "	AND ZZ6_FILIAL='"+__cFil+"' "
    cQuery += "ORDER BY ZZ6_DATA,ZZ6_TIPO "
    
    MPSysOpenQuery(cQuery,cAliasSQL)

    While (cAliasSQL)->(!EoF())

        ZZ6->(dbSeek((cAliasSQL)->ZZ6_FILIAL+(cAliasSQL)->ZZ6_LOCAL+(cAliasSQL)->ZZ6_PROD+(cAliasSQL)->ZZ6_DATA))

        If (cAliasSQL)->ZZ6_TIPO == 'P'
            _cNumOP := GerOP()

            If SToD((cAliasSQL)->ZZ6_DATA) > GetMV('MV_ULMES')
                AponOP(_cNumOP)
            EndIf
        ElseIf (cAliasSQL)->ZZ6_TIPO == 'C' .And. SToD((cAliasSQL)->ZZ6_DATA) > GetMV('MV_ULMES')
            OPConsumo()
        EndIf

        (cAliasSQL)->(DbSkip())
    EndDo

    (cAliasSQL)->(dbCloseArea())
    ZZ6->(dbCloseArea())
    SC2->(dbCloseArea())

    //_oLocker:ReleaseLock(_cJob)

    RpcClearEnv()

Return


/*/{Protheus.doc} GerOP
    @Desc gera ordem de producao na SC2
    @type Static Function
    @author Douglas Silva / Reinaldo / Felipe Mayer
    @since 07/06/2021
/*/
Static Function GerOP()

Local aMATA650 := {}
Local aLogAuto := {}
Local nOpc     := 3
Local nX       := 0
Local cLogTxt  := ''
Local _cNumOP  := GetNumSc2()

Private lMSHelpAuto     := .T.
Private lAutoErrNoFile  := .T.
Private lMsErroAuto     := .F.

    If ZZ6->ZZ6_QUANT > 0
        aMata650  := {;  
            {'C2_FILIAL'   ,ZZ6->ZZ6_FILIAL         ,NIL},;
            {'C2_NUM'      ,_cNumOP                 ,NIL},;
            {'C2_ITEM'     ,"01"                    ,NIL},;
            {'C2_SEQUEN'   ,"001"                   ,NIL},;
            {'C2_PRODUTO'  ,ZZ6->ZZ6_PROD           ,NIL},;
            {'C2_LOCAL'    ,ZZ6->ZZ6_LOCAL          ,NIL},;
            {'C2_CC'       ,ZZ6->ZZ6_LOCAL          ,NIL},;
            {'C2_PRIOR'    ,"500"                   ,NIL},;
            {'C2_QUANT'    ,ZZ6->ZZ6_QUANT          ,NIL} }
        
        SC2->(dbSetOrder(1))
        If !SC2->(DbSeek(xFilial("SC2")+ _cNumOP + "01"+"001"))

            dDataBAse := ZZ6->ZZ6_DATA //Troco database para criação OP

            msExecAuto({|x,Y| Mata650(x,Y)},aMata650,nOpc)

            If lMsErroAuto
                aLogAuto := GetAutoGRLog()
                cTitErr  := "Erro na geração da OP"

                For nX := 1 To Len(aLogAuto)
                    cLogTxt += aLogAuto[nX]+'<br>'
                Next nX
                
                cLogTxt += '<b>Parâmetros de Execução:</b><br>'

                For nX := 1 To Len(aMata650)
                    cLogTxt += aMata650[nX,1]+' - '+cValToChar(aMata650[nX,2])+'<br>'
                Next nX

                EnvLgErr(cTitErr,cLogTxt)
            Else           
                RecLock('ZZ6',.F.)
                    ZZ6->ZZ6_OPERP := cValToChar(SC2->(Recno()))
                ZZ6->(MsUnLock())
            EndIf
        EndIf

        dDataBAse := Date() //Volto a data base
    Else
        RecLock('ZZ6',.F.)
            ZZ6->ZZ6_OPERP := 'Qtd Zerada'
        ZZ6->(MsUnLock()) 
    EndIf
 
Return(_cNumOP)


/*/{Protheus.doc} AponOP
    @Desc Faz apontamento de producao na SD3
    @type Static Function
    @author Douglas Silva / Reinaldo / Felipe Mayer
    @since 07/06/2021
/*/
Static Function AponOP(_cNumOP)

Local aVetor    := {}  
Local aLogAuto  := {}       
Local nOpc      := 3
Local cLogTxt   := ''

Private lMSHelpAuto     := .T.
Private lAutoErrNoFile  := .T.
Private lMsErroAuto     := .F.  

    aVetor := {; 
        {"D3_TM"     ,"100"                  ,NIL},;
        {"D3_COD"    ,ZZ6->ZZ6_PROD          ,NIL},;
        {"D3_OP"     ,_cNumOP+"01001"        ,NIL},;
        {"D3_LOCAL"  ,ZZ6->ZZ6_LOCAL         ,NIL},;
        {"D3_CC"     ,ZZ6->ZZ6_LOCAL         ,NIL} }     

    dDataBAse := ZZ6->ZZ6_DATA //Troco database para criação OP
    
    MSExecAuto({|x, y| mata250(x, y)},aVetor, nOpc ) 

    If lMsErroAuto
        aLogAuto := GetAutoGRLog()
        cTitErr  := "Erro no apontamento da OP"

        For nX := 1 To Len(aLogAuto)
            cLogTxt += aLogAuto[nX]+'<br>'
        Next nX
        
        cLogTxt += '<b>Parâmetros de Execução:</b><br>'

        For nX := 1 To Len(aVetor)
            cLogTxt += aVetor[nX,1]+' - '+cValToChar(aVetor[nX,2])+'<br>'
        Next nX

        EnvLgErr(cTitErr,cLogTxt)
    Else     
        RecLock('ZZ6',.F.)
            ZZ6->ZZ6_OPERP := "A" + Alltrim(ZZ6->ZZ6_OPERP)
        ZZ6->(MsUnLock())

        //Gravo via Recklock pois o execauto nao esta gravando
        RecLock('SD3',.F.)
            SD3->D3_LOCAL := ZZ6->ZZ6_LOCAL  
        SD3->(MsUnLock())
    EndIf

    dDataBAse := Date() //volta a data base

Return


/*/{Protheus.doc} OPConsumo
    @Desc Faz apontamento de consumo na SD3
    @type Static Function
    @author Douglas Silva / Reinaldo / Felipe Mayer
    @since 07/06/2021
/*/
Static Function OPConsumo()

Local aItem     := {}
Local aLogAuto  := {}
Local nOpc      := 3
Local cLogTxt   := ''

Private lMSHelpAuto     := .T.
Private lAutoErrNoFile  := .T.
Private lMsErroAuto     := .F.

    If ZZ6->ZZ6_QUANT > 0
        aItem := {;
            {"D3_FILIAL" , ZZ6->ZZ6_FILIAL  ,NIL},;
            {"D3_TM"     , "502"            ,NIL},;
            {"D3_COD"    , ZZ6->ZZ6_PROD    ,NIL},;
            {"D3_QUANT"  , ZZ6->ZZ6_QUANT   ,NIL},;
            {"D3_LOCAL"  , ZZ6->ZZ6_LOCAL   ,NIL},;
            {"D3_CC"     , ZZ6->ZZ6_LOCAL   ,NIL},;
            {"D3_DOC"    , ZZ6->ZZ6_OP      ,NIL},;
            {"D3_EMISSAO", ZZ6->ZZ6_DATA    ,NIL} }
            
        dDataBAse := ZZ6->ZZ6_DATA //Troca database para criação OP

        MSExecAuto({|x,y| mata240(x,y)},aItem,nOpc)

        If lMsErroAuto
            aLogAuto := GetAutoGRLog()
            cTitErr  := "Erro no apontamento de Consumo"

            For nX := 1 To Len(aLogAuto)
                cLogTxt += aLogAuto[nX]+'<br>'
            Next nX
            
            cLogTxt += '<b>Parâmetros de Execução:</b><br>'

            For nX := 1 To Len(aItem)
                cLogTxt += aItem[nX,1]+' - '+cValToChar(aItem[nX,2])+'<br>'
            Next nX

            EnvLgErr(cTitErr,cLogTxt)
        Else
            RecLock('ZZ6',.F.)
                ZZ6->ZZ6_OPERP := cValToChar(SD3->(Recno()))
            ZZ6->(MsUnLock())
        EndIf
    Else
        RecLock('ZZ6',.F.)
            ZZ6->ZZ6_OPERP := 'Qtd Zerada'
        ZZ6->(MsUnLock())
    EndIf

    dDataBAse := Date() //volta data base

Return


/*/{Protheus.doc} EnvLgErr
    @Desc Envio de log error por email
    @type Static Function
    @author Felipe Mayer
    @since 07/06/2021
/*/
Static Function EnvLgErr(cTitErr,cLogTxt)

Local cEmailCom := AllTrim(SuperGetMv("MV_WFLGERR",,"suporte@bdil.com.br"))
Local cProcWF 	:= 'EXLGER' 
Local cStatusWF := '10001'
Local lProcWF	:= WF1->(DbSeek(xFilial("WF1")+cProcWF))
Local lStatusWF := WF2->(DbSeek(xFilial("WF2")+WF1->WF1_COD+cStatusWF))	

	If !lProcWF
		Conout("Processo "+cProcWF+" do WorkFlow nao cadastrado!","Erro")
		Return
	EndIf

	If !lStatusWF
		Conout("Status "+cStatusWF+" do processo do "+cProcWF+" do WorkFlow nao cadastrado!","Erro")
		Return
	EndIf
	
	If Empty(cEmailCom)
		Conout("Parametro nao preenchido com email destino","MV_WFLGERR")
		Return	
	EndIf

	oProcess := TWFProcess():New(cProcWF,"LOG ERRO EXECAUTO JOBPROD")  
	oProcess :NewTask("LOG ERRO EXECAUTO JOBPROD","\WORKFLOW\WFLGERR.htm")
	oHtml := oProcess:oHTML

	oHtml:ValByName("cDadosT" ,cTitErr)
	oHtml:ValByName("cDados1" ,cLogTxt)

	oHtml := oProcess:oHTML
		
	oProcess:cSubject := 'JOBPROD - '+cTitErr
	oProcess:cTo := cEmailCom

	oProcess:Start()		
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,WF1->WF1_COD,WF2->WF2_STATUS,"Email enviado com sucesso")
	
	oProcess:Finish()
	WFSendMail()

Return
