#include 'protheus.ch'
#include 'parmtype.ch'

user function tstcons()

local aProd := {}

Private LMSERROAUTO := .F.

aAdd(aProd, {"D3_FILIAL", XFILIAL("SD3") , NIL})
	aAdd(aProd, {"D3_TM", '505', NIL})
	aAdd(aProd, {"D3_COD", 'PA001003000040', NIL})     
	aAdd(aProd, {"D3_QUANT", 1, NIL})
	aAdd(aProd, {"D3_DOC", '999999999', NIL})
	aAdd(aProd, {"D3_LOCAL", '007201', NIL})
	aAdd(aProd, {"D3_EMISSAO", stod('20200115'), NIL})
	aAdd(aProd, {"D3_CC", '007201', NIL})
		                       
	msExecAuto({|x, y| Mata240(x, y)}, aProd, 3)

	if lmsErroAuto		            
		MOSTRAERRO()
	endif                                                 
	
return