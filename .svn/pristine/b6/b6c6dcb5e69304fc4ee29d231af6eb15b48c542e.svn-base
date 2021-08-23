/*//#########################################################################################
Modulo  : Estoque
Fonte   : blestr12
Objetivo: Relatório de Inventário Pendente
*///#########################################################################################

#INCLUDE 'TOTVS.CH'
#INCLUDE 'REPORT.CH'

/*/{Protheus.doc} blestr13
   Gerenciador de Processamento
   @author  Douglas Rodrigues da Silva
   @table   Tabelas
   @since   28-01-2020
/*/
User Function BLESTR13()
  
  	Local aParamBox := {}
	
	Private aRet := {}
		
	aAdd(aParamBox,{1,"Data Inventário"  ,Ctod(Space(8)),"","","","",50,.T.})
	
	
	If ParamBox(aParamBox,"Extrator Dados...",@aRet)
	
		
		xProc9(aRet[1])
	
	EndIf

Return


Static Function xProc9(dData)
	
	cQuery := " WITH INV AS (SELECT DISTINCT B7_FILIAL, B7_LOCAL FROM "+RetSQLName("SB7")+" " 
	cQuery += " 	WHERE B7_DATA = CONVERT(VARCHAR(8), '"+DTOS(dData)+"', 112) AND D_E_L_E_T_ = '') "
	cQuery += " 	SELECT NNR_CODIGO, NNR_DESCRI "
	cQuery += " 	FROM "+RetSQLName("NNR")+" NNR "
	cQuery += " 	LEFT JOIN INV ON NNR_CODIGO = B7_LOCAL AND NNR.D_E_L_E_T_ = ''WHERE B7_LOCAL IS NULL AND NNR_XINV = 'S' "
	
	U_QRYCSV(cQuery,"SB7 - Inventário Pendente")

Return