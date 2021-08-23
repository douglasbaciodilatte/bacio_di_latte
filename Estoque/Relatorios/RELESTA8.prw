//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"
#include 'parmtype.ch'
#Include 'Report.ch'

#DEFINE NOME_REL   'RELESTA8'
#DEFINE TITULO_REL 'Relat�rio de Inventario'
#DEFINE DESCRI_REL ''
#DEFINE ABA_PLAN   ''

Static eol       := chr(13) + chr(10)

//
//Programa principal para a Gera��o do relatorio de descarte para rodar direto do menu
//Sera 
//

User Function RELESTA8()
Private cPerg := "RELESTA802"
Private aCab  := {}
Private aCols := {}

    ValidPerg()                         //Valida se a Pergunte existe

    if Pergunte(cPerg,.t.)              //Chama a Pengunte
        xCab()                          //Cria a Array com o cabe�alho
        fquery()                        //Consulta principal com os descarte
        xAcols()                        //cria a acols dom os dados da consulta
        IF LEN(aCols) > 0               //Veiricar se existe dados para impress�o
            _imprel(aCab,aCols)         //Imprime o relatorio
        else
            MsgInfo("N�o a Dados para Gerar o Relat�rio", "Aten��o")
        endif
    endif

Return

//
//Monta o cabe�alhao do Relatorio
//

static Function xCab()
        
    aAdd(aCab, {"Produto"           , "PRODUTO"     ,""                 ,TamSX3("B1_COD" )[01]+5, 0})
    aAdd(aCab, {"Descri��o"         , "DERSCRI"     ,""                 ,TamSX3("B1_DESC")[01]+10, 0})
    aAdd(aCab, {"Unidade"           , "UNIDADE"     , ""                ,TamSX3("B1_UM")[01]  , 0})
    aAdd(aCab, {"Lote"              , "LOTE"        , ""                ,10                   , 0})
    aAdd(aCab, {"Armaz�m"           , "ARMAZ"       , ""                ,10                   , 0})
    aAdd(aCab, {"Inventario"        , "INVENTARIO"  , "@E 999,999.99"   ,010                  , 2})
    aAdd(aCab, {"Saldo Siatema"     , "SALDO_SITEMA", "@E 999,999.99"   ,010                  , 2})
    aAdd(aCab, {"Saldo Lote"        , "SALDO_LOTE"  , "@E 999,999.99"   ,010                  , 2})
    
return

//
//Cria a um matriz com os dados da consulta para a impress�o do relatorio
//

Static function xAcols()

    DbSelectArea("TRB1")
    TRB1->(DbGotop())
    
    While TRB1->(!EOF())

        AAdd(aCols,{TRB1->PRODUTO,TRB1->DESCRI,TRB1->UNIDADE,TRB1->LOTE,TRB1->ARMAZ,TRB1->INVENTARIO,TRB1->SALDO_SISTEMA,TRB1->SALDO_LOTE,.F.})
    
        TRB1->(dbskip())
    
    EndDo

Return

//-----------------------------------------------------------------------
// Rotina | xArray       | Autor | Robson Luiz - Rleg | Data | 04.04.2013
//-----------------------------------------------------------------------
// Descr. | Tratamento de impress�o dos dados por meio de um Array.
//-----------------------------------------------------------------------
// Uso    | 
//-----------------------------------------------------------------------
Static Function xArray( )
Local oReport
Local nI     := 0
Local nX     := 0
Local nTm    := 0
Local aCpo   := {}
local aDados := {}
local aCab   := {}
    
