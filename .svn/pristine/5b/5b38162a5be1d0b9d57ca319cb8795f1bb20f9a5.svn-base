#Include 'Protheus.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³I210CLIOK ºAutor  ³Microsiga           º Data ³  04/25/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de Entrada na Integracao de Cupons no Motor para 	  º±±
±±º          ³realizar a validacao/escolha do Cliente/Loja conforme regra º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Motor de Integracao										  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function I210CLIOK(_cChaveSA1,_nOrdem,nRecPin)

Local _lRet		:= .T.												//Variavel de Retorno
Local _aArea	:= GetArea()										//Salva a Area atual
Local _aAreaPIN	:= PIN->( GetArea() )								//Salva a Area da tabela PIN - Cabecalho da Venda de Cupom
Local _cCliPad  := Alltrim(SuperGetMV( "MV_CLIPAD"   ,.F.,"" ))		//Cliente Padrao
Local _cLojaPad := Alltrim(SuperGetMV( "MV_LOJAPAD"  ,.F.,"" ))		//Loja do Cliente Padrao

Default _cChaveSA1	:= ""											//Chave de pesquisa da tabela de Cliente
Default _nOrdem		:= 0											//Ordem usada para a pesquisa do cliente
Default nRecPin		:= 0											//Recno do registro na tabela PIN

//Verifica se o Recno recebido eh Valido
If nRecPin > 0

	dbSelectArea("PIN")
	PIN->( dbGoTo( nRecPin ) )
	//Verifica se o Recno recebido existem na base de dados
	If PIN->( Eof() )
		_lRet := .F.
	Else
		//Pesquisa se o cliente recebido na integracao é um Cliente Padrao e se o parametro da Loja Padrao está preenchido
		If Alltrim(PIN_CLIENT) == Alltrim(_cCliPad) .And. !Empty(_cLojaPad)
			_cChaveSA1	:= xFilial("SA1") + PadR(_cCliPad,TamSX3("A1_COD")[1]) + PadR(_cLojaPad,TamSX3("A1_LOJA")[1])
			_nOrdem		:= 1	//A1_FILIAL+A1_COD+A1_LOJA
		Else
			
		EndIf
	EndIf
Else
	_lRet := .F.
EndIf

RestArea(_aArea)
RestArea(_aAreaPIN)

Return _lRet