#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"
                        
USER FUNCTION BDLAPI01
RETURN

WSRESTFUL PRODUTO DESCRIPTION "Serviço Rest para Consulta de Produtos"

WSDATA produto AS STRING //PARAMETRO DO METODO GET COM O CODIGO DO PRODUTO
WSDATA apiKey AS STRING //PARAMETRO COM A CHAVE PARA AUTENTICACAO

WSMETHOD GET DESCRIPTION "Metodo responsável por retornar o produto conforme código informado" WSSYNTAX "/PRODUTO"
	
END WSRESTFUL

WSMETHOD GET WSRECEIVE apiKey, produto WSSERVICE PRODUTO

Local cCodProd := ::produto
Local apiKeyAuth	:= ::apiKey
Local lLoginOk := SuperGetMV("MV_XAPIKEY",.F.,"1234") == apiKeyAuth
Local aArea		:= GetArea()
Local oObjProd	:= Nil
Local cStatus	:= ""
Local cJson		:= ""
                                                         
if !lLoginOk
	SetRestFault(403,"Falha durante o login, verifique a chave")	
	return .F.
endif

if empty(cCodProd) 
	SetRestFault(400,"Verifique se todos os parametro produto foi informados")
	return .F.
endif
// define o tipo de retorno do método
::SetContentType("application/json")

DbSelectArea("SB1")
SB1->( DbSetOrder(1) )
If SB1->( DbSeek( xFilial("SB1") + cCodProd ) )
	cStatus  := Iif( SB1->B1_MSBLQL == "1", "Bloqueado", "Ok" )
	oObjProd := BDILProd():New(SB1->B1_COD, SB1->B1_DESC, SB1->B1_UM, cStatus) //Cria um objeto da classe produtos para fazer a serialização na função FWJSONSerialize
	// Transforma o objeto de produtos em uma string json
	cJson := FWJsonSerialize(oObjProd, .F., .F.) //parametros: objeto, nome da class no json, converte data para utc      
	// Envia o JSON Gerado para a aplicação Client
	::SetResponse(cJson)
Else
	SetRestFault(204,"Produto nao encontrado")  
EndIf

RestArea(aArea)

Return(.T.)