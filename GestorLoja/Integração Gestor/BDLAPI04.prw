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
Local _cLoja := ""
             
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

if oData:quantidade < 0
	//Retorna Forbidden (nao autorizado)
	SetRestFault(405,"Ordem de Producao menor que zero " + cValToChar(oData:quantidade))
	return .F.
endif

dDataBase := stod(oData:dataProd)

//Tratamento para loja 
_cLoja := SUBSTR(oData:armazem,1,6)

/*
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
*/

	CTT->(dbSelectArea("CTT"))
	CTT->(dbSetOrder(1))
	If ! CTT->(dbSeek( xFilial("CTT") + _cLoja))
		
		//Retorna Forbidden (nao autorizado)
		SetRestFault(406,"Filial de consumo incorreta " + _cLoja + " Original " + oData:armazem )
		return .F.	

	EndIf

	//Numero de Ordem de Produçăo	
	cOPNum	:= GetSxeNum("ZZ6","ZZ6_OP")

	ZZ6->(dbSelectArea("ZZ6"))
	ZZ6->(dbSetOrder(1))
	
	ZZ6->(RecLock("ZZ6",.T.))
		ZZ6->ZZ6_FILIAL := CTT->CTT_FILMAT
		ZZ6->ZZ6_LOCAL 	:= _cLoja
		ZZ6->ZZ6_PROD 	:= oData:produto
		ZZ6->ZZ6_OP		:= cOPNum
		ZZ6->ZZ6_QUANT 	:= oData:quantidade
		ZZ6->ZZ6_DATA	:= Stod(oData:dataProd)
		ZZ6->ZZ6_DTIMP	:= Date()
		ZZ6->ZZ6_HRIMP	:= TIME()
		ZZ6->ZZ6_TIPO	:= "C"
	ZZ6->( MsUnlock() )
	ConfirmSX8()
//dummy response para evitar processamento assíncrono
::SetResponse('{"Doc":"' + cOPNum + '"}')
return .T.                                    
