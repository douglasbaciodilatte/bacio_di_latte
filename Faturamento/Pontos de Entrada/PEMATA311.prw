#Include 'Protheus.ch'
#include "TOPCONN.CH"
#DEFINE ENTER chr(13)+chr(10)

/*
=====================================================================================
Programa.:              PEMATA311 
Autor....:              Francis Oliveira
Data.....:              17/10/2016
Descricao / Objetivo:   Ao Efetivar a transferencia gravar no PV o centro de custo   
Doc. Origem:            
Solicitante:            Cliente
Uso......:              BACIO DI LATTE
Obs......:              Rotina em MVC 
=====================================================================================
*/

User Function MATA311()

Local aArea   	:= Getarea()
Local aAreaSX5  := SX5->(GetArea())
Local aAreaNNT 	:= NNT->(Getarea())
Local aAreaNNS 	:= NNS->(Getarea())
Local aParam    := PARAMIXB
Local oObj      := ''
Local cIdPonto  := ''
Local cIdModel  := ''
Local cItens    := ''
Local cQuery    := ''
Local nList     := 1
Local nLinha    := 0
Local nOper	    := 0
Local nX		:= 0
Local aList1    := {}
Local aItens	:= {}
Local aDados	:= {}
Local lIsGrid   := .F.
Local lRet      := .T.
Local lArm700002:= .F.
Local lEfetiva	:= IsInCallStack("A311Efetiv")

SetPrvt("oFont1","oFont2","oDlg1","oSay1","oGrp1","oSay2","oBtn1","oBtn2","oList1")

