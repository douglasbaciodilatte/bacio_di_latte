#include "Protheus.ch"    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัอออออออออออออออออหออออออัอออออออออออออออออออออหอออออัออออออออออปฑฑ
ฑฑบPrograma  ณCNPJCPFC         บAutor ณNorbert Waage Junior บData ณ 29/06/05 บฑฑ
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
//U_CNPJCPFC(M->A1_CGC,M->A1_LOJA,"2")
User Function CNPJCPFC(cCGC,cLoja,cOrigem)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local aArea	   		:= GetArea()
Local aAreaSA1 		:= SA1->(GetArea())
Local nTamCod		:= TamSx3("A1_COD")[1]
Local numero   		:= Space(nTamCod) 
Local cQuery		:= ""
Local cAlias		:= GetNextAlias()
Local resto			:= 0
Local lPassouLoja	:= !(cLoja == NIL)
Local retorno_conv	:= Space(nTamCod)
Local cPessoa,cBusca  
Local cProxNum		:= ""			//busca o proximo numero no HardLock

Default	cCGC  := IIf((AllTrim(ReadVar()) == "M->A1_CGC"),M->A1_CGC,Nil)
Default	cLoja := IIf((AllTrim(ReadVar()) == "M->A1_CGC"),M->A1_LOJA,Nil)  
Default cOrigem := "1" 	//Sendo 1 = chamado a partir do campo CGC e 2 = chamado a partir do campo Estado

//Caso esteja chamando do campo estado e o mesmo nao seja extrangeiro retorna
If (cOrigem == "2" .And. M->A1_EST <> "EX") .Or. (cOrigem == "1" .And. M->A1_EST == "EX")
	Return M->A1_COD 

//Caso seja chamado do campo estado e o mesmo seja extrangeiro, busca no hardlock o proximo numero
ElseIf cOrigem == "2" .And. M->A1_EST == "EX"	
	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณ Seleciona sequencia dos clientes           ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
	cQuery := "Select MAX(A1_COD) A1_COD from "+ RetSQLName("SA1")
	cQuery += " where A1_FILIAL = '" + xFilial("SA1") + "' AND "
	cQuery += "A1_CGC = '" + Space(TamSX3("A1_CGC")[1]) + "' AND D_E_L_E_T_ = ' ' AND A1_EST='EX' AND A1_COD LIKE ('0%')" 
	cQuery := ChangeQuery(cQuery)
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAlias,.F.,.T.)
	If !(cAlias)->( Eof() )
		cProxNum := (cAlias)->A1_COD
	Else
		cProxNum := Replicate("0",TamSX3("A1_COD")[1])
	EndIf

	cProxNum := Soma1(cProxNum)
	
	M->A1_LOJA		:= "9999"
	
	(cAlias)->( dbCloseArea() )
	
	RestArea(aArea)
	RestArea(aAreaSA1)
	
	Return(cProxNum)

ElseIf Len(alltrim(cCGC)) > 11
	//Pessoa Juridica
	div		:= Val(SubStr(cCGC,1,8))
	cLoja	:= "0001"
	cPessoa	:= "J"
Else
	// Pessoa Fisica
	div		:= Val(SubStr(cCGC,1,9))
	//div    := Int(Val(AllTrim(cCGC)))/100
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
dbSelectArea("SA1")
dbSetOrder(1)

If cLoja <> "9999"
	
	While .T.
		
		cBusca := retorno_conv + cLoja
		
		dbSeek(xFilial("SA1")+cBusca)
		
		If Eof()
			Exit
		Else
			cLoja := Soma1(cLoja)
		EndIf
		
	EndDo
	
EndIf  

If Len(alltrim(cCGC)) > 11
	cLoja := substr(M->A1_CGC,9,4)
Else
	cLoja := "9999"
Endif


//Se foi acionada por gatilho na tela de clientes
If AllTrim(ReadVar()) == "M->A1_CGC"
	
	M->A1_LOJA		:= cLoja
	M->A1_PESSOA	:= cPessoa
	
	//Executa os gatilhos do campo pessoa
	If ExistTrigger("A1_PESSOA")
		RunTrigger(1,,,,"A1_PESSOA")
	EndIf
	
EndIf

RestArea(aAreaSA1)
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
