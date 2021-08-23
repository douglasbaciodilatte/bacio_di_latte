#Include 'Protheus.ch'
#Include "TopConn.ch"

/*===================================================================================
Programa.:              PEFINA473A - PONTO DE ENTRADA
Autor....:              Felipe Mayer
Data.....:              10/03/2020
Descricao / Objetivo:   Não deixar conciliar com data anterior ao MV_DATAFIN
Uso......:              BACIO DI LATTE
Obs......:              Rotina em MVC 
===================================================================================*/

User Function FINA473A()

Local cDataX6		:= GetMv("MV_DATAFIN")
Local aArea   		:= GetArea()
Local aParam    	:= PARAMIXB
Local cDataAte		:= MV_PAR05
Local lRet      	:= .T.
Private MV_PAR05
	
	If aParam <> NIL
		If cDataAte <= cDataX6
			MsgAlert("Data de conciliação não pode ser anterior ao dia: "+DToC(cDataX6),"PE-FINA473A")
			lRet := .F.
		EndIf
	EndIf
 
	RestArea(aArea)

Return lRet