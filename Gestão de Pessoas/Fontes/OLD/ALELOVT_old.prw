#include "rwmake.ch"
#INCLUDE "topconn.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "PROTHEUS.CH" 
#IFNDEF CRLF
#DEFINE CRLF ( chr(13)+chr(10) )
#ENDIF

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ALELOVT  บ Autor ณ  JORGE SATO        บ Data ณ  20/09/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Geracao de Arquivo Texto para Aquisicao do VT Pela ALELO   บฑฑ
ฑฑบ          ณ da Empresa MILANO COMERCIO VAREJISTA DE ALIMENTOS S.A.     บฑฑ
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


User Function ALELOVT()

//???????????????????????????????????????????????????????????????
//? Define as variaveis utilizadas na rotina                     ?
//????????????????????????????????????????????????????????????????
cCadastro := "Gera Arquivo Texto Vale Transporte- ALELO"
cPerg     := "ALELOVT   "
nOpca     := 0
nTotDet   := 0
nTotRec1  := 0
nTotRec2  := 0
nTotRec3  := 0
nTotRec4  := 0
nTotRec5  := 0
nSeq      := 0
Ret       := ""
aInfoE    := {}
cEndereco := ""
cNumero   := ""
aCamp     := {}
cArq      := ""

//Cria perguntas caso nใo exista
//fCriaSx1()


VerPerg( cPerg )

//???????????????????????????????????????????????????????????????
//? Carrega perguntas do programa                                ?
//????????????????????????????????????????????????????????????????

If !Pergunte(cPerg,.t.)
	Return
EndIf

cFilde    := mv_par01
cFilAte   := mv_par02
cCCde     := mv_par03
cCCate    := mv_par04
cMatDe    := mv_par05
cMatAte   := mv_par06
cSituacao := mv_par07
dDtRef    := mv_par08
cArqTxt   := mv_par09
cMesRef   := Subs(dTos(dDtRef),5,2)
cAnoRef   := Subs(dTos(dDtRef),1,4)
lImpLis   := If(mv_par10==1,.T.,.F.)
cRespon   := mv_par11
cNOmeArq  := cArqtxt


//Deleta Arquivo Temporario
If lImplis
	If File(cArq + '.DBF')
		dbSelectArea('TMP')
		dbCloseArea()
		fErase(cArq + '.DBF')
		FErase (cArqInd+OrdBagExt())
	Endif
Endif


If lImpLis
	//Criacao do Array
	aadd(aCamp,{'TP','C',2,0})
	aadd(aCamp,{'FIL','C',4,0})
	aadd(aCamp,{'CC','C',9,0})
	aadd(aCamp,{'MAT','C',6,0})
	aadd(aCamp,{'CAMPO','C',70,0})
	
	//Nome e Criacao do Arquivo
	cArq := Criatrab(aCamp,.t.)
	
	//Abertura do Arquivo
	dbUseArea(.t.,,cArq,'TMP')
	dbSelectArea('TMP')
	
Endif

//??????????????????????????????????????????????????????????????????????
//? Montagem da tela de processamento.                                  ?
//???????????????????????????????????????????????????????????????????????

@ 200,001 TO 410,480 DIALOG oDlg2 TITLE OemToAnsi( cCadastro )
@ 002,010 TO 095,230
@ 010,018 Say " Este programa ira gerar o Arquivo Texto para compra de Vale   "
@ 018,018 Say " Transporte da ALELO, AGUARDE UNS MINUTOS.....                 "
@ 026,018 Say " SELECIONANDO OS DADOS .........                               "

@ 70,128 BMPBUTTON TYPE 05 ACTION Pergunte(cPerg,.T.)
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oDlg2)
@ 70,188 BMPBUTTON TYPE 01 ACTION ProcTxT()

ACTIVATE DIALOG oDlg2 CENTERED


Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ProcTxt  บ Autor ณ  JORGE SATO        บ Data ณ  20/09/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Geracao de Arquivo Texto para Aquisicao do VT Pela ALELO   บฑฑ
ฑฑบ          ณ da Empresa MILANO COMERCIO VAREJISTA DE ALIMENTOS S.A.     บฑฑ
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


