#INCLUDE "Totvs.ch"
#include "topconn.ch"
#include "RWMAKE.ch"

#DEFINE  CRLF        Chr(13)+Chr(10)

//Definicao dos elementos do array aTotVal
#DEFINE TOTPROV	 1 		//Total de Proventos
#DEFINE TOTDESC  2      //Total de Descontos

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ GERHOLER บ Autor ณ JORGE SATO        บ Data ณ  12/01/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Geracao de Arquivo Texto para HOLERITE ON LINE             บฑฑ
ฑฑบ          ณ da Empresa MILANO                                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑบAlteracao ณ  Data    ณ Analista  ณ               Motivo                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑบ          ณ          ณ           ณ                                     บฑฑ
ฑฑบ          ณ          ณ           ณ                                     บฑฑ
ฑฑบ          ณ          ณ           ณ                                     บฑฑ
ฑฑบ          ณ          ณ           ณ                                     บฑฑ
ฑฑบ          ณ          ณ           ณ                                     บฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function Gerholer()

//Declaracao de Variaveis
SetPrvt("lEnd,lContinua,lAbortPrint,nHdl,cPerg,cNomeArq,cArq,cArqInd,nPos,nBaseINSS,nBaseINSS,cFilAnter,cMatAnter,cBanAgen,cConCorr")
SetPrvt("aTotVal,cTexto,nSeq,nRef,aInfoE,nEnt,cTipCod,nBaseFGTS,nValFGTS,nTaxaIRRF,nBaseIRRF,nValIRRF,nValProv,nValDesc") 

//Carrega Variaveis
lEnd        := .F.
lContinua   := .T.
lAbortPrint := .F.
nHdl		:= 0
nDafas		:= 0
nPos		:= 0
cPerg		:= "HOLERITE"
cNomeArq	:= ""
cArq		:= ""
cArqInd		:= ""

fChkPerg()
pergunte(cPerg,.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Montagem da tela de processamento.                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
@ 200,001 TO 410,480 DIALOG oDlg TITLE OemToAnsi( "Geracao para Holerite On Line" )
@ 02,10 TO 095,230
@ 10,018 Say " Este programa ira gerar um arquivo texto, conforme os parame- "
@ 18,018 Say " tros definidos  pelo usuario,  com os registros do arquivo de "
@ 26,018 Say " Geracao de Arquivo Texto do Holerite On Line.        "

@ 70,128 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oDlg)
@ 70,188 BMPBUTTON TYPE 01 ACTION OkGeraTxt()

Activate Dialog oDlg Centered

If nHdl > 0
	If fClose(nHdl)
		If lContinua
			Aviso('AVISO','Gerado o arquivo ' + AllTrim(cNomeArq) + '...',{'OK'})
		Else
			If fErase(cNomeArq) == 0
				If lContinua
					Aviso('AVISO','Nao existem registros a serem gravados. A geracao do arquivo ' + AllTrim(cNomeArq) + ' foi abortada ...',{'OK'})
				EndIf
			Else
				MsgAlert('Ocorreram problemas na tentativa de delecao do arquivo '+AllTrim(cNomeArq)+'.')
			EndIf
		EndIf
	Else
		MsgAlert('Ocorreram problemas no fechamento do arquivo '+AllTrim(cNomeArq)+'.')
	EndIf
	
EndIf


Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ OKGERATXTบ Autor ณ JORGE SATO         บ Data ณ  12/01/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao chamada pelo botao OK na tela inicial de processamenบฑฑ
ฑฑบ          ณ to. Executa a geracao do arquivo texto.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */
Static Function OkGeraTxt()

Close(oDlg)

Processa({|| fRunHOL() },"Processando...")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfRunHOL   บAutor ณ JORGE SATO          บ Data ณ  12/01/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Processamento do Sistema                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

Static Function fRunHOL()

//Carrega Variaveis
Local cPDVerba := ""
//Variaveis das Perguntas
Pergunte(cPerg,.F.)

