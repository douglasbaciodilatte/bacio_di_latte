#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"
                                
USER FUNCTION BDLAPI03
RETURN

WSRESTFUL PRODUCAO DESCRIPTION "Serviço Rest para Apontamento de Produção"

WSMETHOD POST DESCRIPTION "Metodo responsável por apontar a producao da receita para o produto informado" WSSYNTAX "/PRODUCAO"

END WSRESTFUL

WSMETHOD POST WSSERVICE PRODUCAO

Local cBody := ::GetContent() //retorna o conteudo do body
Local cKey := SuperGetMV("MV_XAPIKEY",.F.,"1234")
Local aOP := {}   
Local cOPNum := ""     
Local cOPComp := ""
Local aProd := {}
Local aCabecPerda := {}      
Local aItensPerda := {}                                
Local aItemPerda := {}
Local cTmProd := SuperGetMV("MV_XTMPROD", .F., "001")
Local cJsonErro := '{"erro":"'      
Local aLog := {}                     
Local i := 0
             
Private oData //objeto com os dados do body

Private lMsErroAuto := .F.
Private lAutoErrNoFile := .T.
// define o tipo de retorno do método
::SetContentType("application/json")
                                                
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

begin transaction

	// Ordem de Producao
	cOPNum := GetNumSC2()
	aAdd(aOP, {"C2_FILIAL", XFILIAL("SC2"), NIL})
	aAdd(aOP, {"C2_NUM",cOPNum, NIL})
	aAdd(aOP, {"C2_ITEM","01", NIL})
	aAdd(aOP, {"C2_SEQUEN", "001", NIL})
	aAdd(aOP, {"C2_PRODUTO", oData:produto, NIL})
	aAdd(aOP, {"C2_LOCAL", oData:armazem, NIL})
	aAdd(aOP, {"C2_QUANT", oData:quantidade, NIL})
	aAdd(aOP, {"C2_DATPRI", stod(oData:dataProd), NIL })
	aAdd(aOP, {"C2_DATPRF", stod(oData:dataProd), NIL })
	aAdd(aOP, {"AUTEXPLODE", "S", NIL})
	                                         
	msExecAuto({|x,Y| Mata650(x,Y)},aOP,3)    

	if lMsErroAuto
		RollbackSx8() 
		aLog := GetAutoGrLog()
		aEval(aLog, {|x| cJsonErro += x })//gera o json a ser retornado
		cJsonErro += '"}"
		::SetResponse(cJsonErro)                  
		//Seta o StatusCode para 500 internal server error	
		SetRestFault(500, cJsonErro)     
		Return .F.
	else                                          
		ConfirmSX8()    	
	endif    
	                    
	//Producao                        
	aAdd(aProd, {"D3_FILIAL", XFILIAL("SD3") , NIL})
	aAdd(aProd, {"D3_TM", cTmProd, NIL})
	aAdd(aProd, {"D3_COD", oData:produto, NIL})     
	aAdd(aProd, {"D3_QUANT", oData:quantidade, NIL})
	aAdd(aProd, {"D3_OP", cOPNum + "01001", NIL})
	aAdd(aProd, {"D3_LOCAL", oData:armazem, NIL})
	aAdd(aProd, {"D3_EMISSAO", stod(oData:dataProd), NIL})
	                       
	msExecAuto({|x, y| Mata250(x, y)}, aProd, 3)

	if lmsErroAuto		            
		aLog := GetAutoGrLog()
		aEval(aLog, {|x| cJsonErro += x })//gera o json a ser retornado
		cJsonErro += '"}"		
		::SetResponse(cJsonErro) 
		//Seta o StatusCode para 500 internal server error	
		SetRestFault(500, cJsonErro)
		DisarmTransaction()
		return .F.
	endif                                                 
	                                                  
	//PERDAS
	//verifica se ha desperdicio, se sim lanca a perda
	if Type("oData:Desperdicio") != "U"

		for i := 1 to len(oData:Desperdicio)                  
			//obtem a sequencia da op conforme o empenho (a perda pode ocorrer em 1 item da op filha - na data do desenvolvimento somente aplicavel a fabrica
			cOpComp := GetOPD4(oData:Desperdicio[i]:ingrediente, cOPNum)
			//verifica se o item foi empenhado
			aAdd(aItemPerda, {"BC_PRODUTO" , oData:Desperdicio[i]:ingrediente ,NIL})
			aAdd(aItemPerda, {"BC_QUANT" , oData:Desperdicio[i]:quantidade   ,NIL})
			aAdd(aItemPerda, {"BC_LOCORIG" , oData:Armazem ,NIL}) 
			aAdd(aItemPerda, {"BC_MOTIVO"  , "FH" ,NIL})   
			aAdd(aItemPerda, {"BC_DATA", stod(oData:dataProd), NIL })
			
			if (nPos := aScan(aItensPerda, {|x| x[1] == cOpComp })) == 0
				aAdd(aItensPerda, { cOpComp, { aItemPerda }})
				aAdd(aCabecPerda, { cOpComp, { {"BC_FILIAL"  , xFilial("SBC"), NIL }, {"BC_OP"      , cOpComp ,NIL} }})
			else
				aAdd(aItensPerda[nPos][2], aItemPerda)
			end	
			aItemPerda := {}
		next       
		
		//Ordena o array	                        
		aSort(aItensPerda,,, {|x,y| x[1] < y[1]})
		aSort(aCabecperda,,, {|x,y| x[1] < y[1]})
			
		for i:=1 to len(aCabecPerda)				                          		
			msExecAuto({|x,y,z| Mata685(x,y,z)}, aCabecPerda[i][2], aItensPerda[i][2], 3)
		
			if lmsErroAuto		            
				aLog := GetAutoGrLog()
				aEval(aLog, {|x| cJsonErro += x })//gera o json a ser retornado
				cJsonErro += '"}"		
				::SetResponse(cJsonErro) 
				//Seta o StatusCode para 500 internal server error	
				SetRestFault(500, cJsonErro)
				DisarmTransaction()
				return .F.
			endif                                                 
		next
			
	endif   
	
end transaction

return .T.                                    

Static Function GetOPD4(cProd, cOp)

Local cAlias := GetNextAlias()
Local nTamOp := TamSx3("C2_NUM")[1]              
Local cRet := ""
Beginsql Alias cAlias
	%noparser%
	SELECT D4_OP
	FROM %table:SD4%
	WHERE D4_COD = %exp:cProd%
	AND LEFT(D4_OP, %exp:nTamOp%) = %exp:cOp%
	AND %notdel%
endsql      
cRet := (cAlias)->D4_OP
(cAlias)->(dbCloseArea())

Return cRet