Static Function ProcTxt()

Close(oDlg2)


GERAVTX()
//Imprime Listagem
If lImpLis
	fImpLis()
End

//Deleta Arquivo Temporario
If lImplis
	If File(cArq + '.DBF')
		dbSelectArea('TMP')
		dbCloseArea()
		fErase(cArq + '.DBF')
		FErase (cArqInd+OrdBagExt())
	Endif
Endif


Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ GERAVTX  บ Autor ณ  JORGE SATO        บ Data ณ  20/09/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Checa a movimentacao para gerar o Arquivo                  บฑฑ
ฑฑบ          ณ da Empresa MILANO COMERCIO VAREJISTA DE ALIMENTOS S.A.     บฑฑ
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

Static Function GERAVTX()

Local cNomArq := Alltrim(mv_par09)
Local cCodFil := " "
Local cCodFun := " " 
Local cCodFian := " "
Local cCodFuan := " "
Local c_ret   := " "
Private cCNPJPr := ""
Private nSeqFil := 0

If File( cNomArq )
	If MsgYesNo("O arquivo ja Existe Deseja Substituir")
		nHdlArq := MsFCreate( cNomArq,0)
	Else
		Return
	EndIf
Else
	nHdlArq := MsFCreate(cNomArq,0)
EndIf

//carrega informa?oes da filial

cFilBus := "0045"
fLocalInfo(cFilBus)
cCNPJPr := aInfoE[09]

//????????????????????????????
//?Gerando o Registro Header  ?
//?????????????????????????????

fGeraTipo0()
nTotDet++

//??????????????????????????????????????
//?Gerando o Registro Enderecos         ?
//???????????????????????????????????????

c_ret := "SELECT DISTINCT SRA.RA_FILIAL" + CRLF
c_ret += " FROM " + retsqlname("SRA") + " SRA INNER JOIN " + retsqlname("SR0") + " SR0 ON (R0_FILIAL = RA_FILIAL AND R0_MAT = RA_MAT)" + CRLF
c_ret += " WHERE SRA.D_E_L_E_T_ <> '*' AND SR0.D_E_L_E_T_ <> '*'" + CRLF
c_ret += " AND SRA.RA_FILIAL BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' AND SRA.RA_MAT BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"'" + CRLF
c_ret += " AND SR0.R0_VALCAL > 0 AND SR0.R0_TPVALE = 0 AND SR0.R0_QDIAINF > 0 AND SRA.RA_SITFOLH <> 'D'" + CRLF
c_ret += " ORDER BY SRA.RA_FILIAL" + CRLF

If Select("TRB") > 0
	DbSelectArea("TRB")
	DbCloseArea()
Endif

TCQUERY c_ret NEW ALIAS "TRB"

dbselectarea("TRB")
TRB->(dbgotop())

while TRB->(!eof())
	
	IF cCodFil <> TRB->RA_FILIAL
		cFilBus := TRB->RA_FILIAL
		fLocalInfo(cFilBus)
		nSeqFil += 1
		fGeraTipo1()
		nTotDet++
		nTotRec1++
	ENDIF
	DbSelectArea("TRB")
	DbSkip()
EndDo
TRB->(dbclosearea())
nSeqFil := 0
cCodFil := " "

//??????????????????????????????????????
//?Gerando registro de usuarios         ?
//???????????????????????????????????????

DbSelectArea("SR0")
DbSetOrder(1)
DbSeek(xFilial("SR0"),.T.)

//ProcRegua( RecCount("SR0"))

