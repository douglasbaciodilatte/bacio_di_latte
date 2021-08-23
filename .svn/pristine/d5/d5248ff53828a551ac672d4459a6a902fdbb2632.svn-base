#include 'protheus.ch'
#include 'parmtype.ch'

#Define STR_PULA		Chr(13)+Chr(10)

/*/{Protheus.doc} CEGPEM01
// 				Criar perguntas (SX1) ou Tela de Filtro de Empresa/Filial por usuários
@author 		Eduardo Pessoa
@since 			02/08/2019
@version 		1.0
@type 			User function
@example		u_CEGPEM01( _cPergInc, _aItens, _lMens)

@param  		_cPergInc	, Caractere , Nome da pergunta a ser avalidada.
@param 			_aItens		, Array     , Array com a estrutura de Pergutnas a ser criada, sendo:
@param 		    _lMens		, Lógico	, Mostrar Mensagens?

				@param cOrdem,    characters, Ordem da Pergunta        (ex.: 01, 02, 03, ...)
				@param cTexto,    characters, Texto da Pergunta        (ex.: Produto De, Produto Até, Data De, ...)
				@param cMVPar,    characters, MV_PAR?? da Pergunta     (ex.: MV_PAR01, MV_PAR02, MV_PAR03, ...)
				@param cVariavel, characters, Variável da Pergunta     (ex.: MV_CH0, MV_CH1, MV_CH2, ...)
				@param cTipoCamp, characters, Tipo do Campo            (C = Caracter, N = Numérico, D = Data)
				@param nTamanho,  numeric,    Tamanho da Pergunta      (Máximo de 60)
				@param nDecimal,  numeric,    Tamanho de Decimais      (Máximo de 9)
				@param cTipoPar,  characters, Tipo do Parâmetro        (G = Get, C = Combo, F = Escolha de Arquivos, K = Check Box)
				@param cValid,    characters, Validação da Pergunta    (ex.: Positivo(), u_SuaFuncao(), ...)
				@param cF3,       characters, Consulta F3 da Pergunta  (ex.: SB1, SA1, ...)
				@param cPicture,  characters, Máscara do Parâmetro     (ex.: @!, @E 999.99, ...)
				@param cDef01,    characters, Primeira opção do combo
				@param cDef02,    characters, Segunda opção do combo
				@param cDef03,    characters, Terceira opção do combo
				@param cDef04,    characters, Quarta opção do combo
				@param cDef05,    characters, Quinta opção do combo
				@param cHelp,     characters, Texto de Help do parâmetro (Limitado a 30 caracteres)
				
@return 		_lRet, Lógico, Se Ok análise Perguntas.
@obs 			Exclusivo CIEE
 /*/
user function CEGPEM01(_cPergInc, _aItens, _lMens)

Local _aAreaAnt:= { GetArea(), SX1->(GetArea()) }
Local _lRet    := .T.
Local _nIt     := 0
 
DeFault _lMens 	  := .T.
DeFault _aItens	  := {}
DeFault _cPergInc := ''
 
