#INCLUDE "PROTHEUS.CH"


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ºPrograma ³   BACDM030     ºAutor³ Elaine Mazaro 	      º Data Ini³ 15/02/17		 º±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ºDesc.    ³ 	Gatilha a TES de saida	 nas solicitaï¿½ï¿½o de transferencia		  ±±
±±				Tabela NNT rotina mata311  											  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ºUso      ³ 	BACIO di LATTE                                            		  	  ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ºRequisitos ³  Definir na APSDU Fornec '07XPHH' para  cOPER == '53'			      ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/


User Function BACDM030(cFilDes,cProd)

Local cTES 			:= ""   
Local cClieFor 		:= ""
Local cLoja			:= ""
Local cCgcFil 		:= ""                 
local cTpOper 		:= SuperGetMV("ES_TPOPTRA",," ")
Local _aAreaSM0		:= SM0->( GetArea() )	//Salva a Area da tabela SM0 - Empresas
Local _aAreaSA1		:= SA1->( GetArea() )	//Salva a Area da tabela SA1 - Cadastro de Clientes

Default cFilDes 	:= ""
Default cProd 		:= ""

	//Busca CGC da Filial
	SM0->(dbGoTop())
	While !SM0->(Eof())
		If Alltrim(SM0->M0_CODFIL) == cFilDes
			cCgcFil:= SM0->M0_CGC
			Exit
		EndIf
		SM0->(dbskip())
	End        
	
	RestArea(_aAreaSM0)
	
	dbSelectArea("SA1")
	dbSetorder(3) 
	SA1->(dbGoTop())
	
	If SA1->(dbSeek(xFilial("SA1") + cCgcFil))
	
		cClieFor := SA1->A1_COD
		cLoja := SA1->A1_LOJA
	
		dbSelectArea("SFM")
		SFM->(dbSetOrder(2)) 
			
			If xFilial("NNT") == "0031"
				cTpOper := "83"
			EndIf
				   	
			cTES := MaTesInt(2,cTpOper,cClieFor,cLoja,"C",cProd,NIL)	   	
				   	  
		If Empty(cTES)
			cTpOper := "03"
			cTES := MaTesInt(2,cTpOper,cClieFor,cLoja,"C",cProd,NIL)
		EndIf	
		 
	Endif
	
	RestArea(_aAreaSA1)
]
Return cTES

