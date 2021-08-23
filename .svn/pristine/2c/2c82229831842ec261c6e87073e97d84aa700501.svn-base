#include 'protheus.ch'

//dummy function para reservar o nome do fonte
user function BDLML001()
return

/*/{Protheus.doc} BDLML001
Classe respons�vel pelo envio de email com as divergencias entre a
solicita��o da transfer�ncia x atendimento
@author    Renan Paiva
@since     29/06/2018
@version   ${version}
/*/
class BDLML001 
	
	data _cSerie
	data _cNota	
	
	method new() constructor 
	method SndNotif()	
	
endclass

/*/{Protheus.doc} new
M�todo construtor da classe
@author    Renan Paiva
@since     29/06/2018
@version   ${version}
@param _pSerie, Character, ${param_descr}
@param _pNota, Character, ${param_descr}
/*/
method new(_pSerie, _pNota) class BDLML001

::_cSerie	:= _pSerie
::_cNota	:= _pNota

return

/*/{Protheus.doc} SendMail
Metodo que realiza o envio do email
@author    Renan Paiva
@since     29/06/2018
@version   ${version}
/*/
method SndNotif() class BDLML001

local _cHTML	 := ""
local _cTo		 := ""
local _cAlias	 := getNextAlias()
local _cDocTrans := checkTrans(::_cNota, ::_cSerie)
local _oSendMail

//Busca numero do Pedido de Venda
SC6->(dbSelectArea("SC6"))
SC6->(dbSetOrder(13))
If SC6->(DBSeek( xFilial("SF2") + ::_cNota ))
	
	SC5->(dbSelectArea("SC5"))
	SC5->(DBSetOrder(1))
	If SC5->(dbSeek( SC6->C6_FILIAL + SC6->C6_NUM ))
		
		//Busca Codigo da Transferencia
		_cDocTrans := SC5->C5_XSOLTRA

	EndIf

EndIf

dbSelectArea("NNS")
dbSetOrder(1)
If ! Empty(_cDocTrans)
	If dbSeek(xFilial("NNS") + _cDocTrans)
		getData(_cAlias, _cDocTrans, ::_cNota, ::_cSerie)
		dbSelectArea(_cAlias)
		if (_cAlias)->(!eof())
			_cHTML := htmlHead(_cDocTrans, _cAlias)
			_cHTML += htmlTable(_cAlias)
			_cHTML += htmlBottom()
			_cTo := getSolMail(NNS->NNS_SOLICT)
			_oSendMail := MailSend():New()
			_oSendMail:send( , _cTo, "", "Transferencia CD - " + _cDocTrans, _cHTML)		
		endif
	EndIf	
Endif

return

/*/{Protheus.doc} checkTrans
Fun��o respons�vel por verificar se existe solicita��o de transfer�ncia
atrelada a nota fiscal, caso exista retorna o n�mero da solicita��o
@author Renan Paiva
@since 29/06/2018
@version undefined
/*/
static function checkTrans(_cDoc, _cSer)

local _cRet 	:= ""
local _cAlias 	:= getNextAlias()

beginsql alias _cAlias
	%noparser%
	SELECT TOP 1 
		NNT_COD
	FROM 
		%table:NNT%

	WHERE 
		NNT_FILIAL = %xfilial:NNT%
		AND NNT_DOC = %exp:_cDoc%
		AND NNT_SERIE = %exp:_cSer%
		AND %notDel%
endsql	 

dbSelectArea(_cAlias)
_cRet := (_cAlias)->NNT_COD

(_cAlias)->(dbCloseArea())

return _cRet

/*/{Protheus.doc} getDados
@author Renan Paiva
@since 29/06/2018
@version undefined
@param _cAlias, caracter, alias a ser criado
@param _cCod, caracter, codigo da solicita��o de transfer�ncia
/*/
static function getData(_cAlias, _cCod, _cDoc, _cSer)

local _cNfEmpty := " "
local _cSerEmpty := " "

beginsql alias _cAlias
	%noparser%
	SELECT 
		NNT_PROD,
		B1_DESC,		
		NNT_XQTORI,
		NNT_QUANT,
		NNT_LOCLD,
		NNT_XOBSCO,
		CASE WHEN NNT.D_E_L_E_T_ != '' THEN 'REMOVIDO' 
			 WHEN NNT_QUANT < NNT_XQTORI THEN 'PARCIAL'
			 WHEN NNT_QUANT = NNT_XQTORI THEN 'TOTAL' 
			 WHEN NNT_QUANT > NNT_XQTORI THEN 'ADICIONADO' END STATUS
	FROM
		%table:NNT% NNT
	JOIN
		%table:SB1% SB1
	ON
		B1_FILIAL = %xfilial:SB1%
		AND B1_COD = NNT_PROD
		AND NNT_FILIAL = %xfilial:NNT%
		AND NNT_COD = %exp:_cCod%
		AND (NNT_DOC = %exp:_cDoc% OR NNT_DOC = %exp:_cNfEmpty%)
		AND (NNT_SERIE = %exp:_cSer% OR NNT_SERIE = %exp:_cSerEmpty%)
		AND SB1.%notDel%
