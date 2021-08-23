#Include "Protheus.ch"
#Include "TopConn.ch"
#include "fileio.ch"



/*???????????????????????????????????????????????
? ?rograma ?BLESTR18         ?utor?RVACARI Felipe Mayer	    ?Data Ini?13/07/2020   ??
????????????????????????????????????????????????
? ?esc.    ?Relat?io de linhas deletadas Solicita?o Transferencia                        ?
????????????????????????????????????????????????
? ?so      ?BACIO DI LATTE	                                            		  		  ?
???????????????????????????????????????????????*/

User Function BLESTR18()

Local aPergs     := {}
Private cFilDe   := Space(TamSx3("NNT_FILIAL")[1])
Private cFilAt   := Space(TamSx3("NNT_FILIAL")[1])
Private dDTde    := SToD('')
Private dDTAt    := SToD('')


aAdd(aPergs, {1, "Filial De" ,      cFilDe,  "",  ".T.",   "",  ".T.", 40,  .F.})
aAdd(aPergs, {1, "Filial Ate",      cFilAt,  "",  ".T.",   "",  ".T.", 40,  .F.})
aAdd(aPergs, {1, "DT Exclusao De" ,  dDTde,  "",  ".T.",   "",  ".T.", 80,  .F.})
aAdd(aPergs, {1, "DT Exclusao Ate",  dDTAt,  "",  ".T.",   "",  ".T.", 80,  .F.})

If ParamBox(aPergs, "Informe os parametros")
	MsAguarde({|| GeraExcel()},,"O arquivo Excel esta sendo gerado...")
EndIf

Return Nil

Static Function GeraExcel()

Local cQuery := ''

    cQuery := " SELECT  "
    cQuery += " NNT_FILORI FIL_ORIG, "
    cQuery += " NNT_COD COD_SOLICIT, "
    cQuery += " NNT_PROD PRODUTO, "
    cQuery += " ISNULL(B1_DESC,'') DESCRI, "
    cQuery += " NNT_UM UM, "
    cQuery += " NNT_LOCAL ARMAZEM_ORIG, "
    cQuery += " NNT_QUANT QTD_1UM, "
    cQuery += " NNT_QTSEG QTD_2UM, "
    cQuery += " NNT_FILDES FIL_DEST, "
    cQuery += " NNT_LOCLD ARMAZEM_DEST, "
    cQuery += " CONVERT(VARCHAR(10), CAST(NNT_XDTEXC AS DATE),103) DT_EXCLUSAO, "
    cQuery += " NNT_XMOTIV MOTIVO_EXCLUSAO "
    cQuery += " FROM "+RetSqlName("NNT")+" NNT "
    cQuery += " LEFT JOIN "+RetSqlName("SB1")+" B1 ON B1_COD=NNT_PROD AND B1.D_E_L_E_T_='' "
    cQuery += " WHERE NNT.D_E_L_E_T_='*'  "
    cQuery += " AND NNT_XDTEXC <> '' "
    cQuery += " AND NNT_XDTEXC BETWEEN '"+DToS(MV_PAR03)+"' AND '"+DToS(MV_PAR04)+"' "
    cQuery += " AND NNT_FILIAL BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"' "
    cQuery += " ORDER BY NNT_COD,NNT_XDTEXC "

    U_QRYCSV(cQuery,"LinhasDeletadas")


Return
