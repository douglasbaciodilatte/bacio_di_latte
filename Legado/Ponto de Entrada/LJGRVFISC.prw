#INCLUDE "PROTHEUS.CH"              

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LJGRVFISC	ºAutor  ³Marcos Justo        º Data ³  20/11/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada antes da gravacao do SD2, dentro 		  º±±
±±º          ³ da funcao LjGrvTran com o orcamento posicionado.           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ LjGrvTran                                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function LJGRVFISC() 
Local _lLJGRVFISC   := SuperGetMV( "IN_LJGRVFI"  ,,.T.)  ////indica se executa ou não o ponto de entrada
Local _nAliq        := 0  
Local _cFilRet      := cFilAnt
Begin Sequence             
	If !_lLJGRVFISC //verifica se utiliza e ou não o PE
		Break
  	Endif
    CONOUT("ACESSOU LJGRVFISC ")
	LJGRVFSD2()                
End Begin		
Return(Nil)   


//Atualização para manter o D2 igual a aos valores impostos da Camada
//O SL2 esta exatamente igual ao da camada e não é alterado até gerar SD2
//DAC - 09/03/2016

Static Function LJGRVFSD2()  //atualizar SD2 conforme SL2
Local _cAliasTRB := GetNextAlias()
Local _nValICM 	 :=´SL2->L2_VALICM
Local _nBaseICM  := SL2->L2_BASEICM	
Local _nItem     := Val(SL2->L2_ITEM) 
Local _nAliq     := 0               
Local _lLJPisCof := SuperGetMV( "IN_LJGRVPC"  ,,.T.)  ////indica se Grava PIS/COFINS

//Variaveis para tratamento do arredondamento
Local _lHabArred 	:= SuperGetMv("IN_LJIPECF",,.F.)  				// calcula o imposto conforme o ECF
Local _lExistMDS 	:= AliasInDic("MDS")							// Verifica se tabela existe
Local _lD2SITTRIB  	:= SD2->(FieldPos( "D2_SITTRIB" )) > 0	   		// Verifica se campo existe
Local _lStatusImp13	:= .F.											// Pega o retorno do PE FRTECF13 para verificar arredondamento

