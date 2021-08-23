#Include 'Totvs.ch'

/*/
{Protheus.doc} BDCOMBN
	@Description: Processa rotina de criação BN
	@author: Felipe Mayer
	@since: 20/05/2021
/*/
User Function BDCOMBN()

    Processa({|| fGeraBn()},"BDCOMBN","Gerando produto BN, aguarde...",.F.)

Return


/*/
{Protheus.doc} fGeraBn
	@Description: Duplicar produto e criar tipo BN
	@author: Felipe Mayer
	@since: 08/06/2021
/*/
Static Function fGeraBn()

Local aArea     := GetArea()
Local aAreaSB1  := SB1->(GetArea())
Local aFieldSB1 := FwSx3Util():GetAllFields("SB1",.F.)
Local aItens    := {}
Local nX        := 0

    For nX := 1 To Len(aFieldSB1)
        AAdd(aItens,{aFieldSB1[nX],&('SB1->'+aFieldSB1[nX])})
    Next nX

    DbSelectareA("SB1")
    DbSetOrder(1)

    cProd := Iif(!IsNumeric(SubsTr(Alltrim(&('SB1->'+aFieldSB1[2])),0,2)),'BN'+SubsTr(Alltrim(&('SB1->'+aFieldSB1[2])),3),'BN'+Alltrim(&('SB1->'+aFieldSB1[2])))

    If !Dbseek(xFilial("SB1")+cProd)
        Reclock('SB1',.T.)
        For nX := 1 To Len(aItens)
            __Dados := aItens[nX,2]

            If aItens[nX,1] == 'B1_COD'
                If !IsNumeric(SubsTr(Alltrim(aItens[nX,2]),0,2))
                    __Dados := 'BN'+SubsTr(Alltrim(aItens[nX,2]),3)
                Else
                    __Dados := 'BN'+Alltrim(aItens[nX,2])
                EndIf
            ElseIf aItens[nX,1] == 'B1_TIPO'
                __Dados := 'BN'
            ElseIf aItens[nX,1] == 'B1_XGRUPO2'
                __Dados := ''//u_BDSEQLT()
            ElseIf aItens[nX,1] == 'B1_MSBLQL'
                __Dados := '1'
            EndIf
            
            &('SB1->'+aItens[nX,1]) := __Dados
        Next nX
        SB1->(MsUnlock())

        MsgInfo('Produto BN -'+Alltrim(Posicione("SB1",1,xFilial("SB1")+cProd,"B1_DESC"))+' criado com sucesso!',cProd)
        MsgInfo('Produto <b>'+cProd+' - '+Alltrim(Posicione("SB1",1,xFilial("SB1")+cProd,"B1_DESC"))+'</b> bloqueado!<br>Alterar cadastro e desbloquear!!','BDCOMBN')
    Else
        MsgAlert('<b>ATENCAO</b> Produto BN ja existe: '+cProd+' - '+Alltrim(Posicione("SB1",1,xFilial("SB1")+cProd,"B1_DESC")),'BDCOMBN')
    EndIf

    SB1->(DbCloseArea())

    RestArea(aArea)
    RestArea(aAreaSB1)
    
Return
