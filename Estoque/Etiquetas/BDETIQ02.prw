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
 
	Private VNFISCAL := Space(9)

	cCombo   := "S4M"
	aItens   := {"ELTRON","S4M","ZEBRA","ZDesigner"}	
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
	   @ 003,001 TO 355,450 DIALOG oDlg1   TITLE "Impressao de Etiquetas - Entrada NF-e"
	   
	   @ 135,045 BUTTON "_Imprimir"       	SIZE 30,20 ACTION Impetiq()
	   @ 135,128 BUTTON "_Sair"           	SIZE 30,20 ACTION sair()
	   
	   @ 014,015 Say "Volume Inicio:"
	   @ 014,085 Get VIQetiq             	SIZE 30,20 Pict "999"
	   
	   @ 030,015 Say "Volume Fim:"
	   @ 030,085 Get VFQetiq                SIZE 30,20 Pict "999"
	   
	   @ 042,015 Say "Nota Fiscal:"
	   @ 042,065 Get VNFISCAL               SIZE 50,20 Picture "@!" F3 "SF1" 
 
	   ACTIVATE DIALOG oDlg1 CENTERED
	EndDo

Return

Static Function Impetiq()

	Private aDados := {}

	MSCBPRINTER("ZEBRA","LPT1",,,.F.,,,,,,.T.)

	SD1->(dbsetorder(1))
	SD1->(dbseek(xfilial("SD1") + VNFISCAL ))
	
	Do While SD1->(!eof() .And. xFilial("SD1") == SD1->D1_FILIAL .And. SD1->D1_DOC == VNFISCAL )

		//Busca fornecedor
		SA2->(dbSelectArea("SA2"))
		SA2->(dbSetOrder(1))

		If SA2->(dbSeek(xFilial("SA2") + SD1->D1_FORNECE + SD1->D1_LOJA))

			SB1->(dbSelectArea("SB1"))
			SB1->(dbSetOrder(1))
			SB1->(dbSeek(xFilial("SB1") + SD1->D1_COD))

			For nCount := VIQetiq to VFQetiq

				MSCBBEGIN(1,3)
			
				MSCBSAY(01,10,"     " + ALLTRIM(SD1->D1_COD) ,"N", "0", "052,055")
				MSCBSAYBAR(01,17,AllTrim(SD1->D1_COD),"N","C",10)
				
				MSCBSAY(01,29,"     " + "LOTE " + ALLTRIM(SD1->D1_LOTECTL) ,"N", "0", "050,055")
				MSCBSAYBAR(01,35,AllTrim(SD1->D1_LOTECTL),"N","C",10)
				
				MSCBSAY(01,50,"VALIDADE " + DTOC(SD1->D1_DTVALID) ,"N", "0", "025,027")	
				MSCBSAY(01,55,SUBSTR(SB1->B1_DESC,1,40),"N", "0", "025,027")				
				MSCBSAY(01,60,"EMISSAO NF-E " + DTOC(SD1->D1_EMISSAO) ,"N", "0", "025,027")	
				MSCBSAY(01,65,"DATA DIGITACAO " + DTOC(SD1->D1_DTDIGIT) ,"N", "0", "025,027")

				MSCBSAY(01,70,"DOCUMENTO " + SD1->D1_DOC + " SERIE " + SD1->D1_SERIE ,"N", "0", "025,027")
				MSCBSAY(01,80,"FORNECEDOR " + SD1->D1_FORNECE + " LOJA " + SD1->D1_LOJA ,"N", "0", "025,027")
				MSCBSAY(01,85,SUBSTR(SA2->A2_NREDUZ,1,40),"N", "0", "025,027")				

				
				MSCBEND()
			
			Next(nCount)
		
		EndIf

		SD1->(dbSkip())
	Enddo	
	
	MSCBCLOSEPRINTER()

Return          
 
Static Function Sair()

	Close(oDlg1)
	vSair := .t.
 
Return
