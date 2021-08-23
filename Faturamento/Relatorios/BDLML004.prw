#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BDLML004  �Autor  � Douglas Silva      � Data � 11/11/2019  ���
�������������������������������������������������������������������������͹��
���Desc.     � Impress�o rela��o de vendas por filial Protheus            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Bacio Di Latte - RVacari                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function BDLML004()

	Local aParamBox	:= {}
	Private oReport  := Nil
	Private cPerg 	 := PadR ("BDLML003", Len (SX1->X1_GRUPO))
	Private aRet		:= {}
	
	//Parametros para gerar query de dados
	aAdd(aParamBox,{1,"Emiss�o De?" ,Ctod(Space(8)),"","","","",50,.F.}) 
	aAdd(aParamBox,{1,"Emiss�o Ate?",Ctod(Space(8)),"","","","",50,.F.}) 
			
	If ParamBox(aParamBox ,"Parametros ",aRet)
		ReportDef()
		oReport:PrintDialog()
	Else
		Alert("A��o cancelada! ")
	EndIf

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BDLML003  �Autor  � Douglas Silva      � Data � 31/10/2019  ���
�������������������������������������������������������������������������͹��
���Desc.     � Impress�o rela��o de vendas por filial Protheus            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Bacio Di Latte - RVacari                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function ReportDef()

Private oSection1 := nil

	oReport := TReport():New("BDLML003","Somat�rio Vendas - SF2 X SD2",cPerg,{|oReport| PrintReport(oReport)},"Somat�rio Vendas - SF2 X SD2")
	oReport:SetPortrait()
	oReport:SetTotalInLine(.F.)
	
	oSection1 := 	TRSection():New( oReport , "Vendas Integradas SF2 x SD2"	,{"QRY"}, , .F., .T. )
					TRCell():New( oSection1, "F2_FILIAL"    		,"QRY", 'Filial F2'	,PesqPict('SF2',"F2_FILIAL") )
					TRCell():New( oSection1, "TOTALF2"    			,"QRY", 'Total  F2 ',PesqPict('SD2',"D2_TOTAL") )
					
	TRFunction():New(oSection1:Cell("TOTALF2"),/*cId*/,"SUM"     ,/*oBreak*/,"TOTAL",/*cPicture*/,/*uFormula*/,.F.            ,.T.           ,.F.        ,oSection1)
	
	//Define a impress�o dos totalizadores em colunas
	oReport:SetTotalInLine(.f.)
	
	//Aqui, farei uma quebra  por se��o
	oSection1:SetPageBreak(.T.)
	oSection1:SetTotalText(" ")
	
Return (oReport)

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BDLML003  �Autor  � Douglas Silva      � Data � 31/10/2019  ���
�������������������������������������������������������������������������͹��
���Desc.     � Impress�o rela��o de vendas por filial Protheus            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Bacio Di Latte - RVacari                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function PrintReport(oReport)

Local cQuery     := ""
Local oSection1 := oReport:Section(1)

	cQuery += " SELECT " + CRLF 
	cQuery += " SUBSTRING(F2_EMISSAO,7,2) + '/' + " + CRLF 
	cQuery += " SUBSTRING(F2_EMISSAO,5,2) + '/' + " + CRLF 
	cQuery += " SUBSTRING(F2_EMISSAO,1,4) AS F2_EMISSAO, " + CRLF
	cQuery += " F2_FILIAL, " + CRLF 
	cQuery += " ROUND(SUM(SF2.F2_VALBRUT),2) TOTALF2 " + CRLF
	cQuery += " FROM " + RetSqlName("SF2") + " SF2 (NOLOCK) " + CRLF 
	cQuery += " WHERE SF2.F2_EMISSAO BETWEEN  '"+ DTOS( aRet[1] ) +"' AND '"+ DTOS(aRet[2]) +"' " + CRLF
	cQuery += " AND SF2.D_E_L_E_T_ != '*' " + CRLF
	cQuery += " AND SF2.F2_PDV != ' ' " + CRLF 
	cQuery += " GROUP BY F2_EMISSAO,F2_FILIAL " + CRLF 
	cQuery += " ORDER BY F2_EMISSAO,F2_FILIAL " + CRLF 
		
	cQuery := ChangeQuery(cQuery)
	
	If Select("QRY") > 0
		Dbselectarea("QRY")
		QRY->(DbClosearea())
	EndIf
	
	TcQuery cQuery New Alias "QRY"
	
	oSection1:BeginQuery()
	oSection1:EndQuery({{"QRY"},cQuery})
	oSection1:Print()

Return Nil