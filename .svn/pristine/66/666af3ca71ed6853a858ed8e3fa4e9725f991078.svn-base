#Include "Totvs.ch"
#Include "Totvs.ch"
#INCLUDE "PROTHEUS.CH"
#include "RWMAKE.ch"
#INCLUDE "XMLXFUN.CH"

Static cxAliAux    := GetNextAlias()

/*/{Protheus.doc} CEXMGRNFE
@description 	Ponto de entrada na Gravacao do XML na tabela
@obs			Ponto de entrada e chamado na gravacao dos itens
@obs			A cada item gravado o ponto e chamado.
@author 		Richard Branco
@since 			06/2020
@version		1.0
@return			Nil
@type 			Function
/*/
User Function CEXMGRNFE()

	Local aAreaAT  := GetArea()

	cFornece	:= ''
	cLoja		:= ''

	If GetCliFor( "F", RECNFXML->XML_EMIT, @cFornece, @cLoja )
		cFornece	:= SA2->A2_COD 
		cLoja		:= SA2->A2_LOJA
	Endif

	DbSelectArea("ZZC")
	DbSetOrder(1)
	If DbSeek(xFilial("ZZC")+Alltrim( Upper( RECNFXMLITENS->XIT_UMNFE )) )
		If Alltrim( Upper( RECNFXMLITENS->XIT_UMNFE ))  == Alltrim( Upper(ZZC->ZZC_UMXML))
			Reclock("RECNFXMLITENS",.f.)
				RECNFXMLITENS->XIT_UMNFE :=  ZZC->ZZC_UMERP
			Msunlock()
		EndIf
	EndIf
	
	//AJUSTE PARA LIMPAR LOTE NAS LOJAS
	if !Empty(RECNFXMLITENS->XIT_LOTEC)
		DbSelectArea("SM0")
		dbGotop()
		nRecM0 := SM0->(RECNO()) 	
		Do While ! Eof()
			If !Empty(RECNFXMLITENS->XIT_LOTEC) .and. Alltrim( SM0->M0_CGC ) == Alltrim( RECNFXML->XML_DEST ) .and. !SM0->M0_CODFIL $ "31/72"
				Reclock("RECNFXMLITENS",.f.)
					RECNFXMLITENS->XIT_LOTEC := ""
				Msunlock()
			EndIf
			DbSelectArea("SM0")
			dbSkip()
		End				
		Dbgoto(nRecM0)
	EndIf

	If !Empty(RECNFXMLITENS->XIT_DESCRI)

		cSerie 	:= ''
		nPSer	:= At("SER.(",UPPER(RECNFXMLITENS->XIT_DESCRI))
		cDoc  	:= ''
		nPDoc 	:= At("NF.(",UPPER(RECNFXMLITENS->XIT_DESCRI)) 
		cItem 	:= ''
		cIdent  := ''

		If nPSer > 0
			cSerie := Alltrim(Str(Val(Alltrim(Substr(RECNFXMLITENS->XIT_DESCRI,nPSer+5,At(")",SUBSTR(RECNFXMLITENS->XIT_DESCRI,nPSer+6,15)))))))
		EndIf

		If nPDoc > 0
			cDoc := Strzero(Val(SUBSTR(RECNFXMLITENS->XIT_DESCRI,nPDoc+4,At(")",SUBSTR(RECNFXMLITENS->XIT_DESCRI,nPDoc+5,12)))),9)
		EndIf

		If !Empty(cDoc)

			cProdPEsq := ''

			If !Empty(RECNFXMLITENS->xit_codprd)
				cProdPesq := RECNFXMLITENS->xit_codprd
			Else
				cProdXml := RECNFXMLITENS->XIT_CODNFE
				//Chama Ponto de entrada Que retorna o Produto (Customizado)
				cProdPesq	:= ExecBlock( "CEXSA5INI", .F., .F., { cProdXml , cFornece, cLoja, ''  } )

			EndIf

			cxQuery	:= " SELECT D2_DOC, D2_SERIE, D2_ITEM, D2_IDENTB6 "
			cxQuery	+= " FROM " + RETSQLNAME("SD2") + " D2 "
			cxQuery	+= " WHERE D2_DOC = '"+Alltrim(cDoc)+"' "
			cxQuery	+= " AND D2_COD = '" + Alltrim(cProdPesq) + "' "
			cxQuery	+= " AND D2_SERIE = '" + Alltrim(cSerie) + "' "
			cxQuery	+= " AND D2.D_E_L_E_T_ = ''  "

			cxAliAux    := GetNextAlias()
			Iif(Select(cxAliAux)>0,(cxAliAux)->(dbCloseArea()),Nil)
			MPSysOpenQuery( cxQuery, cxAliAux )

			dbSelectArea(cxAliAux)
			(cxAliAux)->(dbGotop())

			If (cxAliAux)->(!Eof())
				cItem 	:= (cxAliAux)->D2_ITEM
				cIdent  := (cxAliAux)->D2_IDENTB6
			Endif
			(cxAliAux)->(dbCloseArea())

		EndIf

		If  !Empty(cDoc) //.And. Empty(RECNFXMLITENS->XIT_NFORI)

			DbSelectArea("RECNFXMLITENS")
			RecLock( "RECNFXMLITENS", .F. )
				RECNFXMLITENS->XIT_NFORI	:= cDoc
				RECNFXMLITENS->XIT_SRORI	:= cSerie
				RECNFXMLITENS->XIT_ITORI	:= cItem
				RECNFXMLITENS->XIT_IDENB6   := cIdent
			MsUnlock()
			

		Endif		
	Endif
	
	RestArea( aAreaAT )