//Definições da pergunta
DbSelectArea("SX1")
SX1->(DbSetOrder(1)) //X1_GRUPO + X1_ORDEM
If !SX1->(DbSeek(_cPergInc)) .and. !Empty(_cPergInc) .and. valtype( _aItens) == 'A' .AND. !Empty(_aItens)  

	// Verificando tamanho Array
	if len(_aItens[01]) == 17

		// Incluindo os registros.
		for _nIt := 1 to len(_aItens)
		
			cTipoPar 	:= _aItens[_nIt][11]
			nPreSel 	:= Iif(cTipoPar == "C", 1, 0) 
			cOrdem		:= _aItens[_nIt][01] 
			cChaveHelp 	:= "P." + AllTrim(_cPergInc) + AllTrim(cOrdem) + "."
			cHelp       := _aItens[_nIt][17] 
			
			RecLock('SX1', .T.)
			
		        X1_GRUPO   := _cPergInc 		// _cPergInc
		        X1_ORDEM   := cOrdem 			// cOrdem
		        X1_PERGUNT := _aItens[_nIt][02] // cTexto
		        X1_PERSPA  := _aItens[_nIt][02] // cTexto
		        X1_PERENG  := _aItens[_nIt][02] // cTexto
		        X1_VAR01   := _aItens[_nIt][03] // cMVPar
		        X1_VARIAVL := _aItens[_nIt][04] // cVariavel
		        X1_TIPO    := _aItens[_nIt][05] // cTipoCamp
		        X1_TAMANHO := _aItens[_nIt][06] // nTamanho
		        X1_DECIMAL := _aItens[_nIt][07] // nDecimal
		        X1_GSC     := _aItens[_nIt][08] // cTipoPar
		        X1_VALID   := _aItens[_nIt][09] // cValid
		        X1_F3      := _aItens[_nIt][10] // cF3
		        X1_PICTURE := _aItens[_nIt][11] // cPicture
		        X1_DEF01   := _aItens[_nIt][12] // cDef01
		        X1_DEFSPA1 := _aItens[_nIt][12] // cDef01
		        X1_DEFENG1 := _aItens[_nIt][12] // cDef01
		        X1_DEF02   := _aItens[_nIt][13] // cDef02
		        X1_DEFSPA2 := _aItens[_nIt][13] // cDef02
		        X1_DEFENG2 := _aItens[_nIt][13] // cDef02
		        X1_DEF03   := _aItens[_nIt][14] // cDef03
		        X1_DEFSPA3 := _aItens[_nIt][14] // cDef03
		        X1_DEFENG3 := _aItens[_nIt][14] // cDef03
		        X1_DEF04   := _aItens[_nIt][15] // cDef04
		        X1_DEFSPA4 := _aItens[_nIt][15] // cDef04
		        X1_DEFENG4 := _aItens[_nIt][15] // cDef04
		        X1_DEF05   := _aItens[_nIt][16] // cDef05
		        X1_DEFSPA5 := _aItens[_nIt][16] // cDef05
		        X1_DEFENG5 := _aItens[_nIt][16] // cDef05
		        X1_PRESEL  := nPreSel 		    // nPreSel
		         
	            //Se tiver Help da Pergunta
	            If !Empty( cHelp )
	            
	                X1_HELP := ""
	                fAtuHelp(cChaveHelp, cHelp)
	                
	            EndIf
	            
	        SX1->(MsUnlock())
		
		Next
		
	Else
		
		// Se exibir mensagem, mostra estrutura.
		if _lMens
		
			MsgAlert ('O tamanho da estrutura enviada  não esta de acordo para se criar a Pergunta. ' + chr(13) + chr(10) + ;
					  'A seguir será exibida a estrutura desejada.', 'Atenção')
					  
			_cMensEstr := 'O Array enviado deverá ter 17 posições, sendo: ' 													+ STR_PULA
			_cMensEstr += '=====================================' 																+ STR_PULA
			_cMensEstr += "@param cOrdem,    characters, Ordem da Pergunta        (ex.: 01, 02, 03, ...)"						+ STR_PULA
			_cMensEstr += "@param cTexto,    characters, Texto da Pergunta        (ex.: Produto De, Produto Até, Data De, ...)" + STR_PULA
			_cMensEstr += "@param cMVPar,    characters, MV_PAR?? da Pergunta     (ex.: MV_PAR01, MV_PAR02, MV_PAR03, ...)"     + STR_PULA
			_cMensEstr += "@param cVariavel, characters, Variável da Pergunta     (ex.: MV_CH0, MV_CH1, MV_CH2, ...)"			+ STR_PULA
			_cMensEstr += "@param cTipoCamp, characters, Tipo do Campo            (C = Caracter, N = Numérico, D = Data)"		+ STR_PULA
			_cMensEstr += "@param nTamanho,  numeric,    Tamanho da Pergunta      (Máximo de 60)"								+ STR_PULA
			_cMensEstr += "@param nDecimal,  numeric,    Tamanho de Decimais      (Máximo de 9)"								+ STR_PULA
			_cMensEstr += "@param cTipoPar,  characters, Tipo do Parâmetro        (G = Get, C = Combo, F = Escolha de Arquivos, K = Check Box)"	 + STR_PULA
			_cMensEstr += "@param cValid,    characters, Validação da Pergunta    (ex.: Positivo(), u_SuaFuncao(), ...)"						 + STR_PULA
			_cMensEstr += "@param cF3,       characters, Consulta F3 da Pergunta  (ex.: SB1, SA1, ...)"										     + STR_PULA
			_cMensEstr += "@param cPicture,  characters, Máscara do Parâmetro     (ex.: @!, @E 999.99, ...)										 + STR_PULA
			_cMensEstr += "@param cDef01,    characters, Primeira opção do combo"										 		+ STR_PULA
			_cMensEstr += "@param cDef02,    characters, Segunda opção do combo"										 		+ STR_PULA
			_cMensEstr += "@param cDef03,    characters, Terceira opção do combo"										 		+ STR_PULA
			_cMensEstr += "@param cDef04,    characters, Quarta opção do combo"										 			+ STR_PULA
			_cMensEstr += "@param cDef05,    characters, Quinta opção do combo"										 			+ STR_PULA
			_cMensEstr += "@param cHelp,     characters, Texto de Help do parâmetro"										 	+ STR_PULA
			
			EeCview(_cMensEstr)
			_lRet := .F.
					  
		Endif
		
	Endif

	 