Local nPosCod   := aScan(aCabAux, {|x| Alltrim(x[2]) == "PRODUTO"      })
Local nPosQuant := aScan(aCabAux, {|x| Alltrim(x[2]) == "DESCRI"       })
Local nPosTM    := aScan(aCabAux, {|x| Alltrim(x[2]) == "UNIDADE"      })
Local nPosUM1   := aScan(aCabAux, {|x| Alltrim(x[2]) == "LOTE"         })
Local nPosUM2   := aScan(aCabAux, {|x| Alltrim(x[2]) == "ARMAZ"        })
Local nPosLocal := aScan(aCabAux, {|x| Alltrim(x[2]) == "INVENTARIO"   })
Local nPosCust  := aScan(aCabAux, {|x| Alltrim(x[2]) == "SALDO_SISTEMA"})
Local nPosCust  := aScan(aCabAux, {|x| Alltrim(x[2]) == "SALDO_LOTE"   })
   
    For nI := 1 To Len( aCabAux)
        AAdd( aCab, {RTrim(aCabAux[nI,1] ),aCabAux[nI,4]}  )
    Next nI

    For nI := 1 to len(aDAux)
        aCpo := {}

        if !(aDAux[nI,len(aDAux[nI])])
            
            for nX := 1 to len(aDAux[nI])-1
                aadd(aCpo,aDAux[nI,nX])
            Next nX

            AAdd( aDados, aCpo ) 
        endif

    Next nI

    If Len( aDados ) > 0

        oReport := xDefArray( aDados, aCab )
        oReport:PrintDialog()

    Else

        MsgInfo('N�o foi poss�vel localizar os dados, verifique os par�metros.',cCadastro)

    Endif

Return

//-----------------------------------------------------------------------
// Rotina | xTReport     | Autor | Robson Luiz - Rleg | Data | 04.04.2013
//-----------------------------------------------------------------------
// Descr. | Esta rotina exemplifica a utiliza��o do TReport.
//-----------------------------------------------------------------------
// Uso    | Oficina de Programa��o
//-----------------------------------------------------------------------

Static Function _imprel(aHead,aCol)

Private cCadastro := ABA_PLAN
Private cOpcRel   := 'Relat�rio de Descarte'
Private aCabAux   := aClone(aHead)
Private aDAux     := aClone(aCol)

    xArray( )

Return

//-----------------------------------------------------------------------
// Rotina | xDefArray    | Autor | Reinaldo Rabelo  | Data | 01.04.2021 |
//-----------------------------------------------------------------------
// Descr. | Defini��o de impress�o dos dados do array.
//-----------------------------------------------------------------------
// Uso    | Oficina de Programa��o
//-----------------------------------------------------------------------
Static Function xDefArray( aCOLS, aHeader )
Local oReport
Local oSection 
Local nX := 0

    /*
    +-------------------------------------+
    | M�todo construtor da classe TReport |
    +-------------------------------------+
    New(cReport,cTitle,uParam,bAction,cDescription,lLandscape,uTotalText,lTotalInLine,cPageTText,lPageTInLine,lTPageBreak,nColSpace)
    
    cReport            - Nome do relat�rio. Exemplo: MATR010
    cTitle            - T�tulo do relat�rio
    uParam            - Par�metros do relat�rio cadastrado no Dicion�rio de Perguntas (SX1). Tamb�m pode ser utilizado bloco de c�digo para par�metros customizados.
    bAction            - Bloco de c�digo que ser� executado quando o usu�rio confirmar a impress�o do relat�rio
    cDescription    - Descri��o do relat�rio
    lLandscape        - Aponta a orienta��o de p�gina do relat�rio como paisagem
    uTotalText        - Texto do totalizador do relat�rio, podendo ser caracter ou bloco de c�digo
    lTotalInLine    - Imprime as c�lulas em linha
    cPageTText        - Texto do totalizador da p�gina
    lPageTInLine    - Imprime totalizador da p�gina em linha
    lTPageBreak        - Quebra p�gina ap�s a impress�o do totalizador
    nColSpace        - Espa�amento entre as colunas
    
    Retorno    Objeto
    */
    oReport := TReport():New( NOME_REL, TITULO_REL, , {|oReport| xImprArray( oReport, aCOLS )}, DESCRI_REL + cOpcRel )
    
    DEFINE SECTION oSection OF oReport TITLE ABA_PLAN TOTAL IN COLUMN

    nX := 0

    DEFINE CELL NAME "CEL"+Alltrim(Str(nX   )) OF oSection SIZE 020 TITLE aHeader[01,1]
    DEFINE CELL NAME "CEL"+Alltrim(Str(nX+01)) OF oSection SIZE 050 TITLE aHeader[02,1]
    DEFINE CELL NAME "CEL"+Alltrim(Str(nX+02)) OF oSection SIZE 010 TITLE aHeader[03,1]
    DEFINE CELL NAME "CEL"+Alltrim(Str(nX+03)) OF oSection SIZE 015 TITLE aHeader[04,1]
    DEFINE CELL NAME "CEL"+Alltrim(Str(nX+04)) OF oSection SIZE 015 TITLE aHeader[05,1]
    DEFINE CELL NAME "CEL"+Alltrim(Str(nX+05)) OF oSection SIZE 015 TITLE aHeader[06,1]
    DEFINE CELL NAME "CEL"+Alltrim(Str(nX+06)) OF oSection SIZE 015 TITLE aHeader[07,1]
    DEFINE CELL NAME "CEL"+Alltrim(Str(nX+07)) OF oSection SIZE 015 TITLE aHeader[08,1]
    
    /*
    +---------------------------------------+    
    | Define o espa�amento entre as colunas |
    +---------------------------------------+
    SetColSpace(nColSpace,lPixel)
    nColSpace    - Tamanho do espa�amento
    lPixel        - Aponta se o tamanho ser� calculado em pixel
    */
    
    oSection:SetColSpace(1,.T.)
       
    // Quantidade de linhas a serem saltadas antes da impress�o da se��o
    oSection:nLinesBefore := 1
       /*
    +--------------------------------------------------------------------------------------------------------------+
    | Define que a impress�o poder� ocorrer emu ma ou mais linhas no caso das colunas exederem o tamanho da p�gina |
    +--------------------------------------------------------------------------------------------------------------+
    SetLineBreak(lLineBreak)
    
    lLineBreak - Se verdadeiro, imprime em uma ou mais linhas
    */
    oSection:SetLineBreak(.T.)


