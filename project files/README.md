
Walmart Sales Data Analysis

Descrição do Projeto

Este projeto tem como objetivo realizar a análise de dados de vendas do Walmart, utilizando ferramentas de Python (Pandas), SQL Server e Power BI.
O fluxo completo envolve a limpeza e transformação dos dados, carregamento no banco de dados SQL Server e criação de tabelas analíticas para visualização em dashboards interativos.

Tecnologias Utilizadas

Python 3.10+

Bibliotecas: pandas, sqlalchemy, psycopg2, pyodbc

SQL Server (SQL Express)

Power BI Desktop

Dataset: Walmart_dataset.csv

Etapas do Projeto

1. Limpeza e Transformação dos Dados com Python

As principais etapas do tratamento foram:

Leitura do dataset original com pandas.read_csv().

Verificação de valores nulos (.isnull().sum()) e remoção de linhas incompletas (dropna()).

Eliminação de duplicatas (drop_duplicates()).

Padronização dos nomes das colunas para letras minúsculas.

Conversão de tipos de dados:

quantity → inteiro

unit_price → float (remoção do símbolo $)

Criação da coluna total_price com base na multiplicação entre unit_price e quantity.

Exportação do dataset tratado para um novo arquivo:

Cdf.to_csv('Dataset_Walmart_transformed.csv', index=False)

2. Envio do Dataset para o SQL Server

Após o tratamento, o dataset foi carregado no SQL Server usando SQLAlchemy:

from sqlalchemy import create_engine

engine = create_engine(
    "mssql+pyodbc://@localhost\\SQLEXPRESS/wlt?driver=ODBC+Driver+17+for+SQL+Server&trusted_connection=yes"
)

df.to_sql(
    name='Walmart',
    con=engine,
    if_exists='replace',
    index=False
)

3. Consultas SQL e Criação de Tabelas de Apoio

    Tabela de Vendas

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
WHERE YEAR(CONVERT(DATE, [date], 3)) IN (2022, 2023);

    Tabela de Filial

WITH filial AS (
    SELECT 
        branch,
        city
    FROM Walmart
)
SELECT *
FROM filial;

    Tabela de Data

WITH data AS (
    SELECT 
        CONVERT(DATE, [date], 3) AS data_completa,
        YEAR(CONVERT(DATE, [date], 3)) AS ano_data,
        DATENAME(MONTH, CONVERT(DATE, [date], 3)) AS mes_data,
        DATENAME(WEEKDAY, CONVERT(DATE, [date], 3)) AS dia_data,
        CASE 
            WHEN DATEPART(HOUR, TRY_CONVERT(time, [time])) BETWEEN 6 AND 11 THEN 'Morning'
            WHEN DATEPART(HOUR, TRY_CONVERT(time, [time])) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS turno
    FROM Walmart
    WHERE YEAR(CONVERT(DATE, [date], 3)) IN (2022, 2023)
)
SELECT * FROM data;


Essas tabelas servem como base para modelagem no Power BI, permitindo análises como:

Faturamento total por ano

Vendas por categoria e filial

Padrões de compra por horário e dia da semana

Resultados e Visualizações

As tabelas criadas no SQL Server foram importadas para o Power BI, onde foram desenvolvidos dashboards interativos com os principais indicadores de desempenho.
(Você pode incluir prints ou links do dashboard aqui quando quiser)

4. Métricas DAX Implementadas

As seguintes medidas foram criadas no Power BI para acompanhar a evolução do faturamento entre 2022 e 2023:

Faturamento 2022

Calcula o total de faturamento apenas para o ano de 2022.

Faturamento_2022 = 
CALCULATE(
    SUM('Venda'[faturamento]),
    'Data'[ano] = 2022
)

Faturamento 2023

Calcula o total de faturamento apenas para o ano de 2023.

Faturamento_2023 = 
CALCULATE(
    SUM('Venda'[faturamento]),
    'Data'[ano] = 2023
)

Diferença de Faturamento

Retorna a diferença absoluta entre o faturamento de 2023 e 2022.

Diferença_faturamento = 
[Faturamento_2023] - [Faturamento_2022]

Variação Percentual

Calcula a variação percentual entre os dois anos.

Variacao_percentual = 
DIVIDE(
    [Diferença_faturamento],
    [Faturamento_2022]
)

Ícone de Tendência Percentual

Mostra um ícone visual conforme o resultado da variação:

🟢 aumento

🔴 queda

⚪ estabilidade

iconePercentual = 
VAR v = [Variacao_percentual]
RETURN
SWITCH(
    TRUE(),
    v > 0, "🟢 ",
    v < 0, "🔴 ",
    v == 0, "⚪ "
)


Essas métricas foram utilizadas para construir os KPIs principais no dashboard do Power BI, permitindo visualizar de forma rápida:

O faturamento total por ano;

A variação percentual entre períodos;

A tendência (positiva, negativa ou neutra) com ícones visuais.

5. Visualização dos KPIs — Dashboard de Faturamento 2022–2023

O dashboard desenvolvido no Power BI apresenta a análise comparativa do faturamento entre os anos de **2022 e 2023**, com foco em **método de pagamento**, **categoria de produto** e **desempenho por filial**.

![Dashboard Power BI](imagens/dashboard_kpis.png)

---

### 💰 Resultados Principais

- **Faturamento Total (2023):** \$232 mil  
- **Faturamento Total (2022):** \$217 mil  
- **Variação Absoluta (YoY):** \$15 mil  
- **Variação Percentual (YoY):** **+7%** (crescimento de 2023 sobre 2022)

As métricas foram calculadas no Power BI por meio de **medidas DAX**, integrando os dados processados via Python e SQL Server.

---

### 📈 Desempenho e Distribuição

**Faturamento por Método de Pagamento:**
- 💳 *Cartão de Crédito:* \$179,11 mil (**76,89%**)  
- 📱 *eWallet:* \$195,86 mil (**43,56%**)  
- 💵 *Cash:* \$74,69 mil (**16,61%**)  

> ⚠️ Observação: a soma dos percentuais indica que o cálculo pode estar sendo feito sobre o total de vendas gerais. É recomendável revisar a base para garantir consistência percentual.

**Faturamento por Categoria:**
- 👜 *Fashion Accessories* — categoria com maior faturamento  
- 🏠 *Home and Lifestyle* — segunda posição  
- 💻 *Electronic Accessories* — terceira posição  

📅 **Sazonalidade:** crescimento acentuado nos últimos meses de **2023 (Outubro, Novembro, Dezembro)** em relação a 2022, indicando possível efeito sazonal nas vendas.

---

### 🗺️ Desempenho por Filial

Filiais com maior crescimento percentual (2023 vs 2022):

| Filial | Localização | Variação (%) |
|:-------|:-------------|-------------:|
| MALM006 | El Paso | **+173%** |
| MALM010 | Laredo | **+162%** |
| MALM091 | Little Elm | **+149%** |

---

6. Aprendizados

Durante o desenvolvimento deste projeto, foram consolidados conhecimentos sobre:

Limpeza e transformação de dados com Pandas.

Integração entre Python e SQL Server.

Criação de modelos relacionais para análise em Power BI.

Organização de um fluxo de ETL (Extract, Transform, Load) completo.

Próximos Passos

Implementar métricas DAX no Power BI para KPIs de faturamento e desempenho por categoria.

Automatizar o fluxo de atualização de dados.

Adicionar testes e logs no script Python.

Autor

Dion Lopes
[Seu email opcional]
[Link do seu GitHub ou LinkedIn]


