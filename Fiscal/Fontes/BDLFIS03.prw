#include "tbiconn.ch"
#include "protheus.ch"

/*����������������������������������������������������������������������������������������������
�� �Programa � BDLFIS03         �Autor� RVACARI Felipe Mayer	    � Data Ini� 12/03/2020   ���
������������������������������������������������������������������������������������������������
�� �Desc.    � Validar parametro MV_ESTADO com SM0 e gravar/corrigir                          ��
������������������������������������������������������������������������������������������������
�� �Uso      � BACIO DI LATTE	                                            		  		  ��
����������������������������������������������������������������������������������������������*/

User Function BDLFIS03()

Local aSM0   := {} 
Local nX     := 0
Local cFil   := ''
Local cEst   := ''
Local cChave := ''
Local cVar   := 'MV_ESTADO'


    OpenSM0()
    SM0->(DBGOTOP())

    While !SM0->(EOF())
        SM0->(aAdd(aSM0, {M0_CODFIL,M0_ESTENT}))
        SM0->(DbSkip())
    Enddo

    For nX := 1 To Len(aSM0)

    	DbSelectArea("SX6")
		DbSetOrder(1)

        cFil := Alltrim(aSM0[nX,01])
        cEst := Alltrim(aSM0[nX,02])
        
        cChave := AvKey(cFil,"X6_FIL")+Avkey(cVar,"X6_VAR")

        If cFil <> 'SP'
            If !DbSeek(cChave)
                RecLock("SX6", .T.)	
                SX6->X6_FIL     := cFil
                SX6->X6_VAR     := cVar
                SX6->X6_TIPO    := 'C'
                SX6->X6_DESCRIC := 'Sigla do estado da empresa usuaria do sistema para'
                SX6->X6_DESC1   := 'efetio de calculo de ICMS'
                SX6->X6_CONTEUD := cEst
                SX6->X6_CONTSPA := cEst
                SX6->X6_CONTENG := cEst
                SX6->X6_PROPRI  := 'U'
                MsUnLock()
            ElseIf DbSeek(cChave)	
                RecLock("SX6", .F.)		
                SX6->X6_CONTEUD := cEst
                SX6->X6_CONTSPA := cEst
                SX6->X6_CONTENG := cEst
                MsUnLock()    
            EndIf
        EndIf

    Next nX

Return 