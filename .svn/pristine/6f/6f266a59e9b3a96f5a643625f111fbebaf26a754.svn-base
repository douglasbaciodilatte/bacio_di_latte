#include 'protheus.ch'
#include 'parmtype.ch'
#Include "Protheus.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} BLESTR02
// 				Relatório Solicitação de Transferências
@author 		Douglas Silva 
@since 			31/07/2019
@version 		1.0
@example		U_BLESTR02()
@param  		Nulo	, Nulo     , Nenhum
@return 		Nulo	, Nulo     , Nenhu
@obs 			Exclusivo Bacio di Late
/*/
User Function BLESTR02()

	Local oReport := nil
	Local aParamBox	:= {}
	Local cPerg:= Padr("BLESTR02",10)
	Private aRet		:= {}
			
	//gero a pergunta de modo oculto, ficando disponível no botão ações relacionadas
	Pergunte(cPerg,.F.)	          
		
	//Parametros para gerar query de dados
	aAdd(aParamBox,{1,"Emissão Nf-e De" ,Ctod(Space(8)),"","","","",50,.F.}) 
	aAdd(aParamBox,{1,"Emissão NF-e Ate",Ctod(Space(8)),"","","","",50,.F.}) 
			
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
	oReport := TReport():New("BLESTR02","Relação Solicitação Tranferencia x Notas","BLESTR02",{|oReport| ReportPrint(oReport)},"STOQ x Protheus")
	oReport:SetPortrait()    
	oReport:SetTotalInLine(.F.)
	
	oSection1:=		TRSection():New( oReport , "Relação Slc Transf x Nota Saída"	,{"QRY"}, , .F., .T. )					
					
					TRCell():New( oSection1, "NNS_FILIAL"	,"QRY", 'FILIAL'	,PesqPict('NNS',"NNS_FILIAL") )
					TRCell():New( oSection1, "NNS_COD"		,"QRY", 'COD_TRANSF',PesqPict('NNS',"NNS_COD") )
					TRCell():New( oSection1, "NNS_DATA"		,"QRY", 'EMISSAO'	,PesqPict('NNS',"NNS_DATA") )
					TRCell():New( oSection1, "NNT_XHORA"	,"QRY", 'HORA'		,PesqPict('NNT',"NNT_XHORA") )
					TRCell():New( oSection1, "NNT_PROD"		,"QRY", 'PRODUTO'	,PesqPict('NNT',"NNT_PROD") )
					TRCell():New( oSection1, "B1_DESC"		,"QRY", 'DESCRICAO'	,PesqPict('SB1',"B1_DESC") )
					TRCell():New( oSection1, "NNT_UM"		,"QRY", 'UNIDADE'	,PesqPict('NNT',"NNT_UM") )
					TRCell():New( oSection1, "NNT_LOCLD"	,"QRY", 'AMR_DEST'	,PesqPict('NNT',"NNT_LOCLD") )
					TRCell():New( oSection1, "NNR_DESCRI"	,"QRY", 'LOJA'		,PesqPict('NNR',"NNR_DESCRI") )
					TRCell():New( oSection1, "NNT_SERIE"	,"QRY", 'SERIE'		,PesqPict('NNT',"NNT_SERIE") )
					TRCell():New( oSection1, "NNT_DOC"		,"QRY", 'NUM_DOC' 	,PesqPict('NNT',"NNT_DOC") )
					TRCell():New( oSection1, "D2_EMISSAO"	,"QRY", 'EMISSAO_NF',PesqPict('SD2',"D2_EMISSAO") )
					TRCell():New( oSection1, "NNT_QUANT"	,"QRY" ,'QUANTIDADE',PesqPict('NNT',"NNT_QUANT") )
					
	oReport:SetTotalInLine(.F.)
       
    //Aqui, farei uma quebra  por seção
	oSection1:SetPageBreak(.T.)
	oSection1:SetTotalText(" ")
					
Return(oReport)

Static Function ReportPrint(oReport)
Local cQuery     := ""
Local oSection1 := oReport:Section(1)

	cQuery := " SELECT " + CRLF  
	cQuery += " 	NNS.NNS_FILIAL, " + CRLF 
	cQuery += " 	NNS.NNS_COD, " + CRLF  	
	cQuery += " 	NNS.NNS_DATA, " + CRLF 
	cQuery += " 	NNT.NNT_XHORA, " + CRLF 	
	cQuery += " 	NNT.NNT_PROD, " + CRLF 
	cQuery += " 	SB1.B1_DESC, " + CRLF 
	cQuery += " 	NNT_UM, " + CRLF 
	cQuery += " 	NNT_LOCLD, " + CRLF 
	cQuery += " 	NNR.NNR_DESCRI, " + CRLF 
	cQuery += " 	NNT_SERIE, " + CRLF 
	cQuery += " 	NNT_DOC, " + CRLF 
	cQuery += " 	SD2.D2_EMISSAO, " + CRLF 
	cQuery += " 	NNT_QUANT " + CRLF 
	cQuery += " FROM " + RetSqlName("NNS") + " NNS " + CRLF 
	cQuery += " JOIN " + RetSqlName("NNT") + " NNT " + CRLF 
	cQuery += " 	ON NNT.NNT_FILIAL = NNS.NNS_FILIAL " + CRLF 
	cQuery += " 	AND NNT.NNT_COD = NNS.NNS_COD " + CRLF 
	cQuery += " 	AND NNT.D_E_L_E_T_ != '*' " + CRLF 
	cQuery += " LEFT JOIN " + RetSqlName("NNR") + " NNR " + CRLF 
	cQuery += " 	ON NNR.NNR_FILIAL = NNT.NNT_FILDES " + CRLF 
	cQuery += " 	AND NNR.NNR_CODIGO = NNT.NNT_LOCLD " + CRLF 
	cQuery += " 	AND NNR.D_E_L_E_T_ != '*' " + CRLF 
	cQuery += " LEFT JOIN " + RetSqlName("SB1") + " SB1 " + CRLF 
	cQuery += " 	ON SB1.B1_FILIAL = '' " + CRLF 
	cQuery += " 	AND SB1.B1_COD = NNT.NNT_PROD " + CRLF 
	cQuery += " 	AND SB1.D_E_L_E_T_ != '*' " + CRLF 
	cQuery += " 	AND SB1.D_E_L_E_T_ != '*'
	cQuery += " JOIN " + RetSqlName("SD2") + " SD2 " + CRLF 
	cQuery += " 	ON SD2.D2_FILIAL = NNT.NNT_FILIAL " + CRLF 
	cQuery += " 	AND SD2.D2_DOC = NNT.NNT_DOC " + CRLF 
	cQuery += " 	AND SD2.D2_SERIE = NNT.NNT_SERIE " + CRLF 
	cQuery += " 	AND SD2.D2_COD = NNT.NNT_PROD " + CRLF 
	cQuery += " 	AND SD2.D_E_L_E_T_ != '*' " + CRLF 
	cQuery += " WHERE " + CRLF  
	cQuery += " 	NNS.NNS_FILIAL = '0031' " + CRLF 
	cQuery += " 	AND SUBSTRING(NNS.NNS_DATA,1,8) BETWEEN  '"+ DTOS(aRet[1]) +"' AND '"+ DTOS(aRet[2]) +"' " + CRLF 
	cQuery += " 	AND NNT.NNT_DOC != '' " + CRLF 
	cQuery += " 	AND NNS.D_E_L_E_T_ != '*' " + CRLF 
	cQuery += " ORDER BY " + CRLF 
	cQuery += " 1,2 " + CRLF 
		
	cQuery := ChangeQuery(cQuery)
	
	If Select("QRY") > 0
		Dbselectarea("QRY")
		QRY->(DbClosearea())
	EndIf
	
	TcQuery cQuery New Alias "QRY"
	
	TcSetField("QRY", "NNT_QUANT"	, "N",12,2)  
	TcSetField("QRY", "NNS_DATA"	, "D",8,0)
	TcSetField("QRY", "D2_EMISSAO"	, "D",8,0)
	
	oSection1:BeginQuery()
	oSection1:Print()
	
Return

Return