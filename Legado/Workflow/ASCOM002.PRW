#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOTVS.CH"
#include "ap5mail.ch"

/*/{Protheus.doc} ASCOM002
Rotina responsavel por enviar email de notificação à Bexcell após a geração de uma 
pré nota para classificação.

@Author Wanderley Ramos Neto
@Since 14/07/2017
@Return Nil
/*/
User Function ASCOM002(cDoc,cSerie,cForn,cLoja,cTipo)
Local cFilSD1			:= xFilial('SD1')
Local aAreas			:= {SB1->(GetArea()),SA2->(GetArea()),WF1->(GetArea()),WF2->(GetArea()),SD1->(GetArea()),SF1->(GetArea()),GetArea()}
Local lProcWF			:= .F.
Local lStatusWF			:= .F.
Local aAreaSM0			:= {}
Local aAreaSA2			:= {}
Local cEmailCom			:= SuperGetMV('AS_MAILCPN',,'bacio@bexcell.com.br')
Local cProcWF			:= SuperGetMv('AS_PWFPNT',,'NOTPNT')
Local cStatusWF			:= SuperGetMv('AS_SWFPNT',,'10001')


// --------------------------------------------------------------------------
// Verifica se os processos do Workflow necessarios estao cadastrados
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

DbSelectArea("SB1")
SB1->(DbSetOrder(1))

If SF1->(DbSeek(xFilial("SF1")+cDoc+cSerie+cForn+cLoja+cTipo))
		
	oProcess := TWFProcess():New( cProcWF, "Notificação de Pré-Nota" )  
	oProcess :NewTask( "Classificação de Pré-Nota", "\WORKFLOW\notifPreNota.htm" )  
	//oProcess:AttachFile(_cArqPdf)
	
	oHtml    := oProcess:oHTML
	// -------------------------------------------------------------
	// Atualizando dados da Pré Nota
	// -------------------------------------------------------------

	oHtml:ValByName( "F1_DOC"		, SF1->F1_DOC		)
	oHtml:ValByName( "F1_SERIE"		, SF1->F1_SERIE		)
	oHtml:ValByName( "F1_FORNECE"	, SF1->F1_FORNECE	)
	oHtml:ValByName( "F1_LOJA"		, SF1->F1_LOJA  	)
	oHtml:ValByName( "NOM_FOR"		, Posicione('SA2',1,xFilial('SA2')+SF1->F1_FORNECE+SF1->F1_LOJA,'A2_NOME'))
	oHtml:ValByName( "F1_EMISSAO"	, SF1->F1_EMISSAO  	)
	oHtml:ValByName( "F1_ESPECIE"	, SF1->F1_ESPECIE  	)
	oHtml:ValByName( "F1_UF"		, SF1->F1_EST  		)
	
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
	
	
	// -----------------------------------------
	// Atualiza os Itens da Pré-Nota
	// -----------------------------------------
	
	SD1->(DbSetOrder(1))
	If SD1->( dbSeek( cFilSD1+cDoc+cSerie+cForn+cLoja ) )
	
		While SD1->(! Eof()) ;
				.And. SD1->(D1_FILIAL+D1_DOC+D1_SERIE+D1_FORNECE+D1_LOJA) == cFilSD1+cDoc+cSerie+cForn+cLoja
			
			aAdd( (oHtml:ValByName( "it.item"    )), SD1->D1_ITEM    )
			aAdd( (oHtml:ValByName( "it.produto" )), SD1->D1_COD )
			If SB1->(dbSeek( xFilial("SB1") + SD1->D1_COD ))
				aAdd( (oHtml:ValByName( "it.descri"  )), SB1->B1_DESC    )
			EndIf
			aAdd( (oHtml:ValByName( "it.quant"   )), Alltrim(Str(SD1->D1_QUANT,15,2)) )
			aAdd( (oHtml:ValByName( "it.um"      )), SD1->D1_UM      )
			aAdd( (oHtml:ValByName( "it.armazem" )), SD1->D1_LOCAL      )			
			aAdd( (oHtml:ValByName( "it.preco"   )), Alltrim(Str(SD1->D1_TOTAL/iif(Empty(SC7->C7_QTSEGUM),1,SD1->D1_QUANT),15,2)) )
			aAdd( (oHtml:ValByName( "it.valor"   )), Alltrim(Str(SD1->D1_TOTAL,15,2)) )
			aAdd( (oHtml:ValByName( "it.cc" 	 )), Alltrim(SD1->D1_CC) )
			aAdd( (oHtml:ValByName( "it.dia"     )), left(alltrim(str(day(SD1->D1_EMISSAO))),2))
			aAdd( (oHtml:ValByName( "it.mes"     )), padl(alltrim( str( month(SD1->D1_EMISSAO) ) ),2,"0") )
			aAdd( (oHtml:ValByName( "it.ano"     )), right(str(year(SD1->D1_EMISSAO)),2))
			
			SD1->(dbSkip())
		End
	EndIf	
	
	oHtml    := oProcess:oHTML
	
	// --------------------------------------------------------------------------
	// Inicia o Processo de WorkFlow para envio de E-mail ao fornecedor
	// --------------------------------------------------------------------------
	oProcess:cSubject	:= "Pré-Nota disponível para classificação."
	oProcess:cTo		:= cEmailCom
	oProcess:Start()
	RastreiaWF(oProcess:fProcessID+'.'+oProcess:fTaskID,WF1->WF1_COD,WF2->WF2_STATUS,"Email enviado para o fornecedor")
	
	// --------------------------------------------------------------------------
	// Encerra o processo do WorkFlow logo em seguida, 
	//  pois não há resposta do Fornecedor
	// --------------------------------------------------------------------------
	oProcess:Finish()
	WFSendMail()

Endif

AEval(aAreas, {|x| RestArea(x) })

MsgAlert('Rotina de envio de e-mail de notificação concluída com sucesso.')

Return