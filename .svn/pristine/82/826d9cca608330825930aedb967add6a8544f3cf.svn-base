#include 'protheus.ch'
#include 'Restful.ch'
#include 'tbiconn.ch'


User Function WSINT001()
Return 

WsRestFul Funcionarios Description "Consulta Funcionarios Bacio." Format "application/json"

	WsData apiKey As String
	WsData CPF As String

    WsMethod Get Description "Consulta Funcionarios Bacio." WSSYNTAX "/Funcionarios"

End WsRestFul


WsMethod Get WsReceive apiKey, CPF WsService Funcionarios
 
Local lRet       := .T.
Local cQuery     := ""
Local cCPF		 := ::CPF
Local apiKeyAuth := ::apiKey
Local lLoginOk   := SuperGetMV("MV_XAPIKEY",.F.,"1234") == apiKeyAuth
Local oResponse  := JsonObject():New()
Local cAliasSQL  := GetNextAlias()

    If Valtype(apiKeyAuth) == 'U'
        SetRestFault(400, 'Informe a chave token! ' + apiKeyAuth)
        lRet := .F.
    EndIf       

    If !lLoginOk
    	SetRestFault(403,"Falha durante o login, verifique a chave " + apiKeyAuth)
	    return .F.
    EndIf

    If Intransaction()
        DisarmTransaction()
        SetRestFault(500, '{"erro - Thread em Aberto"}')
        ConOut("Erro - Thread em aberto...")   
        return .F.
    EndIf

    ::SetContentType('application/json')

    oResponse['ListFunc']  := {}

    cQuery := " SELECT "
	cQuery += " 	RA_FILIAL, "
	cQuery += " 	RA_MAT, "
	cQuery += " 	RA_CC, "
	cQuery += " 	RA_NOMECMP, "
	cQuery += " 	RA_DDDCELU, "
	cQuery += " 	RA_NUMCELU, "
	cQuery += " 	RA_EMAIL, "
	cQuery += " 	RA_SITFOLH, "
    cQuery += " 	RA_CIC "
	cQuery += " FROM "+RetSqlName('SRA')+" "
	cQuery += " WHERE D_E_L_E_T_!='*' "
	cQuery += " 	AND RA_SITFOLH='' "

	If !Empty(cCPF)
		cQuery += " 	AND RA_CIC='"+cCPF+"' "
	EndIf

	cQuery += " ORDER BY RA_FILIAL,RA_MAT,RA_NOME "

    MPSysOpenQuery(cQuery,cAliasSQL)

    While (cAliasSQL)->(!EoF())

		If Empty((cAliasSQL)->RA_SITFOLH)
			aSituac := "Ativo"
		ElseIf (cAliasSQL)->RA_SITFOLH == "D"
			aSituac := "Demitido"
		ElseIf (cAliasSQL)->RA_SITFOLH == "F"
			aSituac := "Ferias"
		ElseIf (cAliasSQL)->RA_SITFOLH == "T"
			aSituac := "Transferido"
		ElseIf (cAliasSQL)->RA_SITFOLH =="A"
			aSituac := "Afastado"
		EndIf

        oJson := JsonObject():New()

        oJson['Filial'] := (cAliasSQL)->RA_FILIAL
        oJson['Matricula'] := Alltrim((cAliasSQL)->RA_MAT)
        oJson['CentroCusto'] := Alltrim((cAliasSQL)->RA_CC)
        oJson['CPF'] := Alltrim((cAliasSQL)->RA_CIC)
        oJson['Nome'] := Alltrim((cAliasSQL)->RA_NOMECMP)
        oJson['DDDCel'] := Alltrim((cAliasSQL)->RA_DDDCELU)
        oJson['NumCel'] := Alltrim((cAliasSQL)->RA_NUMCELU)
        oJson['Email'] := Alltrim((cAliasSQL)->RA_EMAIL)
        oJson['Situacao'] := aSituac

        aAdd(oResponse['ListFunc'], oJson)

        (cAliasSQL)->(DbSkip())
    EndDo
   
    ::SetResponse(oResponse:toJson())

Return lRet 