While SR0->(!Eof())
	
	
	//	IncProc( "Processando o Funcionario: "+SR0->R0_FILIAL + "  " +SR0->R0_MAT)
	
	If SR0->R0_QDIAINF = 0                            //(SR0->R0_QDiaCal/SR0->R0_QDiaInf) = 0
		SR0->(DbSkip())
		Loop
	EndIf

	If SR0->R0_VALCAL <= 0                            //(SR0->R0_QDiaCal/SR0->R0_QDiaInf) = 0
		SR0->(DbSkip())
		Loop
	EndIf
	
	IF SR0->R0_TPVALE <> '0'
		SR0->(DbSkip())
		Loop
	EndIf
	
	SRA->(DBSeek(SR0->R0_FILIAL + SR0->R0_MAT))
	
	//??????????????????????????????????????????????????
	//?Filtra conforme informacoes no Parametro MV      ?
	//???????????????????????????????????????????????????
	
	If SRA->RA_FILIAL < cFilDe .or. SRA->RA_FILIAL > cFilAte .or. SRA->RA_CC < cCCDe .or. SRA->RA_CC > cCCAte .or.;
		SRA->RA_MAT < cMatDe .or. SRA->RA_MAT > cMatAte .or. !(SRA->RA_SITFOLH $ cSituacao)
		SR0->(DbSkip())
		dbSelectArea("SRA")
		Loop
	EndIf
	
	//?????????????????????????????????
	//?Gerando o Registro Funcionarios ?
	//??????????????????????????????????
	
	cFilBus := SR0->R0_FILIAL
	fLocalInfo(cFilBus)
	
	IF cCodFil <> SR0->R0_FILIAL
		nSeqFil += 1
	ENDIF
	
	cBuffer := "2"
	cBuffer += Substr(cCNPJPr,1,14)
	cBuffer += StrZero(nSeqFil,3)                 //"001"
	cBuffer += StrZero(Val(SR0->R0_FILIAL+SR0->R0_MAT),15)   //Numero Matricula
	cBuffer += Padr(SRA->RA_NOMECMP,50)  // NOME
	cBuffer += SRA->RA_CIC                    //cpf
	cBuffer += fGerZero(11,SUBSTR(FwNoAccent(SRA->RA_RG),1,11))     //RG
	cBuffer += SUBSTR(SRA->RA_RGUF,1,2)                           //Est.Emissor RG
	cBuffer += GravaData(Sra->Ra_Nasc,.F.,5)            //Nascimento
	cBuffer += Padr(Posicione("CTT",1,xFilial("CTT")+Sra->Ra_CC,"CTT_DESC01"),45)      //Departamento
	SRJ->(DBSeek(xFilial("SRJ") + SRA->RA_CODFUNC))
	cBuffer += Padr(SRJ->RJ_DESC,45)                  //Cargo
	cBuffer += StrZero(Sr0->R0_QDiaCal/Sr0->R0_QDiaInf,3)
	cBuffer += Space(26)
	cBuffer += Strzero(nSeq += 1,6) + Chr(13) + Chr(10) //sequencia
	
	Fwrite(nHdlArq,UPPER(cBuffer))
	nTotDet++
	nTotRec2 ++
	
	cCodFil := SR0->R0_FILIAL
	cCodFun := SR0->R0_MAT
	
	While  SR0->(!Eof()) .And. (SR0->R0_FILIAL == cCodFil .AND. SR0->R0_MAT == cCodFun .AND. SR0->R0_TPVALE == '0' .AND. SR0->R0_QDIAINF > 0 )
		
		cCodFian := SR0->R0_FILIAL
		cCodFuan := SR0->R0_MAT		
		//		cTipoBen := Posicione("RFP",1,xFilial("RFP")+"0"+SR0->R0_CODIGO,"RFP_TKCDOP")
		cTipoBen := Posicione("RFP",1,xFilial("RFP")+"0"+SR0->R0_CODIGO,"RFP_TKTPBL")
		cCodBen	 := Posicione("SRN",1,xFilial("SRN")+SR0->R0_CODIGO,"RN_COD")
		cDescBen := Posicione("SRN",1,xFilial("SRN")+SR0->R0_CODIGO,"RN_DESC")
		If cTipoBen <> " "
			
			
			//??????????????????????????????????????????
			//?Gerando o Registro Itens de Funcionarios ?
			//???????????????????????????????????????????
			
			cBuffer := "3"
			cBuffer += Substr(cCNPJPr,1,14)       //cgc
			cBuffer += StrZero(Val(SR0->R0_FILIAL+SR0->R0_MAT),15)   //Numero Matricula
			cBuffer += StrZero(Val(Posicione("RFP",1,xFilial("RFP")+"0"+SR0->R0_CODIGO,"RFP_TKTPBL")),6)
			cBuffer += Padr(cDescBen,50)
			cBuffer += StrZero(Posicione("SRN",1,xFilial("SRN")+SR0->R0_CODIGO,"RN_VUNIATU")*100,12)
			cBuffer += Strzero(SR0->R0_QDIAINF,3)
			cBuffer += Space(25)                      //numero cartao
			cBuffer += Space(108)                     //brancos
			cBuffer += Strzero(nSeq += 1,6) + Chr(13) + Chr(10)
			
			Fwrite(nHdlArq,UPPER(cBuffer))
			nTotDet++
			nTotRec3 ++
			cTipoBen := ""
			
			If lImpLis
				If RecLock("TMP",.T.)
					TMP->TP		:= 	"VT"
					TMP->FIL	:= SR0->R0_FILIAL
					TMP->CC		:= SR0->R0_CC
					TMP->MAT	:= SR0->R0_MAT
					TMP->CAMPO	:= SRA->RA_NOME + StrZero(SR0->R0_QDIAINF,2) + Padr(Posicione("SRN",1,xFilial("SRN")+SR0->R0_CODIGO,"RN_DESC"),30)+ StrZero(Val(Posicione("RFP",1,xFilial("RFP")+"0"+SR0->R0_CODIGO,"RFP_TKTPBL")),6)
				Endif
			Endif 
			cCodFil := SR0->R0_FILIAL
			cCodFun := SR0->R0_MAT			
		Endif

		DbSelectArea("SR0")
		DbSkip()

	Enddo
	//??????????????????????????????????????????
	//?Gerando o Registro de enderecos          ?
	//???????????????????????????????????????????
	
	cBuffer := "4"
	cBuffer += Substr(cCNPJPr,1,14)       //cgc
	cBuffer += StrZero(Val(SRA->RA_FILIAL+SRA->RA_MAT),15)   //FILIAL + Numero Matricula
	cBuffer += Padr(Alltrim(SRA->RA_ENDEREC),50)  //endereco
	cBuffer += Padr(SRA->RA_LOGRNUM,15) //numero
	cBuffer += Padr(SRA->RA_COMPLEM,20) //complem
	cBuffer += Padr(SRA->RA_BAIRRO,35) //bairro
	cBuffer += StrZero(Val(SRA->RA_CEP),8)                    //CEP
	cBuffer += Padr(SRA->RA_MUNICIP,30)                     //cidade
	cBuffer += If(Empty(SRA->RA_ESTADO),"SP",SRA->RA_ESTADO)
	cBuffer += "N"
	cBuffer += SPACE(12)
	cBuffer += Space(31)
	cBuffer += Strzero(nSeq += 1,6) + Chr(13) + Chr(10)
	
	Fwrite(nHdlArq,UPPER(cBuffer))
	nTotDet++
	nTotRec4 ++
	
	
	//??????????????????????????????????????????
	//?Gerando o Registro de dados              ?
	//???????????????????????????????????????????
	cBuffer := "5"
	cBuffer += Substr(cCNPJPr,1,14)       //cgc
	cBuffer += StrZero(Val(SRA->RA_FILIAL+SRA->RA_MAT),15)   //Numero Matricula
	cBuffer += Padr(SRA->RA_MAE,50) //mae
	cBuffer += Space(154)
	cBuffer += Strzero(nSeq += 1,6) + Chr(13) + Chr(10)
	
	Fwrite(nHdlArq,UPPER(cBuffer))
	nTotDet++
	nTotRec5 ++
	
	IF cCodFian <> cCodFil .AND. cCodFuan <> cCodFun	
		DbSelectArea("SR0")
		DbSkip(-1) 
	EndIf	 	
