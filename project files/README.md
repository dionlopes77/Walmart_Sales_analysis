
# Walmart Sales Data Analysis

## **Autor**

**Dion Lopes**  
Projeto de **Análise de Dados** com fins educacionais e demonstrativos.  

[LinkedIn](https://www.linkedin.com) | [GitHub](https://github.com/seuusuario)

## **Descrição do Projeto**
Este projeto apresenta uma análise de dados de vendas da rede **Walmart**, desenvolvida com **Python (Pandas)**, **SQL Server** e **Power BI**.  
O objetivo foi **comparar o desempenho de faturamento entre 2022 e 2023**, avaliar a **distribuição por categoria e método de pagamento**, e identificar as **filiais com maior crescimento percentual**.  

O fluxo completo envolve:  
1. **Limpeza e transformação dos dados** em Python  
2. **Carregamento e consultas** no SQL Server  
3. **Criação de dashboards interativos** no Power BI  

---

## **Tecnologias Utilizadas**
- **Python 3.10+**
  - Bibliotecas: `pandas`, `sqlalchemy`, `psycopg2`, `pyodbc`, `matplotlib`
- **SQL Server (SQL Express)** – armazenamento e consultas analíticas
- **Power BI Desktop** – visualização e criação de KPIs
- **Dataset:** `Walmart_dataset.csv`

---

## **Etapas do Projeto**

### 1 **Tratamento e Limpeza dos Dados (Python)**
Principais etapas realizadas com `pandas`:
- Leitura do dataset: `pd.read_csv()`
- Verificação e remoção de valores nulos: `.isnull().sum()` e `.dropna()`
- Eliminação de duplicatas: `.drop_duplicates()`
- Padronização de colunas para letras minúsculas
- Conversão de tipos:
  - `quantity` → inteiro  
  - `unit_price` → float (remoção do símbolo `$`)
- Criação da coluna `total_price` = `unit_price * quantity`
- Exportação do dataset tratado:
  ```python
  df.to_csv('Dataset_Walmart_transformed.csv', index=False)

### 2 **Envio do Dataset ao SQL Server**
O dataset tratado foi carregado no SQL Server usando SQLAlchemy:

```
python
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
```

### 3. **Consultas SQL e Criação das Tabelas de Apoio**

Após o carregamento no SQL Server, foram criadas três tabelas auxiliares:

- vendas – contém informações detalhadas de cada venda (invoice_id, category, total_price, payment_method, etc.)
- filial – mapeia filiais e suas respectivas cidades.
- data – organiza a dimensão temporal (ano, mês, dia da semana e turno).

O código completo dessas consultas está disponível no arquivo
sql_queries/walmart_tables.sql


**Essas tabelas serviram como base para análises de:**

- Faturamento total por ano
- Vendas por categoria e filial
- Padrões de compra por horário e dia da semana
- Modelagem e Visualização (Power BI)

### **4 Modelagem e Visualização (Power BI)**

A modelagem no Power BI envolveu:

- Criação das medidas DAX para KPIs
- Relacionamentos entre tabelas de Data, Vendas e Categoria
- Construção de dashboards comparativos 2022–2023

**Principais Métricas DAX**

As seguintes medidas foram criadas para analisar o desempenho de faturamento e crescimento anual:

- Faturamento_2022 → soma do faturamento no ano de 2022.
- Faturamento_2023 → soma do faturamento no ano de 2023.
- Diferença_faturamento → diferença absoluta entre os dois anos.
- Variação_percentual (YoY) → crescimento percentual de 2023 em relação a 2022.
- Ícone de tendência → representação visual (🟢🔴⚪) da variação percentual.

```
Diferença_faturamento = [Faturamento_2023] - [Faturamento_2022]

Faturamento_2022 = 
CALCULATE(
    SUM('Venda'[faturamento]),
    'Data'[ano] = 2022
)

Faturamento_2023 = 
CALCULATE(
    SUM('Venda'[faturamento]),
    'Data'[ano] = 2023
)

Variacao_percentual = 
DIVIDE([Diferença_faturamento], [Faturamento_2022])

iconePercentual = 
VAR v = [Variacao_percentual]
RETURN
SWITCH(
    TRUE(),
    v > 0, "🟢 ",
    v < 0, "🔴 ",
    v == 0, "⚪ "
)
```

**Visualização dos KPIs**

O dashboard apresenta:

- Faturamento Anual (2022 vs 2023)
- Variação Percentual (YoY)
- Distribuição por Método de Pagamento
- Ranking de Filiais e Categorias

![Dashboard Power BI](https://github.com/dionlopes77/Walmart_Sales_analysis/blob/main/imagens/dashboard_kpis.png.png?raw=true)


### **Análise do Dashboard de Faturamento 2022-2023**

**Principais Resultados**

| Indicador              | 2022     | 2023     | Variação    |
| ---------------------- | -------- | -------- | ----------- |
| **Faturamento Total**  | $217 mil | $232 mil | **+7%**     |
| **Diferença Absoluta** | —        | —        | **$15 mil** |


Crescimento mais acentuado nos meses de outubro a dezembro de 2023, indicando sazonalidade positiva no fim do ano.

**Desempenho e Distribuição**

*Faturamento por Método de Pagamento:*
 - Cartão de Crédito: $179,11 mil (76,89%)
 - eWallet: $195,86 mil (43,56%)
 - Dinheiro (Cash): $74,69 mil (16,61%)

Observação: a soma dos percentuais deve ser verificada em relação ao total do dataset.

*Faturamento por Categoria:*
- Fashion Accessories (Acessórios de Moda) lidera as vendas.
- Home and Lifestyle e Electronic Accessories seguem em ordem decrescente.
- Sazonalidade: crescimento acentuado nos meses de outubro, novembro e dezembro de 2023 em comparação com 2022.

**Filiais com Maior Crescimento (2023 vs 2022)**

| Filial  | Localização | Crescimento |
| ------- | ----------- | ----------- |
| MALM006 | El Paso     | 173%        |
| MALM010 | Laredo      | 162%        |
| MALM091 | Little Elm  | 149%        |


### Conclusão 

A análise demonstra um **aumento consistente no faturamento** de 2023 em relação a 2022, com destaque para o crescimento em **algumas filiais e categorias específicas**.  
Os resultados evidenciam o potencial da **integração entre Python, SQL e Power BI** para criação de **relatórios de desempenho automatizados e visualmente intuitivos**.





