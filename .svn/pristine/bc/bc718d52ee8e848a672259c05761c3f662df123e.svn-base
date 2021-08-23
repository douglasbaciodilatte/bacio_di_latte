#Include 'Protheus.ch'

/*---------------------------------------------------------------------------------------
{Protheus.doc} IN210AL1
Rdmake Responsável pelo retorno de campos a serem gravados na tabela SL1 Loja
@class      Nao Informado
@from       Nao Informado
@param      _nRecno -> Registro relacionado ao PIN esta posicionado
@attrib     Nao Informado
@protected  Nao Informado
@author     TOTVS
@Date     	16/02/2017
@version    P.12
@since      Nao Informado  
@return     ARRAY
@sample     Nao Informado
@obs        Esta funcionalidade deve retornar um ARRAY bidimensional com duas posições ex {"CAMPO",CONTEUDO}
			Já esta posicionado o registro da tabela  PIN
@project    Integração de arquivos - Motor de Integração
@menu       Nao Informado
@history    
---------------------------------------------------------------------------------------*/

User Function IN210AL1

Local _aRet 	:= {}				//Array de retorno
Local _nPos		:= 0				//Variavel de tratamento para posicionamento no Array
Local _nPosPG	:= 0				//Variavel de tratamento para posicionamento no Array da Forma de Pagamento
Local _nRecPIN	:= ParamIXB[1]		//Recno que esta sendo processado
Local _cVend	:= ""
Local _aFormas	:= {}
Local _aArmPDV	:= {}

Begin Sequence
	//Filiais do Legado
	If PIN->( FieldPos("PIN_XFILEX") ) > 0	.and. SL1->( FieldPos("L1_XFILEX") ) > 0 //Validando a Camada do Motor de Integração e verificando existência no Padrão do Campo		
		Aadd( _aRet, {"L1_XFILEX"	, PIN->PIN_XFILEX} ) 
	EndIf
	
	//Verifica se existe o Array do cabeçalho do Orcamento
	If Type("_aSL1") <> "U" .And. ValType(_aSL1) == "A"
		//Busca a posicao do campo de Operador no array
		If (_nPos := aScan(_aSL1,{|x| Alltrim(x[1]) == "L1_OPERADO" })) > 0
			_aSL1[_nPos][2] := SuperGetMV("ES_CXAFIL",,"CXA")
		Else
			Aadd( _aRet, {"L1_OPERADO"	, SuperGetMV("ES_CXAFIL",,"CXA")} ) 
		EndIf
		
		//Busca a posicao do campo de Forma de Pagamento no array
		If (_nPos := aScan(_aSL1,{|x| Alltrim(x[1]) == "L1_FORMPG" })) > 0
			_aSL1[_nPos][2] := Space(TamSX3("L1_FORMPG")[1])
		Else
			Aadd( _aRet, {"L1_FORMPG"	, Space(TamSX3("L1_FORMPG")[1])} ) 
		EndIf
		
		//Chama a funcao para buscar as formas de pagamento 
		_aFormas := AL1FormPG(_nRecPIN)
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄD¿
		//³Caso retorne alguma forma de pagamento, realiza o       ³
		//³tratamento para atualizar os campos acumuladores do     ³
		//³cabecalho da venda para ajustar, conforme a necessidade ³
		//³do GCV.                                                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄDÙ
		If Len(_aFormas) > 0
			If (_nPos := aScan(_aSL1,{|x| Alltrim(x[1]) == "L1_DINHEIR" })) > 0
				If (_nPosPG := aScan(_aFormas,{|x| Alltrim(x[1]) == "R$" })) > 0
					_aSL1[_nPos][2] := _aFormas[_nPosPG][2]
				Else
					_aSL1[_nPos][2] := 0
				EndIf
			EndIf
			
			If (_nPos := aScan(_aSL1,{|x| Alltrim(x[1]) == "L1_CARTAO"	})) > 0
				If (_nPosPG := aScan(_aFormas,{|x| Alltrim(x[1]) == "CC" })) > 0
					_aSL1[_nPos][2] := _aFormas[_nPosPG][2]
				Else
					_aSL1[_nPos][2] := 0
				EndIf
			EndIf
			
			If (_nPos := aScan(_aSL1,{|x| Alltrim(x[1]) == "L1_VLRDEBI" })) > 0
				If (_nPosPG := aScan(_aFormas,{|x| Alltrim(x[1]) == "CD" })) > 0
					_aSL1[_nPos][2] := _aFormas[_nPosPG][2]
				Else
					_aSL1[_nPos][2] := 0
				EndIf
			EndIf
		EndIf

		//Atualiza o campo do Vendedor
		If (_nPos := aScan(_aSL1,{|x| Alltrim(x[1]) == "L1_ESTACAO" })) > 0
			If !Empty(_aSL1[_nPos][2])				
				//Busca os dados de amarracao 
				_aArmPDV := U_BACAA011(_aSL1[_nPos][2])
				/*==============================\
				|	Elementos do array _aArmPDV	|
				|_aArmPDV[1] - Deposito			|
				|_aArmPDV[2] - Centro de Custo	| 
				|_aArmPDV[3] - Conta Corrente	|
				\==============================*/
				
				If (_nPos := aScan(_aSL1,{|x| Alltrim(x[1]) == "L1_VEND" })) > 0
					_aSL1[_nPos][2] := IIF(Len(_aArmPDV) > 0,_aArmPDV[1],"")
				ElseIf SL1->( FieldPos("L1_VEND") ) > 0
					Aadd( _aRet, {"L1_VEND"	, IIF(Len(_aArmPDV) > 0,_aArmPDV[1],"") } ) 
				EndIf 
			EndIf
		EndIf	
	EndIf
End Sequence

Return _aRet

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AL1FormPG ºAutor  ³Microsiga           º Data ³  06/22/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function AL1FormPG(_nRecPIN)

Local _aRet		:= {}
Local _cQry		:= ""
Local _cAlias	:= GetNextAlias()
Local _aArea	:= GetArea()
Local _aAreaPIN	:= PIN->( GetArea() )

_cQry := "SELECT PIP_FORMA, SUM(PIP_VALOR) PIP_VALOR FROM " + RetSqlName("PIP")
_cQry += " WHERE PIP_FILIAL = '" + PIN->PIN_FILIAL + "'"
_cQry += "   AND PIP_XCODEX = '" + PIN->PIN_XCODEX + "'"
_cQry += "   AND D_E_L_E_T_ = ' '"
_cQry += " GROUP BY PIP_FORMA"
DbUseArea( .T., "TOPCONN", TcGenQry(,,_cQry), _cAlias, .T., .F. )
While !(_cAlias)->( Eof() )
	aAdd(_aRet,{(_cAlias)->PIP_FORMA,(_cAlias)->PIP_VALOR})
	
	(_cAlias)->( dbSkip() )
End

(_cAlias)->( dbCloseArea() )

RestArea(_aArea)
RestArea(_aAreaPIN)

Return _aRet