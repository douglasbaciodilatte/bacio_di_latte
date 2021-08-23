#INCLUDE "RWMAKE.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ MT100AGR ºAutor  ³Ricardo Roda        º Data ³  24/08/2012 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de Entrada na confirmacao da nf para distribuicao    º±±
±±º          ³ automatica do saldo do armazem 		                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ ACD                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function MT100AGR()
Local aArea    := GetArea()
Local aAreaSD1 := SD1->(GetArea())
Local aAreaSDA := SDA->(GetArea())
Local aAreaSB2 := SB2->(GetArea())
//Local cLocali  := GetMv("MV_LOCENTR")//endereço de entrada
//Local cArmazem  := GetMv("MV_ARMENTR")//armazem de entrada
Local cArmCQ  := GetMv("MV_CQ")
Local cEndCQ  := "CQ"//GetMv("MV_CBENDCQ")
Local cEnder  := "DOCAE"//GetMv("MV_XENDPAD")
Local cLocal  := "800003"//GetMv("MV_XLOCPAD")

Public __aDocXEnd:={}

BEGIN TRANSACTION 
IF (INCLUI .Or. ALTERA)
	SD1->(DBSETORDER(1))  //1 = D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA+D1_COD+D1_ITEM
	IF SD1->(Dbseek(xFilial("SD1")+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA))
		While SD1->(!Eof()) .AND. SD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_lOJA) == SF1->(F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA)
			
			DBSelectArea("SB2")
			DBSetOrder(1)
			If !DBSeek(xFilial("SB2")+SD1->D1_COD+SD1->D1_LOCAL)
				CriaSB2(SD1->D1_COD,SD1->D1_LOCAL)
			EndIf
			
			DBSelectArea("SB1")
			DBSetOrder(1)
			If DBSeek(xFilial("SB1")+SD1->D1_COD)
				If SB1->B1_LOCALIZ == 'S' //PRODUTO CONTROLA ENDEREÇO
					
						
						DBSelectArea("SB2")
						DBSetOrder(1)
						If !DBSeek(xFilial("SB2")+SD1->D1_COD+cArmCQ)
							CriaSB2(SD1->D1_COD,cArmCQ)
						EndIf
						SDA->(DBSetOrder(1)) //DA_FILIAL+DA_PRODUTO+DA_LOCAL+DA_NUMSEQ+DA_DOC+DA_SERIE+DA_CLIFOR+DA_LOJA
						nQtde := SD1->D1_QUANT
						IF nQtde > 0 .And. SDA->(DBSeek(xFilial("SDA")+SD1->D1_COD+SD1->D1_LOCAL+SD1->D1_NUMSEQ+SD1->D1_DOC+SD1->D1_SERIE+SD1->D1_FORNECE+SD1->D1_LOJA)) .AND. SDA->DA_SALDO > 0
							nQtde  := Min(SD1->D1_QUANT,nQtde)
						
							IF SB1->B1_TIPOCQ == 'Q'// ENDEREÇA PRODUTOS DA QUALIDADE AUTOMATICAMENTE
								cEnder := cEndCQ
								cLocal := cArmCQ
							else
								clocal := SD1->D1_LOCAL	
							Endif
					    	aAdd(__aDocXEnd,{SD1->D1_COD,clocal,SD1->D1_NUMSEQ,SD1->D1_DOC,SD1->D1_SERIE,SD1->D1_FORNECE,SD1->D1_lOJA,cEnder,Nil,nQtde,SD1->D1_LOTECTL,SD1->D1_NUMLOTE,SD1->D1_DTVALID})
							//-- Realiza a Distribuicao Automatica atravez do parametro MV_DISTAUT
							A100Distri(SD1->D1_COD,clocal,SD1->D1_NUMSEQ,SD1->D1_DOC,SD1->D1_SERIE,SD1->D1_FORNECE,SD1->D1_lOJA,cEnder,Nil,nQtde,SD1->D1_LOTECTL,SD1->D1_NUMLOTE)
						Endif
					Endif
				
			Endif
			SD1->(DBSkip())
		Enddo
	ENDIF
Processa( {||   U_EnderAut(__aDocXEnd)}, "Aguarde processando endereçamento" ) 
ENDIF
END TRANSACTION 

RestArea(aAreaSB2)
RestArea(aAreaSDA)
RestArea(aAreaSD1)
RestArea(aArea)

Return

/*/{Protheus.doc} EnderAut
description
@type function
@version 
@author Ricardo Roda
@since 10/08/2020
@param aVetor, array, param_description
@return return_type, return_description
/*/
User Function EnderAut(aVetor)
Local cQuery := " "
Local aAuto := {}
//Local aItem := {}
//Local aLinha := {}
Local aCols2 := {} //Produto Utilizado
Local nX
//Local nOpcAuto := 3
Private lMsErroAuto := .F.

