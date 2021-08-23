#include 'protheus.ch'

user function bdilSISPAG(_cFunction, _xParam)

do case
	case _cFunction == "VALTIT"
		_nValor := 0
		//VALOR FINANCEIRO
		//nValMoeda+nMulta+nJuros-nDescont+nAcresc-nDecresc-nPis-nCoFins-nCsll-nIrrf-nIss
		_nValor += SE2->(E2_VALOR + E2_ACRESC - E2_DECRESC - E2_DESCONT)

		//DESCONTA O VALOR DOS IMPOSTSO
		_nValor -= SE2->(E2_ISS + E2_IRRF + E2_INSS + E2_PIS + E2_COFINS + E2_CSLL + E2_SEST)

		return strzero(round(_nValor,2)*100, _xParam)
		 
	case _cFunction == "VALLIQ"
		_nValor := 0
		//VALOR FINANCEIRO
		//nValMoeda+nMulta+nJuros-nDescont+nAcresc-nDecresc-nPis-nCoFins-nCsll-nIrrf-nIss
		_nValor += SE2->E2_VALOR

		//DESCONTA O VALOR DOS IMPOSTSO
		_nValor -= SE2->(E2_ISS + E2_IRRF + E2_INSS + E2_PIS + E2_COFINS + E2_CSLL + E2_SEST)

		return strzero(round(_nValor,2)*100, _xParam) 
endcase
		
return 
/*/{Protheus.doc} bdilSISPAG
Classe para trabalhar as informações necessárias para o SISPAG
@author    Renan Paiva
@since     02/10/2018
@version   ${version}
@example
(examples)
@see (links_or_references)
/*/
class bdilSISPAG 

	method getBanco(xFornece, xLoja)
	method getAgencia(xFornece, xLoja)
	method getConta(xFornece, xLoja)	
	method getCNPJ(xFornece, xLoja)
	method getNumEnd()	

endclass

/*/{Protheus.doc} getBanco
Metodo para Retornar a banco do fornecedor
@author Renan Paiva
@since 02/10/2018
@version undefined
@example
(examples)
@see (links_or_references)
/*/
method getBanco(xFornece, xLoja) class bdilSISPAG 

local _aArea := {SA2->(GetArea()), GetArea()}
dbSelectArea("SA2")
dbSetOrder(1)
dbSeek(xFilial("SA2") + xFornece + xLoja)
if fieldpos("A2_XPAGCEN") > 0 .And. SA2->A2_XPAGCEN == "S"
	dbSelectArea("SA2")
	dbSetOrder(3)//filial + cnpj
	if dbSeek(xFilial("SA2") + LEFT(SA2->A2_CGC, 8) + "0001")
		return SA2->A2_BANCO
	else
		msgInfo("Não foi encontrado fornecedor para pagamento centralizado", "NOTFOUND")
		return SPACE(TAMSX3("SA2", "A2_BANCO")[1])
	endif
endif
aEval(_aArea,{|x| RestArea(x)})

return SA2->A2_BANCO

/*/{Protheus.doc} getAgencia
Metodo para Retornar a agencia bancária
@author Renan Paiva
@since 02/10/2018
@version undefined
@example
(examples)
@see (links_or_references)
/*/
method getAgencia(xFornece, xLoja) class bdilSISPAG

local _aArea := {SA2->(GetArea()), GetArea()}
dbSelectArea("SA2")
dbSetOrder(1)
dbSeek(xFilial("SA2") + xFornece + xLoja)
if fieldpos("A2_XPAGCEN") > 0 .And. SA2->A2_XPAGCEN == "S"
	dbSelectArea("SA2")
	dbSetOrder(3)//filial + cnpj
	if dbSeek(xFilial("SA2") + LEFT(SA2->A2_CGC, 8) + "0001")
		return SA2->A2_AGENCIA
	else
		msgInfo("Não foi encontrado fornecedor para pagamento centralizado", "NOTFOUND")
		return SPACE(TAMSX3("SA2", "A2_AGENCIA")[1])
	endif
endif
aEval(_aArea,{|x| RestArea(x)})

return SA2->A2_AGENCIA

/*/{Protheus.doc} getConta
Metodo para Retornar a conta bancária
@author Renan Paiva
@since 02/10/2018
@version undefined
@example
(examples)
@see (links_or_references)
/*/
method getConta(xFornece, xLoja) class bdilSISPAG

local _aArea := {SA2->(GetArea()), GetArea()}
dbSelectArea("SA2")
dbSetOrder(1)
dbSeek(xFilial("SA2") + xFornece + xLoja)
if fieldpos("A2_XPAGCEN") > 0 .And. SA2->A2_XPAGCEN == "S"
	dbSelectArea("SA2")
	dbSetOrder(3)//filial + cnpj
	if dbSeek(xFilial("SA2") + LEFT(SA2->A2_CGC, 8) + "0001")
		return SA2->A2_CONTAB
	else
		msgInfo("Não foi encontrado fornecedor para pagamento centralizado", "NOTFOUND")
		return SPACE(TAMSX3("SA2", "A2_CONTAB")[1])
	endif
endif
aEval(_aArea,{|x| RestArea(x)})

return SA2->A2_CONTAB

/*/{Protheus.doc} getCNPJ
Metodo para Retornar o CNPJ do fornecedor, quando for pagamento centralizado
retorna o CNPJ da Matriz
@author Renan Paiva
@since 02/10/2018
@version undefined
@example
(examples)
@see (links_or_references)
/*/
method getCNPJ(xFornece, xLoja) class bdilSISPAG

local _aArea := {SA2->(GetArea()), GetArea()}
dbSelectArea("SA2")
dbSetOrder(1)
dbSeek(xFilial("SA2") + xFornece + xLoja)
if fieldpos("A2_XPAGCEN") > 0 .And. SA2->A2_XPAGCEN == "S"
	dbSelectArea("SA2")
	dbSetOrder(3)//filial + cnpj
	if dbSeek(xFilial("SA2") + LEFT(SA2->A2_CGC, 8) + "0001")
		return SA2->A2_CGC
	else
		msgInfo("Não foi encontrado fornecedor para pagamento centralizado", "NOTFOUND")
		return SPACE(TAMSX3("SA2", "A2_CGC")[1])
	endif
endif
aEval(_aArea,{|x| RestArea(x)})

return SA2->A2_CGC

/*/{Protheus.doc} getNumEnd
Funcao para Retornar o Número do Endereço
@author Renan Paiva
@since 04/10/2018
@version undefined
@example
(examples)
@see (links_or_references)
/*/
method getNumEnd(tamCampo) class bdilSISPAG

default tamCampo := 0
	
return STRZERO(VAL(SUBS(SM0->M0_ENDCOB,AT(",",SM0->M0_ENDCOB)+1, tamCampo)),tamCampo)