#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#include "ap5mail.ch"

/*/{Protheus.doc} ASCOM001
Rotina responsavel por enviar email de notifica��o ao Fornecedor ap�s a libera��o de um 
PEdido de Compras. Uma copia do email sera enviada � Filial de Entrega

@Author Wanderley Ramos Neto
@Since 05/06/2017
@Param cNumPed		Numero do Pedido liberado
@Param cCodForn		Codigo do Fornecedor do pedido
@Param cLojaForn	Loja do Fornecedor do pedido
@Return Nil
/*/
User Function ASCOM001(cNumPed, cCodForn, cLojaForn)
Local cEmailCom			:= ''
Local cMailCopia		:= ''
Local cFilSC7			:= xFilial('SC7')
Local lProcWF			:= .F.
Local lStatusWF			:= .F.
Local aAreaSM0			:= {}
Local aAreaSA2			:= {}
Local cProcWF			:= SuperGetMv('AS_PWFFOR',,'NOTFOR')
Local cStatusWF			:= SuperGetMv('AS_SWFFOR',,'10001')         
Local cNomLocal         := ''            
Local cNomEstoq         := ''


// --------------------------------------------------------------------------
// Verifica se os processos do Wrokflow necessarios estao cadastrados
// --------------------------------------------------------------------------

lProcWF := WF1->(DbSeek(xFilial("WF1") + cProcWF))
IF !lProcWF
	MsgStop("Processo "+cProcWF+" do WorkFlow nao cadastrado!","Erro")
	Return
Endif

lStatusWF := WF2->(DbSeek(xFilial("WF2") + WF1->WF1_COD + cStatusWF))
IF !lStatusWF
	MsgStop("Status "+cStatusWF+" do processo do "+cProcWF+" do WorkFlow nao cadastrado!","Erro")
	Return
Endif

DbSelectArea("SA2")
SA2->(DbSetOrder(1))

DbSelectArea("SE4")
DbSelectArea("SB1")
SB1->(DbSetOrder(1))

