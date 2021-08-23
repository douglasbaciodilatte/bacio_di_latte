#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BDLIQSE2  ºAutor  ³Microsiga           º Data ³  12/27/17   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/



USER FUNCTION BDLIQSE2()

local _valiq     := 0 
local _valPcc    := 0 
Local _valRetPcc := 0            

Local _forPis   := "1"   
Local _forCof   := "1" 
Local _forCsl   := "1"   

Local _natPis   := 'N' 
Local _natCof   := 'N'
Local _natCsl   := 'N'         

Local _codFor   :=  SE2->E2_FORNECE  
Local _lojFor   :=  SE2->E2_LOJA  




//E2_SALDO - IIF(E2_COFINS + E2_PIS + E2_CSLL > 10 ,E2_COFINS + E2_PIS + E2_CSLL,0 )
//- E2_DECRESC + E2_ACRESC + E2_VRETPIS + E2_VRETCOF + E2_VRETCSL


IF(SE2->E2_SALDO = 0 )

 _valiq = 0  
 RETURN _valiq
 
ENDIF 

_valiq     := SE2->(E2_SALDO - E2_DECRESC + E2_ACRESC)
_valPcc    := SE2->(E2_COFINS + E2_PIS + E2_CSLL)
//_valRetPcc := SE2->(E2_VRETPIS + E2_VRETCOF + E2_VRETCSL)      


dbSelectArea("SA2") 
SA2->(dbSetOrder(1))
If SA2->(DbSeek(XFilial("SA2")+_codFor+_lojFor))   
	
	 _forPis   := SA2->A2_RECPIS
     _forCof   := SA2->A2_RECCOFI 
     _forCsl   := SA2->A2_RECCSLL  
   	
ENDIF         

dbSelectArea("SED") 
SED->(dbSetOrder(1))
If SED->(DbSeek(XFilial("SED") + SE2->E2_NATUREZ))   
	
	 _natPis   := SED->ED_CALCPIS
     _natCof   := SED->ED_CALCCOF 
     _natCsl   := SED->ED_CALCCSL  
   	
ENDIF 


IF(_valPcc > 10 )

	//_valiq := _valiq - _valPcc + _valRetPcc    
	
	IF _forPis = "2" .AND. _natPis = "S"
     	_valiq := _valiq - SE2->E2_PIS + SE2->E2_VRETPIS
	ENDIF  
	
	IF _forCof = "2" .AND. _natCof = "S"
		_valiq := _valiq - SE2->E2_COFINS + SE2->E2_VRETCOF
	ENDIF       
	
	IF _forCsl = "2" .AND. _natCsl = "S"
		_valiq := _valiq - SE2->E2_CSLL + SE2->E2_VRETCSL 
		
	ENDIF
	
	
ENDIF

 //MSGALERT(_valiq) 




//RETURN()
RETURN _valiq