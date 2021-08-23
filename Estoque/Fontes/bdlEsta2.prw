//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"
#include 'parmtype.ch'
#Include 'Report.ch'

#DEFINE NOME_REL   'RELESTA2'
#DEFINE TITULO_REL 'Relatório de Descarte'
#DEFINE DESCRI_REL ''
#DEFINE ABA_PLAN   ''

Static cTMVAL   := GetMV("BL_TMVAL",.T.,"510;520;530;540;550")  
Static cComboBox :=  "510=Avaria-Qualidade Fornecedor;520=Avaria-Qualidade Interna;530=Descarte Producao;540=Produto Descontinuado;550=Produto Vencido"

/*
bdlEsta2 
Rotina para digitação do descarte em lote

*/
 
User Function BDLESTA2()
    Local aArea := GetArea()
    //Objetos da Janela
    Private oDlgPvt
    Private oMsGetSBM
    Private aHeadSBM := {}
    Private aColsSBM := {}
    Private oBtnSalv
    Private oBtnFech
    Private oBtnLege
    //Tamanho da Janela
    Private    nJanLarg    := 0
    Private    nJanAltu    := 0
    //Fontes
    Private    cFontUti   := "Tahoma"
    Private    oFontAno   := TFont():New(cFontUti,,-38)
    Private    oFontSub   := TFont():New(cFontUti,,-20)
    Private    oFontSubN  := TFont():New(cFontUti,,-20,,.T.)
    Private    oFontBtn   := TFont():New(cFontUti,,-14)
       
    //if upper(left(cusername,2)) != 'LJ'
	//    msgStop("Esta rotina esta somente disponível para as lojas","DENIED")
	//    return
    //endif 

	aAdd(aHeadSBM, {"Produto"           , "XX_COD"    ,""                 ,TamSX3("D3_COD" )[01], 0,"NaoVazio() .and. U_VlSE3Cpo('COD')", "û", "C", "SB1", "" } )
    aAdd(aHeadSBM, {"Descrição"         , "XX_DESC"   ,""                 ,TamSX3("B1_DESC")[01], 0,".T."                               , "û", "C", "   ", "" } )
    aAdd(aHeadSBM, {"Motivo do Descarte", "XX_TM"     , ""                ,3                    , 0,"NaoVazio()"                        , "û", "C", ""   , "", @cComboBox} )
    aAdd(aHeadSBM, {"Unid.Medida1"      , "XX_UM"     , ""                ,2                    , 0,""                                  , "û", "C", ""   , "" } )
    aAdd(aHeadSBM, {"Quant.UM 1"        , "XX_QUANT"  ,"@E 999,999.99",010                  , 2,"U_VlSE3Cpo('QTD1')"                , "û", "N", ""   , "" } )
    aAdd(aHeadSBM, {"Unid.Medida2"      , "XX_UM2"    , ""                ,2                    , 0,""                                  , "û", "C", ""   , "" } )
    aAdd(aHeadSBM, {"Quant.UM 2"        , "XX_QUANT2" ,"@E 999,999.99",010                  , 2,"U_VlSE3Cpo('QTD2')"                , "û", "N", ""   , "" } )
    aAdd(aHeadSBM, {"Data"              , "XX_EMISSAO",""                 , 10                  , 0,".T."                               , "û", "D", ""   , "" } )
    
    aAlter := {"XX_COD","XX_TM","XX_QUANT","XX_QUANT2","XX_EMISSAO"}    
	
    aAdd(aColsSBM, { ;
            SPACE(TamSX3("D3_COD")[01] ),;//SPACE(TamSX3("B1_LOCPAD")[01]),;
            SPACE(TamSX3("B1_DESC")[01]),;
            SPACE(3),;
            SPACE(2),;
            0,;
            SPACE(2),;
            0,;
            DATE(),;
            .F.;
        })
    nJanLarg := 1325
    nJanAltu := 575
    //Criação da tela com os dados que serão informados
    DEFINE MSDIALOG oDlgPvt TITLE "Descarte de Produto" FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
        //oDlgPvt:lMaximized := .T.
        //Labels gerais
        @ 004, 003 SAY "Descarte"   SIZE 200, 030 FONT oFontAno  OF oDlgPvt COLORS RGB(149,179,215) PIXEL
        //@ 004, 090 SAY "Produtos"   SIZE 200, 030 FONT oFontSub  OF oDlgPvt COLORS RGB(031,073,125) PIXEL
       // @ 014, 090 SAY "Descartados" SIZE 200, 030 FONT oFontSubN OF oDlgPvt COLORS RGB(031,073,125) PIXEL
         
        //Botões
        @ 006, (nJanLarg/2-001)-(0052*01) BUTTON oBtnFech  PROMPT "Fechar"        SIZE 050, 018 OF oDlgPvt ACTION (oDlgPvt:End())                               FONT oFontBtn PIXEL
        //@ 006, (nJanLarg/2-001)-(0052*02) BUTTON oBtnLege  PROMPT "Legenda"       SIZE 050, 018 OF oDlgPvt ACTION (fLegenda())                                  FONT oFontBtn PIXEL
        @ 006, (nJanLarg/2-001)-(0052*02) BUTTON oBtnSalv  PROMPT "Salvar"        SIZE 050, 018 OF oDlgPvt ACTION (fSalvar())                                   FONT oFontBtn PIXEL
         
        //Grid dos grupos B1_XLISTA
        oMsGetSBM := MsNewGetDados():New(   029,;                //nTop      - Linha Inicial
                                            003,;                //nLeft     - Coluna Inicial
                                            (nJanAltu/2)-3,;     //nBottom   - Linha Final
                                            (nJanLarg/2)-3,;     //nRight    - Coluna Final
                                            GD_INSERT + GD_UPDATE + GD_DELETE,;//nStyle    - Estilos para edição da Grid (GD_INSERT = Inclusão de Linha; GD_UPDATE = Alteração de Linhas; GD_DELETE = Exclusão de Linhas)
                                            "U_VLSE3()",;       //cLinhaOk  - Validação da linha
                                            "U_VLTSE3()",;       //cTudoOk   - Validação de todas as linhas
                                            "",;                 //cIniCpos  - Função para inicialização de campos
                                            aAlter,;             //aAlter    - Colunas que podem ser alteradas
                                            ,;                   //nFreeze   - Número da coluna que será congelada
                                            9999,;               //nMax      - Máximo de Linhas
                                            "U_VLSE3FdOK",;      //cFieldOK  - Validação da coluna
                                            ,;                   //cSuperDel - Validação ao apertar '+'
                                            ,;                   //cDelOk    - Validação na exclusão da linha
                                            @oDlgPvt,;            //oWnd      - Janela que é a dona da grid
                                            @aHeadSBM,;           //aHeader   - Cabeçalho da Grid
                                            @aColsSBM,;            //aCols     - Dados da Grid
                                            {|| FullField()} )
        //oMsGetSBM:lMaximized := .T.   
    ACTIVATE MSDIALOG oDlgPvt CENTERED
     
    RestArea(aArea)
