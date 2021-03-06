#Include "TOTVS.ch"
#Include "FWMVCDEF.ch"

/*/{Protheus.doc} User Function DBCTE001
    (long_description)
    @type  Function
    @author Douglas Rodrigues da Silva
    @since 15/07/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function DBCTE001()

    Local aPergs 	 := {}
    Local cCaminho  := Space(90)
    Local aRet      := {}

    Private cCentCust := ''

    aAdd( aPergs ,{6,"Diretorio do Arquivo?"	,cCaminho	,"@!",,'.T.',80,.F.,"Arquivo...|*.txt " })

    If cFilAnt == '0072'
        aAdd( aPergs ,{1,"Centro de Custo" ,Space(TamSx3('NNT_LOCLD')[1]),"",".T.","NNT",".T.",50,.T.})
    EndIf
    
    If ParamBox(aPergs ,"Parametros ",aRet)
        cCentCust := Iif(cFilAnt=='0072',MV_PAR02,'')
        processa( {|| Importxt(MV_PAR01) } ,'Aguarde Efetuando Importacao da Planilha' )
    EndIf


RETURN

Static Function Importxt(cFile)

    Local aDados    := {}
    Local aItens
    Local aCabec    := {}
    Local aItem     := {}
    Local aAux      := {}
    Local nX
    Local i
    Local lMsErroAuto := .F.
    Local _cChav
    Private cCCG := ""

   	If ! Empty(cFile) 

		FT_FUSE(cFile)
		ProcRegua(FT_FLASTREC())
		FT_FGOTOP()
		
        While !FT_FEOF()
			
			IncProc("Selecionando Registros...")
	 
			cLinha := FT_FREADLN()
            
            //Guarda CNPJ fornecedor CT-e
            If SUBSTR(cLinha,1,3) == "351"
                cCCG    := SUBSTR(cLinha,4,14)
            EndIf

            // Importa Linha DOCCOB 3.6
            If SUBSTR(cLinha,1,3) == "353"
            		    
                AADD(aDados, { SUBSTR(cLinha,14,5) , SUBSTR(cLinha,19,12) } )

            EndIf    
							
			FT_FSKIP()
		EndDo

    EndIf


      //Efetua leitura dos dados
    ProcRegua( Len(aDados) )
           
        For i := 1 to Len(aDados)  //Leitura do Array importacao dos dados

            //Limpa cabe?alho de nota
            aCabec  := {}
            aItens  := {}
            nX      := 1
            aItem   := {}
            
            //Monta numero da nota
            cNumNota := STRZERO(Val(aDados[i][1]),3) + STRZERO(Val(aDados[i][2]),9) + "  " 

            //Busca Nota Fiscal Central XML
            cQuery := " SELECT * FROM RECNFCTE A JOIN RECNFCTEITENS B ON B.XIT_CHAVE = A.XML_CHAVE AND B.D_E_L_E_T_ != '*' WHERE A.XML_NUMNF LIKE '"+cNumNota+"' AND A.XML_EMIT = "+cCCG+" AND A.D_E_L_E_T_ != '*' "

            DBUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),"SQL",.F.,.T.)

            Do While SQL->(!EOF())
                
                //Busca fornecedor
                SA2->(dbSelectArea("SA2"))
                SA2->(dbSetOrder(3))

                If SA2->(dbSeek(xFilial("SA2") + SQL->XML_EMIT))

                    _cChav := Alltrim(SQL->XML_CHAVE)

                    If Empty(aCabec)
                        aadd(aCabec,{"F1_TIPO"    ,"N" ,NIL})
                        aadd(aCabec,{"F1_FORMUL"  ,"N" ,NIL})
                        aadd(aCabec,{"F1_DOC"     ,STRZERO(Val(aDados[i][2]),9) ,NIL})
                        aadd(aCabec,{"F1_SERIE"   ,STRZERO(Val(aDados[i][1]),3) ,NIL})
                        aadd(aCabec,{"F1_EMISSAO" ,STOD(SQL->XML_EMISSA) ,NIL})
                        aadd(aCabec,{"F1_DTDIGIT" ,DDATABASE ,NIL})
                        aadd(aCabec,{"F1_FORNECE" ,SA2->A2_COD ,NIL})
                        aadd(aCabec,{"F1_LOJA"    ,SA2->A2_LOJA ,NIL})
                        aadd(aCabec,{"F1_ESPECIE" ,"CTE" ,NIL})
                        aadd(aCabec,{"F1_COND"    ,"001" ,NIL})
                        aadd(aCabec,{"F1_DESPESA" , 0 ,NIL})
                        aadd(aCabec,{"F1_DESCONT" , 0 ,Nil})
                        aadd(aCabec,{"F1_SEGURO"  , 0 ,Nil})
                        aadd(aCabec,{"F1_FRETE"   , 0 ,Nil})
                        aadd(aCabec,{"F1_MOEDA"   , 1 ,Nil})
                        aadd(aCabec,{"F1_TXMOEDA" , 1 ,Nil})
                        aadd(aCabec,{"F1_STATUS"  , "A" ,Nil})
                        aadd(aCabec,{"F1_CHVNFE"  , SQL->XML_CHAVE ,Nil})

                        aadd(aCabec,{"F1_UFORITR"  , SQL->XML_UFINI,Nil})
                        aadd(aCabec,{"F1_MUORITR"  , SUBSTR(SQL->XML_MUNINI,3,6),Nil})    

                        aadd(aCabec,{"F1_UFDESTR"  , SQL->XML_UFFIM,Nil})
                        aadd(aCabec,{"F1_MUDESTR"  , SUBSTR(SQL->XML_MUNFIM,3,6),Nil})    
                        aadd(aCabec,{"F1_TPCTE"  , "N",Nil})    
                    EndIf    

                        aItem := {}
                        aadd(aItem,{"D1_ITEM"   ,StrZero(nX,4) ,NIL})
                        aadd(aItem,{"D1_COD"    ,IIF(EMPTY(SQL->XIT_CODPRD), "SV901000000564",SQL->XIT_CODPRD)  ,NIL})
                        aadd(aItem,{"D1_UM"     ,"UN" ,NIL})
                        aadd(aItem,{"D1_LOCAL"  ,"700003" ,NIL})
                        aadd(aItem,{"D1_QUANT"  ,1 ,NIL})
                        aadd(aItem,{"D1_VUNIT"  ,SQL->XIT_PRUNIT ,NIL})
                        aadd(aItem,{"D1_TOTAL"  ,SQL->XIT_TOTAL ,NIL})
                        aadd(aItem,{"D1_TES"    ,"045" ,NIL})
                        aadd(aItem,{"D1_CONTA"  ,"415020001           ",NIL})
                        aadd(aItem,{"D1_GRUPO"  ,"9010",NIL})
                        aadd(aItem,{"D1_CLASFIS","090",NIL})
                        aadd(aItem,{"D1_NFORI"  ,SQL->XIT_NFORI,NIL})
                        aadd(aItem,{"D1_SERIORI",SQL->XIT_SRORI,NIL})    
                        aadd(aItem,{"D1_PICM"   ,SQL->XIT_PICICM,NIL})                       

                        If cFilAnt == '0072'
                            aadd(aItem,{"D1_CC",cCentCust,NIL})
                            
                        ElseIf cFilAnt $ '0031/0136'
                            SF2->(dbSelectArea("SF2"))
                            SF2->(dbSetOrder(1))
                            If SF2->(dbSeek(cFilAnt + SQL->XIT_NFORI + SQL->XIT_SRORI ) )

                                cQuery := " SELECT TOP 1 NNT_LOCLD,NNT_XCC,NNT_FILDES FROM "+RETSQLNAME("NNT")+" "
                                cQuery += " WHERE NNT_DOC='"+SQL->XIT_NFORI+"' AND NNT_FILIAL='"+cFilAnt+"' "

                                DBUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),"TRB",.F.,.T.)

                                If AllTrim(TRB->NNT_FILDES) == '0136'
                                    aadd(aItem,{"D1_CC",TRB->NNT_XCC,NIL}) 
                                Else
                                    aadd(aItem,{"D1_CC",TRB->NNT_LOCLD,NIL})       
                                EndIf
                                TRB->(DBCloseArea())                    
                            EndIf
                        EndIf   
                        
                        aAdd(aItens,aItem) 
                        nX++

                EndIf                         
                
                SQL->(dbSkip())
            Enddo    

            Begin Transaction

                If Empty(aCabec)
                    Alert("ATEN??O: Nota fiscal n?o localizada para lan?amento, verifique a importa??o dos XMLs " + cNumNota)
                Else
                    
                    SF1->(DBSELECTAREA("SF1"))
                    SF1->(DBSETORDER(8))

                    If ! SF1->(DBSEEK( xFilial("SF1") + _cChav))
                        
                        MsAguarde({|| MATA103(aCabec,aItens , 3 , .T.) },"Processamento","Aguarde gerando docto entrada...")

                        If lMsErroAuto      							
                            DisarmTransaction()
                            Mostraerro()                                       
                            Alert("ATEN??O: Erro lan?amento CT-e " + _cChav)
                        Else	

                            //Alimenta chave CT-e    
                            If  SF1->F1_DOC == STRZERO(Val(aDados[i][2]),9);
                                .And. SF1->F1_SERIE == STRZERO(Val(aDados[i][1]),3);
                                .And. SF1->F1_FORNECE == SA2->A2_COD;
                                .And. SF1->F1_LOJA == SA2->A2_LOJA

                                Reclock("SF1",.F.)
                                    SF1->F1_CHVNFE  := Alltrim(aCabec[18][2])
                                    SF1->F1_UFORITR := aCabec[19][2]
                                    SF1->F1_MUORITR := aCabec[20][2]
                                    SF1->F1_UFDESTR := aCabec[21][2]
                                    SF1->F1_MUDESTR := aCabec[22][2]                                       
                                MSUnLock()
                                
                            EndIf
                            TF1->(DBCLOSEAREA())	    
                        EndIf

                    Else
                        aadd(aAux,{SF1->F1_FILIAL,SF1->F1_DOC,_cChav,.F.})
                    EndIf                    
                  
                EndIf

            End Transaction     
            
            SQL->(DBCloseArea())

        Next i 

        If Len(aAux) > 0
            fAuxList(aAux)
        EndIf

Return


/*/{Protheus.doc} fAuxList
    @type Static Function
    @author Felipe Mayer - RVacari
    @since 04/12/2020
    @Desc fAuxList
