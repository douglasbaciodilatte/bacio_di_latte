#include 'protheus.ch'
#include 'Restful.ch'
#include 'tbiconn.ch'
#INCLUDE "TopConn.ch"

/*/{Protheus.doc} User Function REST010
    (long_description)
    @type  Function
    @author Douglas Rodrigues da Silva
    @since 17/04/2020
    @version 1.0
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

User Function REST011()
Return 

WSRESTFUL Gestor_Inventario DESCRIPTION "RestFul Gestor Lojas Inventario" FORMAT "application/json"

    WSDATA apiKey AS STRING  //PARAMETRO COM A CHAVE PARA AUTENTICACAO

    WSMETHOD GET DESCRIPTION "Gestor Lojas Base de dados" WSSYNTAX "/Gestor_Inventario/{}"
    WSMETHOD POST DESCRIPTION "Gestor Lojas Post Inventario" WSSYNTAX "/Gestor_Inventario/{}"

END WSRESTFUL

WSMETHOD GET WSSERVICE Gestor_Inventario

    Local lRet          := .T.
    Local oResponse     := JsonObject():New()
    Local apiKeyAuth	:= ::apiKey
    Local lLoginOk      := SuperGetMV("MV_XAPIKEY",.F.,"1234") == apiKeyAuth
    Local nLin          := 1
    Local cAmbinetes    := ""
    Local aAmbientes
    Private oJsonlj     := JsonObject():New()
    Private oJsonNFT    := JsonObject():New()  

     If Valtype(apiKeyAuth) == 'U'
        SetRestFault(400, 'Informe a chave token! ' + apiKeyAuth)
        lRet := .F.
    EndIf       

    if !lLoginOk
    	SetRestFault(403,"Falha durante o login, verifique a chave " + apiKeyAuth )	
	    return .F.
    endif

    If Intransaction()
        DisarmTransaction()
        SetRestFault(500, '{"erro - Thread em Aberto"}')
        ConOut("Erro - Thread em aberto...")   
        return .F.
    EndIf

    ::SetContentType('application/json')

    //Montagem Json Ambientes
    oResponse['ambientes']  := {}

    For nLin := 1 To 5

        oJsonAmb := JsonObject():New()   

        If nLin == 1
            oJsonAmb['id']      := '1'
            oJsonAmb['desc']    := "Camara fria"   
        ElseIf nLin == 2
            oJsonAmb['id']      := '2'
            oJsonAmb['desc']    := "Deposito"
        ElseIf nLin == 3
            oJsonAmb['id']      := '3'
            oJsonAmb['desc']    := "Estoque"
        ElseIf nLin == 4    
            oJsonAmb['id']      := '4'
            oJsonAmb['desc']    := "Freezer" 
        ElseIf nLin == 5   
            oJsonAmb['id']      := '5'
            oJsonAmb['desc']    := "Loja Vitrine"
        EndIf               
     
        aAdd(oResponse['ambientes'], oJsonAmb)
    Next
  
    oResponse['lojas']  := {}
    
    NNR->(DbSetOrder(1))
	NNR->(DbGoTop())
	Do While NNR->(!Eof())

            oJsonlj     := JsonObject():New()
                  
            If NNR->NNR_CODIGO != '000001' .And. NNR->NNR_XINV == 'S' 

                //Rotina para envio de produtos:

                //U_BDINVA01(NNR->NNR_FILIAL, NNR->NNR_CODIGO, .T.)        

                //Verifica se Aramz??m vai para invent??rio e est?? desbloqueado
                oJsonlj['filial_loja']  := NNR->NNR_FILIAL
                oJsonlj['codigo_Loja']	:= NNR->NNR_CODIGO
                oJsonlj['nome_loja']	:= Alltrim(NNR->NNR_DESCRI)
                oJsonlj['bloqueado']    := IIF(NNR->NNR_MSBLQL == "S", "1","2")                            
                
                cAmbinetes := ""
                /*
                If  NNR->NNR_XACA == '1'
                    cAmbinetes  += '1,'
                EndIf    
                
                If NNR->NNR_XADE == '1'
                    cAmbinetes +=  '2,'
                EndIf    
                */
                If NNR->NNR_XAES == '1'
                    cAmbinetes += '3,'
                EndIf    
                /*
                If NNR->NNR_XAFR == '1'
                    cAmbinetes += '4,'
                EndIf    
                
                If NNR->NNR_XALV == '1'
                    cAmbinetes += '5'  
                EndIf    
                */
                aAmbientes := SEPARA (cAmbinetes, ',', .f.)

                oJsonlj['ambientes']    := aAmbientes                         
                
                //Programa para buscar NF-es
                
                oJsonNFT := JsonObject():New()
                oJsonNFT    := {} 

                /*    
                    cQuery := " SELECT " + CRLF 
                    cQuery += " RTRIM(A.XML_NOMEMT) AS 'FORNECE', " + CRLF
                    cQuery += " SUBSTRING(RTRIM(A.XML_NUMNF),4,9) AS 'NUMERO', " + CRLF
                    cQuery += " RTRIM(A.XML_CHAVE) AS 'CHAVE' " + CRLF
                    cQuery += " FROM RECNFXML A " + CRLF
                    cQuery += " JOIN RECNFSINCXM B ON A.XML_CHAVE = B.XML_CHAVE and B.D_E_L_E_T_ != '*' " + CRLF
                    cQuery += " WHERE  " + CRLF
                    cQuery += " A.D_E_L_E_T_ != '*' " + CRLF
                    cQuery += " AND SUBSTRING(XML_DEST,9,4) = '"+NNR->NNR_FILIAL+"' " + CRLF
                    cQuery += " AND SUBSTRING(XML_EMISSA,1,4) >=  '2020'  " + CRLF
                    cQuery += " AND XML_LANCAD = '' " + CRLF

                    dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery ),"TRB",.F.,.T.)
	
                    Do While TRB->(!EOF())

                        oJsonNFD := JsonObject():New()
                        oJsonNFD['fornecedor']  := Alltrim(TRB->FORNECE)
                        oJsonNFD['numero']      := Alltrim(TRB->NUMERO)
                        oJsonNFD['chave']       := Alltrim(TRB->CHAVE)

                        aAdd(oJsonNFT, oJsonNFD)

                        TRB->(dbSkip())
                    Enddo                                 

                    TRB->(dbCloseArea())	
                */
                oJsonlj['nf_pendente'] := oJsonNFT 

                aAdd(oResponse['lojas'], oJsonlj)

            EndIf    

		NNR->(DbSkip())
	EndDo
   
    oResponse['produtos']  := {}

    cQuery := " SELECT * " + CRLF
	cQuery += " FROM "+RETSQLNAME("SB1")+" SB1 " + CRLF 
	cQuery += " WHERE D_E_L_E_T_ != '*' AND B1_XLISTA = '2' AND B1_FILIAL = '' " + CRLF
	cQuery += " ORDER BY B1_TIPO " + CRLF

    If Select("SQL") > 0
		Dbselectarea("SQL")
		SQL->(DbClosearea())
	EndIf
	
	TcQuery cQuery New Alias "SQL"
    
    SQL->(DbGoTop())
    Do While SQL->(!Eof())     
     
            SB1->(DbSelectArea("SB1"))
            SB1->(DbSetOrder(1))

            If SB1->(DBSeek( xFilial("SB1") + SQL->B1_COD ))
                
                oJsonSB1 := JsonObject():New()

                oJsonSB1['codigo_produto']  := SB1->B1_COD
                oJsonSB1['descricao_prod']	:= Alltrim(SB1->B1_DESC)
                oJsonSB1['descricao_inve']	:= Alltrim(SB1->B1_DESC)
                oJsonSB1['mostra_inventario']:= IIF(SB1->B1_XLISTA == '2', '1', '2')

                    //Monta Json Grupos

                    oJsonGRP := JsonObject():New()
                    oJsonAGL := JsonObject():New()
                    oJsonAGL := {}   
            
                    oJsonGRP := JsonObject():New()
                    oJsonGRP['id']      := '3'
                    oJsonGRP['unidade'] := SB1->B1_UM
                    oJsonGRP['conv']    := SB1->B1_CONV
                    aAdd(oJsonAGL, oJsonGRP)
                                               
                
                oJsonSB1['ambientes']    := oJsonAGL

                oJsonSB1['grupo1']      := '3'
                
                oJsonSB1['grupo2']      := '99'

                aAdd(oResponse['produtos'], oJsonSB1)
                                    
         EndIf
        
        SQL->(DbSkip())
    EndDo

    //Cria Tabela de grupo1
    oResponse['grupo1']  := {}
    For nLin := 1 To 5

        oJson1GPR := JsonObject():New()

         If nLin== 1
            oJson1GPR['id']     := '1'
            oJson1GPR['desc']   := 'Cafes & Doces'
        ElseIf nLin == 2
            oJson1GPR['id']     := '2'
            oJson1GPR['desc']   := 'Embalagens'
        ElseIf nLin == 3
            oJson1GPR['id']     := '3'
            oJson1GPR['desc']   := 'Gelato'
        ElseIf nLin == 4
            oJson1GPR['id']     := '4'
            oJson1GPR['desc']   := 'Insumos'
        ElseIf nLin == 5
            oJson1GPR['id']     := '5'
            oJson1GPR['desc']   := 'Outros'
         EndIf

        aAdd(oResponse['grupo1'], oJson1GPR)

    Next 
    
    oResponse['grupo2']  := {}

    SX5->(dbSelectArea("SX5"))
    SX5->(dbSetOrder(1))
    SX5->(dbSeek( xFilial("SX5") + "Z3"))

    Do While SX5->(!EOF() .And. SX5->X5_TABELA == "Z3")

        oJsonSX5 := JsonObject():New()
        
        oJsonSX5['Codigo']      := Alltrim(SX5->X5_CHAVE)
        oJsonSX5['Descricao']	:= Alltrim(SX5->X5_DESCRI)

         aAdd(oResponse['grupo2'], oJsonSX5)	

        SX5->(dbSkip())
    Enddo  
  
             
    oResponse['bloqueados']  := {}
    /*
    ZZ3->(dbSelectArea("ZZ3"))
    ZZ3->(dbSetOrder(1))
    ZZ3->(dbGoTop())
    
    Do While ZZ3->(!EOF() )

        oJsonZZ3 := JsonObject():New()
        
        oJsonZZ3['filial']      := ZZ3->ZZ3_FILIAL
        oJsonZZ3['codigo']	    := ZZ3->ZZ3_COD
        oJsonZZ3['loja']	    := ZZ3->ZZ3_LOCAL

         aAdd(oResponse['bloqueados'], oJsonZZ3)	

        ZZ3->(dbSkip())
    Enddo    
    */
    ::SetResponse(oResponse:toJson())

