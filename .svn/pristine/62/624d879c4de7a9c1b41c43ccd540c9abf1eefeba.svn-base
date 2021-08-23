#INCLUDE 'TOTVS.CH'
#INCLUDE "APWEBSRV.CH"
#INCLUDE "PROTHEUS.CH"
#include "TbiConn.ch"
#include "TbiCode.ch"
#include "TOPCONN.ch"
 
//---------------------------------------------------------------------------
WSSERVICE DAMMPHP DESCRIPTION "WebService INTEGRACAO PHP" // NAMESPACE "http://192.168.0.4:8090/ws"
   
WSDATA CCPF  as STRING
WSDATA cRetCpf  as STRING 
//-----------------------------------------
WSMETHOD VALIDACPF DESCRIPTION "Valida Cpf do cliente"
ENDWSSERVICE
WSMETHOD VALIDACPF WSRECEIVE CCPF WSSEND cRetCpf WSSERVICE DAMMPHP
Local cCfpVl:= alltrim(::CCPF)
Local lRet :=.t.
Local cRet :=""
Local cDupl :=.f.
conout("pesquisando "+cCfpVl)    
dbSelectArea("SA1")
dbSetOrder(3)
if dbSeek(xfilial("SA1")+cCfpVl)
    cDupl:=.t.
    cRet :="JA EXISTE CLIENTE COM ESSE CPF/CNPJ "+alltrim(SA1->A1_NOME)
    ::cRetCpf:=cRet
    Return(.T.)
endif    
if !cDupl
    lRet:=CGC(cCfpVl)
    if lRet
        cRet:="OK"
    else
        if len(cCfpVl) = 14
            cRet:="CNPJ INVALIDO"
        else
            cRet:="CPF INVALIDO"
        endif
    endif
endif
::cRetCpf:=cRet
Return(.T.)

