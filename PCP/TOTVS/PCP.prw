#INCLUDE "rwmake.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TbiConn.ch"
#INCLUDE "TbiCode.ch"


/*/{Protheus.doc} uMovInterno
Gravacao do Movimento Interno Modelo 2 via ExecAuto
@author Agility
@since 17/11/2015
@version 1.0
@example
(examples)
@see (links_or_references)
/*/
Class uMovInterno From uExecAuto
	Data cDocumento
	Data dEmissao

	Method New()
	Method AddValues(cCampo, xValor)
	Method Gravacao(nOpcao)
	Method GetDocumento()
EndClass

/*/{Protheus.doc} New
Inicializacao do Objeto.
@author Agility
@since 17/11/2015
@version 1.0
@example
(examples)
@see (links_or_references)
/*/
Method New() Class uMovInterno
	_Super:New()

	::aTabelas		:= {"SD3"}
	::cDocumento	:= ""
	::dEmissao		:= CtoD("")
Return Self
/*/{Protheus.doc} AddCabec
Adiciona os dados do Cabecalho para Gravacao
@author Agility
@since 17/11/2015
@version 1.0
@param cCampo, character, (Descricao do parametro)
@param xValor, varivel, (Descricao do parametro)
@example
(examples)
@see (links_or_references)
/*/
Method AddValues(cCampo, xValor) Class uMovInterno

	If AllTrim(cCampo) == "D3_DOC"
		::cDocumento	:= xValor
	ElseIf AllTrim(cCampo) == "D3_EMISSAO"
		::dEmissao		:= xValor
	EndIf

	_Super:AddValues(cCampo, xValor)

Return Nil
/*/{Protheus.doc} Gravacao
Gravacao via ExecAuto.
@author Agility
@since 17/11/2015
@version 1.0
@param nOpcao, numrico, (Descricao do parametro)
@example
(examples)
@see (links_or_references)
/*/
Method Gravacao(nOpcao) Class uMovInterno
	Local dDataBackup	:= dDataBase		//Backup da Data Base do Sistema
	Local lReserva		:= .F.				//Determina se reservou o Documento para Inclusao
	Local lRetorno		:= .T.				//Retorno da Rotina de Gravacao
	Local nPosProd		:= 0
	Local nPosUnMd		:= 0
	Local cUnidMed		:= ""

	Private	lMsErroAuto	:= .F.				//Determina se houve algum erro durante a Execucao da Rotina Automatica

	If !Empty(::dEmissao)
		dDataBase := ::dEmissao
	EndIf

	DbSelectArea("SD3")
	DbSetOrder(2)	//D3_FILIAL, D3_DOC, D3_COD

	If nOpcao == 3
		If Empty(::cDocumento)
			lReserva := .T.
			::AddValues("D3_DOC", GetSx8Num("SD3", "D3_DOC"))
		EndIf
	Else
		If Empty(::cDocumento)
			lRetorno	:= .F.
			::cMensagem	:= "Documento nใo informado."
		Else
			If !SD3->(DbSeek(xFilial("SD3") + ::cDocumento))
				lRetorno	:= .F.
				::cMensagem	:= "Documento nใo localizado."
			EndIf
		EndIf
	EndIf

	If lRetorno .and. Len(::aValues) > 0
		nPosProd := Ascan(::aValues, {|x| x[01] == "D3_COD"})
		nPosUnMd := Ascan(::aValues, {|x| x[01] == "D3_UM"})

		If nPosProd > 0
			DbSelectArea("SB1")
			DbSetOrder(1)

			If SB1->(DbSeek(xFilial("SB1") + ::aValues[nPosProd][02]))
				cUnidMed := SB1->B1_UM

				If nPosUnMd > 0
					::aValues[nPosUnMd][02] := cUnidMed
				Else
					Aadd(::aValues, {"D3_UM", cUnidMed, NIL})
				EndIf
			EndIf
		EndIf

		MSExecAuto({|a, b, c| MATA240(a, b)}, ::aValues, nOpcao)

		If lMsErroAuto

			lRetorno := .F.

			If lReserva
				RollBackSx8()
			EndIf

			If ::lExibeTela
				MostraErro()
			EndIf

			If ::lGravaLog
				::cMensagem := MostraErro(::cPathLog, ::cFileLog)
			EndIf
		Else
			If lReserva
				ConfirmSx8()
			EndIf
		EndIf
	EndIf

	//Restaura a Data Base Original
	dDataBase := dDataBackup

