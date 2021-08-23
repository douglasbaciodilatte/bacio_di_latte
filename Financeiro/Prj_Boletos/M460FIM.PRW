#Include "TOTVS.ch"
#Include "TOPCONN.CH"
#Include "TBICONN.ch"
 
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³M460FIM    ºAutor  ³Vanito Rocha      Fº Data ³  27/08/20   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Tratamento para transferencia dos títulos para o Banco      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function M460FIM()

Local aArea := GetArea()


DbSelectArea("SA1")
DbSetOrder(1)//A1_FILIAL+A1_COD+A1_LOJA                                                                                                                                        
DbSeek(xFilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA)
If SA1->A1_XIMPBOL == "1"
    U_GERABORD()
EndIf

RestArea(aArea)
Return

/*
Local cPedido  := ''
Local cCampo   := ''
Local aAreaSF2 := SF2->(GetArea())
Local aAreaSD2 := sd2->(GetArea())
Local aAreaSC5 := sc5->(GetArea())
Local aAreaSE1 := sE1->(GetArea())
Local aAreaSA1 := sA1->(GetArea())
Local aTit := {}
Local aBor := {}

Local cPrefixo := ""
Local cNumero := ""
Local cParcela := ""
Local cTipo := ""
Local cBanco := SuperGetMV("MV_XBLBCO",.F.,"237")
Local cAgencia := SuperGetMV("MV_XBLAGEN",.F.," ")
Local cConta := SuperGetMV("MV_XBLCC",.F.,"")
Local cSituaca := "1"
Local cNumBco := NossoNum() //verificar o digito verificador do bradesco e qual o tamanho do Nossonum
Local nDesconto := 0
Local nValCred := 0
Local nVlIof := 0
Local dDataMov := dDataBase

//-- Variáveis utilizadas para o controle de erro da rotina automática
Local aErroAuto :={}
Local cErroRet :=""
Local nCntErr :=0

Local c_Alias 

Private lMsErroAuto := .F.
Private lMsHelpAuto := .T.
Private lAutoErrNoFile := .T.

//Tratamento para Transferencia do Título que será que será usado na Impressão do Boleto no final da impressão da DANFE.


DbSelectArea("SA1")
DbSetOrder(1)//A1_FILIAL+A1_COD+A1_LOJA                                                                                                                                        
DbSeek(xFilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA)
Impbol:=SA1->A1_XIMPBOL
		
If Impbol=="1"
    //Informações bancárias
    aAdd(aBor, {"AUTDATAMOV" , dDataMov ,Nil})
    aAdd(aBor, {"AUTBANCO" , PadR(cBanco ,TamSX3("A6_COD")[1]) ,Nil})
    aAdd(aBor, {"AUTAGENCIA" , PadR(cAgencia ,TamSX3("A6_AGENCIA")[1]) ,Nil})
    aAdd(aBor, {"AUTCONTA" , PadR(cConta ,TamSX3("A6_NUMCON")[1]) ,Nil})
    aAdd(aBor, {"AUTSITUACA" , PadR(cSituaca ,TamSX3("E1_SITUACA")[1]) ,Nil})
    aAdd(aBor, {"AUTNUMBCO" , PadR(cNumBco ,TamSX3("E1_NUMBCO")[1]) ,Nil})
    
    c_Alias := GetNextAlias()

    BEGINSQL ALIAS c_Alias
        %NOPARSER%
        SELECT * FROM %TABLE:SE1% E1
            WHERE E1.%NOTDEL% AND E1_FILIAL = %EXP:XFILIAL("SE1")% AND E1_PREFIXO = %EXP:SF2->F2_SERIE%
                AND E1_NUM = %EXP:SF2->F2_DOC% AND E1_TIPO = 'NF'
    ENDSQL
    dbSelectArea(c_Alias)
    //Enquanto tiver dados na query
    While !(c_Alias)->(eof())
        DbSelectArea("SE1")
        SE1->(DbGoTo((c_Alias)->R_E_C_N_O_) )
          
        aAdd(aTit, {"E1_PREFIXO" , PadR(SE1->E1_PREFIXO , TamSX3("E1_PREFIXO")[1]) ,Nil})
        aAdd(aTit, {"E1_NUM" , PadR(SE1->E1_NUM , TamSX3("E1_NUM")[1]) ,Nil})
        aAdd(aTit, {"E1_PARCELA" , PadR(SE1->E1_PARCELA , TamSX3("E1_PARCELA")[1]) ,Nil})
        aAdd(aTit, {"E1_TIPO" , PadR(SE1->E1_TIPO , TamSX3("E1_TIPO")[1]) ,Nil})
         
        (c_Alias)->(DbSkip())
    Enddo
    (c_Alias)->(DbCloseArea())
    MSExecAuto({|a, b| FINA060(a, b)}, 3,{aBor,aTit}) 
    
    If lMsErroAuto
        aErroAuto := GetAutoGRLog()
            For nCntErr := 1 To Len(aErroAuto)
                cErroRet += aErroAuto[nCntErr]
            Next
        Conout(cErroRet)
    EndIf
Endif
     
RestArea(aAreaSF2)
RestArea(aAreaSD2)
RestArea(aAreaSC5)
RestArea(aAreaSE1)
RestArea(aAreaSA1)

Return
*/
