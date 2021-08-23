#include 'protheus.ch'
#include 'parmtype.ch'
/*/{Protheus.doc} bdlctb02
Funcao para retornar o valor da tarifa referente a administrador de cartoes
@author Renan Paiva
@since 12/12/2018
/*/
user function bdlctb02(_cFilial, _cNumNota, _cSerie)

local _aArea := GetArea()
local _nRet := 0
	
dbSelectArea("SE1")
dbOrderNickname("BDLE1")
if dbSeek(_cFilial + _cNumNota + _cSerie)
	If SE1->E1_TIPO != "R$ " //Alterado por Douglas Silva 14:55 14/01/2020 - Não entrar subtrair caso recebimento em dinheiro chamado: 21121  
		_nRet := SF2->F2_VALBRUT - SE1->E1_VALOR
	EndIf	
endif	

RestArea(_aArea)

return _nRet