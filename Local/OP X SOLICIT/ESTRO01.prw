
#Include 'Protheus.ch' //Informa a biblioteca

/*/{Protheus.doc} User Function ESTRO01
    (long_description)
    @type  Function
    @author Douglas Silva
    @since 03/06/2020
    @version 1.0
    @example
        Tela tem como objetivo criar solicitacao de armazans
    @see (links_or_references)
/*/

User Function ESTRO01()

    Local aRet      := {}
    Local aParamBox := {}
    Local i         := 0
    
    aAdd(aParamBox,{1,"Num OP",Space(15),"","","SC2","",0,.F.}) // Tipo caractere

    If ParamBox(aParamBox,"Ordem de Producao x Solicitacao...",@aRet)
        
        For i:=1 To Len(aRet)
            MsgRun("Buscando informacoes Aguarde...", "RVacari", {|| MontaTela(MV_PAR01) })
        Next

    Endif


Return

Static Function MontaTela(cNumOP)

    Local aaCampos  	:= {"QTD_A_TRG"} 	//Variavel contendo o campo editavel no Grid
    Local aBotoes	    := {}      		//Variavel onde sera incluido o botao para a legenda
    Private oLista                    	//Declarando o objeto do browser
    Private aCabecalho  := {}         	//Variavel que montara o aHeader do grid
    Private aColsEx 	:= {}         	//Variavel que recebera os dados
    Private lRet        := .T.

     //Declarando os objetos de cores para usar na coluna de status do grid
    Private oVerde  	:= LoadBitmap( GetResources(), "BR_VERDE")
    Private oAzul  	    := LoadBitmap( GetResources(), "BR_AZUL")
    Private oVermelho	:= LoadBitmap( GetResources(), "BR_VERMELHO")
    Private oAmarelo	:= LoadBitmap( GetResources(), "BR_AMARELO")
   
    aSizeAut	:= MsAdvSize(,.F.,400)
	aInfo := { aSizeAut[ 1 ], aSizeAut[ 2 ], aSizeAut[ 3 ], aSizeAut[ 4 ], 3, 3 }

    //DEFINE MSDIALOG oDlg TITLE "Ordem de Producao x Solicitacao" FROM 000, 000  TO 800, 1024  PIXEL
    DEFINE MSDIALOG oDlg TITLE "Ordem de Producao x Solicitacao" STYLE DS_MODALFRAME FROM aSizeAut[7],0 TO aSizeAut[6],aSizeAut[5]  Of oMainWnd PIXEL 

        //chamar a funcao que cria a estrutura do aHeader
        CriaCabec()

        //Monta o browser com inclusao
        oLista := MsNewGetDados():New( 053, 078, 415, 775, GD_UPDATE,"U_ESTRO02", "AllwaysTrue", "AllwaysTrue", aACampos,1, 999, "AllwaysTrue", "", "AllwaysTrue", oDlg, aCabecalho, aColsEx)

         //Carregar os itens que irao compor o conteudo do grid e verifica se Ordem de producao tem saldo para atender
        If ! Carregar(cNumOP)
            Return
        EndIf

        //Alinho o grid para ocupar todo o meu formulario
        oLista:oBrowse:Align := CONTROL_ALIGN_ALLCLIENT

        //Ao abrir a janela o cursor esta posicionado no meu objeto
        oLista:oBrowse:SetFocus()

        //Crio o menu que ira aparece no botao Acoes relacionadas
        aadd(aBotoes,{"NG_ICO_LEGENDA", {||Legenda()},"Legenda","Legenda"})
      	
    ACTIVATE MSDIALOG oDlg CENTERED ON INIT ( EnchoiceBar(oDlg, {|| lOk:=.T.,U_ESTRO03( ), oDlg:End() }, {|| oDlg:End() },,aBotoes) )

Return 

