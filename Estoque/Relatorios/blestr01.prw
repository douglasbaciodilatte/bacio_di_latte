#include 'protheus.ch'
#include 'parmtype.ch'
#Include "Protheus.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} BLESTR01
// 				Relatório Nota Fiscal de Entrada com Usuário
@author 		Eduardo Pessoa
@since 			31/07/2019
@version 		1.0
@type 			User function
@example		u_CBFINR06()
@param  		Nulo	, Nulo     , Nenhum
@return 		Nulo	, Nulo     , Nenhu
@obs 			Exclusivo Bacio di Late
/*/
user function BLESTR01()

	Local _aAreaAnt := { GetArea() }
	Local lEmail  	:= .F.
	Local cPara   	:= ""
	Local _lCont    := .T.
	Local oReport

	Private cPerg   := "BLESTR01"
	Private _aAcUsu :={}
	Private _cFilFilter := ""
	Private MV_PAR02 := Ctod("  /  /  ")
	Private MV_PAR03 := Ctod("  /  /  ")

	//Definições da pergunta
	DbSelectArea("SX1")
	SX1->(DbSetOrder(1)) //X1_GRUPO + X1_ORDEM
	If !SX1->(DbSeek(cPerg))
		_aPerg := {}
		Aadd( _aPerg, {"01", "Tipo da NFE?"		    	, "MV_PAR01", "mv_ch1", "C", TamSX3('F1_TIPO')[01]		, 0, "C", ""            ,  	  				, , 'N=Normal', 'D=Devolução', 'C=Complemento', , , "Informe o Tipo da Nota de Entrada" } )
		Aadd( _aPerg, {"02", "DT Digitação De: ?"		, "MV_PAR02", "mv_ch2", "D", TamSX3('D1_DTDIGIT')[01]	, 0, "G", "NaoVazio()"	, "SD1"				, , , , , , , "Informe Data de digitação inicial" } )
		Aadd( _aPerg, {"03", "DT Digitação Até:?"		, "MV_PAR03", "mv_ch3", "D", TamSX3('D1_DTDIGIT')[01]	, 0, "G", "NaoVazio()"	, "SD1"				, , , , , , , "Informe Data de digitação final" } )

		// Incluir a pergunta.
		_lCont := u_CEGPEM01( cPerg, _aPerg, .T.)

	EndIf
	Pergunte(cPerg,.T.)
	// Se OK Continua
	if _lCont

		// Solicita filtro por filial
		_aAcUsu := u_CEGPEM02()

		if !Empty(_aAcUsu)
			For ix := 1 to Len(_aAcUsu)
				IIF(ix = Len(_aAcUsu),_cFilFilter += _aAcUsu[ix,2] ,_cFilFilter += _aAcUsu[ix,2]+"/")
			Next ix

			_cFilFilter:= FormatIn(_cFilFilter,"/")

			//Cria as definições do relatório
			oReport := fReportDef()

			//Será enviado por e-Mail?
			If lEmail

				oReport:nRemoteType := NO_REMOTE
				oReport:cEmail := cPara
				oReport:nDevice := 3 //1-Arquivo,2-Impressora,3-email,4-Planilha e 5-Html
				oReport:SetPreview(.F.)
				oReport:Print(.F., "", .T.)

				//Senão, mostra a tela
			Else
				oReport:PrintDialog()
			EndIf

		Else

			MsgAlert ('Não foi selecionada nenhuma Empresa/Filial para Emissão do Relatório', 'Atenção')

		Endif

	Endif

	// Retorna aos ambientes
	aEval(_aAreaAnt, {|x| RestArea(x) })

Return

/*-------------------------------------------------------------------------------*
| Func:  fReportDef                                                             |
| Desc:  Função que monta a definição do relatório                              |
*-------------------------------------------------------------------------------*/

