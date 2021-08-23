#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"
                                

/*/{Protheus.doc} blintstq

   Fun��o para gravar os dados dos cupons de venda nas tabelas do motor padr�o TOTVS

   @author  Nome
   @example Exemplos
   @param   [Nome_do_Parametro],Tipo_do_Parametro,Descricao_do_Parametro
   @return  Especifica_o_retorno
   @table   Tabelas
   @since   27-02-2019
/*/
                                
USER FUNCTION blintstq
RETURN

WSRESTFUL Vendas DESCRIPTION "Servi�o Rest para Integra��o de Vendas"

WSMETHOD POST CUPONS DESCRIPTION "Metodo respons�vel por incluir os cupons" WSSYNTAX "/cupons" PATH "/cupons"
//WSMETHOD POST DESCRIPTION "Metodo respons�vel por incluir as redu��es Z" WSSYNTAX "/reducao" PATH "/reducao"

END WSRESTFUL

WSMETHOD POST CUPONS WSSERVICE Vendas

local _cBody := ::GetContent()//retorna o conteudo do body da requisicao
local i
local _nRecPIO
local _cError := ""
local _oError := ErrorBlock({|e| _cError := e:Description + e:ErrorStack})

private _oData

::SetContentType("application/json") 

if !FWJsonDeserialize(_cBody, @_oData)		
	//Retorna BadRequest
	SetRestFault(400, "ERROR ON DESERIALIZE JSON, VERIFY JSON ON BODY")
	return .F.
endif

begin sequence

for i:=1 to len(_oData:Orcamento )
    BEGIN TRANSACTION
    _cXCodeX := FWUUID(_oData:Orcamento[i]:NotaFiscal)
    _nRecPIO := GravaPIO(_oData:Orcamento[i], _cXCodeX)
    GravaPIN(_oData:Orcamento[i]:Items, _oData:Orcamento[i]:Filial, _oData:Orcamento[i]:ChaveNFCe, _nRecPIO, _cXCodeX)
    GravaPIP(_oData:Orcamento[i]:Pagamentos, _nRecPIO, _cXCodeX)
    END TRANSACTION
next

end sequence

ErrorBlock(_oError)
if !empty(_cError)
	SetRestFault(500, '{"erro":"' + _cError + '"}')
	return .F.
endif

return .t.

static function GravaPIO(Orcamento, _cXCodeX)

dbSelectArea("SLG")
dbSetOrder(2)//filial + pdv
dbSeek(Orcamento:Filial + Orcamento:NumeroPDV)

reclock("PIN", .T.)
PIN->PIN_FILIAL := Orcamento:Filial
PIN->PIN_NUM	:= STRZERO ( VAL( Orcamento:Orcamento ) ,6)
PIN->PIN_VEND	:= ""
PIN->PIN_CLIENT	:= "000001"	
PIN->PIN_LOJA	:= Left(Orcamento:NumeroPDV,4)
PIN->PIN_TIPOCL	:= "F"
PIN->PIN_VLRTOT	:= Orcamento:ValorTotal	
PIN->PIN_VLRLIQ	:= Orcamento:ValorLiquido
PIN->PIN_DOC	:= Orcamento:NotaFiscal
PIN->PIN_EMISNF	:= STOD( Orcamento:Emissao )
PIN->PIN_PDV	:= Orcamento:NumeroPDV
PIN->PIN_VALBRU	:= Orcamento:ValorBrutoNF	
PIN->PIN_VALMER	:= Orcamento:ValorMercadoria
PIN->PIN_TIPO	:= "V"
PIN->PIN_OPERAD	:= "001"
PIN->PIN_DINHEI	:= IIF ( Orcamento:Dinheiro > 0, Orcamento:Entrada, 0) 
PIN->PIN_CARTAO	:= IIF ( Orcamento:Dinheiro == 0, Orcamento:Entrada, 0)
PIN->PIN_ENTRAD	:= Orcamento:Entrada
PIN->PIN_PARCEL	:= 1
PIN->PIN_CONDPG	:= "CN"
PIN->PIN_EMISSA	:= STOD( Orcamento:Emissao )
PIN->PIN_NUMCFI	:= Orcamento:CupomFiscal
PIN->PIN_VENDTE	:= IIF( Orcamento:Dinheiro > 0, "N", "S")
					
If PIN->PIN_VENDTE == "S"
    PIN->PIN_DATATE	:=	STOD( Orcamento:Emissao ) 
