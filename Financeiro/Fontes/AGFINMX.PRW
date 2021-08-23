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
User Function AGFINMX()

Local aTitbx   	:= {}
Local lEnd	   	:= .F.
Local lReturn 	:= .f.

processa(  {||   lReturn := U_ConverteXLSCP(@aTitBx)   }	, 'Lendo planilha ...')

if lReturn 

	processa(  {||   BaixaSE2(aTitbx) } 		,'Baixando Titulos ...')
	
Endif	
	
return

/*/{Protheus.doc} BaixaSE2
//TODO Descrição auto-gerada.
@author henri
@since 19/01/2018
@version 1.0
@return ${return}, ${return_description}
@param aTitbx, array, descricao
@type function
/*/
Static Function BaixaSE2(aTitbx)
	Local aFinA080 	:= {}
	Local _aLog		:= {}
	Local nJuros	:= 0
	Local _aReport	:= {}
	Local cErro		:= ''
	Private lAutoErrNoFile	:= .T.	
	
	procregua( len(aTitbx)  )
	
 	DbSelectArea("SE2")
  	DbSetOrder(1)//E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA 
	
	FOR _nx := 1 to Len(aTitbx)
	
		DbSeek(xFilial("SE2")+;
		   	   PadR(aTitbx[_nx][4],TamSx3('E2_PREFIXO')[1])+; 
		   	   PadR(aTitbx[_nx][5],TamSx3('E2_NUM')[1])+;	
		   	   PadR(aTitbx[_nx][6],TamSx3('E2_PARCELA')[1])+;  
		   	   PadR(aTitbx[_nx][3],TamSx3('E2_TIPO')[1])+;
		   	   PadR(aTitbx[_nx][8],TamSx3('E2_FORNECE')[1])+;
		   	   PadR(aTitbx[_nx][9],TamSx3('E2_LOJA')[1]))

		IncProc("Baixando ... [" + AllTrim(Str(_nx))+ "/"+ AllTrim(Str(Len(aTitbx)))+"]")
	
	
		nJuros := 0
		If aTitbx[_nx][26] > aTitbx[_nx][15] .And. SE2->E2_ACRESC = 0
			nJuros := aTitbx[_nx][26] - aTitbx[_nx][15] 
		Endif  
	
		aFinA080 :={{'E2_FILIAL',xFilial("SE2")									,Nil},;
		{"E2_PREFIXO" 			,padr(aTitbx[_nx][4],TamSx3('E2_PREFIXO')[1])	,Nil},;
		{"E2_NUM"  				,padr(aTitbx[_nx][5],TamSx3('E2_NUM')[1])		,Nil},;
		{"E2_TIPO" 				,padr(aTitbx[_nx][3],TamSx3('E2_TIPO')[1])		,Nil},;
		{"E2_NATUREZ"			,padr(aTitbx[_nx][10],TamSx3('E2_NATUREZ')[1])	,Nil},;
		{"E2_PARCELA"			,padr(aTitbx[_nx][6],TamSx3('E2_PARCELA')[1])	,Nil},;
	 	{"E2_FORNECE" 			,padr(aTitbx[_nx][8],TamSx3('E2_FORNECE')[1])	,Nil},;
		{"E2_LOJA"				,padr(aTitbx[_nx][9],TamSx3('E2_LOJA')[1])		,Nil},;
		{"E2_NOMFOR"			,aTitbx[_nx][07]					   			,Nil},;
		{"AUTMOTBX"	    		,AllTrim(aTitbx[_nx][17])						,Nil},;
		{"AUTDTBAIXA"			,aTitbx[_nx][22]		      					,Nil},;
		{"E2_DTDIGIT"			,dDatabase		   								,Nil},;
		{"AUTDTDEB"				,aTitbx[_nx][23]	       						,Nil},;
		{"AUTDESCONT"			,aTitbx[_nx][25]								,Nil},;
		{"AUTMULTA"	   			,IIF(nJuros <> 0,nJuros,0)						,Nil},;
		{"E2_ORIGEM" 			,'AUTBAIXA'    	  		   						,Nil},;
		{"E2_FLUXO"				,"S"          									,Nil},;
		{"AUTBANCO"				,padr(aTitbx[_nx][18],TamSx3('E5_BANCO')[1] )   ,Nil},;
		{"AUTAGENCIA"			,padr(aTitbx[_nx][19],TamSx3('E5_AGENCIA')[1] ) ,Nil},;
		{"AUTCONTA"				,padr(aTitbx[_nx][20],TamSx3('E5_CONTA')[1] )  	,Nil},;   
		{"AUTHIST"				,padr(aTitbx[_nx][24],TamSx3('E5_HISTOR')[1] )  ,Nil},;	
		{"AUTVLRPG"				,aTitbx[_nx][26]   								,Nil}}
			
		_dDataBase := dDataBase
		dDataBAse := aTitbx[_nx][23]

		lMsErroAuto := .F.
		MSExecAuto({|x, y| FINA080(x, y)},aFinA080,3) //Conteúdos do nOpc: 3 - Baixa de Título, 5 - Cancelamento de baixa, 6 - Exclusão de Baixa.

		dDataBase := _dDataBase

		cErro := ''
		If lMsErroAuto
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

			aadd(_aReport, {aTitbx[_nx,4],aTitbx[_nx,5],aTitbx[_nx,6],aTitbx[_nx,3],aTitbx[_nx,8],aTitbx[_nx,9],aTitbx[_nx,7],aTitbx[_nx,14],cErro})

		Else
	
		EndIf
	Next _nx
	
	if len(_aReport) > 0
		U_AGFNRCPX(_aReport)
	Else	
		MsgAlert('Todas as baixas foram relizadas com sucesso.')
	Endif
	
Return


