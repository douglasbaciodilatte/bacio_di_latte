#include 'protheus.ch'
#include 'parmtype.ch'
#include "totvs.ch"
#include "topconn.ch"
/* detalhamento de aPIO

*/
//------------------------------------------------------------
// Função fwimppio                        | Data: 09.03.2019
// Autor: Eduardo Pessoa
// Descrição: Faz a importação de vendas paras as tabelas 
// PIO, preparando para o motor do 
//importacao
//------------------------------------------------------------
user function fwimppio()
Local aFiles := {}

//Local cPath  := "\\172.28.8.245\SSNP9K_pr_TST_data\Outsourcing\Clientes\SSNP9K_TST\Protheus_Data\IMPORT"
Local cExtFiles := "\*PIO.TXT"
Local nX := 0
Local oFile
Private cPath  := "\\172.28.8.117\SSNP9K_pr_PRD_data\Outsourcing\Clientes\SSNP9K_PRD\Protheus_data\IMPORT"
//Private cPath  := "c:\rvacari\bl\vendas\IMPORT"

Public cErrorMessage := ""
 

If IsRunning(FunName())
    //Conout(cErrorMessage)
    Return
EndIf

aFiles := Directory(cPath+cExtFiles, "D")

For nX := 1 to Len(aFiles)
    // Tratamento dos arquivos
    oFile := FWFileReader():New(cPath+"\"+aFiles[nX,1])
    AddPio(oFile)
Next nX

Return(.T.)

//------------------------------------------------------------
// Função AddError                          | Data: 09.03.2019
// Autor: Eduardo Pessoa
// Descrição: Trata a inclusão de mensagem de erro
//------------------------------------------------------------
Static Function AddError(cErrorText)
If !Empty(cErrorMessage)
    cErrorMessage += CHR(13)+CHR(10)
EndIf    
cErrorMessage := CErrorText+"-|"+dtoc(Date())
Return

//------------------------------------------------------------
// Função IsRunning                         | Data: 09.03.2019
// Autor: Eduardo Pessoa
// Descrição: Verifica se a rotina está sendo executada
//------------------------------------------------------------
Static Function IsRunning(cFunction)
Local aInfo := GetUserInfoArray()
Local nIndex := 0
Local lRet := .F.

For nIndex := 1 to Len(aInfo)
    If aInfo[nIndex,5] == cFunction
        lRet := .T.
        If !Empty(cErrorMessage)
            cErrorMessage += Chr(10)+Chr(13)
        EndIf    
        AddError("Função já está em execução, será executado no próximo looping do job.")
    EndIf
Next        
Return(lRet)

//------------------------------------------------------------
// Função AddPIO                            | Data: 09.03.2019
// Autor: Eduardo Pessoa
// Descrição: Inclui registro na tabela PIN
//------------------------------------------------------------
Static Function AddPIO(oFile)
Local aPIO := {}
Local aPINInfo := {}

if (oFile:Open())
   while (oFile:hasLine())
        aPIO := StrTokArr(oFile:GetLine(),"|")
        //If aPIO[2] == "PIO"
            //If ChkCodex(aPIO[1]) --Solicitado que retirasse essa verificacao 13/03/2019
                // Gravar a PIN
                // Verifica filial e seta environment
                //cFilImp := RetFil(aPIO[41])

                aPINInfo := GetPINInfo(aPIO[1])

                If Len(aPINInfo) > 0
                    //PREPARE ENVIRONMENT EMPRESA '01' FILIAL cFilImp;
                    dbSelectArea("PIO")
                    RecLock("PIO",.T.)
					PIO->PIO_FILIAL	:= aPINInfo[8,1]
					PIO->PIO_NUM	:= StrZero(Val(aPIO[11]),6)
					PIO->PIO_PRODUT	:= aPIO[3]
					PIO->PIO_ITEM	:= STRZERO(Val(aPIO[4]), 2)
					PIO->PIO_QUANT	:= Val(aPIO[5])
					PIO->PIO_VRUNIT	:= Val(aPIO[6])
					PIO->PIO_VLRITE	:= Val(aPIO[7])
					PIO->PIO_DESC	:= 0 
					PIO->PIO_LOCAL	:= "01"
					PIO->PIO_UM		:= "UM"
					PIO->PIO_TES	:= "XXX"
					PIO->PIO_CF		:= aPIO[10]
					PIO->PIO_VENDID	:= "S"
					PIO->PIO_DESPES := 0
					PIO->PIO_ENTREG := ""
					PIO->PIO_DOC	:= STRZero(Val(aPIO[11]),9)
					PIO->PIO_SERIE  := aPINInfo[9,1]
					PIO->PIO_PDV	:= ALLTRIM(aPINInfo[6,1])
					PIO->PIO_EMISSA	:= STOD( aPIO[15] )
					PIO->PIO_VALICM	:= Val(aPIO[13])
					PIO->PIO_BASEIC	:= Val(aPIO[14])
					PIO->PIO_VALPS2	:= Val(aPIO[21])
					PIO->PIO_VALCF2	:= Val(aPIO[22])
					PIO->PIO_BASEPS	:= Val(aPIO[23])
					PIO->PIO_BASECF	:= Val(aPIO[24])
					PIO->PIO_ALIQPS	:= Val(aPIO[25])
					PIO->PIO_ALIQCF	:= Val(aPIO[26])					
					PIO->PIO_PRCTAB	:= Val(aPIO[16])
					PIO->PIO_VEND	:= "000001"
					PIO->PIO_SITUA	:= "RX"
					PIO->PIO_SITTRI	:= "T0320"
					PIO->PIO_DATEXP	:= Date()
					PIO->PIO_DATIMP	:= Date()
					PIO->PIO_CODORI	:= "2"
					PIO->PIO_CODDES	:= "1"
					PIO->PIO_STAIMP	:= "9"
					PIO->PIO_PROTHE	:= "PIO_RECCAB" //cValtoChar(aPINInfo[7,1])
					PIO->PIO_LOGINT := ""
					PIO->PIO_OPER   := ""
					PIO->PIO_GARANT := ""
					PIO->PIO_RECCAB := aPINInfo[7,1]
					PIO->PIO_ACAO	:= "1"
					PIO->PIO_DESCRI	:= aPIO[30]
					PIO->PIO_XTPREG	:= "5"
					PIO->PIO_LJORI	:= RIGHT(aPINInfo[2,1],4) 
					PIO->PIO_CNPJOR	:= aPINInfo[3,1]
					PIO->PIO_CHVORI	:= aPINInfo[4,1] 
					PIO->PIO_XCODEX	:= aPIO[1]
					PIO->PIO_CODORI	:= '2' 
					PIO->PIO_CODDES := '1'
					PIO->PIO_STATUS	:= ""
					PIO->PIO_DESCPR	:= 0
					PIO->PIO_CUSTO1	:= 0
					PIO->PIO_GRADE	:= ""
					PIO->PIO_PREMIO	:= ""
					PIO->PIO_VALFRE	:= 0
					PIO->PIO_SEGURO	:= 0
					PIO->PIO_FILRES	:= ""
					PIO->PIO_NUMORI	:= ""
					PIO->PIO_VALEPR	:= ""
					PIO->PIO_TABELA	:= ""
					PIO->PIO_CUSTO2	:= 0
					PIO->PIO_LOTECT	:= ""
					PIO->PIO_EMPRES	:= ""
					PIO->PIO_ORCRES	:= ""
					PIO->PIO_ITEMSD	:= ""
					PIO->PIO_DTVALI	:= Stod("")
					PIO->PIO_SEGUM	:= ""
					PIO->PIO_PEDRES	:= ""
					PIO->PIO_FDTENT	:= Stod("")
					PIO->PIO_CODCON	:= ""
					PIO->PIO_FDTMON	:= Stod("")
					PIO->PIO_CODREG	:= ""
					PIO->PIO_VLDESR	:= 0
					PIO->PIO_TURNO	:= ""
					PIO->PIO_XPCOMI	:= 0
					PIO->PIO_XPCOMG	:= 0
					PIO->PIO_XTPREG	:= "5"
					PIO->PIO_XJURFI	:= 0
					PIO->PIO_SITUA	:= "RX" //aPINInfo[5,1]
					MsUnLock()
                EndIf

            //Else
            //    AddError("Codex nao existe, registro não importado."+PIO->PIO_XCODEX)
            //EndIf
        //Else
        //    AddError("Registro não é da tabela PIO.")    
        //EndIf    
   end
   oFile:Close()
endif


Return()

//------------------------------------------------------------
// Função ChkCodex                          | Data: 09.03.2019
// Autor: Eduardo Pessoa
// Descrição: Verifica se existe o Codex na PIO
//------------------------------------------------------------
Static Function ChkCodex(cCodex)
Local cQuery := ""
Local lRet := .T.

cQuery := "SELECT * FROM "+RetSQLName("PIN")+" WHERE D_E_L_E_T_='' AND PIN_XCODEX='"+Alltrim(cCodex)+"'"

If Select("IMPPIN")<>0
    IMPPIN->(dbCloseArea())
EndIf    

TCQuery cQuery New Alias "IMPPIN"

If !IMPPIN->(Eof())
    lRet := .T.
EndIf    

Return(lRet)

//------------------------------------------------------------
// Função GetPINInfo                      | Data: 09.03.2019
// Autor: Eduardo Pessoa
// Descrição: Busca dados na PIN, via xCodex
//------------------------------------------------------------
/*
1 - xCodex  4 - CHVORI   7 - RECCAB
2 - LJORI   5 - SITUA
3 - CNPJOR  6 - PDV
*/
Static Function GetPINInfo(cXCodex)
Local cQueryPIN := ""
Local aRet := {}

cQueryPIN := " SELECT PIN_XCODEX,PIN_LJORI,PIN_CNPJOR,PIN_CHVORI,PIN_SITUA,PIN_PDV,PIN_RECCAB,PIN_FILIAL,PIN_SERIE "
cQueryPIN += " FROM "+RetSQLName("PIN")+" WHERE D_E_L_E_T_='' AND PIN_XCODEX='"+Alltrim(cXCodex)+"'"

If Select("INFOPIN")<>0
    INFOPIN->(dbCloseArea())
EndIf    

TCQuery cQueryPIN New Alias "INFOPIN"

If !INFOPIN->(Eof())
    Aadd(aRet,{INFOPIN->PIN_XCODEX})  //1
    Aadd(aRet,{INFOPIN->PIN_LJORI})   //2
    Aadd(aRet,{INFOPIN->PIN_CNPJOR})  //3
    Aadd(aRet,{INFOPIN->PIN_CHVORI})  //4
    Aadd(aRet,{INFOPIN->PIN_SITUA})   //5
    Aadd(aRet,{INFOPIN->PIN_PDV})     //6
    Aadd(aRet,{INFOPIN->PIN_RECCAB})  //7
    Aadd(aRet,{INFOPIN->PIN_FILIAL})  //8 
	Aadd(aRet,{INFOPIN->PIN_SERIE})  //9 
EndIf    

Return(aRet)

//------------------------------------------------------------
// Função RetFil                            | Data: 09.03.2019
// Autor: Eduardo Pessoa
// Descrição: Retorna a Filial da informação importada
//------------------------------------------------------------
Static Function RetFil(cCnpjOri)
Local CCnpj := STRTRAN(cCnpjOri,"/","")
Local aSM0  := FWLoadSM0()
Local nI    := 0
Local cRet  := ""

For nI := 1 to Len(aSM0)
    IIF(aSM0[nI,18]==CCnpj,cRet:=aSM0[nI,2],)
Next nI

If Empty(cRet)
    AddError("Filial não encontrada.")
EndIf

Return(cRet)