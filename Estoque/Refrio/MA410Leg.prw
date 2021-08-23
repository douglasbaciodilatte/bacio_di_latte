#Include "Protheus.ch"

/*
{Protheus.doc} MA410Leg
Complementa a legenda das cores da mbrowse 
@author  Vanito Rocha
@since   28/12/2020
*/

User Function MA410Leg()
Local aCores := {}

aCores := ParamIXB

Aadd(aCores,{"BR_VIOLETA","Pedido Separacao Refrio"})
Aadd(aCores,{"BR_PRETO"  ,"Com Erros Refrio"})

Return(aCores)