Static Function CriaCabec()

     Aadd(aCabecalho, {;
                  "",;//X3Titulo()
                  "IMAGEM",;  //X3_CAMPO
                  "@BMP",;		//X3_PICTURE
                  3,;			//X3_TAMANHO
                  0,;			//X3_DECIMAL
                  ".F.",;			//X3_VALID
                  "",;			//X3_USADO
                  "C",;			//X3_TIPO
                  "",; 			//X3_F3
                  "V",;			//X3_CONTEXT
                  "",;			//X3_CBOX
                  "",;			//X3_RELACAO
                  "",;			//X3_WHEN
                  "V"})			//   
    Aadd(aCabecalho, {;
                  "Ordem Producao",;	//X3Titulo()
                  "OP",;  	//X3_CAMPO
                  "@!",;		//X3_PICTURE
                  TamSX3("D4_OP")[1],;			//X3_TAMANHO
                  0,;			//X3_DECIMAL
                  "",;			//X3_VALID
                  "",;			//X3_USADO
                  "C",;			//X3_TIPO
                  "SB1",;		//X3_F3
                  "R",;			//X3_CONTEXT
                  "",;			//X3_CBOX
                  "",;			//X3_RELACAO
                  ""})			//X3_WHEN     
    Aadd(aCabecalho, {;
                  "Codigo",;	//X3Titulo()
                  "CODIGO",;  	//X3_CAMPO
                  "@!",;		//X3_PICTURE
                  TamSX3("B1_COD")[1],;			//X3_TAMANHO
                  0,;			//X3_DECIMAL
                  "",;			//X3_VALID
                  "",;			//X3_USADO
                  "C",;			//X3_TIPO
                  "",;			//X3_F3
                  "R",;			//X3_CONTEXT
                  "",;			//X3_CBOX
                  "",;			//X3_RELACAO
                  ""})			//X3_WHEN                           
     Aadd(aCabecalho, {;
                  "Descricao",;	//X3Titulo()
                  "DESCRICAO",; //X3_CAMPO
                  "@!",;		//X3_PICTURE
                  TamSX3("B1_DESC")[1],;			//X3_TAMANHO
                  0,;			//X3_DECIMAL
                  "",;			//X3_VALID
                  "",;			//X3_USADO
                  "C",;			//X3_TIPO
                  "",;			//X3_F3
                  "R",;			//X3_CONTEXT
                  "",;			//X3_CBOX
                  "",;			//X3_RELACAO
                  ""})			//X3_WHEN
     Aadd(aCabecalho, {;
                  "Tipo",;//X3Titulo()
                  "TIPO",;  //X3_CAMPO
                  "@!",;		//X3_PICTURE
                  TamSX3("B1_TIPO")[1],;			//X3_TAMANHO
                  0,;			//X3_DECIMAL
                  "",;			//X3_VALID
                  "",;			//X3_USADO
                  "C",;			//X3_TIPO
                  "",; 			//X3_F3
                  "R",;			//X3_CONTEXT
                  "",;			//X3_CBOX
                  "",;			//X3_RELACAO
                  ""})			//X3_WHEN     
        Aadd(aCabecalho, {;
                  "Arm. Producao",;//X3Titulo()
                  "ARM_P",;  //X3_CAMPO
                  "@!",;		//X3_PICTURE
                  TamSX3("D4_LOCAL")[1],;//X3_TAMANHO
                  0,;			//X3_DECIMAL
                  "",;			//X3_VALID
                  "",;			//X3_USADO
                  "C",;			//X3_TIPO
                  "",; 			//X3_F3
                  "R",;			//X3_CONTEXT
                  "",;			//X3_CBOX
                  "",;			//X3_RELACAO
                  ""})			//X3_WHEN                             
        Aadd(aCabecalho, {;
                  "Qtd. Empenhada",;//X3Titulo()
                  "QTD_EMP",;  //X3_CAMPO
                  "@E 999,999,999.99",;		//X3_PICTURE
                  TamSX3("D4_QUANT")[1],;//X3_TAMANHO
                  2,;			//X3_DECIMAL
                  "",;			//X3_VALID
                  "",;			//X3_USADO
                  "N",;			//X3_TIPO
                  "",; 			//X3_F3
                  "R",;			//X3_CONTEXT
                  "",;			//X3_CBOX
                  "",;			//X3_RELACAO
                  ""})			//X3_WHEN  

        Aadd(aCabecalho, {;
                  "Qtd. Arm Producao",;//X3Titulo()
                  "QTD_ARM_P",;  //X3_CAMPO
                  "@E 999,999,999.99",;		//X3_PICTURE
                  TamSX3("D4_QUANT")[1],;//X3_TAMANHO
                  2,;			//X3_DECIMAL
                  "",;			//X3_VALID
                  "",;			//X3_USADO
                  "N",;			//X3_TIPO
                  "",; 			//X3_F3
                  "R",;			//X3_CONTEXT
                  "",;			//X3_CBOX
                  "",;			//X3_RELACAO
                  ""})			//X3_WHEN       

          Aadd(aCabecalho, {;
                  "Arm. Origem",;//X3Titulo()
                  "ARM_P",;  //X3_CAMPO
                  "@!",;		//X3_PICTURE
                  TamSX3("B1_LOCPAD")[1],;//X3_TAMANHO
                  0,;			//X3_DECIMAL
                  "",;			//X3_VALID
                  "",;			//X3_USADO
                  "C",;			//X3_TIPO
                  "",; 			//X3_F3
                  "R",;			//X3_CONTEXT
                  "",;			//X3_CBOX
                  "",;			//X3_RELACAO
                  ""})			//X3_WHEN                         

          Aadd(aCabecalho, {;
                  "Qtd. Arm Origem",;//X3Titulo()
                  "QTD_ARM_P",;  //X3_CAMPO
                  "@E 999,999,999.99",;		//X3_PICTURE
                  TamSX3("D4_QUANT")[1],;//X3_TAMANHO
                  2,;			//X3_DECIMAL
                  "",;			//X3_VALID
                  "",;			//X3_USADO
                  "N",;			//X3_TIPO
                  "",; 			//X3_F3
                  "R",;			//X3_CONTEXT
                  "",;			//X3_CBOX
                  "",;			//X3_RELACAO
                  ""})			//X3_WHEN       

        Aadd(aCabecalho, {;
                  "Qtd. A Transferir",;//X3Titulo()
                  "QTD_A_TRG",;  //X3_CAMPO
                  "@E 999,999,999.99",;		//X3_PICTURE
                  TamSX3("D4_QUANT")[1],;//X3_TAMANHO
                  2,;			//X3_DECIMAL
                  "",;			//X3_VALID
                  "",;			//X3_USADO
                  "N",;			//X3_TIPO
                  "",; 			//X3_F3
                  "R",;			//X3_CONTEXT
                  "",;			//X3_CBOX
                  "",;			//X3_RELACAO
                  ""})			//X3_WHEN 

