#include "totvs.ch"
#include "tbiconn.ch"

/*//#########################################################################################
Fonte   : blestr11
Objetivo: Envio de email com aviso de pend?ncia de invent?rio
Autor   : Renan Paiva
Data    : 05/02/2019
*///#########################################################################################


/*/{Protheus.doc} blestr11
/*/
user function blestr11(_aEmp)

if !empty(_aEmp)
    PREPARE ENVIRONMENT EMPRESA _aEmp[1] FILIAL _aEmp[2] MODULO "EST"
endif

private _dData := FirstDay(Date()) - 1 //ultimo dia do mes anterior
private _cDestMail := SuperGetMv("MV_XDESINV", .F., "douglas.silva@bdil.com.br;elisangela.anastacio@bdil.com.br;fabio.meireles@bdil.com.br;thiago@bdil.com.br")
private _cAlias := getDados(_dData)
private _cHtmlGer := "<p>Bom dia!</p><p>Segue lista das lojas com pend?ncia de invent?rio para o per?odo: " + right(dtoc(_dData),7) + ".</p>"
private _cHtmlLj := "<p>Bom dia!</p><p>At? o momento n?o identificamos a inclus?o do invent?rio do ?limo m?s " + right(dtoc(_dData),7) + ".</p><p>Favor providenciar o quanto antes</p><p>Em caso de d?vida favor abrir chamado atrav?s do sistema de tickets</p><br>"
private _oMailSrv := MailSend():New()
private _lSendMail := .F.

dbSelectArea(_cAlias)
_lSendMail := !eof()
while !eof()
    _oMailSrv:send( , "lj" + left((_cAlias)->NNR_CODIGO,4) + "@bdil.com.br", "", "Invent?rio Pendente", _cHtmlLj)
    _cHtmlGer += (_cAlias)->NNR_DESCRI + "</br>"
    dbSkip()
enddo

if _lSendMail
    _oMailSrv:send( , _cDestMail, "", "Lojas Com Pend?ncia de Invent?rio", _cHtmlGer)
endif

return


/*/{Protheus.doc} getDados

   Fun??o para retornar as lojas com pend?ncia de invent?rio

   @author  Renan paiva
   @return  Area Criada - string 
   @table   NNR
   @since   05-02-2019
/*/
static function getLojas()

local _cAlias := GetNextAlias()

beginsql alias _cAlias
    SELECT NNR_CODIGO, NNR_DESCRI
    FROM %table:NNR%
    WHERE NNR_XINVEN == "S"
    AND %notdel%
endsql

return _cAlias
