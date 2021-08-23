#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#INCLUDE "AP5MAIL.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"


/*‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±∫Programa ≥ WFCOMNF1    ∫Autor≥  Felipe Mayer		         ∫ Data Ini≥ 03/02/2020  ∫±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±∫Desc.    ≥ WorkFlow NFs Pendentes de ClassificaÁ„o			 					  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±∫Uso      ≥ BACIO DI LATTE - RVACARI                                       		 ∫±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ*/

User Function WFCOMNF1()

Local cProcWF			
Local cStatusWF	
Local nTotal	:= 0
Local nQtDias   := 0
Local nX		:= 0
Local nJust1	:= 0
Local nJust2	:= 0
Local nJust3	:= 0
Local nJust4	:= 0
Local nJust5	:= 0
Local nQuant	:= 0
Local nVlr1		:= 0
Local nVlr2		:= 0
Local nVlr3		:= 0
Local nVlr4 	:= 0
Local nVlr5		:= 0
Local aItens	:= {}
Local cDataIni  := '20190101'
Local cDataFin	:= DToS(Date())

Private cMailConta	:= NIL
Private cMailServer	:= ""
Private cMailSenha	:= NIL

Default cDirTmp	:= '\WORKFLOW\WFCOMNF1\'
Default cArq 	:= CriaTrab(NIL,.F.) + ".xml"


PREPARE ENVIRONMENT EMPRESA "01" FILIAL '0001'

cEmailCom	:= 'felipe.mayer@rvacari.com.br'  //Fiscal , Pagamentos e  Controladoria
cProcWF		:= 'NCOM01'
cStatusWF	:= '10001'


	cQuery := " SELECT D1_FILIAL AS FILIAL, D1_DOC AS DOC, D1_EMISSAO AS EMISSAO, " 				 
	cQuery += " D1_DTDIGIT AS DATA, D1_FORNECE	AS FORNEC, D1_LOJA AS LOJA, SUM(D1_TOTAL) AS TOTAL " 
	cQuery += " FROM " + RetSqlName("SD1") + " (NOLOCK) " 											  
	cQuery += " WHERE D1_FILIAL != '' AND D1_EMISSAO BETWEEN  '" +cDataIni+ "' AND '" +cDataFin+ "' "	 	  
	cQuery += " AND D_E_L_E_T_ <> '*' AND D1_TES = '' "												  
	cQuery += " GROUP BY D1_FILIAL, D1_DOC, D1_EMISSAO, D1_DTDIGIT, D1_FORNECE, D1_LOJA " 			 
	cQuery += " ORDER BY D1_DTDIGIT " 																 
	
	If Select("TMP1") > 0
		TMP1->( dbclosearea() )
	Endif
		
	DbUseArea(.T.,'TOPCONN', TcGenQry(,,cQuery),"TMP1", .T., .T.)	
	
	DbSelectArea("TMP1")
	DbGoTop()
	
	While TMP1->(!Eof())
		Aadd(aItens,{ TMP1->DATA, TMP1->TOTAL })	
		TMP1->(DbSkip())	
	EndDo
	
	For nX := 1 to len(aItens)
		nQtDias := DDATABASE - SToD(aItens[nX,01])
		If nQtDias >= 0		
			If nQtDias > 30
				nJust1++
				nVlr1 += aItens[nX,02]

			ElseIf nQtDias >= 11 .And. nQtDias < 30
				nJust2++
				nVlr2 += aItens[nX,02]
				
			ElseIf nQtDias >= 3 .And. nQtDias <= 5
				nJust3++
				nVlr3 += aItens[nX,02]
				
			ElseIf nQtDias >= 6 .And. nQtDias <= 10
				nJust4++
				nVlr4 += aItens[nX,02]
				
			ElseIf nQtDias < 3
				nJust5++
				nVlr5 += aItens[nX,02]		
			EndIf
				nQuant++
				nTotal += aItens[nX,02]	
		EndIf
	Next nX	
		
	oProcess := TWFProcess():New( cProcWF, "NFS PENDENTES DE CLASSIFICA«√O FISCAL" )  
	oProcess :NewTask( "WorkFlow NFs Pendentes - Protheus", "\WORKFLOW\WFCOMNF1.htm" )
	oHtml    := oProcess:oHTML
		  
	While TMP1->(!Eof())
		aAdd( (oHtml:ValByName("it.nJust1") ), cValtoChar(nJust1) )
		aAdd( (oHtml:ValByName("it.nJust2") ), cValtoChar(nJust2) )		
		aAdd( (oHtml:ValByName("it.nJust3") ), cValtoChar(nJust3) )
		aAdd( (oHtml:ValByName("it.nJust4") ), cValtoChar(nJust4) )
		aAdd( (oHtml:ValByName("it.nJust5") ), cValtoChar(nJust5) )
		aAdd( (oHtml:ValByName("it.nQuant") ), cValtoChar(nQuant) )
		aAdd( (oHtml:ValByName("it.nVlr1" ) ), Transform(nVlr1 ,"@E 999,999,999.99") )
		aAdd( (oHtml:ValByName("it.nVlr2" ) ), Transform(nVlr2 ,"@E 999,999,999.99") )
		aAdd( (oHtml:ValByName("it.nVlr3" ) ), Transform(nVlr3 ,"@E 999,999,999.99") )
		aAdd( (oHtml:ValByName("it.nVlr4" ) ), Transform(nVlr4 ,"@E 999,999,999.99") )
		aAdd( (oHtml:ValByName("it.nVlr5" ) ), Transform(nVlr5 ,"@E 999,999,999.99") )
		aAdd( (oHtml:ValByName("it.nTotal") ), Transform(nTotal,"@E 999,999,999.99") )
		TMP1->(DbSkip())		
	EndDo
		
	Processa( {|| GeraExcel() }, "NCOM01", "Processando aguarde...", .f.)
	
	/* --------------------------------------------------------------------------
	     Inicia o Processo de WorkFlow para envio de E-mail aos respons·veis
	   ------------------------------------------------------------------------*/
	
	oProcess:cSubject	:= "WorkFlow NFs Pendentes - Protheus"
	oProcess:cTo		:= cEmailCom
	oProcess:AttachFile(cDirTmp+cArq) //Anexar Arquivo
		
	oProcess:Finish()
	WFSendMail()

