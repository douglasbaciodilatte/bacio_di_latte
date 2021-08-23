/*/{Protheus.doc} User Function RLOTETMA2
description)
    @type  Function
    @author user
    @since 05/10/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function ROTRF004()
    
    Local aAreaAnt := GETAREA()

        RecLock("NNS", .F.)
            NNS->NNS_STATUS := "1"
        MsUnLock() 

    RestArea(aAreaAnt) 

Return 
