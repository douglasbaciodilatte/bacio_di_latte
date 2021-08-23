User Function FINA910F()

Local aRetorno 
Local aAreaSA6 := SA6->(Getarea())
Local aArea    := Getarea()    


	dbSelectArea("SA6")
	SA6->( dbOrderNickName("CCSITEF")) 
	If DbSeek(xFilial("SA6")+PARAMIXB[3])	
 
		aRetorno := {SA6->A6_COD,SA6->A6_AGENCIA,SA6->A6_NUMCON}				

    EndIf                        
    
    RestArea(aArea)
    RestArea(aAreaSA6)

Return aRetorno