For nX := 1 To len(aVetor)
		
		If SELECT("Qry") > 0 
			Qry->(dbCloseArea())
		Endif	
		
	cQuery += " SELECT PCH_PRODUT, PCH_VALID, PCH_FLOTE,SUM(PCH_QUANT) PCH_QUANT  "
	cQuery += " FROM "+RETSQLNAME("PCH")+" PCH "
	cQuery += " WHERE PCH_FILIAL = '"+XFilial("PCH")+"' "
	cQuery += " AND PCH_DOC = '"+aVetor[nX,4]+"' "
	cQuery += " AND PCH_SERIE = '"+aVetor[nX,5]+"' "
	cQuery += " AND PCH_FORNEC = '"+aVetor[nX,6]+"' "
	cQuery += " AND PCH_LOJA = '"+aVetor[nX,7]+"' "
	cQuery += " AND PCH_PRODUT = '"+aVetor[nX,1]+"' "
	cQuery += " AND PCH.D_E_L_E_T_ = ''
	cQuery += " GROUP BY PCH_PRODUT, PCH_VALID,PCH_FLOTE
	DBUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),"Qry",.F.,.T.)
	nRegs:= 0 

	if Qry->(eof())
		Return
	Endif
	
	While Qry->(!eof())
		nRegs+= 1
		SB1->(DbSeek(xFilial("SB1")+PadR(Qry->PCH_PRODUT, tamsx3('D3_COD') [1])))
		Aadd(aCols2,{SB1->B1_COD,;
					 SB1->B1_DESC,;
					 SB1->B1_UM,;
					 PadR(aVetor[nX,2], tamsx3('D3_LOCAL') [1]),;
					 PadR(aVetor[nX,8], tamsx3('D3_LOCALIZ') [1]),;
					 SB1->B1_COD,;
					 SB1->B1_DESC,;
					 SB1->B1_UM,;
					 PadR(aVetor[nX,2], tamsx3('D3_LOCAL') [1]),;
					 PadR(aVetor[nX,8], tamsx3('D3_LOCALIZ') [1]),;
				     CRIAVAR("D3_NUMSERI"),;
					 PadR(aVetor[nX,11], tamsx3('D3_LOTECTL') [1]),;
					 CRIAVAR("D3_NUMLOTE"),;
					 aVetor[nX,13],;
					 CRIAVAR("D3_POTENCI"),;
					 Qry->PCH_QUANT,;
					 ConvUm(SB1->B1_COD, Qry->PCH_QUANT, 0, 2),;
					 CRIAVAR("D3_ESTORNO"),;
					 CRIAVAR("D3_NUMSEQ"),;
					 PadR(Qry->PCH_FLOTE, tamsx3('D3_LOTECTL') [1]),;
					 stod(Qry->PCH_VALID),;
					CRIAVAR("D3_ITEMGRD"),;
					CRIAVAR("D3_OBSERVA"),;
					})

	Qry->(DbSkip())
	End

		If SELECT("Qry") > 0 
			Qry->(dbCloseArea())
		Endif	

aAdd(aAuto,{GetSxeNum("SD3","D3_DOC"),dDataBase})

For i:=1 To Len(aCols2)
   aAdd(aAuto, {aCols2[i][01],;  //Prod Origem
                aCols2[i][02],;  //Descrição
                aCols2[i][03],;  //Unid Medida
                aCols2[i][04],;  //Armazem origem
                aCols2[i][05],;  //End. Origem
                aCols2[i][06],;  //Prod Dest.
                aCols2[i][07],;  //Descrição
                aCols2[i][08],;  //Unid Medida
                aCols2[i][09],;  //Armazém destino
                aCols2[i][10],;  //End. Dest.
                aCols2[i][11],;  //Num. Serie
                aCols2[i][12],;  //Lote
                aCols2[i][13],;  //Sub-Lote
                aCols2[i][14],;  //Validade
                aCols2[i][15],;  //Potencia
                aCols2[i][16],;  //Quantidade
                aCols2[i][17],;  //Qtde 2ª UM
                aCols2[i][18],;  //Estornado
                aCols2[i][19],;  //Seq.
                aCols2[i][20],;  //Lote Dest.
                aCols2[i][21],;  //Valid Dest.
                aCols2[i][22],; //Item Grade
				aCols2[i][23]	})  
Next i

MsgInfo( cValtochar(Len(aCols2))+" Lotes","Aviso")

MSExecAuto({|x,y| mata261(x,y)},aAuto,3)//inclusão
If lMsErroAuto
   ConOut("Erro na inclusao!")			
   MostraErro()
   DisarmTransaction()
EndIf

Next nX

Return !lMsErroAuto
