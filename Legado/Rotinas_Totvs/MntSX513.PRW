#INCLUDE "Protheus.ch"
#INCLUDE "Topconn.ch"
  
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSPDR0001  บ Autor ณ EVERTON FORTI      บ Data ณ  10/04/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณRelat๓rio contendo as informa็๕es do livro fiscal para      บฑฑ
ฑฑบ          ณauxiliar na confer๊ncia do SPED Pis/Cofins                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณLivros Fiscais 									          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

//INCLUSรO DE NOVOS GRUPOS DE TRIBURAวรO - TABELA 13 DA SX5
User Function MntSX513()
       Local aArea := GetArea()
       dbselectarea("SX5")
       dbSetOrder(1)
       Set filter to X5_TABELA = "13"
       AxCadastro("SX5","Cadastro de CFOP")
       Set Filter to
       RestArea(aArea)
Return

//INCLUIR NO X3_WHEN DOS CAMPOS X5_TABELA E X5_CHAVE
!(FUNNAME()=="MNTSX513")                                    

//INCLUIR NO X3_RELACAO DO CAMPO X5_TABELA
IIF(FUNNAME()=="MNTSX513","13",.T.)

//INCLUIR NO X3_VLDUSER DO CAMPO X5_DESCRI                                    	
IIF(FUNNAME()=="MNTSX513",U_ProxSX513(),.T.)

User Function ProxSX513()
       Local aArea   := GetArea()
       Local cCodigo := ''
       
       cSql := "SELECT MAX(X5_CHAVE) AS CODIGO FROM "+RetSqlName("SX5")
       cSql += " WHERE D_E_L_E_T_<>'*' "
       cSql += " AND X5_TABELA = '13' "
       TcQuery cSql NEW ALIAS "_QRY"
       
       If Empty(_QRY->CODIGO)
         cCodigo := '0000'
       Else                        
         cCodigo := Soma1(Alltrim(_QRY->CODIGO)) 
       Endif           
       _QRY->(dbclosearea())
       
       M->X5_CHAVE := cCodigo
                                                     
       RestArea(aArea)                
Return .T.
