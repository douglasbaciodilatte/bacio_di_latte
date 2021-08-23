#Include "Protheus.ch"

/*

{Protheus.doc} MA410Cor

Esta rotina monta uma dialog com a descricao das cores da Mbrowse. 

@author  Vanito Rocha
@since   28/12/2020
*/


User Function MA410COR()

Local aCores := {}
Local ni

aAdd(aCores, {"C5_STAREF == '2'", "BR_VIOLETA", "Pedido Separacao Refrio"})
aAdd(aCores, {"C5_STAREF == '4'", "BR_PRETO"  , "Com Erros Refrio"})

For ni:=1 to Len(ParamIXB)
	Aadd(aCores,ParamIXB[ni])
NExt

Return(aCores)
