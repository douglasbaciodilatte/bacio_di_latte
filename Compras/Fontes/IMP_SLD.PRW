
#include "PROTHEUS.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IMPSLDINI ºAutor  ³Microsiga           º Data ³  11/06/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³                                                            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

STATIC a_filiais	  := {}

//user function BRBAA010  

user function IMP_SLD

local c_patch_ori := space(100)
local c_patch_log := space(100)
local n_hdllog 	  :=  0



//filiais da empresa.
while sm0->(!eof()) .and. sm0->m0_codigo == cempant
	
	aadd ( a_filiais , sm0->m0_codfil )
	sm0->(dbskip())
	
end                
sm0->(dbgotoP())

if get_paramts(@c_patch_ori,@c_patch_log)
	
	n_hdllog := msfcreate( c_patch_log )
	
	if  n_hdllog > 0
		
		impsldini_start( c_patch_ori, n_hdllog , a_filiais , c_patch_log )
		
	endif
endif

return

static function get_paramts(c_patch_ori,c_patch_log)

local abuttons := {}
local oget1
local oget2
local ogroup1
local ogroup2
local lget_paramts := .f.
local  odlg

Local oSButton1
Local oSButton2

Local aButtons := {}
Local oButton1
Local oButton2
Local ogetpatchori
Local ogetpatclog
Local ogetpathbase
Local oGroup1
Local oGroup2
Static oDlg

define msdialog odlg title "Parametros para execução" from 000, 000  to 180, 600 colors 0, 16777215 pixel

enchoicebar(odlg, { || vld_get_paramts( @lget_paramts , cpathbase, cpatclog, @odlg)  }, {||},,abuttons)
@ 017, 005 group ogroup1 to 044, 242 prompt "Arquivo de origem" of odlg color 0, 16777215 pixel
@ 028, 009 msget ogetpatchori var c_patch_ori size 205, 010 of odlg colors 0, 16777215 pixel
@ 028, 220 button obutton1 prompt "..." size 016, 009 of odlg pixel action helpfile(@lget_paramts,.t. , @c_patch_ori)
@ 047, 005 group ogroup2 to 074, 242 prompt "Caminho do log" of odlg color 0, 16777215 pixel
@ 058, 009 msget ogetpatclog var c_patch_log size 205, 010 of odlg colors 0, 16777215 pixel
@ 058, 220 button obutton2 prompt "..." size 016, 009 of odlg pixel action helpfile(@lget_paramts,.f., @c_patch_log)
@ 077, 221 button obutton3 prompt "&OK" size 016, 009 of odlg pixel action vld_get_paramts( @lget_paramts , c_patch_ori , c_patch_log , @odlg)

if !lget_paramts
	activate msdialog odlg centered
endif

return (lget_paramts)

static function helpfile(lget_paramts,lopenfile,cAdmArq)
local ctype		:= "*.csv"
local cTexto 	:= "File error!"
if lopenfile
	cAdmArq	:= cGetFile(ctype, "Selecione arquivo" ,,,,GETF_NETWORKDRIVE+GETF_LOCALHARD+GETF_LOCALFLOPPY ) // "Selecione arquivo "
else
	cAdmArq := cGetFile(".log", "Salvar como",0, ,.F.,GETF_NETWORKDRIVE+GETF_LOCALHARD+GETF_LOCALFLOPPY ) //"Salvar Objeto como"
endif

IF empty(cAdmArq)
	lget_paramts := .f.
else
	lget_paramts := .t.
endif

return .t.

static function vld_get_paramts(lget_paramts,c_patch_ori,c_patch_log, odlg)

lget_paramts := .t.

if empty(c_patch_ori)
	aviso("impsldini", "Informar caminho do arquivo de origem.",{"ok"})
	lget_paramts := .f.
endif


if empty(c_patch_log)
	aviso("impsldini", "Informar caminho do arquivo de log.",{"ok"})
	lget_paramts := .f.
endif

IF lget_paramts
	odlg:END()
END

return lget_paramts


static function impsldini_start( carqtxt , n_hdllog , a_filiais , c_patch_log )

local adados 		:= {}
local c_cod  		:= criavar("B9_COD")
local c_local		:= criavar("B9_LOCAL")
local n_qini 		:= criavar("B9_QINI")
local n_cm1			:= criavar("B9_VINI1")
local lcreatesdb 	:= .f.
local lcreatesd5 	:= .f.
local nAcao			:= 0