//Roteiro            		mv_par01
//Filial De            		mv_par02
//Filial Ate         		mv_par03
//Matricula De            	mv_par04
//Matricula Ate          	mv_par05
//Centro de Custo De      	mv_par06
//Centro de Custo Ate   	mv_par07
//Situacoes a Imprimir  	mv_par08
//Categorias a Imprimir 	mv_par09
//Nome do Arquivo           mv_par10

cFilDe      := mv_par02
cFilAte     := mv_par03
cMatDe      := mv_par04
cMatAte     := mv_par05
cCcDe       := mv_par06
cCcAte      := mv_par07
cSit        := mv_par08
cCat        := mv_par09
cNomeArq	:= mv_par10
nBaseSal  	:= 0
nLiqSal   	:= 0
nBaseINSS 	:= 0
nBaseFGTS 	:= 0
nValFGTS   	:= 0
nTaxaIRRF 	:= 0
nBaseIRRF 	:= 0
nValIRRF  	:= 0
nValProv  	:= 0
nValDesc  	:= 0 
cFilAnter   := " "
cMatAnter   := " " 
cTipCod     := " "
cBanAgen    := " "
cConCorr    := " " 
aInfoE		:= {}
aTotVal		:= {0,0}


//Cria o arquivo texto
While .T.
	If File(cNomeArq)
		If (nAviso := Aviso('AVISO','Deseja substituir o ' + AllTrim(cNomeArq) + ' existente ?', {'Sim','Nao','Cancela'})) == 1
			If fErase(cNomeArq) == 0
				Exit
			Else
				MsgAlert('Ocorreram problemas na tentativa de delecao do arquivo '+AllTrim(cNomeArq)+'.')
			EndIf
		ElseIf nAviso == 2
			Pergunte(cPerg,.T.)
			Loop
		Else
			Return
		EndIf
	Else
		Exit
	EndIf
EndDo

nHdl := fCreate(cNomeArq)

If nHdl == -1
	MsgAlert('O arquivo '+AllTrim(cNomeArq)+' nao pode ser criado! Verifique os parametros.','Atencao!')
	Return
Endif

//Monta Query de Filtro 

CQUERY := "SELECT RC_FILIAL,RC_MAT,RC_PD,RC_ROTEIR,RC_PERIODO,RC_CC,RV_DESC,RV_TIPOCOD,RC_HORAS,RC_VALOR,RA_CATFUNC,RA_NOMECMP,RA_CIC,RA_CC,RA_SITFOLH,"
CQUERY += " SUBSTRING(RA_ADMISSA,7,2)+'/'+SUBSTRING(RA_ADMISSA,5,2)+'/'+SUBSTRING(RA_ADMISSA,1,4) AS RA_ADMISSA,RA_BCDEPSA,RA_CTDEPSA,RJ_DESC,RJ_CODCBO,CTT_DESC01"
CQUERY += " FROM " + RETSQLNAME("SRC")+ " SRC INNER JOIN " + RETSQLNAME("SRV")+ " SRV ON (RV_COD = RC_PD)"
CQUERY += " INNER JOIN " + RETSQLNAME("SRA")+ " SRA ON (RA_FILIAL = RC_FILIAL AND RA_MAT = RC_MAT)"
CQUERY += " INNER JOIN " + RETSQLNAME("SRJ")+ " SRJ ON (RJ_FUNCAO = RA_CODFUNC)"
CQUERY += " INNER JOIN " + RETSQLNAME("CTT")+ " CTT ON (CTT_CUSTO = RA_CC)"
CQUERY += " WHERE SRC.D_E_L_E_T_ = ' ' AND SRV.D_E_L_E_T_ = ' ' AND SRA.D_E_L_E_T_ = ' ' AND SRJ.D_E_L_E_T_ = ' ' AND CTT.D_E_L_E_T_ = ' '" 
CQUERY += " AND RC_ROTEIR = '"+MV_PAR01+"'  AND RA_SITFOLH <> 'D' AND (RV_TIPOCOD IN ('1','2') OR RV_COD IN ('721','706','731','766','799','801'))"
CQUERY += " AND RC_FILIAL >= '"+CFILDE+"' AND RA_FILIAL <= '"+CFILATE+"'"
CQUERY += " AND RC_MAT    >= '"+CMATDE+"' AND RC_MAT    <= '"+CMATATE+"'"
CQUERY += " AND RC_CC     >= '"+CCCDE+ "' AND RC_CC     <= '"+CCCATE+ "'"
CQUERY += " ORDER BY RC_FILIAL,RC_MAT,RC_PD,RV_TIPOCOD"

