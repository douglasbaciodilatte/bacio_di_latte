#include "Protheus.ch"    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออออหออออออัอออออออออออออออออออออหอออออัออออออออออปฑฑ
ฑฑบPrograma  ณCNPJCPFF         บAutor ณNorbert Waage Junior บData ณ 29/06/05 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออสออออออฯอออออออออออออออออออออสอออออฯออออออออออนฑฑ
ฑฑบDescricao ณRotina para geracao do codigo/loja pelo CNPJ/CGC               บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณcCGC  - CGC/CNPJ do cliente                                    บฑฑ
ฑฑบ          ณcLoja - Loja do cliente, caso esta ja esteja preenchida        บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบRetorno   ณcCodigo - Codigo do cliente quando nao informada a loja        บฑฑ
ฑฑบ          ณaCodigo - Array com codigo e loja, quando informada a loja     บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบAplicacao ณRotina chamada via gatilho no campo A1_CGC ou via rotina       บฑฑ
ฑฑฬออออออออออุออออออออัออออออัอออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบAnalista  ณ Data   ณBops  ณManutencao Efetuada                            บฑฑ
ฑฑฬออออออออออุออออออออุออออออุอออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ        ณ      ณ                                               บฑฑ
ฑฑฬออออออออออุออออออออฯออออออฯอออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณPintos Magazine                              บData ณ 19/05/16  บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
//U_CNPJCPFF(M->A2_CGC,M->A2_LOJA,"2")
User Function CNPJCPFF(cCGC,cLoja,cOrigem)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local aArea	   		:= GetArea()
Local aAreaSA2 		:= SA2->(GetArea())
Local nTamCod		:= TamSx3("A2_COD")[1]
Local numero   		:= Space(nTamCod)
Local cQuery		:= ""
Local cAlias		:= GetNextAlias()
Local resto			:= 0
Local lPassouLoja	:= !(cLoja == NIL)
Local retorno_conv	:= Space(nTamCod)
Local cPessoa,cBusca
Local cProxNum		:= ""			//busca o proximo numero no HardLock 
local oModel		:= fwModelActive()   
local oSA2Master 	:= oModel:GetModel("SA2MASTER")

//Default cCGC  := IIf((AllTrim(ReadVar()) == "M->A2_CGC"),M->A2_CGC,Nil)
//Default cLoja := IIf((AllTrim(ReadVar()) == "M->A2_CGC"),M->A2_LOJA,Nil)
Default cOrigem := "1" 	//Sendo 1 = chamado a partir do campo CGC e 2 = chamado a partir do campo Estado

//Caso esteja chamando do campo estado e o mesmo nao seja extrangeiro retorna
If (cOrigem == "2" .And. M->A2_EST <> "EX") .Or. (cOrigem == "1" .And. M->A2_EST == "EX")
	Return M->A2_COD 

//Caso seja chamado do campo estado e o mesmo seja extrangeiro, busca no hardlock o proximo numero
ElseIf cOrigem == "2" .And. M->A2_EST == "EX"	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Seleciona sequencia dos fornecedores       ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cQuery := "Select MAX(A2_COD) A2_COD from "+ RetSQLName("SA2")
	cQuery += " where A2_FILIAL = '" + xFilial("SA2") + "' AND "
	cQuery += "A2_CGC = '" + Space(TamSX3("A2_CGC")[1]) + "' AND D_E_L_E_T_ = ' ' AND A2_EST='EX' AND A2_COD LIKE ('0%')" 
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias,.F.,.T.)
	If !(cAlias)->( Eof() )
		cProxNum := (cAlias)->A2_COD
	Else
		cProxNum := Replicate("0",TamSX3("A2_COD")[1])
	EndIf

	cProxNum := Soma1(cProxNum)
	
	oSA2Master:LoadValue("A2_LOJA", "9999")
	
	(cAlias)->( dbCloseArea() )
	
	RestArea(aArea)
	RestArea(aAreaSA2)
	
	Return(cProxNum)
	
ElseIf Len(alltrim(cCGC)) > 11
	//Pessoa Juridica
	div		:= Val(SubStr(cCGC,1,8))
	cLoja	:= "0001"
	cPessoa	:= "J"
Else
	// Pessoa Fisica
	div    := Val(SubStr(cCGC,1,9))
	cLoja := "9999"
	cPessoa	:= "F"
EndIf

//Calcula codigo
While div >= 35
	resto := div % 35
	div   := int(div / 35)
	numero:= conv1(resto)+alltrim(numero)
End

numero       := Conv1(div)+AllTrim(numero)
retorno_conv := Replicate("0",nTamCod-Len(AllTrim(numero)))+AllTrim(numero)

//Calculo da loja para as filiais de uma mesma empresa
dbSelectArea("SA2")
dbSetOrder(1)

If cLoja <> "9999"
	
	While .T.
		
		cBusca := retorno_conv + cLoja
		dbSelectArea( "SA2" )
		dbSetOrder(1)
		dbSeek(xFilial("SA2")+cBusca)
		
		If Eof()
			Exit
		Else
			cLoja := Soma1(cLoja)
		EndIf
		
	EndDo
	
EndIf  

If Len(alltrim(cCGC)) > 11
	cLoja := substr(M->A2_CGC,9,4)
Else
	cLoja := "9999"
Endif

//Se foi acionada por gatilho na tela de clientes
If AllTrim(ReadVar()) == "M->A2_CGC"
	
	oSA2Master:LoadValue("A2_LOJA", cLoja)
	oSA2Master:LoadValue("A2_TIPO", cPessoa)	
	
	//Executa os gatilhos do campo pessoa
	If ExistTrigger("A2_TIPO")
		RunTrigger(1,,,,"A2_TIPO")
	EndIf
	
EndIf

RestArea(aAreaSA2)
RestArea(aArea)

If lPassouLoja
	Return({retorno_conv,cLoja})
Else
	Return(retorno_conv)
EndIf   

/*

ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ

ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ

ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ

ฑฑบPrograma  ณ Conv1    บAutor  ณ Marcelo Gaspar     บ Data ณ  01/10/01   บฑฑ

ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ

ฑฑบDescricao ณ Funcao que converte numeros em letras(base 35)             บฑฑ

ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ

ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ

฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿

*/

Static Function Conv1(y)

Return AllTrim(IIf(y<10,Str(y),Chr(y+55)))


