#INCLUDE "Protheus.ch"
#Include "TbiConn.ch"
#include "fileio.ch"

#DEFINE ENTER chr(13)+chr(10)


/*����������������������������������������������������������������������������������������������
�� �Programa � BDLFIS02         �Autor� RVACARI Felipe Mayer	    � Data Ini� 10/03/2020   ���
������������������������������������������������������������������������������������������������
�� �Desc.    � Importar TES Inteligente - SFM                                                 ��
������������������������������������������������������������������������������������������������
�� �Uso      � BACIO DI LATTE	                                            		  		  ��
����������������������������������������������������������������������������������������������*/

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
		MsgStop("O arquivo " +cArqAux + " n�o foi encontrado. A importa��o ser� abortada!","[BDLFIS02] - ATENCAO")
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

			MsgAlert("TES Inteligente: "+aDados[nX,02]+" j� existente no sistema! <b>Verificar parametros:</b>"+;
			"<hr> <b>1 -</b> Tp. Opera��o: "+cPar1+;
			"<br> <b>2 -</b> Estado: "+cPar2+;
			"<br> <b>3 -</b> NCM: "+cPar3+;
			"<br> <b>4 -</b> Gp. Produto: "+cPar4,"TES n�o cadastrada")
		EndIf
		MsUnLock()
	Next nX

	MsgInfo("Importa��o de TES Inteligente conclu�da!","BDLFIS02")

	RestArea(aArea)
Return