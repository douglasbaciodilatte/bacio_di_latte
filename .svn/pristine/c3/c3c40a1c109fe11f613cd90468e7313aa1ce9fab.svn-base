#include 'protheus.ch'
#include 'parmtype.ch'

/*/{Protheus.doc} bdlesta01
//Rotina para digitação de desperdício
@author Renan Paiva
@since 26/10/2018
/*/
user function bdlesta01()

Private _oDlg
Private _dData := Date()
Private _aItens := {"                         ", "AVARIA - QUALIDADE FORNECEDOR", "AVARIA - QUALIDADE INTERNA", "DESCARTE PRODUCAO", "PRODUTO DESCONTINUADO", "PRODUTO VENCIDO"}
Private _aTMs := {"   ","510", "520", "530", "540", "550"}
Private _cProduto := Space(TamSx3("B1_COD")[1])
Private _nQuant := 0
Private _cCombo := _aItens[1]
Private _lOk := .F.
Private _lCancel := .F.

if upper(left(cusername,2)) != 'LJ'
	msgStop("Esta rotina esta somente disponível para as lojas","DENIED")
	return
endif

	While !_lOk .And. !_lCancel

		DEFINE MSDIALOG _oDlg FROM 0,0 TO 250, 395 TITLE "Descarte" PIXEL
		@010,008 Say "Data:" PIXEL
		@008,060 MSGET _dData SIZE 60, 10 HASBUTTON PIXEL
		@030,008 Say "Tipo Descarte:" PIXEL
		TComboBox():New(28,060,{|u|if(PCount()>0,_cCombo:=u,_cCombo)},;
	        _aItens,120,13,_oDlg,,{|| },,,,.T.,,,,,,,,,'_cCombo')  
		
		@050,008 Say "Produto:" PIXEL
	    @048,060 MSGET _cProduto PICTURE PesqPict("SB1", "B1_COD") F3 "SB1" HASBUTTON PIXEL
	    @070,008 Say "Quantidade:" PIXEL
	    @068,060 MSGET _nQuant SIZE 80, 10 PICTURE PesqPict("SD3", "D3_QUANT") HASBUTTON PIXEL
	    
	    @100,110 BUTTON "OK" SIZE 35, 12 PIXEL OF _oDlg ACTION (_lOk := .T., _oDlg:End())
	    @100,150 BUTTON "CANCELAR" SIZE 35, 12 PIXEL OF _oDlg ACTION (_lCancel := .T., _oDlg:End())
	    
	    ACTIVATE MSDIALOG _oDlg CENTERED
    
	    if _lOk
	    	_lOk := .F.
	    	do case 
	    		case Trim(_cCombo) == ""
	    			MsgStop("Selecione o Tipo de Descarte","OBRIGAT")
	    		case Trim(_cProduto) == ""
	    			MsgStop("Informe o Produto","OBRIGAT")
	    		case _nQuant == 0
	    			MsgStop("Informe a Quantidade","OBRIGAT")
	    		otherwise	    				    				    			
	    			IncMov()
	    			_dData := Date()
	    			_cCombo := _aItens[1]
	    			_cProduto := Space(TamSx3("B1_COD")[1])
	    			_nQuant := 0	    			
	    	endcase 	    		    		    	 
	    endif
	        
    EndDo        
return 

/*/{Protheus.doc} IncMov
//Rotina para inclusão do movimento interno de descarte
@author Renan Paiva
@since 29/10/2018
@see (links_or_references)
/*/
Static Function IncMov()

Local _aDados := {}
Local _nPos := aScan(_aItens, {|x| x == _cCombo})
Private lMsErroAuto := .F.

aAdd(_aDados, {"D3_FILIAL", xFilial("SD3"), NIL})
aAdd(_aDados, {"D3_TM", _aTMs[_nPos], NIL})
aAdd(_aDados, {"D3_COD", _cProduto, NIL})
aAdd(_aDados, {"D3_QUANT", _nQuant, NIL})
aAdd(_aDados, {"D3_LOCAL", RIGHT(CUSERNAME,4) + '01', NIL})
aAdd(_aDados, {"D3_EMISSAO", _dData, NIL})

MSEXECAUTO({|x,y|mata240(x,y)}, _aDados, 3)

if lMsErroAuto
	MostraErro()
else
	msgInfo("Descarte registrado com sucesso!!!", "INCLUSAO OK")
endif

Return