If aParam <> NIL
      
	oObj       := aParam[1]
	cIdPonto   := aParam[2]
	cIdModel   := aParam[3]
	lIsGrid    := ( Len( aParam ) > 3 )
	
	If cIdPonto == "FORMLINEPOS"
	
		nLinha 	:= aParam[4]
		aDados	:= oObj:ADATAMODEL
		
		cChave := 	aDados[nLinha][1][1][16] +; //Filial Destino
					aDados[nLinha][1][1][17] +; //Codigo Produto destino	
					aDados[nLinha][1][1][20]    // Armazem Destino  			
		
		//Verifica tabela de cotas
		ZCC->(dbSelectArea("ZCC"))
		ZCC->(dbSetOrder(1))
		If ZCC->(dbSeek( cChave ))
		
			//Verifica saldo em Cota
			nQtde1 := aDados[nLinha][1][1][14]
			nQtde2 := aDados[nLinha][1][1][15]
			
			If ZCC->ZCC_QTDE1 > 0 
			
				If nQtde1 > ZCC->ZCC_QTDE1 	       			
					Alert("ATEN??O: Quantidade solicitada maior que o saldo em cotas, solicite revis?o ao Consultor<br> "+;
					"Saldo: "+cValToChar(ZCC->ZCC_QTDE1)+"<br>"+;
					"Produto: "+Alltrim(aDados[nLinha][1][1][17]))
					lRet := .F.
				EndIf	
			
			ElseIf ZCC->ZCC_QTDE2 > 0	
				
				If nQtde2 > ZCC->ZCC_QTDE2  		       			
					Alert("ATEN??O: Quantidade solicitada maior que o saldo em cotas, solicite revis?o ao Consultor<br> "+;
					"Saldo: "+cValToChar(ZCC->ZCC_QTDE2)+"<br>"+;
					"Produto: "+Alltrim(aDados[nLinha][1][1][17]))
					lRet := .F.	       			
				EndIf
										
			ElseIf ZCC->ZCC_QTDE1 == 0 .And. ZCC->ZCC_QTDE2 == 0	
					Alert("ATEN??O: N?o ? poss?vel solicitar o item pois n?o existe saldo de cotas, Saldo = 0 Solicite revis?o ao Consultor<br>"+;
					"Produto: "+Alltrim(aDados[nLinha][1][1][17]))
					lRet := .F.	       			
			
			EndIf
			
		EndIf
	
	ElseIf cIdPonto == 'MODELCOMMITNTTS'
		nOper := oObj:nOperation

		oModelNNS := oObj:AALLSUBMODELS[1] // Cabecalho
		oModelNNT := oObj:AALLSUBMODELS[2] // Itens
					
		// Loop para os ites da Transferencia 
		For nX:= 1 To oModelNNT:GetQtdLine() 
			oModelNNT:GoLine(nX)
				
			cFilNNT := oModelNNT:GetValue("NNT_FILORI") 	// C6_FILIAL
			cDocNNT := oModelNNT:GetValue("NNT_DOC") 		// C6_NOTA
			cSerNNT := oModelNNT:GetValue("NNT_SERIE") 		// C6_SERIE
			cProNNT := oModelNNT:GetValue("NNT_PROD") 		// C6_PRODUTO
			cCusNNT := oModelNNT:GetValue("NNT_XCC") 		// C6_CCUSTO
			cAmzNNT := oModelNNT:GetValue("NNT_LOCLD")		// C6_XLOCDES
			nQt1NNT := oModelNNT:GetValue("NNT_QUANT") 		// NNT_QUANT
			nQt2NNT := oModelNNT:GetValue("NNT_QTSEG") 		// NNT_QTSEF
			cFilDes := oModelNNT:GetValue("NNT_FILDES") 	// NNT_FILDES
			
			If lEfetiva
				// Query para selecionar os produtos na SC6
				cQuery := " SELECT C6_FILIAL, C6_NUM, C6_ITEM, C6_PRODUTO, R_E_C_N_O_ AS SC6RECNO " + ENTER
				cQuery += " FROM "       + RetSqlName("SC6") + " SC6       " + ENTER
				cQuery += " WHERE SC6.C6_FILIAL = '" + cFilNNT + "' " + ENTER
				cQuery += " AND SC6.C6_NOTA = '" + cDocNNT + "' " + ENTER
				cQuery += " AND SC6.C6_SERIE = '" + cSerNNT + "' " + ENTER
				cQuery += " AND SC6.C6_PRODUTO = '" + cProNNT + "' " + ENTER
				cQuery += " AND SC6.D_E_L_E_T_ = ' ' " 

				If ( Select("TMP1") ) > 0
					DbSelectArea("TMP1")
					TMP1->(DbCloseArea())
				EndIf
			
				TCQUERY cQuery NEW ALIAS "TMP1"
			
				DbSelectArea("TMP1")
				DbGoTop()
			
				While TMP1->(!Eof())
			
					DbSelectArea("SC6")
					DbGoTo(TMP1->SC6RECNO)
					RecLock("SC6",.F.)
						SC6->C6_CCUSTO  := cCusNNT   
						SC6->C6_XLOCDES := cAmzNNT
					MsUnlock()	
				TMP1->(DbSkip())		
				EndDo
				
				
				//Atualiza saldo Cotas ap?s efetivar o pedido de transferencia
				cChave := 	cFilDes +; //Filial Destino
							cProNNT +; //Codigo Produto destino	
							cAmzNNT    // Armazem Destino  			
			
				//Verifica tabela de cotas
				ZCC->(dbSelectArea("ZCC"))
				ZCC->(dbSetOrder(1))
				If ZCC->(dbSeek( cChave ))
				
					If ZCC->ZCC_QTDE1 > 0
						//Atualiza saldo
						RecLock("ZCC",.F.)
							ZCC->ZCC_QTDE1F		:= ZCC->ZCC_QTDE1F + nQt1NNT
							ZCC->ZCC_QTDE1  	:= ZCC->ZCC_QTDE1 - nQt1NNT   		       				
						MsUnlock()	
					ElseIf ZCC->ZCC_QTDE2 > 0
						//Atualiza saldo
						RecLock("ZCC",.F.)
							ZCC->ZCC_QTDE2F		:= ZCC->ZCC_QTDE2F + nQt2NNT
							ZCC->ZCC_QTDE2  	:= ZCC->ZCC_QTDE2 - nQt2NNT   		       				
						MsUnlock()					   	
					EndIf
						
				EndIf
			EndIf
			
			If nOper == 3 .And. cAmzNNT == '700002'
				lArm700002 := .T.

				aAdd(aItens,{cFilNNT,cFilDes,cProNNT,;
					Alltrim(Posicione("SB1",1,xFilial("SB1")+cProNNT,"B1_DESC")),;
					Alltrim(oModelNNT:GetValue("NNT_LOCAL")),cAmzNNT,nQt2NNT})
			EndIf
		Next nX
		
		//envia WF somente para solicita??es para Arm 700002 - chamado #65194 - Felipe Mayer 08/07/2021
		If nOper == 3 .And. lArm700002 
			U_WFTRANSF( oModelNNS:GetValue("NNS_COD"),;
						oModelNNS:GetValue("NNS_DATA"),;
						oModelNNS:GetValue("NNS_HORA"),;
						aItens,;
						AllTrim(SuperGetMv("MV_WFTRAN",,"")) )
		EndIf

	/*Atualiza??o PE MVC respons?vel por gravar motivo da exclus?o da linha na tabela NNT  -  Felipe Mayer Rvacari  -  06/07/2020*/
	ElseIf cIdPonto == "FORMLINEPRE"

		nOper := oObj:GetModel(cIdPonto):nOperation

		If	nOper == 4
			If aParam[5] == 'DELETE'

				oModelNNT := oObj:ADATAMODEL[aParam[4]][1][1] // Item deletado

				cQuery := " SELECT NNT_FILIAL,NNT_COD,NNT_FILORI,NNT_PROD,NNT_LOCAL,NNT_LOCALI,NNT_NSERIE, "
				cQuery += " NNT_LOTECT,NNT_NUMLOT,NNT_LOCLD,NNT_FILDES,NNT_PRODD,NNT_LOCDES,NNT_LOTED "
				cQuery += " FROM "+RetSqlName('NNT')+" WHERE NNT_COD='"+oModelNNT[2]+"' "
				cQuery += " AND NNT_FILORI='"+oModelNNT[3]+"' AND NNT_PROD='"+oModelNNT[4]+"' "
				cQuery += " AND NNT_LOCAL='"+oModelNNT[7]+"' AND NNT_FILDES='"+oModelNNT[16]+"' "
				cQuery += " AND NNT_LOCLD='"+oModelNNT[20]+"' AND D_E_L_E_T_='' "
				
				If Select("TMP") <> 0
					DbSelectArea("TMP")
					DbCloseArea()
				EndIf	
				
				DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),'TMP',.F.,.T.)

				cKey := AvKey(TMP->NNT_FILIAL,"NNT_FILIAL")+AvKey(TMP->NNT_COD,"NNT_COD")+AvKey(TMP->NNT_FILORI,"NNT_FILORI")+AvKey(TMP->NNT_PROD,"NNT_PROD")+AvKey(TMP->NNT_LOCAL,"NNT_LOCAL");
				+AvKey(TMP->NNT_LOCALI,"NNT_LOCALI")+AvKey(TMP->NNT_NSERIE,"NNT_NSERIE")+AvKey(TMP->NNT_LOTECT,"NNT_LOTECT")+AvKey(TMP->NNT_NUMLOT,"NNT_NUMLOT")+AvKey(TMP->NNT_FILDES,"NNT_FILDES");
				+AvKey(TMP->NNT_PRODD,"NNT_PRODD")+AvKey(TMP->NNT_LOCLD,"NNT_LOCLD")+AvKey(TMP->NNT_LOCDES,"NNT_LOCDES")+AvKey(TMP->NNT_LOTED,"NNT_LOTED")	

				dbSelectArea('SX5')
				If SX5->(dbSeek(xFilial('SX5')+'ZZ'))
					If !Empty(Alltrim(X5Descri()))
						While SX5->(!EOF()) .and. SX5->X5_TABELA == 'ZZ'
							cItens += Alltrim(X5Descri())+','
							SX5->(Dbskip())
						EndDo
						lRet := .F.
						aList1 := StrTokArr(cItens,",")
						
						oFont1  := TFont():New( "MS Sans Serif",0,-16,,.T.,0,,700,.F.,.F.,,,,,, )
						oFont2  := TFont():New( "MS Sans Serif",0,-14,,.F.,0,,400,.F.,.F.,,,,,, )
						oDlg1   := MSDialog():New( 221,354,431,910,"Deletar Linha",,,.F.,,,,,,.T.,,,.T. )
						oSay1   := TSay():New( 004,080,{||"Justifique a exclus?o da linha"},oDlg1,,oFont1,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,120,012)
						oGrp1   := TGroup():New( 020,004,080,268,"",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
						oList1  := TListBox():New(027,008,{|u|if(Pcount()>0,nList:=u,nList)},aList1,256,049,,oDlg1,,CLR_BLACK,CLR_WHITE,.T.,,,oFont2,"",,,,,,, )
						oBtn1   := TButton():New(083,230,"Confirmar",oDlg1,{|| SayMotiv(aList1[nList],cKey),oDlg1:End(),lRet := .T.},037,012,,,,.T.,,"",,,,.F. )
						oDlg1:Activate(,,,.T.)

					EndIf
				EndIf

			ElseIf aParam[5] == 'UNDELETE'

				oModelNNT := oObj:ADATAMODEL[aParam[4]][1][1] // Item deletado

				cQuery := " SELECT NNT_FILIAL,NNT_COD,NNT_FILORI,NNT_PROD,NNT_LOCAL,NNT_LOCALI,NNT_NSERIE, "
				cQuery += " NNT_LOTECT,NNT_NUMLOT,NNT_LOCLD,NNT_FILDES,NNT_PRODD,NNT_LOCDES,NNT_LOTED "
				cQuery += " FROM "+RetSqlName('NNT')+" WHERE NNT_COD='"+oModelNNT[2]+"' "
				cQuery += " AND NNT_FILORI='"+oModelNNT[3]+"' AND NNT_PROD='"+oModelNNT[4]+"' "
				cQuery += " AND NNT_LOCAL='"+oModelNNT[7]+"' AND NNT_FILDES='"+oModelNNT[16]+"' "
				cQuery += " AND NNT_LOCLD='"+oModelNNT[20]+"' AND D_E_L_E_T_='' "
				
				If Select("TMP") <> 0
					DbSelectArea("TMP")
					DbCloseArea()
				EndIf	
				
				DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),'TMP',.F.,.T.)

				cKey := AvKey(TMP->NNT_FILIAL,"NNT_FILIAL")+AvKey(TMP->NNT_COD,"NNT_COD")+AvKey(TMP->NNT_FILORI,"NNT_FILORI")+AvKey(TMP->NNT_PROD,"NNT_PROD")+AvKey(TMP->NNT_LOCAL,"NNT_LOCAL");
				+AvKey(TMP->NNT_LOCALI,"NNT_LOCALI")+AvKey(TMP->NNT_NSERIE,"NNT_NSERIE")+AvKey(TMP->NNT_LOTECT,"NNT_LOTECT")+AvKey(TMP->NNT_NUMLOT,"NNT_NUMLOT")+AvKey(TMP->NNT_FILDES,"NNT_FILDES");
				+AvKey(TMP->NNT_PRODD,"NNT_PRODD")+AvKey(TMP->NNT_LOCLD,"NNT_LOCLD")+AvKey(TMP->NNT_LOCDES,"NNT_LOCDES")+AvKey(TMP->NNT_LOTED,"NNT_LOTED")	

				DbSelectArea("NNT")
				DbSetOrder(1)

				If DbSeek(cKey)
					RecLock("NNT", .F.)		
						NNT->NNT_XMOTIV := ''
						NNT->NNT_XDTEXC := SToD('')
					MsUnLock()
				EndIf 
			EndIf	  
		EndIf          
	EndIf
EndIf
 
RestArea(aAreaNNT) 
RestArea(aAreaNNS)
RestArea(aAreaSX5)
RestArea(aArea)

Return lRet


/*/
(long_description)
@type Static Function
@author Felipe Mayer RVacari
@since 06/07/2020
@Desc: Respons?vel por gravar campo NNT_XMOTIV na tabela
/*/


Static Function SayMotiv(cMotiv,cKey)

Local lRet  := .T.
Local cUsr  := UsrRetName(RetCodUsr())
Local cDate := DToC(Date())
Local cHora := Time()

cMotiv := 'Motivo: '+cMotiv+' | '+'Usuario: '+cUsr+' | '+'Data Exclusao: '+cDate+' -  Hora: '+cHora

    If !Empty(cMotiv)
        DbSelectArea("NNT")
        DbSetOrder(1)

        If DbSeek(cKey)
            RecLock("NNT", .F.)		
                NNT->NNT_XMOTIV := Alltrim(cMotiv) 
				NNT->NNT_XDTEXC := Date()
            MsUnLock()
        Else
            lRet := .F.
        EndIf
    Else
        lRet := .F.
    EndIf

Return lRet