Return

 
/*--------------------------------------------------------*
 | Func.: fSalvar                                         |
 | Desc.: Função que percorre as linhas e faz a gravação  |
 *--------------------------------------------------------*/
 
Static Function fSalvar()
    Local aColsAux    := oMsGetSBM:aCols
    Local nPosCod     := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_COD"    })
    //Local nPosLoc     := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_LOCAL"})
    Local nPosTM      := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_TM"     })
    Local nPosQuant   := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_QUANT"  })
    Local nPosEmissao := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_EMISSAO"})
    Local nPosQuan2   := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_QUANT2" })
   
    Local nPosDel     := Len(aHeadSBM) + 1
    Local nLinha   := 0
    Local _aDados := {}
    //Local _nPos := aScan(_aItens, {|x| x == _cCombo})
    Private lMsErroAuto := .F.
    
    if U_VLTSE3() == .F.
        Return
    EndiF
    //Percorrendo todas as linhas
    For nLinha := 1 To Len(aColsAux)
        _aDados := {}
        
        lMsErroAuto := .F.

        if !(aColsAux[nLinha,nPosDel] )
            DbSelectArea("NNR")
            DBSETORDER(1)
            if !DbSeek(xFilial("NNR")+RIGHT(CUSERNAME,4)+ '01')
                Reclock("NNR",.T.)
                NNR->NNR_FILIAL := XFILIAL("NNR")
                NNR->NNR_CODIGO := RIGHT(CUSERNAME,4)+ '01'
                NNR->NNR_DESCRI := "DESCARTE " + RIGHT(CUSERNAME,4) +'01'
                Msunlock()
            endif

            aAdd(_aDados, {"D3_FILIAL" , xFilial("SD3"), NIL})
            aAdd(_aDados, {"D3_TM"     , aColsAux[nLinha,nPosTM] , NIL})
            aAdd(_aDados, {"D3_COD"    , aColsAux[nLinha,nPosCod], NIL})
            aAdd(_aDados, {"D3_QUANT"  , aColsAux[nLinha,nPosQuant], NIL})
            aAdd(_aDados, {"D3_LOCAL"  , RIGHT(CUSERNAME,4)+ '01', NIL})
            //aAdd(_aDados, {"D3_LOCAL"  , aColsAux[nLinha,nPosLoc], NIL})
            aAdd(_aDados, {"D3_EMISSAO", aColsAux[nLinha,nPosEmissao], NIL})
            aAdd(_aDados, {"D3_QTSEGUM", aColsAux[nLinha,nPosQuan2], NIL})


            MSEXECAUTO({|x,y|mata240(x,y)}, _aDados, 3)

            if lMsErroAuto
                MostraErro()
            else
                //msgInfo("Descarte registrado com sucesso!!!", "INCLUSAO OK")
            endif
        endif
    Next nLinha

    _imprel(aHeadSBM,oMsGetSBM:aCols)

    MsgInfo("Manipulações finalizadas!", "Atenção")
    oDlgPvt:End()
