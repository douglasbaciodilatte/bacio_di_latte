#include "protheus.ch"
#include "restful.ch"

wsmethod get wsservice DnlRestETC
//Esse cara indica que vamos retornar um HTML, apenas para o nosso primeiro retorno
self:setContentType("text/html")
self:setResponse("<p>Hello World</p>")
self:setStatus(200)
return .T.

wsrestful DnlRestETC description "REST de exemplo! =]"
wsmethod get description "Retornar um Hello World" wssyntax "dnlrestetc/v1/" path "dnlrestetc/v1/"
end wsrestful



