# Walmart Sales Data Analysis - Análise de Faturamento 2022-2023  
### Power BI | Python | SQL Server

---

## **Descrição do Projeto**

Este projeto apresenta uma análise de dados de vendas da rede **Walmart** utilizando **Python (pandas)**, **SQL Server** e **Power BI**.  
O objetivo foi **comparar o desempenho de faturamento entre 2022 e 2023**, avaliar a **distribuição por categoria e método de pagamento**, e identificar **as filiais com maior crescimento percentual**.

---

## **Objetivos**

- Realizar a **extração e limpeza dos dados de vendas**.  
- Calcular o **faturamento anual e suas variações**.  
- Construir **indicadores (KPIs)** no Power BI.  
- Identificar **padrões de crescimento e sazonalidade**.  
- Criar **visualizações interativas e interpretáveis**.

---

## **Tecnologias Utilizadas**

- **Python:** pandas, matplotlib, sqlalchemy, pyodbc  
- **SQL Server:** armazenamento e consultas de dados  
- **Power BI:** visualização de KPIs e dashboards  

---

## **Estrutura Analítica**

A análise foi dividida em três etapas principais:

### *1. Tratamento e integração de dados*
- Leitura e limpeza de dados com **Python (pandas)**  
- Inserção no banco de dados **SQL Server**  
- Consultas **SQL** para agregações e filtros  

### *2. Modelagem no Power BI*
- Criação das **medidas DAX** para cálculo de KPIs  
- Relacionamentos entre tabelas de **Data, Vendas e Categoria**

### *3. Visualização e interpretação dos resultados*
- Dashboard comparando os anos de **2022 e 2023**  
- Gráficos de **distribuição e rankings** por categoria e filial  

---

## **Métricas DAX Utilizadas**

```DAX
Diferença_faturamento = [Faturamento_2023] - [Faturamento_2022]

Faturamento_2022 = CALCULATE(
    SUM('Venda'[faturamento]),
    'Data'[ano] = 2022
)

Faturamento_2023 = CALCULATE(
    SUM('Venda'[faturamento]),
    'Data'[ano] = 2023
)

iconePercentual = 
VAR v = [Variacao_percentual]
RETURN
SWITCH(
    TRUE(),
    v > 0, "🟢 ",
    v < 0, "🔴 ",
    v == 0, "⚪ "
)

Variacao_percentual = DIVIDE(
    [Diferença_faturamento],
    [Faturamento_2022]
)
```

## **Visualização dos KPIs**

Abaixo está a visualização criada no **Power BI** para acompanhar os principais indicadores de desempenho do projeto, incluindo **faturamento anual**, **variação percentual**, **distribuição por método de pagamento** e **ranking de filiais**.

<p align="center">
  <img src="imagens/dashboard_kpis.png" alt="Dashboard Power BI" width="80%">
</p>

---

## **Análise do Dashboard de Faturamento 2022-2023**

O dashboard demonstra o desempenho de faturamento, comparando **2022 e 2023**, e detalha a **distribuição por método de pagamento e categoria**, além de um **ranking por filial**.

---

### **Resultados Principais**

- **Faturamento Total (2023):** \$232 mil  
- **Faturamento Total (2022):** \$217 mil  
- **Variação Anual Absoluta (YoY):** \$15 mil  
- **Variação Percentual (YoY):** **7%** (crescimento de 2023 sobre 2022)

---

### **Desempenho e Distribuição**

**Faturamento por Método de Pagamento:**
- Cartão de Crédito: \$179,11 mil (76,89%)  
- eWallet: \$195,86 mil (43,56%)  
- Dinheiro (Cash): \$74,69 mil (16,61%)  

> *Observação:* a soma dos percentuais deve ser verificada em relação ao total do dataset.

**Faturamento por Categoria:**
- *Fashion Accessories (Acessórios de Moda)* lidera as vendas.  
- *Home and Lifestyle* e *Electronic Accessories* seguem em ordem decrescente.  

**Sazonalidade:** crescimento acentuado nos meses de **outubro, novembro e dezembro de 2023** em comparação com 2022.

---

### **Desempenho por Filial**

Maiores crescimentos percentuais (**2023 vs 2022**):

| **Filial** | **Localização** | **Crescimento (%)** |
|:-----------:|:----------------|-------------------:|
| MALM006 | El Paso | **173%** |
| MALM010 | Laredo | **162%** |
| MALM091 | Little Elm | **149%** |

---

## **Conclusão**

A análise demonstra um **aumento consistente no faturamento** de 2023 em relação a 2022, com destaque para o crescimento em **algumas filiais e categorias específicas**.  
Os resultados evidenciam o potencial da **integração entre Python, SQL e Power BI** para criação de **relatórios de desempenho automatizados e visualmente intuitivos**.

---

## **Autor**

**Dion Lopes**  
Projeto de **Análise de Dados** com fins educacionais e demonstrativos.  

[LinkedIn](https://www.linkedin.com) | [GitHub](https://github.com/seuusuario)

