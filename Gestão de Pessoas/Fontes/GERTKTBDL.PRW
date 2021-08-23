#INCLUDE "Protheus.ch"
#include "topconn.ch"
#include "RWMAKE.ch"
#DEFINE  CRLF        Chr(13)+Chr(10)

//Definicao dos elementos do array aTotVal
#DEFINE TOTHEA	 1 		//Total de Header
#DEFINE TOTDET	 2 		//Total de Detalhe
#DEFINE TOTTRA	 3 		//Total de Trailer
#DEFINE TOTUEN	 4 		//Total de Unidade de Entrega
#DEFINE TOTDEP	 5 		//Total de Departamento
#DEFINE TOTFUT	 6 		//Total de Funcionarios de VT
#DEFINE TOTITT	 7 		//Total de Itens de VT
#DEFINE TOTPAS	 8 		//Total de Passagens
#DEFINE TOTQVR	 9 		//Total de Vale Refeicao
#DEFINE TOTVVR	10 		//Total de Valor de VR
#DEFINE TOTFUE	11 		//Total de Funcionarios VR Eletronico
#DEFINE TOTFUA  12 		//Total de Funcionarios VA Eletronico
#DEFINE TOTTVR  13 		//Valor Total VR Eletronico
#DEFINE TOTTVA  14 		//Valor Total VA Eletronico

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ GERTKTBDL บ Autor ณ JORGE SATO        บ Data ณ  28/02/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Geracao de Arquivo Texto para Aquisicao do Kit Beneficios  บฑฑ
ฑฑบ          ณ da Empresa Bacio de Latte                                  บฑฑ
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

User Function GERTKTBDL()

//Declaracao de Variaveis
SetPrvt("lEnd,lContinua,lAbortPrint,lDetVRE,lDetVAE,nHdl,nDafas,cPerg,cNomeArq,cArq,cArqInd,nPos")
SetPrvt("aTotVal,lFlag,lTran,lAlim,lRef,cFilSRO,cFilSRN,cTexto,cValAnt,nTVlrServ,nSeq,nDtrab,nRef,aInfoE,nEnt,cFilEnt,nContrOld,aShTaSAli,aEntrega")

//Carrega Variaveis
lEnd        := .F.
lContinua   := .T.
lAbortPrint := .F.
nHdl		:= 0
nDafas		:= 0
nPos		:= 0
cPerg		:= "GERTKTVR  "
cNomeArq	:= ""
cArq		:= ""
cArqInd		:= ""