Return Nil




/*/{Protheus.doc} GetCliFor
@description 	Posiciona e Retorna Cliente / Fornecedor
@author 		Amedeo D. Paoli Filho
@version		1.0
@param			Nil
@return			Nil
@type 			Function
/*/
Static Function GetCliFor( cTipo, cCnpj, cCliFor, cLjClFor, cTpNF )
	Local cAliTmp	:= GetNextAlias()
	Local cSelect	:= "% R_E_C_N_O_ AS RECNO %"
	Local lRetorno	:= .T.
	Local cTabela	:= ""
	Local cWhere	:= ""

	If cTipo == "F"
		cTabela	:= "% " + RetSqlName("SA2") + " %"
		cWhere	:= "% D_E_L_E_T_ <> '*' AND A2_MSBLQL <> '1' AND A2_CGC = '" + cCnpj + "' AND A2_FILIAL = '" + xFilial("SA2")+ "' %"
		cTpNF	:= "F"
	Else
		cTabela	:= "% " + RetSqlName("SA1") + " %"
		cWhere	:= "% D_E_L_E_T_ <> '*' AND A1_MSBLQL <> '1' AND A1_CGC = '" + cCnpj + "' AND A1_FILIAL = '" + xFilial("SA1")+ "' %"
		cTpNF	:= "C"
	EndIf
	
	BeginSQL Alias cAliTmp
		SELECT	%Exp:cSelect%
		FROM	%Exp:cTabela%
		WHERE	%Exp:cWhere%
	EndSQL
	
	If (cAliTmp)->( Eof() )

		lRetorno	:= .F.
	Else
		If cTipo == "F"
			DbSelectarea("SA2")
			SA2->( DbGoto( (cAliTmp)->RECNO ) )
			cCliFor		:= SA2->A2_COD
			cLjClFor	:= SA2->A2_LOJA
		Else
			DbSelectarea("SA1")
			SA1->( DbGoto( (cAliTmp)->RECNO ) )
			cCliFor		:= SA1->A1_COD
			cLjClFor	:= SA1->A1_LOJA
		EndIf
	EndIf
	
	(cAliTmp)->( DbCloseArea() )
	
Return lRetorno
