
User Function A650LOCA()

Local cRetLocal 

	//Verifca se o produto diferente de 'MO'(m�o de Obrra) e n�o faz parte do grupo 0198
 	If  SC2->C2_FILIAL == "0031"
		cRetLocal := '700002'
	ElseIf SC2->C2_FILIAL == "0072"	
		cRetLocal := '700023'	
 	EndIf
 
Return cRetLocal 