Static Function fReportDef()

	Local oReport
	Local oSecCabec := Nil
	Local oSecItens := Nil
	Local oBreak := Nil

	//Criação do componente de impressão
	oReport := TReport():New(	"BLFINCR06",;						//Nome do Relatório
	"Nota Fiscal de Entrada com Usuário",;			//Título
	cPerg,;								//Pergunte ... Se eu defino a pergunta aqui, será impresso uma página com os parâmetros, conforme privilégio 101
	{|oReport| _ImpRel(oReport)},;		//Bloco de código que será executado na confirmação da impressão
	)		//Descrição
	oReport:SetTotalInLine(.F.)
	oReport:lParamPage := .F.
	oReport:oPage:SetPaperSize(9) //Folha A4
	oReport:SetLandscape()
	oReport:SetLineHeight(60)
	//oReport:nFontBody := 06
	oReport:cFontBody := 'Arial'
	oReport:nFontBody := 12

	//Criando a seção de dados
	oSecCabec := TRSection():New( oReport,;
	"Relatorio de Notas Fiscais de Entrada",;
	"SF1")
	oSecCabec:SetTotalInLine(.F.)
	TRCell():New(oSecCabec, "F1_FILIAL"			, ""	, "Filial"		    	, /*Picture*/	    , 020, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSecCabec, "F1_SERIE"			, ""	, "Série"				, /*Picture*/	    , 020, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSecCabec, "F1_DOC"			, ""	, "Doc"					, /*Picture*/	    , 040, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign */,/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSecCabec, "F1_EMISSAO"		, ""	, "Emissão"	            , /*Picture*/	    , 040, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,"RIGHT",/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSecCabec, "F1_FORNECE"	    , ""	, "Cod. Fornece"		, /*Picture*/	    , 040, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,"RIGHT",/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSecCabec, "F1_LOJA"	        , ""	, "Loja"		        , /*Picture*/	    , 020, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cHeaderAlign*/,/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSecCabec, "A2_NREDUZ"			, ""	, "Nome"	            , /*Picture*/	    , 100, /*lPixel*/,/*{|| code-block de impressao }*/,/*cAlign*/,/*lLineBreak*/,/*cAlign*/,/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)

	oSecItens := TRSection():New(	oReport,;		//Objeto TReport que a seção pertence
	"Dados",;		//Descrição da seção
	{"QRY_AUX"})		//Tabelas utilizadas, a primeira será considerada como principal da seção
	oSecItens:SetTotalInLine(.F.)  //Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha

	//Colunas do relatório
	TRCell():New(oSecItens, "D1_ITEM"			, ""	, "Item"		        , /*Picture*/	    , 020, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,"RIGHT",/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSecItens, "D1_COD"	    	, ""	, "Produto"	            , /*Picture*/	    , 030, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,"RIGHT",/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSecItens, "B1_DESC"	    	, ""	, "Descrição"	        , /*Picture*/	    , 1000, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,"RIGHT",/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSecItens, "D1_UM"	        	, ""	, "UM"	                , /*Picture*/	    , 020, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,"RIGHT",/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSecItens, "B1_GRUPO"	    	, ""	, "Grupo"	            , /*Picture*/	    , 020, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,"RIGHT",/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSecItens, "D1_QUANT"		    , ""	, "Quantidade"	        , "@E 9,999,999.99" , 050, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,"RIGHT",/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSecItens, "D1_VUNIT"	    	, ""	, "Preço Unit."         , "@E 9,999,999.99" , 050, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,"RIGHT",/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSecItens, "D1_TOTAL"  		, ""	, "Total"	            , "@E 9,999,999.99" , 050, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,"RIGHT",/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)
	TRCell():New(oSecItens, "D1_USERLGI"		, ""	, "Usuário"	            , /*Picture*/	    , 050, /*lPixel*/,/*{|| code-block de impressao }*/,"RIGHT",/*lLineBreak*/,"RIGHT",/*lCellBreak*/,/*nColSpace*/,.T.,/*nClrBack*/,/*nClrFore*/,/*lBold*/)

	TRFunction():New(oSecItens:Cell("D1_TOTAL"),NIL,"SUM",,,,,.F.,.T.)
	oReport:SetTotalInLine(.F.)
       
    //Aqui, farei uma quebra  por seção
	oSecCabec:SetPageBreak(.F.)
	oSecCabec:SetTotalText(" ")
