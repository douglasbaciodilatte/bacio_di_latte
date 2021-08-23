#INCLUDE "Protheus.ch"
#Include "TbiConn.ch"
#include "fileio.ch"

#DEFINE ENTER chr(13)+chr(10)


/*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºPrograma ³ BDLFIS02         ºAutor³ RVACARI Felipe Mayer	    º Data Ini³ 10/03/2020   º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºDesc.    ³ Importar TES Inteligente - SFM                                                 ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºUso      ³ BACIO DI LATTE	                                            		  		  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/

User Function BDLFIS02()

Local nOpcoes	  := GETF_LOCALHARD  + GETF_NETWORKDRIVE
Local aArea 	  := GetArea()
Local lArvore	  := .T.
Local lPrim   	  := .T.
Local lSalvar	  := .F.
Local aCampos 	  := {}
Local aDados  	  := {}            
Local nMascpadrao := 0
Local nX		  := 0
Local cDirinicial := 'C:\'
Local cMascara	  := 'Arquivo CSV|*.csv| Arquivo TXT|*.txt'
Local cTitulo  	  := 'Selecao de Arquivos'
Local cLinha	  := ''
Local cArqAux	  := ''
Local cChave	  := ''
Local cPar1		  := ''
Local cPar2		  := ''
Local cPar3 	  := ''
Local cPar4		  := ''

    //Chamando o cGetFile para pegar um arquivo txt ou xml, mostrando o servidor
    cArqAux := cGetFile(cMascara, cTitulo, nMascpadrao, cDirinicial, lSalvar, nOpcoes, lArvore)
     
	If !File(cArqAux)
		MsgStop("O arquivo " +cArqAux + " não foi encontrado. A importação será abortada!","[BDLFIS02] - ATENCAO")
		Return
	EndIf
	
	FT_FUSE(cArqAux)
	ProcRegua(FT_FLASTREC())
	FT_FGOTOP()
	While !FT_FEOF()
		
		IncProc("Lendo arquivo ...")
		
		cLinha := FT_FREADLN()
		
		If lPrim
			aCampos := Separa(cLinha,";",.T.)
			lPrim := .F.
		Else                     
			aAdd(aDados,Separa(cLinha,";",.T.))
		EndIf
		
		FT_FSKIP()
	EndDo              

	For nX := 1 to len(aDados)

		DbSelectArea("SFM")
		DbSetOrder(2)

		cChave := AvKey("","FM_FILIAL")+Avkey(StrZero(Val(aDados[nX,01]),2), "FM_TIPO")+AvKey("","FM_CLIENTE")+AvKey("","FM_LOJACLI");
		+AvKey("07XPHH","FM_FORNECE")+AvKey("","FM_LOJAFOR")+AvKey("","FM_GRTRIB")+AvKey("","FM_PRODUTO");
		+AvKey(aDados[nX,05],"FM_GRPROD")+AvKey(aDados[nX,03],"FM_EST")+AvKey(aDados[nX,04],"FM_POSIPI")

		If !DbSeek(cChave)		
			RecLock("SFM", .T.)			

			If aDados[nX,01] <> ''
				SFM->FM_TIPO   := StrZero(Val(aDados[nX,01]),2)
			EndIf
			If aDados[nX,03] <> ''
				SFM->FM_EST    := aDados[nX,03]
			EndIf
			If aDados[nX,04] <> ''
				SFM->FM_POSIPI := aDados[nX,04]
			EndIf
			If aDados[nX,05] <> ''
				SFM->FM_GRPROD := aDados[nX,05]
			EndIf

			SFM->FM_FORNECE := '07XPHH'

			If aDados[nX,02] >= '500'
				SFM->FM_TS := aDados[nX,02]
			ElseIf aDados[nX,02] < '500'
				SFM->FM_TE := aDados[nX,02]
			EndIf
		Else

			cPar1 := StrZero(Val(aDados[nX,01]),2)
			cPar2 := aDados[nX,03]
			cPar3 := aDados[nX,04]
			cPar4 := aDados[nX,05]

			If cPar1 == ''
			   cPar1 := 'Sem Parametro'
			EndIf
			If cPar2 == ''
			   cPar2 := 'Sem Parametro'
			EndIf
			If cPar3 == ''
			   cPar3 := 'Sem Parametro'
			EndIf
			If cPar4 == ''
			   cPar4 := 'Sem Parametro'
			EndIf

			MsgAlert("TES Inteligente: "+aDados[nX,02]+" já existente no sistema! <b>Verificar parametros:</b>"+;
			"<hr> <b>1 -</b> Tp. Operação: "+cPar1+;
			"<br> <b>2 -</b> Estado: "+cPar2+;
			"<br> <b>3 -</b> NCM: "+cPar3+;
			"<br> <b>4 -</b> Gp. Produto: "+cPar4,"TES não cadastrada")
		EndIf
		MsUnLock()
	Next nX

	MsgInfo("Importação de TES Inteligente concluída!","BDLFIS02")

	RestArea(aArea)
Return