Enddo

//??????????????????????????
//?Faz o Trailler do Arquivo?
//???????????????????????????

cBuffer := "9"
cBuffer += StrZero(nTotRec1,6) // Qtde Total de Registro Tipo 1
cBuffer += StrZero(nTotRec2,6) // Qtde Total de Registro Tipo 2
cBuffer += StrZero(nTotRec3,6) // Qtde Total de Registro Tipo 3
cBuffer += StrZero(nTotRec4,6) // Qtde Total de Registro Tipo 4
cBuffer += StrZero(nTotRec5,6) // Qtde Total de Registro Tipo 5
cBuffer += Space(203)
cBuffer += Strzero(nSeq += 1,6) + Chr(13) + Chr(10)

Fwrite(nHdlArq,cBuffer)

//??????????????????????
//?Fecha o Arquivo Texto?
//???????????????????????
Fclose( nHdlArq )

#IFDEF WINDOWS
	Alert ("Criacao do arquivo VT ALELO finalizada !!!")
#ELSE
	Alert("Criacao do arquivo VT ALELO finalizada !!!")
#ENDIF

Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fGeraTipo0  บ Autor ณ  JORGE SATO     บ Data ณ  20/09/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Gerar o Arquivo TIPO 0                                     บฑฑ
ฑฑบ          ณ da Empresa MILANO COMERCIO VAREJISTA DE ALIMENTOS S.A.     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
*/

