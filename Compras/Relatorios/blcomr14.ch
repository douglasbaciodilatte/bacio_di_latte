#ifdef SPANISH
	#define STR0001 "Detalle de divergencias de pedidos de compras"
	#define STR0002 "Emision del detalle de los itemes para compras"
	#define STR0003 "con divergencias"
	#define STR0004 "A Rayas"
	#define STR0005 "Administracion"
	#define STR0006 "DIVERGENCIAS ENTRE FACT. DE COMPRAS Y PEDIDOS"
	#define STR0007 "FACTURA      EMISION    CODIGO TD PROVEEDOR                        PRODUCTO        UN     CANTIDAD   VALOR UNITARIO FCH.ENTREGA  COND."
	#define STR0008 "PEDIDO/REMITO"
	#define STR0009 "ANULADO POR EL OPERADOR"
	#define STR0010 "No hay pedido de compra colocado"
	#define STR0011 "No hay remito colocado          "
	#define STR0012 "FACTURA      EMISION    CODIGO               TD   PROVEEDOR        PRODUCTO        UN   CANTIDAD     VALOR UNITARIO  FCH.ENTR.  COND."
	#define STR0013 "                "
	#define STR0014 "                        "
	#define STR0015 "Items del(os) pedido(s) que no constan en la Factura "
	#define STR0016 "Items de Doc. de Entrada"
	#define STR0017 "Pedidos de Compra"
	#define STR0018 "FACTURA                EMISION    CODIGO               TD   PROVEEDOR        PRODUCTO        UN   CANTIDAD     VALOR UNITARIO  FCH.ENTR.  COND."
	#define STR0019 "FACTURA                EMISION    CODIGO TD PROVEEDOR                        PRODUCTO        UN     CANTIDAD   VALOR UNITARIO FCH.ENTREGA  COND."
#else
	#ifdef ENGLISH
		#define STR0001 "List of Purchase Order Differences"
		#define STR0002 "Issue of the Items to Purchase list"
		#define STR0003 "with Divergencies"
		#define STR0004 "Z.Form "
		#define STR0005 "Management"
		#define STR0006 "DIVERGENCIES OF PURCHASE FACTURAS AND ORDERS"
		#define STR0007 "INVO         ISSUE      CODE   SUPPLIER UNIT                       PRODUCT         UM   QUANTITY     UNIT VALUE      DELIV.DATE TERM "
		#define STR0008 "ORDER "
		#define STR0009 "CANCELLED BY THE OPERATOR"
		#define STR0010 "There is no Purchase Order placed"
		#define STR0011 "There is no Remito placed"
		#define STR0012 "INVOICE      ISSUE DT   CODE                 UN    VENDOR          PRODUCT         UM    QUANTITY    UNIT VALUE      DELIV.DATE COND."
		#define STR0013 "                "
		#define STR0014 "                        "
		#define STR0015 "Items of orders that are not part of the Invoice     "
		#define STR0016 "Inflow document items         "
		#define STR0017 "Purchase Orders  "
		#define STR0018 "INVOICE                ISSUE DT   CODE                 UN    VENDOR          PRODUCT         UM    QUANTITY    UNIT VALUE      DELIV.DATE COND."
		#define STR0019 "INVO                   ISSUE      CODE   SUPPLIER UNIT                       PRODUCT         UM   QUANTITY     UNIT VALUE      DELIV.DATE TERM "
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Rela��o De Diverg�ncias De Pedidos De Compras", "Relacao de Divergencias de Pedidos de Compras" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Emiss�o Da Rela��o De Itens Para Compras", "Emissao da Relacao de Itens para Compras" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Com diverg�ncias", "com divergencias" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "C�digo de barras", "Zebrado" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Administra��o", "Administracao" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Diverg�ncias Entre Factura De Compras E Pedidos", "DIVERGENCIAS ENTRE NF DE COMPRAS E PEDIDOS" )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Factura         emiss�o    c�digo lj fornecedor                       produto         um   quantidade   valor unit�rio  dt.entrega cond ", "NOTA         EMISSAO    CODIGO LJ FORNECEDOR                       PRODUTO         UM   QUANTIDADE   VALOR UNITARIO  DT.ENTREGA COND " )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Pedido", "PEDIDO" )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Cancelado Pelo Operador", "CANCELADO PELO OPERADOR" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "N�o h� pedido de compra colocado", "Nao ha' pedido de compra colocado" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "N�o existe guia de remessa colocada          ", "No hay remito colocado          " )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Factura         Emiss�o    C�digo               Lj   Fornecedor       Produto         Um   Quantidade   Valor Unit�rio  Dt.entrega Cond.", "NOTA         EMISSAO    CODIGO               LJ   FORNECEDOR       PRODUTO         UM   QUANTIDADE   VALOR UNITARIO  DT.ENTREGA COND." )
		#define STR0013 "Itens do pedido "
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Que n�o constam na factura ", "que nao constam na nota " )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Elementos do(s) pedido(s) que n�o constam na factura ", "Itens do(s) pedido(s) que nao constam na Nota Fiscal " )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Itens Do Documento De Entrada", "Itens do Documento de Entrada" )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Pedidos De Compra", "Pedidos de Compra" )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Nota                   Emiss�o    C�digo                Lj   Fornecedor       Artigo         Um   Quantidade   Valor Unit�rio  Dt.entrega Cond.", "NOTA                   EMISSAO    CODIGO               LJ   FORNECEDOR       PRODUTO         UM   QUANTIDADE   VALOR UNITARIO  DT.ENTREGA COND." )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Nota                   emiss�o    c�digo  lj fornecedor                       artigo         um   quantidade   valor unit�rio  dt.entrega cond ", "NOTA                   EMISSAO    CODIGO LJ FORNECEDOR                       PRODUTO         UM   QUANTIDADE   VALOR UNITARIO  DT.ENTREGA COND " )
	#endif
#endif