DbSelectArea("SC7")
SC7->(DbSetOrder(1))
SC7->(DbGoTop())
If SC7->(DbSeek(xFilial("SC7")+Alltrim(cNumPed)))
	If SA2->(dbSeek( xFilial("SA2") + cCodForn + cLojaForn ))
		cEmailCom := Alltrim(SA2->A2_EMAIL)
		
		If ! Empty(cEmailCom)
         
			
			oProcess := TWFProcess():New( "NOTFOR", "Notificacao ao Fornecedor" )  
			oProcess :NewTask( "Fluxo de Compras", "\WORKFLOW\notifFornPC.htm" )  
			//oProcess:AttachFile(_cArqPdf)
			
			oHtml    := oProcess:oHTML
			oHtml:ValByName( "C7_NUM"    , SC7->C7_NUM     )
			oHtml:ValByName( "C7_FORNECE", SC7->C7_FORNECE )
			oHtml:ValByName( "C7_LOJA"   , SC7->C7_LOJA    )
			
			oHtml:ValByName( "A2_NOME"   , SA2->A2_NOME   )
			oHtml:ValByName( "A2_CGC"    , SA2->A2_CGC   )
			oHtml:ValByName( "A2_INSCR"  , SA2->A2_INSCR   )
			oHtml:ValByName( "A2_NOME"   , SA2->A2_NOME   )
			oHtml:ValByName( "A2_END"    , SA2->A2_END    )
			oHtml:ValByName( "A2_MUN"    , SA2->A2_MUN    )
			oHtml:ValByName( "A2_EST"    , SA2->A2_EST    )
			oHtml:ValByName( "A2_BAIRRO" , SA2->A2_BAIRRO )
			oHtml:ValByName( "A2_TEL"    , SA2->A2_TEL    )
			oHtml:ValByName( "A2_FAX"    , SA2->A2_FAX    )
			
			// -------------------------------------------------------------
			// Atualizando dados da empresa
			// -------------------------------------------------------------
			oHtml:ValByName( "M0_NOMECOM"	, SM0->M0_NOMECOM	)
			oHtml:ValByName( "M0_CGC"		, SM0->M0_CGC		)
			oHtml:ValByName( "M0_INSC"		, SM0->M0_INSC		)
			oHtml:ValByName( "M0_TEL"		, SM0->M0_TEL		)
			oHtml:ValByName( "M0_ENDCOB"	, SM0->M0_ENDCOB	)
			oHtml:ValByName( "M0_COMPCOB"	, SM0->M0_COMPCOB	)
			oHtml:ValByName( "M0_BAIRCOB"	, SM0->M0_BAIRCOB	)
			oHtml:ValByName( "M0_CIDCOB"	, SM0->M0_CIDCOB	)
			oHtml:ValByName( "M0_ESTCOB"	, SM0->M0_ESTCOB	)
			oHtml:ValByName( "M0_CEPCOB"	, SM0->M0_CEPCOB	)
			
			If !Empty(SC7->C7_FILENT)
				aAreaSM0 := SM0->(GetArea())
				
				If SM0->( dbSeek( cEmpAnt + SC7->C7_FILENT ) )
				
					oHtml:ValByName( "M0_ENDENT"	, SM0->M0_ENDENT	)
					oHtml:ValByName( "M0_COMPENT"	, SM0->M0_COMPENT	)
					oHtml:ValByName( "M0_BAIRENT"	, SM0->M0_BAIRENT	)
					oHtml:ValByName( "M0_CIDENT"	, SM0->M0_CIDENT	)
					oHtml:ValByName( "M0_ESTENT"	, SM0->M0_ESTENT	)
					oHtml:ValByName( "M0_CEPENT"	, SM0->M0_CEPENT	)
					
					aAreaSA2 := SA2->(GetArea())
					cMailCopia := UsrRetMail(RetCodUsr()) //Posicione('SA2', 3, cFilSA2 + SM0->M0_CGC, 'A2_EMAIL')
					oHtml:ValByName( "MAIL_LOJA"	, cMailCopia	)
					RestArea(aAreaSA2)
				EndIf
				
				RestArea(aAreaSM0)
			EndIf
			
			oHtml:ValByName( "Pagamento" , Posicione("SE4",1,xFilial("SE4") + SC7->C7_COND,"E4_DESCRI")   )
			
			// -----------------------------------------
			// Atualiza os Itens da Pedido
			// -----------------------------------------   
			
			
			While SC7->(! Eof()) ;
					.and. SC7->C7_FILIAL = cFilSC7 ;
					.and. Alltrim(SC7->C7_NUM) = Alltrim(cNumPed)
					
					SB1->(dbSetOrder(1))
					SB1->(dbSeek( xFilial("SB1") + SC7->C7_PRODUTO ))
					
				aAdd( (oHtml:ValByName( "it.item"    )), SC7->C7_ITEM    )
				aAdd( (oHtml:ValByName( "it.produto" )), SC7->C7_PRODUTO )				
				aAdd( (oHtml:ValByName( "it.descri"  )), SB1->B1_DESC    ) // SC8->C8_DESCRI  )
				aAdd( (oHtml:ValByName( "it.quant"   )), TRANSFORM(SC7->C7_QTSEGUM, "@E 9,999,999.99"))
				aAdd( (oHtml:ValByName( "it.um"      )), SC7->C7_SEGUM      )
				aAdd( (oHtml:ValByName( "it.preco"   )), TRANSFORM( SC7->C7_TOTAL/iif(Empty(SC7->C7_QTSEGUM),1,SC7->C7_QTSEGUM), "@E 9,999,999.99"))
				aAdd( (oHtml:ValByName( "it.valor"   )), TRANSFORM( SC7->C7_TOTAL, "@E 9,999,999.99")) 					 
				aAdd( (oHtml:ValByName( "it.DtEntrega")), IIF(SUBSTR( CUSERNAME,1,2 ) $ "lj|LJ|", "  " , DTOC( SC7->C7_DATPRF ) ) )              
				aAdd( (oHtml:ValByName( "it.obsitem" )), SC7->C7_OBS    ) // SC8->C8_DESCRI  )  
				
				cNomLocal := SC7->C7_LOCAL
				
				SC7->(dbSkip())
			End
            
             //DbSelectArea("CTT")
		    // CTT->(DbSetOrder(1))			
		    // If CTT->(DbSeek(xFilial("CTT")+cNomLocal))
		  
		 	//	 	cNomEstoq := CTT->CTT_DESC01
		    // Endif   
		     
		     dbselectarea("NNR")
			 dbsetorder(1)     
		     If NNR->(DbSeek(xFilial("NNR")+cNomLocal))

  					cNomEstoq := Alltrim(NNR->NNR_DESCRI) 

             ENDIF        
						
			oHtml    := oProcess:oHTML
			
			// --------------------------------------------------------------------------
			// Inicia o Processo de WorkFlow para envio de E-mail ao fornecedor
			// --------------------------------------------------------------------------
			oProcess:cSubject	:= "Pedido de Compra " + cNumPed + " - " + cNomEstoq
			oProcess:cTo		:= cEmailCom
			oProcess:cCC		:= cMailCopia
			oProcess:Start()
			RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,WF1->WF1_COD,WF2->WF2_STATUS,"Email enviado para o fornecedor")
			
			// --------------------------------------------------------------------------
			// Encerra o processo do WorkFlow logo em seguida, 
			//  pois n�o h� resposta do Fornecedor
			// --------------------------------------------------------------------------
			oProcess:Finish()
			WFSendMail()

		endif
	Endif
Endif

	MsgInfo('WorkFlow enviado com sucesso, fornecedor notificado!')

Return

User Function ASNOTFOR()

U_ASCOM001(SC7->C7_NUM, SC7->C7_FORNECE, SC7->C7_LOJA)

Return Nil