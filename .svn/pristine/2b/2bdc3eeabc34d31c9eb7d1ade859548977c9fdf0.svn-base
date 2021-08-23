#include 'protheus.ch'
#include 'parmtype.ch'
#include 'totvs.ch'


User Function MT311Leg

Local oBrowse := PARAMIXB[1]


    oBrowse:ALEGENDS[1][2]:ALEGEND := {}

    oBrowse:AddLegend( "NNS_STATUS == '1'", "GREEN"		, 'Incluido' 	)//"Incluido"
    oBrowse:AddLegend( "NNS_STATUS == '2'", "RED"       , 'Em Transito' )//"Em Transito"
    oBrowse:AddLegend( "NNS_STATUS == '5'", "BLUE"		, 'Recebido' 	)//"Recebido"
    oBrowse:AddLegend( "NNS_STATUS == '6'", "YELLOW"    , 'Rejeitado'   )//"Rejeitado"

Return (oBrowse)
