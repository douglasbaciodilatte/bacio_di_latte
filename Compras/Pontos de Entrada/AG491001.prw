// #########################################################################################
// Projeto:
// Modulo :
// Fonte  : AG491001.prw
// -----------+-------------------+---------------------------------------------------------
// Data       | Autor             | Descricao
// -----------+-------------------+---------------------------------------------------------
// 16/10/2017 | perez             | Gerado com auxílio do Assistente de Código do TDS.
// -----------+-------------------+---------------------------------------------------------

#include "protheus.ch"
#include "vkey.ch"

//------------------------------------------------------------------------------------------
/*/{Protheus.doc} AG491001
Processa a tabela SC7-Pedidos de Compra.

@author    perez
@version   11.3.5.201703092121
@since     16/10/2017
/*/
//------------------------------------------------------------------------------------------
User function AG491001()
	Local aArea    := GetArea()
	Local aAreaSC7 := SC7->(GetArea())
	Local cNumPc   := ""

	cNumPc:=GetSxENum("SC7","C7_NUM",RetSQLName("SC7"))
	dbSelectArea("SC7")
	dbSetOrder(1)
	While ChkChaveSC7(cNumPc) .or. !MayIUseCode(RetSQLName("SC7")+'/'+cNumPc,RetCodUsr())
		If ( __lSx8 )
			ConfirmSX8()
		EndIf
		cNumPc := GetSxENum("SC7","C7_NUM",RetSQLName("SC7"))
	EndDo
	RestArea(aAreaSC7)
	RestArea(aArea)
Return(cNumPc)

User Function MT120FIM()
	//Local nOpcao := PARAMIXB[1]   // Opção Escolhida pelo usuario 
	//Local cNumPC := PARAMIXB[2]   // Numero do Pedido de Compras
	Local nOpcA  := PARAMIXB[3]   // Indica se a ação foi Cancelada = 0  ou Confirmada = 1.

	FreeUsedCode()
	If nOpcA == 1
		ConfirmSX8()
	Else
		RollbackSXE()
	EndIf
Return