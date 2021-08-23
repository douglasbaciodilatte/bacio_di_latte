//Bibliotecas
#Include "Protheus.ch"
#Include "TopConn.ch"    
#include "apwebsrv.ch"
#include "apwebex.ch"
#include "ap5mail.ch"  
 
/*--------------------------------------------------------------------------------------------------------------*
 | P.E.:  A200GRVE                                                                                              |
 | Desc:  P.E. chamado na confirmação de dados da Estrutura                                                     |
 | Link:  http://tdn.totvs.com/display/public/PROT/A200GRVE                                                     |
 *--------------------------------------------------------------------------------------------------------------*/
 
User Function A200GRVE()
    Local aArea     := GetArea()
    Local nOperacao := ParamIxb[1]
    Local lMapDiv   := ParamIxb[2]
    Local aRecExc   := ParamIxb[3]
    Local aRecAlt   := ParamIxb[4]
    Local cEmAlter  := SuperGetMV("MV_XALTEST", .F., "sistemas@bdil.com.br;oliver@bdil.com.br")
    Local cMsg      := ""
    Local nAtual    := 0
    Local aRegsInc  := {}
    Local aRegsAlt  := {}
    Local aRegsExc  := {}
    Local cQryAux   := ""
    Local cCodProd  := ""
    Local cDesProd  := ""
     
    If nOperacao != 2
        cMsg += "Produto: "+cProduto+"("+Alltrim(Posicione('SB1', 1, FWxFilial('SB1')+cProduto, 'B1_DESC'))+")<br>"
        cMsg += "Data: "+dToC(Date())+"<br>"
        cMsg += "Hora: "+Time()+"<br>"
        cMsg += "Usu&aacute;rio: "+RetCodUsr()+" ("+cUserName+")<br><br>"
    EndIf
     
    //Visualização
    If nOperacao == 2
         
    //Inclusão
    //ElseIf nOperacao == 3
         
    //Alteração
    ElseIf nOperacao == 4
        //Se tiver alteração, dispara e-Mail
        cMsg := '<font face="tahoma"><h1>Altera&ccedil;&atilde;o na Estrutura.</h1><br><br>'+cMsg+'<br><br>'
         
        //Percorre os recnos
        For nAtual := 1 To Len(aRecAlt)
            cQryAux := " SELECT "
            cQryAux += "    G1_COMP, "
            cQryAux += "    B1_DESC AS DESCRICAO "
            cQryAux += " FROM "
            cQryAux += "    "+RetSQLName('SG1')+" SG1 WITH (NOLOCK) "
            cQryAux += "    INNER JOIN "+RetSQLName('SB1')+" SB1 WITH (NOLOCK) ON ("
            cQryAux += "        B1_FILIAL = '"+FWxFilial('SB1')+"' "
            cQryAux += "        AND B1_COD = G1_COMP "
            cQryAux += "        AND SB1.D_E_L_E_T_ = ' ' "
            cQryAux += "    ) "
            cQryAux += " WHERE "
            cQryAux += "    SG1.R_E_C_N_O_ = "+cValToChar(aRecAlt[nAtual][1])+" "
            TCQuery cQryAux New Alias "QRY_AUX"
            cCodProd  := ""
            cDesProd  := ""
             
            //Se houver dados
            If !QRY_AUX->(EoF())
                cCodProd := QRY_AUX->G1_COMP
                cDesProd := QRY_AUX->DESCRICAO
            EndIf
            QRY_AUX->(DbCloseArea())
             
            //Se tiver produto e/ou descrição
            If !Empty(cCodProd) .Or. !Empty(cDesProd)
                //Alteração de Item
                If aRecAlt[nAtual][2] == 3
                    aAdd(aRegsInc, {cCodProd, cDesProd})
                     
                //Inclusão de Item
                ElseIf aRecAlt[nAtual][2] == 1
                    aAdd(aRegsAlt, {cCodProd, cDesProd})
                     
                //Exclusão de Item
                ElseIf aRecAlt[nAtual][2] == 2
                    aAdd(aRegsExc, {cCodProd, cDesProd})
                EndIf
            EndIf
        Next
         
        //Se tiver dados de alteração
        If Len(aRegsInc) > 0
            //cMsg += '<center><b>Inclus&atilde;o de Produtos:</b><br>'     
           // cMsg += '<center><b>Altera&ccedil;&&atilde;o de Produtos:</b><br>'   
			cMsg += '<center><b>Alteracao de Produtos:</b><br>'
            cMsg += '<table border="4" bordercolor=="#367feb" width="800px">'
            cMsg += '<tr>'
            cMsg += '<td width="20%" align="center" colspan="5" bgcolor="#050505"><b><font color="ffffff">C&oacute;digo</font></b></td>'
            cMsg += '<td width="80%" align="center" colspan="5" bgcolor="#050505"><b><font color="ffffff">Descri&ccedil;&atilde;o</font></b></td>'
            cMsg += '</tr>'
            For nAtual := 1 To Len(aRegsInc)
                cMsg += '<tr>'
                cMsg += '<td width="20%" colspan="5">'+aRegsInc[nAtual][1]+'</td>'
                cMsg += '<td width="80%" colspan="5">'+aRegsInc[nAtual][2]+'</td>'
                cMsg += '</tr>'
            Next
            cMsg += '</table>'
            cMsg += '</center>'
            cMsg += '<br><br>'
        EndIf
         
        //Se tiver dados de inclusão
        If Len(aRegsAlt) > 0
            //cMsg += '<center><b>Altera&ccedil;&&atilde;o de Produtos:</b><br>'       
            cMsg += '<center><b>Inclus&atilde;o de Produtos:</b><br>'
            cMsg += '<table border="4" bordercolor=="#367feb" width="800px">'
            cMsg += '<tr>'
            cMsg += '<td width="20%" align="center" colspan="5" bgcolor="#050505"><b><font color="ffffff">C&oacute;digo</font></b></td>'
            cMsg += '<td width="80%" align="center" colspan="5" bgcolor="#050505"><b><font color="ffffff">Descri&ccedil;&atilde;o</font></b></td>'
            cMsg += '</tr>'
            For nAtual := 1 To Len(aRegsAlt)
                cMsg += '<tr>'
                cMsg += '<td width="20%" colspan="5">'+aRegsAlt[nAtual][1]+'</td>'
                cMsg += '<td width="80%" colspan="5">'+aRegsAlt[nAtual][2]+'</td>'
                cMsg += '</tr>'
            Next
            cMsg += '</table>'
            cMsg += '</center>'
            cMsg += '<br><br>'
        EndIf
         
        //Se tiver dados de exclusão
        If Len(aRegsExc) > 0
            cMsg += '<center><b>Exclus&atilde;o de Produtos:</b><br>'
            cMsg += '<table border="4" bordercolor=="#367feb" width="800px">'
            cMsg += '<tr>'
            cMsg += '<td width="20%" align="center" colspan="5" bgcolor="#050505"><b><font color="ffffff">C&oacute;digo</font></b></td>'
            cMsg += '<td width="80%" align="center" colspan="5" bgcolor="#050505"><b><font color="ffffff">Descri&ccedil;&atilde;o</font></b></td>'
            cMsg += '</tr>'
            For nAtual := 1 To Len(aRegsExc)
                cMsg += '<tr>'
                cMsg += '<td width="20%" colspan="5">'+aRegsExc[nAtual][1]+'</td>'
                cMsg += '<td width="80%" colspan="5">'+aRegsExc[nAtual][2]+'</td>'
                cMsg += '</tr>'
            Next
            cMsg += '</table>'
            cMsg += '</center>'
            cMsg += '<br><br>'
        EndIf
         
        cMsg += '</font>'
        u_EnviarEmail(cEmAlter, "Alteração de Estrutura", cMsg)
     
    //Exclusão
    ElseIf nOperacao == 5
        cMsg := "<h1>Produto excluído na Estrutura - "+cProduto+".</h1><br><br>"+cMsg
        u_EnviarEmail(cEmAlter, "Exclusão de Estrutura", cMsg)   
   
   //Inclusão
    ElseIf nOperacao == 3
        cMsg := "<h1>Produto Incluido na Estrutura - "+cProduto+".</h1><br><br>"+cMsg
        u_EnviarEmail(cEmAlter, "Inclusão de Estrutura", cMsg)
    EndIf   
    
     
    RestArea(aArea)
