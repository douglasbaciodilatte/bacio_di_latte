#include 'protheus.ch'
#include 'parmtype.ch'

/*/{Protheus.doc} AGFIS001

@author Agility
@since 02/02/2018
@version 1.0
@type function
/*/
user function AGFIS001()
	Local nOpc    := 0
	Local cPerg   := "AGFIS001"
	Local aSay    := {}
	Local aButton := {}
	Local cTitulo := "REPLICA DE CADASTRO FISCAIS"
	Local cDesc1  := "Este programa irá realizar a replicação dos cadastros fiscais"
	Local cDesc2  := "conforme os parâmetros definidos pelo usuário."

	Pergunte(cPerg,.F.)

	aAdd( aSay, cDesc1 )
	aAdd( aSay, cDesc2 )

	aAdd( aButton, { 1, .T., {|| nOpc := 1, FechaBatch()	}} )
	aAdd( aButton, { 2, .T., {|| FechaBatch()            	}} )
	aAdd( aButton, { 5, .T., {|| Pergunte(cPerg,.t.)       	}} )

	FormBatch( cTitulo, aSay, aButton )

	If nOpc = 1
		processa({|| doCopy() }, "Processando cadastros...")
		APMsgInfo("Replicação finalizada.","Concluído")
		dbCloseAll()
		OpenFile(SubStr(cNumEmp,1,2))
	EndIf
Return()

Static Function doCopy()
	Local aArea := SM0->(GetArea())
	local cEmp  := cEmpAnt
	local cEstDe

	dbSelectArea("SM0")
	dbSetOrder(1)
	dbGoTop()
	If !dbSeek(cEmp+mv_par01)
		APMsgStop("Filial de origem não encontrada!!!","Atenção")
		RestArea(aArea)
		Return
	Else
		cEstDe := SM0->M0_ESTENT
	EndIf

	dbGoTop()
	If !dbSeek(cEmp+mv_par02)
		APMsgStop("Filial de destino não encontrada!!!","Atenção")
		RestArea(aArea)
		Return
	ElseIf cEstDe <> SM0->M0_ESTENT
		APMsgStop("Estado de origem diverge do estado destino!!!","Atenção")
		RestArea(aArea)
		Return	
	EndIf

	Do Case
		Case mv_par03 = 1
		CopySF7(mv_par01,mv_par02)
		Case mv_par03 = 2
		CopySFM(mv_par01,mv_par02)
		Case mv_par03 = 3
		CopySF7(mv_par01,mv_par02)
		CopySFM(mv_par01,mv_par02)
	EndCase
Return()

Static Function CopySF7(cFilDe,cFilPara)
	local aArea	:= GetArea()
	local aLog 	:= {}
	local aRegs	:= {}
	local aTmp	:= {}
	local nX 	:= 0
	local nY 	:= 0

	dbSelectArea("SF7")
	ProcRegua(RecCount())
	dbSetOrder(1)
	dbGoTop()

	If dbSeek(cFilPara)
		APMsgStop("Filial de destino já possui cadastros de exceção fiscal!!!","Atenção")
		RestArea(aArea)
		Return
	EndIf
	dbSeek(cFilDe)
	While !EOF() .and. F7_FILIAL == cFilDe
		IncProc()
		For nX := 1 to Fcount()
			If FieldName(nX) == "F7_FILIAL"
				aAdd(aTmp,cFilPara)				
			else
				aAdd(aTmp,FieldGet(nX))
			EndIf
		Next
		aAdd(aRegs,aTmp)
		aTmp := {}
		dbSkip()
	EndDo

	ProcRegua(Len(aRegs))

	For nX := 1 to Len(aRegs)
		IncProc()
		RecLock("SF7",.T.)
		For nY := 1 to Fcount()
			FieldPut(nY,aRegs[nX,nY])
		Next nY	
		MSUnlock()
	Next nX

Return

Static Function CopySFM(cFilDe,cFilPara)
	local aArea	:= GetArea()
	local aLog 	:= {}
	local aRegs	:= {}
	local aTmp	:= {}
	local nX 	:= 0
	local nY 	:= 0

	dbSelectArea("SFM")
	ProcRegua(RecCount())
	dbSetOrder(1)
	If dbSeek(cFilPara)
		APMsgStop("Filial de destino já possui cadastros de TES inteligente!!!","Atenção")
		RestArea(aArea)
		Return
	EndIf

	dbGoTop()
	dbSeek(cFilDe)

	While !EOF() .and. FM_FILIAL == cFilDe
		IncProc()
		For nX := 1 to Fcount()
			If FieldName(nX) == "FM_FILIAL"
				aAdd(aTmp,cFilPara)				
			else
				aAdd(aTmp,FieldGet(nX))
			EndIf
		Next
		aAdd(aRegs,aTmp)
		aTmp := {}
		dbSkip()
	EndDo

	ProcRegua(Len(aRegs))
	For nX := 1 to Len(aRegs)
		IncProc()
		RecLock("SFM",.T.)
		For nY := 1 to Fcount()
			FieldPut(nY,aRegs[nX,nY])
		Next nY	
		MSUnlock()
	Next nX

Return
