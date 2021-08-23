#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "PROTHEUS.CH"

/*±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± Programa ³   BDESTA10          Autor: Felipe Mayer            Data: 26/05/2020     ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± Desc.    ³ 	Consulta Sincroniação de inventarios    		 					  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±± Uso      ³   BACIO DI LATTE                                            		      ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±*/

User Function BDESTA10()

Local aPergs   := {}
Local cLoja    := Space(04)
Local dData    := SToD('')
Local cQuery   := ''

 
    aAdd(aPergs, {1, "Loja", cLoja, "", ".T.", "", ".T.", 35, .T.})
    aAdd(aPergs, {1, "Data Inventário", dData,  "",  ".T.",  "",  ".T.", 60,  .T.})

    If ParamBox(aPergs, "Informe os parâmetros para consulta")
        cQuery := " SELECT B7_FILIAL,NNR_DESCRI,B7_DOC,B7_DATA,REPLACE(SUM(B7_QUANT),'.',',') QTD_TOTAL, "
        cQuery += " 'R$ '+REPLACE(ROUND(SUM(B7.B7_QUANT*B1.B1_CUSTD),2),'.',',') VLR_TOTAL FROM "+RetSQLName("SB7")+" B7 "
        cQuery += " INNER JOIN "+RetSQLName("NNR")+" NR ON B7_LOCAL=NNR_CODIGO AND B7_FILIAL=NNR_FILIAL AND NR.D_E_L_E_T_='' "
        cQuery += " LEFT JOIN "+RetSQLName("SB1")+" B1 ON B7_COD=B1_COD AND B1.D_E_L_E_T_='' "
        cQuery += " WHERE B7.D_E_L_E_T_='' AND NNR_CODIGO='"+ MV_PAR01 +"'+'01' AND B7_DATA='"+ DtoS(MV_PAR02) +"' " 
        cQuery += " GROUP BY B7_FILIAL,NNR_DESCRI,B7_DOC,B7_DATA "

        cQuery := ChangeQuery(cQuery)
        DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),'TMP',.F.,.T.)
        
        dbSelectArea("TMP")
        TMP->(dbGoTop())

        If Alltrim(TMP->NNR_DESCRI) <> ''
            MsgInfo('O inventário foi sincronizado no sistema!<br>'+'   '+'<br>Quantidade: <b>'+Alltrim(cValToChar(TMP->QTD_TOTAL))+ '</b><br>Valor: <b>'+Alltrim(cValToChar(TMP->VLR_TOTAL));
            +'</b><br>Documento: <b>'+Alltrim(TMP->B7_DOC)+'</b><br>Data: <b>'+DToC(StoD(TMP->B7_DATA)),'Loja: '+Alltrim(TMP->NNR_DESCRI))
        Else
            MsgAlert('Inventário não encontrado nos parâmetros informados!')
        EndIf
    EndIf

Return