Return

Static Function Carregar(cNumOP)

    Local aProdutos := {}
    Local i
    Local lRet := .T.
    Local nSaldo
    Local nSaldoOr

   //Tabela de Empenhos
    SD4->(dbSelectArea("SD4"))
    SD4->(dbSetOrder(2))

    If SD4->(dbSeek(xFilial("SD4") + Alltrim(cNumOP)))

        Do While SD4->(!EOF()) .And. SD4->D4_FILIAL + Alltrim(SD4->D4_OP) == xFilial("SD4") + Alltrim(cNumOP)     

            //Busca o Tipo do produto
            SB1->(DBSelectArea("SB1"))
            SB1->(DBSetOrder(1))
            SB1->(dbSeek(xFilial("SB1") + SD4->D4_COD))

            //Busca saldo produto - quantidade empenhada
            SB2->(dbSelectArea("SB2"))
            SB2->(dbSeek(xFilial("SB2") + SB1->B1_COD + SD4->D4_LOCAL))
            nSaldo := SaldoSb2()

             //Busca saldo produto - quantidade empenhada
            SB2->(dbSelectArea("SB2"))
            SB2->(dbSeek(xFilial("SB2") + SB1->B1_COD + SB1->B1_LOCPAD))
            nSaldoOr := SaldoSb2()

            //Preenche Array com dados OP
            aadd(aProdutos,{    SD4->D4_OP,;
                                SB1->B1_COD,;
                                SB1->B1_DESC,;
                                SB1->B1_TIPO ,;
                                SD4->D4_LOCAL,;
                                SD4->D4_QUANT,;
                                nSaldo,;
                                SB1->B1_LOCPAD,;
                                nSaldoOr,;
                                SD4->D4_QUANT})

        SD4->(dbSkip())
        Enddo    

    Else
        Alert("ATENCAO: Ordem de Producao " + cNumOP + " nao localizada, verifique os parametros!")            
        lRet := .F.
        Return (lRet)
    EndIf

    For i := 1 to len(aProdutos)
        aadd(aColsEx,{  oVerde,;
                        aProdutos[i,1],;
                        aProdutos[i,2],;
                        aProdutos[i,3],;
                        aProdutos[i,4],;
                        aProdutos[i,5],;
                        aProdutos[i,6],;
                        aProdutos[i,7],;
                        aProdutos[i,8],;
                        aProdutos[i,9],;
                        aProdutos[i,10],.F.})                                
    Next

    //Setar array do aCols do Objeto.
    oLista:SetArray(aColsEx,.T.)

    //Atualizo as informacoes no grid
    oLista:Refresh()

Return (lRet)

Static function Legenda()

    Local aLegenda := {}
    AADD(aLegenda,{"BR_AMARELO"     ,"   Tipo nao definido" })
    AADD(aLegenda,{"BR_AZUL"    	,"   Tipo PC" })
    AADD(aLegenda,{"BR_VERDE"    	,"   Tipo UN" })
    AADD(aLegenda,{"BR_VERMELHO" 	,"   Tipo MT" })

    BrwLegenda("Legenda", "Legenda", aLegenda)

Return Nil

