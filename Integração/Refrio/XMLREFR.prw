#Include "TOTVS.ch"
#Include "FWMVCDEF.ch"
#include "topconn.ch"
#include "tbiconn.ch"
#INCLUDE 'RWMAKE.CH'



User Function XMLREFR()

Local cXml    := ''
Local cFil    := ''
Local cSolict := ''
Local cQuery  := ''
Local cResult := ''
Local lAux    := .T.
Local nItem   := 0

    cSolict := NNS->NNS_COD
    cFil    := NNS->NNS_FILIAL

        cQuery := CRLF + " SELECT NNS_COD,NNS_DATA,NNS_SOLICT,NNS_XNOMSO,NNS_STATUS,NNT_PROD,NNT_UM,NNT_LOCAL,NNT_QUANT,NNT_FILDES,NNT_LOCLD,NNT_XDATA,NNT_XHORA,NNT_QTSEG FROM "+RetSqlName('NNS')+" NNS "
        cQuery += CRLF + " INNER JOIN "+RetSqlName('NNT')+" NNT ON NNT_COD=NNS_COD AND NNT_FILIAL=NNS_FILIAL AND NNT.D_E_L_E_T_='' "
        cQuery += CRLF + " WHERE NNS.D_E_L_E_T_='' AND NNS_COD='"+cSolict+"' AND NNS_FILIAL='"+cFil+"' "

        If Select("TMP") <> 0
            DbSelectArea("TMP")
            DbCloseArea()
        EndIf	

        DbUseArea(.T.,"TOPCONN",TCGENQRY(,,cQuery),'TMP',.F.,.T.)

        OpenSM0()
        SM0->(DBGOTOP())

        While !SM0->(EOF()) 
            If Alltrim(SM0->M0_CODFIL)==Alltrim(TMP->NNT_FILDES)
                cEndDes := Alltrim(SM0->M0_ENDENT)
                cCidDes := Alltrim(SM0->M0_CIDENT)
                cUFDes  := Alltrim(SM0->M0_ESTENT)
                cCepDes := Alltrim(SM0->M0_CEPENT)
                cBairDes:= Alltrim(SM0->M0_BAIRENT)
                cCGCDes := Alltrim(SM0->M0_CGC)
            ElseIf Alltrim(SM0->M0_CODFIL)==Alltrim(cFilAnt)
                cCgcEnt := Alltrim(SM0->M0_CGC)
            EndIf
            SM0->(DbSkip())
        Enddo
        
        While TMP->(!EOF())

            If lAux

                cDate := DToC(SToD(TMP->NNT_XDATA))+' '+Alltrim(TMP->NNT_XHORA)
               
                cXml := "   <GENERICA>"
                cXml += CRLF + "  <IDENTIFICACAO> " + CRLF
                cXml += CRLF + "      <IDENTIFICADOR>WEBAPI-I50</IDENTIFICADOR> "
                cXml += CRLF + "      <REQUISITANTE>00043</REQUISITANTE>"
                cXml += CRLF + "      <DESTINO>00037</DESTINO>"
                cXml += CRLF + "      <CNPJ_REQUISITANTE>"+TRANSFORM(cCgcEnt, "@R 99.999.999/9999-99")+"</CNPJ_REQUISITANTE>"
                cXml += CRLF + "      <CNPJ_DESTINO>49.363.468/0005-63</CNPJ_DESTINO>"
                cXml += CRLF + "   </IDENTIFICACAO>"
                
                
                cXml += CRLF + "   <DADOSXML>"
                cXml += CRLF + "      <PEDIDOS>"
                cXml += CRLF + "         <PEDIDO>"
                cXml += CRLF + "            <doca />"
                cXml += CRLF + "            <cnpjProprietario>"+cCGCDes+"</cnpjProprietario>"
                cXml += CRLF + "            <cnpjDestinatario>"+cCgcEnt+"</cnpjDestinatario>"
                cXml += CRLF + "            <cnpjTransportadora>"+cCgcEnt+"</cnpjTransportadora>"
                cXml += CRLF + "            <numeroPedido>"+cSolict+"</numeroPedido>"
                cXml += CRLF + "            <tipoCarga>CN</tipoCarga>"
                cXml += CRLF + "            <tipoAcondicionamento>PC</tipoAcondicionamento>"
                cXml += CRLF + "            <tipoSeparacao>FEF</tipoSeparacao>"
                cXml += CRLF + "            <observacao />"
                cXml += CRLF + "            <dataEmissao>"+cDate+"</dataEmissao>"
             //   cXml += CRLF + "            <numeroPlanejamento>246889</numeroPlanejamento>"
            //    cXml += CRLF + "            <numeroEmbarque>566</numeroEmbarque>"
            //    cXml += CRLF + "            <numeroRefPedCliente>4562</numeroRefPedCliente>"
             //   cXml += CRLF + "            <nroagrupseparacao>246889</nroagrupseparacao>"
             //   cXml += CRLF + "            <placaVeiculo>DET1456</placaVeiculo>"
            //    cXml += CRLF + "            <deposito>03</deposito>"
                cXml += CRLF + "            <cnpjArmazem>"+cCgcEnt+"</cnpjArmazem>"
                cXml += CRLF + "            <numeroLacre />"
                cXml += CRLF + "            <indicaLocalEntregaNome>"+cEndDes+"</indicaLocalEntregaNome>"
                cXml += CRLF + "            <indicaLocalEntregaBairro>"+cBairDes+"</indicaLocalEntregaBairro>"
                cXml += CRLF + "            <indicaLocalEntregaCidade>"+cCidDes+"</indicaLocalEntregaCidade>"
                cXml += CRLF + "            <indicaLocalEntregaCep>"+cCepDes+"</indicaLocalEntregaCep>"
                cXml += CRLF + "            <indicaLocalEntregaUf>"+cUFDes+"</indicaLocalEntregaUf>"
            //    cXml += CRLF + "            <indicaLocalEntregaTel />"
         //       cXml += CRLF + "            <atributo1>246889</atributo1>"
          //      cXml += CRLF + "            <atributo2>1620167</atributo2>"
          //      cXml += CRLF + "            <atributo3>2</atributo3>"
            EndIf

                nItem++

                cXml += CRLF + "            <ITEM_PEDIDO>"
                cXml += CRLF + "               <numeroSequencialItem>"+cValToChar(nItem)+"</numeroSequencialItem>"
                cXml += CRLF + "               <codigoProduto>"+Alltrim(TMP->NNT_PROD)+"</codigoProduto>"
                cXml += CRLF + "               <qtdeEmbalagem>"+Alltrim(Iif(ValType(TMP->NNT_QTSEG)=='N',cValToChar(TMP->NNT_QTSEG),TMP->NNT_QTSEG))+"</qtdeEmbalagem>"
                cXml += CRLF + "               <quantidadeProduto>"+Alltrim(Iif(ValType(TMP->NNT_QUANT)=='N',cValToChar(TMP->NNT_QUANT),TMP->NNT_QUANT))+"</quantidadeProduto>"
           //     cXml += CRLF + "               <tipoSeparacao>FEF</tipoSeparacao>"
             //   cXml += CRLF + "               <valorDetalhe1 />"
               // cXml += CRLF + "               <valorDetalhe2 />"
               // cXml += CRLF + "               <valorDetalhe3 />"
               // cXml += CRLF + "               <valorDetalhe4 />"
                cXml += CRLF + "               <tipoEspecificacaoItem />"
                cXml += CRLF + "               <valorEspecificacaoItem />"
                cXml += CRLF + "            </ITEM_PEDIDO>"

            lAux := .F.

            TMP->(DbSkip())
        EndDo

            cXml += CRLF + "         </PEDIDO>"
            cXml += CRLF + "      </PEDIDOS>"
            cXml += CRLF + "   </DADOSXML>"
            cXml += CRLF + "   </GENERICA>"
        
        oWs:=WSWmsSIS():New()
    
        oWs:oWScabec:CIDENTIFICADOR := "WEBAPI-I50"
        oWs:oWScabec:CREQUISITANTE := "00043"
        //oWs:oWScabec:CXSDVALIDACAO := "PadraoI50-v1.xsd"    

        If oWs:SOLWMSConsumoInterfaces(oWs:oWScabec,cXml)
            cResult := oWs:cSOLWMSConsumoInterfacesResult
        Else                    
            cResult := GetWSCError()  
        EndIf
Return
