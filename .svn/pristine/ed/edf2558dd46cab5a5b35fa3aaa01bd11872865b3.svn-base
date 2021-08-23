#Include "Protheus.ch"
#INCLUDE "TBICONN.CH" 
#include "rwmake.ch"

/*/{Protheus.doc} User Function BDETIQ01
    (long_description)
    @type  Function
    @author user
    @since 01/06/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function BDETIQ01()
    
    SetPrvt("CPERG,CCOMBO,AITENS,VIQetiq,cCidade,nCount,VNFISCAL,VNR")
	SetPrvt("cPed,VCLIENTE,cCliEnt,cSerie,nLin,nCol,lPrim,cEndEnt,VQtdEmb")
	SetPrvt("VCONF,cNome,cEntrega,cNomeTra, VDTAVAL,VSAIR,_CPORTA,_SALIAS,AREGS,dDataTrf")
	SetPrvt("I,J,qQetiq")
 
	cCombo   := "S4M"
	aItens   := {"ELTRON","S4M","ZEBRA","ZDesigner"}
	VNFISCAL := Space(9)
	VProduto :=""
	cPed   := Space(6)
	VCliente :=Space(30)
	cEndEnt := Space(30)
	VQtdEmb := ""
	cNomeTra    := Space(30)
	VSair    := .f.
	VIQetiq   := 1
	VFQetiq   := 1
	Vcont := 0
 
	While vSair == .f.
	   @ 003,001 TO 355,450 DIALOG oDlg1   TITLE "Impress�o de Etiquetas -Expedi��o"
	   @ 135,045 BUTTON "_Imprimir"        SIZE 30,20 ACTION Impetiq()
	   @ 135,128 BUTTON "_Sair"            SIZE 30,20 ACTION sair()
	   
	   @ 014,015 Say "Volume Inicio:"
	   @ 014,085 Get VIQetiq                    	SIZE 30,20 Pict "999"
	   
	   @ 030,015 Say "Volume Fim:"
	   @ 030,085 Get VFQetiq                    	SIZE 30,20 Pict "999"
	   
	   @ 042,015 Say "Nota Fiscal:"
	   @ 042,065 Get VNFISCAL                  	SIZE 50,20 Picture "@!" F3 "SF2" VALID FillDSF2(VNFISCAL)
	   @ 058,015 Say "Transferecia:"
	   @ 058,065 Get cPed                  		SIZE 50,20
	   @ 074,015 Say "Transportadora:"
	   @ 074,065 Get cNomeTra                    SIZE 100,20
	   @ 090,015 Say "Cliente:"
	   @ 090,065 Get cNome                   SIZE 100,20
	   @ 106,015 Say "Endereco:"
	   @ 106,065 Get cEntrega                    SIZE 100,20
	   @ 122,090 ComboBox cCombo Items aItens   SIZE 30,70 
 
	   ACTIVATE DIALOG oDlg1 CENTERED
	EndDo

Return

Static Function Impetiq()
 
	MSCBPRINTER("ZEBRA","LPT1",,,.F.,,,,,,.T.)
	for nCount := VIQetiq to VFQetiq
		MSCBBEGIN(1,3)
		
		MSCBSAY(01,07,"BACIO DI LATTE","N", "0", "025,027")

		MSCBSAY(01,14,"NOTA "+ cSerie + VNFISCAL,"N", "0", "052,055")
		MSCBSAY(01,21,"TRANSF "+cPed,"N", "0", "052,055")
		
		MSCBSAY(01,30,"ENTREGA "+Alltrim(cNome),"N", "0", "025,027")
		
		//MSCBSAY(01,33,"ENDERECO ","N", "0", "025,027")
		MSCBSAY(01,36,SUBSTR(cEntrega,1,40),"N", "0", "025,027")
		MSCBSAY(01,39,SUBSTR(cEntrega,41,40),"N", "0", "025,027")		
		MSCBSAY(01,42,SUBSTR(cEntrega,82,40),"N", "0", "025,027")				
		MSCBSAY(01,45,SUBSTR(cEntrega,123,40),"N", "0", "025,027")				
		
		MSCBSAY(01,48,"SOLICITADO " + DTOC(dDataTrf) ,"N", "0", "025,027")		
		MSCBSAY(01,51,"EMBARQUE " + DTOC( DATE() ) + " " + SUBSTR( TIME(),1,5) ,"N", "0", "025,027")		
		
		MSCBSAY(01,54,cNomeTra ,"N", "0", "025,027")		
		
		MSCBSAY(01,58,"VOLUMES "+Alltrim(STR(nCount))+" DE " +Alltrim(STR(VFQetiq)),"N", "0", "052,055")
		
		MSCBEND()
	Next(nCount)
	MSCBCLOSEPRINTER()

Return          
 
Static Function Sair()

	Close(oDlg1)
	vSair := .t.
 
Return
 
Static Function FillDSF2(_cDoc)

	Local cPed1
	SF2->(dbsetorder(1))
	SF2->(dbseek(xfilial("SF2") + _cDoc ))
	
	cCliente      	:= SF2->F2_CLIENTE
	cSerie 			:= SF2->F2_SERIE
	
	cPed1 			:= posicione("SC9",6,xfilial("SC9")+cSerie+_cDoc,"C9_PEDIDO")
	cPed 			:= posicione("SC5",1,xfilial("SC5")+cPed1,"C5_XSOLTRA")
	
	cNome       	:= posicione("SA1",1,xfilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA,"A1_NREDUZ")
	dDataTrf		:= posicione("NNS",1,xfilial("SF2")+cPed,"NNS_DATA") 
	
	cEntrega      	:= UPPER(SF2->F2_XMENS)
	cNomeTra      	:= posicione("SA4",1,xfilial("SA4")+SF2->F2_TRANSP,"A4_NOME")
	cCidade       	:= posicione("SA1",1,xfilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA,"A1_MUN")

	//Verifica se endere�o est� em branco e efetua ajuste etiqueta

	If Empty( Alltrim(cEntrega) ) .Or. SUBSTR(Alltrim(cEntrega),1,3) == "DOC" .Or. SUBSTR(Alltrim(cEntrega),1,1) == "."

		SA1->(dbSelectArea("SA1"))
		SA1->(dbSetOrder(1))
		If SA1->(dbSeek( xfilial("SA1")+SF2->F2_CLIENTE+SF2->F2_LOJA ))
			cEntrega := Alltrim( SA1->A1_END ) 
			cEntrega += " " + Alltrim( SA1->A1_BAIRRO ) 
			cEntrega += " " + Alltrim( SA1->A1_MUN ) 
			cEntrega += " " + Alltrim( SA1->A1_EST ) 
			cEntrega += " " + Alltrim( SA1->A1_CEP ) 
		EndIf
	EndIf

return()