Return
/* 
Valida Linha do Grid
 */
user function VLSE3()
    Local aColsAux    := oMsGetSBM:aCols
    Local nPosCod     := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_COD"})
    Local nPosTM      := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_TM"})
    Local nPosQuant   := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_QUANT"})
    Local nPosEmissao := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_EMISSAO"})

    Local nLinha      := oMsGetSBM:nat
    Local lRet        := .T.

    if empty(aColsAux[nLinha,nPosCod])
        lRet := .F.
        Alert("Campo de Produto vazio")
    Elseif empty(aColsAux[nLinha,nPosTM])
        lRet := .F.
        Alert("Campo de Tipo de Movimento vazio")
    Elseif !(aColsAux[nLinha,nPosTM] $ cTMVAL)
        lRet := .F.
        Alert("Tipo de Movimento inválido para esta Opreação")
    Elseif aColsAux[nLinha,nPosQuant] <= 0
        lRet := .F.
        Alert("Quantidade Invalida")
    Elseif aColsAux[nLinha,nPosEmissao ] > date() .or. empty(aColsAux[nLinha,nPosEmissao])
        lRet := .F.
        Alert("Data invalida Invalida")
    elseif !(ExistCpo("SB1", aColsAux[nLinha,nPosCod]))
        lRet := .F.
        Alert("Produto não encontrado")
   Else
        lRet := .T.
    Endif


return lRet
/* 
Valida Todas as linhas do grid
 */
user function VLTSE3()
    Local aColsAux    := oMsGetSBM:aCols
    Local nPosCod     := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_COD"    })
    Local nPosTM      := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_TM"     })
    Local nPosQuant   := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_QUANT"  })
    Local nPosEmissao := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_EMISSAO"})

    Local nLinha      := 1
    Local lRet        := .T.
   
    FOR nLinha := 1 to len(aColsAux)
        if empty(aColsAux[nLinha,nPosCod])
            lRet := .F.
            Alert("Campo de Produto vazio")
            exit
        Elseif empty(aColsAux[nLinha,nPosTM])
            lRet := .F.
            Alert("Campo de Tipo de Movimento vazio")
            exit
        Elseif !(aColsAux[nLinha,nPosTM] $ cTMVAL )
            lRet := .F.
            Alert("Tipo de Movimento inválido para esta Opreação")
            exit
        Elseif aColsAux[nLinha,nPosQuant] <= 0
            lRet := .F.
            Alert("Quantidade Invalida")
            exit
        Elseif aColsAux[nLinha,nPosEmissao ] > date() .or. empty(aColsAux[nLinha,nPosEmissao])
            lRet := .F.
            Alert("Data invalida Invalida")
            exit
         elseif !(ExistCpo("SB1", aColsAux[nLinha,nPosCod]))
             lRet := .F.
             Alert("Produto não encontrado")
             Exit
        Else
             lRet := .T.
        Endif
    Next nLinha


return lRet

