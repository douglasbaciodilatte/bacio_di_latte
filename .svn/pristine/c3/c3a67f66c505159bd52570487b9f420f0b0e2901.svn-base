#include "Protheus.ch"    
#INCLUDE "Topconn.ch"

//+---------------------------------------------------------------------+
//| Efetua ajuste RECCAB do Cupom Importado                             |
//+---------------------------------------------------------------------+

User Function BDFATA01()
	
	Local cQueryR

	cQueryR := "	SELECT PIN_FILIAL, PIN_XCODEX, R_E_C_N_O_ " + CRLF 
	cQueryR += "	FROM PIN020 WITH (NOLOCK) WHERE SUBSTRING(PIN_EMISNF,1,6) = '202002' AND D_E_L_E_T_ != '*' " + CRLF
	
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQueryR ),"TRF",.F.,.T.)	

	TRF->(dbGoTop())

	Do While TRF->(!EOF())
	
		PIN->(dbSelectArea("PIN"))
		PIN->(dbSetOrder(2)) //PIN_FILIAL+PIN_XCODEX+PIN_STAIMP
		
		//Ajusta Cabe?lho de Cupom
		If PIN->( dbSeek( TRF->PIN_FILIAL + TRF->PIN_XCODEX ))
			
			Reclock("PIN",.F.)
			
				PIN->PIN_RECCAB := TRF->R_E_C_N_O_
			
			PIN->(MsUnlock())
				
			//Atualiza os dados do Cupom, Produto
			PIO->(dbSelectArea("PIO"))
			PIO->(dbSetOrder(3)) //PIO_FILIAL+PIO_XTPREG+PIO_XCODEX+PIO_PDV+PIO_STAIMP+PIO_CODORI+PIO_CODDES+PIO_ACAO
			
			If PIO->(dbSeek ( PIN->PIN_FILIAL + "5" + PIN->PIN_XCODEX ))
			
				Do While PIO->(!EOF() .And. PIN->PIN_XCODEX == PIO->PIO_XCODEX )
					
					Reclock("PIO",.F.)
						
						PIO->PIO_RECCAB	:=  TRF->R_E_C_N_O_
					
					PIO->(MsUnlock())
					
					PIO->(dbSkip())
				Enddo
			EndIf
			
			//Atualiza informao de pagamento
			PIP->(dbSelectArea("PIP"))
			PIP->(dbSetOrder(3)) //PIP_FILIAL+PIP_XTPREG+PIP_XCODEX+PIP_PDV+PIP_STAIMP+PIP_CODORI+PIP_CODDES+PIP_ACAO
			
			If PIP->(dbSeek( PIN->PIN_FILIAL + "5" +  PIN->PIN_XCODEX ))
			
				Reclock("PIP",.F.)
					PIP->PIP_RECCAB	:=  TRF->R_E_C_N_O_
				PIP->(MsUnlock())
				
			EndIf
			
		EndIf
	
		TRF->(dbSkip())
	Enddo
		
	dbCloseArea("TRF")

Return