fChkPerg()
Pergunte(cPerg,.F.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Montagem da tela de processamento.                                  ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
@ 200,001 TO 410,480 DIALOG oDlg TITLE OemToAnsi( "Geracao Ticket Eletronico (VA/VR)" )
@ 02,10 TO 095,230
@ 10,018 Say " Este programa ira gerar um arquivo texto, conforme os parame- "
@ 18,018 Say " tros definidos  pelo usuario,  com os registros do arquivo de "
@ 26,018 Say " Geracao de Arquivo Texto do Ticket Eletronico (VA/VR).        "

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

//Fechamento do Arquivo Temporario
If File(cArq + ".DBF")
	
	//Seleciona Area
	dbSelectArea('TMPT')
	dbCloseArea('TMPT')
	
	Ferase(cArq + ".DBF")
	Ferase (cArqInd+OrdBagExt())
	
Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ OKGERATXTบ Autor ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
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

Processa({|| fRunTKT() },"Processando...")

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfRunTkt   บAutor ณ JORGE SATO        บ Data ณ  28/02/2017   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Processamento do Sistema                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

Static Function fRunTkt()

//Carrega Variaveis
aTotVal		:= {0,0,0,0,0,0,0,0,0,0,0,0,0,0} 				//Informacoes definidas no #DEFINE
nSeq		:= 1
aInfoE		:= {}

//Variaveis das Perguntas

Pergunte(cPerg,.F.)

dVrEntr			:= If(!Empty(mv_par01),mv_par01,dDataBase) // Periodo de Referencia
nRef			:= mv_par02
cFilDe     		:= mv_par03
cFilAte     	:= mv_par04
cMatDe      	:= mv_par05
cMatAte     	:= mv_par06
cCcDe       	:= mv_par07
cCcAte      	:= mv_par08
//cEnt			:= mv_par09
CUser 			:= mv_par09
cNomeArq		:= mv_par10
//cAnoMes     	:= Str(Year(dDataRef),4) + StrZero(Month(dDataRef),2)
//dPedido     	:= StrZero(DAY(dDataRef),2) + "/" + StrZero(Month(dDataRef),2) + "/" + SUBS(Str(Year(dDataRef),4),3,2)

//Cria DBF
fCriaDBF()

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
cQuery := "Select RA_FILIAL,RA_CC,RA_MAT,RA_NOME,RA_NASC,RA_CIC,R0_VALCAL,CTT_DESC01, R0_TPVALE"
cQuery += " FROM " + RETSQLNAME("SRA")+ " ," +  RETSQLNAME("SR0")+ " , " +  RETSQLNAME("CTT")
cQuery += " Where RA_SITFOLH <> 'D'"
cQuery += " and RA_FILIAL >= '"+cFilDe+"' and RA_FILIAL <= '"+cFilAte+"' "
cQuery += " and RA_CC     >= '"+cCcDe+ "' and RA_CC     <= '"+cCcAte+ "' "
cQuery += " and RA_MAT    >= '"+cMatDe+"' and RA_MAT    <= '"+cMatAte+"' "
cQuery += " and RA_FILIAL = R0_FILIAL and RA_MAT = R0_MAT and RA_CC = CTT_CUSTO "
cQuery += " and R0_VALCAL > 0 "
If nRef <> 3
	cQuery += " and R0_TPVALE = '" + alltrim(str(nRef)) + "' "
Else
	cQuery += " and (R0_TPVALE = '1' OR R0_TPVALE = '2')"
EndIf
cQuery += " and "+RETSQLNAME("SRA")+".D_E_L_E_T_ = ''"
cQuery += " and "+RETSQLNAME("SR0")+".D_E_L_E_T_ = ''"
cQuery += " and "+RETSQLNAME("CTT")+".D_E_L_E_T_ = ''"
cQuery += " ORDER BY R0_TPVALE,RA_FILIAL,RA_CC,RA_NOME"

cQuery := ChangeQuery(cQuery)

//Verifica se Tabela Aberta
If Select("R0NW") > 0
	DbSelectArea("R0NW")
	DbCloseArea("R0NW")
EndIf

//Abre Tabela
dbUseArea( .T., 'TOPCONN', TcGenQry( ,, cQuery ), 'R0NW', .T., .F. )

TcSetField( "R0NW", "R0_VALCAL" , "N", 12, 2 )
TcSetField( "R0NW", "RA_NASC"   , "D",  8, 0 )

R0NW->(DbGotop())

//Header do Arquivo
fGerLSUP5()

nRefold 	:= 0
nRef 		:= 0
cFilOld   	:= ''
nContrOld 	:= ''
nContr 	  	:= ''
aEntrega	:= {}
// busca o endere็o conforme empresa identificado na Filial
fCarrTab( @aShTaSAli,"U001")

While R0NW->(!Eof())
	
	If (nPos := Ascan(aShTaSAli,{|x| x[2]==R0NW->RA_FILIAL})) == 1
		If (nPos := Ascan(aShTaSAli,{|x| x[5]=="01"})) == 0
			nPos := Ascan(aShTaSAli,{|x| x[4]})
		EndIf
	EndIf
	aInfoE		:= {}
	nSM0Recno := SM0->(Recno())
	SM0->(dbSeek(cEmpAnt + R0NW->RA_FILIAL,.T.))

	Aadd(aInfoE,SM0->M0_NOME)
	Aadd(aInfoE,SM0->M0_NOMECOM)
	Aadd(aInfoE,SM0->M0_FILIAL)
	// Retorna ao Registro
	SM0->(dbGoto(nSM0Recno))	
	
	nRef := val(R0NW->R0_TPVALE)
	
	If R0NW->RA_FILIAL  <> cFilOld .or. nRefold <> val(R0NW->R0_TPVALE)   //+ R0NW->RA_CC
	//aAdd( aEntrega, {"0101","0101"})			// Refeicao
		aAdd( aEntrega , {aShTaSAli[nPos,20],aShTaSAli[nPos,19],R0NW->RA_FILIAL,aShTaSAli[nPos,11],aShTaSAli[nPos,12],aShTaSAli[nPos,13],aShTaSAli[nPos,14],aShTaSAli[nPos,15],aShTaSAli[nPos,16],aShTaSAli[nPos,17],aShTaSAli[nPos,18],R0NW->R0_TPVALE,R0NW->CTT_DESC01})
//        fGerTRE()                                             //R0NW->RA_FILIAL + R0NW->RA_CC
	EndIf
	IF nRefold <> val(R0NW->R0_TPVALE)
		//REGISTRO SUPLEMENTAR
		fGerHTRE() 
	ENDIF	
	//REGISTRO DAS UNIDADES DE ENTREGA
	IF cFilOld <> R0NW->RA_FILIAL
		fGerTRE()
	ENDIF	
	
	nRefold := val(R0NW->R0_TPVALE)
	cFilOld :=  R0NW->RA_FILIAL   //R0NW->RA_FILIAL + R0NW->RA_CC
	R0NW->(DbSkip())
EndDo

aAdd( aEntrega , {'XXX', 'XXX'})

R0NW->(DbGotop())

nContrOld 	:= ''
nContr	  	:= ''
cFilOld		:= ''
nRefold 	:= 0

While R0NW->(!Eof())
	
	IncProc('Gerando o Arquivo... ')
	nRef 		:= val(R0NW->R0_TPVALE)
	
	If (nPos := Ascan(aShTaSAli,{|x| x[2]==Subst(R0NW->RA_FILIAL,1,4)})) == 0
		If (nPos := Ascan(aShTaSAli,{|x| x[5]=="01"})) == 0
			nPos := Ascan(aShTaSAli,{|x| x[4]})
		EndIf
	EndIf
	
	If nRef = 1
		nContr := aShTaSAli[nPos,20]
	Else
		nContr := aShTaSAli[nPos,19]
	EndIf
	
	If nContr <> nContrOld .or. nRef <> nRefold
		If cFilOld <> ""
			fGerTTRE()
		EndIf
		
		If nRef = 1
			n := ascan(aEntrega, { |x| x[1] == nContr .and. val(x[12]) == nRef .and. x[3] == R0NW->RA_FILIAL } )//R0NW->RA_FILIAL + R0NW->RA_CC
		Else
			n := ascan(aEntrega, { |x| x[2] == nContr .and. val(x[12]) == nRef .and. x[3] == R0NW->RA_FILIAL } )//R0NW->RA_FILIAL + R0NW->RA_CC
		EndIf 	
		
		nstop := 0
		nContrOld := nContr
		While (nContrOld = aEntrega[n,1] .or. nContrOld = aEntrega[n,2]) .and. nstop = 0 
            
			If Len(aEntrega) >= n+1
				n += 1
				If aEntrega[n,1] <> 'XXX'
					If alltrim(str(nRef)) <> aEntrega[n,12]
						nstop := 1
					Endif
				Endif
				
			EndIf
			
		EndDo
	EndIf
	
	fGerTRF()
	cFilOld := R0NW->RA_FILIAL
	nRefold	:= val(R0NW->R0_TPVALE)
	
	R0NW->(DbSkip())
	
EndDo

//REGISTRO TRAILLER
fGerTTRE()

//Trailler do Arquivo
fGerLSUP9()

Return

//Fim da Rotina
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGerLSUP  บAutor ณ  JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera Registro LSUP5                                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ ok*/

Static Function fGerLSUP5()

cTexto := "LSUP5"                      	// 001 - 005 -> Tipo do Registro
cTexto += "TICKET  "	             	// 006 - 013 -> Nome do Usuario que gerou o arquivo
cTexto += Space(11)                    	// 014 - 024 -> Brancos
cTexto += GravaData(dDataBase,.F.,8 )  	// 025 - 032 -> Data da Geracao
cTexto += Time()	   				   	// 033 - 040 -> Hora da Grava็ใo HH.MM.SS
cTexto += "LAYOUT-16/06/2014"          	// 041 - 057 -> Fixo
cTexto += Space(107)                   	// 058 - 165 -> Brancos
cTexto += CRLF

fGravaReg(AllTrim(cTexto))

Return

//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fGerHTRE บAutor ณ JORGE SATO        บ Data ณ  28/02/2017   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera Registro Header Vale Refeicao Eletronico              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ ok*/

Static Function fGerHTRE()

cTexto := "T"         	                           	// 001 - 001 -> Fixo T
If nRef = 1
	cTexto += "R"                                  	// 002 - 002 -> Refeicao
Else
	cTexto += "A"                                  	// 002 - 002 -> Alimenta็ao
EndIf
cTexto += "02"										// 003 - 004 -> Fixo 02        admin
cTexto += "0"										// 005 - 005 -> 0
If nRef = 1
	cTexto += "R"									// 006 - 006 -> Refeicao
Else
	cTexto += "A"									// 006 - 006 -> Alimentacao
EndIf

// busca o endere็o conforme empresa identificado na Filial
//fCarrTab( @aShTaSAli,"U001")

If (nPos := Ascan(aShTaSAli,{|x| x[2]==Subst(R0NW->RA_FILIAL,1,4)})) == 1
	If (nPos := Ascan(aShTaSAli,{|x| x[5]=="01"})) == 0
			nPos := Ascan(aShTaSAli,{|x| x[4]})
	EndIf
EndIf

If nRef = 1
	cTexto += PADL(alltrim(Subst(aShTaSAli[nPos,20],1,10)),10,"0")			// 007 - 016 -> Refeicao
Else
	cTexto += PADL(alltrim(Subst(aShTaSAli[nPos,19],1,10)),10,"0")			// 007 - 016 -> Alimentacao
EndIf
cTexto += fGerStr(24,aInfoE[1])		              	// 017 - 040 -> Nome da Empresa
cTexto += Space(6)                   				// 041 - 046 -> Brancos
cTexto += GravaData(dDataBase,.F.,8)            	// 047 - 054 -> Data de Geracao
cTexto += GravaData(dVrEntr,.F.,8)                	// 055 - 062 -> Data de Entrega
cTexto += "C"                                      	// 063 - 063 -> C
cTexto += Space(16)                               	// 064 - 079 -> Brancos
cTexto += StrZero(Month(dDataBase),2)             	// 080 - 081 -> Mes de Referencia
cTexto += Space(19)                               	// 082 - 100 -> Brancos
cTexto += "04"		                                // 101 - 102 -> 04
If nRef = 1
	cTexto += "34"		          		            // 103 - 104 -> Tipo de Cartao - (TRE
Else
	cTexto += "33"		          		            // 103 - 104 -> Tipo de Cartao - (TRA
EndIf
cTexto += Space(48)									// 105 - 152 -> Brancos
cTexto += fGerStr(06,"SUP")							// 153 - 158 -> Preencher com "SUP"
cTexto += StrZero(nSeq,6)                         	// 159 - 164 -> Controle Sequencia
cTexto += CRLF

fGravaReg(AllTrim(cTexto))

nSeq += 1
aTotVal[TOTHEA] += 1

Return

//Fim de Arquivo

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fGerTRE  บAutor ณ JORGE SATO        บ Data ณ  28/02/2017   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera Registro Unidade de Entrega Vale Refeicao Eletronico  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ ok*/

Static Function fGerTRE()

aInfoE		:= {}
nSM0Recno := SM0->(Recno())
SM0->(dbSeek(cEmpAnt + R0NW->RA_FILIAL,.T.))

Aadd(aInfoE,SM0->M0_NOME)
Aadd(aInfoE,SM0->M0_NOMECOM)
Aadd(aInfoE,SM0->M0_FILIAL)
// Retorna ao Registro
SM0->(dbGoto(nSM0Recno))

If nRef = 1
	nContrOld := aShTaSAli[nPos,20]
Else
	nContrOld := aShTaSAli[nPos,19]
EndIf

cTexto := "T" 										// 001 - 001 -> Tipo do Produto
If nRef = 1
	cTexto += "R"                                  	// 002 - 002 -> Refeicao
Else
	cTexto += "A"                                  	// 002 - 002 -> Alimenta็ao
EndIf
cTexto += "02"										// 003 - 004 -> Fixo 02
cTexto += "2"										// 005 - 005 -> 2
cTexto += fGerStr(26,aInfoE[3]) //fGerStr(26,R0NW->CTT_DESC01)               	// 006 - 031 -> Nome da Unidade
cTexto += fGerStr(4,aShTaSAli[nPos,11]) 	//fGerStr(4,aShTaSAli[nPos,11])        	  	// 032 - 035 -> Tipo de Logradouro
cTexto += fGerStr(30,aShTaSAli[nPos,12]) //fGerStr(30,aShTaSAli[nPos,12])			// 036 - 065 -> Nome do Logradouro
cTexto += fGerZero(6,aShTaSAli[nPos,13]) //fGerZero(6,aShTaSAli[nPos,13])         	// 066 - 071 -> Numero do Logradouro
cTexto += fGerStr(10,aShTaSAli[nPos,14]) //fGerStr(10,aShTaSAli[nPos,14])        	// 072 - 081 -> Complemento do Logradouro
cTexto += fGerStr(25,aShTaSAli[nPos,15]) //fGerStr(25,aShTaSAli[nPos,15])  		 	// 082 - 106 -> Municipio
cTexto += fGerStr(15,aShTaSAli[nPos,16]) //fGerStr(15,aShTaSAli[nPos,16])  			// 107 - 121 -> Bairro
cTexto += Subst(aShTaSAli[nPos,17],1,5) //Subst(aShTaSAli[nPos,17],1,5)				// 122 - 126 -> CEP
cTexto += aShTaSAli[nPos,18] 			//aShTaSAli[nPos,18]						// 127 - 128 -> Estado
cTexto += fGerStr(20,cUser)           			  								// 129 - 148 -> Responsavel
cTexto += Subst(aShTaSAli[nPos,17],6,3) //Subst(aShTaSAli[nPos,17],5,3)				// 149 - 151 -> Complemento CEP
cTexto += Space(7)                              								// 152 - 158 -> Reservado
cTexto += StrZero(nSeq,6)                         								// 159 - 164 -> Controle Sequencia
cTexto += CRLF

fGravaReg(AllTrim(cTexto))

nSeq += 1

If RecLock("TMPT",.T.)
	TMPT->TIPREG	:=	"TRE"
	TMPT->CODIGO	:= R0NW->RA_FILIAL
	TMPT->TEXTO		:= cTexto
	MSunLock()
Endif

aTotVal[TOTDET] += 1

Return

//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ  fGerTRF บAutor ณ JORGE SATO        บ Data ณ  28/02/2017   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera Registro de Funcionarios do Vale Refeicao Eletronico  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ ok*/

Static Function fGerTRF()

aInfoE		:= {}
nSM0Recno := SM0->(Recno())
SM0->(dbSeek(cEmpAnt + R0NW->RA_FILIAL,.T.))

Aadd(aInfoE,SM0->M0_NOME)
Aadd(aInfoE,SM0->M0_NOMECOM)
Aadd(aInfoE,SM0->M0_FILIAL)
// Retorna ao Registro
SM0->(dbGoto(nSM0Recno)) 

cTexto := "T"	                          	        							// 001 - 001 -> Fixo T
If nRef = 1
	cTexto += "R"                                  								// 002 - 002 -> Refeicao
Else
	cTexto += "A"                                  								// 002 - 002 -> Alimenta็ao
EndIf
cTexto += "02"                                   								// 003 - 004 -> Fixo 02
cTexto += "3"  				                    								// 005 - 005 -> Fixo 3
cTexto += fGerStr(26,fGerZero(6,(R0NW->RA_CC)))         //R0NW->RA_FILIAL +     // 006 - 031 -> Codigo do Departamento
cTexto += fGerZero(12,R0NW->RA_CIC)							   					// 032 - 043 -> Codigo do Funcionario
cTexto += GravaData(R0NW->RA_NASC,.F.,5)            							// 044 - 051 -> Data de Nascimento
cTexto += Space(18)					            								// 052 - 069 -> Branco
cTexto += fGerStr(26,aInfoE[3])//fGerStr(26,R0NW->CTT_DESC01)//R0NW->RA_FILIAL + // 070 - 095 -> Nome da Unidade
cTexto += "00101"                                  								// 096 - 100 -> Preencher 00101
cTexto += StrZero(Round(R0NW->R0_VALCAL * 100,2),9)        						// 101 - 109 -> Valor Total do Beneficio
If nRef = 1
	cTexto += "R"                                  								// 110 - 110 -> Produto
Else
	cTexto += "A"                                  								// 110 - 110 -> Produto
EndIf
cTexto += "E"   	                                							// 111 - 111 -> Eletronico
cTexto += fGerStr(30,R0NW->RA_NOME)                 							// 112 - 141 -> Nome do Funcionario
cTexto += Space(17)                                								// 142 - 158 -> Brancos
cTexto += StrZero(nSeq,6)                          								// 159 - 164 -> Controle Sequencia
cTexto += CRLF

fGravaReg(AllTrim(cTexto))

nSeq += 1

If RecLock("TMPT",.T.)
	TMPT->TIPREG	:=	"TRF"
	TMPT->TEXTO		:= cTexto
	MSunLock()
Endif

aTotVal[TOTFUE] += 1
aTotVal[TOTTVR] += R0NW->R0_VALCAL
aTotVal[TOTDET] += 1

Return

//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fGerTTRE บAutor ณ  JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera Registro Trailes do Vale Refeicao Eletronico          บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

Static Function fGerTTRE()

cTexto := "T"                     	   								// 001 - 001 -> Tipo do Registro
If nRef = 1 .or. nRefold = 1
	cTexto += "R"                                  					// 002 - 002 -> Refeicao
Else
	cTexto += "A"                                  					// 002 - 002 -> Alimenta็ao
EndIf
cTexto += "02"														// 003 - 003 -> 02
cTexto += "9"														// 005 - 005 -> Tipo de Registro
cTexto += StrZero(aTotVal[TOTFUE],8)       							// 006 - 013 -> Total de Funcionarios
cTexto += StrZero(Round(aTotVal[TOTTVR] * 100,2),14)				// 014 - 027 -> Valor Total
cTexto += Space(131)                   								// 028 - 158 -> Brancos
cTexto += StrZero(nSeq,6)                   						// 159 - 164 -> Controle Sequencia
cTexto += CRLF


aTotVal[TOTFUE] := 0
aTotVal[TOTTVR] := 0

fGravaReg(AllTrim(cTexto))
aTotVal[TOTTRA]	+= 1

Return

//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfGerLSUP9 บAutor ณ  JORGE SATO        บ Data ณ  28/02/2017  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Gera Registro LSUP9                                        บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

Static Function fGerLSUP9()

cTexto := "LSUP9"                     			// 001 - 005 -> Tipo do Registro
cTexto += StrZero(aTotVal[TOTHEA],8)  			// 006 - 013 -> Total Headerดs
cTexto += StrZero(aTotVal[TOTTRA],8)  			// 014 - 021 -> Total Traillerดs
cTexto += StrZero(aTotVal[TOTDET],8)  			// 022 - 029 -> Total Registros
cTexto += Space(135)                  			// 030 - 164 -> Brancos
cTexto += CRLF

fGravaReg(AllTrim(cTexto))

Return

//Fim da Rotina

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ fGravaReg   ณ Autor ณ  JORGE SATO    บ Data ณ  28/02/2017  บฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Grava Registros no Arquivo Texto                           ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe   ณ fGravaReg()                                                ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณ GeraKit                                                    ณฑฑ
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
ฑฑบPrograma  ณ  fGerStr บAutor ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑฑ
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
ฑฑบPrograma  ณfGerZero  บAutor ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑฑ
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

/*


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfChkPerg  บAutor ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑฑ
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

aAdd(aRegs,{cPerg,'01','Data de Entrega         ?','Data de Entrega         ?','Data de Entrega         ?','mv_ch1','D',08,0,0,'G','NaoVazio   ','mv_par01','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ','','',''})
aAdd(aRegs,{cPerg,'02','VR ou VA                ?','VR ou VA                ?','VR ou VA                ?','mv_ch2','N',01,0,0,'C','           ','mv_par02','VR             ','','','','','VA           ','','','','','Ambos        ','','','','','              ','','','','','               ','','','','   ','','',''})
aAdd(aRegs,{cPerg,'03','Filial De               ?','Filial De               ?','Filial De               ?','mv_ch3','C',Fi,0,0,'G','           ','mv_par03','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SM0','','',''})
aAdd(aRegs,{cPerg,'04','Filial Ate              ?','Filial Ate              ?','Filial Ate              ?','mv_ch4','C',Fi,0,0,'G','NaoVazio   ','mv_par04','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SM0','','',''})
aAdd(aRegs,{cPerg,'05','Matricula De            ?','Matricula De            ?','Matricula De            ?','mv_ch5','C',06,0,0,'G','           ','mv_par05','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SRA','','',''})
aAdd(aRegs,{cPerg,'06','Matricula Ate           ?','Matricula Ate           ?','Matricula Ate           ?','mv_ch6','C',06,0,0,'G','NaoVazio   ','mv_par06','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','SRA','','',''})
aAdd(aRegs,{cPerg,'07','Centro de Custo De      ?','Centro de Custo De      ?','Centro de Custo De      ?','mv_ch7','C',09,0,0,'G','           ','mv_par07','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','CTT','','',''})
aAdd(aRegs,{cPerg,'08','Centro de Custo Ate     ?','Centro de Custo Ate     ?','Centro de Custo Ate     ?','mv_ch8','C',09,0,0,'G','NaoVazio   ','mv_par08','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','CTT','','',''})
aAdd(aRegs,{cPerg,'09','Responsavel Pedido      ?','Responsavel Pedido      ?','Responsavel Pedido      ?','mv_ch9','C',30,0,0,'G','NaoVazio   ','mv_par09','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ','','',''})
aAdd(aRegs,{cPerg,'10','Nome do Arquivo         ?','Nome do Arquivo         ?','Nome do Arquivo         ?','mv_cha','C',70,0,0,'G','NaoVazio   ','mv_par10','               ','','','','','             ','','','','','             ','','','','','              ','','','','','               ','','','','   ','','',''})

ValidPerg(aRegs,cPerg,.F.)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfCriaDBF  บAutor ณ JORGE SATO        บ Data ณ  28/02/2017  บฑฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cria DBF                                                   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Protheus 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿ */

Static Function fCriaDBF()

Local aCamp 	:= {}
Local cInd		:= ""

//Vale Transporte
//Arquivo Unidade de Entrega/Departamento VT
aadd(aCamp,{'TIPREG','C',5,0})
aadd(aCamp,{'CODIGO','C',8,0})
aadd(aCamp,{'TEXTO','C',310,0})

//Nome e Criacao do Arquivo
cArq := Criatrab(aCamp,.t.)

If Select("TMPT") > 0
	DbSelectArea("TMPT")
	DbCloseArea("TMPT")
EndIf

//Abertura do Arquivo
dbUseArea(.t.,,cArq,'TMPT')
dbSelectArea('TMPT')

//Cria Indice Temporario
//Nome do Indice
cArqInd := CriaTrab(Nil,.F.)

cInd := "TIPREG + CODIGO"
//Criacao do Indice
IndRegua("TMPT",cArqInd,cInd,,,"Selecionando Registros")

Return

//Fim da Rotina