User Function VLSE3FdOK()
    Local aColsAux    := oMsGetSBM:aCols
    Local nPosCod     := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_COD"    })
    Local nPosDesc    := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_DESC"   })
    Local nPosUM1     := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_UM"     })
    Local nPosUM2     := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_UM2"    })
    
    nX := oMsGetSBM:nAt
    
    //IF  Empty(oMsGetSBM:aCols[nX ,nPosDesc]) 
        oMsGetSBM:aCols[nX,nPosDesc] := posicione("SB1",1,XfILIAL("SB1")+oMsGetSBM:aCols[nX,nPosCod],"B1_DESC" )
        oMsGetSBM:aCols[nX,nPosUM1]  := posicione("SB1",1,XfILIAL("SB1")+oMsGetSBM:aCols[nX,nPosCod],"B1_UM"   )
        oMsGetSBM:aCols[nX,nPosUM2]  := posicione("SB1",1,XfILIAL("SB1")+oMsGetSBM:aCols[nX,nPosCod],"B1_SEGUM")
        aColsAux[nX,nPosDesc]        := posicione("SB1",1,XfILIAL("SB1")+oMsGetSBM:aCols[nX,nPosCod],"B1_DESC" )
        aColsAux[nX,nPosUM1]         := posicione("SB1",1,XfILIAL("SB1")+oMsGetSBM:aCols[nX,nPosCod],"B1_UM"   )
        aColsAux[nX,nPosUM2]         := posicione("SB1",1,XfILIAL("SB1")+oMsGetSBM:aCols[nX,nPosCod],"B1_SEGUM")
    //endif    
     
    oMsGetSBM:SetArray(aColsAux,.F.)
    
    ///oMsGetSBM:Refresh()
    oMsGetSBM:oBrowse:Refresh()
    oMsGetSBM:Refresh()

    lRet := .T.
Return lRet


USER Function VlSE3Cpo(cTipo)
    Local lRet := .T.
    
    Local nPosCod     := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_COD"    })
    Local nPosDesc    := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_DESC"   })
    Local nPosQuant   := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_QUANT"  })
    Local nPosQuan2   := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_QUANT2" })
    Local nPosUM1     := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_UM"     })
    Local nPosUM2     := aScan(aHeadSBM, {|x| Alltrim(x[2]) == "XX_UM2"    })
    Local nConv   := 1
    Local cTipoCon:= "D"
   
    Default cTipo := ""
    
    nX := oMsGetSBM:nAt
    
        IF M->XX_COD <> NIL    
            oMsGetSBM:aCols[nX,nPosCod] := M->XX_COD
        ELSE
            M->XX_COD := oMsGetSBM:aCols[nX,nPosCod] 
        ENDIF
        oMsGetSBM:aCols[nX,nPosDesc] := posicione("SB1",1,XfILIAL("SB1")+oMsGetSBM:aCols[nX,nPosCod],"B1_DESC" )
        oMsGetSBM:aCols[nX,nPosUM1]  := posicione("SB1",1,XfILIAL("SB1")+oMsGetSBM:aCols[nX,nPosCod],"B1_UM"   )
        oMsGetSBM:aCols[nX,nPosUM2]  := posicione("SB1",1,XfILIAL("SB1")+oMsGetSBM:aCols[nX,nPosCod],"B1_SEGUM")

            M->XX_DESC := oMsGetSBM:aCols[nX,nPosDesc]
            M->XX_UM   := oMsGetSBM:aCols[nX,nPosUM1] 
            M->XX_UM2  := oMsGetSBM:aCols[nX,nPosUM2]
            if Empty(M->XX_DESC)
                lRet := .F.
                Alert("Produto não encontrado")
            endif
      
    if (cTipo == "QTD1" .AND. !EMPTY(oMsGetSBM:aCols[nX,nPosCod])) //.OR. M->XX_QUANT <> oMsGetSBM:aCols[nX,nPosQuant]

        cTipoCon := posicione("SB1",1,XfILIAL("SB1")+oMsGetSBM:aCols[nX,nPosCod],"B1_TIPCONV")
        nConv    := posicione("SB1",1,XfILIAL("SB1")+oMsGetSBM:aCols[nX,nPosCod],"B1_CONV"   )
    
        if cTipoCon == "D"
            oMsGetSBM:aCols[nX,nPosQuan2] := M->XX_QUANT / nConv
        elseif cTipoCon == "M"
            oMsGetSBM:aCols[nX,nPosQuan2] := M->XX_QUANT * nConv
        endif
        M->XX_QUANT2 :=  oMsGetSBM:aCols[nX,nPosQuan2]

    elseif cTipo == "QTD2" .AND. !EMPTY(oMsGetSBM:aCols[nX,nPosCod]) // .OR. M->XX_QUANT2 == NIL

        cTipoCon := posicione("SB1",1,XfILIAL("SB1")+oMsGetSBM:aCols[nX,nPosCod],"B1_TIPCONV")
        nConv    := posicione("SB1",1,XfILIAL("SB1")+oMsGetSBM:aCols[nX,nPosCod],"B1_CONV"   )
    
        if cTipoCon == "D"
            oMsGetSBM:aCols[nX,nPosQuant] := M->XX_QUANT2 * nConv
        elseif cTipoCon == "M"
            oMsGetSBM:aCols[nX,nPosQuant] := M->XX_QUANT2 / nConv
        endif
        M->XX_QUANT  :=  oMsGetSBM:aCols[nX,nPosQuant]
    ENDIF 
 
    
    oMsGetSBM:oBrowse:Refresh()
    oMsGetSBM:Refresh()
  
    //lRet := .T.
