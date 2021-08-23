#INCLUDE 'PROTHEUS.CH'

/*/
{Protheus.doc} PONROT01
Description

	Rotina tem como objetivo retirar flag de rejeição automática após leitura relogio de ponto

@param xParam Parameter Description
@return Nil
@author  - Douglas Silva
@since 06/12/2019
/*/

User Function PONROT01()

Private aPergs 	:= {}
Private aRet	    := {}

    aAdd( aPergs ,{1,"Apontamento De?"  ,Ctod(Space(8)),"","","","",50,.T.}) 
    aAdd( aPergs ,{1,"Apontamento Até?"  ,Ctod(Space(8)),"","","","",50,.T.}) 
    aAdd( aPergs ,{1,"Filial De?"  ,SPACE(4),"","","SM0","",50,.T.}) 
    aAdd( aPergs ,{1,"Filial Ate?" ,SPACE(4),"","","SM0","",50,.T.}) 
    aAdd( aPergs ,{1,"Matricula De?" ,SPACE(6),"","","SRA","",50,.T.}) 
    aAdd( aPergs ,{1,"Matricula Ate?" ,SPACE(6),"","","SRA","",50,.T.}) 

    If ParamBox(aPergs ,"Retira Flag Rejeição Aut ",aRet)
    
        Processa(  {|| ProcX1()  }	, 'Aguarde, Processando Correções...')	
    EndIf
    
Return    

Static Function ProcX1()

	Local nStatus
 
 	TCLink() //Inicia nova conexão banco de dados.
 	
 		cQuery := " UPDATE "+RETSQLNAME("SP8")+"  SET P8_MOTIVRG = '', P8_TPMCREP = '' " + CRLF
 		cQuery += " FROM "+RETSQLNAME("SP8")+" " + CRLF
 		cQuery += " WHERE " + CRLF 
 		cQuery += " 	P8_DATA BETWEEN '"+ DTOS(aRet[1]) +"' AND '"+ DTOS(aRet[2]) +"' " + CRLF
 		cQuery += " 	AND P8_FILIAL BETWEEN '"+ (aRet[3]) +"' AND '"+ (aRet[4]) +"' " + CRLF
 		cQuery += " 	AND P8_MAT BETWEEN '"+ (aRet[5]) +"' AND '"+ (aRet[6]) +"' " + CRLF 
 		cQuery += " 	AND P8_FLAG = 'E' " + CRLF 
 		cQuery += " 	AND P8_TPMCREP = 'D' " + CRLF
 		cQuery += " 	AND P8_APONTA = 'S' " + CRLF
 		cQuery += " 	AND D_E_L_E_T_ != '*' " + CRLF
 		
 		nStatus := 	TcSqlExec(cQuery)
			
		TcSqlExec("COMMIT")
 		
 		If (nStatus < 0)
			Alert("TCSQLError() " + TCSQLError())
		Else
			MsgInfo("Alteração concluída com sucesso, numero de registros " )
		EndIf
 	
 	TCUnlink()
 
Return