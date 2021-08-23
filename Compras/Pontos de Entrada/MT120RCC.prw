#Include 'Protheus.ch'      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณMT120RCC  บAutor  ณAndre Sarraipa      บ Data ณ  05/25/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImporta o rateio de centro de custo a partir de um CSV      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Milano                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function MT120RCC()

Local aHeaderCH  := PARAMIXB[1]
Local aColsCH    := PARAMIXB[2]  
Local nX         := 0
Local nY         := 0
Local lOk        := .T.     
Local cArq       := ""
Local cLinha     := ""
Local lPrim      := .T.
Local aCampos    := {}
Local aDados     := {}            
LOCAL nCont      := 0  
Local nQtd		 := 0
Local nVlunit	 := 0     
Local nPerc_     := 0


If Altera .OR. Inclui

		If MsgYesNo( 'Gostaria de importar o rateio de um arquivo CSV.', 'BACIO' )
           
            if empty(aColsCH[1][3])                   
                   
            	msgalert("A planilha deve ser salva no padrao CSV separado por virgula."+ Chr(13) + Chr(10) + Chr(13) + Chr(10)+"Na primeira linha deve fica o nome de cada coluna:";            	
            	+Chr(13) + Chr(10)+"Na primeira coluna deve ficar o centro de custo.";
            	+Chr(13) + Chr(10)+"Na segunda coluna deve ficar o percentual.";
            	+Chr(13) + Chr(10)+ Chr(13) + Chr(10)+"Como o centro de custo tem 6 digitos a rotina completa com 0 a esquerda. ")
            
  				cArq := cGetFile('Arquivo *|*.csv|Arquivo csv|*.csv','Todos os Drives',0,'C:\Dir\',.T.,GETF_LOCALHARD+GETF_NETWORKDRIVE,.T.)  
  			
  			else     
  			
  				msgalert("O pedido ja possui rateio!") 
  			    Return aColsCH
  			    
  			endif
	              
   			//Valida se o arquivo foi selecionado para nใo dar aerro
  			if empty(cArq)   
   	  			Return aColsCH
  			endif

 
		Else
 
  			Return aColsCH

		Endif     

ELSE
    
	Return aColsCH

ENDIF
                              

//***********INcluido para ler csv  



FT_FUSE(cArq)
ProcRegua(FT_FLASTREC())
FT_FGOTOP()
While !FT_FEOF()
 
	IncProc("Lendo arquivo texto...")
 
	cLinha := FT_FREADLN()
 
	If lPrim
		aCampos := Separa(cLinha,";",.T.)
		lPrim := .F.
	Else
		AADD(aDados,Separa(cLinha,";",.T.))    
		
			nCont++                                       
		
	EndIf                       
 
	FT_FSKIP()
	
EndDo
       

If !EMPTY(aDados)


  For nX:=1 To len(aDados) 
	   
   
	IF !empty(aDados[nx,1])
	
	dbSelectArea("CTT") 
	dbSetOrder(1)

	If dbSeek(xFilial("CTT")+PADL(aDados[nx,1],6,"0")) 


  		nPerc_ := VAL(strtran(aDados[nx,2],',','.'))

        if nx == 1
			aColsCH[nx][1] := PADL(nx,2,"0")	
			aColsCH[nx][2] := nPerc_              	
			aColsCH[nx][3] := PADL(aDados[nx,1],6,"0")
			aColsCH[nx][4] := ""
			aColsCH[nx][5] := ""    
			aColsCH[nx][6] := ""    

	    Else 
			AADD(aColsCH,Array(Len(aHeaderCH)+1))   
			aColsCH[nx][1] := PADL(nx,2,"0")
			aColsCH[nx][2] := nPerc_
			aColsCH[nx][3] := PADL(aDados[nx,1],6,"0")
			aColsCH[nx][4] := ""
			aColsCH[nx][5] := ""    
			aColsCH[nx][6] := ""         
  		Endif  
	ELSE
	
   		MSGALERT("O centro de custo: "+PADL(aDados[nx,1],6,"0")+" nใo foi encontrado!")  		

	ENDIF
  
   endif  //Fim do if que ve se o centro de custo esta preenchido
  		
  Next nX  	


ENDIF //FIM DO If !EMPTY(aDados)

Return aColsCH