return lRet


Static Function FullField()

    oMsGetSBM:Refresh()
    
return 


//***************************************************************************************************************************
//***************************************************************************************************************************
//***************************************************************************************************************************
//***************************************************************************************************************************
//***************************************************************************************************************************
//***************************************************************************************************************************
//***************************************************************************************************************************
//***************************************************************************************************************************


//-----------------------------------------------------------------------
// Rotina | xTReport     | Autor | Robson Luiz - Rleg | Data | 04.04.2013
//-----------------------------------------------------------------------
// Descr. | Esta rotina exemplifica a utilização do TReport.
//-----------------------------------------------------------------------
// Uso    | Oficina de Programação
//-----------------------------------------------------------------------
static Function _imprel(aHead,aCol)
    Private cCadastro := ABA_PLAN
    Private cOpcRel   := 'Teste'
    Private aCabAux   := aClone(aHead)
    Private aDAux     := aClone(aCol)
    xArray( )

Return

//-----------------------------------------------------------------------
// Rotina | xArray       | Autor | Robson Luiz - Rleg | Data | 04.04.2013
//-----------------------------------------------------------------------
// Descr. | Tratamento de impressão dos dados por meio de um Array.
//-----------------------------------------------------------------------
// Uso    | Oficina de Programação
//-----------------------------------------------------------------------
Static Function xArray( )
    Local oReport
    Local nI     := 0
    Local nX     := 0
    Local nTm    := 0
    Local aCpo   := {}
    local aDados := {}
    local aCab   := {}
    
    Local nPosCod   := aScan(aCabAux, {|x| Alltrim(x[2]) == "XX_COD"    })
    Local nPosQuant := aScan(aCabAux, {|x| Alltrim(x[2]) == "XX_QUANT"  })
    Local nPosTM    := aScan(aCabAux, {|x| Alltrim(x[2]) == "XX_TM"     })
    Local nPosUM1   := aScan(aCabAux, {|x| Alltrim(x[2]) == "XX_UM"     })
    Local nPosUM2   := aScan(aCabAux, {|x| Alltrim(x[2]) == "XX_UM2"    })
  
    Local aTm       := StrTokArr(cCombobox,";")

    For nI := 1 To Len( aCabAux)
        if nI == nPosTM
            AAdd( aCab, {RTrim(aCabAux[nI,1] ),10}  )
        elseif nI == nPosUM1 
            AAdd( aCab, {"UM.1",aCabAux[nI,4]}  )
        elseif nI == nPosUM2 
            AAdd( aCab, {"UM.2",aCabAux[nI,4]}  )
        else
            AAdd( aCab, {RTrim(aCabAux[nI,1] ),aCabAux[nI,4]}  )
        endif
    Next nI

    AAdd( aCab,{ "Custo STD"  , 18})
    AAdd( aCab,{ "Custo Total", 18})    
    For nI := 1 to len(aDAux)
        aCpo := {}
      
        nTm :=  aScan(aTm, {|x| substr(x,1,3) == aDAux[nI, nPosTM] })

        if !(aDAux[nI,len(aDAux[nI])])
            
            for nX := 1 to len(aDAux[nI])-1
                if nX == nPosTM               
                    aadd(aCpo,aTm[nTm])
                else
                    aadd(aCpo,aDAux[nI,nX])
                endif
            Next nX
            aadd(aCpo,posicione("SB1",1,XFILIAL("SB1") + aCpo[nPosCod],"B1_CUSTD")  )
            
            aadd(aCpo,posicione("SB1",1,XFILIAL("SB1") + aCpo[nPosCod],"B1_CUSTD") * aCpo[nPosQuant] )
            AAdd( aDados, aCpo ) 
        endif
    Next nI
    
    If Len( aDados ) > 0
        oReport := xDefArray( aDados, aCab )
        oReport:PrintDialog()
    Else
        MsgInfo('Não foi possível localizar os dados, verifique os parâmetros.',cCadastro)
    Endif
Return