Return

Return   Nil             


User function EnviarEmail(cDestino,cAssunto,cCorpo)

local cServer         := getMV('MV_RELSERV') //endereço SMTP
local lAutentic       := getMV('MV_RELAUTH') //utilize em caso de necessidade de autenticação
local cAccount        := getmv('MV_RELACNT') //conta
local cPassword       := getMV('MV_RELAPSW') //senha
local cMailDe  		  := getmv('MV_RELACNT')
LOcal cQL             := CHR(13) + CHR(10)
local cRemoteip       := Getclientip()
local cRemoteComputer := GetComputerName()
local lConectou       := .f.                     



// conecta com o servidor de e-mail
CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword Result lConectou
mailAuth(cAccount, cPassword)
If lConectou 
	
	SEND MAIL FROM "Bacio di Latte" TO cDestino SUBJECT cAssunto BODY cCorpo FORMAT TEXT RESULT lEnviado

   /*	if !lEnviado
			alert("ALERTA: Não foi possivel enviar a mensagem") //, pois ocorreu o seguinte erro: " + sMensagem + ".")
	else
		alert("E-mail transmitido com sucesso para " + cDestino +"!")
	endif  */

else
	alert("Não foi possivel executar sua solicitação, pois não houve resposta do servidor de e-mail."+cQL+cQL+"Informe ao Administrador do Sistema!")
	return .f.
Endif

DISCONNECT SMTP SERVER Result lDisConectou     

Return