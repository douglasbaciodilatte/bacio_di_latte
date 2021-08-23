#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "TopConn.ch"

User Function BDINVI01()

    Local aPergs 	 := {}
    Local cCaminho  := Space(90)
    Local aRet      := {}
    
    aAdd( aPergs ,{6,"Diretorio do Arquivo?"	,cCaminho	,"@!",,'.T.',80,.F.,"Arquivos .xlsx |*.sql " }) 
   
    If ParamBox(aPergs ,"Parametros ",aRet)
        processa( {|| ImporSQL(MV_PAR01) } ,'Aguarde Efetuando Importacao da Planilha' )
    EndIf

Return

Static Function ImporSQL(cFile)

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
			    AADD( aDados,cLinha )
			EndIf
	
			FT_FSKIP()
		EndDo

    EndIf    


    For i := 1 to Len(aDados)  //Leitura do Array importacao dos dados

        TCLink()
    
        nStatus := TCSqlExec( aDados[i] )
        
        if (nStatus < 0)
            MsgInfo( "TCSQLError() " + TCSQLError() )
        endif
        
        TCUnlink()
    
    Next i

Return
