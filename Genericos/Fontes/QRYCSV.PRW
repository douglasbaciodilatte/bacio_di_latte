//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"
#include "fileio.ch"
  
/*/{Protheus.doc} Extrator
Função tem como objetivo gerar querys e exportar em excel
@author Douglas Silva
@since 03/01/2019
@version 1.0
    @obs Cuidado com colunas com mais de 200 caracteres, pode ser que o Excel dê erro ao abrir o XML
/*/
  
User Function QRYCSV(cQuery)

    Default cQryAux   := ""
    Default cTitAux   := "Título"
     
    Processa({|| fProcessa(cQuery, cTitAux) }, "Processando...")
Return
 
/*---------------------------------------------------------------------*
 | Func:  fProcessa                                                    |
 | Desc:  Função de processamento                                      |
 *---------------------------------------------------------------------*/
 
Static Function fProcessa(cQuery, cTitAux)

	//Local lRetDir	  := IIF(ExistDir( "C:\TOTVS\RELATORIOS\" ),.T., FM_Direct("C:\TOTVS\RELATORIOS\", .F., .F.))
    //Local cDiretorio  := "C:\TOTVS\RELATORIOS\"
    Local cDiretorio  := cGetFile( '*.csv|*.csv' , 'Selecionar um diretório para salvar', 1, 'C:\', .F., nOR( GETF_LOCALHARD, GETF_LOCALFLOPPY, GETF_RETDIRECTORY ),.T., .T. )
	Local cArquivo    := "QRYCSV" + "_" + DTOS(DATE()) + "_" + SUBSTR(TIME(),1,2 ) + SUBSTR(TIME(),4,2 ) + SUBSTR(TIME(),7,2 ) + '.csv'
    Local cArqFull    := cDiretorio + cArquivo
    Local nHnd 	
	Local aEstrut
	Local nAux
	Local cTitulo
	Local aColunas 	  := {}
	Local cDados
	Local nLin	:= 0
	Local nLinT := 0

	//Verifica se query está vazia
	If Empty(cQuery)
		Alert("Consulta com problema não foi possível gerar arquivo!")
		Return
	EndIf
	
	nHnd := FCreate(cArqFull)
	
	If nHnd == -1
	  MsgStop("Falha ao criar arquivo ["+cArqFull+"]","FERROR "+cValToChar(fError()))
	  Return
	Endif

	//Execulta Select Banco de dados
	If Select("TRB") > 0
		Dbselectarea("TRB")
		TRB->(DbClosearea())
	EndIf
	
	TcQuery cQuery New Alias "TRB"
	
	//Organiza estrutura do arquivo
	DbSelectArea('SX3')
    SX3->(DbSetOrder(2)) //X3_CAMPO
     
    //Percorrendo a estrutura
    aEstrut := TRB->(DbStruct())
    ProcRegua(Len(aEstrut))
    For nAux := 1 To Len(aEstrut)
        
        //IncProc("Buscando Informações Tabela") 
        
         cTitulo := ""
         
        //Se conseguir posicionar no campo
        If SX3->(DbSeek(aEstrut[nAux][1]))
            cTitulo := Alltrim(SX3->X3_TITULO)             
        Else
            cTitulo := Capital(Alltrim(aEstrut[nAux][1]))
        EndIf
         
    	//Adicionando nas colunas
        aAdd(aColunas, cTitulo)
    Next

	// Abre o arquivo
	TRB->(dbGoTop())
	
	//Gera Cabeçalho Query
	For nAux := 1 To Len(aColunas)
	
		If nAux == 1
			cTitulo := aColunas[nAux]
		Else
			cTitulo += ";" + aColunas[nAux]
		EndIf
			
	Next nAux
	
	FWrite(nHnd,cTitulo + CHR(13)+CHR(10))
	
	TRB->(dbGoTop())
	ProcRegua(RecCount())
	nLinT := RecCount()	
	TRB->(dbGoTop())
		
	Do While TRB->(!EOF())
	
		IncProc("Gravando Dados CSV " + cValToChar(nLin) + " / " + cValToChar( nLinT )) 
		
	 	aLinhaAux := Array(Len(aColunas))
        For nAux := 1 To Len(aEstrut)
            
            If Empty( cDados ) 
            	cDados := &("TRB->"+aEstrut[nAux][1])
            Else
            	
            	cDados += ';'
            	
            	If ValType(&("TRB->"+aEstrut[nAux][1])) == "C"
            		
            		cDados += &("TRB->"+aEstrut[nAux][1])
            	
            	ElseIf ValType(&("TRB->"+aEstrut[nAux][1])) == "N"	
            		            		         	
            		cDados += TRANSFORM(&("TRB->"+aEstrut[nAux][1]), "@E 999,999,999.99")  
            	
            	EndIf	
            	
            EndIf
            	 
        Next
            
        //Grava linha no arquivo
        FWrite(nHnd,cDados + CHR(13)+CHR(10))
        cDados := ""
        nLin++
		TRB->(dbSkip())
	Enddo	
	
	fclose(nHnd)
    MsgAlert('ATENÇÃO: Arquivo gerando com sucesso ' + cArqFull)
  
Return