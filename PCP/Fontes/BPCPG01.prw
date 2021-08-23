#include 'protheus.ch'
#include 'parmtype.ch'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ BPCPG01  ºAutor  ³ Agility            º Data ³  25/10/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Gatilho para validacao da quantidade a ser apontadada.     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

user function BPCPG01(_cQtdApon)
Local _nRet    := 0	
Local _nPosQtd := AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_QUANT"})
Local _nPosOp  := AScan(aHedDad1,{|x| AllTrim(x[2]) == "D3_OP"})
//Local _cMesFec := Month(GetMV("MV_ULMES"))
Local _cMesFec := Substr(DTOS(GetMV("MV_ULMES")),1,6)
Local _cMesOP  := ""

dbSelectArea("SC2")
dbSetOrder(1)
IF dbSeek(XFILIAL("SC2")+aColDad1[n][_nPosOp])
	//_cMesOP := Month(SC2->C2_EMISSAO)
	_cMesOP := Substr(DTOS(SC2->C2_EMISSAO),1,6)
	IF _cMesOP <= _cMesFec
		ShowHelpDlg('BPCPG01',{'O mês de emissão da Ordem de Produção está fora do mês de fechamento do estoque.'},1,{'Somente Ordens de Produção com mês superior ao mês de fechamento podem sem apontadas.'},1)
		Return(_nRet)
	ENDIF
ENDIF

IF _cQtdApon > aColDad1[n][_nPosQtd] 
	ShowHelpDlg('BPCPG01',{'A quantidade informada para apontamento é superior ao saldo da Ordem de Produção.'},1,{'Informe a quantidade menor ou igual ao saldo da Ordem de Produção.'},1)
	Return(_nRet)
ELSE
	_nRet := _cQtdApon
ENDIF
	
Return(_nRet)