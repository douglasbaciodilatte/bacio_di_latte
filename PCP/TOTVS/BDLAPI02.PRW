#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"
                                                        
USER FUNCTION BDLAPI02
RETURN

WSRESTFUL RECEITA DESCRIPTION "Serviço Rest para Consulta de Receitas"

WSDATA produto AS STRING //PARAMETRO DO METODO GET COM O CODIGO DO PRODUTO
WSDATA apiKey AS STRING //PARAMETRO COM A CHAVE PARA AUTENTICACAO

WSMETHOD GET DESCRIPTION "Metodo responsável por retornar a receita do produto informado" WSSYNTAX "/RECEITA"
	
END WSRESTFUL

WSMETHOD GET WSRECEIVE apiKey, produto WSSERVICE RECEITA             
Local cCodProd := ::produto
Local apiKeyAuth	:= ::apiKey
Local lLoginOk := SuperGetMV("MV_XAPIKEY",.F.,"1234") == apiKeyAuth
Local oEstrut	:= Nil
Local cJson		:= ""
Local cAlias	:= GetNextAlias()
                                                         
if !lLoginOk
	SetRestFault(403,"Falha durante o login, verifique a chave")
	return .F.
endif

if empty(cCodProd) 
	SetRestFault(400,"Verifique se todos os parametro produto foi informados")
	return .F.
endif

//posiciona no produto para pegar a quantidade base
dbSelectArea("SB1")
dbSetOrder(1)
dbSeek(xFilial("SB1") + cCodProd)
// define o tipo de retorno do método
::SetContentType("application/json")  

beginsql alias cAlias
	column G1_QUANT as numeric(18,3)                  
	%noparser%
	SELECT * FROM dbo.XPLODESTRUT01(%Exp:cCodProd%, 1)
endsql

dbSelectArea(cAlias)
If !Eof()
	oEstrut := BDILEstrut():New(cCodProd, SB1->B1_QB) //cria o objeto com a estrutura
	While !Eof()                                                       
		//adiciona os itens da estrutura ao objeto
		oEstrut:AddItem((cAlias)->G1_COMP, (cAlias)->G1_QUANT) 
		(cAlias)->(dbSkip())
	EndDo                   
	// --> Transforma o objeto de produtos em uma string json
	cJson := FWJsonSerialize(oEstrut, .F., .F.) //parametros: objeto, nome da class no json, converte data para utc      
	// --> Envia o JSON Gerado para a aplicação Client
	::SetResponse(cJson)
Else      
	SetRestFault(204,"Produto nao encontrado")  
EndIf   

(cAlias)->(dbCloseArea())

return .t.