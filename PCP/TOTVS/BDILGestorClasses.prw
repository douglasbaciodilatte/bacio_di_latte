#include 'protheus.ch'

/*/{Protheus.doc} BDILProd
Classe para conter os dados do produto que serão retornados
na API Rest
@author    Renan Paiva
@since     06/05/2018
@version   1.0
/*/
USER FUNCTION BDILPRODFUNC
RETURN

class BDILProd
	
	data produto as string
	data unidadeMedida	as string
	data descricao as string
	data status as string
	method new(cCodigo, cDescricao, cUM, cStatus) constructor 

endclass

/*/{Protheus.doc} new
Metodo construtor
@author    renan
@since     06/05/2018
@version   1.0
/*/
method new(cCodProd, cDesc, cUMProd, cStat) class BDILProd

::produto := cCodProd
::unidadeMedida := cUMProd
::descricao := cDesc
::status := cStat

return

/*/{Protheus.doc} BDILEstrutItem
Classe que representa o item da estrutura de produtos que serão retornados
na API Rest
@author    Renan Paiva
@since     18/05/2018
@version   1.0
/*/
class BDILEstrutItem
	data ingrediente 
	data quantidade	
	method new() constructor 
endclass
                                                  
/*/{Protheus.doc} new
Metodo construtor
@author    renan
@since     18/05/2018
@version   1.0
/*/
method new(cComp, nQtd) class BDILEstrutItem
::ingrediente := cComp
::quantidade := nQtd
return                                                       

/*/{Protheus.doc} BDILEstrut
Classe para conter os dados da estrutura de produto que será retornado
na API Rest
@author    Renan Paiva
@since     18/05/2018
@version   1.0
/*/                         
class BDILEstrut
	data produto
	data quantidadeBase
	data ingredientes
	method new() constructor
	method AddItem()
endclass  
   
/*/{Protheus.doc} new
Metodo construtor
@author    renan
@since     18/05/2018
@version   1.0
/*/
method new(cPai, nQtdBase) class BDILEstrut
::produto := cPai
::quantidadeBase := nQtdBase
::ingredientes := {}
return Self         

/*/{Protheus.doc} new
Metodo AddItem
@author    renan
@since     18/05/2018
@version   1.0
/*/                 
method AddItem(cComp, nQtd) class BDILEstrut
	aAdd(::ingredientes, BDILEstrutItem():New(cComp, nQtd))
return