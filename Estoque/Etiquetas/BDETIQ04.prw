#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "protheus.ch"
#Include 'TopConn.ch'

User Function BDETIQ04()
  
    If ValidPerg()
        MsAguarde({|| ImpEtiq() },"Impress?o de etiqueta","Aguarde...")
    EndIf

Return

Static Function ImpEtiq()

    Local cQuery    := ""
    Local nQuant    := MV_PAR03

//    Local oFont24    := TFont():New('Arial',24,24,,.F.,,,,.T.,.F.,.F.)
//    Local oFont35    := TFont():New('Arial',35,35,,.F.,,,,.T.,.F.,.F.)
    Local oFont45    := TFont():New('Arial',45,45,,.F.,,,,.T.,.F.,.F.)

    Local lAdjustToLegacy     := .F.
    Local lDisableSetup      := .T.

    Local nLin        := 0
    Local nCol        := 0
    Local nLinC        := 0
    Local nColC        := 0
    Local nWidth    := 0
    Local nHeigth   := 0
    Local lBanner    := .T.        //Se imprime a linha com o c?digo embaixo da barra. Default .T.
    Local nPFWidth    := 0
    Local nPFHeigth    := 0
    Local lCmtr2Pix    := .T.        //Utiliza o m?todo Cmtr2Pix() do objeto Printer.Default .T.

    MsProcTxt("Identificando a impressora...")

    //Private oPrinter := FWMSPrinter():New("produto"+Alltrim(__cUserID)+".etq",IMP_SPOOL,lAdjustToLegacy,"/spool/",lDisableSetup,,,Alltrim(cImpress) /*parametro que recebe a impressora*/)
    Private oPrinter := FWMSPrinter():New("ETIQUETA_PRODUTO_BDETIQ04.rel", IMP_PDF, lAdjustToLegacy, , lDisableSetup)
    
    oPrinter:SetLandscape() 
    oPrinter:SetPaperSize(DMPAPER_A4) // papel tamanho A4


    //Para saber mais sobre o componente FWMSPrinter acesse http://tdn.totvs.com/display/public/mp/FWMsPrinter

    cQuery := "SELECT B1_COD AS 'CODIGO', B1_DESC AS 'DESC', B1_COD AS 'CODBAR' FROM "+RETSQLNAME("SB1")+" WHERE B1_COD BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' AND D_E_L_E_T_ != '*'"

    TcQuery cQuery New Alias "QRYTMP"
    QRYTMP->(DbGoTop())

    oPrinter:SetMargin(001,001,001,001)

    While QRYTMP->(!Eof())
        For nR := 1 to nQuant
            nLin := 10
            nCol := 22

            MsProcTxt("Imprimindo "+Alltrim(QRYTMP->CODIGO) + " - " + Alltrim(QRYTMP->DESC)+"...")

            oPrinter:StartPage()

            nLin+= 45
            oPrinter:Say(nLin,nCol, Alltrim(QRYTMP->CODIGO) ,oFont45)
            
            
            nLin+= 40
            nLinC        := 5.7          //Linha que ser? impresso o C?digo de Barra
            nColC        := 2         //Coluna que ser? impresso o C?digo de Barra
            nWidth       := 0.0164      //Numero do Tamanho da barra. Default 0.025 limite de largura da etiqueta ? 0.0164
            nHeigth      := 1.6         //Numero da Altura da barra. Default 1.5 --- limite de altura ? 0.3
            lBanner      := .T.         //Se imprime a linha com o c?digo embaixo da barra. Default .T.
            nPFWidth     := 0.8         //N?mero do ?ndice de ajuste da largura da fonte. Default 1
            nPFHeigth    := 0.9         //N?mero do ?ndice de ajuste da altura da fonte. Default 1
            lCmtr2Pix    := .T.         //Utiliza o m?todo Cmtr2Pix() do objeto Printer.Default .T.
            
            oPrinter:FWMSBAR("CODE128" , nLinC , nColC, alltrim(QRYTMP->CODBAR), oPrinter,/*lCheck*/,/*Color*/,/*lHorz*/, nWidth, nHeigth,.F.,/*cFont*/,/*cMode*/,.F./*lPrint*/,nPFWidth,nPFHeigth,lCmtr2Pix)

            nLin+= 67
            oPrinter:Say(nLin,nCol, Alltrim(QRYTMP->DESC),oFont45)
            
            nLin+= 58
            oPrinter:Say(nLin,nCol,"Lote " + Alltrim(MV_PAR05) ,oFont45)
            
            nLin+= 70
            oPrinter:FWMSBAR("CODE128" , 20, nColC ,Alltrim(MV_PAR05),oPrinter,/*lCheck*/,/*Color*/,/*lHorz*/, nWidth, nHeigth,.F.,/*cFont*/,/*cMode*/,.F./*lPrint*/,nPFWidth,nPFHeigth,lCmtr2Pix)      

            nLin+= 60
            oPrinter:Say(nLin,nCol,"Validade " + DTOC(MV_PAR06) ,oFont45)

            nLin+= 60
            oPrinter:Say(nLin,nCol,"Qtde " + cValToChar(MV_PAR07) + " Unid " + cValToChar(MV_PAR08)  ,oFont45)               

            oPrinter:EndPage()
        Next
        QRYTMP->(DbSkip())
    EndDo
    oPrinter:Print()
    QRYTMP->(DbCloseArea())