cQuery := ChangeQuery(cQuery)

//Verifica se Tabela Aberta
If Select("R0NW") > 0
	DbSelectArea("R0NW")
	R0NW->(DbCloseArea())
EndIf

//Abre Tabela
dbUseArea( .T., 'TOPCONN', TcGenQry( ,, cQuery ), 'R0NW', .T., .F. )

R0NW->(DbGotop())

cTipCod     := R0NW->RV_TIPOCOD	
cFilAnter   := R0NW->RC_FILIAL
cMatAnter   := R0NW->RC_MAT
cTipCod     := R0NW->RV_TIPOCOD
fGerREG1()
fGerREG2()	

While R0NW->(!Eof()) 

	IncProc('Gerando o Arquivo... ')
    
	If cFilAnter <> R0NW->RC_FILIAL .AND. cMatAnter <> R0NW->RC_MAT .AND. cTipCod $ "1*2*3"

			//REGISTRO 04 
			fGerREG4()
			//REGISTRO 99 finaliza os dados da filial anterior
			//fGerREG9()
		 	//REGISTRO 01 se mudou de filial, grava dados da nova empresa.	  
			fGerREG1()
			cFilAnter   := R0NW->RC_FILIAL
			cMatAnter   := R0NW->RC_MAT
			cTipCod     := R0NW->RV_TIPOCOD			
			//REGISTRO 02
			fGerREG2()
		
	ElseIf cFilAnter = R0NW->RC_FILIAL .AND. cMatAnter <> R0NW->RC_MAT .AND. cTipCod $ "1*2*3*4"

			//REGISTRO 04
			fGerREG4()
			cFilAnter   := R0NW->RC_FILIAL
			cMatAnter   := R0NW->RC_MAT
			cTipCod     := R0NW->RV_TIPOCOD
			//REGISTRO 02
			fGerREG2()
		 
	ELSEIF cFilAnter = R0NW->RC_FILIAL .AND. cMatAnter = R0NW->RC_MAT .AND. cTipCod $ "1*2" 
		
			//REGISTRO 03	
			fGerREG3()
			
			cPDVerba := R0NW->RC_PD
			IF cPDVerba = "721"
				nBaseINSS := R0NW->RC_VALOR 
			ENDIF	
			cFilAnter   := R0NW->RC_FILIAL
			cMatAnter   := R0NW->RC_MAT
			cTipCod     := R0NW->RV_TIPOCOD			
			R0NW->(DbSkip())
	
	ELSEIF cFilAnter = R0NW->RC_FILIAL .AND. cMatAnter = R0NW->RC_MAT .AND. cTipCod $ "3" 
				
			//REGISTRO 04
			cPDVerba := R0NW->RC_PD
			cBanAgen:= R0NW->RA_BCDEPSA
			cConCorr:= SUBSTR(R0NW->RA_CTDEPSA,5,8)

			IF cPDVerba = "721"
				nBaseINSS := R0NW->RC_VALOR
			ELSEIF cPDVerba = "706"
				nBaseIRRF := R0NW->RC_VALOR
			ELSEIF cPDVerba = "731"			
				nBaseFGTS := R0NW->RC_VALOR
			ELSEIF cPDVerba = "766"
				nValFGTS := R0NW->RC_VALOR           
			ELSEIF cPDVerba = "799"	
				nLiqSal  := R0NW->RC_VALOR
			ELSEIF cPDVerba = "801"
				nBaseSal := R0NW->RC_VALOR 
			ENDIF
			cFilAnter   := R0NW->RC_FILIAL
			cMatAnter   := R0NW->RC_MAT
			cTipCod     := R0NW->RV_TIPOCOD
			R0NW->(DbSkip())

	ELSE		
		fGerREG4()
		cFilAnter   := R0NW->RC_FILIAL
		cMatAnter   := R0NW->RC_MAT
		cTipCod     := R0NW->RV_TIPOCOD
		R0NW->(DbSkip())		
	ENDIF
