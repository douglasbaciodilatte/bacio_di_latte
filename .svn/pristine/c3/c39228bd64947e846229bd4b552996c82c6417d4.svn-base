#INCLUDE 'totvs.ch'
#INCLUDE 'FWMVCDEF.CH'

/*/{Protheus.doc} User Function RLOTETMA1

description)
    @type  Function
    @author Douglas Rodrigues da Silva
    @since 28/09/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    Rotina tem como função abrir tela de transferencia e marcar quais devem distribuir os lotes
    @see (links_or_references)
    /*/

User Function RLOTETMA1()

    Local _aBoxParam 	:= {}
	Private _aXRetPAram 	:= {}
	
	Private aRotina := MenuDef()
	Private cCondicao
	Private oMark
		
	Aadd(_aBoxParam,{1,"Filial"			 ,Space(04)		,"@!"	,""	,"SM0"   	,""	,05	,.F. })
	
    Aadd(_aBoxParam,{1,"Transferencia de",Space(10)		,"@!"	,""	,"NNS"	,""	,50	,.F. })
	Aadd(_aBoxParam,{1,"Transferencia de",Space(10)		,"@!"	,""	,"NNS"	,""	,50	,.F. })
	
	If ParamBox(_aBoxParam, "Busca Nota Fiscal Serviço", @_aXRetPAram)
		
		cCondicao := "	NNS_FILIAL == 		'" + _aXRetPAram[1] + "' " 
		cCondicao += " .AND. NNS_COD >=  	'" + _aXRetPAram[2] + "' " 
		cCondicao += " .AND. NNS_COD <= 	'" + _aXRetPAram[3] + "' " 
        cCondicao += " .AND. NNS_STATUS == 	'1' " 
									
		oMark := FWMarkBrowse():New()
		oMark:SetAlias('NNS')
		oMark:SetFilterDefault(cCondicao)
		oMark:SetSemaphore(.T.)
		oMark:SetDescription('Seleção Transferencias para Lotes')
		oMark:SetFieldMark( 'NNS_OK' )
		oMark:SetAllMark( { || oMark:AllMark() } )	
		oMark:Activate()
				
	EndIf
    
Return 

/*-----------------------------------------------------------------
//   Rotina: RLOTETMA1
//   Descrição: Verifica documentos selecionados
//   Autor: Douglas Silva
//   Data: 29/04/2019
//   Uso: Bacio di Latte
-----------------------------------------------------------------*/

Static Function MenuDef()

Local aRotina := {}

	ADD OPTION aRotina TITLE 'Confirmar' ACTION 'U_RLOTETM2' OPERATION 2 ACCESS 0

Return aRotina

/*-----------------------------------------------------------------
//  Rotina: RLOTETM2
//  Descrição: Verifica documentos selecionados
//  Autor: Douglas Silva
//  Data: 28-09-2020
//  Uso: Processar
-----------------------------------------------------------------*/

User Function RLOTETM2()

	Local aArea 		:= GetArea()
	Local cMarca 		:= oMark:Mark()
	Local aIndexNNS     := {}
		
	bFiltraBrw	:= {|| FilBrowse("NNS",@aIndexNNS,@cCondicao) }
	Eval(bFiltraBrw)
	
		While !NNS->( EOF() )
		    If oMark:IsMark(cMarca)
		        
                //Procura tabela NNT - Detalhes
                NNT->(dbSelectArea("NNT"))
                NNT->(DbSetOrder(1)) //NNT_FILIAL, NNT_COD
                
                If NNT->(DbSeek( NNS->NNS_FILIAL + NNS->NNS_COD ))

                    Do While NNT->(!EOF() .And. NNS->NNS_FILIAL + NNS->NNS_COD == NNT->NNT_FILIAL + NNT->NNT_COD)

                        //Verifica se produto da solicitação controle Rastro/Lote
                        If Rastro(NNT->NNT_PROD) .And. EMPTY(NNT->NNT_LOTECT)
                            
                            //Busca cadastro de proutos
                            SB1->(DBSelectArea("SB1"))
                            SB1->(DBSetOrder(1))
                            SB1->(dbSeek (xFilial("SB1") + NNT->NNT_PROD ))

                            //Verifica saldo atual do produto SB2
                            dbSelectArea("SB2")
                            If SB2->(dbSeek(xFilial('SB2')+NNT->NNT_PROD + NNT->NNT_LOCAL))
                                nQtdEst := SaldoMov(Nil,.F.,Nil,Nil,Nil,Nil, Nil, Date()) // deve sempre considerar o saldo disponivel (desconsiderando o empenho)
                                If nQtdEst < NNT->NNT_QUANT 
                                    Alert("ATENÇÃO: Produto com saldo inferior ao solicitado " + cValToChar(nQtdEst) + " Produto: " + Alltrim(NNT->NNT_PROD) )
                                    
                                EndIf
                            EndIf

                            SB8->( DbSetOrder(1) )
                            If SB8->( DbSeek(xFilial('SB8')+ NNT->NNT_PROD + NNT->NNT_LOCAL ) )

                                Do While SB8->(!EOF() .And. SB8->B8_PRODUTO + SB8->B8_LOCAL == NNT->NNT_PROD + NNT->NNT_LOCAL )
                                    
                                    //Carrega saldo do Lote
                                    nQtdEst := SaldoLote(SB8->B8_PRODUTO,SB8->B8_LOCAL,SB8->B8_LOTECTL,Nil,Nil,Nil,Nil, Date() ,,.T.)

                                    If nQtdEst < NNT->NNT_QUANT .And. !EMPTY(NNT->NNT_LOTECT)    
                                        
                                        Alert("ATENÇÃO: Quantidade disponível em lote insuficiente para atender transferencia " +;
                                         NNT->NNT_COD + " Produto " + Alltrim(NNT->NNT_PROD) + " Lote " + Alltrim(SB8->B8_LOTECTL) )
                                                                                 
                                    Else    
                                        
                                       // GravaB8Emp("+",NNT->NNT_QUANT,"F",NIL,NNT->NNT_QTSEG)

                                        //Grava os lotes tabela NNT
                                        RecLock("NNT", .F.)	
                                            
                                            NNT->NNT_LOTECT := SB8->B8_LOTECTL
                                            NNT->NNT_NUMLOT := SB8->B8_NUMLOTE
                                            NNT->NNT_DTVALI := SB8->B8_DTVALID
                                            NNT->NNT_POTENC := SB8->B8_POTENCI

                                            NNT->NNT_LOTED  := SB8->B8_LOTECTL
                                            NNT->NNT_DTVALD := SB8->B8_DTVALID

                                        MsUnLock() 
                                    
                                    EndIf    
                                    SB8->(dbSkip())
                                Enddo    

                            Else

                                Alert("ATENÇÃO: Produto controla rastro mas não localizado tabela SB8 Transf " + NNT->NNT_COD + " Produto " + Alltrim(NNT->NNT_PROD))                          

                            Endif

                        EndIf
                    
                    NNT->(dbSkip())
                    Enddo    
                
                EndIf    
		        
		    EndIf
		    NNS->( dbSkip() )
		End
		
	Set Filter to 
		
	RestArea( aArea )
	
    MsgInfo("Distribuição de Lotes concluída com sucesso!")

Return Nil
