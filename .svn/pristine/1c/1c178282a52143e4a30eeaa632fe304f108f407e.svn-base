#include 'protheus.ch'
#include 'parmtype.ch'

/*/{Protheus.doc} ConvXLS
//TODO Descrição auto-gerada.
@author henri
@since 18/01/2018
@version 1.0
@return ${return}, ${return_description}

@type function
/*/
User Function ConvXLS(_aReturn)

	Local oDlg, oExcelApp
	Local cTemp := GetTempPath()
	Local cSystem := Upper(GetSrvProfString('STARTPATH',''))
	Local cArqMacro := 'ConvXLS.xls'
	Local cNomeXLS := Lower(CriaTrab(Nil,.f.))
	Local _nx
	
	Private cArquivo := Space(100)
	Private nLin := 35
	
	Private nCol1 := 16
	Private nCol2 := 40
	Private nCol3 := 170
	Private bOk := { || If(ValidaDir(), (lOk:=.T.,oDlg:End()) ,) }
	Private bCancel := { || lOk:=.F.,oDlg:End() }
	
	
	Define MsDialog oDlg Title 'Diretório' From 03,15 To 20,65 Of GetWndDefault()

	@nLin,nCol1 Say 'Diretorio:' Size 050,10 Of oDlg Pixel
	@nLin,nCol2 MsGet cArquivo Size 110,08 Of oDlg Pixel
	@nLin,nCol3-15 Button '…' Size 010,10 Action Eval({|| SelectFile() }) Of oDlg Pixel
	
	Activate MsDialog oDlg Centered On Init (EnchoiceBar(oDlg,bOk,bCancel))
	If !File(alltrim(cArquivo))
		MsgStop('Caminho ou Arquivo inválido!','Atenção')
		Return(.f.)
	Endif

	//Apaga o Arquivo XLS do diretorio temporario caso ja exista
	If File(cTemp+cNomeXLS+'.xls')
		fErase(cTemp+cNomeXLS+'.xls')
	EndIf

	//Copia o arquivo XLS para o Temporario para ser executado
	If !AvCpyFile(cArquivo,cTemp+cNomeXLS+'.xls',.T.) .and. !File(cTemp+cNomeXLS+'.xls')
		MsgInfo('Problemas na copia do arquivo '+cArquivo+' para '+cTemp+cNomeXLS+'.xls' ,'AvCpyFile()')
		Return(.F.)
	EndIf

	If File(cTemp+cArqMacro)
		fErase(cTemp+cArqMacro)
	EndIf

	//Copia o arquivo XLA para o Temporario para ser executado
	If !AvCpyFile(cSystem+cArqMacro,cTemp+cArqMacro,.T.) .and. !File(cTemp+cArqMacro)
		MsgInfo('Problemas na copia do arquivo '+cSystem+cArqMacro+' para '+cTemp+cArqMacro ,'AvCpyFile()')
		Return(.F.)
	EndIf

	oExcelApp := MsExcel():New()
	oExcelApp:WorkBooks:Open(cTemp+cArqMacro) //Instancia a macro
	oExcelApp:Run(cArqMacro+'!XLS2DBF',cTemp,cNomeXLS,'Exemplo') // Executa a macro
	oExcelApp:WorkBooks:Close('savechanges:=False')
	oExcelApp:Quit()
	oExcelApp:Destroy()

	If Select('TMP') > 0
		TMP->(dbCloseArea())
	EndIf

	//Exclui o arquivo DBF antigo (se existir) e copia o novo
	If File(cSystem+cNomeXLS+'.Dbf')
		fErase(cSystem+cNomeXLS+'.Dbf') //Deleta o arquivo DBF de origem
	EndIf

	//Copia o arquivo DBF do temporário para o System (Rootpath)
	If !AvCpyFile(cTemp+cNomeXLS+'.Dbf',cSystem+cNomeXLS+'.Dbf',.T.) .or. !File(cSystem+cNomeXLS+'.Dbf')
		MsgInfo('Problemas na copia do arquivo '+cTemp+cNomeXLS+'.DBF para '+ cSystem+cNomeXLS+'.Dbf' ,'AvCpyFile()')
		Return(.F.)
	EndIf


	dbUseArea(.T.,'DBFCDXADS',cNomeXLS+'.Dbf','TMP',.T.,.F.)
	DbSelectArea('TMP')
	DbGoTop()

	procregua(TMP->(reccount()))


	Do While TMP->(!Eof())

		IncProc("Lendo Planilha... ")


		aadd(_aReturn, {} ) 
	
		For _nx := 1 to 25
	
			_cCampo := 'A'+alltrim(str(_nx))	
			TMP->(aadd(_aReturn[len(_aReturn)], formatdata(&_cCampo,_nx)  ) )
	
		Next
	
		TMP->(DbSkip())
	Enddo

	DbSelectArea('TMP')
	DbCloseArea()

Return(.t.)


/*/{Protheus.doc} SelectFile
//TODO Descrição auto-gerada.
@author henri
@since 18/01/2018
@version 1.0
@return ${return}, ${return_description}

@type function
/*/
Static Function SelectFile()
	//————————————————————————————————-//
	Local cMaskDir := 'Arquivos Microsoft Excel (*.xlsx) |*.xlsx|'
	Local cTitTela := 'Arquivo para a integracao'
	Local lInfoOpen := .T.
	Local lDirServidor := .T.
	Local cOldFile := cArquivo
	cArquivo := cGetFile(cMaskDir,cTitTela,,cArquivo,lInfoOpen, (GETF_LOCALHARD+GETF_NETWORKDRIVE) ,lDirServidor)

	If !File(cArquivo)
		MsgStop('Arquivo Não Existe!')
		cArquivo := cOldFile
		Return .F.
	EndIf

Return Nil


/*/{Protheus.doc} ValidaDir
//TODO Descrição auto-gerada.
@author henri
@since 18/01/2018
@version 1.0
@return ${return}, ${return_description}

@type function
/*/
Static Function ValidaDir()
	//————————————————————————————————-//
	Local lRet := .T.
	If Empty(cArquivo)
		MsgStop('Selecione um arquivo','Atenção')
		lRet := .F.
	ElseIf !File(cArquivo)
		MsgStop('Selecione um arquivo válido!','Atenção')
		lRet := .F.
	EndIf
Return lRet
//————————————————————————————————-//


/*/{Protheus.doc} FormatData
//TODO Descrição auto-gerada.
@author henri
@since 18/01/2018
@version 1.0
@return ${return}, ${return_description}
@param _cCampo, , descricao
@param _nx, , descricao
@type function
/*/
Static Function FormatData(_cCampo, _nx)

Local _nx := alltrim(strzero(_nx,2))
Local _xData := alltrim(_cCampo)

if _nx $  '11,12,13,15,22'

	_xData := ctod(_cCampo) 

Elseif _nx $ '14,16,17,20,21' 

	_xData := strtran(_cCampo,',','.')
	_xData := val(_xData)


Endif

Return(_xData)