Static Function fGeraTipo0()

cTipo         := '0'
cDtArq        := AllTrim(StrZero(Day(dDataBase),2)) + AllTrim(StrZero(Month(dDataBase),2)) + AllTrim(Str(Year(dDataBase)))
cEmp          := Substr(aInfoE[2] + Space(40),1,50)

cLin := cTipo + cDtArq  + aInfoE[09]  + cEmp + Space(157) + "0400000001"  +  CRLF

nSeq += 1

fGravaReg()


Return

// Fim da Rotina

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fGeraTipo1  บ Autor ณ  JORGE SATO     บ Data ณ  20/09/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Gera linha com Registro Tipo "1"                           บฑฑ
ฑฑบ          ณ da Empresa MILANO COMERCIO VAREJISTA DE ALIMENTOS S.A.     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
*/

Static Function fGeraTipo1()



cTipo   := '1'

cLin    := cTipo +	Substr(cCNPJPr,1,14) + StrZero(nSeqFil,3) + fGerStr(50,aInfoE[03]) + fGerStr(15,aInfoE[11])
cLin    += fGerStr(20,aInfoE[08]) + fGerStr(35,aInfoE[07]) + aInfoE[06] + fGerStr(32,(aInfoE[04] + aInfoE[05]))
cLin    += cRespon + Space(11) + StrZero(nSeq+1,6) + CRLF

fGravaReg()


nSeq += 1

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fGravaReg   บ Autor ณ  JORGE SATO     บ Data ณ  20/09/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Grava Registros no Arquivo Texto                           บฑฑ
ฑฑบ          ณ da Empresa MILANO COMERCIO VAREJISTA DE ALIMENTOS S.A.     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
*/

Static Function fGravaReg()

If fWrite(nHdlArq,cLin,Len(cLin)) != Len(cLin)
	If !MsgYesNo('Ocorreu um erro na gravacao do arquivo '+AllTrim(cNomeArq)+'.   Continua?','Atencao!')
		lContinua := .F.
		Return
	Endif
Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fImpLis     บ Autor ณ  JORGE SATO     บ Data ณ  20/09/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Imprime Listagem do Pedido                                 บฑฑ
ฑฑบ          ณ da Empresa MILANO COMERCIO VAREJISTA DE ALIMENTOS S.A.     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
*/

Static Function fImpLis()

