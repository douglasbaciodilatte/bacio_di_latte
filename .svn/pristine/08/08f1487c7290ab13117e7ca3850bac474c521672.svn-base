#INCLUDE 'PROTHEUS.CH'

User function EMP650()

    Local aArea  := GetArea()
    local nx
    Local nPosLocal := FieldPos("D4_LOCAL") 

    For nx := 1 to len(Acols) // Percorre todas as linhas da acols

         IF ! Acols[nx][len(acols[nx])] // Verifica se linha nao esta Deletada

            //Altera armazém filial 00031 para 700002
            If xFilial("SD4") == "0031"
               Acols[nx][nPosLocal] := "700002" 
            ElseIf xFilial("SD4") == "0072"   
                Acols[nx][nPosLocal] := "700023" 
            EndIf

        EndIF

    Next nx

    RestArea(aArea)

Return
