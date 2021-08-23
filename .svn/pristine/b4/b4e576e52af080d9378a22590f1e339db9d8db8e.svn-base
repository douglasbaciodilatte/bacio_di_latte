#include 'protheus.ch'
#include 'parmtype.ch'

/*/{Protheus.doc} bdlctb01
//TODO Funcao para retornar o numero da conta contabil do financeiro
//     de acordo com a conta contábil da natureza do título 
@author Renan Paiva
@since 22/06/2018
@version v1.01
@return cCtaRet, conta contabil da natureza do título a receber
@param cFilial, characters, filial do titulo
@param cNumNota, characters, numero da nota fiscal
@param cSerie, characters, serie da nota fiscal
/*/
user function bdlctb01(_cFilial, _cNumNota, _cSerie)

local _cCtaRet := ""         
local _aArea := {SED->(GetArea()), GetArea()}
	
dbSelectArea("SE1")
dbOrderNickname("BDLE1")
if dbSeek(_cFilial + _cNumNota + _cSerie)
	dbSelectArea("SED")
	dbSetOrder(1)
	if dbSeek(xFilial("SED") + SE1->E1_NATUREZ)
		_cCtaRet := SED->ED_CONTA
	endif
endif

aEval(_aArea, {|x| RestArea(x)})

return _cCtaRet