EndDo
//REGISTRO 04
fGerREG4()
//REGISTRO 99
fGerREG9()

R0NW->(DbCloseArea())
Return

//Fim da Rotina
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGerREG1 บAutor ณ JORGE SATO          บ Data ณ  12/01/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera Registro 01                                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ ok*/

Static Function fGerREG1() 

Local cMes		:= "" 
Local cTpFol	:= "" 

aInfoE  := {}

nSM0Recno := SM0->(Recno())
SM0->(dbSeek(cEmpAnt + R0NW->RC_FILIAL,.T.))

Aadd(aInfoE,SM0->M0_NOME)
Aadd(aInfoE,SM0->M0_NOMECOM)
Aadd(aInfoE,SM0->M0_CGC)
Aadd(aInfoE,SM0->M0_CIDENT)

// Retorna ao Registro
SM0->(dbGoto(nSM0Recno))

If MV_PAR01 == "ADI"
	cTpFol := "ADIANTAMENTO
ElseIF MV_PAR01 == "FOL"
	cTpFol := "FOLHA MENSAL"
ElseIF MV_PAR01 == "PLR"
	cTpFol := "FOLHA PLR"
ElseIF MV_PAR01 == "131"
	cTpFol := "13 SALARIO 1PAR"
ElseIF MV_PAR01 == "132"
	cTpFol := "13 SALARIO 2PAR" 
EndIf	

If SUBSTR(R0NW->RC_PERIODO,5,2) == "01"
	cMes := "JANEIRO DE "+SUBSTR(R0NW->RC_PERIODO,1,4)
ElseIF SUBSTR(R0NW->RC_PERIODO,5,2) == "02"
	cMes := "FEVEREIRO DE "+SUBSTR(R0NW->RC_PERIODO,1,4)
ElseIF SUBSTR(R0NW->RC_PERIODO,5,2) == "03
	cMes := "MARCO DE "+SUBSTR(R0NW->RC_PERIODO,1,4)
ElseIF SUBSTR(R0NW->RC_PERIODO,5,2) == "04"
	cMes := "ABRIL DE "+SUBSTR(R0NW->RC_PERIODO,1,4)
ElseIF SUBSTR(R0NW->RC_PERIODO,5,2) == "05"
	cMes := "MAIO DE "+SUBSTR(R0NW->RC_PERIODO,1,4)
ElseIF SUBSTR(R0NW->RC_PERIODO,5,2) == "06"
	cMes := "JUNHO DE "+SUBSTR(R0NW->RC_PERIODO,1,4)
ElseIF SUBSTR(R0NW->RC_PERIODO,5,2) == "07"
	cMes := "JULHO DE "+SUBSTR(R0NW->RC_PERIODO,1,4)
ElseIF SUBSTR(R0NW->RC_PERIODO,5,2) == "08"
	cMes := "AGOSTO DE "+SUBSTR(R0NW->RC_PERIODO,1,4)
ElseIF SUBSTR(R0NW->RC_PERIODO,5,2) == "09"
	cMes := "SETEMBRO DE "+SUBSTR(R0NW->RC_PERIODO,1,4)
ElseIF SUBSTR(R0NW->RC_PERIODO,5,2) == "10"
	cMes := "OUTUBRO DE "+SUBSTR(R0NW->RC_PERIODO,1,4)
ElseIF SUBSTR(R0NW->RC_PERIODO,5,2) == "11"
	cMes := "NOVEMBRO DE "+SUBSTR(R0NW->RC_PERIODO,1,4)
Else
	cMes := "DEZEMBRO DE "+SUBSTR(R0NW->RC_PERIODO,1,4) 
EndIf