endsql

return

/*/{Protheus.doc} getSolMail
Funcao para retornar o email do solicitante da transferencia.
@author Renan Paiva
@since 29/06/2018
@version undefined
@return return, return_description
@param _cSolicit, caractere, nome do solicitante
@type function
/*/
static function getSolMail(_cUserId)

local cEmail := ""
PswOrder(1)//ordena pelo id do usuario

if PswSeek(_cUserId, .T. )  
   cEmail := PswRet()[1][14] + SuperGetMv("MV_XENVMAI", .F., ";estoque@bdil.com.br;expedicao@bdil.com.br;")  // Retorna vetor com informa��es do usu�rio
endif

return cEmail //email

/*/{Protheus.doc} htmlHead
Funcao para gerar os dados do cabe�alho do HTML
@author Renan Paiva
@since 29/06/2018
@version undefined
@return return, return_description
@param _cDocTrans, , descricao
@type function
/*/
static function htmlHead(_cDocTrans, _cAlias)

local _cHtm := ""

_cHtm += '<html>'
_cHtm += '<body>'


_cHtm += '	<h2><u>Resumo de Atendimento - Solicitacao De Transferecia</u></h1>'
_cHtm += '	<h3>Informamos que a solicitacao de transferencia ' + _cDocTrans + ' realizada em ' + DtoC(NNS->NNS_DATA) + ' para o armazem ' + (_cAlias)->NNT_LOCLD + ' foi atendida.</h2>'
_cHtm += '	<h3>Nota Fiscal ' + SF2->F2_DOC + ' Serie ' + SF2->F2_SERIE + ' Data Faturamento ' + dToc( Date() ) + ' Hora ' + SUBSTR( TIME() ,1,5 ) + ' </h2> '
_cHtm += '  <h3>Abaixo esta o comparativo entre a quantidade solicitada e a quantidade enviada.*</h2>'

_cHtm += '	<table border=1 cellspacing=0 cellpadding=2>'
_cHtm += '		<tr bgcolor="#643C00">'
_cHtm += '			<td><font color="#FFF"><b>Produto</b></font></td>'
_cHtm += '			<td><font color="#FFF"><b>Descri&ccedil;&atilde;o</b></font></td>'
_cHtm += '			<td><font color="#FFF"><b>Qtd. Solicitada</b></font></td>'
_cHtm += '			<td><font color="#FFF"><b>Qtd. Transferida</b></font></td>'
_cHtm += '			<td><font color="#FFF"><b>Obs. Atendimento</b></font></td>'
_cHtm += '			<td><font color="#FFF"><b>Status</b></font></td>'
_cHtm += '		</tr>'

return _cHtm

static function htmlTable(_cAlias)

local _cHtm := ""
local i := 0

dbSelectArea(_cAlias)
while !eof()
	_cHtm += '		<tr ' + iif(i % 2 != 0, 'bgcolor="lightgrey"', "") + '>'
	_cHtm += '			<td>' + (_cAlias)->NNT_PROD + '</td>'
	_cHtm += '			<td>' + (_cAlias)->B1_DESC + '</td>'
	_cHtm += '			<td>' + transform((_cAlias)->NNT_XQTORI,"@E 999,999,999.999") + '</td>'
	_cHtm += '			<td>' + transform((_cAlias)->NNT_QUANT,"@E 999,999,999.999") + '</td>'
	_cHtm += '			<td>' + (_cAlias)->NNT_XOBSCO + '</td>'
	_cHtm += '			<td>' + (_cAlias)->STATUS + '</td>'
	_cHtm += '		</tr>'
	skip()
	i++
enddo
return _cHtm

/*/{Protheus.doc} htmlBottom
// Funcao para preencher o fim do HTML
@author renan
@since 04/07/2018
@version undefined
@return return, return_description
@example
(examples)
@see (links_or_references)
/*/
static function htmlBottom

local _cHtm := ""

_cHtm += '	</table>'
_cHtm += '	<p><i>* Informamos que a quantidade enviada pode ser diferente da solicitada devido a e, disponibilidade do item em estoque ou descontinuidade do seu uso.</i></p>'
_cHtm += '</body>'
_cHtm += '</html>'

return _cHtm
