#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BDLML005  ºAutor  ³ Douglas Silva      º Data ³ 20/12/2019  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressão de relatório Livros Fiscais - SFT                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio Di Latte - RVacari                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function BDLML005()

	Local oReport := nil
	Local aParamBox	:= {}
	Local cPerg:= Padr("BDLML005",10)
	Private aRet		:= {}
			
	//gero a pergunta de modo oculto, ficando disponível no botão ações relacionadas
	Pergunte(cPerg,.F.)	          
		
	//Parametros para gerar query de dados
	aAdd(aParamBox,{1,"Emissão De" ,Ctod(Space(8)),"","","","",50,.F.}) 
	aAdd(aParamBox,{1,"Emissão Ate",Ctod(Space(8)),"","","","",50,.F.})
	aAdd(aParamBox,{1,"Filial De"	,Space(4),"","","SM0","",50,.F.})  
	aAdd(aParamBox,{1,"Filial Ate"	,Space(4),"","","SM0","",50,.F.})
	aAdd(aParamBox,{1,"Estado De"	,Space(2),"","","12","",50,.F.})	
	aAdd(aParamBox,{1,"Estado Ate"	,Space(2),"","","12","",50,.F.})
			
	If ParamBox(aParamBox ,"Parametros ",aRet)	
		oReport := RptDef(cPerg)
		oReport:PrintDialog()
	Else
		Alert("Ação cancelada! ")
	EndIf
			
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BDLML005  ºAutor  ³ Douglas Silva      º Data ³ 20/12/2019  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressão de relatório Livros Fiscais - SFT                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio Di Latte - RVacari                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function RptDef(cNome)
	
	Local oReport := Nil
	Local oSection1:= Nil
	
	/*Sintaxe: TReport():New(cNome,cTitulo,cPerguntas,bBlocoCodigo,cDescricao)*/
	oReport := TReport():New("BDLML005","Livros Fiscais SFT","BDLML005",{|oReport| ReportPrint(oReport)},"Livros Fiscais SFT")
	oReport:SetPortrait()    
	oReport:SetTotalInLine(.F.)
	
	oSection1:=		TRSection():New( oReport , "Livros Fiscais SFT"	,{"TMP"}, , .F., .T. )					
					
					TRCell():New( oSection1, "FT_FILIAL"	,"TMP", 'FILIAL'	,PesqPict('SFT',"F2_FILIAL") )
					TRCell():New( oSection1, "FT_TIPOMOV"	,"TMP", 'TIPOMOV'	,PesqPict('SFT',"FT_TIPOMOV") )
					TRCell():New( oSection1, "FT_ESTADO"	,"TMP", 'ESTADO'	,PesqPict('SFT',"FT_ESTADO") )
					TRCell():New( oSection1, "FT_ENTRADA"	,"TMP", 'ENTRADA'	,PesqPict('SFT',"FT_ENTRADA") )
					TRCell():New( oSection1, "FT_EMISSAO"	,"TMP", 'EMISSAO'	,PesqPict('SFT',"FT_EMISSAO") )
					TRCell():New( oSection1, "FT_DTCANC"	,"TMP", 'DTCANC'	,PesqPict('SFT',"FT_DTCANC") )
					TRCell():New( oSection1,"FT_ESPECIE"	,"TMP", 'ESPECIE'	,PesqPict('SFT',"FT_ESPECIE") )
					TRCell():New( oSection1,"FT_NFISCAL"	,"TMP", 'NFISCAL'	,PesqPict('SFT',"FT_NFISCAL") )
					TRCell():New( oSection1,"FT_SERIE"		,"TMP", 'SERIE'		,PesqPict('SFT',"FT_SERIE") )
					TRCell():New( oSection1,"FT_SERSAT"		,"TMP", 'SERSAT'	,PesqPict('SFT',"FT_SERSAT") )
					TRCell():New( oSection1,"FT_CLIEFOR"	,"TMP", 'CLIEFOR'	,PesqPict('SFT',"FT_CLIEFOR") )
					TRCell():New( oSection1,"FT_LOJA"		,"TMP", 'LOJA'		,PesqPict('SFT',"FT_LOJA") )
					TRCell():New( oSection1,"FT_NOME"		,"TMP", 'NOME'		,PesqPict('SA1',"A1_NOME") )
					TRCell():New( oSection1,"FT_NREDUZ"		,"TMP", 'NREDUZ'	,PesqPict('SA1',"A1_NREDUZ") )
					TRCell():New( oSection1,"FT_CNPJ"		,"TMP", 'CNPJ'		,PesqPict('SA1',"A1_CGC") )
					TRCell():New( oSection1,"FT_EST"		,"TMP", 'EST'		,PesqPict('SA1',"A1_EST") )
					TRCell():New( oSection1,"FT_PRODUTO"	,"TMP", 'PRODUTO'	,PesqPict('SFT',"FT_PRODUTO") )
					TRCell():New( oSection1,"B1_DESC"		,"TMP", 'DESC'		,PesqPict('SB1',"B1_DESC") )
					TRCell():New( oSection1,"B1_UM"			,"TMP", 'UM'		,PesqPict('SB1',"B1_UM") )
					TRCell():New( oSection1,"B1_TIPO"		,"TMP", 'TIPO'		,PesqPict('SB1',"B1_TIPO") )
					TRCell():New( oSection1,"B1_POSIPI"		,"TMP", 'POSIPI'	,PesqPict('SB1',"B1_POSIPI") )
					TRCell():New( oSection1,"FT_TES"		,"TMP", 'TES'		,PesqPict('SFT',"FT_TES") )
					TRCell():New( oSection1,"FT_CFOP"		,"TMP", 'CFOP'		,PesqPict('SFT',"FT_CFOP") )
					TRCell():New( oSection1,"FT_CLASFIS"	,"TMP", 'CLASFIS'	,PesqPict('SFT',"FT_CLASFIS") )
					TRCell():New( oSection1,"FT_CSTPIS"		,"TMP", 'CSTPIS'	,PesqPict('SFT',"FT_CSTPIS") )
					TRCell():New( oSection1,"FT_CSTCOF"		,"TMP", 'CSTCOF'	,PesqPict('SFT',"FT_CSTCOF") )
					TRCell():New( oSection1,"FT_CODBCC"		,"TMP", 'CODBCC'	,PesqPict('SFT',"FT_CODBCC") )
					TRCell():New( oSection1,"FT_CEST"		,"TMP", 'CEST'		,PesqPict('SFT',"FT_CEST") )
					TRCell():New( oSection1,"FT_ESTOQUE"	,"TMP", 'ESTOQUE'	,PesqPict('SFT',"FT_ESTOQUE") )
					TRCell():New( oSection1,"FT_PRCUNIT"	,"TMP", 'PRCUNIT'	,PesqPict('SFT',"FT_PRCUNIT") )
					TRCell():New( oSection1,"FT_QUANT"		,"TMP", 'QUANT'		,PesqPict('SFT',"FT_QUANT") )
					TRCell():New( oSection1,"FT_VALCONT"	,"TMP", 'VALCONT'	,PesqPict('SFT',"FT_VALCONT") )
					TRCell():New( oSection1,"FT_DESCONT"	,"TMP", 'DESCONT'	,PesqPict('SFT',"FT_DESCONT") )
					TRCell():New( oSection1,"FT_ISENICM"	,"TMP", 'ISENICM'	,PesqPict('SFT',"FT_ISENICM") )
					TRCell():New( oSection1,"FT_OUTRICM"	,"TMP", 'OUTRICM'	,PesqPict('SFT',"FT_OUTRICM") )
					TRCell():New( oSection1,"FT_BASEICM"	,"TMP", 'BASEICM'	,PesqPict('SFT',"FT_BASEICM") )
					TRCell():New( oSection1,"FT_ALIQICM"	,"TMP", 'ALIQICM'	,PesqPict('SFT',"FT_ALIQICM") )
					TRCell():New( oSection1,"FT_VALICM"		,"TMP", 'VALICM'	,PesqPict('SFT',"FT_VALICM") )
					TRCell():New( oSection1,"FT_BASEIPI"	,"TMP", 'BASEIPI'	,PesqPict('SFT',"FT_BASEIPI") )
					TRCell():New( oSection1,"FT_ALIQIPI"	,"TMP", 'ALIQIPI'	,PesqPict('SFT',"FT_ALIQIPI") )
					TRCell():New( oSection1,"FT_VALIPI"		,"TMP", 'VALIPI'	,PesqPict('SFT',"FT_VALIPI") )
					TRCell():New( oSection1,"FT_BASEPIS"	,"TMP", 'BASEPIS'	,PesqPict('SFT',"FT_BASEPIS") )
					TRCell():New( oSection1,"FT_ALIQPIS"	,"TMP", 'ALIQPIS'	,PesqPict('SFT',"FT_ALIQPIS") )
					TRCell():New( oSection1,"FT_VALPIS"		,"TMP", 'VALPIS'	,PesqPict('SFT',"FT_VALPIS") )
					TRCell():New( oSection1,"FT_BASECOF"	,"TMP", 'BASECOF'	,PesqPict('SFT',"FT_BASECOF") )
					TRCell():New( oSection1,"FT_ALIQCOF"	,"TMP", 'ALIQCOF'	,PesqPict('SFT',"FT_ALIQCOF") )
					TRCell():New( oSection1,"FT_VALCOF"		,"TMP", 'VALCOF'	,PesqPict('SFT',"FT_VALCOF") )
					TRCell():New( oSection1,"FT_BASECSL"	,"TMP", 'BASECSL'	,PesqPict('SFT',"FT_BASECSL") )
					TRCell():New( oSection1,"FT_ALIQCSL"	,"TMP", 'ALIQCSL'	,PesqPict('SFT',"FT_ALIQCSL") )
					TRCell():New( oSection1,"FT_VALCSL"		,"TMP", 'VALCSL'	,PesqPict('SFT',"FT_VALCSL") )
					TRCell():New( oSection1,"FT_BASIMP5"	,"TMP", 'BASIMP5'	,PesqPict('SFT',"FT_BASIMP5") )
					TRCell():New( oSection1,"FT_ALQIMP5"	,"TMP", 'ALQIMP5'	,PesqPict('SFT',"FT_ALQIMP5") )
					TRCell():New( oSection1,"FT_VALIMP5"	,"TMP", 'VALIMP5'	,PesqPict('SFT',"FT_VALIMP5") )
					TRCell():New( oSection1,"FT_BASIMP6"	,"TMP", 'BASIMP6'	,PesqPict('SFT',"FT_BASIMP6") )
					TRCell():New( oSection1,"FT_ALQIMP6"	,"TMP", 'ALQIMP6'	,PesqPict('SFT',"FT_ALQIMP6") )
					TRCell():New( oSection1,"FT_VALIMP6"	,"TMP", 'VALIMP6'	,PesqPict('SFT',"FT_VALIMP6") )
					TRCell():New( oSection1,"FT_CHVNFE"		,"TMP", 'CHVNFE'	,PesqPict('SFT',"FT_CHVNFE") )
					
	oReport:SetTotalInLine(.F.)
       
    //Aqui, farei uma quebra  por seção
	oSection1:SetPageBreak(.T.)
	oSection1:SetTotalText(" ")
					
Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BDLML005  ºAutor  ³ Douglas Silva      º Data ³ 20/12/2019  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressão de relatório Livros Fiscais - SFT                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio Di Latte - RVacari                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrint(oReport)

