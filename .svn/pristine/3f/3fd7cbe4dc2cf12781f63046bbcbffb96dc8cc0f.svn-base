#Include 'Protheus.ch'

User Function WFW120P()
Local aAreas		:= {SC7->(GetArea()),GetArea()}

If SC7->C7_CONAPRO == "L"

	// Verifica se todos os itens do pedido estão liberados.
	If VerPedCom(SC7->C7_NUM)		
		If MsgYesNo('Deseja enviar o email de notificação ao Fornecedor?')
			u_ASCOM001(SC7->C7_NUM, SC7->C7_FORNECE, SC7->C7_LOJA)
		EndIf
		Matr110( "SC7", SC7->(Recno()), SC7->C7_TIPO ) //Adicionado por Renan Paiva em 27/04/2018 solicitado por Marcelo Magalhaes, impressaoa do relatorio
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