Return lRetorno

/*/{Protheus.doc} GetDocumento
Retorna o Numero do Documento Gerado
@author Agility
@since 16/11/2015
@version 1.0
@example
(examples)
@see (links_or_references)
/*/
Method GetDocumento() Class uMovInterno
Return ::cDocumento

Class uExecAuto
	Data aCabec							//Dados do Cabecalho
	Data aItens							//Dados dos Itens
	Data aItemTemp						//Array temporario para o Item
	Data aTabelas						//Array com as Tabelas que devem ser abertas na Preparacao do Ambiente
	Data aValues						//Dados para Gravacao

	Data cEmpBkp						//Backup da Empresa Original
	Data cFilBkp						//Backup da Filial Original
	Data cEmpGrv						//Empresa para Gravacao
	Data cFileLog						//Nome do Arquivo para Gravacao de Log de Erro da Rotina Automatica
	Data cFilGrv						//Filial para Gravacao
	Data cMensagem						//Mensagem de Erro
	Data cPathLog						//Caminho para Gravacao do Arquivo de Log

	Data lExibeTela						//Define se deve exibir Tela com a Mensagem de Erro
	Data lGravaLog						//Define se deve gravar arquivo de log com a Mensagem de Erro

	Method New() Constructor			//Inializacao do Objeto
	Method AddValues(cCampo, xValor)	//Adiciona dados para Gravacao
	Method AddCabec(cCampo, xValor)		//Adicona dados ao Cabecalho
	Method AddItem(cCampo, xValor)		//Adiciona dados ao Item
	Method SetItem()					//Insere os dados do Item no Array dos Itens
	Method GetMensagem()				//Retorno das Mensagens de Erro
	Method SetEnv()		//Prepara o Ambiente para Execucao da Rotina Automatica
EndClass

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Method   ณ New      บAutor  ณ Guilherme Santos   บ Data ณ  17/04/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Inicializa o Objeto                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Method New() Class uExecAuto
	::aCabec		:= {}
	::aItens		:= {}
	::aItemTemp		:= {}
	::aTabelas		:= {}
	::aValues		:= {}

	::cEmpBkp		:= ""
	::cFilBkp		:= ""
	::cEmpGrv		:= ""
	::cFilGrv		:= ""
	::cMensagem		:= ""

	::cFileLog		:= FunName()+".LOG"
	::cPathLog		:= "\LOGS\"

	::lExibeTela	:= .T.
	::lGravaLog	:= .T.
