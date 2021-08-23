#include "protheus.ch"    
#INCLUDE "Topconn.ch"

//|=====================================================================|
//|Programa: BLFINR05.PRW |Autor: Douglas Silva    | Data: 27/01/2020  |
//|=====================================================================|
//|Descricao: O ponto de entrada FA050INC - será executado na validação |
//|            da Tudo Ok na inclusão do contas a pagar                 |
//|=====================================================================|
//|Sintaxe:                                                             |
//|=====================================================================|
//|Uso: Ponto de entrada da rotina FINA050                              |
//|=====================================================================|
//|       ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.             |
//|---------------------------------------------------------------------|
//|Programador |Data:      |BOPS  |Motivo da Alteracao                  |
//|---------------------------------------------------------------------|
//| ====================================================================|                                                                  

User Function BLFINR05()
	
	Private _lRet := .T.

 	MsAguarde({|lFim| _lRet := (Proces(@lFim))},"Processamento","Aguarde a finalização do processamento...")
 
 Return (_lRet)

Static function Proces(lFim)

	Local _cNumTi 	:= SUBSTR(DTOS(M->E2_VENCTO),5,2)+SUBSTR(DTOS(M->E2_VENCTO),3,2)+SUBSTR(M->E2_CCUSTO,1,4) + " "
    

    //Verifica se título já existe base de dados
    SE2->( DBSETORDER(1)) //E2_FILIAL, E2_PREFIXO, E2_NUM, E2_PARCELA, E2_TIPO, E2_FORNECE, E2_LOJA
    If SE2->(DBSEEK( M->E2_FILIAL + M->E2_PREFIXO + _cNumTi + M->E2_PARCELA + M->E2_TIPO + M->E2_FORNECE + M->E2_LOJA ))
    
        Alert("ATENÇÃO: Título já existe base de dados, altere a parcela (" + M->E2_PARCELA +") para próximo número subsequente")
        _lRet := .F.
        
        If MsgYesNo("Deseja alterar o numero da parcela?")
        	
        		//Query para sugerir a parcela correta
        	cQuery := " 	SELECT MAX(E2_PARCELA) E2_PARCELA FROM "+RETSQLNAME("SE2")+" "
        	cQuery += " 	WHERE (E2_FILIAL + E2_PREFIXO + E2_NUM + E2_TIPO + E2_FORNECE + E2_LOJA) = '"+(M->E2_FILIAL + M->E2_PREFIXO + _cNumTi + M->E2_TIPO + M->E2_FORNECE + M->E2_LOJA)+"'	AND D_E_L_E_T_ != '*' "
        	cQuery := ChangeQuery(cQuery)
	
        	TcQuery cQuery New Alias "TMP"
        	        	
        	M->E2_PARCELA := STRZERO ( VAL(TMP->E2_PARCELA) + 1 ,2)
        	
        	_lRet := .T.
    
        	TMP->(DbClosearea())
        	
        EndIf
        
    EndIf

Return(_lRet)