cString  := 'SRA' // Alias do Arquivo Principal
aOrd     := {"Matricula","Centro de Custo"}
aReturn  := { 'Especial', 1,'Administra??o', 1, 2, 2,'',1 }
nTamanho := 'P'
Titulo   := 'LISTAGEM DE BENEFICIOS DO ALELO VT'
cDesc1   := 'Emissao de Relatorio de Vale Transporte - ALELO '
cDesc2   := 'Sera impresso de acordo com os parametros solicitados '
cDesc3   := 'pelo usuario.'
cPerg    := ''
cCancel  := '*** ABORTADO PELO OPERADOR ***'
wCabec1	 := ' Matr.            Nome                Quant.    Descricao do     Codigo'
wCabec2  := '	                            Diaria    Beneficio        V.Vale'
NomeProg := 'ALELOVT'
cArqInd  := ''
cInd	 := ''
cCcAnt	 := ''
cCcDesc	 := ''
nLastKey := 0
m_pag    := 0
li       := 0
ContFl   := 1
nOrdem	 := 0
nTfunc   := 0
nTccFunc := 0
nTBen    := 0
nTccBen  := 0
nTgfunc  := 0
nTgBen   := 0
lEnd     := .F.
wnrel    := 'ALELOVT'


//???????????????????????????????????????????????????????????????
//? Envia controle para a funcao SETPRINT                        ?
//????????????????????????????????????????????????????????????????

wnrel := SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,nTamanho)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

// Inicio do Arquivo Temporario
dbSelectArea('TMP')
TMP->(dbGoTop())

nOrdem   := aReturn[8]

//Processa Selecao de Ordem
Processa({|lEnd| ContOrd()},"Ordenando Arquivo...")

//Processa Impressao
RptStatus({|lEnd| Nota()},'Imprimindo...')

Return


Static Function ContOrd()

//Cria Indice Temporario
//Nome do Indice
cArqInd := CriaTrab(Nil,.F.)

//Chave do Indice
If nOrdem == 1
	cInd := "FIL + MAT"
Else
	cInd := "FIL + CC + MAT"
Endif

//Criacao do Indice
IndRegua("TMP",cArqInd,cInd,,,"Selecionando Registros")

Return

//Fim da Rotina

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ Nota        บ Autor ณ  JORGE SATO     บ Data ณ  20/09/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Imprime Listagem do Pedido                                 บฑฑ
ฑฑบ          ณ da Empresa MILANO COMERCIO VAREJISTA DE ALIMENTOS S.A.     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
*/

Static Function Nota()

// Carrega Regua
SetRegua(TMP->(RecCount()))


While !TMP->(Eof())
	
	//Abortado Pelo Operador
	If lAbortPrint
		lEnd := .T.
	Endif
	
	If lEnd
		cDet := cCancel
		Impr(cDet,'C')
		Exit
	EndIF
	
	
	If (nOrdem == 2)
		
		cCcAnt  := TMP->CC
		cCcDesc := DescCC(cCcAnt)
		
		cDet := cCcAnt + ' - ' + cCcDesc
		Impr(cDet,'C')
		
	Endif
	
	While TMP->TP == 'VT' .And. !TMP->(Eof()) .And. !lEnd
		
		If (nOrdem == 2) .And. (cCcAnt != TMP->CC)
			
			cCcAnt  := TMP->CC
			cCcDesc := DescCC(cCcAnt)
			
			cDet := cCcAnt + ' - ' + cCcDesc
			Impr(cDet,'C')
			
		Endif
		
		//Abortado Pelo Operador
		If lAbortPrint
			lEnd := .T.
		Endif
		
		If lEnd
			cDet := cCancel
			Impr(cDet,'C')
			Exit
		EndIF
		
		cDet := TMP->MAT + "  "  +  Subst(TMP->CAMPO,1,30) + "  " + Subst(TMP->CAMPO,31,2)
		cDet += "     " + Subst(TMP->CAMPO,33,15)+ "   "+ Subst(TMP->CAMPO,63)
		Impr(cDet,'C')
		
		TMP->(dbSkip())
		
		If (nOrdem == 2) .And. (cCcAnt != TMP->CC)
			
			cDet := 'Totais do Centro de Custo - ' + cCcAnt + ' - '  + cCcDesc
			Impr(cDet,'C')
			
			cDet := 'Total Beneficio (R$): ' + Transform(nTccBen,'@E 999,999,999.99')
			Impr(cDet,'C')
			
			cDet := 'Total Funcionario: ' + Transform(nTccfunc,'@E 99999')
			Impr(cDet,'C')
			
			cDet := ''
			Impr(cDet,'C')
			
			
		Endif
		
		
		IncRegua('Imprimindo... ')
		
	Enddo
	
	cDet := ''
	Impr(cDet,'C')
	
	