Return lRet 

WSMETHOD POST WSSERVICE Gestor_Inventario

    Local lPost     := .T.
    Local cJson     := ::getContent()
    Local oResponse := JsonObject():New()
    Local oItens
	  
    Local nCampo1 := TamSx3("ZZ4_FILIAL")[1]
    Local nCampo2 := TamSx3("ZZ4_COD")[1]
    Local nCampo3 := TamSx3("ZZ4_LOJA")[1]
    Local nCampo4 := TamSx3("ZZ4_DOC")[1]

    Local aProdGrv  := {}
    Local cHoraIni
    Local dDataIni
    Local nOK := 0 
    Local nDP := 0
    Local nER := 0
    
    Private lMsErroAuto     := .F.
    Private oJson
    Private aDados    := {}

    Private cXFilial := ""
    Private cXCod    := ""
    Private cXLocal  := ""
    Private xXDoc    := ""
    Private xXGrupo  := ""
    Private xXAmbien := ""
    Private xXData   := ""
    Private xXValor  := 0
    Private xXUnida  := ""

    /*
    {
	"filial": "0001",
	"loja": "000101",
	"documento": "20200625",
	"idata": "20200625",
	"itens":[{
		"produto": "MP208009001136",
		"valor": 1,
		"ambiente":"Camara fria",
		"grupo":"Cafes & Doces",
		"unidade":"UN"
	}]
    }		
    */
    
    oJson   := JsonObject():New()
    cError  := oJson:FromJson(cJson)
    //Se tiver algum erro no Parse, encerra a execu??????o
    IF .NOT. Empty(cError)
        SetRestFault(500,'Parser Json Error')
        lRet    := .F.
    Else
    
        ZZ4->(dbSelectArea("ZZ4"))
        ZZ4->(dbSetOrder(1)) 
        
        dDataIni    := Date()
        cHoraIni    := Time()

        oItens  := oJson:GetJsonObject('itens')
            
        For i:=1 To Len(oItens)
            
            aDados := {}

            cXFilial    := Alltrim( oJson:GetJsonObject('filial') ) + SPACE(nCampo1 - Len ( Alltrim( oJson:GetJsonObject('filial') ) ))
            cXLocal     := Alltrim( oJson:GetJsonObject('loja') ) + SPACE(nCampo3 - Len ( Alltrim( oJson:GetJsonObject('loja') )) )                        
            xXDoc       := Alltrim( oJson:GetJsonObject('documento') ) + SPACE(nCampo4 - Len ( Alltrim( oJson:GetJsonObject('documento') )) )
            xXData      := CTOD( SUBSTR(xXDoc,7,2) + "/" + SUBSTR(xXDoc,5,2) + "/" + SUBSTR(xXDoc,3,2) )
            
            cXCod       := Alltrim( oItens[i]:GetJsonObject('produto') ) + SPACE(nCampo2 - Len ( Alltrim( oItens[i]:GetJsonObject('produto') )) )            
            xXGrupo     := oItens[i]:GetJsonObject('grupo') 
            xXAmbien    := oItens[i]:GetJsonObject('ambiente')             
            xXValor     := oItens[i]:GetJsonObject('valor')
            xXUnida     := oItens[i]:GetJsonObject('unidade')

            ZZ4->(dbSetOrder(1)) //ZZ4_FILIAL+ZZ4_LOJA+ZZ4_COD+ZZ4_DOC+ZZ4_GRUPO+ZZ4_AMBIEN
            
            If ! ZZ4->(dbSeek( cXFilial + cXLocal + cXCod + xXDoc + xXGrupo + xXAmbien))
                
                lMsErroAuto := GRAVAZZ4(aDados)
                                            
                If lMsErroAuto
                    nOK++
                    aAdd( aProdGrv , {"OK", (cXFilial + "|" + xXDoc + "|" + cXCod + "|" + cXLocal) } )   
                else
                    aAdd( aProdGrv , {"ER", (cXFilial + "|" + xXDoc + "|" + cXCod + "|" + cXLocal) } )   
                    nER++
                EndIf  

            Else
                aAdd( aProdGrv , {"DP", (cXFilial + "|" + xXDoc + "|" + cXCod + "|" + cXLocal) } )
                nDP++
            EndIf    
                                 
        Next i       
        
        oResponse['aproc']      := "OK " + cValTochar(nOK) + " DP " + cValTochar(nDP) + " ER " + cValTochar(nER) + " total " + cValTochar(Len(oItens))
        oResponse['data']       := "inicio " + DTOC(dDataIni) + " fim " + DTOC( Date() )
        oResponse['hora']       := "inicio " + cHoraIni + " fim " + Time()
        oResponse['mensagem']   := "rotina concluida com sucesso"
        oResponse['Prod']       := { aProdGrv }

    EndIf
    
    ::SetResponse( oResponse:toJson() )
    ConOut(oResponse:toJson())

