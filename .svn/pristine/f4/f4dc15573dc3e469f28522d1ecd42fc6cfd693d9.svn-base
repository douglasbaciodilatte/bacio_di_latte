#INCLUDE "PROTHEUS.CH"
#include "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³SF2460I   ºAutor  ³Elaine Mazaro       º Data ³  23/02/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada localizado apos a atualizacao das tabelas  º±±
±±º          ³ referentes a nota fiscal (SF2/SD2), mas antes da           º±± 
±±º          ³ contabilizacao.                                            º±± 
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Bacio                                                       º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function SF2460I() 
	
	U_BACDM040()
	
	MsAguarde({|| ADJ_NF2()},"Processamento","Buscando detalhes faturamento...")
	
	//Rotina aviso de Pagamento Guia ICMS - ST

	U_BDFAT001()

Return(Nil)

//+---------------------------------------------------------------------+
//| Ajuste Nota Fiscal                                                  |
//+---------------------------------------------------------------------+

Static Function ADJ_NF2()

	Local lRet			:= .T.
	Local aAreaAnt 		:= GETAREA()
	Local aRet			:= {}
	Local cMennota 	 	:= ""
	Local _cOP			:= ""
	Local lEfetiva		:= IsInCallStack("A311Efetiv") 
	Private _nVolume := 10
	Private _cTransp  := '00001'
	Private _aFrete   := {"C-CIF","F-FOB","T-Por Conta Terceiros","R-Por Conta Remetente","D-Por Conta Destinatario","S-Sem Frete"}
	Private _TpVolume:= "CX"
	Private _cInfCompl:= ""
	Private _cVeiculo := Space(9)
	Private _nPallets:= 0
	Private _cOPs      := Space(14)
	
	Private aParamBox	:= {}

	//Verifica se pedido proveniente de uma transferencia
	If ! EMPTY( SC5->C5_XSOLTRA )
		//Busca solicitação e grava Pedido/Nota/Serie
		NNS->(dbselectarea("NNS"))	
		NNS->(dbsetorder(1))
		If NNS->(dbSeek( SC5->C5_FILIAL + SC5->C5_XSOLTRA ))
			RecLock("NNS",.F.)
				NNS->NNS_PEDIDO	:= SC5->C5_NUM
				NNS->NNS_DOC 	:= SC5->C5_NOTA
				NNS->NNS_SERIE	:= SC5->C5_SERIE
			MsUnlock()
		EndIf
	EndIf

	//Verifica se esta fabrica
	If SF2->F2_FILIAL $ "0031|0072|0136"
	
		//Cria mensagem padrão para dados adicionais NF-e
		//SUBSTR(FwFldGet("NNT_PROD"),1,2) $ "PA|PI"
		//Busca quantidade de volumes nota fiscal
		
		If SUBSTR(NNT->NNT_PROD,1,2) $ "PA|PI"
			_nVolume 	:= XBUSCVOL( SC6->C6_NUM ) 
			_TpVolume	:= "BD"
		Else	
			_nVolume	:= SC5->C5_VOLUME1
		EndIf

		_cInfCompl := SPACE(80)
		
		//Soma quantidade de itens pedido de venda
		If !Empty(NNT->NNT_LOCLD) .And. SC6->C6_CLI == "07XPHH"
			SA1->(dbselectarea("SA1"))
			SA1->(dbsetorder(1))
			If SA1->(dbSeek( xFilial("SA1") + SC6->C6_CLI + NNT->NNT_LOCLD))

				_cInfCompl := "ENTREGA: " + Alltrim(SA1->A1_END)
				
				If ! EMPTY( Alltrim(SA1->A1_COMPLEM) )
					_cInfCompl += " " + Alltrim(SA1->A1_END)
				EndIf	

				_cInfCompl += " " + Alltrim(SA1->A1_BAIRRO)
				_cInfCompl += " " + Alltrim(Transform(SA1->A1_CEP, "@R 99999-999")) 
				_cInfCompl += " " + Alltrim(SA1->A1_MUN)
				_cInfCompl += " " + Alltrim(SA1->A1_EST)
				_cInfCompl += SPACE(20)
			
			ElseIf SA1->(dbSeek( xFilial("SA1") + SC6->C6_CLI + SC6->C6_LOJA))

				_cInfCompl := "ENTREGA: " + Alltrim(SA1->A1_END)
				
				If ! EMPTY( Alltrim(SA1->A1_COMPLEM) )
					_cInfCompl += " " + Alltrim(SA1->A1_END)
				EndIf	

				_cInfCompl += " " + Alltrim(SA1->A1_BAIRRO)
				_cInfCompl += " " + Alltrim(Transform(SA1->A1_CEP, "@R 99999-999")) 
				_cInfCompl += " " + Alltrim(SA1->A1_MUN)
				_cInfCompl += " " + Alltrim(SA1->A1_EST)
				_cInfCompl += SPACE(20)

			EndIf
		EndIf 

		//aAdd(aParamBox,{1,"Valor",0,"@E 9,999.99","mv_par02>0","","",20,.F.}) // Tipo numérico
					
		aAdd(aParamBox,{1 ,"Volume"        ,_nVolume       ,"@E 9,999.99",      ,"","",20,.F.,.T.}) // 1
		aAdd(aParamBox,{1 ,"Transportadora",SC5->C5_TRANSP ,""           ,"ExistCPO('SA4')","SA4","",0,.F.,.T.}) // 2
		aAdd(aParamBox,{3 ,"Tipo Frete"    ,1              ,_aFrete       ,100   ,"" ,.F.}) // 3
		aAdd(aParamBox,{1 ,"Tipo Volume"   ,_TpVolume      ,""           ,""   ,"SAH","",0,.F.,.T.})  //4
		aAdd(aParamBox,{11,"Mensagem NF-e" ,_cInfCompl     ,".T."        ,".T.",.T.}) //5
		aAdd(aParamBox,{1 ,"Veiculo 1"     ,_cVeiculo      ,""           ,""   ,"DA3","",0,.F.,.T.}) //6
		aAdd(aParamBox,{1 ,"Pallets"       ,_nPallets      ,"@E 9,999.99",     ,""   ,"",20,.F.,.T.}) //7
		aAdd(aParamBox,{1 ,"Ordem Producao",_cOPs           ,""           ,""   ,"SC2","",0,.F.,.T.}) //8
		
		If U_ParamBoZ(aParamBox ,"Parametros ",@aRet,{||.T.},{},100,300)//ParamBox(aParamBox ,"Parametros ",aRet)
		    
			//Adiciona Numero Ordem de produção Mensagem para nota
			If ! Empty( aRet[8] ) .And. !lEfetiva
				_cOP += " O.P " + SUBSTR(aRet[8],1,6)
			EndIf

			SF2->F2_VOLUME1	:= aRet[1]
			SF2->F2_TRANSP	:= aRet[2]
			SF2->F2_TPFRETE	:= Substr(_aFrete[aRet[3]],1,1)  //IIF(aRet[3] == 1, "C", "F")
			SF2->F2_ESPECI1	:= Alltrim( UPPER(aRet[4]) )
			SF2->F2_XMENS	:= Alltrim( _cOP ) + Alltrim( aRet[5] ) 
			SF2->F2_XSTATUS	:= "2"  
			SF2->F2_VEICUL1	:= Alltrim( aRet[6] )

			//Efetua manutenção cabeçalho pedido de venda
			If SC5->C5_FILIAL + SC5->C5_NUM == SD2->D2_FILIAL + SD2->D2_PEDIDO 
			
				//Verifica se encontra a transferência e ajusta endereço de entrega da nota fiscal
				NNR->(dbselectarea("NNR"))
				NNR->(dbsetorder(1))
				If NNR->( dbseek( SC5->C5_FILIAL + SC5->C5_XSOLTRA ))    		
					cMennota := " Entreg em: " + Alltrim( NNR->NNR_DESCRI ) + " Num Transferecia.: "+ Alltrim( NNT->NNT_COD )
				EndIf  	
						
				//Verificar se o Array foi preeochido ou ação foi cancelada pelao usuário - Douglas Silva 10.03.2020
				If Len(aRet) > 1

					RecLock("SC5",.F.)
						SC5->C5_VOLUME1	:= aRet[1]
						SC5->C5_TRANSP	:= aRet[2]	
						SC5->C5_TPFRETE	:= Substr(_aFrete[aRet[3]],1,1) //IIF(aRet[3] == 1, "C", "F")
						SC5->C5_ESPECI1	:= UPPER(aRet[4])	
						SC5->C5_MENNOTA	:= Alltrim(SC5->C5_MENNOTA) + cMennota												
					MsUnlock()

				EndIf
			EndIf		
				
		EndIf
					
	EndIf

	//Valida se existe pedido de compra cliente
	If SC5->(FieldPos("C5_XPEDCLI")) > 0 
		If ! EMPTY( SC5->C5_XPEDCLI )						
			SF2->F2_XMENS := Alltrim(SF2->F2_XMENS) + " P.C " + Alltrim(SC5->C5_XPEDCLI) 	
		EndIf			
	EndIf	

	//Alterado por Douglas Silva 29/12/2020 - Adiciona Nome do Cliente:
	If SF2->F2_TIPO == "N"
		SA1->(dbselectarea("SA1"))
		SA1->(dbsetorder(1))
		If SA1->(dbSeek( xFilial("SA1") + SF2->F2_CLIENTE + SF2->F2_LOJA))
			SF2->F2_XMENS := Alltrim(SF2->F2_XMENS) + " CLIENTE " + Alltrim(SA1->A1_NREDUZ) + " "
		EndIf
	EndIf

	//Adiciona o numero do pedido de venda:
	SF2->F2_XMENS := Alltrim(SF2->F2_XMENS) + " PEDIDO " + Alltrim(SC5->C5_NUM) + " "
	
	RestArea(aAreaAnt)
	
Return( lRet )

//+---------------------------------------------------------------------+
//| Rotina automática para envio do Endereço de entrega                 |
//+---------------------------------------------------------------------+

Static Function XBUSCVOL(_cNumPed)

	Local cQuery

	cQuery := " SELECT SUM(NNT_QUANT) SOMA_1, SUM(NNT_QTSEG) SOMA_2 " + CRLF
	cQuery += " FROM "+RETSQLNAME("NNT")+ " " + CRLF 
	cQuery += " WHERE NNT_COD = '"+NNT->NNT_COD+"' AND D_E_L_E_T_ != '*' AND NNT_FILIAL = '" + xFilial("NNT") + "'  " + CRLF

	If ( Select("TMP1") ) > 0
		DbSelectArea("TMP1")
		TMP1->(DbCloseArea())
	EndIf

	TCQUERY cQuery NEW ALIAS "TMP1"

	DbSelectArea("TMP1")
	DbGoTop()
	
	_nVolume := TMP1->SOMA_1
			
Return(_nVolume)