Enddo

//Imprime Total Geral da Empresa
cDet := ''
Impr(cDet,'C')

cDet := Replic('*',80)
Impr(cDet,'C')

//cDet := 'Totais da Empresa '

cDet := ''
Impr(cDet,'F')

If aReturn[5] == 1
	Set Printer TO
	ourspool(wnrel)
Endif

MS_FLUSH()

Return

// Fim da Rotina

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ fLocalInfo  บ Autor ณ  JORGE SATO     บ Data ณ  20/09/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Inicializa o Array aInfo com informacoes do Local          บฑฑ
ฑฑบ          ณ da Empresa MILANO COMERCIO VAREJISTA DE ALIMENTOS S.A.     บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
*/


Static Function fLocalInfo(cFilBus)

Local nContador := 0

aInfoE := {}

// Armazena Registro Atual
nSM0Recno := SM0->(Recno())

SM0->(dbSeek(cEmpAnt + cFilBus,.T.))

nContador := At(",",SM0->M0_ENDENT)

Aadd(aInfoE,SM0->M0_NOME)              //1
Aadd(aInfoE,SM0->M0_NOMECOM)           //2
Aadd(aInfoE,(substr(SM0->M0_ENDENT,1, nContador - 1)))                 //3
Aadd(aInfoE,SM0->M0_CIDENT)            //4
Aadd(aInfoE,SM0->M0_ESTENT)            //5
Aadd(aInfoE,SM0->M0_CEPENT)            //6
Aadd(aInfoE,SM0->M0_BAIRENT)           //7
Aadd(aInfoE,SM0->M0_COMPENT)           //8
Aadd(aInfoE,SM0->M0_CGC)               //9
Aadd(aInfoE,SM0->M0_FILIAL)            //10
Aadd(aInfoE,alltrim(substr(SM0->M0_ENDENT, nContador + 1,8)))                  //11

// Retorna ao Registro
SM0->(dbGoto(nSM0Recno))

Return

// Fim da Rotina

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ VerPerg     บ Autor ณ  JORGE SATO     บ Data ณ  20/09/2017 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Verifica  as perguntas, Incluindo-as caso nao existam      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ PROTHEUS 12                                                บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
*/


Static Function VerPerg()

Local cPerg := "ALELOVT   "
Local aregs		:= {}
Local i, j		:= 0
Local cArea := getarea()

