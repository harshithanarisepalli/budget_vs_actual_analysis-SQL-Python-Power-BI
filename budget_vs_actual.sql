
-- How did the company's actual revenue perform compared to the budgeted revenue?

SELECT
    ROUND(SUM(budget_revenue)::numeric,2) AS budget_revenue,
    ROUND(SUM(actual_revenue)::numeric,2) AS actual_revenue,
    ROUND(SUM(variance_usd)::numeric,2) AS revenue_variance,
    ROUND(AVG(variance_pct)::numeric,2) AS avg_variance_pct
FROM budgetvsactual;

-- The company generated approximately $2.1 million less revenue than budgeted, resulting in an average revenue variance of around -0.65%.


-- Which product lines contributed the most to the overall revenue variance?

SELECT
    product_line,
    ROUND(SUM(budget_revenue)::numeric,2) AS budget_revenue,
    ROUND(SUM(actual_revenue)::numeric,2) AS actual_revenue,
    ROUND(SUM(variance_usd)::numeric,2) AS revenue_variance,
    ROUND(AVG(variance_pct)::numeric,2) AS avg_variance_pct
FROM budgetvsactual
GROUP BY product_line
ORDER BY avg_variance_pct;

-- Electronics recorded the largest negative revenue variance, while Sports and Fashion exceeded their budget targets.


-- Which regions contributed most to the revenue variance?

SELECT
    region,
    ROUND(SUM(budget_revenue)::numeric,2) AS budget_revenue,
    ROUND(SUM(actual_revenue)::numeric,2) AS actual_revenue,
    ROUND(SUM(variance_usd)::numeric,2) AS revenue_variance,
    ROUND(AVG(variance_pct)::numeric,2) AS avg_variance_pct
FROM budgetvsactual
GROUP BY region
ORDER BY avg_variance_pct;

-- The South recorded the highest negative revenue variance, while the Northeast performed closest to its budget target.


-- Which states within each region were driving regional revenue performance?

SELECT
    region,
    state,
    ROUND(SUM(budget_revenue)::numeric,2) AS budget_revenue,
    ROUND(SUM(actual_revenue)::numeric,2) AS actual_revenue,
    ROUND(SUM(variance_usd)::numeric,2) AS revenue_variance,
    ROUND(AVG(variance_pct)::numeric,2) AS avg_variance_pct
FROM budgetvsactual
GROUP BY region, state
ORDER BY avg_variance_pct;

-- Florida recorded one of the largest negative revenue variances, while Ohio achieved one of the strongest performances against budget.


-- How did revenue performance change over time?

SELECT
    DATE_TRUNC('month', date) AS month,
    ROUND(SUM(budget_revenue)::numeric,2) AS budget_revenue,
    ROUND(SUM(actual_revenue)::numeric,2) AS actual_revenue,
    ROUND(SUM(variance_usd)::numeric,2) AS revenue_variance,
    ROUND(AVG(variance_pct)::numeric,2) AS avg_variance_pct
FROM budgetvsactual
GROUP BY month
ORDER BY month;

-- Revenue remained relatively close to budget throughout the year with only minor month-to-month variation.


-- Which individual products performed best and worst against their revenue targets?

SELECT
    product_line,
    product,
    ROUND(SUM(budget_revenue)::numeric,2) AS budget_revenue,
    ROUND(SUM(actual_revenue)::numeric,2) AS actual_revenue,
    ROUND(SUM(variance_usd)::numeric,2) AS revenue_variance,
    ROUND(AVG(variance_pct)::numeric,2) AS avg_variance_pct
FROM budgetvsactual
GROUP BY product_line, product
ORDER BY avg_variance_pct;

-- Products within the Electronics category consistently underperformed, while several Fashion and Sports products exceeded expectations.


-- Did discount levels contribute to the revenue variance?

SELECT
    product_line,
    ROUND(AVG(discount_pct)::numeric,2) AS avg_discount_pct,
    ROUND(AVG(variance_pct)::numeric,2) AS avg_variance_pct
FROM budgetvsactual
GROUP BY product_line
ORDER BY avg_discount_pct DESC;

-- Electronics offered the highest average discounts and also recorded the weakest revenue performance against budget.


-- Was there a significant difference between standard prices and selling prices across product lines?

WITH avg_prices AS (
    SELECT
        product_line,
        ROUND(AVG(standard_price_usd)::numeric,2) AS avg_standard_price,
        ROUND(AVG(selling_price_usd)::numeric,2) AS avg_selling_price
    FROM budgetvsactual
    GROUP BY product_line
)
SELECT
    product_line,
    avg_standard_price,
    avg_selling_price,
    ROUND((avg_standard_price - avg_selling_price)::numeric,2) AS price_difference
FROM avg_prices
ORDER BY price_difference DESC;

-- Electronics showed the largest gap between standard and selling prices, reflecting the most aggressive price reductions.

