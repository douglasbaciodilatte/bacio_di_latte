#Include 'Totvs.ch'
#Include "Protheus.ch"
#include "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

//#define DS_MODALFRAME 128

User Function M410lDel()

Local lRet := .t.
Local aArea := GetArea()
Local aAreaSC6 := GetArea('SC6')

	if xFilial("SC6") == '0072' .and. Altera .and. !acols[n,len(acols[n])] 
		IF EMPTY(SC6->C6_VDOBS)
			lRet := fMotivo()
		ELSE
			RECLOCK('SC6',.F.)
				SC6->C6_VDOBS := SPACE(1)
			SC6->(MSUNLOCK())
			lRet := .t.
		ENDIF
		
	endif

	RestArea(aAreaSC6)
	RestArea(aArea)

Return lRet

    
Static Function fMotivo()

Local cItens := ''
Local oFont1
Local oFont2
Local oDlg1
Local oSay1
Local oGrp1
Local oList1
Local oBtn1
Local aList1 
Local nList := 1
Local lRet := .F.
Local cKey := space(1)

	dbSelectArea('SX5')

	If SX5->(dbSeek(xFilial('SX5')+'ZZ'))

		If !Empty(Alltrim(X5Descri()))

			While SX5->(!EOF()) .and. SX5->X5_TABELA == 'ZZ'
				cItens += Alltrim(X5Descri())+','
				SX5->(Dbskip())
			EndDo

			lRet := .F.

			aList1 := StrTokArr(cItens,",")
			
			oFont1  := TFont():New( "MS Sans Serif",0,-16,,.T.,0,,700,.F.,.F.,,,,,, )
			oFont2  := TFont():New( "MS Sans Serif",0,-14,,.F.,0,,400,.F.,.F.,,,,,, )
			
            oDlg1   := MSDialog():New( 221,354,431,910,"Deletar Linha",,,.F.,DS_MODALFRAME,,,,,.T.,,,.T. )
			oSay1   := TSay():New( 004,080,{||"Justifique a exclus?o da linha"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,120,012)
			oGrp1   := TGroup():New( 020,004,080,268,"",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
			oList1  := TListBox():New(027,008,{|u|iif(Pcount()>0,nList:=u,nList)},aList1,256,049,,oDlg1,,CLR_BLACK,CLR_WHITE,.T.,,,oFont2,"",,,,,,, )

			oBtn1   := TButton():New(083,230,"Confirmar",oDlg1,{|| SayMotiv(aList1[nList],cKey),oDlg1:End(),lRet := .T.},037,012,,,,.T.,,"",,,,.F. )
			
			oDlg1:lEscClose := .F.
			oDlg1:Activate(,,,.T.)

		EndIf

	EndIf

Return lRet


Static Function SayMotiv(cMotiv,cKey)

Local lRet  := .T.
Local cUsr  := UsrRetName(RetCodUsr())
Local cDate := DToC(Date())
Local cHora := Time()

cMotiv := 'Motivo: '+cMotiv+' | '+'Usuario: '+cUsr+' | '+'Data Exclusao: '+cDate+' -  Hora: '+cHora

    If !Empty(cMotiv)

        RECLOCK('SC6',.F.)
            SC6->C6_VDOBS := cMotiv
        SC6->(MSUNLOCK())

        lRet := .t.
    EndIf

Return lRet
