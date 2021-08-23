#include "TOTVS.CH"
#include "TOPCONN.CH"

/*
// Gera bordero para clientes que preferem 
// que os boletos já sejam enviado junto com a 
// Nota Fiscal.
*/
User Function GERABORD()
Local aArea := GetArea()
Local c_Alias := ""
Local cNumBord := VrfNumBor()
Local cBanco := Alltrim(SuperGetMV("MV_XBLBCO",.F.,"237"))
Local cAgencia := Alltrim(SuperGetMV("MV_XBLAGEN",.F.," "))
Local cConta := Alltrim(SuperGetMV("MV_XBLCC",.F.,""))
Local cSitTit := "1"

c_Alias := GetNextAlias()

BEGINSQL ALIAS c_Alias
    %NOPARSER%
    SELECT * FROM %TABLE:SE1% E1
        WHERE E1.%NOTDEL% AND E1_FILIAL = %EXP:XFILIAL("SE1")% AND E1_PREFIXO = %EXP:SF2->F2_PREFIXO%
        AND E1_CLIENTE = %EXP:SF2->F2_CLIENTE% AND E1_LOJA = %EXP:SF2->F2_LOJA%
        AND E1_NUM = %EXP:SF2->F2_DOC% AND E1_TIPO = 'NF'
ENDSQL
dbSelectArea(c_Alias)
While (c_Alias)->(! Eof() )
    
    dbSelectArea("SE1")
    dbSetOrder(1)
    dbGoto((c_Alias)->R_E_C_N_O_)
    Reclock("SE1",.F.)
    SE1->E1_PORTADO := cBanco
    SE1->E1_AGEDEP  := cAgencia 
    SE1->E1_SITUACA := cSitTit
    SE1->E1_NUMBOR  := cNumBord
    SE1->E1_DATABOR := Msdate()
    SE1->E1_MOVIMEN := Msdate()
    SE1->E1_CONTA	:= cConta
    MsUnlock()

    DbSelectArea("SEA")
    dbSetOrder(1)
    RecLock("SEA",.T.)
    SEA->EA_FILIAL	:= xFilial("SEA")
    SEA->EA_NUMBOR  := cNumBord
    SEA->EA_DATABOR := MsDate()
    SEA->EA_PORTADO := cBanco
    SEA->EA_AGEDEP  := cAgencia 
    SEA->EA_NUMCON  := cConta 
    SEA->EA_NUM 	:= SE1->E1_NUM
    SEA->EA_PARCELA := SE1->E1_PARCELA
    SEA->EA_PREFIXO := SE1->E1_PREFIXO
    SEA->EA_TIPO	:= SE1->E1_TIPO
    SEA->EA_CART	:= "R"
    SEA->EA_SITUACA := cSitTit
    SEA->EA_FILORIG := SE1->E1_FILORIG
    SEA->(MsUnlock())
    FKCOMMIT()
    (c_Alias)->( dbSkip() )
EndDo

PutMv("MV_NUMBORR",cNumBord)

RestArea(aArea)
Return
/*
// Verifica se o numero de bordero
// esta sendo ou foi utlizado
*/
Static Function VrfNumBor()
Local aArea := GetArea()
Local c_Alias 

Local cNumRet := Soma1(GetMV("MV_NUMBORR"),6)
Local lNextBord := .T.

While lNextBord
    c_Alias := GetNextAlias()

    BEGINSQL ALIAS c_Alias
        %NOPARSER%
        SELECT E1_NUMBOR FROM %TABLE:SE1% (NOLOCK) E1
        WHERE E1.%NOTDEL% AND E1_NUMBOR = %EXP:cNumRet%
    ENDSQL

    DbSelectArea(c_Alias)
    If Eof()
        lNextBord := .F.
    Endif
    (c_Alias)->( dbCloseArea() )

EndDo

cNumRet := Replicate("0",TamSX3("E1_NUMBOR")[1]-Len(Alltrim(cNumRet)))+Alltrim(cNumRet)
While !MayIUseCode("SE1"+xFilial("SE1")+cNumRet)  //verifica se esta na memoria, sendo usado
	// busca o proximo numero disponivel 
	cNumRet := Soma1(cNumRet)
EndDo

RestArea(aArea)

Return cNumRet
