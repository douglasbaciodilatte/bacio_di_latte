#include "totvs.ch"
#include "topconn.ch"
#include "fileio.ch"

*/
//------------------------------------------------------------
// Função BLVLDPROD                        | Data: 17.05.2019
// Autor: Rodolfo Vacari
// Descrição: Validacao do produto na UM 
// 
//------------------------------------------------------------
User Function XVLDPROD1()
LOCAL _XVLDPROD := NNT->NNT_QUANT

If !SUBSTR(NNT->NNT_PROD,1,2) $ ("PA","PI")
    ALERT("Para esse PRODUTO, Digitar a quantidade no campo Qtde. 2a. UM")
    _XVLDPROD := 0
    
EndIf    

Return(_XVLDPROD)