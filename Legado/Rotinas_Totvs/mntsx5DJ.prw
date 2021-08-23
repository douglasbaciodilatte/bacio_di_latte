#INCLUDE "Protheus.ch"
#INCLUDE "Topconn.ch"
  
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณSPDR0001  บ Autor ณ ANDREZA DUARTE      บ Data ณ  06/12/13   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณRelat๓rio contendo as informa็๕es do livro fiscal para      บฑฑ
ฑฑบ          ณauxiliar na confer๊ncia do SPED Pis/Cofins                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณLivros Fiscais 									          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

//INCLUSรO DE NOVOS GRUPOS DE TRIBURAวรO - TABELA DJ DA SX5
User Function MntSX5DJ()
       Local aArea := GetArea()
       dbselectarea("SX5")
       dbSetOrder(1)
       Set filter to X5_TABELA = "DJ"
       AxCadastro("SX5","Grupo Tributario")
       Set Filter to
       RestArea(aArea)
Return

//INCLUIR NO X3_WHEN DOS CAMPOS X5_TABELA E X5_CHAVE
!(FUNNAME()=="MNTSX5DJ")                                    

//INCLUIR NO X3_RELACAO DO CAMPO X5_TABELA
IIF(FUNNAME()=="MNTSX5DJ","DJ",.T.)

//INCLUIR NO X3_VLDUSER DO CAMPO X5_DESCRI                                    	
IIF(FUNNAME()=="MNTSX5DJ",U_ProxSX5DJ(),.T.)

User Function ProxSX5DJ()
       Local aArea   := GetArea()
       Local cCodigo := ''
       
       cSql := "SELECT MAX(X5_CHAVE) AS CODIGO FROM "+RetSqlName("SX5")
       cSql += " WHERE D_E_L_E_T_<>'*' "
       cSql += " AND X5_TABELA = 'DJ' "
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
