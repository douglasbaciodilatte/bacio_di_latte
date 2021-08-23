#Include 'protheus.ch'

/*---------------------------------------------------------------------------------------
{Protheus.doc} BACAA020
@class      Nao Informado
@from       Nao Informado
@param      Nao Informado
@attrib     Nao Informado
@protected  Nao Informado
@author     TOTVS
@Date     	20/03/2017
@version    P.12
@since      Nao Informado  
@return     NIL
@sample     Nao Informado
@obs        
@project    F3 no codigo do produto
@menu       Nao Informado
@history    
---------------------------------------------------------------------------------------*/

User Function BACAA020(_lValid)

Local _xRet
Local _nPCodTab	:= aScan(aHeader,{ |x| Upper(Alltrim(x[2])) == "C7_CODTAB"})
Local _aArea	:= GetArea()
Local _aAreaAIB	:= AIB->( GetArea() )
Local _aAreaSA2	:= SA2->( GetArea() )

Default _lValid	:= .F.

//Caso a variavel _lValid seja .T., 
If _lValid
	_xRet := .T.
Else
	_xRet := ""
EndIf

If _nPCodTab > 0
	If !Empty(aCols[n][_nPCodTab])
		If !_lValid
			_xRet := "@EXISTS(SELECT 1 FROM " + RetSqlName("AIB")
			_xRet += "         WHERE AIB_FILIAL = '" + xFilial("AIB") + "'"
			_xRet += "           AND D_E_L_E_T_ = ' '"
			_xRet += "           AND AIB_CODFOR = '" + cA120Forn + "'"
			_xRet += "           AND AIB_LOJFOR = '" + cA120Loj + "'"
			_xRet += "           AND AIB_CODTAB = '" + aCols[n][_nPCodTab] + "'"
			_xRet += "           AND AIB_CODPRO = B1_COD)"
		Else
			dbSelectArea("AIB")
			dbSetOrder(2)	//AIB_FILIAL+AIB_CODFOR+AIB_LOJFOR+AIB_CODTAB+AIB_CODPRO
			If !AIB->( dbSeek( xFilial("AIB") + cA120Forn + cA120Loj + aCols[n][_nPCodTab] + M->C7_PRODUTO ) )
				ApMsgInfo("Produto " + Alltrim(M->C7_PRODUTO) + " não consta na Tabela de Preços " +;
						  Alltrim(aCols[n][_nPCodTab]) + "." + Chr(10) + Chr(13)+;
						  "Por favor solicitar a inclusão na tabela ou selecionar outro produto.")
				_xRet := .F.
			EndIf
			
			RestArea(_aArea)
			RestArea(_aAreaAIB)
			RestArea(_aAreaSA2)
		EndIf
	EndIf
EndIf

Return _xRet