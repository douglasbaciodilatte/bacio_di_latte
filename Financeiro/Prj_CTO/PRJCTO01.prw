//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'

/*/{Protheus.doc} User Function PRJCTO01
    (long_description)
    @type  Function
    @author user
    @since 19/08/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function PRJCTO01()
    
    
    Local aPergs 	 := {}
    Local cCaminho  := Space(90)
    Local aRet      := {}

    aAdd( aPergs ,{6,"Diretorio do Arquivo?"	,cCaminho	,"@!",,'.T.',80,.F.,"Arquivos .xlsx |*.csv " }) 
   
    If ParamBox(aPergs ,"Parametros ",aRet)
        processa( {|| ImporCSV(MV_PAR01) } ,'Aguarde Efetuando Importacao da Planilha' )
    EndIf
       
Return 

Static Function ImporCSV(cFile)

    Local cLinha
    Local lPrim     := .T.
    Local aCampos   := {}
    Local aDados    := {}
    Local aArray    := {}
    //Local aTitulo   := {}
    Local aAuxEv    := {}
    //Local aRatEz    := {} 
    Local ARATEVEZ  := {}

    Private lMsErroAuto := .F.   

   	If ! Empty(cFile) 

		FT_FUSE(cFile)
		ProcRegua(FT_FLASTREC())
		FT_FGOTOP()
		While !FT_FEOF()
			
			IncProc("Selecionando Registros...")
	 
			cLinha := FT_FREADLN()
			
			If lPrim
				aCampos := Separa(cLinha,";",.T.)
				lPrim := .F.
			Else
				AADD(aDados,Separa(cLinha,";",.T.))
							
			EndIf
			
			FT_FSKIP()
		EndDo

    EndIf


     //Efetua leitura dos dados
    ProcRegua( Len(aDados) )

        For i := 1 to Len(aDados) //Leitura do Array 

            IncProc("Importando Títulos...")

            If i != 1

                //Procura fornecedor
                SA2->(DBSelectArea("SA2"))
                SA2->(dbSetOrder(1))
                If SA2->(dbSeek(xFilial(xFilial("SA2")) + aDados[i][4] ) )


                    //Adicionando o vetor da natureza
                        
                    nCnt := 0

                    //Valor Total Título:

                    _nTValor   := VAL(STRTRAN(STRTRAN(aDados[i][43], ".",""),",","."))
                    _nDesc     := VAL(STRTRAN(STRTRAN(aDados[i][35], ".",""),",","."))
                    aRatEvEz    := {}

                    For nCnt := 15 To 33
                        
                        If Val(aDados[i][nCnt]) != 0 
                            
                            aAuxEv:={}

                            _nRValor := VAL(STRTRAN(STRTRAN(aDados[i][nCnt], ".",""),",","."))

                            aadd( aAuxEv ,{"EV_NATUREZ"     , padr( aDados[1][nCnt] ,tamsx3("EV_NATUREZ")[1]), Nil })//natureza a ser rateada
                            aadd( aAuxEv ,{"EV_VALOR"       , _nRValor , Nil })//valor do rateio na natureza
                            aadd( aAuxEv ,{"EV_PERC"        , _nRValor / _nTValor * 100 , Nil })//percentual do rateio na natureza
                            aadd( aAuxEv ,{"EV_RATEICC"     , "2", Nil })//indicando que há rateio por centro de custo
                            
                            aAdd(aRatEvEz,aAuxEv)//adicionando a natureza ao rateio de multiplas naturezas

                            /*
                            aAuxEz:={}
                            aadd( aAuxEz ,{"EZ_CCUSTO"  ,  aDados[i][2], Nil })//centro de custo da natureza
                            aadd( aAuxEz ,{"EZ_VALOR"   , Val(aDados[i][nCnt]), Nil })//valor do rateio neste centro de custo
                            aadd(aRatEz,aAuxEz)

                            aadd(aAuxEv,{"AUTRATEICC" , aRatEz, Nil })//recebendo dentro do array da natureza os multiplos centros de custo    
                            */

                        EndIf

                    Next nCnt  

                    SE2->(dbSelectArea("SE2"))                           
                    SE2->(dbSetOrder(1)) //E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA
                    If SE2->(dbSeek( xFilial("SE2") + "CO " + aDados[i][11] + " " + aDados[i][12] + " " + aDados[i][8] + " " + SA2->A2_COD + SA2->A2_LOJA  ))
                        Alert("ATENÇÃO: Titulo em duplicidade na base " + aDados[i][11] + " Parcela " + aDados[i][12]  )
                    Else
                       
                        aArray := { { "E2_FILORIG"  , aDados[i][1]      , NIL },;
                                    { "E2_PREFIXO"  , "CO"              , NIL },;
                                    { "E2_NUM"      , aDados[i][11]     , NIL },;
                                    { "E2_TIPO"     , aDados[i][8]      , NIL },;
                                    { "E2_PARCELA"  , aDados[i][12]     , NIL },;
                                    { "E2_NATUREZ"  , aDados[i][5]      , NIL },;
                                    { "E2_CCUSTO"   , aDados[i][2]      , NIL },;
                                    { "E2_FORNECE"  , SA2->A2_COD       , NIL },;
                                    { "E2_LOJA"     , SA2->A2_LOJA       , NIL },;
                                    { "E2_EMISSAO"  , CtoD(aDados[i][13]), NIL },;
                                    { "E2_VENCTO"   , CtoD(aDados[i][14]), NIL },;
                                    { "E2_VENCREA"  , CtoD(aDados[i][14]), NIL },;
                                    { "E2_EMIS1"    , CtoD(aDados[i][13]), NIL },;
                                    { "E2_HIST"     ,"CUSTOS DE OCUPACAO", NIL },;
                                    { "E2_CODBAR"   ,aDados[i][37]       , NIL },;
                                    { "E2_FORBCO"   ,aDados[i][38]       , NIL },;
                                    { "E2_FORAGE"   ,aDados[i][39]       , NIL },;                                    
                                    { "E2_FORCTA"   ,SUBSTR( Alltrim(aDados[i][40]), 1, ( LEN(Alltrim(aDados[i][40])) ) - 2) , NIL },;
                                    { "E2_FCTADV"   ,SUBSTR( Alltrim(aDados[i][40]), ( LEN(Alltrim(aDados[i][40])) ), 1) , NIL },;
                                    { "E2_MULTNAT"  ,'1'       , NIL },;
                                    { "E2_DECRESC" ,_nDesc       , NIL },;
                                    { "E2_SDDECRE" ,_nDesc       , NIL },;                                    
                                    { "E2_VALOR"   ,_nTValor + _nDesc , NIL } }                              
                                                                                                
                                    aAdd(aArray,{"AUTRATEEV",ARatEvEz,Nil})//adicionando ao vetor aArray o vetor do rateio
                                                                                
                            MsExecAuto( { |x,y,z| FINA050(x,y,z)}, aArray,, 3)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão 

                            If lMsErroAuto
                                MostraErro()
                            Else   
                                MsgInfo("Título incluído com sucesso: " + aDados[i][11] + " Parcela " + aDados[i][12] ,"Importação CTO")    
                            Endif   

                            lMsErroAuto := .F.                              
                    EndIf            
                Else
                    Alert("ATENÇÃO: Verifique codigo do fornecedor linha " + cValTochar(i))
                EndIf
                
            EndIf

        Next i

Return
