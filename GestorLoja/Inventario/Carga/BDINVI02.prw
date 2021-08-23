#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "TopConn.ch"

User Function BDINVI02()

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

        //Busca armazém para correção
        NNR->(DBSelectArea("NNR"))
        NNR->(DBSelectArea(1))  //NNR_FILIAL+NNR_CODIGO
        If NNR->(DBSeek( ( aDados[i][1] + aDados[i][2] ) ) )

            RecLock("NNR", .F.)
                NNR->NNR_XINV    := Alltrim(aDados[i][3])
                NNR->NNR_MSBLQL  := Alltrim(aDados[i][4])
                NNR->NNR_XACA    := Alltrim(aDados[i][5])
                NNR->NNR_XADE    := Alltrim(aDados[i][6])
                NNR->NNR_XAES    := Alltrim(aDados[i][7])
                NNR->NNR_XAFR    := Alltrim(aDados[i][8])
                NNR->NNR_XALV    := Alltrim(aDados[i][9])
            MsUnLock() 

        EndIf      

    Next i

    MsgInfo("Carga concluída com sucesso!","BDINVI02")

Return