Return

/*Montagem da tela de perguntas*/
Static Function ValidPerg()

    Local aParamBox     := {}
    Local lRet          := .F.
    Local aOpcoes       := {}
    Local cProdDe       := ""
    Local cProdAte      := ""
    Local cLote         := SPACE(16)
    Local nQuant        := 0
    Local cUnid         := SPACE(2)

    aOpcoes := {"PDFCreator"}
 
    cProdDe := space(TamSX3("B1_COD")[1])
    cProdAte:= REPLICATE("Z",TAMSX3("B1_COD")[1])

    aAdd(aParamBox,{01,"Produto de"             ,cProdDe    ,""             ,"","SB1"    ,"", 60,.F.})    // MV_PAR01
    aAdd(aParamBox,{01,"Produto ate"            ,cProdAte   ,""             ,"","SB1"    ,"", 60,.T.})    // MV_PAR02
    aAdd(aParamBox,{01,"Quantidade Etiqueta"    ,1          ,"@E 9999"      ,"",""        ,"", 60,.F.})    // MV_PAR03
    aadd(aParamBox,{02,"Imprimir em"            ,Space(50)  ,aOpcoes        ,100,".T.",.T.,".T."})        // MV_PAR04
    aAdd(aParamBox,{01,"Lote"                   ,cLote      ,""             ,"",""    ,"", 60,.F.})    // MV_PAR05
    aAdd(aParamBox,{01,"Validade"               ,Date()+30  ,""             ,"",""    ,"", 60,.F.})    // MV_PAR06
    aAdd(aParamBox,{01,"Quantidade"             ,nQuant     ,"@E 9999"      ,"",""    ,"", 60,.F.})    // MV_PAR07
    aAdd(aParamBox,{01,"Unidade"                ,cUnid     ,   ,"","SAH"    ,"", 60,.F.})    // MV_PAR08

    If ParamBox(aParamBox,"Etiqueta Produto",/*aRet*/,/*bOk*/,/*aButtons*/,.T.,,,,FUNNAME(),.T.,.T.)

        If ValType(MV_PAR04) == "N" //Algumas vezes ocorre um erro de ao inv?s de selecionar o conte?do, seleciona a ordem, ent?o verifico se ? numerico, se for, eu me posiciono na impressora desejada para pegar o seu nome
            MV_PAR04 := aOpcoes[MV_PAR04]
        EndIf

        lRet := .T.
    EndIf
Return lRet