Return( oReport )

//-----------------------------------------------------------------------
// Rotina | xImprArray  | Autor | Reinaldo Rabelo    | Data | 01.04.2021|
//-----------------------------------------------------------------------
// Descr. | Impress�o dos dos dados do array.
//-----------------------------------------------------------------------
// Uso    | Oficina de Programa��o
//-----------------------------------------------------------------------
Static Function xImprArray( oReport, aCOLS )
Local oSection := oReport:Section(1) // Retorna objeto da classe TRSection (se��o). Tipo Caracter: T�tulo da se��o. Tipo Num�rico: �ndice da se��o segundo a ordem de cria��o dos componentes TRSection.
Local nX := 0
Local nY := 0
Local nTotal := 0
    
    /*
    +-----------------------------------------------------+
    | Define o limite da r�gua de progress�o do relat�rio |
    +-----------------------------------------------------+
    SetMeter(nTotal)
    nTotal - Limite da r�gua
    */

    oReport:SetMeter( Len( aCOLS ) )    
    
    /*
    +---------------------------------------------------------------------+
    | Inicializa as configura��es e define a primeira p�gina do relat�rio |
    +---------------------------------------------------------------------+
    Init()
    
    N�o � necess�rio executar o m�todo Init se for utilizar o m�todo Print, j� que estes fazem o controle de inicializa��o e finaliza��o da impress�o.
    */
    oSection:Init()
    
    For nX := 1 To Len( aCOLS )

        // Retorna se o usu�rio cancelou a impress�o do relat�rio
        If oReport:Cancel()
            Exit
        EndIf
        
        For nY := 1 To Len(aCOLS[ nX ])

           If ValType( aCOLS[ nX, nY ] ) == 'D'
               // Cell() - Retorna o objeto da classe TRCell (c�lula) baseado. Tipo Caracter: Nome ou t�tulo do objeto. Tipo Num�rico: �ndice do objeto segundo a ordem de cria��o dos componentes TRCell.
               // SetBlock() - Define o bloco de c�digo que retornar� o conte�do de impress�o da c�lula. Definindo o bloco de c�digo para a c�lula, esta n�o utilizara mais o nome mais o alias para retornar o conte�do de impress�o.
               oSection:Cell("CEL"+Alltrim(Str(nY-1))):SetBlock( &("{ || '" + Dtoc(aCOLS[ nX, nY ]) + "'}") )

           Elseif ValType( aCOLS[ nX, nY ] ) == 'N'

               oSection:Cell("CEL"+Alltrim(Str(nY-1))):SetBlock( &("{ || '" + TransForm(aCOLS[ nX, nY ],'@E 99,999,999.99') + "'}") )

           Else

               oSection:Cell("CEL"+Alltrim(Str(nY-1))):SetBlock( &("{ || '" + aCOLS[ nX, nY ] + "'}") )

           Endif

        Next

        // Incrementa a r�gua de progress�o do relat�rio
        oReport:IncMeter()

        /*
        +------------------------------------------------+
        | Imprime a linha baseado nas c�lulas existentes |
        +------------------------------------------------+
        PrintLine(lEvalPosition,lParamPage,lExcel)
        
        lEvalPosition    - For�a a atualiza��o do conte�do das c�lulas 
        lParamPage        - Aponta que � a impress�o da p�gina de par�metros
        lExcel            - Aponta que � gera��o em planilha

        */
        oSection:PrintLine()

    Next
    //oReport:ThinLine()
    oSection:Finish()
    /*
    Finaliza a impress�o do relat�rio, imprime os totalizadores, fecha as querys e �ndices tempor�rios, entre outros tratamentos do componente.
    N�o � necess�rio executar o m�todo Finish se for utilizar o m�todo Print, j� que este faz o controle de inicializa��o e finaliza��o da impress�o.
    */