Return oReport

/*-------------------------------------------------------------------------------*
| Func:  _ImpRel                                                                |
| Desc:  Função que imprime o relatório                                         |
*-------------------------------------------------------------------------------*/

Static Function _ImpRel(oReport)

	Local _aAreaAnt:= { GetArea() }
	Local cQryAux   := ""
	Local oSecCabec := oReport:Section(1)
	Local oSecItens := oReport:Section(2)
	Local _nAtual   := 0
	Local _nTotal   := 0
	Local _aRegs    := {}
	Local aFinal    := {}
	Local cTipoNF   := IIF(MV_PAR01=1,'N','D')
	Local _cNFE     := ""
	

	//Pegando as seções do relatório
	oReport:SetTitle( "Relatório de Notas Fiscais de Entrada" )

	//Montando consulta de dados
	_cAlias := GetNextAlias()
	_cWhereFil := '%F1_FILIAL IN ' + _cFilFilter + '%'
	BeginSql   ALIAS _cAlias

		%noParser%

		SELECT
		F1_FILIAL,F1_SERIE,F1_DOC,F1_EMISSAO,F1_FORNECE,F1_LOJA, A2_NREDUZ,
		D1_ITEM,D1_COD,B1_DESC,D1_UM,B1_GRUPO,D1_QUANT,D1_VUNIT,
		D1_TOTAL,SD1.R_E_C_N_O_
		FROM
		%table:SD1% SD1
		INNER JOIN SA2010 SA2 on (D1_FORNECE=A2_COD AND D1_LOJA=A2_LOJA) 
        INNER JOIN SF1010 SF1 on (F1_DOC = D1_DOC AND F1_SERIE = D1_SERIE AND F1_FORNECE = D1_FORNECE AND F1_LOJA = D1_LOJA)
        INNER JOIN SB1010 SB1 on (D1_COD = B1_COD)
		WHERE
		SF1.%notdel% AND SA2.%notdel% AND SD1.%notdel% AND SB1.%notdel%
		AND F1_DOC = D1_DOC AND F1_SERIE = D1_SERIE AND F1_FORNECE =  D1_FORNECE AND F1_LOJA = D1_LOJA
		AND D1_COD = B1_COD AND F1_TIPO = %exp:cTipoNF% AND D1_DTDIGIT BETWEEN %exp:Dtos(MV_PAR02)%
		AND %exp:Dtos(MV_PAR03)%
		AND %Exp:_cWhereFil%
	EndSql

	//Executando consulta e setando o total da régua -->
	MemoWrite("c:\temp\blfincr06.sql",GetLastQuery()[02])//-->ver erros.

	oReport:SetMeter((_cAlias)->(LastRec()))

	While !(_cAlias)->(EOF())
		If oReport:Cancel()
			Exit
		EndIf
		
		oSecCabec:Init()
		
		oReport:IncMeter()

		_cNFE := (_cAlias)->F1_FILIAL+(_cAlias)->F1_SERIE+(_cAlias)->F1_DOC+(_cAlias)->F1_EMISSAO+(_cAlias)->F1_FORNECE+(_cAlias)->F1_LOJA
		//IncProc("Imprimindo relatório de notas fiscais de entrada "+_cNFE)
		oSecCabec:Cell("F1_FILIAL"	):SetValue( (_cAlias)->F1_FILIAL  )
		oSecCabec:Cell("F1_SERIE"	):SetValue( (_cAlias)->F1_SERIE  )
		oSecCabec:Cell("F1_DOC"	    ):SetValue( (_cAlias)->F1_DOC )
		oSecCabec:Cell("F1_EMISSAO"	):SetValue( (_cAlias)->F1_EMISSAO )
		oSecCabec:Cell("F1_FORNECE"	):SetValue( (_cAlias)->F1_FORNECE )
		oSecCabec:Cell("F1_LOJA"	):SetValue( (_cAlias)->F1_LOJA )
		oSecCabec:Cell("A2_NREDUZ"	):SetValue( (_cAlias)->A2_NREDUZ )
		oSecCabec:PrintLine()
		
		

		While (_cAlias)->F1_FILIAL+(_cAlias)->F1_SERIE+(_cAlias)->F1_DOC+(_cAlias)->F1_EMISSAO+(_cAlias)->F1_FORNECE+(_cAlias)->F1_LOJA = _cNFE
			
			If oReport:Cancel()
				Exit
			EndIf
		    oSecItens:Init()	
			oReport:IncMeter()
			
			dbSelectArea("SD1")
			dbGoTo((_cAlias)->R_E_C_N_O_)
			
			IncProc("Imprimindo item "+(_cAlias)->D1_ITEM)
			oSecItens:Cell("D1_ITEM"	):SetValue( (_cAlias)->D1_ITEM )
			oSecItens:Cell("D1_COD"	    ):SetValue( (_cAlias)->D1_COD )
			oSecItens:Cell("B1_DESC"	):SetValue( (_cAlias)->B1_DESC )
			oSecItens:Cell("D1_UM"	    ):SetValue( (_cAlias)->D1_UM )
			oSecItens:Cell("B1_GRUPO"	):SetValue( (_cAlias)->B1_GRUPO )
			oSecItens:Cell("D1_QUANT"	):SetValue( (_cAlias)->D1_QUANT )
			oSecItens:Cell("D1_VUNIT"	):SetValue( (_cAlias)->D1_VUNIT )
			oSecItens:Cell("D1_TOTAL"	):SetValue( (_cAlias)->D1_TOTAL )
			oSecItens:Cell("D1_USERLGI"	):SetValue( MyLGI("SD1->D1_USERLGI",1) )
			oSecItens:PrintLine()
			(_cAlias)->(dbSkip())
		End
		//finalizo a segunda seção para que seja reiniciada para o proximo registro
		oSecItens:Finish()
		//imprimo uma linha para separar uma NCM de outra
		oReport:ThinLine()
		//finalizo a primeira seção
		oSecCabec:Finish()
	End

	// Retorna aos ambientes
	aEval(_aAreaAnt, {|x| RestArea(x) })

