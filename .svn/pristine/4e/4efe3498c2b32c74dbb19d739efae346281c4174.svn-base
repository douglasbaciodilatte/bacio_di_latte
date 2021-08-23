#include    "protheus.ch"   
#include    "topconn.ch" 

/*/{Protheus.doc} User Function nomeFunction
   (long_description)
   @type  Function
   @author Dougals Rodrigues da Silva
   @since 29/09/2020
   @version version
   @param param_name, param_type, param_descr
   @return return_var, return_type, return_description
   @example
   (examples)
   @see (links_or_references)
   /*/

User Function B_GLtPA(_cVem1,_cVem2)
   
Local _cLote:=Space(15)
Local _xParametro:=GetMv('MV_RASTRO')
Local cSeg := "001"

   If Alltrim(_xParametro) = 'S'
      
      _cVem2:=If(Empty(_cVem2),Substr(Dtos(dDataBase),3,6),_cVem2)
         
         If INCLUI .AND. SB1->(DbSeek(xFilial()+_cVem1))
            
            If SB1->B1_RASTRO = 'L' .And. SC2->C2_FILIAL $ "0031|0072"

               //Verifica se está preenchdo o segmento
               If Empty(SB1->B1_XSEGMEN)
                  Alert("ATENÇÃO: Segmento cadastro de produto em branco")
               EndIf   

               //Verifica se está preenchdo o grupo lote
               If Empty(SB1->B1_XGRUPO2)
                  Alert("ATENÇÃO: Grupo lote em branco cadastro de produto")
               EndIf   
             
               cQuery := " SELECT B1_XBASEPR, COUNT(*) CONTA " + CRLF  
               cQuery += " FROM "+RETSQLNAME("SC2")+" SC2 " + CRLF  
               cQuery += " JOIN "+RETSQLNAME("SB1")+" SB1 ON SB1.B1_FILIAL = '' AND SB1.B1_COD = SC2.C2_PRODUTO AND SB1.D_E_L_E_T_ != '*' " + CRLF  
               cQuery += " WHERE SC2.C2_DATPRI = '"+DTOS( M->C2_DATPRI )+"' AND SC2.D_E_L_E_T_ != '*' AND B1_XBASEPR = '"+SB1->B1_XBASEPR+"' AND C2_SEQUEN = '001' " + CRLF  
               cQuery += " GROUP BY B1_XBASEPR " + CRLF  
               /*
               cQuery := ChangeQuery(cQuery)

               If Select("TMP") > 0
                  Dbselectarea("TMP")
                  TMP->(DbClosearea())
               EndIf
               
               TcQuery cQuery New Alias "TMP"
               */

               DBUSEAREA(.T.,"TOPCONN",TcGenQry(,,cQuery), "TMP", .F., .T.)

               If EMPTY(TMP->CONTA)
                  cSeg := "01"
               Else     
                  cSeg :=  STRZERO( TMP->CONTA + 1 ,2) 
               EndIf      

               TMP->(DbClosearea())

               //Monta composição no lote de produto
               _cLote := SB1->B1_XSEGMEN + GravaData( M->C2_DATPRI ,.F.,2 ) + SB1->B1_XGRUPO2 + cSeg         

               //Gera aviso na tela
               AVISO("Numeração de Lote", "Lote " + _cLote, , 2)
               M->C2_XLOTE := _cLote
              
            Endif         
         
         EndIf       
   Endif  

Return(_cLote)

/*/{Protheus.doc} User Function nomeFunction
   (long_description)
   @type  Function
   @author Douglas Rodrigues da Silva
   @since 29/09/2020
   @version version
   @param param_name, param_type, param_descr
   @return return_var, return_type, return_description
   @example
   (examples)
   @see (links_or_references)
   /*/

User Function B_GVldPA(_cVem1,_cVem2)

   Local _dValidade:=CtoD("//")
   Local _xParametro:=GetMv('MV_RASTRO')

   If Alltrim(_xParametro) = 'S'
      
      _cVem2:=If( Empty(_cVem2), dTos(Date()) , _cVem2)
      
      If INCLUI .AND. SB1->(DbSeek(xFilial()+_cVem1))
         If SB1->B1_RASTRO = 'L'
            _dValidade := STOD(_cVem2) + SB1->B1_PRVALID
         Endif
      Endif
   Endif

Return(_dValidade)
