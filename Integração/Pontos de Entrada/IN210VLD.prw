#Include 'Protheus.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IN210VLD  ºAutor  ³Microsiga           º Data ³  01/12/18   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de Entrada do Motor de Integracao para validar se a   º±±
±±º          ³venda pode ser gerada no Protheus							  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Motor de Integracao - Integracao de Venda				  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function IN210VLD(_cStaImp,nRecPIN,_cErro,_aSL1,_aSL2,_aSL4)

Local _lRet 	:= .T.					//Variavel de controle para retorno da transacao
Local _nPos		:= 0					//Variavel de controle para posicionamento
Local _nI		:= 0					//Variavel de controle para Laco

//Valida campos do cabecalho do Orcamento
If (_nPos := aScan(_aSL1,{|x| Alltrim(x[1]) == "L1_VEND" 	})) > 0 .And. Empty(_aSL1[_nPos][2])
	_cErro += "[Cabecalho] Codigo do Vendedor nao Preenchido"
ElseIf (_nPos := aScan(_aSL1,{|x| Alltrim(x[1]) == "L1_OPERADO" })) > 0 .And. Empty(_aSL1[_nPos][2])
	_cErro += "[Cabecalho] Operador em branco"
EndIf
//Fim das validacoes do Cabecalho

//Valida campos dos Itens
For _nI := 1 to Len(_aSL2)
	If     (_nPos := aScan(_aSL2[_nI],{|x| Alltrim(x[1]) == "L2_LOCAL"		})) == 0
		_cErro += "[Item] Deposito em branco"
	Else
		If Empty(_aSL2[_nI][_nPos][2])
			_cErro += "[Item] Deposito em branco"
		EndIf
	EndIf
	
	If (_nPos := aScan(_aSL2[_nI],{|x| Alltrim(x[1]) == "L2_XCCUSTO"	})) == 0
		_cErro += "[Item] Centro de Custo em Branco"
	Else
		If Empty(_aSL2[_nI][_nPos][2])
			_cErro += "[Item] Centro de Custo em Branco"
		EndIf
	EndIf
	
	If (_nPos := aScan(_aSL2[_nI],{|x| Alltrim(x[1]) == "L2_VEND"		})) == 0
		_cErro += "[Item] Codigo do Vendedor nao Preenchido"
	Else
		If Empty(_aSL2[_nI][_nPos][2])
			_cErro += "[Item] Codigo do Vendedor nao Preenchido"
		EndIf
	EndIf
Next _nI
//Fim das validacoes dos Itens

//Valida campos das Formas de Pagamento
/*
For _nI := 1 to Len(_aSL4)
Next _nI
*/
//Fim das Validacoes das Formas de Pagamento

//Caso a variavel de controle da mensagem de erro esteja preenchida, retorna um codigo de erro para salvar no campo PIN_STAIMP
If !Empty(_cErro)
	_cStaImp	:= "4"
	_lRet		:= .F.

EndIf

Return _lRet