Return Self

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบ Method   ณ AddValues บAutor  ณ Guilherme Santos   บ Data ณ 17/04/09   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณ Armazena os valores para gravacao                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ uExecAuto                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Method AddValues(cCampo, xValor) Class uExecAuto
	Local nPosCpo := Ascan(::aValues, {|x| AllTrim(x[01]) == AllTrim(cCampo)})

	If !Empty(xValor)
		If AllTrim(cCampo) == "EMPRESA"
			::cEmpGrv := xValor
		Else
			If "_FILIAL" $ AllTrim(cCampo)
				::cFilGrv := xValor
			EndIf

			If nPosCpo == 0
				Aadd(::aValues, {cCampo		,xValor		, NIL})
			Else
				::aValues[nPosCpo][02] := xValor
			EndIf
		EndIf
	EndIf
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Metodo   ณ AddCabec  บ Autor ณ Guilherme Santos  บ Data ณ  17/04/09   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯอออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Armazena os Valores do Cabecalho do para gravacao.         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ cCampo - Nome do Campo para Gravacao                       บฑฑ
ฑฑบ          ณ xValor - Valor do Campo para Gravacao                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Classe uExecAuto                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Method AddCabec(cCampo, xValor) Class uExecAuto
	Local nPosCpo := Ascan(::aCabec, {|x| x[01] == cCampo})		//Posicao do Campo no Array

	If !Empty(xValor)
		If AllTrim(cCampo) == "EMPRESA"
			::cEmpGrv := xValor
		Else
			If "_FILIAL" $ AllTrim(cCampo)
				::cFilGrv	:= xValor
			EndIf

			If nPosCpo == 0
				Aadd(::aCabec, {cCampo, xValor, NIL})
			Else
				::aCabec[nPosCpo][02] := xValor
			EndIf
		EndIf
	EndIf
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Metodo   ณ AddItem   บ Autor ณ Guilherme Santos  บ Data ณ  17/04/09   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯอออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Armazena os Valores do Item para gravacao.                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ cCampo - Nome do Campo para Gravacao                       บฑฑ
ฑฑบ          ณ xValor - Valor do Campo para Gravacao                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Classe uExecAuto                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Method AddItem(cCampo, xValor) Class uExecAuto
	Local nPosCpo := Ascan(::aItemTemp, {|x| x[01] == cCampo})

	If !Empty(xValor)
		If !AllTrim(cCampo) == "EMPRESA"
			If nPosCpo == 0
				Aadd(::aItemTemp, {cCampo, xValor, NIL})
			Else
				::aItemTemp[nPosCpo][02] := xValor
			EndIf
		EndIf
	EndIf
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Metodo   ณ SetItem   บ Autor ณ Guilherme Santos  บ Data ณ  17/04/09   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯอออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Armazena os Valores do Item e Reinicializa o Array         บฑฑ
ฑฑบ          ณ Temporario.                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ cCampo - Nome do Campo para Gravacao                       บฑฑ
ฑฑบ          ณ xValor - Valor do Campo para Gravacao                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Classe uExecAuto                                           บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Method SetItem() Class uExecAuto
	Aadd(::aItens, ::aItemTemp)
	::aItemTemp := {}
Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออหอออออออัอออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบ Method   ณ GetMensagem บ Autor ณ Guilherme Santos  บ Data ณ 08/04/09  บฑฑ
ฑฑฬออออออออออุอออออออออออออสอออออออฯอออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a Mensagem de Erro do ExecAuto                     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ uExecAuto                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Method GetMensagem() Class uExecAuto
Return ::cMensagem

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัอออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Method   ณ SetEnv    บ Autor ณ Guilherme Santos  บ Data ณ  17/04/09   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯอออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Prepara o Ambiente para Gravacao na Empresa correta.       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametro ณ nOpcao -> 1 = Prepara / 2 = Restaura                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ uExecAuto                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Method SetEnv() Class uExecAuto

	::lExibeTela	:= SuperGetMV("CL_SHOWERR", NIL, .T.)
	::lGravaLog		:= SuperGetMV("CL_GRVLOG", NIL, .F.)

Return Nil

/*/{Protheus.doc} uProducao
Classe responsavel pela gravacao da uProducao via MsExecAuto.
@author Agility
@since 05/11/2015
@version 1.0
@example
uProducao():New()
/*/
Class uProducao From uExecAuto
	Data	cArmazem						//Armazem do Produto incluido pela uProducao
	Data	cNumOP							//Numero da Ordem de uProducao baixada
	Data	cProduto						//Codigo do Produto incluido pela uProducao
	Data	cDocProd						//Documento da uProducao
	Data	dEmissao

	Method	New()							//Inicializa o Objeto
	Method	AddValues(cCampo, xValor)		//Armazena os Campos e Valores da uProducao
	Method	Gravacao(nOpcao)				//Efetua a Gravacao da uProducao
	Method	GetArmazem()					//Retorna o Armazem
	Method	GetNumOP()						//Retorna o Numero da Ordem de uProducao
	Method	GetProduto()					//Retorna o Codigo do Produto
	Method	GetDocProd()					//Retorna o Documento da uProducao
	Method	SetRegistro()					//Atribui o Numero do Registro para Estorno
EndClass