cTexto := "01"                      	// 001 - 002 -> Tipo do Registro 01 - "01" fixo
cTexto += fGerZero(14,aInfoE[3])        // 003 - 016 -> CNPJ DA EMPRESA (filial)
cTexto += fGerStr(60,aInfoE[2])      	// 017 - 076 -> Razao Social
cTexto += fGerStr(20,cMes)     			// 077 - 096 -> Competencia do Periodo
cTexto += fGerStr(15,cTpFol)   			// 097 - 111 -> Tipo da Folha
cTexto += CRLF

fGravaReg(AllTrim(cTexto))

Return

//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGerREG2     บAutor  ณJORGE SATO       บ Data ณ  12/01/2017บ ฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera Registro 02                                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

Static Function fGerREG2()

aInfoE  := {}
cCatFu	:= "" 

If R0NW->RA_CATFUNC == "A"
	cCatFu:= "AUTONOMO"
ElseIf R0NW->RA_CATFUNC == "C"
	cCatFu:= "COMISSIONADO"
ElseIf R0NW->RA_CATFUNC == "D"
	cCatFu:= "DIARISTA"
ElseIf R0NW->RA_CATFUNC == "E"
	cCatFu:= "ESTAGIARIO MENSALISTA"
ElseIf R0NW->RA_CATFUNC == "G" 
	cCatFu:= "RSTAGIARIO HORISTA"
ElseIf R0NW->RA_CATFUNC == "H" 
	cCatFu:= "HORISTA"
ElseIf R0NW->RA_CATFUNC == "M" 
	cCatFu:= "MENSALISTA"
ElseIf R0NW->RA_CATFUNC == "P"
	cCatFu:= "PRO-LABORE"
ElseIf R0NW->RA_CATFUNC == "S"
	cCatFu:= "SEMANALISTA"
ElseIf R0NW->RA_CATFUNC == "T" 
	cCatFu:= "TAREFEIRO"
EndIf	

nSM0Recno := SM0->(Recno())
SM0->(dbSeek(cEmpAnt + R0NW->RC_FILIAL,.T.))

Aadd(aInfoE,SM0->M0_NOME)
Aadd(aInfoE,SM0->M0_NOMECOM)
Aadd(aInfoE,SM0->M0_CGC)
Aadd(aInfoE,SM0->M0_CIDENT)

// Retorna ao Registro
SM0->(dbGoto(nSM0Recno))

cTexto := "02"			                // 001 - 002 -> Registro 02 - "02" fixo
cTexto += fGerZero(07,R0NW->RC_MAT)     // 003 - 009 -> Cod. Empregado
cTexto += fGerStr(51,R0NW->RA_NOMECMP)   // 010 - 060 -> Nome Empregado
cTexto += fGerZero(06,R0NW->RJ_CODCBO)  // 061 - 066 -> Cod. CBO
IF SUBSTR(R0NW->RA_CC,1,1) == "0"
	cTexto += fGerStr(03,SUBSTR(R0NW->RA_CC,2,3))// 067 - 069 -> Cod. Depto
ELSEIF SUBSTR(R0NW->RA_CC,1,1) # "0"	
	cTexto += fGerStr(03,SUBSTR(R0NW->RA_CC,1,3))// 067 - 069 -> Cod. Depto 
ENDIF	
cTexto += fGerZero(03,cEmpAnt)           // 070 - 072 -> Cod. Empresa
cTexto += fGerStr(35,R0NW->RJ_DESC)      // 073 - 107 -> Desc. Cargo
cTexto += fGerStr(10,R0NW->RA_ADMISSA)   // 108 - 117 -> Data Admissao
cTexto += fGerStr(20,R0NW->CTT_DESC01)   // 118 - 137 -> Desc. Centro de Custo
cTexto += fGerStr(15,aInfoE[4])		     // 138 - 152 -> Cidade Empresa
cTexto += fGerStr(30,cCatFu)			 // 153 - 182 -> Categoria Empregado
cTexto += fGerZero(11,R0NW->RA_CIC)	     // 183 - 193 -> CPF Empregado
cTexto += CRLF