User Function ESTRO02()

    Local lRet := .T.

    //Validação se solicitação ultrapassa empenho
    If lRet .And. aCols[n][11] > aCols[n][7]
        lRet := .F.
        Alert("ATENCAO: Quantidade a Transferir maior que o Empenho")
    EndIf

    //Verifica se a quantidade e maior que o saldo do armazem origem
    If lRet .And. aCols[n][11] > aCols[n][10]
        lRet := .F.
        Alert("ATENCAO: Quantidade a Transferir maior que o Saldo Armzem Origem")
    EndIf

Return lRet

User Function ESTRO03()

    Local lRet := .T.
    Local aAuto := {}
    Local aItem := {}
    Local aLinha := {}
    Local nX
    Local nOpcAuto := 3
    Local cNumDoc
    Private lMsErroAuto := .F.
        
    If MsgYesNo("ATENCAO: Confirma a solicitacao de transferencia ao armazem?")

        //Cabecalho a Incluir
        cNumDoc := GetSxeNum("SD3","D3_DOC")
        ConfirmSX8()
        
        aadd(aAuto,{cNumDoc ,dDataBase}) //Cabecalho

        //Itens a Incluir 
        aItem := {}

        For nX := 1 to len(oLista:aCols)

            aLinha := {}

             //Busca o dados produto
            SB1->(DBSelectArea("SB1"))
            SB1->(DBSetOrder(1))
            SB1->(dbSeek(xFilial("SB1") + oLista:aCols[nX][3] ))

            //Origem 
            aadd(aLinha,{"ITEM"     ,'00'+cvaltochar(nX),Nil})
            aadd(aLinha,{"D3_COD"   , SB1->B1_COD   , Nil}) //Cod Produto origem 
            aadd(aLinha,{"D3_DESCRI", SB1->B1_DESC  , Nil}) //descr produto origem 
            aadd(aLinha,{"D3_UM"    , SB1->B1_UM    , Nil}) //unidade medida origem 
            aadd(aLinha,{"D3_LOCAL" , oLista:aCols[nX][9]  , Nil}) //armazem origem 
            aadd(aLinha,{"D3_LOCALIZ", PadR("", tamsx3('D3_LOCALIZ') [1]),Nil}) //Informar endereÃ§o destino
            
            //Destino 
            aadd(aLinha,{"D3_COD"   , SB1->B1_COD   , Nil}) //cod produto destino 
            aadd(aLinha,{"D3_DESCRI", SB1->B1_DESC  , Nil}) //descr produto destino 
            aadd(aLinha,{"D3_UM"    , SB1->B1_UM    , Nil}) //unidade medida destino 
            aadd(aLinha,{"D3_LOCAL" , oLista:aCols[nX][6]  , Nil}) //armazem destino 
            aadd(aLinha,{"D3_LOCALIZ", PadR("", tamsx3('D3_LOCALIZ') [1]),Nil}) //Informar endereÃ§o destino

            aadd(aLinha,{"D3_NUMSERI", "", Nil}) //Numero serie
            aadd(aLinha,{"D3_LOTECTL", "", Nil}) //Lote Origem
            aadd(aLinha,{"D3_NUMLOTE", "", Nil}) //sublote origem
            aadd(aLinha,{"D3_DTVALID", '', Nil}) //data validade 
            aadd(aLinha,{"D3_POTENCI", 0, Nil}) // Potencia
            aadd(aLinha,{"D3_QUANT", oLista:aCols[nX][11], Nil}) //Quantidade
            aadd(aLinha,{"D3_QTSEGUM", 0, Nil}) //Seg unidade medida
            aadd(aLinha,{"D3_ESTORNO", "", Nil}) //Estorno 
            aadd(aLinha,{"D3_NUMSEQ", "", Nil}) // Numero sequencia D3_NUMSEQ

            aadd(aLinha,{"D3_LOTECTL", "", Nil}) //Lote destino
            aadd(aLinha,{"D3_NUMLOTE", "", Nil}) //sublote destino 
            aadd(aLinha,{"D3_DTVALID", '', Nil}) //validade lote destino
            aadd(aLinha,{"D3_ITEMGRD", "", Nil}) //Item Grade

            aadd(aLinha,{"D3_CODLAN", "", Nil}) //cat83 prod origem
            aadd(aLinha,{"D3_CODLAN", "", Nil}) //cat83 prod destino 

            
            aAdd(aAuto,aLinha)

        Next nX

        MSExecAuto({|x,y| mata261(x,y)},aAuto,nOpcAuto)

        If lMsErroAuto 
             MostraErro()
        else
            MsgInfo("Tranferencia realizada com sucesso, documento: " + cNumDoc )             
        EndIf

    EndIf

Return lRet