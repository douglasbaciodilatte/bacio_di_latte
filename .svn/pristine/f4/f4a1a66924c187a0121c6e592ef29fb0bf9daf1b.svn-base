/*Importar as bibliotecas*/
#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMBROWSE.CH"
#INCLUDE "FWMVCDEF.CH"

/*
=====================================================================================
Programa.:              BLROFIS01 
Autor....:              Douglas Rodrigues da Silva
Data.....:              23/10/2019
Descricao / Objetivo:   Tela de ajustes fiscal e rotina procesamento 
Doc. Origem:            
Solicitante:            Cliente
Uso......:              BACIO DI LATTE
Obs......:              Rotina em MVC - Tela e Rotina 
=====================================================================================
*/

User Function BLROFIS01()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Private cCadastro 	:= "Bacio - Fiscal x Cupons" 
Private aArea       := GetArea()
Private aCores		:= {} 

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Monta um aRotina proprio                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	Private aRotina := { {"Pesquisar"				,"AxPesqui"			,0,1} ,;
			             {"Visualizar"				,"AxVisual"			,0,2} ,;
			             {"Incluir"					,"AxInclui"			,0,3} ,;
			             {"Correção Fiscal"			,"U_BLROFIS2"		,0,4} ,;	
			             {"Resumo Livros"			,"U_BLRTFIS1"		,0,6} }
	                                                                        
	Private cDelFunc := ".T." // Validacao para a exclusao. Pode-se utilizar ExecBlock
	
	Private cString := "ZF1"   
	Private lResp	:= .F.
	
	ZF1->(dbSelectArea("ZF1"))
	ZF1->(dbSetOrder(1))
	
	AADD(aCores,{"ZF1_MSBLQL == '1'" ,"BR_VERMELHO" 	}) 	//Regra Bloqueada
	AADD(aCores,{"ZF1_MSBLQL == '2'" ,"BR_VERDE" }) 		//Regra Desbloqueada
	AADD(aCores,{"ZF1_MSBLQL == ' '" ,"BR_VERDE" }) 		//Regra Desbloqueada
	            
	mBrowse( 6,1,22,75,"ZF1",,,,,6,aCores)            
	                      
RestArea( aArea )

Return

#Include 'Protheus.ch'
#include "TOPCONN.CH"
#DEFINE ENTER chr(13)+chr(10)

/*
=====================================================================================
Programa.:              AJDSFT001 
Autor....:              Douglas Rodrigues da Silva
Data.....:              15/10/2019
Descricao / Objetivo:   Efetua ajuste tabela SFT   
Doc. Origem:            
Solicitante:            Cliente
Uso......:              BACIO DI LATTE
Obs......:              Rotina em MVC 
=====================================================================================
*/

User Function BLROFIS2()

	Processa(  {|| ProcVen()  }	, 'Aguarde, Processando Correções...')		

Return

