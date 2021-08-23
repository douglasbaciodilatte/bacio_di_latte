#Include "Protheus.ch"

/*/{Protheus.doc} User Function GATNNT01
    (long_description)
    @type  Function
    @author user
    @since 18/10/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function GATNNT01()
    
    Local _dValid := DATE()
    Local oModel    := FWModelActive()

    Local _cProdOri := oModel:GetValue('NNTDETAIL','NNT_PROD')
    Local _cLocaOri := oModel:GetValue('NNTDETAIL','NNT_LOCAL')
    Local _cLoteOri := oModel:GetValue('NNTDETAIL','NNT_LOTECT')

    //Busca validade lote - SB8

    If ! Empty(_cProdOri ) .And. ! Empty(_cLocaOri) .And. ! Empty(_cLoteOri)

        SB8->(DBSelectArea("SB8"))
        SB8->(DBSetOrder(3)) //B8_FILIAL+B8_PRODUTO+B8_LOCAL+B8_LOTECTL

        If SB8->(DBSeek( xFilial("NNT") + _cProdOri + _cLocaOri + _cLoteOri))

            If ! Empty(SB8->B8_DTVALID)
                _dValid := SB8->B8_DTVALID     
            EndIf
        
        EndIf    

    EndIf

    oModel:SetValue('NNTDETAIL','NNT_DTVALI',_dValid)

Return _dValid