Return

//***************************************************************************************************************************

//***************************************************************************************************************************

//Consulta principal do relatorio
Static function fquery()
Local cQuery := ''
Local cDatRet:= SubStr(DtoS(MV_PAR04),1,6)

    cQuery := " SELECT  TEMP.FILIAL, " + eol
	cQuery += " 	TEMP.PRODUTO, " + eol
	cQuery += " 	TEMP.DESCRI, " + eol
	cQuery += " 	TEMP.UNIDADE, " + eol
	cQuery += " 	TEMP.LOTE, " + eol
	cQuery += " 	TEMP.ARMAZ, " + eol
	cQuery += " 	TEMP.INVENTARIO, " + eol
	cQuery += " 	TEMP.SALDO_SISTEMA, " + eol
	cQuery += " 	SUM(ISNULL(B8_SALDO,0)) AS 'SALDO_LOTE'  " + eol
	cQuery += " FROM ( " + eol

    cQuery += "    SELECT " + eol
    cQuery += "          B7_FILIAL     AS 'FILIAL', " + eol
    cQuery += "          B7_COD        AS 'PRODUTO', " + eol
    cQuery += "          B1_RASTRO     AS 'LOTE', " + eol
    cQuery += "          SB1.B1_DESC   AS 'DESCRI', " + eol
    cQuery += "          SUM(B7_QUANT) AS 'INVENTARIO', " + eol
    cQuery += "          B2_QATU       AS 'SALDO_SISTEMA', " + eol
    cQuery += "          B1_UM         AS 'UNIDADE', " + eol
    cQuery += "          B7_LOCAL      AS 'ARMAZ' " + eol

    cQuery += "    FROM " + RetSqlName("SB7") + " SB7 WITH (NOLOCK) " + eol
		   
	cQuery += " 	   JOIN  " + RetSqlName("SB1") + " SB1 WITH (NOLOCK)  " + eol
	cQuery += " 			 ON SB1.B1_FILIAL   = ''  " + eol
	cQuery += " 			AND SB1.B1_COD      = B7_COD  " + eol
	cQuery += " 			AND SB1.D_E_L_E_T_ != '*' " + eol
		   
	cQuery += " 	   JOIN " + RetSqlName("SB2") + " SB2 WITH (NOLOCK)  " + eol
	cQuery += " 			 ON SB2.B2_FILIAL   = SB7.B7_FILIAL  " + eol
	cQuery += " 			AND SB2.B2_COD      = B7_COD  " + eol
	cQuery += " 			AND SB2.D_E_L_E_T_ != '*'  " + eol
	cQuery += " 			AND SB2.B2_LOCAL    = SB7.B7_LOCAL  " + eol
	cQuery += " 			AND SB2.D_E_L_E_T_ != '*' " + eol

	cQuery += " 		WHERE B7_FILIAL = '" + MV_PAR01 + "' " + eol
	cQuery += " 			AND SUBSTRING(B7_DATA,1,6) = '" + cDatRet + "' " + eol
	cQuery += " 			AND SB7.B7_LOCAL  between '" + mv_par02 + "' and '" + mv_par03 + "' " + eol
	cQuery += " 			AND SB7.D_E_L_E_T_        != '*' " + eol

	cQuery += " 		GROUP BY SB7.B7_FILIAL,  " + eol
	cQuery += " 			SB7.B7_COD, " + eol
	cQuery += " 			SB2.B2_QATU, " + eol
	cQuery += " 			SB1.B1_RASTRO,  " + eol
	cQuery += " 			SB1.B1_DESC,  " + eol
	cQuery += " 			SB1.B1_UM,  " + eol
	cQuery += " 			SB7.B7_LOCAL " + eol
	
    cQuery += " 	) AS TEMP " + eol

    cQuery += "     LEFT JOIN " + RetSqlName("SB8") + " SB8 WITH (NOLOCK) " + eol
	cQuery += " 		 ON SB8.B8_FILIAL   = TEMP.FILIAL  " + eol
	cQuery += " 		AND SB8.B8_PRODUTO  = TEMP.PRODUTO  " + eol
	cQuery += " 		AND SB8.B8_SALDO   != 0  " + eol
	cQuery += " 		AND SB8.D_E_L_E_T_ != '*'  " + eol
	cQuery += " 		AND SB8.B8_LOCAL    = TEMP.ARMAZ " + eol

    cQuery += "    GROUP BY TEMP.FILIAL, " + eol
	cQuery += " 			TEMP.PRODUTO,  " + eol
	cQuery += " 			TEMP.DESCRI,  " + eol
	cQuery += " 			TEMP.LOTE,  " + eol
	cQuery += " 			TEMP.INVENTARIO,  " + eol
	cQuery += " 			TEMP.SALDO_SISTEMA,  " + eol
	cQuery += " 			TEMP.UNIDADE,  " + eol
	cQuery += " 			TEMP.ARMAZ " + eol

    //memowrite('C:\temp\Inv_query.sql',cQuery)
    
    TCQUERY cQuery NEW ALIAS "TRB1"
    
