#Include "Rwmake.ch"
#Include "TopConn.Ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FLAGCTB  บAutor  ณDouglas Silva       บ Data ณ  29/10/2019 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Visa efetuar a limpeza dos flags marcados no lancamento   บฑฑ
ฑฑบ          ณ  contabil de acordo com os parametros informados pelo      บฑฑ
ฑฑบ          ณ  usuario.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function DBCTBR01()

Private _cHlp  := "FLAGCTB"
Private _lPerg := .F.
Private _oTela

Pergunte(Padr(_cHlp,10),.T.)

@ 001,001 TO 200,400 DIALOG _oTela TITLE OemToAnsi("LIMPA FLAG REGISTROS CONTมBIL")
@ 005,005 TO 095,195
@ 010,018 Say "   Este programa efetuara a limpeza dos registros marcados pela"
@ 020,018 Say " rotina de processamento contแbil."
@ 040,018 Say " Obs.: Essa rotina nใo exclui os lan็amentos na contabilidade "
@ 050,018 Say " somente efetua a desmarca็ใo dos registros para posterior"
@ 060,018 Say " reprocessamento. Devendo o usuแrio excluir os lan็amentos."
@ 070,098 BMPBUTTON TYPE 02 ACTION Close(_oTela) //Fechar
@ 070,128 BMPBUTTON TYPE 01 ACTION  Processa( {|lEnd|  fExecuta(), Close(_oTela)  }, "DBCTBR01","Processando aguarde...", .T. )      //Executa
@ 070,158 BMPBUTTON TYPE 05 ACTION fHelp()		 //Parametros
Activate Dialog _oTela Centered

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FLAGCTB  บAutor  ณDouglas Silva       บ Data ณ  29/10/2019 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Visa efetuar a limpeza dos flags marcados no lancamento   บฑฑ
ฑฑบ          ณ  contabil de acordo com os parametros informados pelo      บฑฑ
ฑฑบ          ณ  usuario.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fHelp()

If Pergunte(Padr(_cHlp,10),.T.)
	_lPerg    := .T.
EndIf

Return()

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ FLAGCTB  บAutor  ณDouglas Silva       บ Data ณ  29/10/2019 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ  Visa efetuar a limpeza dos flags marcados no lancamento   บฑฑ
ฑฑบ          ณ  contabil de acordo com os parametros informados pelo      บฑฑ
ฑฑบ          ณ  usuario.                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function fExecuta

Local cSQL
Local cNmPrg 	:= "Limpa Flag CTB"
Local cOk    	:= "Execu็ใo concluํda com sucesso!"
Local cErro  	:= "Ocorreu um erro na atualizacao!"
Local lErro  	:= .F.
Local nErro		:= 0	

