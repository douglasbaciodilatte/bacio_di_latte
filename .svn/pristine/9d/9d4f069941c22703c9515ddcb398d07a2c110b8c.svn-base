#include 'protheus.ch'
#include 'Restful.ch'
#include 'tbiconn.ch'
#INCLUDE "TopConn.ch"

/*/{Protheus.doc} User Function REST010
    (long_description)
    @type  Function
    @author Douglas Rodrigues da Silva
    @since 17/04/2020
    @version 1.0
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function BDCCUP01()
Return 

WSRESTFUL STOQ_Cancelamento DESCRIPTION "RestFul STOQ Cancelamento Cupons" FORMAT "application/json"

    WSDATA apiKey AS STRING  //PARAMETRO COM A CHAVE PARA AUTENTICACAO

    WSMETHOD GET  DESCRIPTION "STOQ Cancelamento de Vendas" WSSYNTAX "/STOQ_Cancelamento/{}"
    WSMETHOD POST DESCRIPTION "STOQ Cancelamento de Vendas" WSSYNTAX "/STOQ_Cancelamento/{}"

END WSRESTFUL

WSMETHOD GET WSSERVICE STOQ_Cancelamento

    Local lRet          := .T.
    Local oResponse     := JsonObject():New()
    Local apiKeyAuth	:= ::apiKey
    Local lLoginOk      := SuperGetMV("MV_XAPIKEY",.F.,"1234") == apiKeyAuth
    Private oJsonlj     := JsonObject():New()
    Private oJsonNFT    := JsonObject():New()  

     If Valtype(apiKeyAuth) == 'U'
        SetRestFault(400, 'Informe a chave token! ' + apiKeyAuth)
        lRet := .F.
    EndIf       

    if !lLoginOk
    	SetRestFault(403,"Falha durante o login, verifique a chave " + apiKeyAuth )	
	    return .F.
    endif

    If Intransaction()
        DisarmTransaction()
        SetRestFault(500, '{"erro - Thread em Aberto"}')
        ConOut("Erro - Thread em aberto...")   
        return .F.
    EndIf

    ::SetContentType('application/json')

    //Montagem Json Ambientes
    oResponse['cupons']  := {}

    ZZB->(DBSelectArea("ZZB"))
    ZZB->(DBSetOrder(1)) //ZZB_FILIAL+ZZB_CHAVE+ZZB_XCODEX
    
    Do While ZZB->(!EOF() )

        oJsonZZ2 := JsonObject():New()
        
        oJsonZZ2['filial']      := Alltrim(ZZB->ZZB_CHAVE)
        oJsonZZ2['codigo']	    := Alltrim(ZZB->ZZB_XCODEX)
      
         aAdd(oResponse['cupons'], oJsonZZ2)	

        ZZB->(dbSkip())
    Enddo    
    
    ::SetResponse(oResponse:toJson())

Return lRet 

WSMETHOD POST WSSERVICE STOQ_Cancelamento

    Local lPost     := .T.
    Local cJson     := ::getContent()
    Local oResponse := JsonObject():New()
    Local cHoraIni
    Local dDataIni

    
    Private lMsErroAuto     := .F.
    Private oJson
    Private aDados    := {}
    
    oJson   := JsonObject():New()
    cError  := oJson:FromJson(cJson)
    //Se tiver algum erro no Parse, encerra a execu��o
    IF .NOT. Empty(cError)
        SetRestFault(500,'Parser Json Error')
        lRet    := .F.
    Else

        dDataIni    := Date()
        cHoraIni    := Time()
        
        ZZB->(DBSelectArea("ZZB"))
        ZZB->(DBSetOrder(1)) //ZZB_FILIAL+ZZB_CHAVE+ZZB_XCODEX
        
        If ! ZZB->(dbSeek(xFilial("ZZB") + oJson:GetJsonObject('chave') ))
            
            RecLock("ZZB", .T.)        
                ZZB->ZZB_CHAVE    := oJson:GetJsonObject('chave')	
                ZZB->ZZB_XCODEX   := oJson:GetJsonObject('xcodex')	
                ZZB->ZZB_PROTOC   := oJson:GetJsonObject('protocolo')	
                ZZB->ZZB_DATA     := STOD(oJson:GetJsonObject('data'))	
                ZZB->ZZB_HORA     := oJson:GetJsonObject('hora')	
            MsUnLock()
            
            oResponse['data']       := "inicio " + DTOC(dDataIni) + " fim " + DTOC( Date() )
            oResponse['hora']       := "inicio " + cHoraIni + " fim " + Time()
            oResponse['mensagem']   := "cancelamento gravado com sucesso"

        Else
            oResponse['data']       := "inicio " + DTOC(dDataIni) + " fim " + DTOC( Date() )
            oResponse['hora']       := "inicio " + cHoraIni + " fim " + Time()
            oResponse['mensagem']   := "chave cancelamento ja existe na base"            
        EndIf    

    EndIf
    
    ::SetResponse( oResponse:toJson() )

Return lPost
