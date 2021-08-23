#include 'protheus.ch'
#include 'parmtype.ch'

user function AGFINR01(_aReport)

	Local oReport
	
	oReport := ReportDef(_aReport)
	oReport:PrintDialog()

return

/*/{Protheus.doc} ReportDef
//TODO Descrição auto-gerada.
@author Administrador
@since 23/05/2017
@version undefined
@param _cPerg, , descricao
@type function
/*/
Static Function ReportDef(_aReport)

	Local oReport

	oReport := TReport():New('AGFINR01',"",;
	'AGFINR01',;
	{|oReport|PrintReport(oReport,_aReport)},;
	"Este relatório tem por objetivo imprimir demonstrativo de titulos cujas baixas automaticas não foram realizadas com sucesso.")

	oReport:SetLandscape()

	oReport:cFontBody   := 'Arial'
	oReport:nFontBody   := 9
	oReport:nLineHeight := oReport:nFontbody * 4.5
	oReport:HideParamPage()

	//SECTION1
	//-------------------------------------------------------------------
	osec1 := TRSection():New(oReport,OemToAnsi("Baixas"),{},,,,,,,,,,,,2,.F.)
	//osec1:SetCellBorder("ALL")

	ob1 := TRCell():New(osec1,"E1_PREFIXO"	,,"Prefixo"		,,50,,{|| _aReport[_nx,1]   },'LEFT'	,,'CENTER')
	ob2 :=TRCell():New(osec1,"E1_NUM"		,,"Num Titulo"	,,50,,{|| _aReport[_nx,2]   },'LEFT'	,,'CENTER')
	ob3 :=TRCell():New(osec1,"E1_PARCELA"	,,"Parcela"		,,50,,{|| _aReport[_nx,3]   },'LEFT'	,,'CENTER')
	ob4 :=TRCell():New(osec1,"E1_TIPO"	,,"Tipo"			,,50,,{|| _aReport[_nx,4]   },'LEFT'	,,'CENTER')
	ob5 :=TRCell():New(osec1,"E1_CLIENTE"	,,"Cod Cliente"	,,50,,{|| _aReport[_nx,5]   },'LEFT'	,,'CENTER')
	ob6 :=TRCell():New(osec1,"E1_LOJA"	,,"Loja"			,,50,,{|| _aReport[_nx,6]   },'LEFT'	,,'CENTER')
	ob7 :=TRCell():New(osec1,"A1_NOME"	,,"Cliente"			,,50,,{|| _aReport[_nx,7]   },'LEFT'	,,'CENTER')
	ob8 :=TRCell():New(osec1,"E1_VALOR"	,,"Valor"	,"@E 999,999.99",50,,{|| _aReport[_nx,8]   },'RIGHT'	,,'CENTER')
	ob9 :=TRCell():New(osec1,"B5_ECDESCR"	,,"Erro"		,,100,,{|| _aReport[_nx,9]   },'LEFT'	,,'CENTER')

//	ob1:lHeaderSize := .t.
//	ob2:lHeaderSize := .t.
//	ob3:lHeaderSize := .t.
//	ob4:lHeaderSize := .t.
//	ob5:lHeaderSize := .t.
//	ob6:lHeaderSize := .t.
//	ob7:lHeaderSize := .t.
//	ob8:lHeaderSize := .t.
	
Return oReport

//___________________________________//
/*/{Protheus.doc} PrintReport
//TODO Descrição auto-gerada.
@author Administrador
@since 23/05/2017
@version undefined
@param oReport, object, descricao
@param _cPerg, , descricao
@type function
/*/
Static Function PrintReport(oReport,_aReport)

	Local oSection1 		:= oReport:Section(1)
	
	//aadd(_aReport, {aTitbx[1],aTitbx[2],aTitbx[3],aTitbx[4],aTitbx[8],aTitbx[9],aTitbx[10],aTitbx[20],_aLog})

	For _nx := 1 to len(_aReport)

		oSection1:Init()

		oSection1:PrintLine()
		
		OSection1:Finish()
		
	End
	
	oReport:EndPage()


Return