/*/{Protheus.doc} New
Inicializa o Objeto uProducao
@author Agility
@since 05/11/2015
@version 1.0
@example
uProducao():New()
/*/
Method New() Class uProducao
	_Super:New()

	::cArmazem	:= ""
	::cNumOP	:= ""
	::cProduto	:= ""
	::cDocProd	:= ""
	::dEmissao	:= CtoD("")
Return Self

/*/{Protheus.doc} AddValues
Armazena os valores para gravacao
@author Agility
@since 05/11/2015
@version 1.0
@param cCampo, character, String do nome do campo a adicionar
@param xValor, varivel, conteudo do campo a adicionar
@example
uProducao:AddValues(cCampo, xValor)
/*/
Method AddValues(cCampo, xValor) Class uProducao

	If AllTrim(cCampo) == "D3_OP"
		::cNumOP	:= xValor
	ElseIf AllTrim(cCampo) == "D3_COD"
		::cProduto	:= xValor
	ElseIf AllTrim(cCampo) == "D3_LOCAL"
		::cArmazem	:= xValor
	ElseIf AllTrim(cCampo) == "D3_DOC"
		::cDocProd	:= xValor
	ElseIf AllTrim(cCampo) == "D3_EMISSAO"
		::dEmissao	:= xValor
	ElseIf AllTrim(cCampo) == "D3_CUSTO1"
		xValor := Round(xValor, TamSX3("D3_CUSTO1")[2])
	EndIf

	_Super:AddValues(cCampo, xValor)

Return Nil

/*/{Protheus.doc} Gravacao
Metodo de gravacao do apontamento de producao
@author Agility
@since 05/11/2015
@version 1.0
@param nOpcao, numrico, Opcao a executar (IAE)
/*/
Method Gravacao(nOpcao) Class uProducao
	Local dDataBackup	:= dDataBase		//Backup da Data Base do Sistema
	Local lReserva		:= .F.
	Local lRetorno		:= .T.

	Private	lMsErroAuto	:= .F.

	//Prepara o Ambiente para Execucao na Empresa e na Filial Informada
	::SetEnv(1, "EST")

	If !Empty(::dEmissao)
		dDataBase := ::dEmissao
	EndIf

	DbSelectArea("SD3")
	DbSetOrder(1)		//D3_FILIAL, D3_OP, D3_COD, D3_LOCAL

	If nOpcao == 3
		If Empty(::cDocProd)
			lReserva	:= .T.
			::AddValues("D3_DOC", GetSx8Num("SD3", "D3_DOC"))
		EndIf
	Else
		If Empty(::cDocProd)
			lRetorno 	:= .F.
			::cMensagem	:= "Documento da Produ็ใo nใo informado."
		Else
			If !::SetRegistro()
				lRetorno 	:= .F.
				::cMensagem	:= "Movimento de Produ็ใo nใo localizado."
			EndIf
		EndIf
	EndIf

	If lRetorno
		MSExecAuto({|x, y| MATA250(x, y, .F.)}, ::aValues, nOpcao)

		If lMsErroAuto
			lRetorno := .F.

			If lReserva
				RollBackSx8()
			EndIf

			If ::lExibeTela
				MostraErro()
			EndIf

			If ::lGravaLog
				::cMensagem := MostraErro(::cPathLog, ::cFileLog)
			EndIf
		EndIf
	Else
		If lReserva
			ConfirmSx8()
		EndIf
	EndIf

	//Restaura a Data Base Original
	dDataBase := dDataBackup

	//Restaura o Ambiente Original
	::SetEnv(2, "EST")

Return lRetorno

Method	GetArmazem() Class uProducao
Return ::cArmazem

Method	GetNumOP() Class uProducao
Return ::cNumOP

Method	GetProduto() Class uProducao
Return ::cProduto

Method	GetDocProd() Class uProducao
Return ::cDocProd

