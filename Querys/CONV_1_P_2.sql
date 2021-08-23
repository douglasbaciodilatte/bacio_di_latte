
SELECT B8_FILIAL,  B8_PRODUTO,  ROUND((SUM(SB8.B8_SALDO) * SB1.B1_CONV),2) AS SALDO_1, SUM(B8_SALDO) AS SALDO_2
FROM SB8010 SB8
JOIN SB1010 SB1 ON SB1.B1_FILIAL = '' AND SB1.B1_COD = SB8.B8_PRODUTO AND SB1.D_E_L_E_T_ != '*'
WHERE B8_LOCAL = '800003' AND SB8.D_E_L_E_T_ != '*' 
--AND B8_PRODUTO = '20'
AND SB1.B1_TIPCONV = 'D'
GROUP BY B8_FILIAL, B8_PRODUTO, SB1.B1_TIPCONV, SB1.B1_CONV

SELECT B8_FILIAL,  B8_PRODUTO,  SUM(B8_SALDO) AS SALDO_1, ROUND((SUM(SB8.B8_SALDO) * SB1.B1_CONV),2) AS SALDO_2
FROM SB8010 SB8
JOIN SB1010 SB1 ON SB1.B1_FILIAL = '' AND SB1.B1_COD = SB8.B8_PRODUTO AND SB1.D_E_L_E_T_ != '*'
WHERE B8_LOCAL = '800003' AND SB8.D_E_L_E_T_ != '*' 
--AND B8_PRODUTO = '20'
AND SB1.B1_TIPCONV = 'M'
GROUP BY B8_FILIAL, B8_PRODUTO, SB1.B1_TIPCONV, SB1.B1_CONV