ft_fuse(carqtxt)
ft_fgotop()
while ( !ft_feof() )
		
	clinha := ft_freadln()
	
	adados:= {}
	
	while (npos := at(";",clinha) ) > 0
		aadd( adados,substr(clinha,1,npos-1) )
		clinha:= substr(clinha,npos+1,len(clinha))
	end
	
	aadd( adados , clinha )
	
	if len(adados) != 8
		fwrite(n_hdllog,;
		"Formato da linha é invalido !:";
		+ CRLF)
		
		ft_fskip()
		loop
		
	endif
	
	c_filial := adados[1]
	c_local  := adados[2]
	c_cod    := adados[3]
	c_end    := adados[4]
	c_lote   :=	adados[5]
	d_val	 := ctod(adados[6])
	n_qini   := val( strTran( adados[7] ,",",".")   )
	n_cm1    := val( strTran( adados[8] ,",",".")   )
	
	//código da filial não encontrado: filial xx.
	if ascan(a_filiais, { |x| trim(x)== c_filial } ) == 0
		fwrite(n_hdllog ,;
		"código da filial não encontrado: filial";
		+ chr(9) + c_filial;
		+ CRLF )
		ft_fskip()
		loop
		
	endif
	
	//código do produto não encontrado: produto xxxxxx.
	dbselectarea("SB1")
	dbsetorder(1)
	if !dbseek( xFilial("SB1") + c_cod )
		
		fwrite(n_hdllog ,;
		"código do produto não encontrado: produto";
		+ chr(9) + c_cod;
		+ CRLF  )
		ft_fskip()
		loop
		
	endif
	
	lcreatesdb := sb1->b1_localiz == "S"
	lcreatesd5 := sb1->b1_rastro  == "L"
	
	//código do endereço não encontrado para o armazém: endereço xxxxxx, armazém xx.
	if !empty(c_end)
		
		dbselectarea("SBE")
		dbsetorder(1)
		if !dbseek( c_filial + c_local + c_end )
			
			fwrite(n_hdllog,;
			"código do endereço não encontrado para o armazém:";
			+ chr(9) + "endereco";
			+ chr(9) + c_end;
			+ chr(9) + "armazem";
			+ chr(9) + c_local;
			+ CRLF)
			ft_fskip()
			loop
		endif
		
	endif
	
	
	//produto sem custo médio informado: produto xxxxxx.
	if empty(n_cm1)
		fwrite(n_hdllog ,;
		"Produto sem custo médio informado: produto" + chr(9) + c_cod + chr(9) + "falta o custo " +CRLF  )
		ft_fskip()
		loop
		
	endif
	
	//produto sem quantidade informada: produto xxxxxx.
	if empty(n_qini)
		fwrite(n_hdllog ,;
		"Produto sem quantidade informada: produto" + chr(9) + c_cod + chr(9) + "falta o custo " +CRLF  )
		ft_fskip()
		loop
		
	endif
	
	//o produto não controla localização: produto xxxxxx, endereço xxxxxx.
	if !lcreatesdb  .and. !empty(c_end)
		fwrite(n_hdllog ,;
		"Produto não controla localização: produto";
		+ chr(9) + c_cod;
		+ chr(9) + "endereco";
		+ chr(9) + c_end;
		+ CRLF  )
		ft_fskip()
		loop
		
	endif
	
	// produto com controle de localização, sem endereço informado: produto xxxxxx.
	if lcreatesdb .and. empty(c_end)
		fwrite(n_hdllog ,;
		"Produto com controle de localização, sem endereço informado: produto";
		+ chr(9) + c_cod;
		+ CRLF )
		ft_fskip()
		loop
	endif
	
	
	// o produto não controla rastro: produto xxxxxx, lote xxxxxx.
	if !lcreatesd5 .and. !empty(c_lote)
		fwrite(n_hdllog ,;
		"Produto não controla rastro: produto";
		+ chr(9) + c_cod;
		+ chr(9) + "lote";
		+ chr(9) + c_lote;
		+ CRLF )
		ft_fskip()
		loop
	endif
	
	
	//o produto com controle de rastreabilidade, sem lote informado: produto xxxxxx..
	if lcreatesd5 .and. empty(c_lote)
		fwrite(n_hdllog ,;
		"Produto com controle de rastreabilidade, sem lote informado: produto";
		+ chr(9) + c_cod;
		+ CRLF )
		ft_fskip()
		loop
	endif
	
	
	grava(c_filial,;
	c_local,;
	sb1->b1_cod,;
	c_end,;
	c_lote,;
	d_val,;
	n_qini,;
	n_cm1)
	
	ft_fskip()
	
enddo
ft_fuse()

nAcao:= Aviso("AVISO."," Visualizar LOG de Processamento ? ",{"&Sim","Não"} )
fclose(n_hdllog)
if nAcao == 1
	shellexecute("open", c_patch_log, "", "", 1)
endif


return

static function grava( c_filial,;
c_local,;
c_cod,;
c_end,;
c_lote,;
d_val,;
n_qini,;
n_cm1)

local cnumlote := space(6)

dbselectarea("SB9")
dbsetorder(1)//B9_FILIAL+B9_COD+B9_LOCAL+DTOS(B9_DATA)                                                                                                                         
if !dbseek( c_filial + c_cod + c_local + dtos(ddatabase) )
	reclock("SB9",.t.)
else
	reclock("SB9",.f.)
endif

sb9->b9_filial:= c_filial
sb9->b9_cod   := c_cod
sb9->b9_local := c_local
sb9->b9_data  := ddatabase
sb9->b9_qini  += n_qini
sb9->b9_cm1   := n_cm1
sb9->b9_vini1 := sb9->( b9_qini *  b9_cm1 )
SB9->( msunlock() )
cFilAnt := c_Filial


if !empty(c_end)
	
	cnumseq:= proxnum()
	
	criasdb(;
	c_cod,;
	c_local,;
	n_qini,;
	c_end,;
	"",;
	"INI" + cnumseq ,;
	"",;
	"",;
	"",;
	"",;
	"SB9",;
	sb9->b9_data,;
	c_lote,;
	"",;
	cnumseq,;
	"499",;
	"D",;
	"0001",;
	.f.,;
	0,;
	convum(sb1->b1_cod,n_qini,0,2),;
	0)
	
endif

if !empty(c_lote)
	
	if empty(cnumseq)
		
		cnumseq:= proxnum()
		
	endif
	
	gravasd5("SD5",;
	c_cod,;
	c_local,;
	c_lote,;
	cnumlote,;
	cnumseq,;
	"INI" + cnumseq,;
	"",;
	nil,;
	nil, ;
	nil,;
	nil,;
	nil,;
	n_qini,;
	convum(c_cod,n_qini,0,2),;
	sb9->b9_data,;
	d_val,;
	0)
	
endif


return




