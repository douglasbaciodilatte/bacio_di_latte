#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BDLML002  ºAutor  ³ Douglas Silva      º Data ³ 30/10/2019  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressão de cadastro de funcionários em TReport.          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio Di Latte - RVacari                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function BDLML002()

	Local oReport := nil
	Local aParamBox	:= {}
	Local cPerg:= Padr("BDLML002",10)
	Private aRet		:= {}
			
	//gero a pergunta de modo oculto, ficando disponível no botão ações relacionadas
	Pergunte(cPerg,.F.)	          
		
	//Parametros para gerar query de dados
	aAdd(aParamBox,{1,"Emissão De?" ,Ctod(Space(8)),"","","","",50,.F.}) 
	aAdd(aParamBox,{1,"Emissão Ate?",Ctod(Space(8)),"","","","",50,.F.}) 
			
	If ParamBox(aParamBox ,"Parametros ",aRet)	
		oReport := RptDef(cPerg)
		oReport:PrintDialog()
	Else
		Alert("Ação cancelada! ")
	EndIf
			
Return

Static Function RptDef(cNome)
	
	Local oReport := Nil
	Local oSection1:= Nil
	
	/*Sintaxe: TReport():New(cNome,cTitulo,cPerguntas,bBlocoCodigo,cDescricao)*/
	oReport := TReport():New("BDLML002","Vendas Cupons STOQ x Protheus","BDLML002",{|oReport| ReportPrint(oReport)},"STOQ x Protheus")
	oReport:SetPortrait()    
	oReport:SetTotalInLine(.F.)
	
	oSection1:=		TRSection():New( oReport , "Vendas Integradas"	,{"QRY"}, , .F., .T. )					
					TRCell():New( oSection1, "FILIAL"	,"QRY", 'FILIAL'	,PesqPict('SF2',"F2_FILIAL") )
					TRCell():New( oSection1, "CCUSTO"   ,"QRY", 'CCUSTO'	,PesqPict('SD2',"D2_CCUSTO") )
					TRCell():New( oSection1, "LOJA"  	,"QRY", 'LOJA'		,PesqPict('NNR',"NNR_DESCRI") )
					TRCell():New( oSection1, "ESTADO"  	,"QRY", 'ESTADO'	,PesqPict('SF2',"F2_EST") )
					TRCell():New( oSection1, "EMISSAO"  ,"QRY", 'EMISSAO'	,PesqPict('SF2',"F2_EMISSAO") )
					TRCell():New( oSection1, "QTDE_C" 	,"QRY", 'QTDE_C'	, )
					TRCell():New( oSection1, "TOTAL"  	,"QRY", 'TOTAL'		,PesqPict('SD2',"D2_VALBRUT") )
		
	oReport:SetTotalInLine(.F.)
       
    //Aqui, farei uma quebra  por seção
	oSection1:SetPageBreak(.T.)
	oSection1:SetTotalText(" ")
					
Return(oReport)

Static Function ReportPrint(oReport)
Local cQuery     := ""
Local oSection1 := oReport:Section(1)

	cQuery := " SELECT " + CRLF 
	cQuery += " F2_FILIAL AS 'FILIAL',SD2.D2_CCUSTO AS 'CCUSTO', NNR_DESCRI 'LOJA', " + CRLF 
	cQuery += " F2_EST AS 'ESTADO',F2_EMISSAO AS 'EMISSAO',COUNT(SF2.F2_DOC) 'QTDE_C', " + CRLF 
	cQuery += " ROUND(SUM(SD2.D2_VALBRUT),2) 'TOTAL' " + CRLF 
	cQuery += " FROM " + CRLF 
	cQuery += " 	" + RetSqlName("SF2") + " SF2 " + CRLF 
	cQuery += " LEFT JOIN " + RetSqlName("SD2") + " SD2  " + CRLF
	cQuery += " 	ON SD2.D2_FILIAL = SF2.F2_FILIAL " + CRLF
	cQuery += " 	AND SD2.D2_DOC = SF2.F2_DOC " + CRLF
	cQuery += " 	AND SD2.D2_SERIE = SF2.F2_SERIE " + CRLF
	cQuery += " 	AND SD2.D2_CLIENTE = SF2.F2_CLIENTE " + CRLF
	cQuery += " 	AND SD2.D2_LOJA = SF2.F2_LOJA " + CRLF
	cQuery += " 	AND SD2.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " LEFT JOIN " + RetSqlName("NNR") + " NNR " + CRLF
	cQuery += " 	ON NNR.NNR_FILIAL = SD2.D2_FILIAL " + CRLF
	cQuery += " 	AND NNR.NNR_CODIGO = SD2.D2_CCUSTO " + CRLF
	cQuery += " 	AND NNR.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " WHERE  SF2.F2_FILIAL != '' " + CRLF
	cQuery += " 	AND SF2.F2_EMISSAO BETWEEN  '"+ DTOS(aRet[1]) +"' AND '"+ DTOS(aRet[2]) +"' " + CRLF 
	cQuery += " 	AND SF2.D_E_L_E_T_ != '*' " + CRLF 
	cQuery += " 	AND SF2.F2_PDV != ' ' " + CRLF  
	cQuery += " GROUP BY F2_FILIAL,F2_EMISSAO,SD2.D2_CCUSTO,NNR_DESCRI,F2_EST " + CRLF
	cQuery += " ORDER BY F2_FILIAL,SD2.D2_CCUSTO,F2_EMISSAO " + CRLF 
		
	cQuery := ChangeQuery(cQuery)
	
	If Select("QRY") > 0
		Dbselectarea("QRY")
		QRY->(DbClosearea())
	EndIf
	
	TcQuery cQuery New Alias "QRY"
	
	TCSetField("QRY", "EMISSAO" , "D",8,0)
	TcSetField("QRY", "QTDE_C"	, "N",9)
	TcSetField("QRY", "TOTAL"	, "N",14,2)  
	
	oSection1:BeginQuery()
	//oSection1:EndQuery({{"QRY"},cQuery})
	oSection1:Print()
	
Return