//-----------------------------------------------------------------------
// Rotina | xDefArray    | Autor | Reinaldo Rabelo  | Data | 01.04.2021 |
//-----------------------------------------------------------------------
// Descr. | Definição de impressão dos dados do array.
//-----------------------------------------------------------------------
// Uso    | Oficina de Programação
//-----------------------------------------------------------------------
Static Function xDefArray( aCOLS, aHeader )
    Local oReport
    Local oSection 
   // Local nLen := Len(aHeader)
    Local nX := 0
    /*
    +-------------------------------------+
    | Método construtor da classe TReport |
    +-------------------------------------+
    New(cReport,cTitle,uParam,bAction,cDescription,lLandscape,uTotalText,lTotalInLine,cPageTText,lPageTInLine,lTPageBreak,nColSpace)
    
    cReport            - Nome do relatório. Exemplo: MATR010
    cTitle            - Título do relatório
    uParam            - Parâmetros do relatório cadastrado no Dicionário de Perguntas (SX1). Também pode ser utilizado bloco de código para parâmetros customizados.
    bAction            - Bloco de código que será executado quando o usuário confirmar a impressão do relatório
    cDescription    - Descrição do relatório
    lLandscape        - Aponta a orientação de página do relatório como paisagem
    uTotalText        - Texto do totalizador do relatório, podendo ser caracter ou bloco de código
    lTotalInLine    - Imprime as células em linha
    cPageTText        - Texto do totalizador da página
    lPageTInLine    - Imprime totalizador da página em linha
    lTPageBreak        - Quebra página após a impressão do totalizador
    nColSpace        - Espaçamento entre as colunas
    
    Retorno    Objeto
    */
    oReport := TReport():New( NOME_REL, TITULO_REL, , {|oReport| xImprArray( oReport, aCOLS )}, DESCRI_REL + cOpcRel )
    
    DEFINE SECTION oSection OF oReport TITLE ABA_PLAN TOTAL IN COLUMN
    nX := 0
    //For nX := 1 To nLen
        DEFINE CELL NAME "CEL"+Alltrim(Str(nX ))  OF oSection SIZE 015 TITLE aHeader[01,1]
        DEFINE CELL NAME "CEL"+Alltrim(Str(nX+1)) OF oSection SIZE 045 TITLE aHeader[02,1]
        DEFINE CELL NAME "CEL"+Alltrim(Str(nX+2)) OF oSection SIZE 032 TITLE aHeader[03,1]
        DEFINE CELL NAME "CEL"+Alltrim(Str(nX+3)) OF oSection SIZE 004 TITLE aHeader[04,1]
        DEFINE CELL NAME "CEL"+Alltrim(Str(nX+4)) OF oSection SIZE 014 TITLE aHeader[05,1]
        DEFINE CELL NAME "CEL"+Alltrim(Str(nX+5)) OF oSection SIZE 004 TITLE aHeader[06,1]
        DEFINE CELL NAME "CEL"+Alltrim(Str(nX+6)) OF oSection SIZE 014 TITLE aHeader[07,1]
        DEFINE CELL NAME "CEL"+Alltrim(Str(nX+7)) OF oSection SIZE 010 TITLE aHeader[08,1]
        DEFINE CELL NAME "CEL"+Alltrim(Str(nX+8)) OF oSection SIZE 014 TITLE aHeader[09,1]
        DEFINE CELL NAME "CEL"+Alltrim(Str(nX+9)) OF oSection SIZE 014 TITLE aHeader[10,1]
    //Next nX
    
    /*
    +---------------------------------------+    
    | Define o espaçamento entre as colunas |
    +---------------------------------------+
    SetColSpace(nColSpace,lPixel)

    nColSpace    - Tamanho do espaçamento
    lPixel        - Aponta se o tamanho será calculado em pixel
    */
    oSection:SetColSpace(1,.f.)
    
    // Quantidade de linhas a serem saltadas antes da impressão da seção
    oSection:nLinesBefore := 1
    
    //oSection:SetAutoSize(.t.)
    /*
    +--------------------------------------------------------------------------------------------------------------+
    | Define que a impressão poderá ocorrer emu ma ou mais linhas no caso das colunas exederem o tamanho da página |
    +--------------------------------------------------------------------------------------------------------------+
    SetLineBreak(lLineBreak)
    
    lLineBreak - Se verdadeiro, imprime em uma ou mais linhas
    */
    oSection:SetLineBreak(.T.)


Return( oReport )