Endif

// Retorna aos ambientes
aEval(_aAreaAnt, {|x| RestArea(x) })

Return _lRet
 
/*---------------------------------------------------*
 | Função: fAtuHelp                                  |
 | Desc:   Função que insere o Help do Parametro     |
 *---------------------------------------------------*/
 
Static Function fAtuHelp(cKey, cTxtHelp, lUpdate)

Local cFilePor  := "SIGAHLP.HLP"
Local cFileEng  := "SIGAHLE.HLE"
Local cFileSpa  := "SIGAHLS.HLS"
Local nRet      := 0

Default cKey    := ""
Default cTxtHelp:= ""
Default lUpdate := .F.
 
//Se a Chave ou o Help estiverem em branco
If Empty(cKey) .Or. Empty(cTxtHelp)
    Return
EndIf
 
//**************************** Português
nRet := SPF_SEEK(cFilePor, cKey, 1)
 
//Se não encontrar, será inclusão
If nRet < 0
    SPF_INSERT(cFilePor, cKey, , , cTxtHelp)
 
//Senão, será atualização
Else
    If lUpdate
        SPF_UPDATE(cFilePor, nRet, cKey, , , cTxtHelp)
    EndIf
EndIf
 
 
 
//**************************** Inglês
nRet := SPF_SEEK(cFileEng, cKey, 1)
 
//Se não encontrar, será inclusão
If nRet < 0
    SPF_INSERT(cFileEng, cKey, , , cTxtHelp)
 
//Senão, será atualização
Else
    If lUpdate
        SPF_UPDATE(cFileEng, nRet, cKey, , , cTxtHelp)
    EndIf
EndIf
 
 
 
//**************************** Espanhol
nRet := SPF_SEEK(cFileSpa, cKey, 1)
 
//Se não encontrar, será inclusão
If nRet < 0
    SPF_INSERT(cFileSpa, cKey, , , cTxtHelp)
 
//Senão, será atualização
Else
    If lUpdate
        SPF_UPDATE(cFileSpa, nRet, cKey, , , cTxtHelp)
    EndIf
EndIf
 
Return
	
 