EndIf  
					
PIN->PIN_HORATE	:= IIF( Orcamento:Dinheiro > 0, "", Orcamento:HoraTEF ) 
//PIN->PIN_NSUTEF	:= TRC->ZTQ_NSU
PIN->PIN_SITUA	:= "RX"
PIN->PIN_CGCCLI	:= Orcamento:CPFCNPJ
PIN->PIN_ESTACA	:= IIF( EMPTY( SLG->LG_CODIGO ) , "001", SLG->LG_CODIGO) /*TODO*/
PIN->PIN_KEYNFC	:= Orcamento:ChaveNFCe
PIN->PIN_SERSAT	:= Orcamento:SerieSat//IIF(TRC->ZTQ_TPPDV == "1","", TRC->ZTQ_SERSAT)	
PIN->PIN_ESPECI := Iif(!EMPTY(Orcamento:SerieSat), "SATCE", "")
PIN->PIN_SERIE	:= Orcamento:Serie//IIF(TRC->ZTQ_TPPDV == "1",SUBSTR(TRC->ZTQ_CHAVE,23,3), "")			
PIN->PIN_DESCON	:= Orcamento:Desconto
PIN->PIN_BRICMS	:= Orcamento:BaseICMSSol
PIN->PIN_VALICM	:= Orcamento:ValICMS
PIN->PIN_VALPIS	:= Orcamento:ValPIS
PIN->PIN_VALCOF	:= Orcamento:ValCOF
PIN->PIN_TPORC	:= "E" 
PIN->PIN_XTPREG	:= "5"
PIN->PIN_DATIMP	:= Date() 
PIN->PIN_DATEXP	:= STOD( Orcamento:Emissao )
PIN->PIN_CODORI	:= "2"
PIN->PIN_CODDES	:= "1"
PIN->PIN_ACAO	:= "1"
PIN->PIN_STAIMP	:= " "
PIN->PIN_PROTHE	:= "PIN_FILIAL+PIN_NUM+PIN_PDV"
PIN->PIN_LJORI	:= cValtoChar (VAL( SUBSTR ( ALLTRIM(Orcamento:NumeroPDV ),1,4) ) )  					
PIN->PIN_CXOR	:= cValtoChar (VAL (SUBSTR ( ALLTRIM(Orcamento:NumeroPDV ),5,2) ) ) 		
PIN->PIN_CNPJOR	:= SUBSTR( Orcamento:ChaveNFCe,7,14)
PIN->PIN_CHVORI	:= Orcamento:Filial + SUBSTR( Orcamento:ChaveNFCe,7,14) + ALLTRIM( Orcamento:NotaFiscal ) + DTOS(DATE()) + SUBSTR(TIME(),1,2)  
PIN->PIN_XCODEX	:= _cXCodeX

MsUnlock()

return PIN->(recno())


static function GravaPIN(_oItems, _cFilial, _cChaveNFCe, _nRecPIO, _cXCodeX)

local x

for x := 1 to len( _oItems)

Posicione("SB1", 1, XFILIAL("SB1") + _oItems[x]:Produto, "B1_DESC")

