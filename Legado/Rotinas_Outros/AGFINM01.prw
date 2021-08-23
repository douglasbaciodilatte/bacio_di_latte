#include 'protheus.ch'
#include 'parmtype.ch'
#include 'fileio.ch'

#DEFINE ENTER chr(13)+chr(10)

/*/{Protheus.doc} AGFINM01
//TODO Descrição auto-gerada.
@author Luis Gustavo
@since 17/01/2018
@version 1.0
@return ${return}, ${return_description}

@type function
/*/
User Function AGFINM01()

Local aTitbx   	:= {}
Local lEnd	   	:= .F.
Local lReturn 	:= .f.

processa(  {||   lReturn := U_CONVXLS(@aTitBx)   }	, 'Lendo planilha ...')

if lReturn 

	processa(  {||   BaixaSE1(aTitbx) } 		,'Baixando Titulos ...')
	
Endif	
	
return

/*/{Protheus.doc} BaixaSE1
//TODO Descrição auto-gerada.
@author henri
@since 19/01/2018
@version 1.0
@return ${return}, ${return_description}
@param aTitbx, array, descricao
@type function
/*/
Static Function BaixaSE1(aTitbx)
	Local aFinA070 	:= {}
	Local _aLog		:= {}
	Local nJuros	:= 0
	Local _aReport	:= {}
	Local cErro		:= ''
	Private lAutoErrNoFile	:= .T.	
	
	Private _nProcessa 	:= Len(aTitbx)
	Private _nProcSuce	:= 0
	Private _nProcFalh	:= 0
	
	
	procregua( _nProcessa  )
	
	
	FOR _nx := 1 to Len(aTitbx)

		IncProc("Baixando ... [" + AllTrim(Str(_nx))+ "/"+ AllTrim(Str(Len(aTitbx)))+"]")
	
	
		nJuros := 0
		If aTitbx[_nx][20] > aTitbx[_nx][16]
			nJuros := aTitbx[_nx][20] - aTitbx[_nx][16] 
		Endif  
	
		aFinA070 :={{"E1_NUM"	,padr(aTitbx[_nx][2],TamSx3('E1_NUM')[1])					,Nil},;
		{"E1_PREFIXO" 			,padr(aTitbx[_nx][1],TamSx3('E1_PREFIXO')[1])			   	,Nil},;
		{"E1_FILIAL"  			,xFilial('SE1')												,Nil},;
		{"E1_TIPO" 				,padr(aTitbx[_nx][4],TamSx3('E1_TIPO')[1])			   		,Nil},;
		{"E1_NATUREZ"			,padr(aTitbx[_nx][5],TamSx3('E1_NATUREZ')[1])				,Nil},;
		{"E1_PARCELA"			,padr(aTitbx[_nx][3],TamSx3('E1_PARCELA')[1])		       	,Nil},;
		{"E1_LOJA"				,padr(aTitbx[_nx][9],TamSx3('E1_LOJA')[1])					,Nil},;
		{"E1_CLIENTE" 			,padr(aTitbx[_nx][8],TamSx3('E1_CLIENTE')[1])				,Nil},;
		{"E1_NOMCLI"			,aTitbx[_nx][10]						,Nil},;
		{"AUTMOTBX"	    		,"NOR"         							,Nil},;
		{"AUTDTBAIXA"			,aTitbx[_nx][22]		      			,Nil},;
		{"E1_DTDIGIT"			,dDatabase		   						,Nil},;
		{"AUTDTCREDITO"			,aTitbx[_nx][22]	       				,Nil},;
		{"AUTDESCONT"			,aTitbx[_nx][21]						,Nil},;
		{"AUTDECRESC"			,0										,Nil},;
		{"AUTACRESC" 			,0   									,Nil},;
		{"AUTMULTA"	   			,0										,Nil},;
		{"AUTJUROS"	 			,nJuros	       							,Nil},;
		{"E1_ORIGEM" 			,'IMP001'     	  		   				,Nil},;
		{"E1_FLUXO"				,"S"          							,Nil},;
		{"AUTBANCO"				,padr(aTitbx[_nx][23],TamSx3('E5_BANCO')[1] )   				,Nil},;
		{"AUTAGENCIA"			,padr(aTitbx[_nx][24],TamSx3('E5_AGENCIA')[1] ) 				,Nil},;
		{"AUTCONTA"				,padr(aTitbx[_nx][25],TamSx3('E5_CONTA')[1] )  				,Nil},;
		{"AUTVALREC"			,aTitbx[_nx][20]   												,Nil}}
		
		
		_dDataBase := dDataBase
		dDataBAse := aTitbx[_nx][22]

		lMsErroAuto := .F.
		MSExecAuto({|x,y| Fina070(x,y)},aFinA070,3) //Inclusao da baixa

		dDataBase := _dDataBase

		cErro := ''
		If lMsErroAuto
		_nProcFalh++
			_aLog := GetAutoGRLog()
			
			If ! empty(_aLog)
				For _ny := 1 to len(_aLog)
					conout(_aLog[_ny])
	
					cErro += _aLog[_ny] + CHR(13) + CHR(10)
				Next
			Else
				cErro := MostraErro()+ CHR(13)+ CHR(10)
				conout(Mostraerro())
			Endif

			cErro := strtran(cErro,'-','')

			aadd(_aReport, {aTitbx[_nx,1],aTitbx[_nx,2],aTitbx[_nx,3],aTitbx[_nx,4],aTitbx[_nx,8],aTitbx[_nx,9],aTitbx[_nx,10],aTitbx[_nx,20],cErro})

		Else
			_nProcSuce++
		EndIf
	Next _nx
	
	MsgAlert('Total processado: ' 		+ cValToChar(_nProcessa) + '.' 	+ chr(13) + chr(10) + ;
	'Total processado com sucesso: '	+ cValToChar(_nProcSuce) + '.' 	+ chr(13) + chr(10) + ;
	'Total processado com falha: '		+ cValToChar(_nProcFalh) + '.', 'Processamento finalizado')
	
	
	if len(_aReport) > 0
		u_AGFINR01(_aReport)
	Endif
	
	
Return
