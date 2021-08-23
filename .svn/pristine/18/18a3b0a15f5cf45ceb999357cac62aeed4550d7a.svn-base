#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RCOMR01   ºAutor  ³ Douglas Silva      º Data ³ 29/10/2019  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressão de cadastro de funcionários em TReport.          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio Di Latte - RVacari                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function BDRHREL01()

Private oReport  := Nil
Private oSecCab	 := Nil
Private cPerg 	 := PadR ("BDRHREL01", Len (SX1->X1_GRUPO))

ReportDef()
oReport:PrintDialog()

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RCOMR01   ºAutor  ³ Douglas Silva      º Data ³ 29/10/2019  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressão de cadastro de funcionários em TReport.          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio Di Latte - RVacari                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportDef()

oReport := TReport():New("BDRHREL01","Cadastro de Funcionários",cPerg,{|oReport| PrintReport(oReport)},"Impressão de cadastro de funcionários.")
oReport:SetLandscape(.T.)

oSecCab := 	TRSection():New( oReport , "Funcionários"	,{"QRY"} )
			TRCell():New( oSecCab, "RA_FILIAL"     		,"QRY", 'FILIAL'	,PesqPict('SRA',"RA_FILIAL") )
			TRCell():New( oSecCab, "RA_CC"    			,"QRY", 'C.C'		,PesqPict('SRA',"RA_CC") )
			TRCell():New( oSecCab, "CTT_DESC01"    		,"QRY", 'DESC C.C'	,PesqPict('CTT',"CTT_DESC01") )
			TRCell():New( oSecCab, "RA_MAT"      		,"QRY", 'MATRICULA'	,PesqPict('SRA',"RA_MAT") )
			TRCell():New( oSecCab, "RA_NOME"      		,"QRY", 'NOME'		,PesqPict('SRA',"RA_NOME") )
			TRCell():New( oSecCab, "RA_RG"      		,"QRY", 'RG'		,PesqPict('SRA',"RA_RG") )
			TRCell():New( oSecCab, "RA_CIC"      		,"QRY", 'CPF'		,PesqPict('SRA',"RA_CIC") )
			TRCell():New( oSecCab, "RA_ADMISSA"    		,"QRY", 'ADMISSÃO'	,PesqPict('SRA',"RA_ADMISSA") )
			TRCell():New( oSecCab, "X5_DESCRI"    		,"QRY", 'GRAU ESCOL',PesqPict('SRA',"RA_NOME") )
			TRCell():New( oSecCab, "RA_EMAIL"    		,"QRY", 'E-MAIL'	,PesqPict('SRA',"RA_EMAIL") )
			TRCell():New( oSecCab, "RJ_DESC"    		,"QRY", 'FUNÇÃO'	,PesqPict('SRJ',"RJ_DESC") )
			
//TRFunction():New(/*Cell*/             ,/*cId*/,/*Function*/,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,/*lEndSection*/,/*lEndReport*/,/*lEndPage*/,/*Section*/)
TRFunction():New(oSecCab:Cell("RA_FILIAL"),/*cId*/,"COUNT"     ,/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.F.           ,.T.           ,.F.        ,oSecCab)

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³RCOMR01   ºAutor  ³ Douglas Silva      º Data ³ 29/10/2019  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressão de cadastro de funcionários em TReport.          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio Di Latte - RVacari                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function PrintReport(oReport)

Local cQuery     := ""

//Pergunte(cPerg,.F.)

cQuery := " SELECT " + CRLF
cQuery += " 	SRA.RA_FILIAL, " + CRLF
cQuery += " 	SRA.RA_CC, " + CRLF
cQuery += " 	CTT.CTT_DESC01, " + CRLF
cQuery += " 	SRA.RA_MAT, " + CRLF
cQuery += " 	SRA.RA_NOME, " + CRLF
cQuery += " 	SRA.RA_RG, " + CRLF
cQuery += " 	SRA.RA_CIC, " + CRLF
cQuery += " 	SRA.RA_ADMISSA, " + CRLF
cQuery += " 	SX5.X5_DESCRI, " + CRLF
cQuery += " 	SRA.RA_EMAIL, " + CRLF
cQuery += " 	SRJ.RJ_DESC " + CRLF
cQuery += " FROM " + RetSqlName("SRA") + " SRA " + CRLF
cQuery += " LEFT JOIN " + RetSqlName("CTT") + " CTT ON CTT.CTT_FILIAL = '' AND CTT_CUSTO = SRA.RA_CC AND CTT.D_E_L_E_T_ != '*' " + CRLF
cQuery += " LEFT JOIN " + RetSqlName("SRJ") + " SRJ ON SRJ.RJ_FILIAL = '' AND SRJ.RJ_FUNCAO = SRA.RA_CODFUNC AND SRJ.D_E_L_E_T_ != '*' " + CRLF
cQuery += " LEFT JOIN " + RetSqlName("SX5") + " SX5 ON SX5.X5_FILIAL = '' AND SX5.X5_TABELA = '26' AND SX5.X5_CHAVE = SRA.RA_GRINRAI " + CRLF
cQuery += " WHERE " + CRLF 
cQuery += " 	SRA.RA_FILIAL BETWEEN '' AND '9999'	 " + CRLF
cQuery += " 	AND SRA.D_E_L_E_T_ != '*' " + CRLF
cQuery += " 	AND RA_SITFOLH != 'D' " + CRLF

cQuery := ChangeQuery(cQuery)

If Select("QRY") > 0
	Dbselectarea("QRY")
	QRY->(DbClosearea())
EndIf

TcQuery cQuery New Alias "QRY"

TcSetField("QRY","RA_ADMISSA", TamSx3("RA_ADMISSA")[3], TamSx3("RA_ADMISSA")[1], TamSx3("RA_ADMISSA")[2]) //Decimais

oSecCab:BeginQuery()
oSecCab:EndQuery({{"QRY"},cQuery})
oSecCab:Print()

Return Nil