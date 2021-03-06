#Include "Protheus.ch"
#Include "TbiConn.ch"
#Include "TbiCode.ch"
#Include "Topconn.ch"
#Include "Fileio.ch"
#INCLUDE "stdwin.ch"
#include "Rwmake.ch"
#INCLUDE "Ap5Mail.ch"
#Include 'ApWebEx.ch'

/*
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????ͻ??
???Programa  ?BLIMPPED    ?Autor  ?Vanito Rocha      ? Data ?  19/10/2020 ???
?????????????????????????????????????????????????????????????????????????͹??
???Desc.     ? Fun??o que trata da importacao dos Pedidos da Neogrid      ???
???          ?                                                            ???
?????????????????????????????????????????????????????????????????????????͹??
???Uso       ? Especifico Bacio                                           ???
?????????????????????????????????????????????????????????????????????????ͼ??
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
*/

Static Function ProcPedv(aArquivo,oSay)

//Local cServer		:= "ftp://35.199.86.195/"
//Local nPorta 		:=21
Local cPrdCtrl		:=""
//Local cUser			:="neogrid.bacio"
//Local cPass			:="Gel@102315"
//Local aArea      	:= GetArea()
Local xLocal		:=""
Local aMsg			:={}
Local nErro			:=0
Local xProdcl		:=""
Local lIncPd
Local lCodfnd		:=.F.
Local cPrcArq		:=0
Private lExstSA7	:=.F.
Private aSC5       	:= {}
Private _cPed		:=""
Private aSC6       	:= {}
Private aLinha		:= {}
Private aHeader		:= {}
Private nLenVar    	:= SetVarNameLen(255)
Private nX         	:= 0
Private nY         	:= 0
Private nMaxX      	:= 0
Private nMaxY      	:= 0
Private nOpcAuto   	:= 3
Private nQtddel		:=0
Private nQtditem	:=0
Private lSucesso   	:= .T.
Private cString    	:= ""
Private cCliente   	:= ""
Private cCotacao   	:= ""
Private cOrcamento 	:= ""
Private _cItem      := "00"
Private oXML
Private cMailConta
Private cMailServer
Private cMailSenha
Private lMsHelpAuto	:= .T.
Private cLidNeo
Private lMsErroAuto	:= .F.
Private cBuffer   	:= ""
Private cVerItem	:= ""
Private aDados    	:= {}
Private lOk       	:= .T.
Private aMatA030  	:= {}
Private nBtLidos  	:= 0
Private aFiles 		:= {}
//Private nX 			:= 0
Private aErroAuto	:= {}
Private nReg1 		:=  316 // Tamanho da linha no arquivo texto
Private nReg2 		:=  46  // Tamanho da linha no arquivo texto
Private nReg3 		:=  123 // Tamanho da linha no arquivo texto
Private nReg4 		:=  331 // Tamanho da linha no arquivo texto
Private nReg5 		:=  39  // Tamanho da linha no arquivo texto
Private nReg6 		:=  75  // Tamanho da linha no arquivo texto
Private nReg9 		:=  123 // Tamanho da linha no arquivo texto
Private lItem		:= .T.
Private nPosOld
Private xDESCRI, xLOJACLI, xTIPOCLI, _xCOND, xTpReg6
Private cModName
Private cMod 		:= "FAT"
Private _cEmpresa 	:= "01"
Private _cFilial	:= "0072" //Filial que faz a conex?o
Private xUsuario	:= Alltrim(SuperGETMV("MV_USERNEO") )//"neogrid.bacio"
Private xSenha		:= Alltrim(SuperGETMV("MV_SENHANE") ) //"Gel@102315"
Private cRootPath
Private cStarPath
Private cFilName
Private cRelFrom	:= ""
Private cMensaje	:= "Erro de Integracao - Importa??o Pedido NeoGrid"
Private cVNum
Private lnGrv		:= .F.
Private lSchedule 	:= SuperGETMV("MV_XNEOJOB",.F.)
Private cErroPro 	:= ""
Private cOrd		:="01"
Private xTes		:="600"
Private nValSC6		:=0
Private lUsaSA7		:=SuperGETMV("MV_XUSASA7",.F.)
Private lUsaSB1		:=.T.//SuperGETMV("MV_XUSASB1",.F.)
Private xQualAlt	:=""
Private lnSC6		:=.F.
Private aItemNew    := {}
Private xCondcli	:=""
Private lCodbar		:=.F.
Private xCodTab		:= ""
Private xPrcTab     := ""
Private _TbCli      := ""
Private _cServer	:= "ftp://35.199.86.195"
Private _cUser		:= 'neogrid.bacio'
Private _cSenha		:= 'Gel@102315'
Private cNomCli		:= ""

Private xEANComp 	:= ""
Private xEANCodF 	:= ""
Private xEANLocE 	:= ""
Private xEANLozF 	:= ""
Private xEANEmNF 	:= ""

Default aArquivo 	:= {}
Default oSay		:= Nil

If lSchedule
	SetModulo( @cModName , @cMod )
	
	RpcSetType(3)
	PREPARE ENVIRONMENT EMPRESA (_cEmpresa) FILIAL (_cFilial) USER cUsuario PASSWORD xSenha TABLES "SA1","SM0","SCJ","SCK","SE4","SB1" MODULO cMod
	RpcSetEnv(Alltrim(_cEmpresa),Alltrim(_cFilial))
	InitPublic()
	SetsDefault()
	SetModulo( @cModName , @cMod )
	
EndIf

cStarPath	:= AllTrim(GetSrvProfString("Startpath",""))
cRootPath	:= AllTrim(GetSrvProfString("ROOTPATH",""))
cMailConta  := Alltrim(SuperGETMV("MV_RELACNT") )
cMailServer := Alltrim(SuperGETMV("MV_RELSERV"))
cMailSenha  := Alltrim(SuperGETMV("MV_RELPSW"))

If Len(aArquivo) == 0
	ADIR(cLeNeo+ "*.*", aFiles)
