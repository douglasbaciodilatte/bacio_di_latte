#Include "Protheus.ch"
#Include "TopConn.ch"

/*/{Protheus.doc} User Function RELESTA9
    (long_description)
    @type  Function
    @author Douglas Rodrigues da Silva
    @since 17/05/2021
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function RELESTA9()

Local aParamBox	    := {}
Private aRet		:= {}

aAdd(aParamBox,{1,"Filial  "	,Space(4),"","","SM0","",50,.F.}) 
aAdd(aParamBox,{1,"Armazem "	,Space(6),"","","NNR","",50,.F.}) 

If ParamBox(aParamBox ,"Parametros ",aRet)	
	MsAguarde({|| GeraExcel()},,"O arquivo Excel esta sendo gerado...")
EndIf

Return Nil

Static Function GeraExcel()
    
    Local aArea        := GetArea()
    Local cQuery        := ""
    Local oFWMsExcel
    Local oExcel
    Local cArquivo    := GetTempPath()+'RELESTA9.xml'

    cQuery := " SELECT "
	cQuery += " TEMP.FILIAL,  "
	cQuery += " TEMP.ARMAZEM, " 
	cQuery += " TEMP.PRODUTO, " 
	cQuery += " TEMP.DESCRI, " 
	cQuery += " TEMP.TIPO, " 
	cQuery += " TEMP.LOTE, " 
	cQuery += " TEMP.CONV, " 
	cQuery += " TEMP.UND1, " 
	cQuery += " TEMP.SALDO_SISTEMA_1 AS 'SALDO1', " 
	cQuery += " ISNULL(SUM(SB8.B8_SALDO),0) AS 'SALDOL1', "
	cQuery += " TEMP.UND2, " 
	cQuery += " TEMP.SALDO_SISTEMA_2 AS 'SALDO2', "
	cQuery += " ISNULL(SUM(SB8.B8_SALDO2),0) AS 'SALDOL2' "
    cQuery += " FROM ( SELECT SB2.B2_FILIAL 'FILIAL', "
	cQuery += " SB2.B2_LOCAL 'ARMAZEM', "
	cQuery += " SB2.B2_COD 'PRODUTO', "
	cQuery += " SB1.B1_DESC 'DESCRI', "
	cQuery += " SB1.B1_TIPO 'TIPO', "
	cQuery += " B1_RASTRO 'LOTE', "
	cQuery += " SB1.B1_CONV 'CONV', "
	cQuery += " SB1.B1_UM 'UND1', "
	cQuery += " SB2.B2_QATU 'SALDO_SISTEMA_1', "	   	
	cQuery += " SB1.B1_SEGUM 'UND2', "
	cQuery += " SB2.B2_QTSEGUM 'SALDO_SISTEMA_2' "
    cQuery += " FROM " + RetSqlName("SB2") + " SB2 "
    cQuery += " JOIN " + RetSqlName("SB1") + " SB1  "
	cQuery += " 			ON SB1.B1_FILIAL = ''  "
	cQuery += " 			AND SB1.B1_COD = SB2.B2_COD "
	cQuery += " 			AND SB1.D_E_L_E_T_ != '*' "
    cQuery += " WHERE SB2.B2_FILIAL = '" + MV_PAR01 + "' "
	cQuery += " AND SB2.B2_LOCAL = '" + MV_PAR02 + "' "
	cQuery += " AND SB2.D_E_L_E_T_ != '*') TEMP "
    cQuery += " LEFT JOIN " + RetSqlName("SB8") + " SB8 WITH (NOLOCK) ON SB8.B8_FILIAL = TEMP.FILIAL AND SB8.B8_PRODUTO = TEMP.PRODUTO AND SB8.B8_SALDO != 0 AND SB8.D_E_L_E_T_ != '*' AND SB8.B8_LOCAL = TEMP.ARMAZEM "
    cQuery += " GROUP BY TEMP.FILIAL,  "
	cQuery += " TEMP.ARMAZEM,  "
	cQuery += " TEMP.PRODUTO,  "
	cQuery += " TEMP.DESCRI,  "
	cQuery += " TEMP.TIPO,  "
	cQuery += " TEMP.LOTE,  "
	cQuery += " TEMP.CONV,  "
	cQuery += " TEMP.UND1,  "
	cQuery += " TEMP.SALDO_SISTEMA_1,  "
	cQuery += " TEMP.UND2,  "
	cQuery += " TEMP.SALDO_SISTEMA_2 "
    cQuery += " ORDER BY 1,2,3 "

    TCQuery cQuery New Alias "TMP"
     
    //Criando o objeto que irá gerar o conteúdo do Excel
    oFWMsExcel := FWMSExcel():New()

    //Aba 01 - Teste
    oFWMsExcel:AddworkSheet("Saldo") //Não utilizar número junto com sinal de menos. Ex.: 1-

    //Criando a Tabela
    oFWMsExcel:AddTable("Saldo","Saldo Sistema")

    //Criando Colunas
    oFWMsExcel:AddColumn("Saldo","Saldo Sistema","FILIAL",1,1) //1 = Modo Texto
    oFWMsExcel:AddColumn("Saldo","Saldo Sistema","ARMAZEM",1,1) //1 = Modo Texto
    oFWMsExcel:AddColumn("Saldo","Saldo Sistema","PRODUTO",1,1) //1 = Modo Texto
    oFWMsExcel:AddColumn("Saldo","Saldo Sistema","DESCRI",1,1) //1 = Modo Texto
    oFWMsExcel:AddColumn("Saldo","Saldo Sistema","TIPO",1,1) //1 = Modo Texto
    oFWMsExcel:AddColumn("Saldo","Saldo Sistema","LOTE",1,1) //1 = Modo Texto
    oFWMsExcel:AddColumn("Saldo","Saldo Sistema","CONV",1,1) //1 = Modo Texto
    oFWMsExcel:AddColumn("Saldo","Saldo Sistema","UND1",1,1) //1 = Modo Texto
    oFWMsExcel:AddColumn("Saldo","Saldo Sistema","SALDO_SISTEMA_1",2,2) //2 = Modo Texto
    oFWMsExcel:AddColumn("Saldo","Saldo Sistema","SALDO_LOTE1",2,2) //2 = Modo Texto
    oFWMsExcel:AddColumn("Saldo","Saldo Sistema","UND2",1,1) //2 = Modo Texto
    oFWMsExcel:AddColumn("Saldo","Saldo Sistema","SALDO_SISTEMA_2",2,2) //2 = Modo Texto
    oFWMsExcel:AddColumn("Saldo","Saldo Sistema","SALDO_LOTE2",2,2) //2 = Modo Texto


        //Criando as Linhas... Enquanto não for fim da query
        While !(TMP->(EoF()))
        oFWMsExcel:AddRow("Saldo","Saldo Sistema",{TMP->FILIAL,;
                                                   TMP->ARMAZEM,;
                                                   TMP->PRODUTO,;
                                                   TMP->DESCRI,;
                                                   TMP->TIPO,;
                                                   TMP->LOTE,;
                                                   TMP->CONV,;
                                                   TMP->UND1,;
                                                   TMP->SALDO1,;
                                                   TMP->SALDOL1,;
                                                   TMP->UND2,;
                                                   TMP->SALDO2,;
                                                   TMP->SALDOL2})
         
            //Pulando Registro
            TMP->(DbSkip())
        EndDo

    //Ativando o arquivo e gerando o xml
    oFWMsExcel:Activate()
    oFWMsExcel:GetXMLFile(cArquivo)
         
    //Abrindo o excel e abrindo o arquivo xml
    oExcel := MsExcel():New()             //Abre uma nova conexão com Excel
    oExcel:WorkBooks:Open(cArquivo)     //Abre uma planilha
    oExcel:SetVisible(.T.)                 //Visualiza a planilha
    oExcel:Destroy()                        //Encerra o processo do gerenciador de tarefas
     
    TMP->(DbCloseArea())    
    RestArea(aArea)

Return 