Do Case

	Case MV_PAR05 == 1 //Documento de saida
		
		TCLink() //Inicia nova conexใo banco de dados.
			
			cSQL := " UPDATE "+RetSqlName("SF2")+" SET F2_DTLANC = ''"
			cSQL += " WHERE D_E_L_E_T_ = ''"
			cSQL += " AND F2_FILIAL  BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'"
			cSQL += " AND F2_EMISSAO BETWEEN '"+Dtos(MV_PAR03)+"' AND '"+Dtos(MV_PAR04)+"'"
			cSQL += " AND F2_DOC     BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR07+"'"
			cSQL += " AND F2_SERIE   BETWEEN '"+MV_PAR08+"' AND '"+MV_PAR09+"'"		
			
			nErro := TcSqlExec(cSQL)
			TcSqlExec("COMMIT")
			lErro := iIf(nErro == 0,.F.,.T.)
		TCUnlink()
			
	Case MV_PAR05 == 2 //Documento de Entrada
		
		TCLink() //Inicia nova conexใo banco de dados.
			
			cSQL := " UPDATE "+RetSqlName("SF1")+" SET F1_DTLANC = ''"
			cSQL += " WHERE D_E_L_E_T_ = ''"
			cSQL += " AND F1_FILIAL  BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'"
			cSQL += " AND F1_DTDIGIT BETWEEN '"+Dtos(MV_PAR03)+"' AND '"+Dtos(MV_PAR04)+"'"
			cSQL += " AND F1_DOC     BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR07+"'"
			cSQL += " AND F1_SERIE   BETWEEN '"+MV_PAR08+"' AND '"+MV_PAR09+"'"				
			
			nErro := TcSqlExec(cSQL)
			TcSqlExec("COMMIT")
			lErro := iIf(nErro == 0,.F.,.T.)			
		TCUnlink()
		
	Case MV_PAR05 == 3 //Financeiro CR
		
		TCLink() //Inicia nova conexใo banco de dados.
			cSQL := " UPDATE "+RetSqlName("SE1")+" SET E1_LA = ''"
			cSQL += " WHERE D_E_L_E_T_ = ''"
			cSQL += " AND E1_FILIAL  BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'"
			cSQL += " AND E1_EMIS1   BETWEEN '"+Dtos(MV_PAR03)+"' AND '"+Dtos(MV_PAR04)+"'"
			cSQL += " AND E1_NUM     BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR07+"'"
			cSQL += " AND E1_PREFIXO BETWEEN '"+MV_PAR08+"' AND '"+MV_PAR09+"'"						
			
			nErro := TcSqlExec(cSQL)
			TcSqlExec("COMMIT")
			lErro := iIf(nErro == 0,.F.,.T.)			
		
			cSQL := " UPDATE "+RetSqlName("SE5")+" SET E5_LA = ''"
			cSQL += " WHERE D_E_L_E_T_ = ''"
			cSQL += " AND E5_FILIAL BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'"
			cSQL += " AND E5_DATA   BETWEEN '"+Dtos(MV_PAR03)+"' AND '"+Dtos(MV_PAR04)+"'"
			cSQL += " AND E5_NUMERO BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR07+"'"
			cSQL += " AND E5_PREFIXO BETWEEN '"+MV_PAR08+"' AND '"+MV_PAR09+"'"				
			cSQL += " AND E5_RECPAG = 'R'"
			
			nErro := TcSqlExec(cSQL)
			TcSqlExec("COMMIT")
			lErro := iIf(nErro == 0,.F.,.T.)
		TCUnlink()
		
	Case MV_PAR05 == 4 //Financeiro CP	
		
		If ! lErro
			
			TCLink() //Inicia nova conexใo banco de dados.
				cSQL := " UPDATE "+RetSqlName("SE2")+" SET E2_LA = ''"
				cSQL += " WHERE D_E_L_E_T_ = ''"
				cSQL += " AND E2_FILIAL BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'"
				cSQL += " AND E2_EMIS1  BETWEEN '"+Dtos(MV_PAR03)+"' AND '"+Dtos(MV_PAR04)+"'"
				cSQL += " AND E2_NUM     BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR07+"'"
				cSQL += " AND E2_PREFIXO BETWEEN '"+MV_PAR08+"' AND '"+MV_PAR09+"'"				
				
				nErro := TcSqlExec(cSQL)
				TcSqlExec("COMMIT")
				lErro := iIf(nErro == 0,.F.,.T.)
			
				cSQL := " UPDATE "+RetSqlName("SE5")+" SET E5_LA = ''"
				cSQL += " WHERE D_E_L_E_T_ = ''"
				cSQL += " AND E5_FILIAL BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'"
				cSQL += " AND E5_DATA   BETWEEN '"+Dtos(MV_PAR03)+"' AND '"+Dtos(MV_PAR04)+"'"
				cSQL += " AND E5_NUMERO BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR07+"'"
				cSQL += " AND E5_PREFIXO BETWEEN '"+MV_PAR08+"' AND '"+MV_PAR09+"'"		
				cSQL += " AND E5_RECPAG = 'P'"		
				
				nErro := TcSqlExec(cSQL)
				TcSqlExec("COMMIT")
				lErro := iIf(nErro == 0,.F.,.T.)
			
				cSQL := " UPDATE "+RetSqlName("SEV")+" SET EV_LA = ' ' "
				cSQL += " FROM "+RetSqlName("SEV")+" SEV "
				//cSQL += " JOIN "+RetSqlName("SE5")+" SE5 ON SEV.EV_FILIAL = SE5.E5_FILIAL AND SE5.E5_IDORIG = SEV.EV_IDDOC AND SEV.D_E_L_E_T_ != '*' "
				cSQL += " JOIN "+RetSqlName("SE5")+" SE5 ON SEV.EV_FILIAL = SE5.E5_FILIAL AND SE5.E5_NUMERO = SEV.EV_NUM AND SE5.E5_PREFIXO = SEV.EV_PREFIXO AND SE5.E5_FORNECE = SEV.EV_CLIFOR AND SE5.E5_LOJA = SEV.EV_LOJA AND SEV.D_E_L_E_T_ != '*'"
				cSQL += " WHERE E5_DATA BETWEEN '"+Dtos(MV_PAR03)+"' AND '"+Dtos(MV_PAR04)+"' "
				cSQL += " AND E5_FILIAL BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'"
				cSQL += " AND E5_NUMERO BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR07+"'"
				cSQL += " AND SE5.D_E_L_E_T_ != '*' "
				cSQL += " AND SEV.EV_FILIAL = '' "
				cSQL += " AND SE5.E5_RECPAG = 'P' "
			
				nErro := TcSqlExec(cSQL)
				TcSqlExec("COMMIT")
				lErro := iIf(nErro == 0,.F.,.T.)
			
				cSQL := " UPDATE "+RetSqlName("SEZ")+" SET EZ_LA = ' ' "
				cSQL += " FROM "+RetSqlName("SEZ")+" SEZ "
				cSQL += " JOIN "+RetSqlName("SE5")+" SE5 ON SEZ.EZ_FILIAL = SE5.E5_FILIAL AND SE5.E5_NUMERO = SEZ.EZ_NUM AND SE5.E5_PREFIXO = SEZ.EZ_PREFIXO AND SE5.E5_FORNECE = SEZ.EZ_CLIFOR AND SE5.E5_LOJA = SEZ.EZ_LOJA AND SEZ.D_E_L_E_T_ != '*' ""
				cSQL += " WHERE E5_DATA BETWEEN '"+Dtos(MV_PAR03)+"' AND '"+Dtos(MV_PAR04)+"' "
				cSQL += " AND E5_FILIAL BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'"
				cSQL += " AND E5_NUMERO BETWEEN '"+MV_PAR06+"' AND '"+MV_PAR07+"'"
				cSQL += " AND SE5.D_E_L_E_T_ != '*' "
				cSQL += " AND SEZ.EZ_FILIAL = '' "
				cSQL += " AND SE5.E5_RECPAG = 'P' "			
				
				nErro := TcSqlExec(cSQL)
				TcSqlExec("COMMIT")
				lErro := iIf(nErro == 0,.F.,.T.)
			TCUnlink()
			
		EndIf
			
	Case MV_PAR05 == 5 //Limpa Contabilidade
			
			TCLink() //Inicia nova conexใo banco de dados.
				
				If Empty( MV_PAR10 )
				
					Alert("ATENวรO: Necessแrio informar um numero de lote!")
					Return
				Else
					cSQL := " UPDATE "+RetSqlName("CT2")+"  SET D_E_L_E_T_ = '*' , R_E_C_D_E_L_ = R_E_C_N_O_"
					cSQL += " FROM "+RetSqlName("CT2")+" CT2"
					cSQL += " WHERE CT2.CT2_LOTE = '"+MV_PAR10+"' AND CT2.CT2_DATA BETWEEN '"+Dtos(MV_PAR03)+"' AND '"+Dtos(MV_PAR04)+"' AND CT2.D_E_L_E_T_ != '*'"
					cSQL += " AND CT2.CT2_FILIAL BETWEEN '"+MV_PAR01+"' AND '"+MV_PAR02+"'"
					
					nErro := TcSqlExec(cSQL)
					TcSqlExec("COMMIT")
					lErro := iIf(nErro == 0,.F.,.T.)
				EndIf
			TCUnlink()			
EndCase

If lErro
	MsgAlert(cErro,cNmPrg)
Else
	MsgInfo(cOk,cNmPrg)
EndIf

Return