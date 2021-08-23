#INCLUDE "Protheus.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "TopConn.ch"

/*/{Protheus.doc} User Function DBCONIF1
    (long_description)
    @type  Function
    @author user
    @since 10/12/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function DBCONIF1()
    
    Local aParamBox 	 := {}
    Local cCaminho  := Space(90)
    Local aRet      := {}

    aAdd(aParamBox ,{6,"Diretorio do Arquivo?"	,cCaminho	,"@!",,'.T.',80,.F.,"Arquivos .xlsx |*.csv " }) 
    aAdd(aParamBox,{1,"Banco",Space(3),"","","SA6","",0,.F.}) // Tipo caractere
    aAdd(aParamBox,{1,"Agencia",Space(6),"","","","",0,.F.}) // Tipo caractere
    aAdd(aParamBox,{1,"Conta",Space(10),"","","","",0,.F.}) // Tipo caractere
    aAdd(aParamBox,{1,"Repasse"  ,Ctod(Space(8)),"","","","",50,.F.}) // Tipo data
   
    If ParamBox(aParamBox ,"Parametros ",aRet)
        processa( {|| ImporCSV(MV_PAR01) } ,'Aguarde Efetuando Importacao da Planilha' )
    EndIf

Return 

Static Function ImporCSV(cFile)

    Local cLinha
    Local lPrim         := .T.
    Local aCampos       := {}
    Local aDados        := {}
    Private cSeqFIF
    Private aBanco        := {}
 
   	If ! Empty(cFile) 

		FT_FUSE(cFile)
		ProcRegua(FT_FLASTREC())
		FT_FGOTOP()
		While !FT_FEOF()
			
			IncProc("Selecionando Registros...")
	 
			cLinha := FT_FREADLN()
			
			If lPrim
				aCampos := Separa(cLinha,";",.T.)
				lPrim := .F.
			Else
				AADD(aDados,Separa(cLinha,";",.T.))
			EndIf
			
			FT_FSKIP()
		EndDo

    EndIf

     //Efetua leitura dos dados
    ProcRegua( Len(aDados) )
    
        For i := 1 to Len(aDados)

            IncProc("Importando Registros...")

            cQuery := " SELECT E1_FILIAL, E1_PREFIXO, E1_NUM, E1_PARCELA, E1_TIPO, E1_NATUREZ, E1_PORTADO, E1_FILORIG, E1_CLIENTE, E1_AGEDEP," + CRLF  
            cQuery += " E1_LOJA, E1_NOMCLI, E1_EMISSAO, E1_VENCTO, E1_VENCREA,E1_VALOR, E1_SALDO, E1_VLRREAL, E1_FILORIG, E1_CCUSTO, E1_SALDO, E1_DESCONT " + CRLF     
            cQuery += " FROM " + RetSqlName("SE1") + " SE1 WITH (NOLOCK) " + CRLF      
            cQuery += " WHERE SE1.E1_FILIAL = '' " + CRLF      
            cQuery += "     AND SE1.E1_NSUTEF = '"+aDados[i][1]+"' " + CRLF      
            cQuery += "     AND SE1.E1_EMISSAO = '"+ DTOS(CTOD(aDados[i][2])) +"'  " + CRLF     
            cQuery += "     AND SE1.E1_SALDO != 0 " + CRLF     
            cQuery += "     AND SE1.D_E_L_E_T_ != '*' " + CRLF     
            cQuery += "     AND SE1.E1_CLIENTE = '029' " + CRLF     

            dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),"TRB")
           
                ZCZ->(dbSelectArea("ZCZ"))
                ZCZ->(DBSetOrder(1))
                If ! ZCZ->(dbSeek( TRB->E1_FILORIG + TRB->E1_PREFIXO + TRB->E1_NUM + TRB->E1_PARCELA + TRB->E1_TIPO + TRB->E1_CLIENTE + TRB->E1_LOJA ) )

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
                            ZCZ->ZCZ_BANCO		:= MV_PAR02
                            ZCZ->ZCZ_AGENCI		:= MV_PAR03
                            ZCZ->ZCZ_CONTA		:= MV_PAR04
                            ZCZ->ZCZ_DTPG		:= MV_PAR05
                            ZCZ->ZCZ_FMR		:= "2"
                            ZCZ->ZCZ_PROC		:= "N"
                            ZCZ->ZCZ_LOGIN		:= "DATA " + DTOC( Date() ) + " HORA " + TIME() + " USUARIO " +  Alltrim(UPPER(UsrRetName(__CUSERID)))
                
                    //flag tabela SE2
                    SE1->(dbSelectArea("SE1"))
                    SE1->(dbSetOrder(2)) //E1_FILIAL+E1_CLIENTE+E1_LOJA+E1_PREFIXO+E1_NUM+E1_PARCELA+E1_TIPO
                    If SE1->(dbSeek( xFilial("SE1") + TRB->E1_CLIENTE + TRB->E1_LOJA + TRB->E1_PREFIXO + TRB->E1_NUM + TRB->E1_PARCELA + TRB->E1_TIPO ))
                        RecLock("SE1", .f.)
                            SE1->E1_FLAGFAT := "S"
                        MsUnLock() 
                    EndIf 

                EndIf    
            
            TRB->(DBCloseArea())
        
        Next i
    
Return 