Return


/*‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±∫Programa ≥ GeraExcel    ∫Autor≥  Felipe Mayer	         ∫ Data Ini≥ 03/02/2020  ∫±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±∫Desc.    ≥ Monta e gera relatÛrio XMLS em pasta da rede		 					  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±∫Uso      ≥ BACIO DI LATTE - RVACARI                                       		 ∫±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ*/

Static Function GeraExcel()

Local oExcel 	:= FWMSEXCEL():New()
Local lOk	 	:= .F.
Local cMsgline  := "WorkFlow NFs Pendentes de classificaÁ„o - Protheus"

	DbSelectArea("TMP1")
	TMP1->(DbGoTop())
	
	oExcel:AddWorkSheet("WorkFlow")
	oExcel:AddTable("WorkFlow",cMsgline)
	
	oExcel:AddColumn("WorkFlow"	,cMsgline,	"FILIAL"		,1,1)
	oExcel:AddColumn("WorkFlow"	,cMsgline,	"DOC"			,1,1)
	oExcel:AddColumn("WorkFlow"	,cMsgline,	"EMISSAO"		,1,1)
	oExcel:AddColumn("WorkFlow"	,cMsgline,	"DATA"			,1,1)
	oExcel:AddColumn("WorkFlow"	,cMsgline,	"FORNEC"		,1,1)
	oExcel:AddColumn("WorkFlow"	,cMsgline,	"LOJA"			,1,1)
	oExcel:AddColumn("WorkFlow"	,cMsgline,	"TOTAL"			,1,1)
	
	While TMP1->(!EoF())
		oExcel:AddRow("WorkFlow",cMsgline,{;
		 TMP1->(FILIAL)		  ,;
		 TMP1->(DOC)		  ,;
		 TMP1->(EMISSAO)	  ,;
		 TMP1->(DATA)		  ,;
		 TMP1->(FORNEC)		  ,;
		 TMP1->(LOJA)		  ,;
		 TMP1->(TOTAL)		  })
	
	lOk := .T.
	TMP1-> (DbSkip())
	EndDo
		
	oExcel:Activate()
	
	cArq := CriaTrab(NIL,.F.) + ".xml"
		
	oExcel:GetXMLFile(cArq)
	
		If __CopyFile(cArq, cDirTmp + cArq)
			If lOk
				oExcelApp := MSExcel():New()
				/*oExcelApp:Workbooks:Open(cDirTmp + cArq) //Abre a planilha*/
				oExcelApp:SetVisible(.T.)
				oExcelApp:Destroy()
			EndIf
		EndIf
Return