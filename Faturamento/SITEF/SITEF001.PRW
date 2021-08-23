#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "TopConn.ch"

Static __oHashCFil  := Nil  //Objeto do tipo LJCHasheTable com as filiais cadastradas para importacao
Static __oHashTef	:= Nil	//Objeto do tipo LJCHasheTable com as filiais cadastradas nos parametros - Software Express
Static __oHashAme	:= Nil	//Objeto do tipo LJCHasheTable com as filiais cadastradas nos parametros - Amex
Static __oHashCie	:= Nil	//Objeto do tipo LJCHasheTable com as filiais cadastradas nos parametros - Cielo
Static __oHashRed	:= Nil	//Objeto do tipo LJCHasheTable com as filiais cadastradas nos parametros - Rede

Static oParamFil   := Nil		//Objeto do tipo LJCHasheTable com as filiais cadastradas nos parametros 

/*/{Protheus.doc} User Function SITEF001
    (long_description)
    @type  Function
    @author Douglas Rodrigues da Silva
    @since 16/06/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function SITEF001()

    Local aPergs 	 := {}
    Local cCaminho  := Space(90)
    Local aRet      := {}

    aAdd( aPergs ,{6,"Diretorio do Arquivo?"	,cCaminho	,"@!",,'.T.',80,.F.,"Arquivos .xlsx |*.csv " }) 
   
    If ParamBox(aPergs ,"Parametros ",aRet)
        processa( {|| ImporCSV(MV_PAR01) } ,'Aguarde Efetuando Importacao da Planilha' )
    EndIf

RETURN

/*/

    {Protheus.doc} ImporCSV()