Return

//********************************************************************************************************

//Valida se a Pergunte Existe, caso n�o exista sera criada

//*******************************************************************************************************
Static Function ValidPerg()
Local _sAlias := Alias()

    dbSelectArea("SX1")
    dbSetOrder(1)

    cPerg := PADR(cPerg,10)
    aRegs :={}

    aAdd(aRegs,{cPerg,"01","Filial"         ,"","","mv_ch1","C",TamSX3('B1_FILIAL')[1],0,0,"G","","mv_par01",""       ,""       ,""       ,"","",""       ,""       ,""       ,"","","","","","","","","","","","","","","","","","","",""})
    aAdd(aRegs,{cPerg,"02","De Armazem"     ,"","","mv_ch2","C",TamSX3('B1_LOCPAD')[1],0,0,"G","","mv_par02",""       ,""       ,""       ,"","",""       ,""       ,""       ,"","","","","","","","","","","","","","","","","","","NNR",""})
    aAdd(aRegs,{cPerg,"03","At� Armazem"    ,"","","mv_ch3","C",TamSX3('B1_LOCPAD')[1],0,0,"G","","mv_par03",""       ,""       ,""       ,"","",""       ,""       ,""       ,"","","","","","","","","","","","","","","","","","","NNR",""})
    aAdd(aRegs,{cPerg,"04","Data Referencia","","","mv_ch4","D",10                    ,0,0,"G","","mv_par04",""       ,""       ,""       ,"","",""       ,""       ,""       ,"","","","","","","","","","","","","","","","","","","",""})

    For i := 1 to Len(aRegs)

        If !dbSeek(cPerg+aRegs[i,2])

            RecLock("SX1",.T.)

                For j := 1 to FCount()
                    If j <= Len(aRegs[i])
                        FieldPut(j,aRegs[i,j])
                    Else
                        exit
                    Endif
                Next
            
            SX1->(MsUnlock())
        
        Endif
    
    Next
    
    dbSelectArea(_sAlias)

Return
