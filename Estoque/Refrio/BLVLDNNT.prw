User Function BLVLDNNT()

Local oModel := FwModelActive()
Local nOperation:= oModel:GetOperation()
Local xStatus
Local lRetorno:=.T.

If cFilant $ "0072,0031"
	
	If nOperation == 3 //Inclus�o
		
		//Reclock("NNS",.F.)
		M->NNS_STAREF:='1'
		xStatus:=M->NNS_STAREF
		//Msunlock()
		
	Elseif nOperation == 4 //Altera�ao
		/*
		If Empty(NNS_STAREF)
		Reclock("NNS",.F.)
		NNS->NNS_STAREF:='U'
		xStatus:=NNS->NNS_STAREF
		Msunlock()
		
		U_XMLREFR(xStatus)
		
		Else
		*/
		//MsgAlert("Essa solicita��o de Transfer�ncia j� foi enviada para separa��o e n�o ser� poss�vel sua altera��o","Aten��o")
		
		lRetorno:=.F.
		
		Return lRetorno
		
		//Endif
	ElseIf nOperation == 5  //Exclus�o
		/*
		Reclock("NNS",.F.)
		NNS->NNS_STAREF:='D'
		xStatus:=NNS->NNS_STAREF
		Msunlock()
		
		U_XMLREFR(xStatus)
		*/
		
		//MsgAlert("Essa solicita��o de Transfer�ncia j� foi enviada para separa��o e n�o ser� poss�vel sua exclusao","Aten��o")
		
		lRetorno:=.F.
		
		Return lRetorno
		
	Endif

Endif

Return lRetorno