//-----------------------------------------------------------------------
// Rotina | xImprArray  | Autor | Reinaldo Rabelo    | Data | 01.04.2021|
//-----------------------------------------------------------------------
// Descr. | Impressão dos dos dados do array.
//-----------------------------------------------------------------------
// Uso    | Oficina de Programação
//-----------------------------------------------------------------------
Static Function xImprArray( oReport, aCOLS )
    Local oSection := oReport:Section(1) // Retorna objeto da classe TRSection (seção). Tipo Caracter: Título da seção. Tipo Numérico: Índice da seção segundo a ordem de criação dos componentes TRSection.
    Local nX := 0
    Local nY := 0
    
    /*
    +-----------------------------------------------------+
    | Define o limite da régua de progressão do relatório |
    +-----------------------------------------------------+
    SetMeter(nTotal)
    
    nTotal - Limite da régua

    */
    oReport:SetMeter( Len( aCOLS ) )    
    
    /*
    +---------------------------------------------------------------------+
    | Inicializa as configurações e define a primeira página do relatório |
    +---------------------------------------------------------------------+
    Init()
    
    Não é necessário executar o método Init se for utilizar o método Print, já que estes fazem o controle de inicialização e finalização da impressão.
    */
    oSection:Init()
    
    For nX := 1 To Len( aCOLS )
        // Retorna se o usuário cancelou a impressão do relatório
        If oReport:Cancel()
            Exit
        EndIf
        
        For nY := 1 To Len(aCOLS[ nX ])
           If ValType( aCOLS[ nX, nY ] ) == 'D'
               // Cell() - Retorna o objeto da classe TRCell (célula) baseado. Tipo Caracter: Nome ou título do objeto. Tipo Numérico: Índice do objeto segundo a ordem de criação dos componentes TRCell.
               // SetBlock() - Define o bloco de código que retornará o conteúdo de impressão da célula. Definindo o bloco de código para a célula, esta não utilizara mais o nome mais o alias para retornar o conteúdo de impressão.
               oSection:Cell("CEL"+Alltrim(Str(nY-1))):SetBlock( &("{ || '" + Dtoc(aCOLS[ nX, nY ]) + "'}") )
           Elseif ValType( aCOLS[ nX, nY ] ) == 'N'
               oSection:Cell("CEL"+Alltrim(Str(nY-1))):SetBlock( &("{ || '" + TransForm(aCOLS[ nX, nY ],'@E 99,999,999.99') + "'}") )
           Else
               oSection:Cell("CEL"+Alltrim(Str(nY-1))):SetBlock( &("{ || '" + aCOLS[ nX, nY ] + "'}") )
           Endif
        Next
        
        // Incrementa a régua de progressão do relatório
        oReport:IncMeter()
        
        /*
        +------------------------------------------------+
        | Imprime a linha baseado nas células existentes |
        +------------------------------------------------+
        PrintLine(lEvalPosition,lParamPage,lExcel)
        
        lEvalPosition    - Força a atualização do conteúdo das células 
        lParamPage        - Aponta que é a impressão da página de parâmetros
        lExcel            - Aponta que é geração em planilha

        */
        oSection:PrintLine()
    Next
    
    /*
    Finaliza a impressão do relatório, imprime os totalizadores, fecha as querys e índices temporários, entre outros tratamentos do componente.
    Não é necessário executar o método Finish se for utilizar o método Print, já que este faz o controle de inicialização e finalização da impressão.
    */
    oSection:Finish()
Return

//***************************************************************************************************************************
//***************************************************************************************************************************
//***************************************************************************************************************************
//***************************************************************************************************************************
//***************************************************************************************************************************
//***************************************************************************************************************************
//***************************************************************************************************************************
//***************************************************************************************************************************

//Consulta principal do relatorio
Static function fquery()
    Local cQuery := ''

    cQuery :=  " Select D3_COD     AS XX_COD  , "
    cQuery +=  "        B1_DESC    AS XX_DESC , "
    cQuery +=  "        D3_TM      AS XX_TM   , "
    cQuery +=  "        D3_UM      AS XX_UM   , "
    cQuery +=  "        D3_QUANT   AS XX_QUANT, "
    cQuery +=  "        D3_SEGUM   AS XX_UM2  , "
    cQuery +=  "        D3_QTSEGUM AS XX_QUANT2  , "
    cQuery +=  "        D3_EMISSAO AS XX_EMISSAO , "
    cQuery +=  "        ROUND((D3_QUANT * B1_CUSTD),2) AS CUSTO "
    cQuery +=  "    from "+RetSqlName("SD3") + " D3 " 
    cQuery +=  "        INNER JOIN " + RetSqlName("SB1") + " B1 "
    cQuery +=  "            ON  B1_COD        = D3_COD "
    cQuery +=  "            AND B1.D_E_L_E_T_ = ''"
    cQuery +=  "            AND B1_FILIAL     = '" + xFilial("SB1") + "'"
    cQuery +=  "    WHERE   D3_TM IN('510','520','530','540','550') "
    cQuery +=  "        AND D3_CF = 'RE0' "
    cQuery +=  "        AND D3.D_E_L_E_T_ = '' "
    cQuery +=  "        AND D3_EMISSAO BETWEEN '"+ DToS(MV_PAR01) + "' AND '" + DToS(MV_PAR02) + "'"

    if MV_PAR03 == 1
        cQuery +=  "    ORDER BY D3_EMISSAO   ,D3_COD"
    ELSE
        cQuery +=  "    ORDER BY D3_COD   ,D3_EMISSAO"
    ENDIF

    TCQUERY cQuery NEW ALIAS "TRB1"
    