Static Function ProcVen()


	Local aRet 		:= {}
	Local aParamBox := {}
	Local nStatus	:= 0
	
	SFT->(dbSelectArea("SFT"))
	SFT->(dbSetOrder(1))
		
	aAdd(aParamBox,{1,"Mês De?"  			,SPACE(2),"","","","",50,.F.}) 		//1
	aAdd(aParamBox,{1,"Mês Ate?"  			,SPACE(2),"","","","",50,.F.}) 		//2
	aAdd(aParamBox,{1,"Ano?"  				,SPACE(4),"","","","",50,.F.})		//3
	aAdd(aParamBox,{1,"Produto?"			,SPACE(15),"","","SB1","",0,.F.})	//4
	
	If ParamBox(aParamBox,"Parametros Ajuste SFT",@aRet)
		
		TCLink() //Inicia nova conexão banco de dados.
			
			//Ajuste SFT
				
			cQuery := "	UPDATE "+RetSQLName("SFT")+" SET " + CRLF
			
			If ! Empty( ZF1->ZF1_CFOP ) .And. SUBSTR( ZF1->ZF1_CFOP,1,1) >= "5"
				cQuery += "	FT_CFOP = '" + ZF1->ZF1_CFOP + "'," + CRLF 
			EndIf
			
			If ! Empty( ZF1->ZF1_CSTICM ) .And. SUBSTR( ZF1->ZF1_CFOP,1,1) >= "5"
				cQuery += "	FT_CLASFIS = '" + ZF1->ZF1_CSTICM + "'," + CRLF 
			EndIf
				
			If ZF1->ZF1_BASCAL == "1"
				If Empty(ZF1->ZF1_REGRA) 
					cQuery += "	FT_BASEICM = FT_VALCONT, " + CRLF
					
				ElseIf ZF1->ZF1_REGRA == "3"	
					cQuery += "	FT_BASEICM = ROUND( (FT_VALCONT * " + cValToChar(ZF1->ZF1_REICMS) + " / 100) ,2), " + CRLF
					cQuery += "	FT_ISENICM = ROUND( FT_VALCONT - ROUND( (FT_VALCONT * 18.8235 / 100) ,2) ,2), " + CRLF
					
				EndIf	
			EndIf
			
			If ZF1->ZF1_ICMS != 0
				cQuery += "	FT_ALIQICM = "  + cValToChar( ZF1->ZF1_ICMS ) + "," + CRLF
				
				If ZF1->ZF1_REGRA == "3"
					cQuery += "	FT_VALICM  = ROUND( (  ROUND( (FT_VALCONT * " + cValToChar(ZF1->ZF1_REICMS) + " / 100) ,2)  * "  + cValToChar( ZF1->ZF1_ICMS ) + " / 100) ,2), " + CRLF					
				Else
					cQuery += "	FT_VALICM  = ROUND( ( FT_VALCONT * "  + cValToChar( ZF1->ZF1_ICMS ) + " / 100) ,2), " + CRLF
				EndIf
			Else
				cQuery += "	FT_ALIQICM = 0," + CRLF
				cQuery += "	FT_BASEICM = 0, " + CRLF
				cQuery += "	FT_VALICM = 0, " + CRLF
				 
			EndIf
						
			If ZF1->ZF1_ISNT == "1" .And. ZF1->ZF1_REGRA == "1"
				cQuery += "	FT_ISENICM = FT_VALCONT, " + CRLF
			ElseIf ZF1->ZF1_REGRA != "3"
				cQuery += "	FT_ISENICM = 0, " + CRLF
			EndIf
							
			If ZF1->ZF1_OUTR == "1" .And. ZF1->ZF1_REGRA == "2"
				cQuery += "	FT_OUTRICM = FT_VALCONT " + CRLF
			Else
				cQuery += "	FT_OUTRICM = 0 " + CRLF
			EndIf
			
			cQuery += "	WHERE " + CRLF
			cQuery += "	D_E_L_E_T_ != '*'" + CRLF
						
			cQuery += "	AND SUBSTRING(FT_ENTRADA,1,6) BETWEEN '" + aRet[3] + aRet[1] + "' AND '" + aRet[3] + aRet[2] + "'" + CRLF			
			
			If Empty(aRet[4])
				
				If SUBSTR( ZF1->ZF1_CFOP,1,1) >= "5"
					cQuery += "	AND FT_CFOP = '"+ZF1->ZF1_CFOP+"'" + CRLF
				Else
					cQuery += "	AND FT_CFOP NOT IN ( '1933', '2933' )" + CRLF 
				EndIf
					
				cQuery += "	AND FT_TIPOMOV = '"+IIF( SUBSTR( ZF1->ZF1_CFOP,1,1) <= "4", 'E', 'S'  )+"'" + CRLF
				
			Else			
				cQuery += " AND FT_PRODUTO = '"+aRet[4]+"' " + CRLF
			EndIf
			
			cQuery += " AND FT_ESTADO = '" + ZF1->ZF1_ESTADO + "' " + CRLF
													
			nStatus := 	TcSqlExec(cQuery)
			
			TcSqlExec("COMMIT")
			
			//Ajutes SF3
						
			cQuery := "	UPDATE "+RetSQLName("SF3")+" SET " + CRLF
			
			If ! Empty( ZF1->ZF1_CFOP ) .And. SUBSTR( ZF1->ZF1_CFOP,1,1) >= "5"
				cQuery += "	F3_CFO = '" + ZF1->ZF1_CFOP + "'," + CRLF 
			EndIf
							
			If ZF1->ZF1_BASCAL == "1"
				If Empty(ZF1->ZF1_REGRA) 
					cQuery += "	F3_BASEICM = F3_VALCONT, " + CRLF
					
				ElseIf ZF1->ZF1_REGRA == "3"	
					cQuery += "	F3_BASEICM = ROUND( (F3_VALCONT * " + cValToChar(ZF1->ZF1_REICMS) + " / 100) ,2), " + CRLF
					cQuery += "	F3_ISENICM = ROUND( F3_VALCONT - ROUND( (F3_VALCONT * 18.8235 / 100) ,2) ,2), " + CRLF
					
				EndIf	
			EndIf
			
			If ZF1->ZF1_ICMS != 0
				cQuery += "	F3_ALIQICM = "  + cValToChar( ZF1->ZF1_ICMS ) + "," + CRLF
				
				If ZF1->ZF1_REGRA == "3"
					cQuery += "	F3_VALICM  = ROUND( (  ROUND( (F3_VALCONT * " + cValToChar(ZF1->ZF1_REICMS) + " / 100) ,2)  * "  + cValToChar( ZF1->ZF1_ICMS ) + " / 100) ,2), " + CRLF					
				Else
					cQuery += "	F3_VALICM  = ROUND( ( F3_VALCONT * "  + cValToChar( ZF1->ZF1_ICMS ) + " / 100) ,2), " + CRLF
				EndIf
			Else
				cQuery += "	F3_ALIQICM = 0," + CRLF
				cQuery += "	F3_BASEICM = 0, " + CRLF
				cQuery += "	F3_VALICM = 0, " + CRLF	 
			EndIf
						
			If ZF1->ZF1_ISNT == "1" .And. ZF1->ZF1_REGRA == "1"
				cQuery += "	F3_ISENICM = F3_VALCONT, " + CRLF
			ElseIf ZF1->ZF1_REGRA != "3"
				cQuery += "	F3_ISENICM = 0, " + CRLF
			EndIf
							
			If ZF1->ZF1_OUTR == "1" .And. ZF1->ZF1_REGRA == "2"
				cQuery += "	F3_OUTRICM = F3_VALCONT " + CRLF
			Else
				cQuery += "	F3_OUTRICM = 0 " + CRLF
			EndIf
			
			cQuery += "	FROM "+RetSQLName("SF3")+" AS SF3 " + CRLF
			
			If ! Empty(aRet[4])
				cQuery += "	JOIN "+RETSQLNAME("SFT")+" SFT (NOLOCK)" + CRLF
				cQuery += "	ON SFT.FT_FILIAL = SF3.F3_FILIAL" + CRLF
				cQuery += "	AND SFT.FT_TIPOMOV = 'S'" + CRLF
				cQuery += "	AND SFT.FT_CLIEFOR = SF3.F3_CLIEFOR" + CRLF
				cQuery += "	AND SFT.FT_LOJA = SF3.F3_LOJA" + CRLF
				cQuery += "	AND SFT.FT_NFISCAL = SF3.F3_NFISCAL" + CRLF
				cQuery += "	AND SF3.F3_IDENTFT = SFT.FT_IDENTF3" + CRLF
				cQuery += "	AND SFT.FT_CHVNFE = SF3.F3_CHVNFE" + CRLF
				cQuery += "	AND SFT.D_E_L_E_T_ != '*'" + CRLF
			EndIf
			
			cQuery += "	WHERE " + CRLF
			cQuery += "	SF3.D_E_L_E_T_ != '*'" + CRLF
						
			cQuery += "	AND SUBSTRING(F3_ENTRADA,1,6) BETWEEN '" + aRet[3] + aRet[1] + "' AND '" + aRet[3] + aRet[2] + "'" + CRLF			
			
			If Empty(aRet[4]) .And. SUBSTR( ZF1->ZF1_CFOP,1,1) >= "5"
				cQuery += "	AND F3_CFO = '"+ZF1->ZF1_CFOP+"'" + CRLF
				
			ElseIf ! Empty(aRet[4]) .And. SUBSTR( ZF1->ZF1_CFOP,1,1) >= "5"			
				cQuery += " AND FT_PRODUTO = '"+aRet[4]+"' " + CRLF
				
			Else	
				cQuery += "	AND SUBSTRING( F3_CFO ,1,1 ) <= '4' " + CRLF
				cQuery += "	AND F3_CFO NOT IN ( '1933', '2933' )" + CRLF
			EndIf
						
			cQuery += " AND F3_ESTADO = '" + ZF1->ZF1_ESTADO + "' " + CRLF
													
			nStatus := 	TcSqlExec(cQuery)
			
			TcSqlExec("COMMIT")
						
			If (nStatus < 0)
				Alert("TCSQLError() " + TCSQLError())
			Else
				MsgInfo("Alteração concluída com sucesso, numero de registros " )
			EndIf
			
		TCUnlink()
			
	Endif