Local cQuery     := ""
Local oSection1 := oReport:Section(1)

	cQuery := " SELECT " + CRLF  
	cQuery += " 	SFT.FT_FILIAL, " + CRLF 
	cQuery += " 	SFT.FT_TIPOMOV, " + CRLF 
	cQuery += " 	SFT.FT_ESTADO, " + CRLF 
	cQuery += " 	SFT.FT_ENTRADA, " + CRLF 
	cQuery += " 	SFT.FT_EMISSAO, " + CRLF 
	cQuery += " 	SFT.FT_DTCANC, " + CRLF 
	cQuery += " 	SFT.FT_ESPECIE, " + CRLF 
	cQuery += " 	SFT.FT_NFISCAL, " + CRLF 
	cQuery += " 	SFT.FT_SERIE, " + CRLF 
	cQuery += " 	SFT.FT_SERSAT, " + CRLF 
	cQuery += " 	SFT.FT_CLIEFOR, " + CRLF 
	cQuery += " 	SFT.FT_LOJA, " + CRLF 
	cQuery += " 	IIF( SFT.FT_TIPOMOV = 'S', SA1.A1_NOME, SA2.A2_NOME) AS FT_NOME, " + CRLF 
	cQuery += " 	IIF( SFT.FT_TIPOMOV = 'S', SA1.A1_NREDUZ, SA2.A2_NREDUZ) AS FT_NREDUZ, " + CRLF 
	cQuery += " 	IIF( SFT.FT_TIPOMOV = 'S', SA1.A1_CGC, SA2.A2_CGC) AS FT_CNPJ, " + CRLF 
	cQuery += " 	IIF( SFT.FT_TIPOMOV = 'S', SA1.A1_EST, SA2.A2_EST) AS FT_EST, " + CRLF 
	cQuery += " 	SFT.FT_PRODUTO, " + CRLF 
	cQuery += " 	SB1.B1_DESC, " + CRLF 
	cQuery += " 	SB1.B1_UM, " + CRLF 
	cQuery += " 	SB1.B1_TIPO, " + CRLF 
	cQuery += " 	SB1.B1_POSIPI, " + CRLF 
	cQuery += " 	SFT.FT_TES, " + CRLF 
	cQuery += " 	SFT.FT_CFOP, " + CRLF 
	cQuery += " 	SFT.FT_CODISS, " + CRLF 
	cQuery += " 	SFT.FT_CLASFIS, " + CRLF 
	cQuery += " 	SFT.FT_CSTPIS, " + CRLF 
	cQuery += " 	SFT.FT_CSTCOF, " + CRLF 
	cQuery += " 	SFT.FT_CODBCC, " + CRLF 
	cQuery += " 	SFT.FT_CEST, " + CRLF 
	cQuery += " 	SFT.FT_ESTOQUE, " + CRLF 
	cQuery += " 	SFT.FT_PRCUNIT, " + CRLF 
	cQuery += " 	SFT.FT_QUANT, " + CRLF 
	cQuery += " 	SFT.FT_VALCONT, " + CRLF 
	cQuery += " 	SFT.FT_DESCONT, " + CRLF 
	cQuery += " 	SFT.FT_ISENICM, " + CRLF 
	cQuery += " 	SFT.FT_OUTRICM, " + CRLF 
	cQuery += " 	SFT.FT_BASEICM, " + CRLF 
	cQuery += " 	SFT.FT_ALIQICM, " + CRLF 
	cQuery += " 	SFT.FT_VALICM, " + CRLF 
	cQuery += " 	SFT.FT_BASEIPI, " + CRLF 
	cQuery += " 	SFT.FT_ALIQIPI, " + CRLF 
	cQuery += " 	SFT.FT_VALIPI, " + CRLF 
	cQuery += " 	SFT.FT_BASEPIS, " + CRLF 
	cQuery += " 	SFT.FT_ALIQPIS, " + CRLF 
	cQuery += " 	SFT.FT_VALPIS, " + CRLF 
	cQuery += " 	SFT.FT_BASECOF, " + CRLF 
	cQuery += " 	SFT.FT_ALIQCOF, " + CRLF 
	cQuery += " 	SFT.FT_VALCOF, " + CRLF 
	cQuery += " 	SFT.FT_BASECSL, " + CRLF 
	cQuery += " 	SFT.FT_ALIQCSL, " + CRLF 
	cQuery += " 	SFT.FT_VALCSL, " + CRLF 
	cQuery += " 	SFT.FT_BASIMP5, " + CRLF 
	cQuery += " 	SFT.FT_ALQIMP5, " + CRLF 
	cQuery += " 	SFT.FT_VALIMP5, " + CRLF 
	cQuery += " 	SFT.FT_BASIMP6, " + CRLF 
	cQuery += " 	SFT.FT_ALQIMP6, " + CRLF 
	cQuery += " 	SFT.FT_VALIMP6, " + CRLF 
	cQuery += " 	SFT.FT_CHVNFE " + CRLF 
	cQuery += " FROM  " + CRLF 
	cQuery += " 	" + RetSqlName("SFT") + " SFT " + CRLF 
	cQuery += " LEFT JOIN " + CRLF 
	cQuery += " 	" + RetSqlName("SA1") + " SA1 " + CRLF 
	cQuery += " 	ON SA1.A1_FILIAL = '' " + CRLF 
	cQuery += " 	AND SA1.A1_COD = SFT.FT_CLIEFOR " + CRLF 
	cQuery += " 	AND SA1.A1_LOJA = SFT.FT_LOJA " + CRLF 
	cQuery += " 	AND SA1.D_E_L_E_T_ != '*' " + CRLF 
	cQuery += " LEFT JOIN " + CRLF 
	cQuery += " 	" + RetSqlName("SA2") + " SA2 " + CRLF 
	cQuery += " 	ON SA2.A2_COD = SFT.FT_CLIEFOR " + CRLF 
	cQuery += " 	AND SA2.A2_LOJA = SFT.FT_LOJA " + CRLF 
	cQuery += " 	AND SA2.D_E_L_E_T_ != '*' " + CRLF 
	cQuery += " LEFT JOIN " + CRLF 
	cQuery += " 	" + RetSqlName("SB1") + " SB1 " + CRLF 
	cQuery += " 	ON SB1.B1_FILIAL = '' " + CRLF 
	cQuery += " 	AND SB1.B1_COD = SFT.FT_PRODUTO " + CRLF 
	cQuery += " 	AND SB1.D_E_L_E_T_!= '*' " + CRLF 
	cQuery += " WHERE " + CRLF 
	cQuery += " 	SFT.FT_FILIAL  BETWEEN  '"+ aRet[3] +"' AND '"+ aRet[4] +"' " + CRLF 
	cQuery += " 	AND SFT.FT_ENTRADA BETWEEN  '"+ DTOS(aRet[1]) +"' AND '"+ DTOS(aRet[2]) +"' " + CRLF  	
	cQuery += " 	AND SFT.FT_ESTADO  BETWEEN  '"+ aRet[5] +"' AND '"+ aRet[6] +"' " + CRLF
	cQuery += " 	AND SFT.D_E_L_E_T_ != '*' " + CRLF 
		
	cQuery := ChangeQuery(cQuery)
	
	If Select("TMP") > 0
		Dbselectarea("TMP")
		QRY->(DbClosearea())
	EndIf
	
	TcQuery cQuery New Alias "TMP"
	
	TCSetField("TMP", "FT_ENTRADA" 	, "D",8,0)
	TCSetField("TMP", "FT_EMISSAO"	, "D",8,0)
	TCSetField("TMP", "FT_DTCANC"	, "D",8,0)
	
	oSection1:BeginQuery()
	oSection1:Print()
	
Return