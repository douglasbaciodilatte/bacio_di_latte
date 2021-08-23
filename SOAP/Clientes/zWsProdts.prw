//Bibliotecas
#Include "Protheus.ch"
#Include "APWebSrv.ch"
#Include "TBIConn.ch"
#Include "TBICode.ch"
#Include "TopConn.ch"
#Include "aarray.ch"
#Include "json.ch"
#Include "shash.ch"

WsService zWsProdts Description "WebService com funcoes de Produtos Protheus"

	WsData   cFiltRece as String
	WsData   cFiltSend as String

	//M�todos
	WsMethod zWsProdutos    Description "Metodo para retornar uma lista de Produtos Protheus"

EndWsService

WsMethod zWsProdutos WsReceive cFiltRece WsSend cFiltSend WsService zWsProdts

    //Retorno do M�todo RetListCli (.T. se est� tudo certo ou .F. se houve falha)
	Local lRet       := .T.
	
	//Vari�vel de Token pegando da tabela SX6
	Local cTokWs    := Alltrim(GetMV('MV_X_TOKEN'))
	
	//Vari�veis usadas para transformar o JSON em Objeto
	Private oJSON    := Nil
	
    //Deserializando o JSON (transformando a "string" em "objeto")
	If (FWJsonDeserialize(::cFiltRece, @oJSON))
		
        //Separando o objeto de dados, e o Token
		cParToken  := Iif(Type("oJSON:Token") != "U", oJSON:Token, "")
		
        //Se o Token recebido for o mesmo do par�metro, prossegue
		If cParToken == cTokWs
					
            SB1->(DBSelectArea("SB1"))
            SB1->(dbSetOrder(1))

            //Come�a a montar o JSON de retorno
			::cFiltSend += '{"Produtos" : [ '    + CRLF
			
			SB1->(dbGoTop())

            Do While SB1->(!EOF())
                             
                    ::cFiltSend +=           '   { ' + CRLF
					::cFiltSend +=           '     "Codigo":"'      + Alltrim(SB1->B1_COD)    + '", '   + CRLF
					::cFiltSend +=           '     "Tipo":"'      	+ Alltrim(SB1->B1_TIPO)    + '", '   + CRLF
					::cFiltSend +=           '     "Descricao":"'  	+ Alltrim(SB1->B1_DESC) + '" '   + CRLF				
					::cFiltSend +=           '   }'
                               
                SB1->(dbSkip())
                
                If ! SB1->(EoF())
					::cFiltSend += ','
				EndIf
				
				::cFiltSend += CRLF
            Enddo    
            
            ::cFiltSend += '  ] '     + CRLF
		    ::cFiltSend += ' }'       + CRLF
           
		EndIf
		
	EndIf

Return lRet