Return

Static Function MyLGI(cCampo,nTipo)
Local cRet := ""
Local cAux := Embaralha(&cCampo,1)
Local __aUserLg := {}
Local lChgAlias := .F.

If !Empty(cAux)
	If Subs(cAux, 1, 2) == "#@"
		cID := Subs(cAux, 3, 6)
		If Empty(__aUserLg) .Or. Ascan(__aUserLg, {|x| x[1] == cID}) == 0                            
			PSWORDER(1)
			If ( PSWSEEK(cID) )
				cUsrName	:= Alltrim(PSWRET()[1][2])
			EndIf		
			Aadd(__aUserLg, {cID, cUsrName})	
		EndIf
		
		If nTipo == 1 // retorna o usuário
			nPos := Ascan(__aUserLg, {|x| x[1] == cID})
			cRet := __aUserLg[nPos][2]
		Else
			cRet := Dtoc(CTOD("01/01/96","DDMMYY") + Load2In4(Substr(cAux,16)))
		Endif                         
	Else
		If nTipo == 1 // retorna o usuário
			cRet := Subs(cAux,1,15)
		Else   
			cRet := Dtoc(CTOD("01/01/96","DDMMYY") + Load2In4(Substr(cAux,16)))
		Endif                         
	EndIf
EndIf                 

If lChgAlias
	If !Empty(cSvAlias)
		DbSelectArea(cSvAlias)	
	Endif
EndIf

Return cRet