Begin Sequence
    CONOUT("ACESSOU LJGRVFSD2 ")
	CONOUT("LJGRVFSD2- ITEM "+STR(_nItem))

	SF4->( DbSetOrder(1) )	//F4_FILIAL+F4_CODIGO
	SD2->( DbSetOrder(3) )	//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
    PIO->( DbSetOrder(1) )	//FILIAL NUM ITEM PROD		
	BeginSql Alias _cAliasTRB 
   		SELECT PIO.R_E_C_N_O_ NREGPIO
		FROM %Table:PIO% PIO     
		WHERE PIO.PIO_FILIAL = %Exp:SL2->L2_FILIAL%
 			AND (PIO.PIO_DOC  = %Exp:SL2->L2_DOC%
 			 OR PIO.PIO_XCODEX = %Exp:SL2->L2_XCODEX%)
			AND PIO.PIO_ITEM = %Exp:SL2->L2_ITEM%       
			AND PIO.PIO_PDV  = %Exp:SL2->L2_PDV%       
   			AND PIO.%notDel%                
   	EndSql //Gera a consulta no alias informado anteriormente 
   	If (_cAliasTRB)->(Eof()) .and. (_cAliasTRB)->NREGPIO == 0 
		CONOUT("LJGRVFSD2- NAO LOCALIZADO PIO -> FILIAL "+SL2->L2_FILIAL+" DOC "+SL2->L2_DOC+" ITEM "+SL2->L2_ITEM+" PDV "+SL2->L2_PDV)
		Break
	Endif

    CONOUT("LJGRVFSD2 INICIANDO CARGA DA MEMORIA FISCAL REG. PIO "+STRZERO((_cAliasTRB)->NREGPIO,8))           
	//_nItem      := Val(SL2->L2_ITEM) 
	PIO->(DbGoto((_cAliasTRB)->NREGPIO))
	If Upper(SubsTr(PIO->PIO_SITTRI,1,1)) == "T"
		//_nAliq      := Val(SubsTr(PIO->PIO_SITTRI,2,2))
		_nAliq      := Val(AllTrim(SubsTr(PIO->PIO_SITTRI,2))) / 100 //Pegar toda a composição e dividIR para encontrar o percentual 
	Else
		_nAliq      := 0
	Endif
	MaFisAlt( "IT_BASEICM" , PIO->PIO_BASEIC , _nItem )                    
	CONOUT("LJGRVFSD2- BASE IVMS "+STR(_nValICM))
	MaFisAlt( "IT_ALIQICM" , _nAliq    , _nItem )
	CONOUT("LJGRVFSD2- ALIQ ICMS "+STR(_nBaseICM))
	MaFisAlt( "IT_VALICM"  , PIO->PIO_VALICM , _nItem )  
	CONOUT("LJGRVFSD2- VAL ICMS  "+STR(_nAliq))

    //BASE DE ICMS ST RETIDO
	If PIO->( FieldPos("PIO_BRICMS") ) > 0			
		MaFisAlt( "IT_BASESOL" , PIO->PIO_BRICMS  , _nItem )  
		CONOUT("LJGRVFSD2- BASESOL "+STR(PIO->PIO_BRICMS))
	Else
		CONOUT("LJGRVFSD2- BASESOL NAO LOCALIZADO ")
	Endif

	If _lLJPisCof
		CONOUT("ACESSO OUTROS IMPOSTOS")
		//PIS
		If PIO->( FieldPos("PIO_BASEPS") ) > 0			
			MaFisAlt( "IT_BASEPS2" , PIO->PIO_BASEPS , _nItem )  
			CONOUT("LJGRVFSD2- BASEPS2 "+STR(PIO->PIO_BASEPS))
		Else
			CONOUT("LJGRVFSD2- BASEPS2 NAO LOCALIZADO ")
        Endif
		If PIO->( FieldPos("PIO_ALIQPS") ) > 0			
			MaFisAlt( "IT_ALIQPS2" , PIO->PIO_ALIQPS , _nItem )  
			CONOUT("LJGRVFSD2- ALIQPS2 "+STR(PIO->PIO_ALIQPS))
		Else
			CONOUT("LJGRVFSD2- ALIQPS2 NAO LOCALIZADO ")
		Endif
		If PIO->( FieldPos("PIO_VALPS2") ) > 0			
			MaFisAlt( "IT_VALPS2"  , PIO->PIO_VALPS2  , _nItem )  
			CONOUT("LJGRVFSD2- VALPS2 "+STR(PIO->PIO_VALPS2))
		Else
			CONOUT("LJGRVFSD2- VALPS2 NAO LOCALIZADO ")
		Endif

   		//COFINS
		If PIO->( FieldPos("PIO_BASECF") ) > 0			
			MaFisAlt( "IT_BASECF2" , PIO->PIO_BASECF , _nItem )  
			CONOUT("LJGRVFSD2- BASECF2 "+STR(PIO->PIO_BASECF))
		Else
			CONOUT("LJGRVFSD2- BASECF2 NAO LOCALIZADO ")
		Endif
		If PIO->( FieldPos("PIO_VALCF2") ) > 0			
			MaFisAlt( "IT_VALCF2"  , PIO->PIO_VALCF2  , _nItem )  
			CONOUT("LJGRVFSD2- VALCF2 "+STR(PIO->PIO_VALCF2))
		Else
			CONOUT("LJGRVFSD2- VALCF2 NAO LOCALIZADO ")
		Endif
		If PIO->( FieldPos("PIO_ALIQCF") ) > 0			
			MaFisAlt( "IT_ALIQCF2"  , PIO->PIO_ALIQCF  , _nItem )  
			CONOUT("LJGRVFSD2- ALIQCF2 "+STR(PIO->PIO_ALIQCF))    
		Else
			CONOUT("LJGRVFSD2- ALIQCF2 NAO LOCALIZADO ")
		Endif
	Endif
	
	//Tratamento de Arredondamento
	ConOut("LjxConfIcm - _lHabArred " + cValToChar(_lHabArred)) 
	ConOut("LjxConfIcm - _lExistMDS " + cValToChar(_lExistMDS)) 
	ConOut("LjxConfIcm - _lD2SITTRIB " + cValToChar(_lD2SITTRIB))
	ConOut("LjxConfIcm - Left(SL2->L2_SITTRIB,1) " + Left(SL2->L2_SITTRIB,1))
	If _lHabArred .And. _lExistMDS .And. _lD2SITTRIB .And. Left(SL2->L2_SITTRIB,1) $ "T|S" //Situacao Tributaria (T=ICMS ou S=ISS)
		ConOut("LjxConfIcm - _nItem " + cValToChar(_nItem))
		ConOut("LjxConfIcm - (SL2->L2_VLRITEM + SL2->L2_VALFRE) " + cValToChar((SL2->L2_VLRITEM + SL2->L2_VALFRE)))
		ConOut("LjxConfIcm - SL1->L1_EMISNF " + cValToChar(SL1->L1_EMISNF))
		ConOut("LjxConfIcm - SL1->L1_PDV " + SL1->L1_PDV)
		ConOut("LjxConfIcm - SL2->L2_PRODUTO " + SL2->L2_PRODUTO)
		ConOut("LjxConfIcm - _lStatusImp13 " + cValToChar(_lStatusImp13))
		ConOut("LjxConfIcm - Antes -> IT_ALIQICM " + cValToChar(MaFisRet( _nItem ,"IT_ALIQICM")) + "" + cValToChar(MaFisRet( _nItem ,"IT_VALICM")) )
		LjxConfIcm(	_nItem 	,(SL2->L2_VLRITEM + SL2->L2_VALFRE),SL1->L1_EMISNF , SL1->L1_PDV ,SL2->L2_PRODUTO , _lStatusImp13 )
		ConOut("LjxConfIcm - Depois -> IT_ALIQICM " + cValToChar(MaFisRet( _nItem ,"IT_ALIQICM")) + "" + cValToChar(MaFisRet( _nItem ,"IT_VALICM")) )
	EndIf
	
