#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "TopConn.ch"

/*/{Protheus.doc} User Function SITEF004
    (long_description)
    @type  Function
    @author Douglas Rodrigues da Silva
    @since 22/07/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function SITEF004()

    Local aPergs 	:= {}
    Local aRet      := {}

    aAdd(aPergs,{1,"Data Credito"  ,Ctod(Space(8)),"","","","",50,.F.}) // Tipo data
   
    If ParamBox(aPergs ,"Processamento de Baixas...",aRet)
        processa( {|| Proc01(MV_PAR01) } ,'Aguarde Efetuando Importacao da Planilha' )
    EndIf

	Msginfo("Processamento concluído com sucesso!")

Return

Static Function Proc01(dData)

    cQuery := " SELECT " + CRLF
	cQuery += "     SE1.E1_FILIAL, " + CRLF
	cQuery += "     SE1.E1_PREFIXO, " + CRLF
	cQuery += "     SE1.E1_NUM, " + CRLF
	cQuery += "     SE1.E1_PARCELA, " + CRLF
	cQuery += "     SE1.E1_TIPO, " + CRLF
	cQuery += "     SE1.E1_NATUREZ, " + CRLF
	cQuery += "     SE1.E1_PORTADO, " + CRLF
	cQuery += "     SE1.E1_AGEDEP, " + CRLF
	cQuery += "     SE1.E1_CLIENTE, " + CRLF
	cQuery += "     SE1.E1_LOJA, " + CRLF
	cQuery += "     SE1.E1_NOMCLI, " + CRLF
	cQuery += "     SE1.E1_EMISSAO, " + CRLF
	cQuery += "     SE1.E1_VENCTO, " + CRLF
	cQuery += "     SE1.E1_VENCREA, " + CRLF
	cQuery += "     SE1.E1_VALOR, " + CRLF
	cQuery += "     SE1.E1_SALDO, " + CRLF
	cQuery += "     SE1.E1_VLRREAL, " + CRLF
	cQuery += "     SE1.E1_FILORIG, " + CRLF
	cQuery += "     SE1.E1_CCUSTO, " + CRLF
	cQuery += "     SE1.E1_VLRREAL, " + CRLF
	cQuery += "     FIF.FIF_VLLIQ, " + CRLF
	cQuery += "     SE1.E1_DESCONT, " + CRLF
	cQuery += "     FIF.FIF_DTCRED, " + CRLF
	cQuery += "     FIF.FIF_CODBCO, " + CRLF
	cQuery += "     FIF.FIF_CODAGE, " + CRLF
	cQuery += "     FIF.FIF_NUMCC, " + CRLF
	cQuery += "     FIF.R_E_C_N_O_ REGFIF" + CRLF
    cQuery += " FROM " + CRLF 
	cQuery += "     "+RETSQLNAME("FIF")+" FIF " + CRLF
    
	cQuery += " JOIN "+RETSQLNAME("ZZ2")+" ZZ2 " + CRLF 
	cQuery += "  	ON ZZ2.ZZ2_CODRED = FIF.FIF_CODRED " + CRLF 
	cQuery += "  	AND ZZ2.ZZ2_CODBAN = FIF.FIF_CODBAN " + CRLF 
	cQuery += "  	AND ZZ2.D_E_L_E_T_ != '*'" + CRLF 
	
	cQuery += " JOIN " + CRLF 
	cQuery += "     "+RETSQLNAME("SE1")+" SE1 " + CRLF
	
	cQuery += "    ON SE1.E1_FILIAL = ''  " + CRLF 
    cQuery += "    AND SE1.E1_NSUTEF =  IIF ( LEN(FIF_NSUTEF) > 6, FIF_NSUTEF, REPLICATE('0', 6 - LEN(FIF_NSUTEF)) + RTrim(FIF_NSUTEF) ) " + CRLF 
    cQuery += "    AND SE1.E1_FILORIG = FIF.FIF_CODFIL " + CRLF  
    cQuery += "    AND SE1.E1_EMISSAO = FIF.FIF_DTTEF " + CRLF  
    cQuery += "    AND SE1.E1_VLRREAL = FIF.FIF_VLBRUT " + CRLF
	cQuery += "    AND SE1.E1_VENCREA = FIF.FIF_DTCRED " + CRLF
	cQuery += "    AND SE1.E1_CLIENTE = ZZ2_CODADM " + CRLF
    cQuery += "    AND SE1.D_E_L_E_T_ != '*' " + CRLF 

    cQuery += " LEFT JOIN " + CRLF 
	cQuery += "     "+RETSQLNAME("ZCZ")+" ZCZ " + CRLF 
	cQuery += "     ON ZCZ.ZCZ_FILORI = SE1.E1_FILORIG " + CRLF
	cQuery += "     AND ZCZ.ZCZ_PREFIX = SE1.E1_PREFIXO " + CRLF
	cQuery += "     AND ZCZ.ZCZ_NUM = SE1.E1_NUM " + CRLF
	cQuery += "     AND ZCZ.ZCZ_PARCEL = SE1.E1_PARCELA " + CRLF
	cQuery += "     AND ZCZ.ZCZ_TIPO = SE1.E1_TIPO " + CRLF
	cQuery += "     AND ZCZ.ZCZ_CLIENT = SE1.E1_CLIENTE " + CRLF
	cQuery += "     AND ZCZ.ZCZ_LOJA = SE1.E1_LOJA " + CRLF
	cQuery += "     AND ZCZ.D_E_L_E_T_ != '*' " + CRLF
    cQuery += " WHERE  " + CRLF
	cQuery += "     FIF_FILIAL = '' " + CRLF
	
	cQuery += "     AND FIF_DTCRED = '"+DTOS(MV_PAR01)+"'  " + CRLF
	cQuery += "     AND FIF_PREFIX = '' " + CRLF 
	cQuery += "     AND FIF.D_E_L_E_T_ != '*' " + CRLF
	cQuery += "     AND ISNULL(ZCZ.ZCZ_NUM,'N') = 'N' " + CRLF

    dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB")

	Do While TRB->(!EOF())

		IncProc("Importando dados tabela ZCZ...")
			
				ZCZ->(dbSelectArea("ZCZ"))
				ZCZ->(dbSetOrder(1)) //ZCZ_FILORI, ZCZ_PREFIX, ZCZ_NUM, ZCZ_PARCEL, ZCZ_TIPO, ZCZ_CLIENT, ZCZ_LOJA
				
				If ! ZCZ->(dbSeek( 	PADR( TRB->E1_FILORIG 	,TamSx3('ZCZ_FILORI')[1]) +;
				 					PADR( TRB->E1_PREFIXO 	,TamSx3('ZCZ_PREFIX')[1]) +;
				 					PADR( TRB->E1_NUM 		,TamSx3('ZCZ_NUM')[1]) +;
				 					PADR( TRB->E1_PARCELA 	,TamSx3('ZCZ_PARCEL')[1])+;
				 					PADR( TRB->E1_TIPO 		,TamSx3('ZCZ_TIPO')[1])+;
				 					PADR( TRB->E1_CLIENTE 	,TamSx3('ZCZ_CLIENT')[1])+;
				 					PADR( TRB->E1_LOJA 		,TamSx3('ZCZ_LOJA')[1]) ) )
								
					RecLock("ZCZ", .T.)
						ZCZ->ZCZ_PREFIX 	:= TRB->E1_PREFIXO
					    ZCZ->ZCZ_NUM		:= TRB->E1_NUM
					    ZCZ->ZCZ_PARCEL 	:= TRB->E1_PARCELA 
					    ZCZ->ZCZ_TIPO		:= TRB->E1_TIPO 
					    ZCZ->ZCZ_NATURE		:= TRB->E1_NATUREZ
					    ZCZ->ZCZ_PORTAD		:= TRB->E1_PORTADO
					    ZCZ->ZCZ_DEPOSI		:= TRB->E1_AGEDEP
					    ZCZ->ZCZ_CLIENT		:= TRB->E1_CLIENTE
					    ZCZ->ZCZ_LOJA		:= TRB->E1_LOJA 	
					    ZCZ->ZCZ_NOMCLI		:= TRB->E1_NOMCLI
					    ZCZ->ZCZ_EMISSA		:= STOD(TRB->E1_EMISSAO)
					    ZCZ->ZCZ_VENCTO		:= STOD(TRB->E1_VENCTO)
					    ZCZ->ZCZ_VENCRE		:= STOD(TRB->E1_VENCREA)
					    ZCZ->ZCZ_VALOR		:= TRB->E1_VALOR
					    ZCZ->ZCZ_SALDO		:= TRB->E1_SALDO
					    ZCZ->ZCZ_VALREA		:= TRB->E1_VLRREAL
					    ZCZ->ZCZ_FILORI		:= TRB->E1_FILORIG 
					    ZCZ->ZCZ_CUSTO		:= TRB->E1_CCUSTO
					    ZCZ->ZCZ_VLRBAI		:= TRB->E1_SALDO
					    ZCZ->ZCZ_DESCON		:= TRB->E1_DESCONT
					    ZCZ->ZCZ_DTPG		:= STOD(TRB->FIF_DTCRED)
					    ZCZ->ZCZ_BANCO		:= TRB->FIF_CODBCO
					    ZCZ->ZCZ_AGENCI		:= TRB->FIF_CODAGE
					    ZCZ->ZCZ_CONTA		:= TRB->FIF_NUMCC
					    ZCZ->ZCZ_FMR		:= "2"
					    ZCZ->ZCZ_PROC		:= "N"
					    ZCZ->ZCZ_LOGIN		:= "DATA " + DTOC( Date() ) + " HORA " + TIME() + " USUARIO " +  Alltrim(UPPER(UsrRetName(__CUSERID)))
				    MsUnLock() 
				EndIf

				//Atualiza tabela SE1
				SE1->(dbSelectArea("SE1"))
				SE1->(dbSetOrder(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
				If SE1->(dbSeek( xFilial("SE1") + TRB->E1_CLIENTE + TRB->E1_LOJA + TRB->E1_PREFIXO + TRB->E1_NUM + TRB->E1_PARCELA + TRB->E1_TIPO ))
					RecLock("SE1", .f.)
						SE1->E1_FLAGFAT := "S"
					MsUnLock() 
				EndIf

				//Atualiza status conciliado
				FIF->(dbSelectArea("FIF"))
				FIF->(DBGoTo(TRB->REGFIF))
				If FIF->(RECNO()) == TRB->REGFIF
					
					RecLock("FIF", .F.)
						FIF->FIF_STATUS := "2"
					MsUnLock() 

				EndIf

		TRB->(dbSkip())
	Enddo	

Return
