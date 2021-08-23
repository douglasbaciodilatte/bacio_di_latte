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
	
User Function BDETIQ03()
    
    SetPrvt("CPERG,CCOMBO,AITENS,VIQetiq,cCidade,nCount,VNFISCAL,VNR")
	SetPrvt("cPed,VCLIENTE,cCliEnt,cSerie,nLin,nCol,lPrim,cEndEnt,VQtdEmb")
	SetPrvt("VCONF,cNome,cEntrega,cNomeTra, VDTAVAL,VSAIR,_CPORTA,_SALIAS,AREGS,dDataTrf")
	SetPrvt("I,J,qQetiq")
 
	Private VNFISCAL := Space(10)

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
	   
	   @ 042,015 Say "Transferencia:"
	   @ 042,065 Get VNFISCAL               SIZE 50,20 Picture "@!" F3 "NNS" 
 
	   ACTIVATE DIALOG oDlg1 CENTERED
	EndDo

Return

Static Function Impetiq()

	Private aDados := {}

	MSCBPRINTER("ZEBRA","LPT1",,,.F.,,,,,,.T.)

	NNT->(dbsetorder(1))
	NNT->(dbseek(xfilial("NNT") + VNFISCAL ))
	
    If EMPTY(NNT->NNT_DOC)

        Alert("ATENÇÃO: Solicitação não foi efetivada, etiqueta não pode ser impressa!") 
    Else
        Do While NNT->(!eof() .And. xFilial("NNT") == NNT->NNT_FILIAL .And. NNT->NNT_COD == VNFISCAL )

            //Busca fornecedor
            SA2->(dbSelectArea("SA2"))
            SA2->(dbSetOrder(1))

                SB1->(dbSelectArea("SB1"))
                SB1->(dbSetOrder(1))
                SB1->(dbSeek(xFilial("SB1") + NNT->NNT_PROD))

                For nCount := VIQetiq to VFQetiq

                    MSCBBEGIN(1,3)
                
                    MSCBSAY(01,10,"     " + ALLTRIM(NNT->NNT_PROD) ,"N", "0", "052,055")
                    MSCBSAYBAR(01,17,AllTrim(NNT->NNT_PROD),"N","C",10)
                    
                    If ! EMPTY(NNT->NNT_LOTECT)

                        MSCBSAY(01,29,"     " + "LOTE " + ALLTRIM(NNT->NNT_LOTECT) ,"N", "0", "050,055")
                        MSCBSAYBAR(01,35,AllTrim(NNT->NNT_LOTECT),"N","C",10)

                    EndIf    
                    
                    MSCBSAY(01,50,"VALIDADE " + DTOC(NNT->NNT_DTVALI) ,"N", "0", "025,027")	
                    MSCBSAY(01,55,SUBSTR(SB1->B1_DESC,1,40),"N", "0", "025,027")				
                    MSCBSAY(01,60,"SOLICITADO " + DTOC(NNT->NNT_XDATA) ,"N", "0", "025,027")	
                    MSCBSAY(01,65,"ARM ORIGEM " + NNT->NNT_LOCAL ,"N", "0", "025,027")
                    MSCBSAY(01,70,"ARM DESTINO " + NNT->NNT_LOCLD ,"N", "0", "025,027")

                    MSCBSAY(01,75,"NUM SOLICITACAO " + NNT->NNT_COD ,"N", "0", "025,027")
                                    
                    MSCBEND()
                
                Next(nCount)
            
            NNT->(dbSkip())
        Enddo	
	
	MSCBCLOSEPRINTER()
    EndIf
Return          
 
Static Function Sair()

	Close(oDlg1)
	vSair := .t.
 
Return
