#INCLUDE "Protheus.Ch"
//#INCLUDE "RWMAKE.CH"  

/*/
_____________________________________________________________________________
¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Função    ¦ PONCALD ()     ¦ Autor ¦ JORGE SATO    ¦ Data ¦ 26/06/2019 ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Descriçào ¦ Este ponto de entrada nao contem nenhum parametro de       ¦¦¦
¦¦¦-----------------------------------------------------------------------¦¦¦
¦¦¦entrada e/ou saida, portanto pode ser utilizado somente para           ¦¦¦
¦¦¦incluir/alterar/excluir registros dos arquivos SPB e SPI.              ¦¦¦
¦¦¦Estes arquivos nao estarao sincronizados com o cadastro de             ¦¦¦
¦¦¦funcionarios(SRA) no momento da chamada.                               ¦¦¦
¦¦+----------+------------------------------------------------------------¦¦¦
¦¦¦Uso       ¦ BACIO DI LATTE                                             ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Histórico de Alterações	    					                      ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Data      ¦ Analista            		                                  ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦          ¦     					                                      ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦¦Descricao ¦                                                            ¦¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¦¦+-----------------------------------------------------------------------+¦¦
¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯
/*/

User Function PONCALD()
Local cMatr    := " "
Local _cQuery  := " "
Local cFlll    := " "
Local cDessa   := " "
Local cQuery1  := " "
Local cQuery2  := " "
Local cVerbPd  := " "
Private cPONSIND  := ""
Private cPONVERB  := ""
//Private cPSINDHE  := ""
//Private cPVERBHE  := ""
//Private cPSINDD   := ""
//Private cPVERBD   := ""

dbSelectArea("RCC")
dbSetorder(1)
if dbSeek(xfilial("RCC")+"U003")

	cQuery1  := " SELECT SUBSTRING(RCC_CONTEU,1,2) AS SIND,SUBSTRING(RCC_CONTEU,3,3) AS VERBANT,SUBSTRING(RCC_CONTEU,6,3) AS VERBPOS "
	cQuery1  += " FROM " + RetSqlName("RCC") + " RCC WHERE RCC_CODIGO ='U003' "
	dbUseArea(.T.,"TOPCOON",TcGenQry(,,cQuery1),"TRBRCC01",.F.,.T.)
	TRBRCC01->( dbGoTop() )
	WHILE !EOF()
			cPONSIND+=TRBRCC01->SIND
			cPONVERB+=TRBRCC01->VERBANT

            TRBRCC01->(DbSkip())
			
	ENDDO
	TRBRCC01->(DBCLOSEAREA())

		_cQuery  := " SELECT PB_DATA,PB_MAT,PB_FILIAL,PB_PD,RA_NOME,RA_SINDICA, PB_TIPO2 FROM "
		_cQuery  += " " + RetSqlName("SPB") + " SPB inner join " + RetSqlName("SRA") + " SRA "
		_cQuery  += " ON RA_FILIAL = PB_FILIAL AND RA_MAT = PB_MAT "
		_cQuery  += " WHERE RA_DEMISSA = ' ' AND RA_SINDICA IN(" + fSqlIN(cPONSIND, 2) + ") AND SPB.D_E_L_E_T_ <> '*' AND SRA.D_E_L_E_T_ <> '*' "
		_cQuery  += " AND PB_PD IN (" + fSqlIN(cPONVERB, 3) + ") "

		dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TRBPONTO",.F.,.T.)
		TRBPONTO->( dbGoTop() )
		
		
		WHILE !EOF()
			cMatr := (TRBPONTO->PB_MAT)
			cDessa := (TRBPONTO->PB_PD)
			_dDe2 := (TRBPONTO->PB_DATA)
			cFlll := (TRBPONTO->PB_FILIAL)
			cSindica := (TRBPONTO->RA_SINDICA)
			
			cQuery2  := " SELECT SUBSTRING(RCC_CONTEU,1,2) AS SIND,SUBSTRING(RCC_CONTEU,3,3) AS VERBANT,SUBSTRING(RCC_CONTEU,6,3) AS VERBPOS "
			cQuery2  += " FROM " + RetSqlName("RCC") + " RCC WHERE RCC_CODIGO ='U003' "
			cQuery2  += " AND RCC.D_E_L_E_T_ <> '*' AND SUBSTRING(RCC_CONTEU,1,2) = '" + cSindica +"' AND SUBSTRING(RCC_CONTEU,3,3) = '" + cDessa +"' "
			dbUseArea(.T.,"TOPCOON",TcGenQry(,,cQuery2),"TRBRCC02",.F.,.T.)

			TRBRCC02->( dbGoTop() )
			If Select("TRBRCC02") > 0
				cVerbPd := TRBRCC02->VERBPOS
				//Marca a verba CORRETA - para CADA SINDICATO REFERENTE AO ADICIONAL NOTURNO!!!
				TcSqlExec("UPDATE " + RetSqlName("SPB") + " SET PB_PD = '" + cVerbPd +"' WHERE PB_MAT = '" + cMatr +"' AND PB_FILIAL = '" + cFlll +"' AND  PB_DATA = '" +_dDe2+ "' AND PB_PD = '" +cDessa+ "' ")
				TcSqlExec("COMMIT")
			
				TRBRCC02->(DBCLOSEAREA())
			EndIf	
					
			TRBPONTO->(DbSkip())
			
		ENDDO
		
		TRBPONTO->(dbclosearea())
ENDIF

RETURN()


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ FSQLIN   ºAutor  ³ JORGE SATO        º Data ³  24/11/15    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Funcao para Montar a Selecao da Clausula IN do SQL.        º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ P12                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function fSqlIN( cTexto, nStep )

 Local cRet := ""
 Local i
 
 cTexto := Rtrim( cTexto )

 If Len( cTexto ) > 0
    For i := 1 To Len( cTexto ) Step nStep
        cRet += "'" + SubStr( cTexto, i, nStep ) + "'"
        
        If i + nStep <= Len( cTexto )
           cRet += ","
        EndIf
    Next
 EndIf

Return( cRet )