End Begin

If Select(_cAliasTRB) <> 0
	(_cAliasTRB)->(DbCloseArea())
	Ferase(_cAliasTRB+GetDBExtension())
EndIf

Return Nil

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LJGRVFISC ºAutor  ³Microsiga           º Data ³  08/22/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function LjxConfIcm( nItem 	 , nTotItem , dDatRef , cPdv ,;
							cCodProd , lStatusImp13)

Local nAliqProd := MaFisRet( nItem ,"IT_ALIQICM")
Local nIcmProd	:= MaFisRet( nItem ,"IT_VALICM")
Local cCpoBas	:= "MDS_BA"
Local nBasMDS	:= 0
Local nValAual	:= 0
Local nDifIcm	:= 0
Local nAliqRed	:= 0
Local nPosPont	:= 0
Local nAliqNew	:= 0
Local nValEcfIcm:= 0

Default nTotItem 	:= 0
Default lStatusImp13:= .F.

If nAliqProd > 0

	//??????????????????
	
	//?usca se existe aliquota reduzida?
	
	//??????????????????
	
	nAliqRed := LjxRetAliq(cCodProd)
	If nAliqRed > 0
		nAliqProd := nAliqRed
	EndIf

	nPosPont := AT(".",AllTrim(Str(nAliqProd)))
	
	//???????????????????????????????
	
	//?onta o campo que sera verificado de acordo com a aliquota ?
	
	//???????????????????????????????
	
	If nPosPont > 0
		nAliqNew := Val(SubStr(AllTrim(Str(nAliqProd)) ,1, nPosPont -1 ))
	Else
		nAliqNew := nAliqProd
	EndIf

	If nAliqNew  >= 10
		cCpoBas := cCpoBas+ PadR(StrTran(AllTrim(Str(nAliqProd)),".",""),4,"0")
	Else
		cCpoBas := cCpoBas+ "0"+ PadR(StrTran(AllTrim(Str(nAliqProd)),".",""),3,"0")
	Endif

	If MDS->(FieldPos(cCpoBas) ) > 0
		DbSelectArea("MDS")
		DbSetOrder(1)
		If DbSeek(xFilial("MDS") + DTOS(dDatRef) + cPdv )

	        nBasMDS := MDS->(&cCpoBas)
			//????????????????????????????
			//?Verifica se existe diferenca com o que foi vendido  ?
			//????????????????????????????
			
			If lStatusImp13	// Verificacao do ECF para o arredondamento PE FRTECF13
		        nValAual	:= Round( (nBasMDS) * (nAliqProd/100) , nDecimais )
		        nValEcfIcm	:= Round( (nBasMDS+nTotItem) * (nAliqProd/100) , nDecimais )
		    Else
		        nValAual	:= NoRound( (nBasMDS) * (nAliqProd/100) , nDecimais )
		        nValEcfIcm	:= NoRound( (nBasMDS+nTotItem) * (nAliqProd/100) , nDecimais )
	        Endif
			nDifIcm     := (nValAual + nIcmProd ) - nValEcfIcm
			
			//??????????????????????????????????????????????????????
			
			//?O Intuito da funcao eh diferenca de arredondamento, valores maiores que 0.02 nao devem ser considerados ?
			
			//??????????????????????????????????????????????????????
			
			If Abs(nDifIcm) <= 0.02
				If nDifIcm > 0
					MaFisAlt("IT_VALICM", nIcmProd - nDifIcm, nItem)
				ElseIf nDifIcm < 0
					MaFisAlt("IT_VALICM", nIcmProd + Abs(nDifIcm), nItem)
				EndIf
			EndIf

	    	RecLock("MDS",.F.)
       	    REPLACE &(cCpoBas)		WITH MDS->(&cCpoBas)+ nTotItem
		    MDS->(MsUnlock())
    	Else
	    	RecLock("MDS",.T.)
	        REPLACE MDS_FILIAL	WITH xFilial("MDS")
   	        REPLACE MDS_DATA	WITH dDatRef
	        REPLACE MDS_PDV		WITH cPdv
   	        REPLACE &(cCpoBas)	WITH nTotItem
		    MDS->(MsUnlock())
			//?????????????????????????????????????
			//?fetua a mesma verificacao quando for o primeiro item dessa tributacao ?
			
			//?????????????????????????????????????
		
			If lStatusImp13	 // Verificacao do ECF para o arredondamento PE FRTECF13
		        nValEcfIcm	:= Round( nTotItem * (nAliqProd/100) , nDecimais )
		    Else
		        nValEcfIcm	:= NoRound( nTotItem * (nAliqProd/100) , nDecimais )
		    EndIf
			
			nDifIcm     := nIcmProd - nValEcfIcm
			
			//??????????????????????????????????????????????????????
			
			//?O Intuito da funcao eh diferenca de arredondamento, valores maiores que 0.02 nao devem ser considerados ?
			
			//??????????????????????????????????????????????????????
			
			If Abs(nDifIcm) <= 0.02
				If nDifIcm > 0
					MaFisAlt("IT_VALICM", nIcmProd - nDifIcm, nItem)
				ElseIf nDifIcm < 0
					MaFisAlt("IT_VALICM", nIcmProd + Abs(nDifIcm), nItem)
				EndIf
			EndIf
	    EndIf
	EndIf
EndIf

Return(Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³LjxRetAliqºAutor  ³Microsiga           º Data ³  08/22/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function LjxRetAliq(cProd)

Local nRet	:= 0

Default cProd 		:= ""

DbSelectArea("SB0")
DbSetOrder(1)
If DbSeek(xFilial("SB0")+ cProd)
	nRet := SB0->B0_ALIQRED
EndIf

Return(nRet)