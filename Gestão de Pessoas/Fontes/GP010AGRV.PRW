#INCLUDE "Protheus.Ch"

//-------------------------------------------------------------------
/*{Protheus.doc} 			 							GP010AGRV()                              
Acrescenta 21 meses na data inicial de férias conforme solicitação

@author Itamar Gama.:   -  PHI CONSULT 
@since  06/08/2019
@version P12
*/
//-------------------------------------------------------------------
USER FUNCTION GP010AGRV()
If Inclui .And. Empty(SRF->RF_DATAINI)
	If RecLock("SRF",.F.)
		SRF->RF_DATAINI := MonthSum( SRF->RF_DATABAS,  21 ) 
		SRF->RF_DFEPRO1 := 30
		MsUnLock()
	Endif 
Endif
RETURN