//          Grupo/Ordem    /Pergunta//                   /Var	/Tipo/Tam/Dec/Pres/GSC/Valid/ Var01      /Def01    /DefSpa01    /DefIng1      /Cnt01/Var02    /Def02   /DefSpa2     /DefIng2           /Cnt02   /Var03 /Def03   /DefSpa3  /DefIng3  /Cnt03 /Var04   /Def04     /Cnt04    /Var05  /Def05	/Cnt05  /XF3
aadd(aregs, {cperg, "01", "Filial De				", "ฟDe sucursal ?           ", "From Branch ?            ", "mv_ch1", "C", tamsx3("RA_FILIAL")[1],		0, 0, "G", ""						, "mv_par01", ""  , ""  , ""  , "", ""	, ""	, ""  , ""  , "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "XM0"	, "S", "033", ".RHFILDE.", "", ""})
aadd(aregs, {cperg, "02", "Filial At้           	", "ฟA Sucursal ?         	 ", "To Branch ?              ", "mv_ch2", "C", tamsx3("RA_FILIAL")[1],		0, 0, "G", "naovazio()"				, "mv_par02", ""  , ""  , ""  , "", ""	, ""	, ""  , ""  , "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "XM0"	, "S", "033", ".RHFILAT.", "", ""})
aadd(aregs, {cperg, "03", "Centro de Custo De   	", "ฟDe Centro de Costo ?    ", "From Cost Center ?       ", "mv_ch3", "C", tamsx3("RA_CC")[1], 		0, 0, "G", ""						, "mv_par03", ""  , ""  , ""  , "", ""	, ""	, ""  , ""  , "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "CTT"	, "S", "004", ".RHCCDE." , "", ""})
aadd(aregs, {cperg, "04", "Centro de Custo At้		", "ฟA Centro de Costo ?     ", "To Cost Center ?         ", "mv_ch4", "C", tamsx3("RA_CC")[1], 		0, 0, "G", "naovazio()"				, "mv_par04", ""  , ""  , ""  , "", ""	, ""	, ""  , ""  , "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "CTT"	, "S", "004", ".RHCCAT." , "", ""})
aadd(aregs, {cperg, "05", "Matricula De        		", "ฟDe Matricula ?          ", "From Registration ?      ", "mv_ch5", "C", tamsx3("RA_MAT")[1],		0, 0, "G", ""						, "mv_par05", ""  , ""  , ""  , "", ""	, ""	, ""  , ""  , "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "SRA"	, "S", ""	, ".RHMATD." , "", ""})
aadd(aregs, {cperg, "06", "Matricula At้       		", "ฟA Matricula ?           ", "To Registration ?        ", "mv_ch6", "C", tamsx3("RA_MAT")[1],		0, 0, "G", "naovazio()"				, "mv_par06", ""  , ""  , ""  , "", ""	, ""	, ""  , ""  , "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "SRA"	, "S", ""	, ".RHMATA." , "", ""})
aadd(aregs, {cperg, "07", "Situa็๕es	      		", "Situa็๕es	             ", "Situa็๕es 			      ", "mv_ch7", "C", 5,                 	     	0, 0, "G", "fSituacao"				, "mv_par07", ""  , ""  , ""  , "", ""	, ""	, ""  , ""  , "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""	, "S", ""	, ".RHSITUA.", "", ""})
aAdd(aRegs, {cPerg, "08", "Data de Referencia ?     ", "Data de Referencia ?     ", "Data de Referencia ?     ", "mv_ch8", "D", 8,                          0, 0, "G", "naovazio()"             , "mv_par08", ""  , ""  , ""  , "", ""  , ""    , ""  , ""  , "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""    , "S", ""	, ""         , "", ""})
aadd(aregs, {cperg, "09", "Diret๓rio e Nome Arquivo?", "Diret๓rio e Nome Arquivo?", "Diret๓rio e Nome Arquivo?", "mv_ch9", "C", 45,                         0, 0, "G", "naovazio()"             , "mv_par09", ""  , ""  , ""  , "", ""	, ""	, ""  , ""  , "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""	, "S", ""	, ""         , "", ""})
aAdd(aRegs, {cPerg, "10", "Imprime Listagem   ?     ", "Imprime Listagem   ?     ", "Imprime Listagem   ?     ", "mv_cha", "N", 1,                          0, 0, "C", ""                       , "mv_par10","Sim","Sim","Sim", "", ""  ,"Nao"  ,"Nao","Nao", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""    , "S", ""	, "DIR"      , "", ""})
aadd(aregs, {cperg, "11", "Responsavel Depart.?     ", "Responsavel Depart.?     ", "Responsavel Depart.?     ", "mv_chb", "C", 45,                         0, 0, "G", "naovazio()"             , "mv_par11", ""  , ""  , ""  , "", ""	, ""	, ""  , ""  , "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""	, "S", ""	, ""         , "", ""})

dbselectarea("sx1")
sx1->( dbsetorder(1))

if !sx1->(dbseek(cperg))
	for i := 1 to len(aregs)
		if	!sx1->(dbseek(cperg + aregs[i, 2]))
			reclock("sx1", .t.)
			for j := 1 to fcount()
				fieldput(j, aregs[i, j])
			next
			msunlock("sx1")
		endif
	next
endif

restarea(cArea)
Return

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


Static Function fGerZero(nNum,cVaria)

Local cVar

cVar := Replic("0",nNum) + AllTrim(cVaria)

cVar := Right(cVar,nNum)

Return(cVar)
