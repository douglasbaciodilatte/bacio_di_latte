#Include "tbiconn.ch"
#Include "protheus.ch"


/*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºPrograma ³ BDLFIS01         ºAutor³ RVACARI Felipe Mayer	    º Data Ini³ 09/03/2020   º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºDesc.    ³ Excluir duplicidade da camada                                                  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºUso      ³ BACIO DI LATTE	                                            		  		  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/

User Function BDLFIS01()

Local aPergs  := {}
Local cMes    := Space(2)
Local cAno    := Space(4)

    aAdd(aPergs, {1, "Mês",  cMes,  "",  ".T.",   "",  ".T.", 80,  .T.})
    aAdd(aPergs, {1, "Ano",	 cAno,  "",  ".T.",   "",  ".T.", 80,  .T.})

    If ParamBox(aPergs, "Excluir Duplicidade da Camada")
        MsAguarde({|| DelDupli()},,"Excluindo duplicidade...")
    EndIf

Return Nil


/*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± Static.	 ³ DelDupli     |    ºAutor³ RVACARI Felipe Mayer	    º Data Ini³ 09/03/2020    ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± ºDescR.   ³ Responsável por montar Query do Update               						  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/

Static Function DelDupli()

Local cData   := MV_PAR02+MV_PAR01
Local cQuery  := ''

Private MV_PAR01
Private MV_PAR02

    cQuery := " UPDATE "+RetSqlName("PIN")+" SET D_E_L_E_T_ = '*', R_E_C_D_E_L_ = R_E_C_N_O_ "
    cQuery += " WHERE SUBSTRING(PIN_EMISNF,1,6) = '"+cData+"' "
    cQuery += " AND PIN_LOGINT IN  ('STR0130' , 'STR0132') "
    cQuery += " AND D_E_L_E_T_ != '*' "

    TCSQLExec(cQuery)

    MsgInfo("Processo Finalizado!","BDLFIS01")

Return