/*/

Static Function ImporCSV(cFile)

    Local cLinha
    Local lPrim         := .T.
    Local aCampos       := {}
    Local aDados        := {}
    Local nDecVlBrut    := TamSX3("FIF_VLBRUT")[2]
    Local nDecVlliq  	:= TamSX3("FIF_VLLIQ")[2]
    Local nTamParcel 	:= TamSX3("FIF_PARCEL")[1]
    Local cNPARC
    Local nDecVlCom 	:= TamSX3("FIF_VLCOM")[2]
    Local nDecTxServ 	:= TamSX3("FIF_TXSERV")[2]
    Local nTamNSUTEF 	:=  TamSX3("FIF_NSUTEF")[1]
    Local nTAmCodFil 	:= TamSX3("FIF_CODFIL")[1]
    Local cCodLojaAnt   := ""
    Local cContaAnt     := ""
    Private cSeqFIF
    Private aBanco        := {}
	Private nTamCodEst 	:= TamSX3("FIF_CODEST")[1]
    

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
                
                If SUBSTR(cLinha,1,1) == "1"
				    AADD(aDados,Separa(cLinha,";",.T.))
				EndIf

			EndIf
			
			FT_FSKIP()
		EndDo

    EndIf

     //Efetua leitura dos dados
    ProcRegua( Len(aDados) )
    Begin Transaction

        For i := 1 to Len(aDados)  //Leitura do Array importacao dos dados
        
            IncProc("Importando dados tabela FIF...")

            FIF->(dbSelectArea("FIF"))
            FIF->(dbSetOrder(4)) //FIF_FILIAL+DTOS(FIF_DTCRED)+FIF_NSUTEF+FIF_PARCEL+FIF_CODEST+FIF_CODRED

            If( aDados[i][15] == '0') .Or. ( aDados[i][15] == '00')
                cNPARC := StrZero(Val("01"),nTamParcel)
            Else
                cNPARC := STRZERO(VAL(aDados[i][15]),nTamParcel)
            EndIf

            //Busca Filial para importação      
            If cCodLojaAnt != aDados[i][24]  
                cMsFil := CARFIL( aDados[i][24] )
            EndIf                            
        
            cNSUSitef	:= Alltrim( aDados[i][6] ) + Space(nTamNSUTEF - Len(Alltrim( aDados[i][6] )) )
            cCodLoj     := Alltrim( aDados[i][24] ) + Space(nTAmCodFil  - Len(Alltrim(aDados[i][24])) )	
            cSeqFIF     := A910SeqFIF(aDados[i][4], aDados[i][6], aDados[i][15], aDados[i][24], aDados[i][13])	

            FIF->(dbSetOrder(5)) //FIF_FILIAL+DTOS(FIF_DTTEF)+FIF_NSUTEF+FIF_PARCEL+FIF_CODLOJ+DTOS(FIF_DTCRED)+FIF_SEQFIF             
            If !    FIF->( MsSeek( xFilial("FIF") +;
                    DTOS(STOD(aDados[i][4])) +;
                    cNSUSitef + ;
                    cNPARC +;
                    aDados[i][24] +;
                    DTOS( STOD(aDados[i][13]) ) +;
                    cSeqFIF ) )			
                					
                RecLock("FIF", .T.)

                    FIF->FIF_FILIAL := xFilial("FIF")
                    FIF->FIF_TPREG  := aDados[i][1]
                    FIF->FIF_INTRAN := aDados[i][2]
                    FIF->FIF_CODEST := aDados[i][3]
                    FIF->FIF_DTTEF  := STOD(aDados[i][4])
                    FIF->FIF_NURESU := STRZERO(VAL(aDados[i][5]),10)
                    FIF->FIF_NSUTEF := aDados[i][7]
                    FIF->FIF_NUCOMP := STRZERO(val(aDados[i][6]),12)  
                    FIF->FIF_NUCART := aDados[i][8]
                    FIF->FIF_VLBRUT := Round(Val( aDados[i][9] )/100,nDecVlBrut)
                    FIF->FIF_TOTPAR := aDados[i][10]
                    FIF->FIF_VLLIQ  := Round(Val( aDados[i][11] )/100,nDecVlliq)
                    FIF->FIF_DTCRED := STOD(aDados[i][13])
                    FIF->FIF_PARCEL := cNPARC
                    FIF->FIF_TPPROD := aDados[i][16]
                    FIF->FIF_CAPTUR := aDados[i][17]
                    FIF->FIF_CODRED := aDados[i][18]
                    FIF->FIF_VLCOM  := Round(Val( aDados[i][22] )/100,nDecVlCom)  
                    FIF->FIF_TXSERV := Round(Val( aDados[i][23] )/100,nDecTxServ)
                    FIF->FIF_CODLOJ := aDados[i][24]
                    FIF->FIF_CODAUT := aDados[i][25]
                    FIF->FIF_CUPOM  := aDados[i][26]
                    FIF->FIF_SEQREG := StrZero(i,6)
                    FIF->FIF_STATUS := "1"
                    FIF->FIF_STVEND := Iif(aDados[i][16] == "A", "1", " ")
                    FIF->FIF_MSIMP  := dTos( Date() )
                    FIF->FIF_CODFIL := cMsFil
                    FIF->FIF_CODBAN := aDados[i][27]
                    FIF->FIF_DTVEN  := STOD(aDados[i][28])  
                    FIF->FIF_SEQFIF := cSeqFIF                 
                    
                        ZZ1->(dbSelectarea("ZZ1"))
                        ZZ1->(dbSetOrder(1))

                        If ZZ1->(dbSeek(xFilial("ZZ1") + Alltrim(aDados[i][21]) ))
                            FIF->FIF_CODBCO := ZZ1->ZZ1_COD
                            FIF->FIF_CODAGE := ZZ1->ZZ1_AGENCI
                            FIF->FIF_NUMCC  := ZZ1->ZZ1_NUMCON
                        else
                            FIF->FIF_CODBCO  := Alltrim(aDados[i][19]) 
                            FIF->FIF_CODAGE  := Alltrim(aDados[i][20]) 
                            FIF->FIF_NUMCC   := Alltrim(aDados[i][21])        
                        EndIf                                                          
                                     
                MsUnLock() 

            EndIf

            cCodLojaAnt := aDados[i][24]
            cContaAnt   := Alltrim(aDados[i][21])

        Next i
    End Transaction   

Return 

User Function SITEF002(_cConta)

   // Local cQuery := ""
    
    ZZ1->(dbSelectarea("ZZ1"))
    ZZ1->(dbSetOrder(1))

    If ZZ1->(dbSeek(xFilial("ZZ1") + _cConta ))

        aAdd(aBanco, {ZZ1->ZZ1_COD, ZZ1->ZZ1_AGENCI, ZZ1->ZZ1_NUMCON })

    EndIf

Return (aBanco)

Static Function CARFIL(cFifCodLoj)

 	Local cFilSitef := ''        //Variavel que armazenara da filial SiTef
    Local aArrFil   as Array 
	Local nX		as Numeric
    Local cRetorno  := ""

	oParamFil := LJCHashTable():New()

	// Recupera todas as filias 
	aArrFil := FWAllFilial(,,,.F.)

	For nX := 1 to Len(aArrFil)
		
        If Empty(cRetorno)
           
            cFilSitef := SuperGetMv("MV_EMPTEF",.F.,"",aArrFil[nX])
        
            If Alltrim(cFilSitef) == Alltrim(cFifCodLoj)
                cRetorno := aArrFil[nX]
            EndIf

        EndIf

	Next nX 

Return cRetorno

Static Function A910SeqFIF(cDtVend, cNsuTef, cParcela, cCodLoja, cDtCred)

	Local aOrdFIF := FIF->(GetArea())    //Area FIF
	Local cQuery := ""
    Local nTamNSUTEF 	:=  TamSX3("FIF_NSUTEF")[1]
	Local nTamParcel 	:= TamSX3("FIF_PARCEL")[1]
    Local nTAmCodFil 	:= TamSX3("FIF_CODFIL")[1]

	cNsuTef		:= Alltrim(cNsuTef)  + Space(nTamNSUTEF - Len(Alltrim(cNsuTef)))
	cParcela	:= Alltrim(cParcela) + Space(nTamParcel - Len(Alltrim(cParcela)))				
	cCodLoja    := Alltrim(cCodLoja) + Space(nTAmCodFil - Len(Alltrim(cCodLoja)))

	// se cSeqFif em branco, ainda não buscou o ultimo sequencial
	If Empty(cSeqFIF)                                      
		cQuery := " SELECT MAX(FIF_SEQFIF) MAXFIF FROM " + RetSqlName("FIF") 
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB")
		If TRB->(!Eof())                      
			cSeqFIF := Soma1(TRB->MAXFIF) 
		Else                        
			cSeqFIF := Soma1("000000")	   	
		EndIf   	
		TRB->(DbCloseArea())
	Else
		//se já estiver preenchido o sequencial, só somar 1 
		cSeqFIF := Soma1(cSeqFIF)
	EndIf

	RestArea(aOrdFIF)

Return cSeqFIF    