Return

/*
=====================================================================================
Programa.:              BLROFIS01 
Autor....:              Douglas Rodrigues da Silva
Data.....:              23/10/2019
Descricao / Objetivo:   Tela de ajustes fiscal e rotina procesamento 
Doc. Origem:            
Solicitante:            Cliente
Uso......:              BACIO DI LATTE
Obs......:              Rotina em MVC - Tela e Rotina +
=====================================================================================
*/

User Function BLRTFIS1()

	Local aParamBox	:= {}
	Private aRet		:= {}
	
	
	//Parametros para gerar query de dados
	aAdd(aParamBox,{1,"Estado De?" 	,Space(2)		,"","12","","",50,.F.}) 	
	aAdd(aParamBox,{1,"Estado Ate?" 	,Space(2)	,"","12","","",50,.F.})
	aAdd(aParamBox,{1,"Emissão De?" ,Ctod(Space(8))	,"","","","",50,.F.}) 
	aAdd(aParamBox,{1,"Emissão Ate?",Ctod(Space(8))	,"","","","",50,.F.}) 
			
	If ParamBox(aParamBox ,"Parametros ",aRet)
		Processa(  {|| Procx01()  }	, 'Aguarde, Buscando Informações...')		
	Else
		Alert("Ação cancelada! ")
	EndIf
	
