#Include "Totvs.ch"

/*/{Protheus.doc} User Function GATTES
    Gatilho TES Inteligente
    @type user function
    @author Felipe Mayer
    @since 26/05/2021
/*/
User Function GATTES(cFili)

Local aArea := GetArea()
Local cRet  := ""

	If FunName() $ 'MATA120|MATA121'
		cRet := Iif(cFili=='0031',;
			MaTesInt(1,"84",cA120Forn,cA120Loj,"F",M->C7_PRODUTO,"C7_TES"),;
			MaTesInt(1,"51",cA120Forn,cA120Loj,"F",M->C7_PRODUTO,"C7_TES"))

    ElseIf FunName() == 'MATA103'
		cRet := Iif(cFili=='0031',;
			MaTesInt(1,"84",cA100For,cLoja,If(cTipo$"DB","C","F"),M->D1_COD,"D1_TES"),;
			MaTesInt(1,"51",cA100For,cLoja,If(cTipo$"DB","C","F"),M->D1_COD,"D1_TES"))
	EndIf
		
    RestArea(aArea)
    
Return cRet