Return lPost

/*/{Protheus.doc} GRAVASB7
    (long_description)
    @type  Static Function
    @author user
    @since 30/06/2020
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/

Static Function GRAVAZZ4(aDados)

    Local lRet := .T.

    //Inicia grava??o tabela SB7

    //Busca Cadastro de produto

    SB1->(DBSelectArea("SB1"))
    SB1->(DBSetOrder(1)) 

    If SB1->(dbSeek (xFilial("SB1") + cXCod))

       //Busca nome da Loja
       NNR->(dbSelectArea("NNR"))     
       NNR->(dbSetOrder(1))
       NNR->(dbSeek( cXFilial + cXLocal ))
       
       RecLock("ZZ4", .T.)

            ZZ4->ZZ4_FILIAL := cXFilial           
            ZZ4->ZZ4_LOJA   := cXLocal
            ZZ4->ZZ4_NOME   := NNR->NNR_DESCRI
            ZZ4->ZZ4_COD    := cXCod
            ZZ4->ZZ4_DESC   := SB1->B1_DESC
            ZZ4->ZZ4_DOC    := xXDoc
            ZZ4->ZZ4_DATA   := xXData
            ZZ4->ZZ4_VALOR  := xXValor
            ZZ4->ZZ4_UM     := xXUnida
            ZZ4->ZZ4_GRUPO  := xXGrupo
            ZZ4->ZZ4_AMBIEN := xXAmbien
            ZZ4->ZZ4_DTIN   := DATE()
            ZZ4->ZZ4_HRIN   := TIME()
            
        MsUnLock() 

    EndIf    
   
Return lRet
