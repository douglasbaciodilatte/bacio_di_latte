/*/{Protheus.doc} User Function BDPEDEMP
    (long_description)
    @type  Function
    @author user
    @since 19/10/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function BDPEDEMP()

    Local _aBoxParam 	:= {}
	Private _aRet 	:= {}
	
	Aadd(_aBoxParam,{1,"Filial"		,Space(04)		,"@!"	,""	,"SM0"   	,""	,05	,.F. })
	
    Aadd(_aBoxParam,{1,"Numero OP"  ,Space(10)		,"@!"	,""	,"SC2"	,""	,50	,.F. })
	
	If ParamBox(_aBoxParam, "Gerar Pedido de Venda - OP Tipo BN", @_aRet)

        

    EndIf
    
Return 
