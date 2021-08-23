#include "totvs.ch"
#include "protheus.ch"
 
User Function BDESTA05()
 
Local cArq      := "ENDERECO_ENT.csv"
Local cLinha    := ""
Local lPrim     := .T.
Local aCampos   := {}
Local aDados    := {}
Local cDir      := "C:\TOTVS\"
 
Private aErro := {}
 
If !File(cDir+cArq)
	MsgStop("O arquivo " +cDir+cArq + " não foi encontrado. A importação será abortada!","[AEST901] - ATENCAO")
	Return
EndIf
 
FT_FUSE(cDir+cArq)
ProcRegua(FT_FLASTREC())
FT_FGOTOP()
While !FT_FEOF()
 
	IncProc("Lendo arquivo texto...")
 
	cLinha := FT_FREADLN()
 
	If lPrim
		aCampos := Separa(cLinha,";",.T.)
		lPrim := .F.
	Else
		AADD(aDados,Separa(cLinha,";",.T.))
	EndIf
 
	FT_FSKIP()
EndDo
 
Begin Transaction
	ProcRegua(Len(aDados))
	For i:=1 to Len(aDados)
 
		IncProc("Importando Clientes...")
 
		dbSelectArea("NNR")
		dbSetOrder(1) //NNR_FILIAL, NNR_CODIGO
		dbGoTop()
		
		If NNR->( dbSeek(aDados[i,1] + aDados[i,2] ) )
			
			Reclock("NNR",.F.)
			
				NNR->NNR_XEND := FwCutOff( aDados[i,4] , .T. )
			
			NNR->(MsUnlock())
			
		EndIf
	Next i
End Transaction
 
FT_FUSE()
 
ApMsgInfo("Importação dos Clientes concluída com sucesso!","[BDESTA05] - SUCESSO")
 
Return