#Include 'Protheus.ch'
#Include 'FWMVCDEF.ch'
#Include "TOTVS.ch"
#Include "FWMVCDEF.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#include 'RWMAKE.CH'


/*/{Protheus.doc} MT311ROT
    @type User Function
    @author Felipe Mayer - RVacari
    @since 21/08/2020
    @Desc Ponto de entrada para Adicionar botao MATA311
/*/
User Function MT311ROT()

Local aRet := Paramixb 

    ADD OPTION aRet TITLE "Lib Lotes/End"       ACTION "U_RLOTETMA1"    OPERATION 7 ACCESS 0
    ADD OPTION aRet TITLE "Voltar Solitação"    ACTION "U_ROTRF004"     OPERATION 8 ACCESS 0
    ADD OPTION aRet TITLE "Receber NF-e"        ACTION "U_SINCBDL"      OPERATION 9 ACCESS 0
    ADD OPTION aRet TITLE "Legenda"             ACTION "U_LEG311"       OPERATION 10 ACCESS 0
    ADD OPTION aRet TITLE "Relatório Solict"    ACTION "U_RELBTAC"      OPERATION 11 ACCESS 0
    ADD OPTION aRet TITLE "Enviar Refrio"       ACTION "U_XMLREFR"      OPERATION 12 ACCESS 0
    ADD OPTION aRet TITLE "Consultar Refrio"    ACTION "U_BLCONSPE"     OPERATION 13 ACCESS 0
   
Return aRet
