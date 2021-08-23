#INCLUDE "protheus.ch"
#INCLUDE "apwebsrv.ch"

/* ===============================================================================
WSDL Location    http://laudo-r4.refrio.com.br/WmsSIS.asmx?WSDL
Gerado em        11/10/20 20:44:00
Observações      Código-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alterações neste arquivo podem causar funcionamento incorreto
                 e serão perdidas caso o código-fonte seja gerado novamente.
=============================================================================== */

User Function _EGLUNJV ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSWmsSIS
------------------------------------------------------------------------------- */

WSCLIENT WSWmsSIS

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD TesteDeConexao
	WSMETHOD SOLWMSConsumoInterfaces
	WSMETHOD InspecaoQualBloqueia
	WSMETHOD InspecaoQualDesbloqueia

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   cTesteDeConexaoResult     AS string
	WSDATA   oWScabec                  AS WmsSIS_Cabecalho
	WSDATA   cxml                      AS string
	WSDATA   cSOLWMSConsumoInterfacesResult AS string
	WSDATA   oWSautenticacao           AS WmsSIS_Autenticacao
	WSDATA   cInspecaoQualBloqueiaResult AS string
	WSDATA   cInspecaoQualDesbloqueiaResult AS string

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSWmsSIS
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O Código-Fonte Client atual requer os executáveis do Protheus Build [7.00.170117A-20200102] ou superior. Atualize o Protheus ou gere o Código-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSWmsSIS
	::oWScabec           := WmsSIS_CABECALHO():New()
	::oWSautenticacao    := WmsSIS_AUTENTICACAO():New()
Return

WSMETHOD RESET WSCLIENT WSWmsSIS
	::cTesteDeConexaoResult := NIL 
	::oWScabec           := NIL 
	::cxml               := NIL 
	::cSOLWMSConsumoInterfacesResult := NIL 
	::oWSautenticacao    := NIL 
	::cInspecaoQualBloqueiaResult := NIL 
	::cInspecaoQualDesbloqueiaResult := NIL 
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSWmsSIS
Local oClone := WSWmsSIS():New()
	oClone:_URL          := ::_URL 
	oClone:cTesteDeConexaoResult := ::cTesteDeConexaoResult
	oClone:oWScabec      :=  IIF(::oWScabec = NIL , NIL ,::oWScabec:Clone() )
	oClone:cxml          := ::cxml
	oClone:cSOLWMSConsumoInterfacesResult := ::cSOLWMSConsumoInterfacesResult
	oClone:oWSautenticacao :=  IIF(::oWSautenticacao = NIL , NIL ,::oWSautenticacao:Clone() )
	oClone:cInspecaoQualBloqueiaResult := ::cInspecaoQualBloqueiaResult
	oClone:cInspecaoQualDesbloqueiaResult := ::cInspecaoQualDesbloqueiaResult
Return oClone

// WSDL Method TesteDeConexao of Service WSWmsSIS

WSMETHOD TesteDeConexao WSSEND NULLPARAM WSRECEIVE cTesteDeConexaoResult WSCLIENT WSWmsSIS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<TesteDeConexao xmlns="http://SOLWMSSIS.org/">'
cSoap += "</TesteDeConexao>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://SOLWMSSIS.org/TesteDeConexao",; 
	"DOCUMENT","http://SOLWMSSIS.org/",,,; 
	"http://laudo-r4.refrio.com.br/WmsSIS.asmx")

