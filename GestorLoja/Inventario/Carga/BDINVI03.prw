#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "TopConn.ch"

User Function BDINVI03()

    Local aPergs 	 := {}
    Local cCaminho  := Space(90)
    Local aRet      := {}
    
    aAdd( aPergs ,{6,"Diretorio do Arquivo?"	,cCaminho	,"@!",,'.T.',80,.F.,"Arquivos CSV |*.csv " }) 
   
    If ParamBox(aPergs ,"Parametros ",aRet)
        processa( {|| ImporCSV(MV_PAR01) } ,'Aguarde Efetuando Importacao da Planilha' )
    EndIf

Return

Static Function ImporCSV(cFile)

    Local cLinha
    Local aDados := {}

    If ! Empty(cFile) 

		FT_FUSE(cFile)
		ProcRegua(FT_FLASTREC())
		FT_FGOTOP()
	
    	While !FT_FEOF()
			
			IncProc("Selecionando Registros...")
	 
			cLinha := FT_FREADLN()
           
                If LEN(cLinha) > 0
                    AADD( aDados, Separa( cLinha, ';', .T.) )
                EndIf
                
    		FT_FSKIP()
		EndDo

    EndIf    


    For i := 2 to Len(aDados)  //Leitura do Array importacao dos dados

        //Busca armaz?m para corre??o
        SB5->(DBSelectArea("SB5"))
        SB5->(DBSelectArea(1))  //NNR_FILIAL+NNR_CODIGO
        If SB5->(DBSeek( ( xFilial("SB5") + aDados[i][1] ) ) )
            RecLock("SB5", .F.)           
        Else       
            RecLock("SB5", .T.) 

            //Procura descri??o padr?o do produto
            SB1->(dbSelectArea("SB1"))
            SB1->(dbSetOrder(1))
            SB1->(dbSeek (xFilial("SB1") + aDados[i][1] ))
                        
            SB5->B5_COD     := aDados[i][1]
            SB5->B5_CEME    := SB1->B1_DESC 
            SB5->B5_UMIND   := "1"

        EndIf                 

            SB5->B5_XDESINV := aDados[i][2]
            SB5->B5_XGPR1   := cValToChar(val(aDados[i][3]))
            SB5->B5_XGPR2   := StrZero( val(aDados[i][4]) ,2)

            SB5->B5_XUNCF   := IIF( Alltrim(aDados[i][5]) == "N/A", "", Alltrim(aDados[i][5]) )
            SB5->B5_XFACF   := IIF( Alltrim(aDados[i][6]) == "N/A", 0, VAL(STRTRAN(STRTRAN(aDados[i][6], ".",""),",",".")))     

            SB5->B5_XUNDE   := IIF( Alltrim(aDados[i][7]) == "N/A", "", Alltrim(aDados[i][7]) )
            SB5->B5_XFADE   := IIF( Alltrim(aDados[i][8]) == "N/A", 0, VAL(STRTRAN(STRTRAN(aDados[i][8], ".",""),",",".")) )
            
            SB5->B5_XUNES   := IIF( Alltrim(aDados[i][9]) == "N/A", "", Alltrim(aDados[i][9]) )
            SB5->B5_XFAES   := IIF( Alltrim(aDados[i][10]) == "N/A", 0, VAL(STRTRAN(STRTRAN(aDados[i][10], ".",""),",",".")) )          
            
            SB5->B5_XUNFR   := IIF( Alltrim(aDados[i][11]) == "N/A", "", Alltrim(aDados[i][11]) )           
            SB5->B5_XFAFR   := IIF( Alltrim(aDados[i][12]) == "N/A", 0, VAL(STRTRAN(STRTRAN(aDados[i][12], ".",""),",",".")) )  

            SB5->B5_XUNLV   := IIF( Alltrim(aDados[i][13]) == "N/A", "", Alltrim(aDados[i][13]) )
            SB5->B5_XFALV   := IIF( Alltrim(aDados[i][14]) == "N/A", 0, VAL(STRTRAN(STRTRAN(aDados[i][14], ".",""),",",".")) )        

            MsUnLock() 

    Next i

    MsgInfo("Carga conclu?da com sucesso!","BDINVI03")

Return
