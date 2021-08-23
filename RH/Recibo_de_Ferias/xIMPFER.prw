#INCLUDE "protheus.ch"        // incluido pelo assistente de conversao do AP5 IDE em 03/07/00
#INCLUDE "IMPFER.CH"

/*/{Protheus.doc} User Function IMPFER
    (long_description)
    @type  Esta função tem como objetivo alterar as informações contidas Recibo de Férias, devido COVID-19
    @author Douglas Rodrigues da Silva
    @since 30/03/2020
    @version 1.0
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
    
User Function xIMPFER()        // incluido pelo assistente de conversao do AP5 IDE em 03/07/00

Local cLinAtu		:= ""
Local nCntCd		:= 0
Local nConta		:= 0
Local nDiaFeQueb 	:= 0 
Local i             := 0
Local ni            := 0
Local aGozoFer      := {}
Local dDataRet      := CTOD("//")
Local cDiasFMes		:= ""
Local cDiasFMesSeg  := ""
Local cDiasAbMes	:= ""
Local cDiasAbMSeg	:= ""
Local cLiqReceber	:= ""

//Local nTamSpace	:= ""
Local nLenCRet2	:= ""
//Local nTamLinha	:= ""
Local nTamNomEmpresa := ""

Local nTamSpaco	:= ""
Local lDepto

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?
//?Declaracao de variaveis utilizadas no programa atraves da funcao    ?
//?SetPrvt, que criara somente as variaveis definidas pelo usuario,    ?
//?identificando as variaveis publicas do sistema utilizadas no codigo ?
//?Incluido pelo assistente de conversao do AP5 IDE                    ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴?

SetPrvt("CREPLIC77,CREPLIC22,CREPLIC30,CREPLIC33,CREPLIC35,CREPLIC40")
SetPrvt("N1PARC,NABONO,N13ABONO,CDESC,CLINHA,NLI")
SetPrvt("NVALAB13,NVALAB,NVAL13O,NVAL13A,NPEN13O,NVALNLIQ,CRET1")
SetPrvt("CRET2,CABONO,CEXT,APDV,APDD,PER_AQ_I")
SetPrvt("PER_AQ_F,PER_GO_I,PER_GO_F,NMAXIMO,NTVD,DET")
SetPrvt("NTVP")

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複?
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇?
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴컴컴컴엽?
굇?rograma  ?IMPFER   ?Autor ?R.H. - Aldo           ?Data ?29.10.97       낢?
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴컴컴컴눙?
굇?escrio ?Recibo de Ferias                                                 낢?
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙?
굇?intaxe   ?ImpFer(void)                                                     낢?
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙?
굇?Uso      ?RDMAKE                                                           낢?
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙?
굇?        ATUALIZACOES SOFRIDAS DESDE A CONSTRUAO INICIAL.                   낢?
굇쳐컴컴컴컴컴컫컴컴컴컴쩡컴컴컴컴컴컫컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙?
굇?rogramador ?Data   ?BOPS       ? Motivo da Alteracao                     낢?
굇쳐컴컴컴컴컴컵컴컴컴컴탠컴컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙?
굇?arlos E. O.?1/11/13?12RH01     ?Fonte incluido na P12.                   낢?
굇?           ?       ?96704      ?                                         낢?
굇?idney    O.?1/09/14?PZPWZ      ?Realizado ajustes na largura das linhas  낢?
굇??ero Alves?7/02/15?RTDTI      ?juste p/ retirar frase do relat?io   	낢?
굇?           ?       ?           ?                    						낢?
굇?enrique V. ?5/06/15?SNBZ0      ?nclu?a frase no Aviso de F?ias referent낢?
굇?           ?       ?		 ? ao abono pecuni?io, gratifica豫o de na 낢?
굇?           ?       ?		 ?al e data de retirada das f?ias         낢?
굇?atheus M.  ?4/08/15?TATPP      ?ealizado ajuste para emitir o c.custo e  낢?
굇?           ?       ?		 ?aso o funcion?io possua departamento    낢?
굇?           ?       ?		 ?xibi-lo tamb?.					        낢?
굇읕컴컴컴컴컴컨컴컴컴컴좔컴컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂?
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇?
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽?*/
cReplic77:= REPLICATE("-",77)
cReplic22:= REPLICATE("_",22)
cReplic30:= REPLICATE("_",30)
cReplic33:= REPLICATE("_",33)
cReplic35:= REPLICATE("_",35)
cReplic40:= REPLICATE("_",40)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//?Procura No Arquivo de Ferias o Periodo a Ser Listado         ?
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
If lAchou
	
	dDtBusFer := SRH->RH_DATAINI
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//?Se Funcionario tem  dias de Licensa remunerada, entao deve-se?
	//?imprimir somente o period de gozo das ferias (conf.vlr calcu-?
	//?lado.)                                                       ?
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If SRH->( RH_DIALRE1 + RH_DIALREM) > 0 
		nDiaFeQueb := SRH->(RH_DFERIAS - Int(RH_DFERIAS) ) 
		DaAuxF 	   := SRH->RH_DATAFIM -( SRH->( RH_DIALRE1 + RH_DIALREM ) ) + If(nDiaFeQueb>0 , 1, 0 ) 
    EndIf 
    
    IF cPaisLoc == "ANG"
	    aGozoFer := fBusGozo( SRH->RH_DATABAS , SRH->RH_DBASEAT )
	    IF len(aGozoFer) > 0
		    dDataRet := Dtoc(aGozoFer[len(aGozoFer)][2]+1)
		    DAAUXI   := aGozoFer[1][1]
		    DAAUXF   := aGozoFer[1][2]
		Else
			dDataRet := Dtoc(ctod('//'))
			DAAUXI   := ctod('//')
			DAAUXF   := ctod('//')
		Endif
	Endif

    //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//?Aviso Concesão de Férias COVID-19                       ?
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

    PER_AQ_I := STRZERO(DAY(SRH->RH_DATABASE),2)+STR0067+MesExtenso(MONTH(SRH->RH_DATABAS))+STR0067+STR(YEAR(SRH->RH_DATABAS),4)	//" De "###" De "
    PER_AQ_F := STRZERO(DAY(SRH->RH_DBASEATE),2)+STR0067+MesExtenso(MONTH(SRH->RH_DBASEAT))+STR0067+STR(YEAR(SRH->RH_DBASEAT),4)	//" De "###" De "
    PER_GO_I := STRZERO(DAY(DAAUXI),2)+STR0067+MesExtenso(MONTH(DAAUXI))+STR0067+STR(YEAR(DAAUXI),4)		//" De "###" De "
    PER_GO_F := STRZERO(DAY(DAAUXF),2)+STR0067+MesExtenso(MONTH(DAAUXF))+STR0067+STR(YEAR(DAAUXF),4)		//" De "###" De "

    @ nLi+01,001 PSAY "*" + cReplic77 + "*"
    @ nLi+02,001 PSAY "|" + SPACE(18) + "      AVISO DE CONCESSAO DE FERIAS        "	+SPACE(17)+"|"	//" SOLICITACAO DA 1a PARCELA DO 13o SALARIO "
    @ nLi+03,001 PSAY "|" + SPACE(18) +" ======================================== "+SPACE(17)+"|"
    @ nLi+04,001 PSAY "|" + SPACE(77) + "|"
    @ nLi+05,001 PSAY "|" + SPACE(02) + "Empresa:   " + SubStr(aInfo[3]+Space(40),1,40) + Space(23) + " |"
    @ nLi+06,001 PSAY "|" + SPACE(02) + STR0083 + SubStr(aInfo[4]+Space(30),1,30)+STR0084+SubStr(aInfo[7]+Space(8),1,8) + "           |"
    @ nLi+07,001 PSAY "|" + SPACE(02) + STR0085 + SubStr(aInfo[5]+Space(25),1,25)+STR0086+aInfo[6] + " CNPJ " +  TRANSFORM(aInfo[8] , "@R 99.999.999/9999-99") + Space(3)+"|"
    @ nLi+08,001 PSAY "|" + SPACE(02) + "Empregado " + SUBSTR(SRA->RA_NOME,1,30) + " CTPS " + SRA->RA_NUMCP + "SERIE " + SRA->RA_SERCP   + "           |"    
    @ nLi+09,001 PSAY "|" + SPACE(77) + "|"
    
    @ nLi+10,001 PSAY "|" + SPACE(02) + UPPER("por este instrumento particular, as partes convencionam e se comprometem a ") + "|"    
    @ nLi+11,001 PSAY "|" + SPACE(02) + UPPER("seguir o seguinte:") + SPACE(57)+ "|"    
    @ nLi+12,001 PSAY "|" + SPACE(77) + "|"		

    @ nLi+13,001 PSAY "|" + SPACE(02) + UPPER("Considerando que a disseminacao do COVID 19 Coronavirus, ja declarada pela ") + "|"
    @ nLi+14,001 PSAY "|" + SPACE(02) + UPPER("Organizacao Mundial da Saude  OMS  como uma pandemia de proporcao mundial, ") + "|"
    @ nLi+15,001 PSAY "|" + SPACE(02) + UPPER("requer medidas de prevencao sanitaria, inclusive isolamentos e quarentenas ") + "|"
    @ nLi+16,001 PSAY "|" + SPACE(02) + UPPER("diminuicao do transito de pessoas, etc.                                    ") + "|"
    @ nLi+17,001 PSAY "|" + SPACE(02) + UPPER("com intuito de contencao da propagacao do virus                            ") + "|"
    @ nLi+18,001 PSAY "|" + SPACE(77) + "|"

    @ nLi+19,001 PSAY "|" + SPACE(02) + UPPER("Considerando que, para alem das questoes sanitarias e de saude,            ") + "|"
    @ nLi+20,001 PSAY "|" + SPACE(02) + UPPER("a disseminacao do COVID 19 Coronavirus vem afetando gradualmente a economia") + "|"
    @ nLi+21,001 PSAY "|" + SPACE(02) + UPPER("mundial e local, notadamente no setor de bares, restaurantes e afins       ") + "|"
    @ nLi+22,001 PSAY "|" + SPACE(77) + "|"
    
    @ nLi+23,001 PSAY "|" + SPACE(02) + UPPER("Considerando que o EMPREGADOR atua no ramo de servicos de alimentacao      ") + "|"
    @ nLi+24,001 PSAY "|" + SPACE(02) + UPPER("restaurante e, por isso esta sendo drasticamente afetado pela crise        ") + "|"
    @ nLi+25,001 PSAY "|" + SPACE(02) + UPPER("mundial no setor comercial de bares, restaurantes e afins                  ") + "|"
    @ nLi+26,001 PSAY "|" + SPACE(77) + "|"

    @ nLi+27,001 PSAY "|" + SPACE(02) + UPPER("Considerando, ainda, que no dia 22/03/2020 foi publicada a Media Provisoria") + "|"
    @ nLi+28,001 PSAY "|" + SPACE(02) + UPPER("927/2020 que, em seu artigo 6, 2, permite a antecipacao de ferias          ") + "|"
    @ nLi+29,001 PSAY "|" + SPACE(77) + "|"

    @ nLi+30,001 PSAY "|" + SPACE(02) + UPPER("Considerando, os termos do art 130 da CLT e Clausula 4, alinea (a) cumulada") + "|"
    @ nLi+31,001 PSAY "|" + SPACE(02) + UPPER("com a clausula 5 do Termo Aditivo Convencao Coletiva de Trabalho 2019/2021 ") + "|"
    @ nLi+32,001 PSAY "|" + SPACE(02) + UPPER("para as bases sindicais abrangidas pelo Sinthoresp e pelo Sindifast        ") + "|"
    @ nLi+33,001 PSAY "|" + SPACE(77) + "|"

    @ nLi+34,001 PSAY "|" + SPACE(02) + UPPER("RESOLVEM                                                                   ") + "|"
    @ nLi+35,001 PSAY "|" + SPACE(02) + UPPER("1 A empresa concedera ferias de 10 dias, referente ao periodo aquisitivo de") + "|"
    @ nLi+36,001 PSAY "|" + SPACE(02) + PER_AQ_I + " A " + PER_AQ_F + SPACE(32) + "|"
    @ nLi+37,001 PSAY "|" + SPACE(02) + UPPER("2 As ferias serao usufruidas no periodo entre                              ") + "|"
    @ nLi+38,001 PSAY "|" + SPACE(02) + PER_GO_I + " A " + PER_GO_F + SPACE(32) 
    @ nLi+38,079 PSAY "|" 

    @ nLi+39,001 PSAY "|" + SPACE(77) + "|"
    
    @ nLi+40,001 PSAY "|" + SPACE(02) + UPPER("3 Fazendo uso da flexibilidade prevista na Clausula 4, alinea, cumulada    ") + "|"
    @ nLi+41,001 PSAY "|" + SPACE(02) + UPPER("com a clausula 5 do Termo Aditivo a Convencao Coletiva de Trabalho         ") + "|"
    @ nLi+42,001 PSAY "|" + SPACE(02) + UPPER("2019/2021 (para as bases sindicais do Sinthoresp e do Sindifast) e, para as") + "|"
    @ nLi+43,001 PSAY "|" + SPACE(02) + UPPER("demais bases, fazendo uso do permissivo contigo no artigo 2 da MP 927/2020,") + "|"
    @ nLi+44,001 PSAY "|" + SPACE(02) + UPPER("as partes negociam que                                                     ") + "|"
    
    @ nLi+45,001 PSAY "|" + SPACE(77) + "|"
    @ nLi+46,001 PSAY "|" + SPACE(02) + UPPER("3.1 Os valores das ferias antecipadas + adicional de 1/3 serao pagos em 04 ") + "|"
    @ nLi+47,001 PSAY "|" + SPACE(02) + UPPER("parcelas mensais e consecutivas sendo certo de que o vencimento da primeira") + "|"
    @ nLi+48,001 PSAY "|" + SPACE(02) + UPPER("delas sera 30 (trinta) dias apos o efetivo inicio do gozo pelo EMPREGADO.  ") + "|"
    @ nLi+49,001 PSAY "|" + SPACE(02) + UPPER("Assim, os pagamentos serao efetuados de acordo com o seguinte cronograma:  ") + "|"    
    @ nLi+50,001 PSAY "|" + SPACE(02) + UPPER("PARCELA 1 30/04/2020 PARCELA 2 30/05/2020                                  ") + "|"
    @ nLi+51,001 PSAY "|" + SPACE(02) + UPPER("PARCELA 3 30/06/2020 PARCELA 4 31/07/2020                                  ") + "|"
    @ nLi+52,001 PSAY "|" + SPACE(77) + "|"

    @ nLi+53,001 PSAY "|" + SPACE(02) + UPPER("3.2 No ato da concessao das ferias, a EMPRESA fara o imediato acerto do    ") + "|"
    @ nLi+54,001 PSAY "|" + SPACE(02) + UPPER("saldo de salario que estiver pendente mediante deposito em conta bancaria  ") + "|"
    @ nLi+55,001 PSAY "|" + SPACE(02) + UPPER("de titularidade do EMPREGADO, a qual ja e de conhecimento da empresa.      ") + "|"
    @ nLi+56,001 PSAY "|" + SPACE(77) + "|"

    @ nLi+57,001 PSAY "|" + SPACE(02) + UPPER("4 O empregado que gozar somente ferias proporcionais tera reiniciada a     ") + "|"
    @ nLi+58,001 PSAY "|" + SPACE(02) + UPPER("contagem do periodo aquisitivo, quando do seu retorno ao trabalho similar a") + "|"
    @ nLi+59,001 PSAY "|" + SPACE(02) + UPPER("forma prevista no artigo 140 da CLT.                                       ") + "|"
    @ nLi+60,001 PSAY "*" + cReplic77 + "*"
   
    //Segunda pagina
    @ nLi+01,001 PSAY "*" + cReplic77 + "*"
    @ nLi+02,001 PSAY "|" + SPACE(02) + UPPER("5 As partes concordam que, na impossibilidade de ser emitido e assinado    ") + "|"
    @ nLi+03,001 PSAY "|" + SPACE(02) + UPPER("eventual documento especifico, o comprovante de deposito bancario servira  ") + "|"
    @ nLi+04,001 PSAY "|" + SPACE(02) + UPPER("como recibo de quitacao das parcelas avencadas no presente acordo (e da    ") + "|"
    @ nLi+05,001 PSAY "|" + SPACE(02) + UPPER("proporcao de cada verba que a compoe).                                     ") + "|"
    @ nLi+06,001 PSAY "|" + SPACE(77) + "|"

    @ nLi+07,001 PSAY "|" + SPACE(02) + UPPER("6 Ficam mantidas as demais condicoes originais do contrato de trabalho que ") + "|"
    @ nLi+08,001 PSAY "|" + SPACE(02) + UPPER("nao sejam conflitantes com as alteracoes formalizadas pelo presente        ") + "|"
    @ nLi+09,001 PSAY "|" + SPACE(02) + UPPER("instrumento.                                                               ") + "|"
    @ nLi+10,001 PSAY "|" + SPACE(77) + "|"

    @ nLi+11,001 PSAY "|" + SPACE(02) + UPPER("E assim, por estarem justos e contratados, assinam o presente acordo em 2  ") + "|"
    @ nLi+12,001 PSAY "|" + SPACE(02) + UPPER("(duas) vias de igual teor, juntamente com as testemunhas infra-assinadas,  ") + "|"
    @ nLi+13,001 PSAY "|" + SPACE(02) + UPPER("para que possa produzir seus efeitos legais.                               ") + "|"

    @ nLi+14,001 PSAY "|" + SPACE(77) + "|"
    @ nLi+15,001 PSAY "|" + SPACE(77) + "|"
    @ nLi+16,001 PSAY "|" + SPACE(77) + "|"

    @ nLi+17,001 PSAY "|" + SPACE(02) + UPPER("       Atenciosamente                       Ciente em  _____/_____/_______ ") + "|"
   
    @ nLi+18,001 PSAY "|" + SPACE(77) + "|"
    @ nLi+19,001 PSAY "|" + SPACE(77) + "|"
    @ nLi+20,001 PSAY "|" + SPACE(77) + "|"


    @ nLi+21,001 PSAY "|                       Assinatura do Empregador:____________________________ |"

    @ nLi+22,001 PSAY "|" + SPACE(77) + "|"
    @ nLi+23,001 PSAY "|" + SPACE(77) + "|"
    @ nLi+24,001 PSAY "|" + SPACE(77) + "|"


    @ nLi+25,001 PSAY "|                       Assinatura do Empregado:____________________________  |"
    
    @ nLi+26,001 PSAY "|" + SPACE(77) + "|"
    @ nLi+27,001 PSAY "|" + SPACE(77) + "|"
    @ nLi+28,001 PSAY "|" + SPACE(77) + "|"

    @ nLi+29,001 PSAY "*" + cReplic77 + "*"
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//?Solicitacao 1a Parcela 13o Salario                           ?
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If nSol13 == 1
		n1Parc   := 0
		
		dbSelectArea( "SRR" )
		If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + aCodFol[022,1] )
			n1Parc := 1
		Endif
		
		If n1Parc > 0
			@ nLi+01,001 PSAY "*" + cReplic77 + "*"
			@ nLi+02,001 PSAY "|" + SPACE(18) + STR0001	+SPACE(17)+"|"	//" SOLICITACAO DA 1a PARCELA DO 13o SALARIO "
			@ nLi+03,001 PSAY "|" + SPACE(18) +" ======================================== "+SPACE(17)+"|"
			@ nLi+04,001 PSAY "|" + SPACE(77) + "|"
			If dDtSt13 > SRA->RA_ADMISSA
				@ nLi+05,001 PSAY "|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", "+SUBSTR(DTOC(dDTSt13),1,2)+STR0002+MesExtenso(MONTH(dDTSt13))+STR0002+STR(YEAR(dDTSt13),4)	//" de "###" de "
			Else
				@ nLi+05,001 PSAY "|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", "+SUBSTR(DTOC(SRA->RA_ADMISSAO),1,2)+STR0002+MesExtenso(MONTH(SRA->RA_ADMISSAO))+STR0002+STR(YEAR(SRA->RA_ADMISSA),4)	//" de "###" de "
			Endif
		
			@ nLi+05,079 PSAY "|"
			@ nLi+06,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+07,001 PSAY "|" + SPACE(07) + STR0003 +SPACE(69) + "|"	//"A"
			@ nLi+08,001 PSAY "|" + SPACE(07) + aInfo[3] //+ SPACE(30) + "|"
			@ nLi+08,079 PSAY "|"
			@ nLi+09,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+10,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+11,001 PSAY "|" + SPACE(07) + STR0004 + SPACE(53) + "|"	//"Prezados Senhores"
			@ nLi+12,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+13,001 PSAY "|" + SPACE(77) + "|"		
			@ nLi+14,001 PSAY "|" + SPACE(16) + STR0005 + SPACE(4) + "|"	//"Nos  termos da legislacao vigente, solicito  o  pagamento"
			@ nLi+15,001 PSAY "|" + SPACE(07) + STR0006							//"da  1a  Parcela  do 13o Salario por  ocasiao  do  gozo  de  minhas    |"
			@ nLi+16,001 PSAY "|" + SPACE(07) + STR0007 + SPACE(63) + "|"	//"ferias."
			@ nLi+17,001 PSAY "|" + SPACE(16) + STR0008+SPACE(19)+"|"	//"Solicito apor o seu ciente na copia desta."
			@ nLi+18,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+19,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+20,001 PSAY "|" + SPACE(07) + SRA->RA_NOME+SPACE(02)+STR0009+SRA->RA_FILIAL+" "+SRA->RA_MAT//+SPACE(16)+"|"	//"Registro No: "
			@ nLi+20,079 PSAY "|"

			// Se for Brasil e imprime funcionarios demitidos SIM, utilizar CC
			// da tabela SRR para buscar CC da epoca das ferias do funcionario
			If cPaisLoc == "BRA" .and. SRA->RA_SITFOLH $ "D" .and. nImprDem == 1
				cDesc := DescCc( SRR->RR_CC, SRR->RR_FILIAL )
			Else
				cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )
			EndIf

			cLinha:= "|" + SPACE(07) + STR0010 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(10)	//"CTPS = "		
			cLInha:= cLinha + "C.CUSTO: " + Alltrim(cDesc)
			@ nLi+21,001 PSAY cLinha
			@ nLi+21,079 PSAY "|"
			lDepto	:= CpoUsado("RA_DEPTO") .And. !EMPTY(SRA->RA_DEPTO)
			IF lDepto 
				@ nLi+22,001 PSAY "|" + SPACE(39) + STR0028 + ( fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC') ) ; @ nLi+22,079 PSAY "|"
			Else
				@ nLi+22,001 PSAY "|"; @ nLi+22,079 PSAY "|"
			EndIF
			@ nLi+23,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+24,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+25,001 PSAY "|" + SPACE(07) + STR0011+SPACE(18)+STR0012+SPACE(17)+"|"	//"Atenciosamente"###"Ciente em ___/___/___"
			@ nLi+26,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+27,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+28,001 PSAY "|" + SPACE(07) + cReplic22+SPACE(10)+cReplic35+space(03)+"|"
			@ nLi+29,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+30,001 PSAY "*" + cReplic77 + "*"
			nLi:=nLi+30
			
		Endif
	Endif
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//?Solicitacao Abono Pecuniario                                 ?
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If nSolAb == 1
		nAbono   := 0
		n13Abono := 0
		
		dbSelectArea( "SRR" )		
		
		If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + aCodFol[074,1] )
			nAbono := 1
		Endif
		
		If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + aCodFol[079,1] )
			n13Abono := 1
		Endif
		
		If ( nAbono + n13Abono ) > 0
			@ nLi+01,001 PSAY "*" + cReplic77 + "*"
			@ nLi+02,001 PSAY "|" + SPACE(18) +STR0013+SPACE(17)+"|"	//"     SOLICITACAO DO ABONO DE FERIAS       "
			@ nLi+03,001 PSAY "|" + SPACE(18) +"     ==============================       "+SPACE(17)+"|"		
	   		@ nLi+04,001 PSAY "|" + SPACE(77) + "|"   
			dDtSolAb:= DaySub(SRH->RH_DBASEAT,nDAbnPec)
			@ nLi+05,001 PSAY "|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", " +SUBSTR(DTOC(dDtSolAb),1,2)+STR0002+MesExtenso(MONTH(dDtSolAb))+STR0002+STR(YEAR(dDtSolAb),4)	//" de "###" de "
			@ nLi+05,079 PSAY "|"
			@ nLi+06,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+07,001 PSAY "|" + SPACE(07) + STR0003 +SPACE(69) + "|"	//"A"
			@ nLi+08,001 PSAY "|" + SPACE(07) + aInfo[3] //+ SPACE(30) + "|"
			@ nLi+08,079 PSAY "|"			
			@ nLi+09,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+10,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+11,001 PSAY "|" + SPACE(07) + STR0014 + SPACE(53) + "|"	//"Prezados Senhores"
			@ nLi+12,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+13,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+14,001 PSAY "|" + SPACE(16) + STR0015 + SPACE(3) + "|"	//"Nos  termos da legislacao vigente, solicito  a  conversao "
			@ nLi+15,001 PSAY "|" + SPACE(07) + STR0016							//"de  1/3  (Hum Terco)  de  minhas  ferias   relativas  ao   periodo    |"
			@ nLi+16,001 PSAY "|" + SPACE(07) + STR0017 + PADR(DTOC(SRH->RH_DATABAS),10)+STR0018+PADR(DTOC(SRH->RH_DBASEAT),10)+STR0019+SPACE(12)+"|"	//"aquisitivo de "###" a "###" em abono pecuniario."
			@ nLi+17,001 PSAY "|" + SPACE(16) + STR0020+SPACE(19)+"|"	//"Solicito apor o seu ciente na copia desta."
			@ nLi+18,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+19,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+20,001 PSAY "|" + SPACE(07) + SRA->RA_NOME+SPACE(02)+STR0021+SRA->RA_FILIAL+" "+SRA->RA_MAT//+SPACE(16)+"|"	//"Registro No: "
			@ nLi+20,079 PSAY "|"			

			// Se for Brasil e imprime funcionarios demitidos SIM, utilizar CC
			// da tabela SRR para buscar CC da epoca das ferias do funcionario
			If cPaisLoc == "BRA" .and. SRA->RA_SITFOLH $ "D" .and. nImprDem == 1
				cDesc := DescCc( SRR->RR_CC, SRR->RR_FILIAL )
			Else
				cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )
			EndIf

			cLinha:="|" + SPACE(07) + STR0022 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(10)+"C.CUSTO: "+ AllTrim(cDesc)
			@ nLi+21,001 PSAY cLinha
			@ nLi+21,079 PSAY "|"
			lDepto	:= CpoUsado("RA_DEPTO") .And. !EMPTY(SRA->RA_DEPTO)
			IF lDepto 
				@ nLi+22,001 PSAY "|" + SPACE(39) + STR0028 + ( fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC') ) ; @ nLi+22,079 PSAY "|"
			Else
				@ nLi+22,001 PSAY "|"; @ nLi+22,079 PSAY "|"
			EndIF
			@ nLi+23,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+24,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+25,001 PSAY "|" + SPACE(07) + STR0023+SPACE(18)+STR0024+SPACE(17)+"|"	//"Atenciosamente"###"Ciente em ___/___/___"
			@ nLi+26,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+27,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+28,001 PSAY "|" + SPACE(07) + cReplic22+SPACE(10)+cReplic35+SPACE(03)+"|"
			@ nLi+29,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+30,001 PSAY "*" + cReplic77 + "*"
			nLi:=nLi+30
		Endif
	Endif
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//?Aviso De Ferias                                              ?
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If nAviso == 1
		If nLi > 35
			nLi := 1
		Endif
		
		@ nLi+01,001 PSAY "*" + cReplic77 + "*"
		@ nLi+02,001 PSAY "|" + SPACE(30) + STR0025	;@ nLi+02,079 PSAY "|"	//" AVISO DE FERIAS "
		@ nLi+03,001 PSAY "|" + SPACE(30) + Replicate("=",Len(STR0025)+1);@ nLi+03,079 PSAY "|"
		@ nLi+04,001 PSAY "|";@ nLi+04,079 PSAY "|"      
		
		IF cPaisLoc == "ANG"
			@ nLi+05,001 PSAY "|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", "+SUBSTR(DTOC(SRH->RH_DTRECIB),1,2)+STR0002+MesExtenso(MONTH(SRH->RH_DTRECIB))+STR0002+STR(YEAR(SRH->RH_DTRECIB),4)	//" de "###" de "
		ELSE
			@ nLi+05,001 PSAY "|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", "+SUBSTR(DTOC(SRH->RH_DTAVISO),1,2)+STR0002+MesExtenso(MONTH(SRH->RH_DTAVISO))+STR0002+STR(YEAR(SRH->RH_DTAVISO),4)	//" de "###" de "
		ENDIF
		
		@ nLi+05,079 PSAY "|"
		@ nLi+06,001 PSAY "|"; @ nLi+06,079 PSAY "|"                                     
		
		If cPaisLoc <> "ARG"
			@ nLi+07,001 PSAY "|" + SPACE(07) + STR0026	; @ nLi+07,079 PSAY "|"	//"A(O) SR(A)"
		Else
			@ nLi+07,001 PSAY "|" + SPACE(07) + STR0115	; @ nLi+07,079 PSAY "|"	//"SR(A)"
		EndIf
		
		@ nLi+08,001 PSAY "|" + SPACE(77) + "|"
		@ nLi+09,001 PSAY "|" + SPACE(07) + Left(SRA->RA_NOME,30);@ nLi+09,079 PSAY "|"

		// Se for Brasil e imprime funcionarios demitidos SIM, utilizar CC
		// da tabela SRR para buscar CC da epoca das ferias do funcionario
		dbSelectArea( "SRR" )
		If cPaisLoc == "BRA" .and. SRA->RA_SITFOLH $ "D" .and. nImprDem == 1 .and.;
			dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) )
			cDesc := DescCc( SRR->RR_CC, SRR->RR_FILIAL )
		Else
			cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )
		EndIf

		If cPaisLoc == "BRA"
			cLinha:= "|" + SPACE(07) + STR0027 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(8)+"C.CUSTO: " //"CTPS = "
		ElseIf !( cPaisLoc $ "ARG|ANG" )
			cLinha:= "|" + SPACE(07) + STR0027 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(8)+STR0028	//"CTPS = "###"DEPTO: "
		ElseIF cPaisLoc == "ANG"
		    cLinha:= "|" + SPACE(07) + STR0028	//"###"DEPTO: "
		else
			//cLinha:= "|" + SPACE(07) + STR0116 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(8)+STR0028	//"CTPS = "###"DEPTO: "
		EndIf
		
		cLInha:= cLinha+AllTrim(cDesc)
		@ nLi+10,001 PSAY cLinha;@ nLi+10,079 PSAY "|"
		lDepto	:= CpoUsado("RA_DEPTO") .And. !EMPTY(SRA->RA_DEPTO)
		IF lDepto 
			@ nLi+11,001 PSAY "|" + SPACE(37) + STR0028 + ( fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC') ) ; @ nLi+11,079 PSAY "|"
		Else
			@ nLi+11,001 PSAY "|"; @ nLi+11,079 PSAY "|"
		EndIF
		@ nLi+12,001 PSAY "|"; @ nLi+12,079 PSAY "|"
		@ nLi+13,001 PSAY "|" + SPACE(16) + STR0029 ; @ nLi+13,079 PSAY "|"	//"Nos  termos da legislacao  vigente,  suas  ferias   serao"
		@ nLi+14,001 PSAY "|" + SPACE(07) + STR0030 ; @ nLi+14,079 PSAY "|"	//"concedidas conforme o demonstrativo abaixo:"

		If (SRH->RH_DIALRE1 + SRH->RH_DIALREM) > 0 
			@ nLi+15,001 PSAY "|" + SPACE(64) + STR0033 ; @ nLi+15,079 PSAY "|"
			@ nLi+16,001 PSAY "| " + STR0031+SPACE(04)+STR0032+SPACE(07)+"Retorno ao Trabalho:" +SPACE(03); @ nLi+16,079 PSAY "|"	//"Periodo Aquisitivo:"###"Periodo de Gozo:"###"Retorno ao Trabalho:"                                                                 
			@ nLi+17,001 PSAY "|" + PADR(DTOC(SRH->RH_DATABAS),10)+STR0034+PADR(DTOC(SRH->RH_DBASEAT),10)+SPACE(01)+If(SRH->RH_DIALREM == 30," A ",PADR(DTOC(DAAUXI),10)+STR0034+PADR(DTOC(DAAUXF),10))+SPACE(6)+(CVALTOCHAR(SRH->RH_DIALRE1 + SRH->RH_DIALREM))+SPACE(9)+PADR(DTOC(SRH->RH_DATAFIM+1),10); @ nLi+17,079 PSAY "|"	//" A "###" A "
			
	   	else
			@ nLi+15,001 PSAY "|" ; @ nLi+15,079 PSAY "|"
		   	@ nLi+16,001 PSAY "|    " + STR0031+SPACE(08)+STR0032+SPACE(06)+"Retorno ao Trabalho:"; @ nLi+16,079 PSAY "|"	//"Periodo Aquisitivo:"###"Periodo de Gozo:"###"Retorno ao Trabalho:"                                                                 
			
			IF cPaisLoc == "ANG"
				@ nLi+17,001 PSAY "|  " + DTOC(SRH->RH_DATABAS)+STR0034+DTOC(SRH->RH_DBASEAT)+SPACE(08)+Dtoc(DAAUXI)+STR0034+Dtoc(DAAUXF)+SPACE(9)+dDataRet; @ nLi+17,079 PSAY "|"	//" A "###" A "			
				
				IF len(aGozoFer) > 1   
					For ni=2 to len(aGozoFer)
						nLi++
			    		DAAUXI   := aGozoFer[ni][1]
			    		DAAUXF   := aGozoFer[ni][2]
			    		@ nLi+17,001 PSAY "|"
			    		@ nLi+17,031 PSAY Dtoc(DAAUXI)+STR0034+Dtoc(DAAUXF)
			    		@ nLi+17,079 PSAY "|"
			  		Next i
				Endif
			Else
				@ nLi+17,001 PSAY "|  " + PADR(DTOC(SRH->RH_DATABAS),10)+STR0034+PADR(DTOC(SRH->RH_DBASEAT),10)+SPACE(02)+PADR(DTOC(DAAUXI),10)+STR0034+PADR(DTOC(DAAUXF),10)+SPACE(8)+PADR(DTOC(DAAUXF+1),10); @ nLi+17,079 PSAY "|"	//" A "###" A "
			Endif
		EndIf
		
		@ nLi+18,001 PSAY "|"; @ nLi+18,079 PSAY "|"
		
		@ nLi+19,001 PSAY "|" ; @ nLi+19,079 PSAY "|"
		@ nLi+20,001 PSAY "|" ; @ nLi+20,079 PSAY "|"
		@ nLi+21,001 PSAY "|" ; @ nLi+21,079 PSAY "|"
		@ nLi+22,001 PSAY "|" + SPACE(02) + cReplic40+SPACE(01)+cReplic33+SPACE(01); @ nLi+22,079 PSAY "|"
		@ nLi+23,001 PSAY "|" + SPACE(02) + SubStr(aInfo[3]+Space(40),1,40)+SPACE(05)+Left(SRA->RA_NOME,30); @ nLi+23,079 PSAY "|"
		@ nLi+24,001 PSAY "|" ; @ nLi+24,079 PSAY "|"
		@ nLi+25,001 PSAY "*" + cReplic77 + "*"
		nLi:=nLi+30
	Endif
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//?Recibo De Abono                                              ?
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If nRecAb == 1
		nValAb		:= 0.00
		nValab13 	:= 0.00		
		nValnLiq	:= 0.00
		cRet1		:= ''
		cRet2		:= ''
		
		If nLi > 35
			nLi := 1
		Endif
		
		dbSelectArea( "SRR" )
		dbGoTop()
				
		For i := 1 To Len(aVerbsAbo)
		
			If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + aVerbsAbo[i] )
				nValAb += SRR->RR_VALOR
			Endif
			
		Next
			
		For i := 1 To Len(aVerbs13Abo)
		
			If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + aVerbs13Abo[i] )
				nValAb13 += SRR->RR_VALOR
			Endif
			
		Next i 
		
		If ( nValAb + nValAb13 ) > 0
			@ nLi+01,001 PSAY "*" + cReplic77 + "*"
			@ nLi+02,001 PSAY "|" + SPACE(25) +STR0040+SPACE(24)+"|"			//" RECIBO DE ABONO DE FERIAS  "
			@ nLi+03,001 PSAY "|" + SPACE(25) +" =========================  "+SPACE(24)+"|"
			@ nLi+04,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+05,001 PSAY "|" + SPACE(07) + Sra->RA_NOME+SPACE(40) + "|"

			// Se for Brasil e imprime funcionarios demitidos SIM, utilizar CC
			// da tabela SRR para buscar CC da epoca das ferias do funcionario
			If cPaisLoc == "BRA" .and. SRA->RA_SITFOLH $ "D" .and. nImprDem == 1
				cDesc := DescCc( SRR->RR_CC, SRR->RR_FILIAL )
			Else
				cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )
			EndIf

			cLinha:="|" + SPACE(07) + STR0041 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(8) //"CTPS = "
			cLInha := cLinha + "C.CUSTO: " + Alltrim(cDesc)
			@ nLi+06,001 PSAY cLinha
			@ nLi+06,079 PSAY "|"
			lDepto	:= CpoUsado("RA_DEPTO") .And. !EMPTY(SRA->RA_DEPTO)
			IF lDepto 
				@ nLi+07,001 PSAY "|" + SPACE(37) + STR0028 + ( fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC') ) ; @ nLi+07,079 PSAY "|"
			Else
				@ nLi+07,001 PSAY "|"; @ nLi+07,079 PSAY "|"
			EndIF
			@ nLi+08,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+09,001 PSAY "|" + SPACE(27) + STR0043 + SPACE(25) + "|"	//"D E M O N S T R A T I V O"
			@ nLi+10,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+11,001 PSAY STR0044	//"|  Periodo de ferias em Abono Pecuniario      Periodo de gozo de ferias       |"
			
			If !empty(SRH->RH_ABOPEC)
				cAbono 	:= SRH->RH_ABOPEC
			Else
				cAbono	:= GetMv("MV_ABOPEC")                  //-- Define se o periodo do abono pecuniario ser?considerado antes ou depois do gozo de ferias 
				cAbono 	:= if(cAbono=="S","1","2")    		   //-- Abono antes
			EndIF
			
			If cAbono == "1"
				@ nLi+12,001 PSAY "|"+Space(7)+PADR(DtoC(SRH->RH_DATAINI-SRH->RH_DABONPEC),10)+STR0045+Dtoc(SRH->RH_DATAINI-1)                        +Space(15)+PADR(Dtoc(SRH->RH_DATAINI),10)+STR0045+PADR(DtoC(DaAuxF),10)+Space(5)+"|"	//"  a  "###"  a  "
			Else
				@ nLi+12,001 PSAY "|"+Space(7)+PADR(DtoC( DaAuxF + 1            ),10)+STR0045+PADR(Dtoc(DaAuxF+SRH->RH_DABONPEC),10)+Space(15)+PADR(Dtoc(SRH->RH_DATAINI),10)+STR0045+PADR(DtoC(DaAuxF),10)+Space(5)+"|"	//"  a  "###"  a  "
			Endif
			@ nLi+13,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+14,001 PSAY "|" + SPACE(07) + STR0046+STR(SRH->RH_DABONPE,3)+STR0047+TRANSFORM(nValAb,"@E 999,999,999.99")+SPACE(28)+"|"	//"Abono ("###") Dias :          "
			@ nLi+15,001 PSAY "|" + SPACE(07) + STR0048+TRANSFORM(nValAb13,"@E 999,999,999.99")+SPACE(28)+"|"											//"Acrescimo 1/3 :             "
			@ nLi+16,001 PSAY "|" + SPACE(07) + STR0049+TRANSFORM(nValAb13+nValab ,"@E 999,999,999.99")+SPACE(28)+"|"								//"Liquido :                   "
			nLi:=nLi+3
			nValnLiq := nValAb13+nValab
			@ nLi+14,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+15,001 PSAY "|" + SPACE(77) + "|"
			cExt := Extenso(nValnLiq,.F.,1)
			SepExt(cExt,13,70,@cRet1,@cRet2)
			@ nLi+16,001 PSAY "|" + SPACE(17) + STR0050 + SubStr(aInfo[3], 1, 50)		//"Recebi de "
			@ nLi+16,079 PSAY "|"
			@ nLi+17,001 PSAY "|" +Space(07)+ STR0051+TRANSFORM(nValnLiq,"@E 999,999,999.99") + "  ("+cRet1+SPACE(9)+" |"	//" a importancia Liquida de  R$ "
			
			nLenCRet2 := len(cRet2)
			If nLenCRet2 > 63
				@ nLi+18,001 PSAY "|" +SPACE(08)+subStr(cRet2,1, 69)
				@ nLi+18,079 PSAY "|"
				@ nLi+19,001 PSAY "|" +SPACE(08)+subStr(cRet2,70)+".****)"
				@ nLi+19,079 PSAY "|"
				@ nLi+20,001 PSAY "|" + SPACE(07) + STR0052		//" conforme demonstrativo acima, referente ao abono pecuniario."
				@ nLi+20,079 PSAY "|"
				@ nLi+21,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+22,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+23,001 PSAY "| " + ALLTRIM(aInfo[5])+", "+STRZERO(DAY(SRH->RH_DTRECIB),2)+STR0053+MesExtenso(MONTH(SRH->RH_DTRECIB))+STR0053+STR(YEAR(SRH->RH_DTRECIB),4)	//" de "###" de "
				@ nLi+23,079 PSAY "|"
				@ nLi+24,001 PSAY "|" + SPACE(46)+cReplic30+" |"
				@ nLi+25,001 PSAY "|" + SPACE(46) + SRA->RA_NOME     +" |"
				@ nLi+26,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+27,001 PSAY "*" + cReplic77 + "*"
				nLi:=nLi+25
			Else
				@ nLi+18,001 PSAY "|" +SPACE(08)+cRet2+".****)"
				@ nLi+18,079 PSAY "|"
				@ nLi+19,001 PSAY "|" + SPACE(07) + STR0052		//" conforme demonstrativo acima, referente ao abono pecuniario."
				@ nLi+19,079 PSAY "|"
				@ nLi+20,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+21,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+22,001 PSAY "| " + ALLTRIM(aInfo[5])+", "+STRZERO(DAY(SRH->RH_DTRECIB),2)+STR0053+MesExtenso(MONTH(SRH->RH_DTRECIB))+STR0053+STR(YEAR(SRH->RH_DTRECIB),4)	//" de "###" de "
				@ nLi+22,079 PSAY "|"
				@ nLi+23,001 PSAY "|" + SPACE(46)+cReplic30+" |"
				@ nLi+24,001 PSAY "|" + SPACE(46) + SRA->RA_NOME     +" |"
				@ nLi+25,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+26,001 PSAY "*" + cReplic77 + "*"
				nLi:=nLi+26
			EndIf

		Endif
		
	Endif
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//?Recibo De 13o Salario                                        ?
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If nRec13 == 1
		nVal13o  := 0.00
		nPen13o  := 0.00
		nVal13a  := 0.00
		nValnLiq := 0.00
		cRet1    := ''
		cRet2    := ''
		
		If nLi > 35
			nLi := 1
		Endif
		
		dbSelectArea( "SRR" )
		If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + cPd13o )
			nVal13o := SRR->RR_VALOR
		Endif
		
		For nCntCd := 1 To Len(aCodBenef)
			If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + Dtos(dDtBusFer) + aCodBenef[nCntCd,1] )
				nPen13o += SRR->RR_VALOR
			EndIf
		Next nCntCd
		
		If nVal13o > 0
			@ nLi+01,001 PSAY "*" + cReplic77 + "*"
			@ nLi+02,001 PSAY "|" + SPACE(20) + STR0054+SPACE(19)+"|"	//" RECIBO DA 1a. PARCELA DO 13o SALARIO "
			@ nLi+03,001 PSAY "|" + SPACE(20) +" ==================================== "+SPACE(19)+"|"
			@ nLi+04,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+05,001 PSAY "|" + SPACE(07) + Sra->RA_NOME+SPACE(40) + "|"

			// Se for Brasil e imprime funcionarios demitidos SIM, utilizar CC
			// da tabela SRR para buscar CC da epoca das ferias do funcionario
			If cPaisLoc == "BRA" .and. SRA->RA_SITFOLH $ "D" .and. nImprDem == 1
				cDesc := DescCc( SRR->RR_CC, SRR->RR_FILIAL )
			Else
				cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )
			EndIf

			nTamSpaco := 77-(7 + 7 + len(SRA->RA_NUMCP) + 3 + len(SRA->RA_SERCP) + 8 + 7 + len(cDesc))
						
			cLinha:="|" + SPACE(07) + STR0056 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(8) 	//"CTPS = "
			cLInha := cLinha + "C.CUSTO: " + Alltrim(cDesc)
			@ nLi+06,001 PSAY cLinha
			@ nLi+06,079 PSAY "|"
			lDepto	:= CpoUsado("RA_DEPTO") .And. !EMPTY(SRA->RA_DEPTO)
			IF lDepto 
				@ nLi+07,001 PSAY "|" + SPACE(37) + STR0028 + ( fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC') ) ; @ nLi+07,079 PSAY "|"
			Else
				@ nLi+07,001 PSAY "|"; @ nLi+07,079 PSAY "|"
			EndIF			
			@ nLi+08,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+09,001 PSAY "|" + SPACE(27) + STR0058 + SPACE(25) + "|"	//"D E M O N S T R A T I V O"
			@ nLi+10,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+11,001 PSAY "|" + SPACE(07) + STR0059+TRANSFORM(nVal13o,"@E 999,999,999.99")+SPACE(28)+"|"	//"1a Parcela do 13o Salario : "
			@ nLi+12,001 PSAY "|" + SPACE(07) + STR0060+TRANSFORM(nVal13a,"@E 999,999,999.99")+SPACE(28)+"|"	//"Adiantamento :              "
			If nPen13o > 0
				@ nLi+13,001 PSAY "|" + SPACE(07) + "Pensao :"+TRANSFORM(nPen13o,"@E 999,999,999.99")+SPACE(28)+"|"	//"Pensao :"
			EndIf
			@ nLi+If(nPen13o>0,14,13),001 PSAY "|" + SPACE(07) + STR0061+TRANSFORM(nVal13o-nVal13a-nPen13o,"@E 999,999,999.99")+SPACE(28)+"|"	//"Liquido :                   "
			nValnLiq := nVal13o-nVal13a-nPen13o
			If nPen13o == 0
				@ nLi+14,001 PSAY "|" + SPACE(77) + "|"
			EndIf
			@ nLi+15,001 PSAY "|" + SPACE(77) + "|"
			cExt := Extenso(nValnLiq,.F.,1)
			SepExt(cExt,13,70,@cRet1,@cRet2)
			@ nLi+16,001 PSAY "|" + SPACE(16) + STR0062 + subStr(aInfo[3], 1, 50)	//"Recebi de "
			@ nLi+16,079 PSAY "|"
			@ nLi+17,001 PSAY "|" +Space(07)+ STR0063+TRANSFORM(nValnLiq,"@E 999,999,999.99") + "  ("+cRet1+SPACE(9)+" |"		//" a importancia Liquida de  R$ "
			
			nLenCRet2 := len(cRet2)
			If nLenCRet2 > 63
				@ nLi+18,001 PSAY "|" +SPACE(08)+subStr(cRet2,1, 69)
				@ nLi+18,079 PSAY "|"
				@ nLi+19,001 PSAY "|" +SPACE(08)+subStr(cRet2,70)+".****)"
				@ nLi+19,079 PSAY "|"
				@ nLi+20,001 PSAY "|" + SPACE(07) + STR0064	//" conforme demonstrativo acima, referente a 1a parcela do 13o salario."
				@ nLi+20,079 PSAY "|"
				@ nLi+21,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+22,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+23,001 PSAY "| " + ALLTRIM(aInfo[5])+", "+STRZERO(DAY(SRH->RH_DTRECIB),2)+STR0065+MesExtenso(MONTH(SRH->RH_DTRECIB))+STR0066+STR(YEAR(SRH->RH_DTRECIB),4)	//" de "###" de "
				@ nLi+23,079 PSAY "|"
				@ nLi+24,001 PSAY "|" + SPACE(46)+cReplic30+" |"
				@ nLi+25,001 PSAY "|" + SPACE(46) + SRA->RA_NOME     +" |"
				@ nLi+26,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+27,001 PSAY "*" + cReplic77 + "*"
				nLi:=nLi+25
			Else
				@ nLi+18,001 PSAY "|" +SPACE(08)+cRet2+".****)" 
				@ nLi+18,079 PSAY "|"
				@ nLi+19,001 PSAY "|" + SPACE(07) + STR0064	//" conforme demonstrativo acima, referente a 1a parcela do 13o salario."
				@ nLi+19,079 PSAY "|"
				@ nLi+20,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+21,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+22,001 PSAY "| " + ALLTRIM(aInfo[5])+", "+STRZERO(DAY(SRH->RH_DTRECIB),2)+STR0065+MesExtenso(MONTH(SRH->RH_DTRECIB))+STR0066+STR(YEAR(SRH->RH_DTRECIB),4)	//" de "###" de "
				@ nLi+22,079 PSAY "|"
				@ nLi+23,001 PSAY "|" + SPACE(46)+cReplic30+" |"
				@ nLi+24,001 PSAY "|" + SPACE(46) + SRA->RA_NOME     +" |"
				@ nLi+25,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+26,001 PSAY "*" + cReplic77 + "*"
				nLi:=nLi+26
			EndIf
		Endif
	Endif
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//?Recibo De Ferias                                             ?
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If nRecib == 1
		
		aPdv  := {}
		aPdd  := {}
		cRet1 := ""
		cRet2 := ""
		nLi   := 1
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//?Posiciona Arq. SRR Para Guardar na Matriz as Verbas De Ferias?
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		dbSelectArea("SRR")
		If dbSeek( SRA->RA_FILIAL + SRA->RA_MAT + "F" )
			While ! Eof() .And. SRA->RA_FIlIAL + SRA->RA_MAT + "F" == SRR->RR_FILIAL + SRR->RR_MAT + SRR->RR_TIPO3
				//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
				//?Verifica Verba For Abono Ou 13o Esta $ Na Variavel Nao Lista ?
				//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
				If AScan(aVerbsAbo, SRR->RR_PD ) == 0 .And.;
					AScan(aVerbs13Abo, SRR->RR_PD ) == 0 .And.;
					SRR->RR_PD # cPd13o .And. SRR->RR_PD # aCodFol[102,1] .And.; 					
					AScan(aCodBenef, { |x| x[1] == SRR->RR_PD }) == 0
					
					If SRR->RR_DATA == dDtBusFer
						If PosSrv( SRR->RR_PD , SRA->RA_FILIAL , "RV_TIPOCOD" ) == "1"
							AAdd(aPdv , { SRR->RR_PD , SRR->RR_VALOR })
						ElseIf PosSrv( SRR->RR_PD , SRA->RA_FILIAL , "RV_TIPOCOD" ) == "2"
							AAdd(aPdd , { SRR->RR_PD , SRR->RR_VALOR })
						Endif
					Endif
					
				Endif
				dbSkip()
			Enddo
			
			PER_AQ_I := STRZERO(DAY(SRH->RH_DATABASE),2)+STR0067+MesExtenso(MONTH(SRH->RH_DATABAS))+STR0067+STR(YEAR(SRH->RH_DATABAS),4)	//" De "###" De "
			PER_AQ_F := STRZERO(DAY(SRH->RH_DBASEATE),2)+STR0067+MesExtenso(MONTH(SRH->RH_DBASEAT))+STR0067+STR(YEAR(SRH->RH_DBASEAT),4)	//" De "###" De "
			PER_GO_I := STRZERO(DAY(DAAUXI),2)+STR0067+MesExtenso(MONTH(DAAUXI))+STR0067+STR(YEAR(DAAUXI),4)		//" De "###" De "
			PER_GO_F := STRZERO(DAY(DAAUXF),2)+STR0067+MesExtenso(MONTH(DAAUXF))+STR0067+STR(YEAR(DAAUXF),4)		//" De "###" De "
			
			nLi:=nLi+1
			@ nLi,001 PSAY "*" + cReplic77 + "*"
			nLi:=nLi+1
			@ nLi,001 PSAY "|"
			@ nLi,030 PSAY STR0068		//" RECIBO DE FERIAS "
			@ nLi,079 PSAY "|"
			nLi:=nLi+1
			@ nLi,001 PSAY "|"
			@ nLi,030 PSAY " ================ "
			@ nLi,079 PSAY "|"
			nLi:=nLi+1
			@ nLi,001 PSAY "|" + SPACE(77) + "|"
			nLi:=nLi+1
			@ nLi,001 PSAY "|" + SPACE(77) + "|"
			nLi:=nLi+1
			@ nLi,001 PSAY STR0069+Left(SRA->RA_NOME,30)+SPACE(020)+'|'			//"| Nome do Empregado.......: "
			nLi:=nLi+1    
			
			If ! (cPaisLoc $ "ARG|ANG")
				@ nLi,001 PSAY STR0070 + If(Empty(SRA->RA_NUMCP),Space(7),AllTrim(SRA->RA_NUMCP))+" - "+SRA->RA_SERCP+;		//"| Carteira Trabalho.......: "
				SPACE(04)+STR0071+SRA->RA_FILIAL+" "+SRA->RA_MAT					//"Registro: "
				@ nLi,079 PSAY "|"				
			Else
				cLinAtu := "| " + STR0071+SRA->RA_FILIAL+" "+SRA->RA_MAT
				@ nLi,001 PSAY cLinAtu + Space( 78-Len(cLinAtu) ) + "|"	//"Registro: "
			EndIf
					
			nLi:=nLi+1
			@ nLi,001 PSAY STR0072+PER_AQ_I+STR0073+PER_AQ_F	//"| Periodo Aquisitivo......: "###" A "
			@ nLi,079 PSAY "|"
			nLi:=nLi+1       
			
			IF cPaisLoc <> "ANG"
				@ nLi,001 PSAY STR0074+PER_GO_I+STR0073+PER_GO_F	//"| Periodo Gozo das Ferias.: "###" A " 
			ELSE

			    For i=1 to Len(aGozoFer)
			    	
					PER_GO_I := STR(DAY(aGozoFer[i][1]),2)+STR0067+MesExtenso(MONTH(aGozoFer[i][1]))+STR0067+STR(YEAR(aGozoFer[i][1]),4)		//" De "###" De "
					PER_GO_F := STR(DAY(aGozoFer[i][2]),2)+STR0067+MesExtenso(MONTH(aGozoFer[i][2]))+STR0067+STR(YEAR(aGozoFer[i][2]),4)		//" De "###" De "
			    	
			    	@ nLi,001 PSAY STR0074+PER_GO_I+STR0073+PER_GO_F 
			       
			    	IF i <> Len(aGozoFer)
    					@ nLi,079 PSAY "|" 
			    		nLi:=nLi+1
			    	ENDIF
			    	
			    Next i
			    
			Endif

			@ nLi,079 PSAY "|"
			nLi:=nLi+1
			@ nLi,001 PSAY "| Qtde. Dias Lic. Remun...: " + cValToChar(SRH->RH_DIALRE1 + SRH->RH_DIALREM)			//"| Qtde. Dias Lic. Remun...: "
			@ nLi,079 PSAY "|"
			nLi:=nLi+1
			@ nLi,001 PSAY "*" + cReplic77 + "*"
			nLi:=nLi+1
			@ nLi,001 PSAY "|"
			//@ nLi,(80/2 - Len(STR0126)/2) PSAY STR0126
			@ nLi,079 PSAY "|"			
			nLi:=nLi+1			
			@ nLi,001 PSAY "*" + cReplic77 + "*"
			nLi:=nLi+1									
			@ nLi,001 PSAY "| Salario Mes ..........: " + Transform(SRH->RH_SALMES,"@E 999,999.99")+;		//"| Salario Mes ............: "
			    Space(05)+"Salario Hora ..........: " + Transform(SRH->RH_SALHRS,"@E 999,999.99")				//"Salario Hora ...........: "
			    @ nLi,079 PSAY "|"									
			
            nLi:=nLi+1
			@ nLi,001 PSAY "| Valor Dia ............: " + Transform(SRH->RH_SALDIA,"@E 999,999.99")+;		//"Valor Dia Mes...: "
			    Space(05)+"Valor Dia Mes Seg .....: " + Transform(SRH->RH_SALDIA1,"@E 999,999.99")				//"Valor Dia Mes Seg: "
			    @ nLi,079 PSAY "|"						
			nLi:=nLi+1
			
			cDiasFMes := If(SRR->(dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" +; 
									Dtos(dDtBusFer) + aCodFol[072,1])), Transform(SRR->RR_HORAS, "@E 999,999.99"), Space(11))
									
			cDiasFMesSeg := If(SRR->(dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" +; 
										Dtos(dDtBusFer) + aCodFol[073,1])), Transform(SRR->RR_HORAS, "@E 999,999.99"), Space(11))									
			
			@ nLi,001 PSAY "| Dias Ferias Mes:        " + cDiasFMes +;					//"Dias Ferias Mes: "
			    Space(05)+"Dias Ferias Mes:         " + cDiasFMesSeg						//"Dias Ferias Mes Seg: "
			@ nLi,079 PSAY "|"						
			
			cDiasAbMes := If(SRR->(dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" +; 
										Dtos(dDtBusFer) + aCodFol[074,1])), Transform(SRR->RR_HORAS, "@E 999,999.99"), Space(11))
									
			cDiasAbMSeg := If(SRR->(dbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" +; 
										Dtos(dDtBusFer) + aCodFol[205,1])), Transform(SRR->RR_HORAS, "@E 999,999.99"), Space(11))												
			
			nLi:=nLi+1			
			@ nLi,001 PSAY "| Dias Abono Mes:         " + cDiasAbMes +;	//"Dias Abono Mes: "
			Space(04) + "Dias Abono Mes Seg: " + cDiasAbMSeg		//"Dias Abono Mes Seg: "
			@ nLi,079 PSAY "|"									
			nLi:=nLi+1															
			@ nLi,001 PSAY "*" + cReplic77 + "*"
			nLi:=nLi+1
			@ nLi,001 PSAY STR0079	//"|          P R O V E N T O S           |           D E S C O N T O S          |"
			nLi:=nLi+1
			@ nLi,001 PSAY "|-----------------------------------------------------------------------------|"
			nLi:=nLi+1
			//Cod##Verba##Q/H##Valor
			@ nLi,001 PSAY "| " + "Cod" + " " + "Verba" + Space(8) + "Q/H" + Space(11) + "Valor" + " | " +;
							"Cod" + " " + "Verba" + Space(8) + "Q/H" + Space(11) + "Valor"
							
			@ nLi,079 PSAY "|"						
			nLi:=nLi+1
			
			//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
			//?Impressao das Verbas                                         ?
			//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
			nMaximo := MAX(Len(aPDV),Len(aPdd))
			SRR->(DbSetOrder(1))

			For nConta :=1 TO nMaximo
			
				If nConta > Len(aPdv)
					DET := Space(37) + "| "
				Else
					SRR->(DbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + DToS(dDtBusFer) + aPdv[nConta,1]) )										
					nQtdHoras := SRR->RR_HORAS					
					cDesc := Left(DescPd(aPdv[nConta,1],SRA->RA_FILIAL),11)					
					DET := aPdv[nConta,1] + " " + cDesc + " " + Transform(nQtdHoras, '@E 999.99') +; 
						Transform(aPdv[nConta,2],'@E 999,999,999.99')+" | "						
				Endif
			
				If nConta > Len(aPdd)
					DET += Space(37) + "|"
				Else					
					SRR->(DbSeek(SRA->RA_FILIAL + SRA->RA_MAT + "F" + DToS(dDtBusFer) + aPdd[nConta,1]) )										
					nQtdHoras := SRR->RR_HORAS										
					cDesc := Left(DescPd(aPdd[nConta,1],SRA->RA_FILIAL),11)
					DET += aPdd[nConta,1] + " " + cDesc + " " + Transform(nQtdHoras, '@E 999.99') +; 
						Transform(aPdd[nConta,2],'@E 999,999,999.99')+" |"						
				Endif
			
				@ nLi,1 PSAY '| '+DET
				nLi:=nLi+1
				
			Next
			
			nTvp := 0.00
			nTvd := 0.00
			AeVal(aPdv,{ |X| nTVP:= nTVP + X[2]})    // Acumula Valores
			AeVal(aPdd,{ |X| nTVD:= nTVD + X[2]})
			
			@ nLi,001 PSAY "|                                      |                                      |"
			nLi:=nLi+1
			@ nLi,001 PSAY  STR0080+Trans(nTvp,"@E 999,999,999.99")+" "+;	//"| Total Proventos......:"
			STR0081+Trans(nTvd,"@E 999,999,999.99")+" |"							//"| Total Descontos......:"
			nLi:=nLi+1
			@ nLi,001 PSAY "*" + cReplic77 + "*"
			nLi:=nLi+1
			
			cLiqReceber := Trans(nTvp-nTvd,"@E 999,999,999.99") 														
									
			@ nLi,001 PSAY	"| Liquido a receber.." + cLiqReceber//"| Liquido a receber.." +Trans(nTvp-nTvd,"@E 999,999,999.99")
			@ nLi,079 PSAY "|"			 
			nLi:=nLi+1			
			@ nLi,001 PSAY "*" + cReplic77 + "*"
			nLi:=nLi+1
			@ nLi,001 PSAY "|" + SPACE(02) + "Empresa:   " + SubStr(aInfo[3]+Space(40),1,40) + Space(23) + " |"	//"Empresa: "
			nLi:=nLi+1
			@ nLi,001 PSAY "|" + SPACE(02) + STR0083 + SubStr(aInfo[4]+Space(30),1,30)+STR0084+SubStr(aInfo[7]+Space(8),1,8)		//"Estabelecida a "###"   -  Cep: "
			@ nLi,079 PSAY "|"
			nLi:=nLi+1
			@ nLi,001 PSAY "|" + SPACE(02) + STR0085 + SubStr(aInfo[5]+Space(25),1,25)+STR0086+aInfo[6] + Space(27)+"|"	//"Cidade: "###"   -     UF: "
			cExt   := EXTENSO(nTvp-nTvd,.F.,1)
			
			SepExt(cExt,52,77,@cRet1,@cRet2)
			
			nLi:=nLi+1

            @ nLi,001 PSAY "|  "
			@ nLi,79  PSAY "|"
            
            nLi:=nLi+1
				
			@ nLi,001 PSAY "|  Declaro estar ciente que o pagamento desta importancia sera efetuado em    |"
            nLi:=nLi+1
			
            @ nLi,001 PSAY "|  04 parcelas mensais e consecutivas, sendo certo de que o vencimento da     |"
            nLi:=nLi+1                  

            @ nLi,001 PSAY "|  primeira delas sera 30 (trinta) dias apos o efetivo inicio do gozo         |"
            nLi:=nLi+1
		
            @ nLi,001 PSAY "|  Os pagamentos serao efetuados mediante deposito bancario                   |"
            nLi:=nLi+1
			
            @ nLi,001 PSAY "|  cujos comprovantes servirao de recibo, dando assim a plena e geral quitacao|"
            nLi:=nLi+1
			

			If nDtRec == 1
				@ nLi,001 PSAY "|  "+ALLTRIM(aInfo[5])+", "+StrZero(Day(SRH->RH_DTRECIB),2)+STR0097+MesExtenso(MONTH(SRH->RH_DTRECIB))+STR0097+STRZERO(YEAR(SRH->RH_DTRECIB),4)	//" de "###" de "
				@ nLi,79  PSAY "|"
			Else
				@ nLi,001 PSAY "|  "
				@ nLi,79  PSAY "|"
			Endif
			nLi:=nLi+1
			@ nLi,001 PSAY "|" + SPACE(77) + "|"
			nLi:=nLi+1
			@ nLi,001 PSAY STR0098	//"|                         Assinatura do Empregado:__________________________  |"
			nLi:=nLi+1
			@ nLi,001 PSAY "|" + SPACE(077) + "|"
			nLi:=nLi+1
			@ nLi,001 PSAY "*" + cReplic77 + "*"
			nLi:=nLi+1			
			
		Endif
		nLi := 1
	Endif
	
