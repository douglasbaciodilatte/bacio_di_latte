#Include 'FWMVCDEF.ch'
#Include "TOTVS.ch"

/*/{Protheus.doc} 311MODEL1
    @type  Ponto de Entrada MVC BDTRANSF
    @author Felipe Mayer
    @since 11/05/2021
/*/

User Function 311MODEL1()

Local aArea   	 := Getarea()
Local aAreaNNT 	 := NNT->(GetArea())
Local aAreaNNS 	 := NNS->(GetArea())
Local aParam     := PARAMIXB
Local oObj       := NIL      
Local cIdPonto   := Space(0)
Local nOper      := 0
Local nX         := 0
Local aItens     := {}
Local lRet       := .T.

    If aParam <> NIL
        oObj     := aParam[1]
        cIdPonto := aParam[2]
        cIdModel := aParam[3]

        If cIdPonto == "MODELVLDACTIVE"
            nOper := oObj:nOperation
            If nOper == 3
                If Upper(SubsTr(UsrRetName(RetCodUsr()),0,2))=='LJ' .And. xFilial('NNS')!='0031'
                    MsgAlert("Favor logar na filial correta: 0031")
                    lRet := .F.
                Else
                    lRet := fClassProd(oObj)
                EndIf
            ElseIf nOper == 4
                If NNS->NNS_STATUS != "2"
                    If Date()>NNS->NNS_DATA .And. Upper(SubsTr(UsrRetName(RetCodUsr()),0,2))=='LJ'
                        MsgAlert("Não é possível realizar alteração, data posterior ao lançamento!")
                        lRet := .F.
                    ElseIf Val(SubsTr(Time(),1,2)) >= 15 .And. Upper(SubsTr(UsrRetName(RetCodUsr()),0,2))=='LJ'
                        MsgAlert("Não é possível a alteração após as 15h00<br>Horário atual: "+Time())
                        lRet := .F.
                    EndIf
                Else
                    MsgAlert("Não é possível a alteração dessa solicitação!")
                    lRet := .F.     
                EndIf

                If lRet .And. NNS->NNS_XCLASP == '2'
                    cFilAnt := '0136'
                EndIf
            EndIf
        
        ElseIf cIdPonto == "MODELCANCEL"
            //Zerando variáveis publicas
            cFilAnt := __cBkpFila
            __cClasPrd := ''

        ElseIf cIdPonto == 'MODELCOMMITNTTS'
            nOper := oObj:nOperation
            If Upper(SubsTr(UsrRetName(RetCodUsr()),0,2))=='LJ' .And. nOper == 3

                oModelNNS := oObj:AALLSUBMODELS[1] // Cabecalho
                oModelNNT := oObj:AALLSUBMODELS[2] // Itens
                            
                For nX := 1 To oModelNNT:GetQtdLine() 
                    oModelNNT:GoLine(nX)

                    aAdd(aItens,{;
                        oModelNNT:GetValue("NNT_FILORI"),;
                        oModelNNT:GetValue("NNT_FILDES"),;
                        Alltrim(oModelNNT:GetValue("NNT_PROD")),;
                        Alltrim(Posicione("SB1",1,xFilial("SB1")+oModelNNT:GetValue("NNT_PROD"),"B1_DESC")),;
                        Alltrim(oModelNNT:GetValue("NNT_LOCAL")),;
                        oModelNNT:GetValue("NNT_LOCLD"),;
                        oModelNNT:GetValue("NNT_QTSEG")})
                Next nX

                U_WFTRANSF(oModelNNS:GetValue("NNS_COD"),oModelNNS:GetValue("NNS_DATA"),oModelNNS:GetValue("NNS_HORA"),aItens)
            EndIf

            //Zerando variáveis publicas
            cFilAnt := __cBkpFila
            __cClasPrd := ''
        EndIf
    EndIf

    RestArea(aArea)
    RestArea(aAreaNNT) 
    RestArea(aAreaNNS)

Return lRet



Static Function fClassProd(oObj)

Local lRet   := .T.
Local cCombo := '1'
Local oDlg1,oFont1,oFont2,oBtn1,oBtn2,oSay1,oGrp1,oCBox1

    DEFINE MSDIALOG oDlg1 TITLE "Selecione a classe de produtos" FROM 302, 493 TO 460, 808 COLORS 0, 16777215 PIXEL STYLE DS_MODALFRAME

    oFont1 := TFont():New("MS Reference Sans Serif",0,-11,,.F.,0,,400,.F.,.F.,,,,,,)
    oFont2 := TFont():New("Tahoma",0,-22,,.T.,0,,400,.F.,.F.,,,,,,)
    oSay1  := TSay():New(10,08,{||'Classe de Produtos'},oDlg1,,oFont2,,,,.T.,RGB(031,073,125),,200,030,,,,,,.F.)
    oGrp1  := TGroup():New(036,004,056,152,"",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F.)
    oCBox1 := TComboBox():New(040,008,{|u|if(PCount()>0,cCombo:=u,cCombo)},{"1 - Secos","2 - Congelados"},;
                139,011,oGrp1,,{||},,CLR_BLACK,CLR_WHITE,.T.,oFont1,,,,,,,,'cCombo')

    oBtn1  := TButton():New(064,108,"Confirmar",oDlg1,{||__cClasPrd:=cCombo,oDlg1:End()},037,012,,oFont1,,.T.,,"",,,,.F.)
    oBtn2  := TButton():New(064,068,"Cancelar",oDlg1,{||lRet:=.F.,oDlg1:End()},037,012,,oFont1,,.T.,,"",,,,.F.)

    oDlg1:lEscClose := .F.
    oDlg1:Activate(,,,.T.)

    If SubsTr(cCombo,1,1) == '2'
        cFilAnt := '0136'
    EndIf

Return lRet
