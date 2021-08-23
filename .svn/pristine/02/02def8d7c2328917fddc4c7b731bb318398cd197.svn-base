
/*/
{Protheus.doc} BDSEQLT
	@Description: Proximo numero sequencia B1_XGRUPO2
	@author: Felipe Mayer
	@since: 20/05/2021 
/*/

User Function BDSEQLT()

Local aSx5  	:= FWGetSX5("Z5")
Local cAltAnt   := Iif(Altera,Alltrim(Posicione('SB1',1,xFilial('SB1')+M->B1_COD,'B1_XSEGMEN')),'')
Local cAltPos   := Iif(Altera,Alltrim(M->B1_XSEGMEN),'')
Local nPos  	:= aScan(aSx5, {|x| AllTrim(Upper(x[3])) == Alltrim(M->B1_XSEGMEN)})
Local cRet  	:= Iif(nPos > 0 .And. Inclui,Soma1(aSx5[nPos,4]),'')

	If Altera .And. cAltAnt != cAltPos
		cRet := Iif(nPos > 0,Soma1(aSx5[nPos,4]),'')
	ElseIf Altera .And. cAltAnt == cAltPos
		cRet := Alltrim(Posicione('SB1',1,xFilial('SB1')+M->B1_COD,'B1_XGRUPO2'))
	EndIf	

Return cRet
