#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"  
#include "Totvs.ch"    


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณBDLIMPE2  บAutor  ณAndre Sarraipa      บ Data ณ  01/01/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Importacao de titulos contas a pagar                       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Bacio                                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function BDLIMPE2() 

Local nX     := 0
Local nY     := 0
Local lOk    := .T.     
Local cArq     := ""
Local cLinha   := ""
Local lPrim    := .T.
Local aCampos  := {}
Local aDados   := {}            
LOCAL nCont    := 0  
Local nQtd		:= 0
Local nVlunit		:= 0  

//PRIVATE lMsErroAuto := .F.  


cArq := cGetFile('Arquivo *|*.csv|Arquivo csv|*.csv','Todos os Drives',0,'C:\Dir\',.T.,GETF_LOCALHARD+GETF_NETWORKDRIVE,.T.)

//***********INcluido para ler csv  

//Valida se o arquivo foi selecionado para nใo dar aerro
if empty(cArq)   
   Return(.T.)
endif



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


MsAguarde({||IMPSE2(aDados,nCont)},"Aguarde","Gerando dados para a Planilha",.F.) 

Return(.T.)
           

Static Function IMPSE2(aDados,nCont) 
Local aArray := {}
Local nX := 0
Local nY := 0
Local lOk := .T.  
Local nQtd		:= 0
Local nVlunit	:= 0   
LOCAL cQuery :=""   
Local _dDate

PRIVATE lMsErroAuto := .F.  


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//| Inclusao |
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู 
// { "E2_CCUSTO"   , aDados[nx,7]      , NIL },;       
//{ "E2_LOJA"     , aDados[nx,6]      , NIL },;  


If !EMPTY(aDados)


  For nX:=1 To len(aDados) 
 
  aArray := {}      
  nVlunit	:= Val(StrTran(aDados[nx,11],',','.'))  
  lMsErroAuto := .F.           
  

	cQuery := " SELECT E2_NUM FROM " + RetSqlName("SE2") 
    cQuery += "    WHERE E2_PREFIXO = '"+aDados[nx,1]+"'  AND  E2_NUM = '"+aDados[nx,2]+"'  AND  E2_PARCELA= '"+aDados[nx,3]+"' "
    cQuery += "  AND E2_TIPO='"+aDados[nx,4]+"' AND  E2_FORNECE='"+aDados[nx,6]+"' AND E2_LOJA='"+aDados[nx,7]+"' "  
    cQuery += "   AND D_E_L_E_T_ = ''" 

     if Select("TE1") <> 0 
      TE1->(dbCloseArea()) 
     End if   
     
     TCQuery cQuery New Alias "TE1" 
     
	if !Empty(TE1->E2_NUM) 
    
            	MSGALERT("O Titulo jแ existe: PREFIXO:"+aDados[nx,1]+" NUM:"+aDados[nx,2]+" PARCELA:"+aDados[nx,3]+" TIPO:"+aDados[nx,4]+" FORNECE:"+aDados[nx,6]+" LOJA:"+aDados[nx,7])                                                                                  

	ELSE	
           
  		aArray := { { "E2_PREFIXO", aDados[nx,1] , NIL },; 
            { "E2_NUM"      , aDados[nx,2]       , NIL },;   
            { "E2_PARCELA"  , aDados[nx,3]       , NIL },;
            { "E2_TIPO"     , aDados[nx,4]       , NIL },;
            { "E2_NATUREZ"  , aDados[nx,5]       , NIL },;
            { "E2_FORNECE"  , aDados[nx,6]       , NIL },;
            { "E2_LOJA"     , aDados[nx,7]       , NIL },;  
            { "E2_CCUSTO"   , aDados[nx,8]       , NIL },;
            { "E2_EMISSAO"  , CtoD(aDados[nx,9]) , NIL },;
            { "E2_VENCTO"   , CtoD(aDados[nx,10]), NIL },;
            { "E2_VALOR"    , nVlunit            , NIL },;    
            { "E2_HIST"     , Alltrim(aDados[nx,12]), NIL }}
         
        _dDate := dDataBase   
        dDataBase := CtoD(aDados[nx,13])                         
            
			MsExecAuto( { |x,y,z| FINA050(x,y,z)}, aArray,, 3)  // 3 - Inclusao, 4 - Altera็ใo, 5 - Exclus?    
			
			If lMsErroAuto  
			
	    		MostraErro() 
	        ELSE
				nQtd++
			Endif
			
		dDataBase := _dDate 
		
   ENDIF
			
  Next nX 
 

 
Endif

 
//If lMsErroAuto
 //   MostraErro()
//Else
  //  Alert("T?ulo inclu?o com sucesso!")
//Endif
         

MSGALERT("Processo concluido!"+ Chr(13) + Chr(10) +"QUANTIDADE INCLUIDO: "+cValToChar(nQtd))
  

Return()