Return

/*
=====================================================================================
Programa.:              BLROFIS01 
Autor....:              Douglas Rodrigues da Silva
Data.....:              23/10/2019
Descricao / Objetivo:   Tela de ajustes fiscal e rotina procesamento 
Doc. Origem:            
Solicitante:            Cliente
Uso......:              BACIO DI LATTE
Obs......:              Rotina em MVC - Tela e Rotina +
=====================================================================================
*/

Static Function Procx01

	Local aArea      := GetArea()
    Local cQuery     := ""
    Local oFWMsExcel
    Local oExcel
    Local cArquivo  := GetTempPath()+ "BLROFIS01_" + SUBSTR( TIME(),1,2 ) + SUBSTR( TIME(),4,2 ) + SUBSTR( TIME(),8,2 ) + "_" + DTOS(DATE()) + '.xml'
	
	cQuery := " SELECT " + CRLF
	cQuery += " FT_FILIAL, " + CRLF
	cQuery += " FT_ESTADO AS 'ESTADO', " + CRLF
	cQuery += " IIF(FT_TIPOMOV = 'S', 'SAIDA','ENTRADA') AS TIPOMOV, " + CRLF
	cQuery += " FT_CLASFIS, " + CRLF
	cQuery += " FT_CFOP AS 'CFOP', " + CRLF 
	cQuery += " FT_ALIQICM AS 'ALIQ_ICMS', " + CRLF
	cQuery += " FORMAT( ROUND(SUM(FT_VALCONT),2), 'C', 'PT-BR') AS 'VAL_CONTAB', " + CRLF 
	cQuery += " FORMAT( ROUND(SUM(FT_BASEICM),2), 'C', 'PT-BR') AS 'BASE_ICMS', " + CRLF  
	cQuery += " FORMAT( ROUND(SUM(FT_VALICM),2), 'C', 'PT-BR') AS 'VAL_ICMS', " + CRLF 
	cQuery += " FORMAT( ROUND(SUM(FT_ISENICM),2), 'C', 'PT-BR') AS 'VAL_ISEN_ICMS', " + CRLF 
	cQuery += " FORMAT( ROUND(SUM(FT_OUTRICM),2), 'C', 'PT-BR') AS 'VAL_OUT_ICMS' " + CRLF 
	cQuery += " FROM " + RetSqlName("SFT") +  " SFT " + CRLF 
	cQuery += " WHERE FT_FILIAL != '' " + CRLF  
	cQuery += " 	AND SUBSTRING(FT_ENTRADA,1,8) BETWEEN '"+DTOS(aRet[3])+"' AND '"+DTOS(aRet[4])+"' " + CRLF 
	cQuery += " 	AND FT_ESTADO BETWEEN '"+aRet[1]+"' AND '"+aRet[2]+"' " + CRLF 
	 
	cQuery += " 	AND D_E_L_E_T_ != '*' " + CRLF
	cQuery += " 	AND FT_DTCANC  = '' " + CRLF
	
	cQuery += " GROUP BY FT_FILIAL, FT_TIPOMOV, FT_CLASFIS, FT_ESTADO, FT_CFOP, FT_ALIQICM " + CRLF
	cQuery += " ORDER BY 1,3 " + CRLF
	
	cQuery := ChangeQuery(cQuery)
	
	If Select("QRY") > 0
		Dbselectarea("QRY")
		QRY->(DbClosearea())
	EndIf
	
	TcQuery cQuery New Alias "QRY"
			
	//Criando o objeto que irá gerar o conteúdo do Excel
    oFWMsExcel := FWMSExcel():New()
    
    //Aba 01 - Teste
    oFWMsExcel:AddworkSheet("Livros Fiscais") //Não utilizar número junto com sinal de menos. Ex.: 1-
	
	//Criando a Tabela
    oFWMsExcel:AddTable("Livros Fiscais","Livros Fiscais - Aglutinado CFOP")
	
	 //Criando Colunas
    oFWMsExcel:AddColumn("Livros Fiscais","Livros Fiscais - Aglutinado CFOP","Filial"	,1,1)
    oFWMsExcel:AddColumn("Livros Fiscais","Livros Fiscais - Aglutinado CFOP","Estado"	,1,1)
    oFWMsExcel:AddColumn("Livros Fiscais","Livros Fiscais - Aglutinado CFOP","Tipo"	,1,1)
    oFWMsExcel:AddColumn("Livros Fiscais","Livros Fiscais - Aglutinado CFOP","CFOP"		,1,1)
    oFWMsExcel:AddColumn("Livros Fiscais","Livros Fiscais - Aglutinado CFOP","CST"		,1,1)
    oFWMsExcel:AddColumn("Livros Fiscais","Livros Fiscais - Aglutinado CFOP","Vlr Contabil"	,3,3)
    oFWMsExcel:AddColumn("Livros Fiscais","Livros Fiscais - Aglutinado CFOP","Base ICMS"	,3,3)
    oFWMsExcel:AddColumn("Livros Fiscais","Livros Fiscais - Aglutinado CFOP","Aliq ICMS"	,2,2)
    oFWMsExcel:AddColumn("Livros Fiscais","Livros Fiscais - Aglutinado CFOP","Vlr ICMS"		,3,3)
    oFWMsExcel:AddColumn("Livros Fiscais","Livros Fiscais - Aglutinado CFOP","Vlr Isentas"	,3,3)
    oFWMsExcel:AddColumn("Livros Fiscais","Livros Fiscais - Aglutinado CFOP","Vlr Outras"	,3,3)
	
	//Criando as Linhas... Enquanto não for fim da query
	//QRY->(dbGoTop())
    Do While !(QRY->(EoF()))
    	
    	 oFWMsExcel:AddRow("Livros Fiscais","Livros Fiscais - Aglutinado CFOP",{QRY->FT_FILIAL,;
			                                                                    QRY->ESTADO,;
			                                                                    QRY->TIPOMOV,;
			                                                                    QRY->CFOP,;
			                                                                    QRY->FT_CLASFIS,;
			                                                                    QRY->VAL_CONTAB,;
			                                                                    QRY->BASE_ICMS,;
			                                                                    QRY->ALIQ_ICMS,;
			                                                                    QRY->VAL_ICMS,;
			                                                                    QRY->VAL_ISEN_ICMS,;
			                                                                    QRY->VAL_OUT_ICMS })
    	
    	//Gração dos dados
		IncProc( "Exportando dados Excel" )
    	
    	//Pulando Registro
    	QRY->(DbSkip())
    EndDo
    
    cQuery := " SELECT " + CRLF 
    cQuery += " 	F3_FILIAL, " + CRLF 
    cQuery += " 	F3_ESTADO AS 'ESTADO', " + CRLF 
    cQuery += " 	F3_CFO AS 'CFOP', " + CRLF 
    cQuery += " 	F3_ALIQICM AS 'ALIQ_ICMS', " + CRLF 
    cQuery += " 	FORMAT( ROUND(SUM(F3_VALCONT),2), 'C', 'PT-BR') AS 'VAL_CONTAB', " + CRLF 
    cQuery += " 	FORMAT( ROUND(SUM(F3_BASEICM),2), 'C', 'PT-BR') AS 'BASE_ICMS', " + CRLF 
    cQuery += " 	FORMAT( ROUND(SUM(F3_VALICM),2), 'C', 'PT-BR') AS 'VAL_ICMS', " + CRLF 
    cQuery += " 	FORMAT( ROUND(SUM(F3_ISENICM),2), 'C', 'PT-BR') AS 'VAL_ISEN_ICMS', " + CRLF 
    cQuery += " 	FORMAT( ROUND(SUM(F3_OUTRICM),2), 'C', 'PT-BR') AS 'VAL_OUT_ICMS' " + CRLF 
    cQuery += " FROM " + RetSqlName("SF3") +  " SF3 " + CRLF 
    cQuery += " WHERE F3_FILIAL != '' " + CRLF 
 	cQuery += " 	AND SUBSTRING(F3_ENTRADA,1,8) BETWEEN '"+DTOS(aRet[3])+"' AND '"+DTOS(aRet[4])+"' " + CRLF 
 	cQuery += " 	AND F3_ESTADO BETWEEN '"+aRet[1]+"' AND '"+aRet[2]+"' " + CRLF
 	cQuery += " 	AND D_E_L_E_T_ != '*'  " + CRLF
 	cQuery += " 	AND F3_DTCANC  = ''  " + CRLF
 	cQuery += " GROUP BY F3_FILIAL, F3_ESTADO, F3_CFO, F3_ALIQICM " + CRLF 
 	cQuery += " ORDER BY 1,3 " + CRLF 
    
    TCQuery cQuery New Alias "QRP"
    
     //Aba 02 - Teste
    oFWMsExcel:AddworkSheet("Apuração Fiscal") //Não utilizar número junto com sinal de menos. Ex.: 1-
	
	//Nota Planilha Apuração
	oFWMsExcel:AddTable("Apuração Fiscal","Apuração Fiscal - Aglutinado CFOP")
	
	//Criando Colunas
    oFWMsExcel:AddColumn("Apuração Fiscal","Apuração Fiscal - Aglutinado CFOP","Filial"	,1,1)
	oFWMsExcel:AddColumn("Apuração Fiscal","Apuração Fiscal - Aglutinado CFOP","Estado"	,1,1)
	oFWMsExcel:AddColumn("Apuração Fiscal","Apuração Fiscal - Aglutinado CFOP","CFOP"	,1,1)
	oFWMsExcel:AddColumn("Apuração Fiscal","Apuração Fiscal - Aglutinado CFOP","VAL_CONTAB",3,3)
	oFWMsExcel:AddColumn("Apuração Fiscal","Apuração Fiscal - Aglutinado CFOP","BASE_ICMS",3,3)
	oFWMsExcel:AddColumn("Apuração Fiscal","Apuração Fiscal - Aglutinado CFOP","ALIQ ICMS",3,2)
	oFWMsExcel:AddColumn("Apuração Fiscal","Apuração Fiscal - Aglutinado CFOP","VAL_ICMS",3,3)
	oFWMsExcel:AddColumn("Apuração Fiscal","Apuração Fiscal - Aglutinado CFOP","VAL_ISEN_ICMS",3,3)
	oFWMsExcel:AddColumn("Apuração Fiscal","Apuração Fiscal - Aglutinado CFOP","VAL_OUT_ICMS",3,3)
	
	Do While !(QRP->(EoF()))
		
		 oFWMsExcel:AddRow("Apuração Fiscal","Apuração Fiscal - Aglutinado CFOP",{QRP->F3_FILIAL,;
				                                                                    QRP->ESTADO,;
				                                                                    QRP->CFOP,;			                                                                    
				                                                                    QRP->VAL_CONTAB,;
				                                                                    QRP->BASE_ICMS,;
				                                                                    QRP->ALIQ_ICMS,;
				                                                                    QRP->VAL_ICMS,;
				                                                                    QRP->VAL_ISEN_ICMS,;
				                                                                    QRP->VAL_OUT_ICMS })
	    	
    	//Gração dos dados
		IncProc( "Exportando dados Excel" )
    			
		//Pulando Registro
    	QRP->(DbSkip())
    EndDo
	
	//Ativando o arquivo e gerando o xml
    oFWMsExcel:Activate()
    oFWMsExcel:GetXMLFile(cArquivo)
         
    //Abrindo o excel e abrindo o arquivo xml
    oExcel := MsExcel():New()             //Abre uma nova conexão com Excel
    oExcel:WorkBooks:Open(cArquivo)     //Abre uma planilha
    oExcel:SetVisible(.T.)                 //Visualiza a planilha
    oExcel:Destroy()                        //Encerra o processo do gerenciador de tarefas
     
    QRY->(DbCloseArea())
    QRP->(DbCloseArea())
    RestArea(aArea)
	
	MsgInfo("Arquivo gerado com sucesso " + cArquivo)
	
Return