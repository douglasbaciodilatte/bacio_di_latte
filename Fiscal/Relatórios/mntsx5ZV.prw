#INCLUDE "Protheus.ch"
#INCLUDE "Topconn.ch"
  
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SPDR0001  � Autor � ANDREZA DUARTE      � Data �  06/12/13   ���
�������������������������������������������������������������������������͹��
���Descricao �Relat�rio contendo as informa��es do livro fiscal para      ���
���          �auxiliar na confer�ncia do SPED Pis/Cofins                  ���
�������������������������������������������������������������������������͹��
���Uso       �Livros Fiscais 									          ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

//INCLUS�O DE NOVOS GRUPOS DE TRIBURA��O - TABELA ZV DA SX5
User Function MntSX5ZV()
       Local aArea := GetArea()
       dbselectarea("SX5")
       dbSetOrder(1)
       Set filter to X5_TABELA = "ZV"
       AxCadastro("SX5","Grupo Tributario")
       Set Filter to
       RestArea(aArea)
Return

//INCLUIR NO X3_WHEN DOS CAMPOS X5_TABELA E X5_CHAVE
!(FUNNAME()=="MNTSX5ZV")                                    

//INCLUIR NO X3_RELACAO DO CAMPO X5_TABELA
IIF(FUNNAME()=="MNTSX5ZV","ZX",.T.)

//INCLUIR NO X3_VLDUSER DO CAMPO X5_DESCRI                                    	
IIF(FUNNAME()=="MNTSX5ZV",U_ProxSX5ZV(),.T.)

User Function ProxSX5ZV()
       Local aArea   := GetArea()
       Local cCodigo := ''
       
       cSql := "SELECT MAX(X5_CHAVE) AS CODIGO FROM "+RetSqlName("SX5")
       cSql += " WHERE D_E_L_E_T_<>'*' "
       cSql += " AND X5_TABELA = 'ZV' "
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
