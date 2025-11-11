
SELECT TOP (10) *
FROM Walmart;

-- Criação de 3 tabelas temporárias (vendas, data e filial) para usar no Power BI

-- TABELA VENDAS

WITH vendas AS (
    SELECT
        invoice_id,
        category,
        unit_price,
        total_price,
        quantity,
        rating,
        payment_method,
        branch,
        date
    FROM Walmart
)
SELECT *
FROM vendas
WHERE
    YEAR(CONVERT(DATE, [date], 3)) IN (2022, 2023);

-- TABELA FILIAL 

WITH filial as (
    SELECT 
        branch,
        city
FROM Walmart
)

SELECT *
FROM filial


-- TABELA DATA 

WITH data AS (
    SELECT 
        CONVERT(DATE, [date], 3) as data_completa,
        YEAR(CONVERT(DATE, [date], 3)) as  ano_data,
        DATENAME(MONTH, CONVERT(DATE, [date], 3)) as mes_data,
        DATENAME(WEEKDAY, CONVERT(DATE, [date], 3)) as dia_data,
        
        CASE 
            WHEN DATEPART(HOUR, TRY_CONVERT(time, [time])) BETWEEN 6 AND 11 THEN 'Morning'
            WHEN DATEPART(HOUR, TRY_CONVERT(time, [time])) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
            END AS turno
    
    FROM 
        Walmart
    WHERE 
        YEAR(CONVERT(DATE, [date], 3)) IN (2022, 2023)
)

SELECT *
FROM data
            