fGravaReg(AllTrim(cTexto))

Return
//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGerREG3  บAutor  ณJORGE SATO          บ Data ณ  12/01/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera Registro 03                                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

Static Function fGerREG3()

Local cPRODESC := ""
Local cVerba   := R0NW->RC_PD 

IF R0NW->RV_TIPOCOD $ "1*2"

	IF R0NW->RV_TIPOCOD == "1" 
		nValProv += R0NW->RC_VALOR
		cPRODESC := "P"
	ElseIf R0NW->RV_TIPOCOD == "2" 
		cPRODESC := "D"
		nValDesc += R0NW->RC_VALOR		
	EndIf 

	cTexto := "03" 
	IF cVerba = '405'
		nTaxaIRRF 	:= R0NW->RC_HORAS   
		nValIRRF  	:= R0NW->RC_VALOR   
	ENDIF                                                        // 001 - 002 -> Registro 03 - "03" fixo
	cTexto += fGerZero(06,R0NW->RC_PD)						     // 003 - 008 -> Cod. Evento
	cTexto += fGerStr(35,R0NW->RV_DESC)                          // 009 - 043 -> Nome do Evento
	cTexto += fGerZero(08,transform(R0NW->RC_HORAS,"99999.99"))  // 044 - 051 -> Valor Dia/Hora do Evento
	cTexto += fGerZero(11,transform(R0NW->RC_VALOR,"99999999.99")) // 052 - 062 -> Valor Calculado do Evento
	cTexto += cPRODESC                                           // 063 - 063 -> Provento/Desconto
	cTexto += CRLF
	cTexto:= StrTran(cTexto,".",",")
	fGravaReg(AllTrim(cTexto))
ENDIF	
Return
//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGerREG4  บAutor  ณJORGE SATO          บ Data ณ  12/01/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera Registro 04                                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

Static Function fGerREG4()

cTexto := "04"                                                // 001 - 002 -> Registro 04 - "04" fixo
cTexto += fGerZero(11,transform(nValProv,"99999999.99")) 	  // 003 - 013 -> Total Proventos
cTexto += fGerZero(11,transform(nValDesc,"99999999.99")) 	  // 014 - 024 -> Total Descontos 
cTexto += fGerZero(11,transform(nLiqSal,"99999999.99"))     // 025 - 035 -> Liquido
cTexto += fGerZero(11,transform(nBaseSal,"99999999.99"))    // 036 - 046 -> Salario Base
cTexto += fGerZero(11,transform(nBaseINSS,"99999999.99"))   // 047 - 057 -> Base INSS
cTexto += fGerZero(11,transform(nBaseFGTS,"99999999.99"))   // 058 - 068 -> Base FGTS
cTexto += fGerZero(11,transform(nValFGTS,"99999999.99"))    // 069 - 079 -> Valor FGTS
cTexto += fGerZero(11,transform(nTaxaIRRF,"999999999.99"))   // 080 - 090 -> Taxa IRRF
cTexto += fGerZero(11,transform(nBaseIRRF,"99999999.99"))   // 091 - 101 -> Base IRRF
cTexto += fGerZero(11,transform(nValIRRF,"99999999.99"))    // 102 - 112 -> Valor IRRF
cTexto += fGerZero(03,SUBSTR(cBanAgen,1,3))                  // 113 - 115 -> Cod. Banco
cTexto += fGerZero(06,SUBSTR(cBanAgen,4,4))                  // 116 - 121 -> Cod. Agencia
cTexto += fGerStr(01,SUBSTR(cBanAgen,5,1))                   // 122 - 122 -> Digito Agencia
cTexto += fGerZero(08,cConCorr)                             // 123 - 130 -> Conta Corrente
cTexto += CRLF 

cTexto:= StrTran(cTexto,".",",")

fGravaReg(AllTrim(cTexto))


nBaseSal  	:= 0
nLiqSal   	:= 0
nBaseINSS 	:= 0
nBaseFGTS 	:= 0
nValFGTS   	:= 0
nTaxaIRRF 	:= 0
nBaseIRRF 	:= 0
nValIRRF  	:= 0
nValProv  	:= 0
nValDesc  	:= 0 
cBanAge     :=""
cConCorr    :=""
aTotVal	:= {0,0}

