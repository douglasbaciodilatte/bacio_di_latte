#Include 'Protheus.ch'

User Function WFW120P()
Local aAreas		:= {SC7->(GetArea()),GetArea()}

If SC7->C7_CONAPRO == "L"

	// Verifica se todos os itens do pedido estão liberados.
	If VerPedCom(SC7->C7_NUM)		
		If MsgYesNo('Deseja enviar o email de notificação ao Fornecedor?')
			If FieldPos("C7_XWFINI") > 0
				_aArea := SC7->(GETAREA())
				_cChave := SC7->(C7_FILIAL + C7_NUM)
				While SC7->(!Eof()) .And. _cChave == SC7->(C7_FILIAL + C7_NUM)
					RecLock("SC7", .F.)
					SC7->C7_XWFINI := "S"
					MsUnLock()
					SC7->(dbSkip())
				EndDo
				RestArea(_aArea)
			EndIf
			u_ASCOM001(SC7->C7_NUM, SC7->C7_FORNECE, SC7->C7_LOJA)
		EndIf
		//Adicionado por Renan Paiva em 29/01/2019 projeto menu compra - lojas
		MsgInfo("Será impresso o relatório deste pedido em PDF, imprima e guarde-o para realizar a conferência no ato da entrega.","Imprimir Pedido")
		u_blcomr10( "SC7", SC7->(Recno()), SC7->C7_TIPO )
	EndIf
EndIf

AEval(aAreas, {|x| RestArea(x) })
Return


/*/{Protheus.doc} VerPedCom
Verifica se todos os itens do pedido estão liberados

@Author Wanderley Ramos Neto
@Since 05/06/2017
@Param cNumPed Numerodo pedido de compras que sera verificado
@Return lAprov
/*/
Static Function VerPedCom(cNumPed)

Local lAprov			:= .T.
Local aAreas		:= {SC7->(GetArea()), GetArea()}
Local cFilSC7			:= xFilial('SC7')

SC7->(dbSetOrder(1))
If SC7->( dbSeek( cFilSC7 + cNumPed ) )

	While  SC7->(!Eof());
			.And. SC7->C7_NUM == cNumPed
			
		// Verifica se item esta liberado
		lAprov := SC7->C7_CONAPRO == "L"
		
		If !lAprov
			Exit
		EndIf
		
		SC7->(dbSkip())
	End

EndIf


AEval(aAreas, {|x| RestArea(x) })
Return lAprov