/*/
Static Function fAuxList(aAux)

Private nJanLarg   := 700
Private nJanAltu   := 400
Private cFontUti   := "Tahoma"
Private oFontAno   := TFont():New(cFontUti,,-38)
Private oFontSub   := TFont():New(cFontUti,,-20)
Private oFontSubN  := TFont():New(cFontUti,,-20,,.T.)
Private oFontBtn   := TFont():New(cFontUti,,-14)
Private aHeadTMP   := {}
Private oDlgPvt
Private oMsGetTMP
Private oBtnSalv
Private oBtnFech


    aAdd(aHeadTMP, {"Filial",       "XX_FILIAL",   "",     015, 0, "NaoVazio()",  ".T.", "C", "", ""})
    aAdd(aHeadTMP, {"Documento",    "XX_DOC",      "",     015, 0, "NaoVazio()",  ".T.", "C", "", ""})
    aAdd(aHeadTMP, {"Chave",        "XX_CHAVE",    "",     030, 0, "NaoVazio()",  ".T.", "C", "", ""})

    DEFINE MSDIALOG oDlgPvt TITLE "Os documentos relacionados j? existem" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL

    @ 004, 005 SAY "BDIL"                                   SIZE 200,030 FONT oFontAno  OF oDlgPvt COLORS RGB(149,179,215) PIXEL
    @ 004, 060 SAY "Documentos de Entrada"                  SIZE 200,030 FONT oFontSub  OF oDlgPvt COLORS RGB(031,073,125) PIXEL
    @ 014, 060 SAY "Os documentos relacionados j? existem"  SIZE 200,030 FONT oFontSubN OF oDlgPvt COLORS RGB(031,073,125) PIXEL

    @ (nJanAltu/2)-20, (nJanLarg/2-001)-(0042*01) BUTTON oBtnSalv PROMPT "Fechar" SIZE 035, 017 OF oDlgPvt ACTION (oDlgPvt:End()) FONT oFontBtn PIXEL
     
    oMsGetTMP := MsNewGetDados():New(040,003,(nJanAltu/2)-30,(nJanLarg/2)-3,Iif(.F.,GD_INSERT + GD_UPDATE + GD_DELETE,nil),"AllwaysTrue()",,"",,,9999,,,,oDlgPvt,aHeadTMP,aAux)  
    
    ACTIVATE MSDIALOG oDlgPvt CENTERED
            
Return