/*/{Protheus.doc} SetRegistro
Atribui o Recno para posicionamento durante a Execucao da Rotina Automatica.
@author Agility
@since 05/11/2015
@version 1.0
@example
uProducao:SetRegistro()
/*/
Method SetRegistro() Class uProducao
	Local cQuery	:= ""
	Local lRetorno	:= .F.

	cQuery += "SELECT	SD3.R_E_C_N_O_ REGISTRO" + CRLF

	cQuery += "	FROM	" + RetSqlName("SD3") + " SD3" + CRLF
	cQuery += "	,		" + RetSqlName("SF5") + " SF5" + CRLF

	cQuery += "	WHERE	SD3.D3_FILIAL = '" + xFilial("SD3") + "'" + CRLF
	cQuery += "	AND		SF5.F5_FILIAL = '" + xFilial("SF5") + "'" + CRLF

	cQuery += "	AND		SD3.D3_TM = SF5.F5_CODIGO" + CRLF
	cQuery += "	AND		SF5.F5_TIPO = 'P'" + CRLF

	cQuery += "	AND		D3_COD = '" + ::cProduto + "'" + CRLF
	cQuery += "	AND		D3_OP = '" + ::cNumOP + "'" + CRLF
	cQuery += "	AND		D3_LOCAL = '" + ::cArmazem + "'" + CRLF
	cQuery += "	AND		D3_DOC = '" + ::cDocProd + "'" + CRLF
	cQuery += "	AND		D3_CF = 'PR0'" + CRLF
	cQuery += "	AND		D3_ESTORNO <> 'S'" + CRLF

	cQuery := ChangeQuery(cQuery)

	DbUseArea(.T., "TopConn", TCGenQry( NIL, NIL, cQuery), "TRBPRD", .F., .F.)

	While !TRBPRD->(Eof())
		nRegistro	:= TRBPRD->REGISTRO
		lRetorno	:= .T.
		TRBPRD->(DbSkip())
	End

Return lRetorno

Class uProduto From uExecAuto

	Method New() Constructor
	Method AddValues(cCampo, xValor)
	Method Gravacao(nOpcao)
EndClass

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบ Method   ณ New      บAutor  ณ Agility Solutions  บ Data ณ  18/12/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Inicializa o Objeto                                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Method New() Class uProduto
	_Super:New()

	::aTabelas	:= {"SB1"}
	::cFileLog	:= "MATA010.LOG"
	::lExibeTela	:= .T.
	::lGravaLog	:= .F.
Return Self

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบ Method   ณ AddValues บAutor  ณ Agility Solutions  บ Data ณ 18/12/13   บฑฑ
ฑฑฬออออออออออุอออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณ Armazena os valores para gravacao                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Produto                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Method AddValues(cCampo, xValor) Class uProduto

	_Super:AddValues(cCampo, xValor)

Return Nil                    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออออหอออออออัออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบ Method   ณ Gravacao    บ Autor ณ Agility Solutions บ Data ณ 18/12/13  บฑฑ
ฑฑฬออออออออออุออออออออออออออสอออออออฯออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDesc.     ณ Gravacao dos dados do Produto.                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Produto                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Method Gravacao(nOpcao) Class uProduto
	Local lRetorno		:= .T.
	Private	lMsErroAuto	:= .F.

	::SetEnv(1, "EST")

	DbSelectArea("SB1")

	//Gravacao do Produto
	MSExecAuto({|a, b| MATA010(a, b)}, ::aValues, nOpcao)

	If lMsErroAuto
		lRetorno := .F.

		If ::lExibeTela
			MostraErro()
		EndIf

		If ::lGravaLog
			::cMensagem := MostraErro(::cPathLog, ::cFileLog)
		EndIf
	EndIf

	::SetEnv(2, "EST")

Return lRetorno

static function ajustaSx1(cPerg)
	//Aqui utilizo a fun็ใo putSx1, ela cria a pergunta na tabela de perguntas
	putSx1(cPerg, "01", "Data De ?"		, "", "", "mv_ch1", "D", tamSx3("D3_EMISSAO")[1], 0, 0, "G", "", "", "", "", "mv_par01")
	putSx1(cPerg, "02", "Data Ate?"		, "", "", "mv_ch2", "D", tamSx3("D3_EMISSAO")[1], 0, 0, "G", "", "", "", "", "mv_par02")
return