Return

//Valida se a Pergunte Existe, caso não exista sera criada
Static Function ValidPerg()
    //local cPerg := 
    _sAlias := Alias()
    dbSelectArea("SX1")
    dbSetOrder(1)
    cPerg := PADR(cPerg,10)
    aRegs :={}

    aAdd(aRegs,{cPerg,"01","De Dt.Emissao." ,"","","mv_ch1","D",08,0,0,"G","naovazio()","mv_par01",""       ,""       ,""       ,"","",""       ,""       ,""       ,"","","","","","","","","","","","","","","","","","","",""})
    aAdd(aRegs,{cPerg,"02","Até Dt.Emissao.","","","mv_ch2","D",08,0,0,"G","naovazio()","mv_par02",""       ,""       ,""       ,"","",""       ,""       ,""       ,"","","","","","","","","","","","","","","","","","","",""})
    aAdd(aRegs,{cPerg,"03","Ordenar por"    ,"","","mv_ch3","N",01,0,0,"C",""          ,"mv_par03","Emissao","Emissao","Emissao","","","Produto","Produto","Produto","","","","","","","","","","","","","","","","","","","",""})


    For i := 1 to Len(aRegs)
        If !dbSeek(cPerg+aRegs[i,2])
            RecLock("SX1",.T.)
            For j := 1 to FCount()
                If j <= Len(aRegs[i])
                    FieldPut(j,aRegs[i,j])
                Else
                    exit
                Endif
            Next
            MsUnlock()
        Endif
    Next
    dbSelectArea(_sAlias)

Return
//
//Monta o cabeçalhao do Relatorio
//
static Function xCab()
    aAdd(aCab, {"Produto"           , "XX_COD"    ,""                 ,TamSX3("D3_COD" )[01], 0})
    aAdd(aCab, {"Descrição"         , "XX_DESC"   ,""                 ,TamSX3("B1_DESC")[01], 0})
    aAdd(aCab, {"Motivo do Descarte", "XX_TM"     , ""                ,3                    , 0})
    aAdd(aCab, {"Unid.Medida1"      , "XX_UM"     , ""                ,2                    , 0})
    aAdd(aCab, {"Quant.UM 1"        , "XX_QUANT"  ,"@E 999,999.99"    ,010                  , 2})
    aAdd(aCab, {"Unid.Medida2"      , "XX_UM2"    , ""                ,2                    , 0})
    aAdd(aCab, {"Quant.UM 2"        , "XX_QUANT2" ,"@E 999,999.99"    ,010                  , 2})
    aAdd(aCab, {"Data"              , "XX_EMISSAO",""                 , 10                  , 0})
    
return
//
//Cria a um matriz com os dados da consulta para a impressão do relatorio
//
//
Static function xAcols()

    DbSelectArea("TRB1")
    TRB1->(DbGotop())
    While TRB1->(!EOF())

        AAdd(aCols,{TRB1->XX_COD,TRB1->XX_DESC,TRB1->XX_TM,TRB1->XX_UM,TRB1->XX_QUANT,TRB1->XX_UM2,TRB1->XX_QUANT2,Stod(TRB1->XX_EMISSAO), .F.})
    
        TRB1->(dbskip())
    EndDo

Return

//
//Programa principal para a Geração do relatorio de descarte para rodar direto do menu
//Sera 
//


User Function RELESTA2()
Private cPerg := "RELESTA201"
Private aCab  := {}
Private aCols := {}

ValidPerg()                         //Valida se a Pergunte existe

if Pergunte(cPerg,.t.)              //Chama a Pengunte
    xCab()                          //Cria a Array com o cabeçalho
    fquery()                        //Consulta principal com os descarte
    xAcols()                        //cria a acols dom os dados da consulta
    IF LEN(aCols) > 0               //Veiricar se existe dados para impressão
        _imprel(aCab,aCols)         //Imprime o relatorio
    else
        MsgInfo("Não a Dados para Gerar o Relatório", "Atenção")
    endif
endif

Return