Else
	//--> Impressao do Aviso de Ferias e/ou Sol.Abono e/ou Sol. 1.Parc. 13. sem ter calculado.
	//--> Se nao ha calculo gerado o CC para as apcoes abaixo a ser utilizado eh da tabela SRA.
	If M->RH_DFERIAS > 0 .and. SRA->RA_SITFOLH <> "D"
		If nLi > 35
			nLi := 1
		Endif
	
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//?Aviso de Ferias                                              ?
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		If nAviso == 1 // Imprimi Aviso de Ferias, caso parametro "Imprimi Aviso" esteja como Sim
			If nLi > 35 
				nLi := 1
			Endif
			
			@ nLi+01,001 PSAY "*" + cReplic77 + "*"
			@ nLi+02,001 PSAY "|" + SPACE(30) + STR0099 + SPACE(30)+"|"	//" AVISO DE FERIAS "
			@ nLi+03,001 PSAY "|" + SPACE(30) +" =============== "+SPACE(30)+"|"
			@ nLi+04,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+05,001 PSAY "|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", "+SUBSTR(DTOC(M->RH_DTAVISO),1,2)+STR0097+MesExtenso(MONTH(M->RH_DTAVISO))+STR0097+str(year(m->rh_dtaviso),4)	//" DE "###" DE "
			@ nLi+05,079 PSAY "|"
			@ nLi+06,001 PSAY "|" + SPACE(77)+ "|"
			@ nLi+07,001 PSAY "|" + SPACE(07)+ STR0100 +SPACE(60) + "|"	//"A(O) SR(A)"
			@ nLi+08,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+09,001 PSAY "|" + SPACE(07) + Left(SRA->RA_NOME,30) + Space(39) + " |"

			cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )

			cLinha:= "|" + SPACE(07) + STR0101 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(8)+"C.CUSTO: "	//"CTPS = "###"DEPTO: "
			nTamSpaco := 78 - len(cLinha+cDesc)
			cLinha:= cLinha+cDesc+SPACE(nTamSpaco)+"|"
			@ nLi+10,001 PSAY cLinha
			lDepto	:= CpoUsado("RA_DEPTO") .And. !EMPTY(SRA->RA_DEPTO)
			IF lDepto 
				@ nLi+11,001 PSAY "|" + SPACE(39) + STR0028 + ( fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC') ) ; @ nLi+11,079 PSAY "|"
			Else
				@ nLi+11,001 PSAY "|"; @ nLi+11,079 PSAY "|"
			EndIF
			@ nLi+12,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+13,001 PSAY "|" + SPACE(16) + STR0103+SPACE(04)+"|"	//"Nos  termos da legislacao  vigente,  suas  ferias   serao"
			@ nLi+14,001 PSAY "|" + SPACE(07) + STR0104+SPACE(27)+"|"	//"concedidas conforme o demonstrativo abaixo:"
			@ nLi+15,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+16,001 PSAY "|" + SPACE(06) + STR0105+SPACE(07)+STR0106+SPACE(06)+STR0107+SPACE(03)+"|"	//"Periodo Aquisitivo:"###"Periodo de Gozo:"###"Retorno ao Trabalho:"
			@ nLi+17,001 PSAY "|" + SPACE(04) + PADR(DTOC(M->RH_DATABAS),10)+STR0108+PADR(DTOC(M->RH_DBASEAT),10)+SPACE(02)+PADR(DTOC(DAAUXI),10)+STR0108+PADR(DTOC(DAAUXF),10)+SPACE(6)+PADR(DTOC(DAAUXF+1),10)+SPACE(09)+"|"	//" A "###" A "
			@ nLi+18,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+19,001 PSAY "|" + SPACE(16) + STR0109 + SPACE(4) + "|"	//"A remuneracao correspondente as ferias e, se for o  caso,"
			@ nLi+20,001 PSAY "|" + SPACE(07) + STR0110							//"ao abono pecuniario e ao adiantamento da  gratificacao  de  natal,    |"
			@ nLi+21,001 PSAY "|" + SPACE(07) + STR0111 + PADR(DTOC(M->RH_DTRECIB),10)+"."+SPACE(4)+"|"	//"encontra-se no  caixa  e  podera ser recebida  no  dia "
			@ nLi+22,001 PSAY "|" + SPACE(16) + STR0112 + SPACE(4) + "|"	//"Solicitamos  apresentar  a  sua  carteira  de trabalho  e"
			@ nLi+23,001 PSAY "|" + SPACE(07) + STR0113							//"previdencia social ao depto pessoal para as anotacoes necessarias.    |"
			@ nLi+24,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+25,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+26,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+27,001 PSAY "|" + SPACE(02) + cReplic40+SPACE(01)+cReplic33+SPACE(01)+"|"
			@ nLi+28,001 PSAY "|" + SPACE(02) + SubStr(aInfo[3]+Space(40),1,40)+SPACE(05)+Left(SRA->RA_NOME,30)+"|"
			@ nLi+29,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+30,001 PSAY "*" + cReplic77 + "*"
			nLi:=nLi+30
		Endif
		
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//?Solicitacao 1o Parcela 13o Salario                           ?
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		If nSol13 == 1  // Imprimi Sol.1.Parc.13., caso parametro "Sol. 1.Parc.13.Sal" esteja como Sim
			If nLi > 35
				nLi := 1
			Endif
			@ nLi+01,001 PSAY "*" + cReplic77 + "*"
			@ nLi+02,001 PSAY "|" + SPACE(18) + STR0001	+SPACE(17)+"|"	//" SOLICITACAO DA 1a PARCELA DO 13o SALARIO "
			@ nLi+03,001 PSAY "|" + SPACE(18) +" ======================================== "+SPACE(17)+"|"
			@ nLi+04,001 PSAY "|" + SPACE(77) + "|"
			If dDtSt13 > SRA->RA_ADMISSA
				@ nLi+05,001 PSAY "|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", "+SUBSTR(DTOC(dDTSt13),1,2)+STR0002+MesExtenso(MONTH(dDTSt13))+STR0002+STR(YEAR(dDTSt13),4)	//" de "###" de "
			Else
				@ nLi+05,001 PSAY "|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", "+SUBSTR(DTOC(SRA->RA_ADMISSAO),1,2)+STR0002+MesExtenso(MONTH(SRA->RA_ADMISSAO))+STR0002+STR(YEAR(SRA->RA_ADMISSA),4)	//" de "###" de "
			Endif
			
			@ nLi+05,079 PSAY "|"
			@ nLi+06,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+07,001 PSAY "|" + SPACE(07) + STR0003 +SPACE(69) + "|"	//"A"

			nTamNomEmpresa := 77-(7 + len(aInfo[3]))
			@ nLi+08,001 PSAY "|" + SPACE(07) + aInfo[3] + SPACE(nTamNomEmpresa) + "|"
			@ nLi+09,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+10,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+11,001 PSAY "|" + SPACE(07) + STR0004 + SPACE(53) + "|"	//"Prezados Senhores"
			@ nLi+12,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+13,001 PSAY "|" + SPACE(77) + "|"
			
			@ nLi+14,001 PSAY "|" + SPACE(16) + STR0005 + SPACE(4) + "|"	//"Nos  termos da legislacao vigente, solicito  o  pagamento"
			@ nLi+15,001 PSAY "|" + SPACE(07) + STR0006							//"da  1a  Parcela  do 13o Salario por  ocasiao  do  gozo  de  minhas    |"
			@ nLi+16,001 PSAY "|" + SPACE(07) + STR0007 + SPACE(63) + "|"	//"ferias."
			
			@ nLi+17,001 PSAY "|" + SPACE(16) + STR0008+SPACE(19)+"|"	//"Solicito apor o seu ciente na copia desta."
			@ nLi+18,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+19,001 PSAY "|" + SPACE(77) + "|"
			
			nTamSpaco := 77-(7 + len(SRA->RA_NOME) + 2 + 13 + len(SRA->RA_FILIAL) + 1 +len(SRA->RA_MAT))
			@ nLi+20,001 PSAY "|" + SPACE(07) + SRA->RA_NOME+SPACE(02)+STR0009+SRA->RA_FILIAL+" "+SRA->RA_MAT+SPACE(nTamSpaco)+"|"	//"Registro No: "

			cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )

			nTamSpaco := 77-(7 + 7 + len(SRA->RA_NUMCP) + 3 + len(SRA->RA_SERCP) + 10 + len(cDesc))

			cLinha:= "|" + SPACE(07) + STR0010 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(10)	//"CTPS = "
			cLInha:= cLinha + "C.CUSTO: " + cDesc + Space(nTamSpaco)+"|"
			@ nLi+21,001 PSAY cLinha
			lDepto	:= CpoUsado("RA_DEPTO") .And. !EMPTY(SRA->RA_DEPTO)
			IF lDepto 
				@ nLi+22,001 PSAY "|" + SPACE(39) + STR0028 + ( fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC') ) ; @ nLi+22,079 PSAY "|"
			Else
				@ nLi+22,001 PSAY "|"; @ nLi+22,079 PSAY "|"
			EndIF
			@ nLi+23,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+24,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+25,001 PSAY "|" + SPACE(07) + STR0011+SPACE(18)+STR0012+SPACE(17)+"|"	//"Atenciosamente"###"Ciente em ___/___/___"
			@ nLi+26,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+27,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+28,001 PSAY "|" + SPACE(07) + cReplic22+SPACE(10)+cReplic35+space(03)+"|"
			@ nLi+29,001 PSAY "|" + SPACE(77) + "|"
			@ nLi+30,001 PSAY "*" + cReplic77 + "*"
			nLi:=nLi+30
			
		Endif
	
		//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
		//?Solicitacao Abono Pecuniario                                 ?
		//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
		If nSolAb == 1 // Imprimi Sol.Abono, caso parametro "Sol. Abono Pecun." esteja como Sim
		
			If  M->RF_TEMABPE == "S"  // Ignora funcionarios que nao tem Abono Pecuniario
				
				If nLi > 35
					nLi := 1
				Endif
				
				@ nLi+01,001 PSAY "*" + cReplic77 + "*"
				@ nLi+02,001 PSAY "|" + SPACE(18) +STR0013+SPACE(17)+"|"	//"     SOLICITACAO DO ABONO DE FERIAS       "
				@ nLi+03,001 PSAY "|" + SPACE(18) +"     ==============================       "+SPACE(17)+"|"
				
				@ nLi+04,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+05,001 PSAY "|" + SPACE(28+(20-LEN(ALLTRIM(aInfo[5]))))+ALLTRIM(aInfo[5])+", " +SUBSTR(DTOC(M->RH_DBASEAT-20),1,2)+STR0002+MesExtenso(MONTH(M->RH_DBASEAT-20))+STR0002+STR(YEAR(M->RH_DBASEAT-20),4)	//" de "###" de "
				
				@ nLi+05,079 PSAY "|"
				@ nLi+06,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+07,001 PSAY "|" + SPACE(07) + STR0003 +SPACE(69) + "|"	//"A"
				@ nLi+08,001 PSAY "|" + SPACE(07) + aInfo[3] + SPACE(30) + "|"
				@ nLi+09,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+10,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+11,001 PSAY "|" + SPACE(07) + STR0014 + SPACE(53) + "|"	//"Prezados Senhores"
				@ nLi+12,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+13,001 PSAY "|" + SPACE(77) + "|"
				
				@ nLi+14,001 PSAY "|" + SPACE(16) + STR0015 + SPACE(3) + "|"	//"Nos  termos da legislacao vigente, solicito  a  conversao "
				@ nLi+15,001 PSAY "|" + SPACE(07) + STR0016							//"de  1/3  (Hum Terco)  de  minhas  ferias   relativas  ao   periodo    |"
				@ nLi+16,001 PSAY "|" + SPACE(07) + STR0017 + PADR(DTOC(M->RH_DATABAS),10)+STR0018+PADR(DTOC(M->RH_DBASEAT),10)+STR0019+SPACE(12)+"|"	//"aquisitivo de "###" a "###" em abono pecuniario."
				
				@ nLi+17,001 PSAY "|" + SPACE(16) + STR0020+SPACE(19)+"|"	//"Solicito apor o seu ciente na copia desta."
				@ nLi+18,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+19,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+20,001 PSAY "|" + SPACE(07) + SRA->RA_NOME+SPACE(02)+STR0021+SRA->RA_FILIAL+" "+SRA->RA_MAT+SPACE(16)+"|"	//"Registro No: "

				cDesc := DescCc( SRA->RA_CC, SRA->RA_FILIAL )
	
	
				cLinha:="|" + SPACE(07) + STR0022 + SRA->RA_NUMCP+" - "+SRA->RA_SERCP+SPACE(10)+"C.CUSTO: "+ AllTrim(cDesc)
				@ nLi+21,001 PSAY cLinha
				@ nLi+21,079 PSAY "|"
				lDepto	:= CpoUsado("RA_DEPTO") .And. !EMPTY(SRA->RA_DEPTO)				
				IF lDepto 
					@ nLi+22,001 PSAY "|" + SPACE(39) + STR0028 + ( fDesc('SQB',SRA->RA_DEPTO,'QB_DESCRIC') ) ; @ nLi+22,079 PSAY "|"
				Else
					@ nLi+22,001 PSAY "|"; @ nLi+22,079 PSAY "|"
				EndIF
				@ nLi+23,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+24,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+25,001 PSAY "|" + SPACE(07) + STR0023+SPACE(18)+STR0024+SPACE(17)+"|"	//"Atenciosamente"###"Ciente em ___/___/___"
				@ nLi+26,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+27,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+28,001 PSAY "|" + SPACE(07) + cReplic22+SPACE(10)+cReplic35+SPACE(03)+"|"
				@ nLi+29,001 PSAY "|" + SPACE(77) + "|"
				@ nLi+30,001 PSAY "*" + cReplic77 + "*"
				nLi:=nLi+30
			Endif
		Endif
	Endif
Endif

Return(nil)


/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複?
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇?
굇 袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇?rograma  ?BusGozo  ?utor  ?iago Malta         ?Data ? 04/03/10   볍?
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽?
굇?esc.     ? Fun豫o que busca os periodos e dias de Desfrute de Ferias 볍?
굇?         ?                                                           볍?
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽?
굇?so       ?AP                                                         볍?
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선?
굇?arametros?dIni - Data inicial do periodo aquisitivo                  낢?
굇?         ?dFim - Data Final do periodo aquisitivo                    낢?
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇?
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽?
*/

Static Function fBusGozo(dIni,dFim)

Local aArea		:= SRH->( GetArea() )
Local aGozoFer  := {}

	dbSelectArea("SRH")
	DBSETORDER(1)
	SRH->( DBSEEK(xFilial("SRH")+ SRH->RH_MAT  ))
	
    While SRH->( !EOF() ) .AND. SRH->RH_MAT == SRA->RA_MAT
       	IF SRH->RH_DATABAS == dIni .AND. SRH->RH_DBASEAT == dFim
			aAdd( aGozoFer , { SRH->RH_DATAINI, SRH->RH_DATAFIM ,SRH->RH_DFERIAS } )
    	ENDIF
	    SRH->( DBSKIP() )
    Enddo
	
RestArea(aArea) 

Return(aGozoFer)
