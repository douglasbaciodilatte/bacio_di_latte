#INCLUDE "Protheus.ch"
#include "tbiconn.ch"

/*/
{Protheus.doc} JOBXFIN01
Description

	Job Baixas Títulos a Receber

@param xParam Parameter Description
@return Nil
@author  - Douglas R. Silva
@since 08/10/2019
/*/
	
User Function JOBXFIN1()

	Local _nSomaLin		:= 0
	Local _nProcSuce	:= 0
	Local _nProcFalh	:= 0
	Local dDataBAse		
	Local cErro
	
	Local _aEmp			:= { "01","0001" }

	If ! empty(_aEmp)
		RpcSetType(3)
		RpcSetEnv(_aEmp[1],_aEmp[2],,,,,{"SE1","SE2","FK5"})
	    //PREPARE ENVIRONMENT EMPRESA _aEmp[1] FILIAL _aEmp[2] MODULO "FIN" 
	    Conout("Inicio do Processamento Data " + DTOC( DATE() ) + " Hora " + Time())
	endif
	
	PtInternal( 1, "BAIXAS CONTAS RECEBER DATA " + DTOC( DATE() ) + " HORA " + TIME()  )
	
	ZCZ->(dbSelectArea("ZCZ"))
	ZCZ->(DbSetFilter( {|| ZCZ_FMR == "2" .AND. ZCZ_PROC == "N"  }, 'ZCZ_FMR == "2" .AND. ZCZ_PROC == "N" '))
									
	Do While ZCZ->(!EOF())
		
		//Verifica se contém Juros
		nJuros := 0
		If ZCZ->ZCZ_VLRBAI > ZCZ->ZCZ_SALDO 
			nJuros := ZCZ->ZCZ_VLRBAI - ZCZ->ZCZ_SALDO 
		Endif  
	    
		//Array do titulo a receber, para a baixa do titulo
					
		aFinA070 :={{"E1_NUM"				,ZCZ->ZCZ_NUM		,Nil},;
					{"E1_PREFIXO" 			,ZCZ->ZCZ_PREFIX   	,Nil},;
					{"E1_FILIAL"  			,xFilial('SE1')		,Nil},;
					{"E1_TIPO" 				,ZCZ->ZCZ_TIPO		,Nil},;
					{"E1_NATUREZ"			,ZCZ->ZCZ_NATURE	,Nil},;
					{"E1_PARCELA"			,ZCZ->ZCZ_PARCEL	,Nil},;
					{"E1_LOJA"				,ZCZ->ZCZ_LOJA		,Nil},;
					{"E1_CLIENTE" 			,ZCZ->ZCZ_CLIENT	,Nil},;
					{"E1_NOMCLI"			,ZCZ->ZCZ_NOMCLI	,Nil},;
					{"AUTMOTBX"	    		,"NOR"         		,Nil},; 
					{"E1_DTDIGIT"			,dDatabase		   	,Nil},;
					{"AUTDTCREDITO"			,ZCZ->ZCZ_DTPG		,Nil},;
					{"AUTDESCONT"			,ZCZ->ZCZ_DESCON	,Nil},;
					{"AUTDECRESC"			,0					,Nil},;
					{"AUTACRESC" 			,0   				,Nil},;
					{"AUTMULTA"	   			,0					,Nil},;
					{"AUTJUROS"	 			,nJuros	       		,Nil},;
					{"E1_ORIGEM" 			,'BLFINCR'     	  	,Nil},;
					{"E1_FLUXO"				,"S"          		,Nil},;
					{"AUTBANCO"				,ZCZ->ZCZ_BANCO		,Nil},;
					{"AUTAGENCIA"			,ZCZ->ZCZ_AGENCI	,Nil},;
					{"AUTCONTA"				,ZCZ->ZCZ_CONTA		,Nil},;
					{"AUTVALREC"			,ZCZ->ZCZ_VLRBAI	,Nil}}							
			        
		//verifica se ha erro no execauto
		lMsErroAuto := .F.
		
		//Altera data base
		_dDataBase 	:= dDataBase
		dDataBAse 	:= ZCZ->ZCZ_DTPG
	
		// Extrai os Dados das Celulas Cabeï¿½alho pedido
		If ZCZ->ZCZ_PROC == "N" //Verifica se ainda está Não
			
			SE5->(dbSelectArea("SE5"))
			SE5->(dbSetOrder(7)) //E5_FILIAL, E5_PREFIXO, E5_NUMERO, E5_PARCELA, E5_TIPO, E5_CLIFOR, E5_LOJA, E5_SEQ
			If SE5->(dbSeek( xFilial("SE5") + ZCZ->ZCZ_PREFIX + ZCZ->ZCZ_NUM + ZCZ->ZCZ_PARCEL + ZCZ->ZCZ_TIPO + ZCZ->ZCZ_CLIENT + ZCZ->ZCZ_LOJA ))
				lMsErroAuto := .F.
			Else
				MSExecAuto({|x,y| Fina070(x,y)},aFinA070,3) //Inclusao da baixa
			EndIf
									
			dDataBase := _dDataBase
	
			cErro := ''
			
			If lMsErroAuto
								 
				//Verifica se baixa já ocorreu em outro processameento							 
				Reclock("ZCZ",.F.)
					//ZCZ->ZCZ_PROC	:= "S"
					ZCZ->ZCZ_LOG	:= "LOG PROCESSO ERRO DATA " + DTOC( Date() ) + " HORA " + TIME() + " USUARIO " +  Alltrim(UPPER(UsrRetName(__CUSERID)))
					ZCZ->ZCZ_DATAP	:= Date()
					ZCZ->ZCZ_HORAP	:= TIME()  
				ZCZ->(MsUnlock())
			
				_nProcFalh++
														
			Else
			
				//Atualiza status e Log de Processamento:
				Reclock("ZCZ",.F.)
					//ZCZ->ZCZ_PROC	:= "S"
					ZCZ->ZCZ_LOG	:= "LOG PROCESSO SUCESSO DATA " + DTOC( Date() ) + " HORA " + TIME() + " USUARIO " + Alltrim(UPPER(UsrRetName(__CUSERID)))
					ZCZ->ZCZ_DATAP	:= Date()
					ZCZ->ZCZ_HORAP	:= TIME()  
				ZCZ->(MsUnlock())
									
			    _nProcSuce++
			    
			EndIf
	     
	     EndIf
	        
		_nSomaLin++
					
		ZCZ->(dbSkip())
	Enddo

	//Finaliza Filtro
	ZCZ->(DBClearFilter())

Return( .T. )