Return
//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGerREG9  บAutor  ณJORGE SATO          บ Data ณ  12/01/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera Registro 99                                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

Static Function fGerREG9()
	
//cTexto := "9999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"// 001 - 100 -> Registro Final - "999999" fixo
cTexto := Replic("9",100)
cTexto += CRLF


fGravaReg(AllTrim(cTexto))

Return
//Fim da Rotina


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuno    ณ fGravaReg   ณ Autor ณ JORGE SATO       บ Data ณ 12/01/2017 บฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Grava Registros no Arquivo Texto                           ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ fGravaReg()                                                ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ GeraKitVT                                                  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function fGravaReg(cLin)

If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
	If !MsgYesNo('Ocorreu um erro na gravacao do arquivo '+AllTrim(cNomeArq)+'.   Continua?','Atencao!')
		lContinua := .F.
		Return
	Endif
Endif

Return

//Fim da Rotina


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ  fGerStr บAutor ณ JORGE SATO         บ Data ณ  12/01/2017 บฑฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Acrescenta espacos a direita                               บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */
Static Function fGerStr(nNum,cVaria)

Local cVar

cVar := AllTrim(cVaria) + Space(nNum)

cVar := Subst(cVar,1,nNum)

Return(cVar)

//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGerZero  บAutor ณ JORGE SATO         บ Data ณ  12/01/2017 บฑฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Acrescenta zeros a Esquerda                                บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */
Static Function fGerZero(nNum,cVaria)

Local cVar

cVar := Replic("0",nNum) + AllTrim(cVaria)

cVar := Right(cVar,nNum)

Return(cVar)

//Fim da Rotina


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfChkPerg  บAutor ณ JORGE SATO         บ Data ณ  20/10/2016 บฑฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Perguntas do Sistema.                                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */
Static Function fChkPerg()

Local aRegs := {}
Local Fi    := FWSizeFilial()

aAdd(aRegs,{cPerg,'01','Roteiro de Caluclo      ?','','','mv_ch1','C',03,0,0,'G','           ','mv_par01','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SRY','','',''})
aAdd(aRegs,{cPerg,'02','Filial De               ?','','','mv_ch2','C',Fi,0,0,'G','           ','mv_par02','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','XM0','','',''})
aAdd(aRegs,{cPerg,'03','Filial Ate              ?','','','mv_ch3','C',Fi,0,0,'G','NaoVazio   ','mv_par03','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','XM0','','',''})
aAdd(aRegs,{cPerg,'04','Matricula De            ?','','','mv_ch4','C',06,0,0,'G','           ','mv_par04','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SRA','','',''})
aAdd(aRegs,{cPerg,'05','Matricula Ate           ?','','','mv_ch5','C',06,0,0,'G','NaoVazio   ','mv_par05','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SRA','','',''})
aAdd(aRegs,{cPerg,'06','Centro de Custo De      ?','','','mv_ch6','C',12,0,0,'G','           ','mv_par06','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','CTT','','',''})
aAdd(aRegs,{cPerg,'07','Centro de Custo Ate     ?','','','mv_ch7','C',12,0,0,'G','NaoVazio   ','mv_par07','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','CTT','','',''})
aAdd(aRegs,{cPerg,'08','Situacoes a Imprimir    ?','','','mv_ch8','C',05,0,0,'G','fSituacao  ','mv_par08','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ','','',''})
aAdd(aRegs,{cPerg,'09','Categorias a Imprimir   ?','','','mv_ch9','C',12,0,0,'G','fCategoria ','mv_par09','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ','','',''})
aAdd(aRegs,{cPerg,'10','Local e Nome do Arquivo ?','','','mv_cha','C',70,0,0,'G','NaoVazio   ','mv_par10','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ','','',''})
                                             
ValidPerg(aRegs,cPerg,.F.)

Return

//Fim da Rotina