::Init()
::cTesteDeConexaoResult :=  WSAdvValue( oXmlRet,"_TESTEDECONEXAORESPONSE:_TESTEDECONEXAORESULT:TEXT","string",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method SOLWMSConsumoInterfaces of Service WSWmsSIS

WSMETHOD SOLWMSConsumoInterfaces WSSEND oWScabec, cxml WSRECEIVE cSOLWMSConsumoInterfacesResult WSCLIENT WSWmsSIS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<SOLWMSConsumoInterfaces xmlns="http://SOLWMSSIS.org/">'
cSoap += WSSoapValue("cabec", ::oWScabec, ::oWScabec , "Cabecalho", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</SOLWMSConsumoInterfaces>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://SOLWMSSIS.org/SOLWMSConsumoInterfaces",; 
	"DOCUMENT","http://SOLWMSSIS.org/",,,; 
	"http://laudo-r4.refrio.com.br/WmsSIS.asmx")

::Init()
::cSOLWMSConsumoInterfacesResult :=  WSAdvValue( oXmlRet,"_SOLWMSCONSUMOINTERFACESRESPONSE:_SOLWMSCONSUMOINTERFACESRESULT:TEXT","string",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method InspecaoQualBloqueia of Service WSWmsSIS

WSMETHOD InspecaoQualBloqueia WSSEND oWSautenticacao,cxml WSRECEIVE cInspecaoQualBloqueiaResult WSCLIENT WSWmsSIS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<InspecaoQualBloqueia xmlns="http://SOLWMSSIS.org/">'
cSoap += WSSoapValue("autenticacao", ::oWSautenticacao, oWSautenticacao , "Autenticacao", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</InspecaoQualBloqueia>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://SOLWMSSIS.org/InspecaoQualBloqueia",; 
	"DOCUMENT","http://SOLWMSSIS.org/",,,; 
	"http://laudo-r4.refrio.com.br/WmsSIS.asmx")

::Init()
::cInspecaoQualBloqueiaResult :=  WSAdvValue( oXmlRet,"_INSPECAOQUALBLOQUEIARESPONSE:_INSPECAOQUALBLOQUEIARESULT:TEXT","string",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

// WSDL Method InspecaoQualDesbloqueia of Service WSWmsSIS

WSMETHOD InspecaoQualDesbloqueia WSSEND cxml WSRECEIVE cInspecaoQualDesbloqueiaResult WSCLIENT WSWmsSIS
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<InspecaoQualDesbloqueia xmlns="http://SOLWMSSIS.org/">'
cSoap += WSSoapValue("xml", ::cxml, cxml , "string", .F. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</InspecaoQualDesbloqueia>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://SOLWMSSIS.org/InspecaoQualDesbloqueia",; 
	"DOCUMENT","http://SOLWMSSIS.org/",,,; 
	"http://laudo-r4.refrio.com.br/WmsSIS.asmx")

::Init()
::cInspecaoQualDesbloqueiaResult :=  WSAdvValue( oXmlRet,"_INSPECAOQUALDESBLOQUEIARESPONSE:_INSPECAOQUALDESBLOQUEIARESULT:TEXT","string",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure Cabecalho

WSSTRUCT WmsSIS_Cabecalho
	WSDATA   cIdentificador            AS string OPTIONAL
	WSDATA   cRequisitante             AS string OPTIONAL
	WSDATA   cXsdValidacao             AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WmsSIS_Cabecalho
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WmsSIS_Cabecalho
Return

WSMETHOD CLONE WSCLIENT WmsSIS_Cabecalho
	Local oClone := WmsSIS_Cabecalho():NEW()
	oClone:cIdentificador       := ::cIdentificador
	oClone:cRequisitante        := ::cRequisitante
	oClone:cXsdValidacao        := ::cXsdValidacao
Return oClone

WSMETHOD SOAPSEND WSCLIENT WmsSIS_Cabecalho
	Local cSoap := ""
	cSoap += WSSoapValue("Identificador", ::cIdentificador, ::cIdentificador , "string", .F. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("Requisitante", ::cRequisitante, ::cRequisitante , "string", .F. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("XsdValidacao", ::cXsdValidacao, ::cXsdValidacao , "string", .F. , .F., 0 , NIL, .F.,.F.) 
Return cSoap

// WSDL Data Structure Autenticacao

WSSTRUCT WmsSIS_Autenticacao
	WSDATA   cusuario                  AS string OPTIONAL
	WSDATA   csenha                    AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPSEND
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT WmsSIS_Autenticacao
	::Init()
Return Self

WSMETHOD INIT WSCLIENT WmsSIS_Autenticacao
Return

WSMETHOD CLONE WSCLIENT WmsSIS_Autenticacao
	Local oClone := WmsSIS_Autenticacao():NEW()
	oClone:cusuario             := ::cusuario
	oClone:csenha               := ::csenha
Return oClone

WSMETHOD SOAPSEND WSCLIENT WmsSIS_Autenticacao
	Local cSoap := ""
	cSoap += WSSoapValue("usuario", ::cusuario, ::cusuario , "string", .F. , .F., 0 , NIL, .F.,.F.) 
	cSoap += WSSoapValue("senha", ::csenha, ::csenha , "string", .F. , .F., 0 , NIL, .F.,.F.) 
Return cSoap

User Function xCallWS()

    oWs :=  WSWmsSIS():New()
    
    oCabec := oWs:oWsCabec

    oCabec:CIDENTIFICADOR := "WEBAPI-I50"
    oCabec:CREQUISITANTE := "00043"
    oCabec:CXSDVALIDACAO := "13/11/2020"

    oWs:CXML := "<DADOSXML>" + CRLF
	oWs:CXML := " <PEDIDO> " + CRLF
	oWs:CXML := " <doca/> " + CRLF
	oWs:CXML := " <cnpjProprietario>00.000.000/0001-00</cnpjProprietario> " + CRLF
	oWs:CXML := " <cnpjDestinatario>11.111.111/0001-11</cnpjDestinatario> " + CRLF
	oWs:CXML := " <cnpjTransportadora>22.222.222/0001-22</cnpjTransportadora> " + CRLF
	oWs:CXML := " <numeroPedido>005806</numeroPedido> " + CRLF
	oWs:CXML := " <tipoCarga>CN</tipoCarga> " + CRLF
	oWs:CXML := " <tipoAcondicionamento>PC</tipoAcondicionamento> " + CRLF
	oWs:CXML := " <tipoSeparacao>FEF</tipoSeparacao> " + CRLF
	oWs:CXML := " <observacao/> " + CRLF
	oWs:CXML := " <dataEmissao>15/01/2014 00:00:00</dataEmissao> " + CRLF
	oWs:CXML := " <numeroPlanejamento>246889</numeroPlanejamento> " + CRLF
	oWs:CXML := " <numeroEmbarque>566</numeroEmbarque> " + CRLF
	oWs:CXML := " <numeroRefPedCliente>4562</numeroRefPedCliente> " + CRLF
	oWs:CXML := " <nroagrupseparacao>246889</nroagrupseparacao> " + CRLF
	oWs:CXML := " <placaVeiculo>DET1456</placaVeiculo> " + CRLF
	oWs:CXML := " <deposito>03</deposito> " + CRLF
	oWs:CXML := " <cnpjArmazem>33.333.333/0001-33</cnpjArmazem> " + CRLF
	oWs:CXML := " <numeroLacre/> " + CRLF
	oWs:CXML := " <indicaLocalEntregaNome>R JOAO FERNANDES,L01</indicaLocalEntregaNome> " + CRLF
	oWs:CXML := " <indicaLocalEntregaBairro>JOAO FERNANDES</indicaLocalEntregaBairro> " + CRLF
	oWs:CXML := " <indicaLocalEntregaCidade>Armação dos Búzios</indicaLocalEntregaCidade> " + CRLF
	oWs:CXML := " <indicaLocalEntregaCep>28950-000</indicaLocalEntregaCep> " + CRLF
	oWs:CXML := " <indicaLocalEntregaUf>RJ</indicaLocalEntregaUf> " + CRLF
	oWs:CXML := " <indicaLocalEntregaTel/> " + CRLF
	oWs:CXML := " <atributo1>246889</atributo1> " + CRLF
	oWs:CXML := " <atributo2>1620167</atributo2> " + CRLF
	oWs:CXML := " <atributo3>2</atributo3> " + CRLF
	oWs:CXML := " 	<ITEM_PEDIDO> " + CRLF
	oWs:CXML := " 		<numeroSequencialItem>1</numeroSequencialItem> " + CRLF
	oWs:CXML := " 		<codigoProduto>3117</codigoProduto> " + CRLF
	oWs:CXML := " 		<qtdeEmbalagem>0</qtdeEmbalagem> " + CRLF
	oWs:CXML := " 		<quantidadeProduto>20.0000</quantidadeProduto> " + CRLF
	oWs:CXML := " 		<tipoSeparacao>FEF</tipoSeparacao> " + CRLF
	oWs:CXML := " 		<valorDetalhe1/> " + CRLF
	oWs:CXML := " 		<valorDetalhe2/> " + CRLF
	oWs:CXML := " 		<valorDetalhe3/> " + CRLF
	oWs:CXML := " 		<valorDetalhe4/> " + CRLF
	oWs:CXML := " 		<tipoEspecificacaoItem/> " + CRLF
	oWs:CXML := " 		<valorEspecificacaoItem/> " + CRLF
	oWs:CXML := " 	</ITEM_PEDIDO> " + CRLF
	oWs:CXML := " </PEDIDO> " + CRLF
    oWs:CXML := " </DADOSXML> " + CRLF

    If oWs:SOLWMSConsumoInterfaces()
        Alert("Teste de Conexão")
    EndIf    

Return
