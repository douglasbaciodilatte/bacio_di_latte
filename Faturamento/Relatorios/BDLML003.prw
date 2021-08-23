#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BDLML003  ºAutor  ³ Douglas Silva      º Data ³ 30/10/2019  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressão Faturamento Aglutinado por Filial                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio Di Latte - RVacari                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function BDLML003()

	Local oReport := nil
	Local aParamBox	:= {}
	Local cPerg:= Padr("BDLML003",10)
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
	oReport := TReport():New("BDLML003","Vendas Cupons STOQ x Protheus","BDLML003",{|oReport| ReportPrint(oReport)},"STOQ x Protheus")
	oReport:SetPortrait()    
	oReport:SetTotalInLine(.F.)
	
	oSection1:=		TRSection():New( oReport , "Vendas Integradas"	,{"QRY"}, , .F., .T. )					
					TRCell():New( oSection1, "FILIAL"	,"QRY", 'FILIAL'	,PesqPict('SF2',"F2_FILIAL") )
					TRCell():New( oSection1, "TOTAL"  	,"QRY", 'TOTAL'		,PesqPict('SF2',"F2_VALBRUT") )
		
	oReport:SetTotalInLine(.F.)
       
    //Aqui, farei uma quebra  por seção
	oSection1:SetPageBreak(.T.)
	oSection1:SetTotalText(" ")
					
Return(oReport)

Static Function ReportPrint(oReport)
Local cQuery     := ""
Local oSection1 := oReport:Section(1)

	cQuery := " SELECT " + CRLF 
	cQuery += " F2_FILIAL AS 'FILIAL', " + CRLF 
	cQuery += " ROUND(SUM(SF2.F2_VALBRUT),2) 'TOTAL' " + CRLF 
	cQuery += " FROM " + CRLF 
	cQuery += " 	" + RetSqlName("SF2") + " SF2 " + CRLF 
	cQuery += " WHERE  SF2.F2_FILIAL != '0031' " + CRLF
	cQuery += " 	AND SF2.F2_EMISSAO BETWEEN  '"+ DTOS(aRet[1]) +"' AND '"+ DTOS(aRet[2]) +"' " + CRLF 
	cQuery += " 	AND SF2.D_E_L_E_T_ != '*' " + CRLF 
	cQuery += " 	AND SF2.F2_PDV != ' ' " + CRLF  
	cQuery += " GROUP BY F2_FILIAL " + CRLF
	cQuery += " ORDER BY F2_FILIAL " + CRLF 
		
	cQuery := ChangeQuery(cQuery)
	
	If Select("QRY") > 0
		Dbselectarea("QRY")
		QRY->(DbClosearea())
	EndIf
	
	TcQuery cQuery New Alias "QRY"
	
	TcSetField("QRY", "TOTAL"	, "N",14,2)  
	
	oSection1:BeginQuery()
	oSection1:Print()
	
Return