#Include 'Protheus.ch'
#Include "TopConn.ch"
#include "rwmake.ch" 

/*===================================================================================
Programa.:              F380VLD - PONTO DE ENTRADA
Autor....:              Felipe Mayer
Data.....:              10/03/2020
Descricao / Objetivo:   Não deixar conciliar com data anterior ao MV_DATAFIN
Uso......:              BACIO DI LATTE
===================================================================================*/


User function F380VLD()

Local cDataX6	:= GetMv("MV_DATAFIN")
Local cDataAte  := ParamIxb[3]
Local lRet      := .T.

		If cDataAte <= cDataX6
			MsgAlert("Data de conciliação não pode ser anterior ao dia: "+DToC(cDataX6),"PE-F380VLD")
			lRet := .F.
		EndIf

Return lRet