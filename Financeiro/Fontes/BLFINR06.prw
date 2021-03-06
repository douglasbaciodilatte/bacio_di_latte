#include "totvs.ch"
#include "rwmake.ch
#Include "TOPCONN.CH"
#Include "Tbiconn.ch"

/* 
+-----------------------------------------------------------------------
|FA740BRW -- ponto de entrada que adiciona bot?es no Contas a Receber
|
|Autor Reinaldo Rabelo  23/03/2021
|
|
|
+-----------------------------------------------------------------------
*/
/*
User Function FA740BRW()

    Local aBotao := {}
    aAdd(aBotao, {'Devolu??o ao Cliente',"U_GERANCF",   0 , 3    })

Return(aBotao)
*/
/* 
+----------------------------------------------------------------
|
|
|
+----------------------------------------------------------------
*/

User Function BLFINR06()

    RptStatus({|| NCCxNCF()}, "Aguarde...", "Verificando cadastro Cliente x Fornecedor")

Return

/* 
+----------------------------------------------------------------
|
|
|
+----------------------------------------------------------------
 */

Static Function NCCxNCF()
    PRIVATE cCfilial := SE1->E1_FILIAL
    PRIVATE cCliente := SE1->E1_CLIENTE
    PRIVATE cLoja    := SE1->E1_LOJA

    SetRegua(4)

    If SE1->E1_TIPO == "NCC" .AND. SE1->E1_SALDO > 0
        if ClixFor()
            if FINNCF()
                BaixaNCC()
            endif
        endif

    Endif

Return

/* 
+------------------------------------------------------------------------------------------
|ClixFor --  Rotina responsavel por verificar se o Cliente esta cadastrado como Fornecedor
|           Caso n?o esteja cadastrado ser? cadastrado.
|
+------------------------------------------------------------------------------------------
 */

Static Function ClixFor()

    Local aCampo   := {}
    Local nX       := 0
    Local lRet     := .t.
    Local cCampos  := "A2_LC"
    IncRegua("Validando Cliente x Fonecedor")

    DbSelectArea("SA1")
    SA1->(DBSETORDER(1))
    SA1->(DbSeek(xFilial("SA1") + cCliente + cLoja, .T.))

    DbSelectArea("SA2")
    SA2->(DBSETORDER(3))
    //verifica se o Cliente esta Cadastrado como Fornecedor para Gerar a NCF
    IF !(SA2->(DbSeek(xFilial("SA2")+SA1->A1_CGC,.T.)))

        aCampo := SA2->(DBStruct())
        aCampo1 := SA1->(DBStruct())
        
        // se o cliente n?o estiver cadastrado como fornecedor ser? cadastrado.
        BEGIN TRANSACTION
            reclock("SA2",.T.)

            FOR nX := 1 to len(aCampo)

                nPos := SA1->(FieldPos( "A1"  + SUBSTR(aCampo[nX,1],3,10)))

                if !(aCampo[nX,1] $ cCampos) .and. nPos > 0
                    if aCampo[nX,1] == "A2_COD"
                        SA2->A2_COD := GetSXENum("SA2")
                    elseif aCampo[nX,1] == "A2_TIPO"
                        SA2->A2_TIPO := SA1->A1_PESSOA
                    else

                        SA2->&(aCampo[nX,1]) := SA1->&("A1"  + SUBSTR(aCampo[nX,1],3,10))
                    Endif

                endif

            Next nX

            SA2->(MSUNLOCK())
            ConfirmSX8()
        END TRANSACTION
    ENDIF

return lRet

/* 
+------------------------------------------------------------------------------------
|FINNCF -- Gera um Titulo do Tipo NCF no contas a Pagar com os dados da NCC original
|
|
+------------------------------------------------------------------------------------
 */


Static Function FINNCF()
    Local aArray := {}
    Local lRet   := .t.
    Private lMsErroAuto := .F.

    IncRegua("Gerando NDC")

    aAdd(aArray,{ "E2_PREFIXO" , SE1->E1_PREFIXO, NIL })
    aAdd(aArray,{ "E2_NUM"     , SE1->E1_NUM    , NIL })
    aAdd(aArray,{ "E2_TIPO"    , "NDC"          , NIL })
    aAdd(aArray,{ "E2_PARCELA" , SE1->E1_PARCELA, NIL })
    aAdd(aArray,{ "E2_NATUREZ" , SE1->E1_NATUREZ, NIL })
    aAdd(aArray,{ "E2_FORNECE" , SA2->A2_COD    , NIL })
    aAdd(aArray,{ "E2_LOJA"    , SA2->A2_LOJA   , NIL })

    aAdd(aArray,{ "E2_EMISSAO" , Date()         , NIL })
    aAdd(aArray,{ "E2_VENCTO"  , Date() + 7     , NIL })
    aAdd(aArray,{ "E2_VENCREA" , Date() + 7     , NIL })
    aAdd(aArray,{ "E2_VALOR"   , SE1->E1_VALOR  , NIL })
    aAdd(aArray,{ "E2_FILORIG" , SE1->E1_FILORIG, NIL })
    aAdd(aArray,{ "E2_HIST"    , "T?TULO ORIGINAL:" + SE1->E1_PREFIXO + SE1->E1_NUM + "NCC" , NIL })

    //Rotina automatica para Gera??o da NCF no conta a Pagar
    MsExecAuto( { |x,y,z| FINA050(x,y,z)}, aArray,, 3) // 3 - Inclusao, 4 - Altera??o, 5 - Exclus?o


    If lMsErroAuto
        lRet := .F.
        MostraErro()
    Else
       
        lRet := .t.
    Endif
   
Return lRet

/* 
+----------------------------------------------------------------
|BaixaNCC -- Faz a baixa do Titulo NCC original
|
|
+----------------------------------------------------------------
 */


Static Function BaixaNCC()
    Local cHist  := "Gerado NCF para Devolu??o"
    Local aBaixa := {}
    Private lMsErroAuto:= .F.


    IncRegua("Baixando NCC")
    conout("Teste de Baixa de Titulo")

    aBaixa := { {"E1_PREFIXO"  ,SE1->E1_PREFIXO ,Nil },;
                {"E1_NUM"      ,SE1->E1_NUM     ,Nil },;
                {"E1_TIPO"     ,SE1->E1_TIPO    ,Nil },;
                {"E1_CLIENTE"  ,SE1->E1_CLIENTE ,Nil },;
                {"E1_LOJA"     ,SE1->E1_LOJA    ,Nil },;
                {"E1_NATUREZ"  ,SE1->E1_LOJA    ,Nil },;
                {"E1_PARCELA"  ,SE1->E1_PARCELA ,Nil },;
                {"E1_HIST"     ,SE1->E1_HIST    ,NIL },;
                {"AUTMOTBX"    ,"DEV"           ,Nil },;
                {"AUTDTBAIXA"  ,DATE()          ,Nil },;
                {"AUTDTCREDITO",DATE()          ,Nil },;
                {"AUTHIST"     ,cHist           ,Nil },;
                {"AUTJUROS"    ,0               ,Nil,.T.}}
  
     //Rotina automatica para realizar baixa da NCC
    MSExecAuto({|x,y,b,a| Fina070(x,y,b,a)},aBaixa,3,.F.,3) //3 - Baixa de T?tulo, 5 - Cancelamento de baixa, 6 - Exclus?o de Baixa.

    If lMsErroAuto
        MostraErro()
    Else
        conout("BAIXADO COM SUCESSO!" + E1_NUM)
        MsgBox("Titulo NCC Baixado com sucesso", "Baixa de Titulo", "INFO")
    Endif


Return