Else
	aEval(aArquivo,{|R| aAdd(aFiles,R) })
Endif

aadd(aHeader,{"TES","C6_TES",NIL})


aRet:={}
aParamBox:={}

/*
aAdd(aParamBox,{1,"Operacao",Space(TAMSX3("FM_TIPO")[1]),"SM","EXISTCPO('SFM',MV_PAR01)","DJ","",20,.T.}) // Tipo caractere
If ! ParamBox(aParamBox,"Informe a Operacao...",@aRet)
	Return
Endif
*/

xTes	:= "SM"
_cPed	:= ""

For nX := 1 to Len(aFiles)
	
	aSC5		:= {}
	aSC6        := {}
	nLidos		:= 0
	if alltrim(aFiles[nX,2]) == "Local"
		nHdl 		:= fOpen(cLeNeo+aFiles[nX,1],0)
	else
		nHdl 		:= fOpen(substr(cLeNeo,4)+aFiles[nX,1],0)
	endif

	nTamFile 	:= fSeek(nHdl,0,2)//Tamanho do Arquivo
	fSeek(nHdl,0,0)
	cBuffer  	:= Space(nTamFile)
	cVerItem	:= Space(nTamFile)
	fRead(nHdl,@cBuffer,nReg1)
	
	cVNum		:= Alltrim(Substr(cBuffer,009,20)) //N?mero do Pedido ? passado como tamanho de 8 pela Neogrid
	If oSay != Nil
		oSay:SetText("Importando Pedido Neogrid: " + cVNum )
	Endif
	DbSelectArea("SC5")
	DbOrderNickName("C5XCLI")
	If DbSeek(xFilial("SC5")+cVNum) //Criar um Indice para o Pedido do Cliente para que ao veriricar se o pedido informado no arquivo j? exista ser? uma altera??o ou exclus?o.
		lnGrv 	:= .T.
		
		_cPed:=SC5->C5_NUM

		MsgAlert("ATEN??O: Pedido Cliente: " + cVNum  + " Pedido Protheus: " + SC5->C5_NUM + " J? existe na base!"  )

		/*
		nOpcAuto=3=Inclus?o
		nOpcAuto=4=Alteracao
		nOpcAuto=5=Exclusao
		
		No Manual da Neogrid e na posi??o 11 ate a 13 ? passado os c?digos abaixo:
		C?digo		Descri??o
		1			Adicionar
		2			Excluir
		3			Alterar
		11			N?o Alterada
		
		Para a Op??o 1 a rotina j? faz autom?ticamente., somente se j? existir o pedido do cliente na base ? que ser? tratado a altera??o ou a exclus?o.
		*/
	EndIf
	aSC6 := {}
	While nLidos < nTamFile //.AND. !lnGrv
		
		// Capturar dados
		
		If subs(cbuffer,0,02) == "01"
			
			xFILIAL		:= xFilial()
			xPEDCLI		:= Alltrim(Substr(cBuffer,009,20))
			xCnpjComp	:= Alltrim(Substr(cBuffer,209,14))
			
			SA1->(DbSetOrder(3))//Verificar indice
			If SA1->(DbSeek(xFiliAL("SA1") + xCnpjComp))
				xTIPOCLI	:=	SA1->A1_TIPO
				xLOJACLI	:=	SA1->A1_LOJA
				xCLIENTE	:=  SA1->A1_COD
				xCondcli	:=  SA1->A1_COND
				//xTes		:=  SA1->A1_XTES
				xCodTab		:=  SA1->A1_TABELA
				cNomCli		:= SA1->A1_NOME
				
				Reclock("SA1",.F.)
					SA1->A1_XNEOGRI:='1'
				MsUnlock()
				
				_TbCli		:=Substr(SA1->A1_OBSERV,1,3)
				
			Else
				cErroPro 	+= "Cliente nao encontrado, CNPJ: " + xCnpjComp + CHR(13) + CHR(10) + CHR(13) + CHR(10)
				xTIPOCLI	:=	" "
				xLOJACLI	:=	"XX"
				xCLIENTE	:=  "XXXXXX"
				
				cMensaje:="Integracao Neogrid - Erro na inclusao de Pedido de Vendas - Numero " + _cPed + " Erro no arquivo: " + Alltrim(aFiles[nX,1])+ CHR(13) + CHR(10)
				
				nErro++
				
			Endif
			//Registro 01
			xTpReg		:= "01"
			xFumsg		:= "09"
			xTpPed		:= "001"
			xEMISSAO	:= STOD(Substr(cBuffer,049,04)+SubStr(cBuffer,053,2)+Substr(cBuffer,055,02))
			xHorEms		:= Alltrim(Substr(cBuffer,057,04))
			xDtEntre	:= Alltrim(Substr(cBuffer,061,8 ))
			xLocCob		:= Alltrim(Substr(cBuffer,141,13))
			xLocEntr	:= Alltrim(Substr(cBuffer,154,13))
			xCnpjFor	:= Alltrim(Substr(cBuffer,167,14))
			xCnpjCob 	:= Alltrim(Substr(cBuffer,195,14))
			xCnpjEntr   := Alltrim(Substr(cBuffer,209,14))
			xTPFRETE	:= Alltrim(Substr(cBuffer,270,03))
			
			xEANComp 	:= Alltrim(substr(cbuffer,114,13))
			xEANCodF 	:= Alltrim(substr(cbuffer,127,13))
			xEANLocE 	:= Alltrim(substr(cbuffer,140,13))
			xEANLozF 	:= Alltrim(substr(cbuffer,153,13))
			xEANEmNF 	:= Alltrim(substr(cbuffer,185,13))

			fRead(nHdl,@cBuffer,nReg2)
			
			nLidos+=nReg1
			
		endif
		
		If subs(cbuffer,1,02) == "02"
			
			//Registro 02
			xTpReg2		:= "02"
			_xCOND		:= Alltrim(Substr(cBuffer,03,03)) //a comndi??o de pagamento vem sempre apenas um Caracter
			
			SE4->(DbSetOrder(2))
			If SE4->(DbSeek(xFilial("SE4") + _xCOND))
				_xCOND := SE4->E4_CODIGO
				
			Else
				
				_xCOND:=xCondcli
				
			EndIf
			
			xEmsPg		:= Alltrim(Substr(cBuffer,06,03))
			xTpPer		:= Alltrim(Substr(cBuffer,12,03))
			xNumPer		:= Alltrim(Substr(cBuffer,15,03))
			xDtVenc		:= Alltrim(Substr(cBuffer,18,08))
			xNvalPg		:= Alltrim(Substr(cBuffer,26,15))
			
			fRead(nHdl,@cBuffer,nReg3)
			
			nLidos+=nReg2
			
		endif
		
		If subs(cbuffer,1,02) == "03"
			
			//Registro 03
			xTpReg3		:= "03"
			xPercDesc	:= Val(Substr(cBuffer,03,05))
			xValDesc	:= Val(Substr(cBuffer,08,15))
			xPDescCom	:= Val(Substr(cBuffer,23,05))
			xPrcEncFi	:= Val(Substr(cBuffer,63,05))
			
			fRead(nHdl,@cBuffer,nReg4)
			
			nLidos+=nReg3
			
		EndIf
		
		If subs(cbuffer,0,02) == "04"
			
			While lItem
				
				//Registro 04
				xTpReg4		:= "04"
				xNumSeq		:= Alltrim(Substr(cBuffer,03,04))
				_xITEM		:= Alltrim(Substr(cBuffer,07,05))
				xITEM		:= strzero(val(_xITEM),02)
				/*Qualificador da altera??o, ser? utilizado na altera??o, inclus?o e exclus?o do Pedido.
				Campo utilizado no processo de altera??o de pedido, informando o status do item em quest?o.
				Salienta-se que este campo s? ser? utilizado quando houver acerto entre as partes para emiss?o de documentos de Altera??o de Pedido (ORDCHG).
				1 - Adicionar
				2 - Excluir
				3 - Alterar
				*/
				xQualAlt    := Alltrim(Substr(cBuffer,12,03))
				
				If xQualAlt='2'
					nOpcAuto:=5
				Elseif xQualAlt='3'
					nOpcAuto:=4
				Endif


				xPRODUTO	:= Alltrim(Substr(cBuffer,018,14))
				
				If Empty(xPRODUTO)
					xPRODUTO	:= Alltrim(Substr(cBuffer,072,15))
					
				Else
					
					xPRODUTO	:= xPRODUTO
					
					lCodbar:=.T.
					
				Endif
				
				//Produto controle, caso o c?digo enviado no arquivo n?o exista no cadastro de produtos da Bacio
				cPrdCtrl:=xPRODUTO
				
				//Criado Indice Para que se possa fazer amarra??o entre o Produto Bacio e o Produto que ? enviado pelo Cliente atrav?s do Neogrid
				//O indice abaixo da SA7 foi comentado a pedido do Douglas Silva, segundo o mesmo a consist?ncia deve ser feita pelo B1_CODBAR, apenas para registros deixei comentado.
				If lCodbar
					DbSelectArea("SB1")
					DbSetOrder(5)
					If SB1->(DbSeek(xFilial("SB1")+xPRODUTO,.F.))
						xPRODUTO := SB1->B1_COD
						xLocal	:= "700023"
						xDESCRI	:=	SB1->B1_DESC
					Endif
				Endif
				
				lExstSA7:=.F.

				xLocal:='700023'

				DbSelectArea("SA7")
				DbOrderNickName("BLSA7")
				If SA7->(DbSeek(xFilial("SA7")+xCLIENTE+xLOJACLI+xPRODUTO))
					xPRODUTO := SA7->A7_PRODUTO
					lExstSA7:=.T.
					
				Else

					//BN0030004000504 - PD_20212011788556
					If !lExstSA7
					Do Case
							Case xPRODUTO="BN0030004000500"
								xProdcl:=xPRODUTO
								xPRODUTO:="BN0030004005500"
							Case xPRODUTO="BN0030004000523"
								xProdcl:=xPRODUTO
								xPRODUTO:="BN0030004005523"
							Case xPRODUTO="BN0030004000527"
								xProdcl:="BN0030004005527"
								xPRODUTO:="BN0030004005527"
							Case xPRODUTO='BN0030004000510'
								xProdcl:='BN0030004000510'
								xPRODUTO='BN0030004000510'
							Case xPRODUTO="BN0030004000541"
								xProdcl:=xPRODUTO
								xPRODUTO:="BN0030004005541"
							Case xPRODUTO="BN0030004000504"
								xProdcl:=xPRODUTO
								xPRODUTO:="BN0030004005504"
							Case xPRODUTO="BN0030004000524"
								xProdcl:=xPRODUTO
								xPRODUTO:="BN0030004005524"
							Case xPRODUTO="BN0030004000515"
								xProdcl:=xPRODUTO
								xPRODUTO:="BN0030004005515"
							Case xPRODUTO="BN0030004001500"
								xProdcl:=xPRODUTO
								xPRODUTO:="BN0030004005510"
							Case xPRODUTO="BN0030004000527"
								xProdcl:=xPRODUTO
								xPRODUTO:="BN0030004005527"
							Case xPRODUTO="BN0030004005527"
								xProdcl:=xPRODUTO
								xPRODUTO:="BN0030004005527"
							Case xPRODUTO="BN0030004000502"
								xProdcl:=xPRODUTO
								xPRODUTO:="BN0030004000502"

							Reclock("SA7",.T.)
							SA7->A7_CLIENTE:=xCLIENTE
							SA7->A7_LOJA:=xLOJACLI
							SA7->A7_PRODUTO:=xPRODUTO
							SA7->A7_CODCLI:=xProdcl
							Msunlock()
							
							xPRODUTO:=SA7->A7_PRODUTO
						EndCase
														
						DbSelectArea("SB1")
						DbSetOrder(1)
						If SB1->(DbSeek(xFilial("SB1")+xPRODUTO,.F.))
							xPRODUTO := SB1->B1_COD
							xLocal	:= "700023"
							xDESCRI	:=	SB1->B1_DESC
								
							If SB1->B1_MSBLQL="1"
									
								cErroPro 	+= "O produto esta bloqueado para uso, codigo "+ xPRODUTO + CHR(13) + CHR(10) + CHR(13) + CHR(10)
									
								cMensaje:="Integracao Neogrid - Erro na inclusao de Pedido de Vendas - Numero " + _cPed + " Erro no arquivo: " + Alltrim(aFiles[nX,1])+ CHR(13) + CHR(10)
									
								nErro++
									
							EndIF
						Else
								cErroPro 	+= "Produto nao encontrado, codigo: " + xPRODUTO + CHR(13) + CHR(10) + CHR(13) + CHR(10)
								
								cMensaje:="Integracao Neogrid - Erro na inclusao de Pedido de Vendas. Erro no arquivo: " + Alltrim(aFiles[nX,1])+ CHR(13) + CHR(10)
								
								nErro++
								
								lCodfnd:=.F.
								
						EndIF
							
					Endif
				Endif

				DbSelectArea("SB2")
				DbSetOrder(1)
				If !SB2->(dbSeek(xFilial("SB2")+xPRODUTO+xLocal))
					CriaSb2(xPRODUTO,xLocal)
				Endif
				
				xUM			:= Alltrim(Substr(cBuffer,092,03))
				xQTDVEN		:= IIF(VAL(Substr(cBuffer,100,1))>0,VAL(Substr(cBuffer,101,15)),VAL(Substr(cBuffer,100,15))) /100
				xPRCVEN		:= Transform(VAL(Substr(cBuffer,153,15)),"@E 999,99")
				xVALOR		:= Transform(VAL(Substr(cBuffer,168,15)),"@E 999,99")
				xValBrut	:= Transform(VAL(Substr(cBuffer,183,15)),"@E 999,99")
				xValLiq 	:= Transform(VAL(Substr(cBuffer,198,15)),"@E 999,99")
				xValDesc	:= Transform(VAL(Substr(cBuffer,221,15)),"@E 999,99")
				xPercDesc	:= Transform(VAL(Substr(cBuffer,236,05)),"@E 999,99")
				xVlIpi		:= Transform(Val(Substr(cBuffer,241,15)),"@E 999,99")
				xAlIpi		:= Transform(Val(Substr(cBuffer,256,05)),"@E 999,99")
				

				If SB1->(DbSeek(xFilial("SB1")+xPRODUTO,.F.))
					xPRODUTO := SB1->B1_COD
					xLocal	:= "700023"
					xDESCRI	:=	SB1->B1_DESC
				Endif
				
				//Tratamento para pegar o valor do produto da tabela de Pre?os, caso o valor recebido no arquivo esteja diferente n?o deixar subir.
				DbSelectArea("DA1")
				DbSetOrder(1)
				If DbSeek(xFilial("DA1")+xCodTab+xPRODUTO) //xCodTab ap?s retorno da TOTVS substitui a vari?vel _TbCli pela xCodTab
					xPrcTab:= DA1->DA1_PRCVEN
				Else
					xPrcTab:=0
					cErroPro +="Nao existe pre?o de vendas cadastrado na Tabela de precos para o produto " + xPRODUTO + "  o valor que sera assumido sera o que consta no arquivo enviado pelo cliente caso o problema nao seja o cadastro do produto, por favor verificar" + CHR(13) + CHR(10)
					
					cMensaje:="Integracao Neogrid - Erro na inclusao de Pedido de Vendas. Erro no arquivo: " + Alltrim(aFiles[nX,1])+ CHR(13) + CHR(10)
					
				Endif
				
				cPrcArq:=xPRCVEN
				
				xPRCVEN:=xValLiq
				
				cPrcArq:=xValLiq
				
				If Transform(cPrcArq,"@E 999,99") <> Transform(xPrcTab,"@E 999.99")
					
					cErroPro 	+= "O valor unitario do item no arquivo esta divergente da tabela de pre?os associada ao cliente, tabela "+ xCodTab + ", valor no arquivo " + Transform(cPrcArq,"@E 999,99")+ " valor na tabela " + Transform(xPrcTab,"@E 999.99") + " produto " + xPRODUTO + " O valor assumido para o item sera o da tabela de pre?os. Verifique o pedido apos a insercao no sistema. " + CHR(13) + CHR(10) + CHR(13) + CHR(10)
					
					cMensaje:="Integracao Neogrid - Erro na inclusao de Pedido de Vendas - Numero " + _cPed + " Erro no arquivo: " + Alltrim(aFiles[nX,1])+ CHR(13) + CHR(10)
					
				Endif
				
				If nOpcAuto == 4
					dbSelectArea("SC6")
					dbSetOrder(2)
					If dbSeek(xFilial("SC6")+PADR(xPRODUTO,TAMSX3("B1_COD")[1])+_cPed,.F.)
						_cItem := SC6->C6_ITEM
					ElseIf Len(aItemNew) == 0
						SC6->(dbGotop())
						dbSelectArea("SC6")
						dbSetOrder(1)
						dbSeek(xFilial("SC6")+_cPed,.F.)
						While SC6->( !Eof() ) .And. SC6->C6_NUM == _cPed .And. SC6->C6_FILIAL == xFilial("SC6")
							_cItem := SC6->C6_ITEM
							SC6->( dbSkip() )
						EndDo
						_cItem := Soma1(_cItem)
						aAdd(aItemNew,_cItem)
						//tratamento para retorno
					Else
						_cItem := Soma1(aItemNew[Len(aItemNew)])
						aAdd(aItemNew,_cItem)
					Endif
				Endif
				
				aLinha := {}
				//Adicio Array para ExecAuto
				If xQualAlt=="2" .And. aScan(aItemNew,{|R| R == _cItem }) == 0
					aadd(aLinha,{"LINPOS","C6_ITEM",_cItem})
					aadd(aLinha,{"AUTDELETA","S",Nil})
					nOpcAuto:=4
					nQtddel++
				ElseIf xQualAlt=="3" .And. aScan(aItemNew,{|R| R == _cItem }) == 0
					aadd(aLinha,{"LINPOS","C6_ITEM",_cItem})
					aadd(aLinha,{"AUTDELETA","N",Nil})
					
				ElseIf xQualAlt == "11" .Or. Empty(xQualAlt)
					
					If nOpcAuto==4 .AND. !Empty(xQualAlt)
						nLidos+=331
						nPosArq := fSeek(nHdl,0,1) //Posi??o Atual
						nReg9 := LEN(cBuffer)
						If nReg9 == 0
							fRead(nHdl,@cBuffer,331)
							@cBuffer := SubStr(cbuffer,2,AT(" ",cbuffer)+123)
						Else
							fRead(nHdl,@cBuffer,nReg9)
						EndIF
						
						cCmpPrd := SubStr(cbuffer,1,AT("04",cbuffer)+1)
						If SubStr(cbuffer,1,AT("04",cbuffer)+1) == "04" .OR. Alltrim(StrZero(Val(cCmpPrd),2)) == "04"
							SB1->(DbSkip())
						Else
							lItem := .F.
							Exit
						EndIF
						Loop
					Endif
				Endif
				
				If nOpcAuto == 3 .Or. aScan(aItemNew,{|R| R == _cItem }) > 0
					_cItem := iif(nOpcAuto==3,Soma1(_cItem),_cItem)
					aadd(aLinha,{"C6_ITEM"	 ,_cItem										, Nil})
				Endif
				
				aadd(aLinha,{"C6_PRODUTO",xPRODUTO											 , NIL})
				//aadd(aLinha,{"C6_DESCRI" ,xDESCRI											 , NIL})
				aadd(aLinha,{"C6_QTDVEN" ,xQTDVEN											 , NIL})
				//aadd(aLinha,{"C6_PRCVEN" ,Val(xPRCVEN)										 , NIL})
				//aadd(aLinha,{"C6_PRUNIT" ,Val(xPRCVEN)										 , NIL})
				//aadd(aLinha,{"C6_VALOR" ,xQTDVEN*Val(xPRCVEN)								 , NIL})
				//aadd(aLinha,{"C6_LOCAL"	 ,xLocal											 , NIL})
				aadd(aLinha,{"C6_OPER"	 ,xTes												 , NIL})
				//aadd(aLinha,{"C6_CF"	 ,Posicione("SF4", 1, SF4->(xFilial())+xTes, "F4_CF"), NIL})
				aadd(aLinha,{"C6_NUM"	 ,_cPed												 , NIL})
				aadd(aLinha,{"C6_PEDCLI" ,cVNum												 , NIL})
				aadd(aLinha,{"C6_CLI"	 ,xCLIENTE											 , NIL})
				aadd(aLinha,{"C6_LOJA"	 ,xLOJACLI											 , NIL})
				
				If Empty(cErroPro)
					If nErro=0
						
						lIncPd:=.F.
						
					Endif
				Else
					
					lIncPd:=.T.
					
					If nErro=0
						_cPed:=_cPed
					Else
						_cPed:='XXXXXX'
					Endif
					
				Endif
								
				aAdd(aMsg, {{xPRODUTO,FwCutOff(XDESCRI,.T.),Transform(XQTDVEN,PesqPict("SC6","C6_QTDVEN")),Transform(xPrcTab,"@E 999.99"),Transform(xPRCVEN,"@E 999,99"), "" ,cErroPro}})
				
				cErroPro:=""
				
				//cErroPro
				//checar se a condi??o enviada pelo cliente ? uma exclus?o.
				aadd(aSC6,aLinha)
								
				If xQualAlt <>"2"
					nQtditem++
				Endif
				
				nLidos+=nReg4
				nPosArq := fSeek(nHdl,0,1) //Posi??o Atual
				nReg9 := LEN(cBuffer)
				If nReg9 == 0
					fRead(nHdl,@cBuffer,331)
					@cBuffer := SubStr(cbuffer,2,AT(" ",cbuffer)+123)
				Else
					fRead(nHdl,@cBuffer,nReg9)
				EndIF
				
				cCmpPrd := SubStr(cbuffer,1,AT("04",cbuffer)+1)
				If SubStr(cbuffer,1,AT("04",cbuffer)+1) == "04" .OR. Alltrim(StrZero(Val(cCmpPrd),2)) == "04"
					SB1->(DbSkip())
				Else
					lItem := .F.
					Exit
				EndIF
				DbSkip()
			EndDo
			
		EndIf
		/*
		If subs(cbuffer,0,02) == "05"
		
		//Registro 05
		xTpReg5		:= "05"
		xTpCdPrd	:= Alltrim(Substr(cBuffer,003,03))
		xCdPrd5		:= Alltrim(Substr(cBuffer,006,14))
		xQtdP5		:= Val(Substr(cBuffer,020,15))
		xUMRg5		:=	Alltrim(Substr(cBuffer,035,03))
		
		fRead(nHdl,@cBuffer,nReg6)
		nLidos+=36
		
		EndIf
		
		If subs(cbuffer,0,02) == "06"
		
		//Registro 06
		xTpReg6		:= "06"
		xQtdP6		:= Val(Substr(cBuffer,054,15)) / 100
		xNUMRg6		:= Alltrim(Substr(cBuffer,069,03))
		
		fRead(nHdl,@cBuffer,nReg9)
		nLidos+=70
		
		EndIf
		*/
		
		cCmpPrd2 := SubStr(cbuffer,2,AT("09",cbuffer))
		
		If subs(cbuffer,0,02) == "09" .Or. Alltrim(StrZero(Val(cCmpPrd2),2)) == "09"
			//Registro 09
			xTpReg6		:= "09"
			xVTotM		:= Val(Substr(cBuffer,003,15))
			xVTIPI		:= Val(Substr(cBuffer,018,15))
			xVTAbat		:= Val(Substr(cBuffer,033,15))
			xVTEnc		:= Val(Substr(cBuffer,048,15))
			xVTDCon		:= Val(Substr(cBuffer,063,15))
			xVTotP		:= Val(Substr(cBuffer,108,15))
			
		EndIf
		FCLOSE(nHdl)
		//???????????????????????????????????????????????????????????????????Ŀ
		//?Processa o cabecalho do Orcamento de Venda                         ?
		//?????????????????????????????????????????????????????????????????????
		If xTpReg6 == "09"
			If ( Len(aSC6) > 0 )
				If !lnGrv
				
					_cPed := GetSxeNum("SC5","C5_NUM")
					
				Endif
				aadd(aSC5,{"C5_NUM" 		, _cPed, NIL})
				aadd(aSC5,{"C5_TIPO"		,"N", NIL})
				aadd(aSC5,{"C5_EMISSAO"		,dDataBase,Nil})//xEMISSAO
				aadd(aSC5,{"C5_CLIENTE"		,xCLIENTE,Nil})
				aadd(aSC5,{"C5_LOJACLI"   	,xLOJACLI,Nil})
				aadd(aSC5,{"C5_FECENT"		,Stod(xDtEntre),Nil})
				aadd(aSC5,{"C5_XPEDCLI"		,xPEDCLI,Nil})
				aadd(aSC5,{"C5_XINFNEO",Alltrim(aFiles[nX,1])+ "|"+Dtoc(dDataBase)+ "|" + SUBSTR(TIME(),1,5)+"|"+UPPER(UsrRetName(__cUserID)),Nil})
				/*
				aadd(aSC5,{"C5_XEANCOM", xEANComp, NIL})
				aadd(aSC5,{"C5_XEANCOF", xEANCodF, NIL})
				aadd(aSC5,{"C5_XEANLE" , xEANLocE, NIL})
				aadd(aSC5,{"C5_XEANFOR", xEANLozF, NIL})
				aadd(aSC5,{"C5_EANENF" , xEANEmNF, NIL})
				*/
			EndIf
			
			//Se a quantidade de itens com a instru??o 2 for a quantidade de itens existentes no arquivo o cliente pede para excluir o pedido.
			If nQtddel=nQtditem
				nOpcAuto:=5
			Endif
			
			lMSErroAuto := .F.
			
			DbSelectArea("SC6")
			SC6->(dbSetOrder(1))
			dbSeek(xFilial("SC6")+_cPed)
			
			If nErro=0 .And. !lnGrv
			
				MsExecAuto({|x,y,z|Mata410(x,y,z)},aSC5,aSC6,nOpcAuto)
				
			Endif
			
			If nErro=0
				
				If lMSErroAuto
					MostraErro()
					if aFiles[nX,2] == "Local"
						If __CopyFile(cLeNeo+aFiles[nX,1], cLeNeo+"erro\"+aFiles[nX,1])
							FErase(cLeNeo+aFiles[nX,1])
						Endif
					Else
						If __CopyFile(substr(cLeNeo,4)+aFiles[nX,1], substr(cLeNeo,4)+"erro\"+aFiles[nX,1])
							FErase(substr(cLeNeo,4)+aFiles[nX,1])
						Endif
					EndIf

					cRelto 	 := AllTrim(GETMV("MV_XNEOEML"))
					
					cErroPro := "E-mail de erro na importacao de Pedido da Neogrid." + CHR(13) + CHR(10)
					cErroPro += "Erro no arquivo: " + Alltrim(aFiles[nX,1]) + CHR(13) + CHR(10)
					cErroPro += cErroPro + CHR(13) + CHR(10)
					
					aAdd(aMsg, {{xPRODUTO, xDescri, cErroPro,"","",""}})
					
					cErroPro:=""
					
					aErroAuto := GetAutoGRLog()
					For __nY := 1 To Len(aErroAuto)
						cBodyMsg += StrTran(StrTran(StrTran(aErroAuto[__nY],"<"," "),"-"," "),"/"," ")+" " + CHR(13) + CHR(10)
						nLidos := nTamFile
					Next __nY
					
					cRelFrom 	:= ""
					aAdd(aMsg, {{xPRODUTO, xDescri, cErroPro,"","",""}})
					cOrd:= Soma1(cOrd)
					cErroPro:= ""
				Else
					ConfirmSx8()
					
					If nOpcAuto==3
						cRelto 	 := AllTrim(GETMV("MV_XNEOEML"))
						cMensaje:=""
						
						cMensaje := "Importacao Pedido da Neogrid "+Alltrim(cVNum)+""  + CHR(13) + CHR(10)
						cMensaje += "O arquivo: " + Alltrim(aFiles[nX,1]) +" foi importado e foi gerado o pedido numero: " + _cPed + CHR(13) + CHR(10)
						
						cRelFrom 	:= ""
						
						
						If !lIncPd
							cMensaje := "Importacao Pedido Neogrid "+Alltrim(cVNum)+" com Sucesso TOTVS " + xFilial("SC5")+" "+_cPed + CHR(13) + CHR(10)
							cMensaje += "O arquivo: " + Alltrim(aFiles[nX,1]) +" foi importado e foi gerado o pedido numero: " + xFilial("SC5")+" "+_cPed + CHR(13) + CHR(10)
						Else
							cMensaje := "Importacao Pedido Neogrid "+Alltrim(cVNum)+" Advertencias TOTVS " + xFilial("SC5")+" "+_cPed + CHR(13) + CHR(10)
							cMensaje += "O arquivo: " + Alltrim(aFiles[nX,1]) +" foi importado e foi gerad
						Endif
						
						U_BLEMNOTF(cRelto,"" ,cMensaje, aMsg,{},.F., lIncPd, xFilial("SC5")+" "+_cPed, Alltrim(aFiles[nX,1]),cNomCli,nOpcAuto)
						
						MsgInfo("Pedido cliente: " + cVNum + " Pedido Protheus " + xFilial("SC5")+" "+_cPed + " Importado com sucesso! ")
						
					Elseif nOpcAuto==4
						cRelto 	 := AllTrim(GETMV("MV_XNEOEML"))
						cMensaje:="Integracao Neogrid - Alteracao de Pedido de Vendas"
						
						cErroPro := "E-mail de importacao de Pedido da Neogrid "+Alltrim(cVNum)+" " + CHR(13) + CHR(10)
						cErroPro += "O arquivo: " + Alltrim(aFiles[nX,1]) +" foi alterado e foi gerado o pedido numero: " + _cPed + CHR(13) + CHR(10)
						
						cRelFrom 	:= ""
						U_BLEMNOTF(cRelto,"" ,cMensaje, aMsg,{},.F., lIncPd, _cPed, Alltrim(aFiles[nX,1]),cNomCli,nOpcAuto)
						cOrd:= Soma1(cOrd)
						
					Elseif nOpcAuto==5
						
						cRelto 	 := AllTrim(GETMV("MV_XNEOEML"))
						cMensaje:="Integracao Neogrid - Exclusao de Pedido de Vendas"
						
						cErroPro := "E-mail de importacao de Pedido da Neogrid." + CHR(13) + CHR(10)
						cErroPro += "O arquivo: " + Alltrim(aFiles[nX,1]) +" e o pedido : " + _cPed + " foi excluido" + CHR(13) + CHR(10)
						
						aAdd(aMsg, {{xPRODUTO, xDescri, cErroPro,"","",""}})
						
						cRelFrom 	:= ""
						
						U_BLEMNOTF(cRelto,"" ,cMensaje, aMsg,{},.F., lIncPd, _cPed, Alltrim(aFiles[nX,1]),cNomCli,nOpcAuto)
						
						cOrd:= Soma1(cOrd)
					Endif
					nLidos += nReg9
					
				EndIf
			Else
				
				cRelto 	 := AllTrim(GETMV("MV_XNEOEML"))
				
				
				cMensaje:="Integracao Neogrid - Erro na Inclus?o de Pedido de Vendas"
				
				
				_cPed:='XXXXXX'
				
				U_BLEMNOTF(cRelto,"" ,cMensaje, aMsg,{},.F., lIncPd, _cPed, Alltrim(aFiles[nX,1]),cNomCli,nOpcAuto)
				
				nLidos += nReg9
				
			Endif
		Endif
		nLidos := nTamFile
		fRead(nHdl,@cBuffer,nLidos)
		xTpReg6 := ""
		lItem	:= .T.
		_cItem 	:= "01"
		DbSkip()
	EndDo
	
	lnGrv := .F.
	fClose(nHdl)
	
	cFilName := Alltrim(aFiles[nX,1])
	
	If nErro=0
		If !lMsErroAuto
			//Copia o arquivo para a pasta importados
			if aFiles[nX,2] == "Local"
				If __CopyFile(cLeNeo+aFiles[nX,1], cLeNeo+"Importados\"+aFiles[nX,1])
					FErase(cLeNeo+aFiles[nX,1])
				Endif
			Else
				If __CopyFile(substr(cLeNeo,4)+aFiles[nX,1], substr(cLeNeo,4)+"Importados\"+aFiles[nX,1])
					FErase(substr(cLeNeo,4)+aFiles[nX,1])
				Endif
			EndIf
		EndIF
	Endif
Next nX

If lSchedule
	RESET ENVIRONMENT
	RpcClearEnv()
EndIf

Return()

/*
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????ͻ??
???Funcion   ?SetMotulo ?Autor  ?Vanito Rocha        ? Data ?  20/10/2020 ???
?????????????????????????????????????????????????????????????????????????͹??
???Desc.     ? Seleciona o Modulo a ser executado                         ???
???          ?                                                            ???
?????????????????????????????????????????????????????????????????????????͹??
???Uso       ?                                                            ???
?????????????????????????????????????????????????????????????????????????ͼ??
?????????????????????????????????????????????????????????????????????????????
?????????????????????????????????????????????????????????????????????????????
*/

Static Function SetModulo( cModName , cMod )

Local aRetModName := RetModName( .T. )
Local cSvcModulo
Local nSvnModulo

IF ( Type("nModulo") == "U" )
	_SetOwnerPrvt( "nModulo" , 0 )
Else
	nSvnModulo := nModulo
EndIF

cModName := Upper( AllTrim( cModName ) )

IF (nModulo <> aScan( aRetModName , { |x| Upper( AllTrim( x[2] ) ) == cModName } ) )
	nModulo := aScan( aRetModName , { |x| Upper( AllTrim( x[2] ) ) == cModName } )
	IF ( nModulo == 0 )
		cModName := "SIGAFAT"
		nModulo := aScan( aRetModName , { |x| Upper( AllTrim( x[2] ) ) == cModName } )
	EndIF
EndIF

IF ( Type("cModulo") == "U" )
	_SetOwnerPrvt( "cModulo" , "" )
Else
	cSvcModulo := cModulo
EndIF

cMod := SubStr( cModName , 5 )

IF ( cModulo <> cMod )
	cModulo := cMod
EndIF

Return( { cSvcModulo , nSvnModulo } )


/*
TELA PARA SELECAO DE ARQUIVOS XML
*/
User Function BLIMPPED()
Local aArea := GetArea()
//Local cRet := ""
Local oOK := LoadBitmap(GetResources(),'br_verde')
Local oNO := LoadBitmap(GetResources(),'br_vermelho')
Local aBrowse := {}
Local _aHeader := {}
Local _aHeadSize := {}
Local oDlgArq
//Local aAux := {}
Local nReg := nPos := 0
Local aRet := {}
Local nOpcao := 0
Local cMensagem := "E necessario selecionar pelo menos um item para confirmar."
//Local aArea := GetArea()
//Local oCmbo,Font, oBMP
//Local oBtn
//Local cCmb := ""
Local _cTit := "Selecione Arquivos TXT"
//Local aOrd := {}
//Local nOrd := 1
//Local bPesq := {|| }
//Local bSort := {|| }
//Local aClient:={}
//Local bRefresh:={|| oBrowse:AARRAY := aBrowse, oBrowse:Refresh()}
//Local bAtualiza := {|| nOpcao:= 0,aRet:={}, aFiles := {} ,;
//	aBrowse:={},;
//	if(len(aFiles)>0,aEval(aFiles,{|R| c_File := R[1],aAdd(aBrowse,{.F.,R[1],R[3],R[4],xSelCli(c_File),""}) }),nOpcao==2),;
//	if(nOpcao==1,Eval(bRefresh),oDlgArq:End) }
		
//Local bProc := {|| ProcPedv(aRet) /*FWMsgRun(, {|oSay| ProcPedv(aRet,oSay) }, "Processando", "Importando Pedidos")*/}
Local c_File
Local lErro   := .F.

Private cLeNeo		:= "" //Alltrim(SuperGETMV("MV_XNEOGRE"))
Private aFiles 		:= {}
Private cLeNeoFTP   := ""
Private aFilesFTP   := {}
DbSelectArea("SA1")
U_FTPPED(.T.)
 
 cLeNeo		:= Alltrim(SuperGETMV("MV_XNEOGRE"))
 //cLeNeoFTP  := substr(cLeNeo,4)

 //Verifica se usu?rio est? logado filial 0072

if cEmpAnt == "0072" 
	Alert("ATEN??O: Verifique a filial logada, rotina habilitada somente para filial 0072")
	Return Nil
endif	

While nOpcao == 0
	oDlgArq := Nil					
	_aHeader:= {"","Arquivo","Data","Hora","Cliente /Ped. Cliente","Local"}
	_aHeadSize := {20,40,20,20,80,10}
	aBrowse:={}
	aFiles    := Directory(cLeNeo+"*.TXT")
	aFilesFTP := Directory(cLeNeoFTP+"*.TXT")

	If Len(aFiles)>0
		aEval(aFiles,{|R| c_File := R[1],aAdd(aBrowse,{.F.,R[1],R[3],R[4],xSelCli(c_File),"Local"}) })
		lErro := .F.
	Else
		lErro := .T.
	Endif
	/*
	If Len(aFilesFTP)>0
		aEval(aFilesFTP,{|R| c_File := R[1],aAdd(aBrowse,{.F.,R[1],R[3],R[4],xSelCli(c_File),"FTP  "}) })
		lErro := .F.
	Else
		lErro := .T.
	Endif
	*/
	if lErro 
		Alert("Nao existe arquivo a ser importado!!!")
		Return Nil
	endif		
    nA := 0
	nB := 5
	nC := 100
	nD := 40

	DEFINE MSDIALOG oDlgArq TITLE _cTit FROM 150,180 TO 600,900 PIXEL
			
	oFont:= oDlgArq:oFont
	oBrowse := TWBrowse():New( 30 , 01, 260+nC,nD+184-31,,_aHeader,_aHeadSize,;
	oDlgArq,,,,,{||},,,,,,,.F.,,.T.,,.F.,,, )
	oBrowse:SetArray(aBrowse)
	oBrowse:bLine := {||{If(aBrowse[oBrowse:nAt,01],oOK,oNO),aBrowse[oBrowse:nAt,02],;
	aBrowse[oBrowse:nAt,03],aBrowse[oBrowse:nAt,04],aBrowse[oBrowse:nAt,05],aBrowse[oBrowse:nAt,06]  } }
	// Troca a imagem no duplo click do mouse
	oBrowse:bLDblClick := {|| aBrowse[oBrowse:nAt][1] := !aBrowse[oBrowse:nAt][1], oBrowse:DrawSelect() } // se precisar habilitar o processamento de um s? , nOpcao:=1, oDlgArq:End()  }
	oBrowse:bHeaderClick := {|x,y| aEval(oBrowse:AARRAY,{|x,Y| nReg++,aBrowse[nReg][1] :=!aBrowse[nReg][1]}),oBrowse:AARRAY := aBrowse,nReg:=0,oBrowse:Refresh()}
	ACTIVATE MSDIALOG oDlgArq CENTERED ON INIT EnchoiceBar(oDlgArq,;
	{||aEval(aBrowse,{|X| If(X[1],(nOpcao := 1,aAdd(aRet,{X[2],x[6]})),Nil) }),If(nOpcao==1,oDlgArq:End(),Alert(cMensagem)) },;
	{||nOpcao:=2,oDlgArq:End()},,{})
			
	If nOpcao == 1
		FWMsgRun(, {|oSay| ProcPedv(aRet,oSay) }, "Processando", "Importando Pedidos")
		nOpcao:= 0
	Endif
EndDo
		
RestArea(aArea)
		
Return Nil
		
		
Static Function xSelCli(cFiles)
		
Local xNome :=""
Local cCnpjComp
Local nHdl 		:= FT_FUse(cLeNeo+cFiles)
Local xPdcCli	:=""
Local cBuffer	:=FT_FReadLn()
FT_FUse()

If subs(cbuffer,1,2) <> "01"
	nHdl    := FT_FUse(cLeNeoFTP+cFiles)
	cBuffer	:=FT_FReadLn()
	FT_FUse()
EndIF

If subs(cbuffer,1,2) == "01"
			
	cCnpjComp	:= Alltrim(Substr(cBuffer,209,14))
	xPdcCli		:= Alltrim(Substr(cBuffer,009,20))
			
	DbSelectArea("SA1")
	SA1->(DbSetOrder(3))
	If SA1->(DbSeek(xFiliAL("SA1") + cCnpjComp,.F.))
		xNome:=Alltrim(SA1->A1_NREDUZ) +" / " +Alltrim(xPdcCli)
	Endif
Endif
		
Return xNome
