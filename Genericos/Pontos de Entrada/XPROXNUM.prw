
/*/{Protheus.doc} XPROXNUM
    @Desc numeraçao automatica SD3 MV_DOCSEQ
    @type User Function
    @author Felipe Mayer
    @since 07/06/2021
/*/
User Function XPROXNUM()

Local nTam:=TamSx3("D3_NUMSEQ")[1]
Local cNumSeq:= Replicate("0",nTam)

cNumSeq := Soma1(Subs(GetMV("MV_DOCSEQ"),1,nTam))
PutMV("MV_DOCSEQ",cNumSeq)

Return cNumSeq
