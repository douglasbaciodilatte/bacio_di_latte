#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"
                                
USER FUNCTION BDLAPI04
RETURN

WSRESTFUL CONSUMO DESCRIPTION "Servico Rest para Consumo de Produto GestorLoja"

WSMETHOD POST DESCRIPTION "Metodo responsável por apontar o consumo do produto informado" WSSYNTAX "/CONSUMO"

END WSRESTFUL

WSMETHOD POST WSSERVICE CONSUMO

Local cBody := ::GetContent() //retorna o conteudo do body
Local cKey := SuperGetMV("MV_XAPIKEY",.F.,"1234")
Local aOP := {}   
Local cDOCNum := ""     
Local aProd := {}                              
Local cTmProd := SuperGetMV("MV_XTMCONS", .F., "502")
Local cJsonErro := '{"erro":"'      
Local aLog := {}                     
Local i := 0
             
Private oData //objeto com os dados do body

Private lMsErroAuto := .F.
Private lAutoErrNoFile := .T.
// define o tipo de retorno do método
::SetContentType("application/json")
//Desenvolvimento Rodolfo Vacari -- 11/01/2020
If Intransaction()
    DisarmTransaction()
    SetRestFault(500, '{"erro - Thread em Aberto"}')
    ConOut("Erro - Thread em aberto...")   
	return .F.
EndIf
//FIM ajuste
                                                
//valida se o json foi deserealizado
if !FWJsonDeserialize(cBody, @oData)		
	//Retorna BadResquest
	SetRestFault(400, "ERROR ON DESERIALIZE JSON, VERIFY JSON ON BODY")
	return .F.
endif                                   

//verifica se os dados foram preenchidos corretamente
if type("oData:apiKey") == "U" .or. type("oData:armazem") == "U" .or. type("oData:produto") == "U" ;
		.or. type("oData:quantidade") == "U" .or. type("oData:dataProd") == "U"
	//Retorna BadResquest
	SetRestFault(400, "Invalid JSON Body")
	return .F.	
endif
          
if cKey != oData:apiKey       
	//Retorna Forbidden (nao autorizado)
	SetRestFault(403,"Falha durante o login, verifique a chave")
	return .F.
endif

dDataBase := stod(oData:dataProd)

begin transaction
   
	//Consumo                        
	aAdd(aProd, {"D3_FILIAL", XFILIAL("SD3") , NIL})
	aAdd(aProd, {"D3_TM", cTmProd, NIL})
	aAdd(aProd, {"D3_COD", oData:produto, NIL})     
	aAdd(aProd, {"D3_QUANT", oData:quantidade, NIL})
	aAdd(aProd, {"D3_DOC", Substr(oData:Produto,1,6)+cTmProd, NIL})
	aAdd(aProd, {"D3_LOCAL", oData:armazem, NIL})
	aAdd(aProd, {"D3_EMISSAO", stod(oData:dataProd), NIL})
	aAdd(aProd, {"D3_CC", oData:armazem, NIL})
	cDOCNum := Substr(oData:Produto,1,6)+cTmProd
	                       
	msExecAuto({|x, y| Mata240(x, y)}, aProd, 3)

	if lmsErroAuto		            
		aLog := GetAutoGrLog()
		aEval(aLog, {|x| cJsonErro += x })//gera o json a ser retornado
		cJsonErro += '"}"'		
		::SetResponse(cJsonErro) 
		//Seta o StatusCode para 500 internal server error	
		SetRestFault(500, cJsonErro)
		DisarmTransaction()
		return .F.
	endif                                                 
	                                                  
	
end transaction
//dummy response para evitar processamento assíncrono
::SetResponse('{"Doc":"' + cDOCNum + '"}')
return .T.                                    