reclock("PIO", .T.)
PIO->PIO_FILIAL	:= _cFilial
PIO->PIO_NUM	:= STRZERO ( VAL( _oItems[x]:Orcamento ) ,6)
PIO->PIO_PRODUT	:= _oItems[x]:Produto
PIO->PIO_ITEM	:= STRZERO(Val(_oItems[x]:Item), 2)
PIO->PIO_QUANT	:= _oItems[x]:Quantidade
PIO->PIO_VRUNIT	:= _oItems[x]:PrcUnit
PIO->PIO_VLRITE	:= _oItems[x]:VlrItem
PIO->PIO_DESC	:= 0 
PIO->PIO_LOCAL	:= "01"
PIO->PIO_UM		:= SB1->B1_UM
PIO->PIO_TES	:= "XXX"
PIO->PIO_CF		:= _oItems[x]:CFOP
PIO->PIO_VENDID	:= "S"
PIO->PIO_DOC	:= _oItems[x]:NotaFiscal
PIO->PIO_PDV	:= _oItems[x]:NumPdv
PIO->PIO_EMISSA	:= STOD( _oItems[x]:Emissao )
PIO->PIO_VALICM	:= _oItems[x]:ValICMS
PIO->PIO_BASEIC	:= _oItems[x]:BaseICMS
PIO->PIO_VALPS2	:= _oItems[x]:ValPIS
PIO->PIO_VALCF2	:= _oItems[x]:ValCOF
PIO->PIO_BASEPS	:= _oItems[x]:BasePIS
PIO->PIO_BASECF	:= _oItems[x]:BaseCOF
PIO->PIO_ALIQPS	:= _oItems[x]:AliqPIS
PIO->PIO_ALIQCF	:= _oItems[x]:AliqCOF					
PIO->PIO_PRCTAB	:= _oItems[x]:PrcTabela
PIO->PIO_VEND	:= "001"
PIO->PIO_SITUA	:= "RX"
PIO->PIO_SITTRI	:= "T0320"
PIO->PIO_DATEXP	:= STOD( _oItems[x]:Emissao )
PIO->PIO_DATIMP	:= Date()
PIO->PIO_CODORI	:= "2"
PIO->PIO_CODDES	:= "1"
PIO->PIO_STAIMP	:= " "
PIO->PIO_PROTHE	:= "PIO_RECCAB"
PIO->PIO_ACAO	:= "1"
PIO->PIO_DESCRI	:= SB1->B1_DESC
PIO->PIO_XTPREG	:= "5"
PIO->PIO_LJORI	:= cValtoChar (VAL( SUBSTR ( ALLTRIM( _oItems[x]:NumPdv ),1,4) ) ) 
PIO->PIO_CNPJOR	:= SUBSTR ( _cChaveNFCe,7,14 )
PIO->PIO_CHVORI	:= _cFilial + SUBSTR( _cChaveNFCe,7,14) + ALLTRIM( _oItems[x]:NotaFiscal ) + DTOS(DATE()) + SUBSTR(TIME(),1,2) 
PIO->PIO_RECCAB	:= _nRecPIO
PIO->PIO_XCODEX	:= _cXCodeX
PIO->PIO_CODORI	:= '2' 
PIO->PIO_CODDES := '1'
PIO->PIO_ACAO	:= "1"
MsUnLock()
next
return .t.
static function GravaPIP(_oPagamentos, _nRecPIO, _cXCodeX)

x := 1

for x := 1 to len(_oPagamentos)

reclock("PIP", .t.)
PIP->PIP_FILIAL	:= _oPagamentos[x]:Filial
PIP->PIP_NUM	:= STRZERO ( VAL( _oPagamentos[x]:Orcamento ) ,6)
PIP->PIP_DATA	:= STOD( _oPagamentos[x]:Emissao )
PIP->PIP_VALOR	:= _oPagamentos[x]:Valor
PIP->PIP_FORMA	:= _oPagamentos[x]:FormaPagto
PIP->PIP_ADMINI	:= _oPagamentos[x]:AdmFin
PIP->PIP_HORATE	:= IIF( _oPagamentos[x]:DocTEF != "", _oPagamentos[x]:HoraTrans, "" ) 
PIP->PIP_NSUTEF	:= _oPagamentos[x]:NSUTEF
PIP->PIP_VENDTE	:= IIF( _oPagamentos[x]:NSUTEF != "", "S", "N")
PIP->PIP_DATEXP	:= STOD( _oPagamentos[x]:Emissao )
PIP->PIP_DATIMP	:= Date()
PIP->PIP_CODORI	:= "2"
PIP->PIP_CODDES	:= "1"
PIP->PIP_STAIMP	:= "1"
PIP->PIP_PROTHE	:= "PIP_FILIAL+PIP_NUM+PIP_ORIGEM"
PIP->PIP_ACAO	:= "1"
PIP->PIP_PDV	:= _oPagamentos[x]:PDV 
PIP->PIP_XTPREG	:= "5"	
PIP->PIP_CHVORI	:= _oPagamentos[x]:Filial + _oPagamentos[x]:CNPJFilOri + ALLTRIM( _oPagamentos[x]:Orcamento ) + DTOS( DATE()) + SUBSTR( TIME(),1,2) 
PIP->PIP_CNPJOR	:= _oPagamentos[x]:CNPJFilOri
PIP->PIP_LJORI	:= cValtoChar (VAL( SUBSTR ( ALLTRIM(_oPagamentos[x]:PDV ),1,4) ) )
PIP->PIP_XCODEX	:= _cXCodeX
PIP->PIP_CODORI	:= '2'
PIP->PIP_CODDES := '1'
PIP->PIP_ACAO 	:= "1" 

MsUnLock()

next

return .t.
					