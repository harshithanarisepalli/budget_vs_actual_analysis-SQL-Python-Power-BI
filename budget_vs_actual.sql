--1.variance analysis between budgeted and actual revenue
select
    round(sum(budget_revenue)::numeric,2) as budget,
    round(sum(actual_revenue)::numeric,2) as actual,
    round(sum(variance_usd)::numeric,2) as variance,
    round(avg(variance_pct)::numeric,2) as avg_variance_pct
from budgetvsactual;
----The company generated approximately $646.6 million less revenue than budgeted, with an average revenue variance of -22.33%, indicating that overall revenue targets were not achieved.


--2.Rootcause analysis:-investigating why the company missed its target.
---2a.Which product lines contributed most to the revenue shortfall?
select product_line,round(sum(budget_revenue)::numeric,2) as budget,
    round(sum(actual_revenue)::numeric,2) as actual,
    round(sum(variance_usd)::numeric,2) as variance,
    round(avg(variance_pct)::numeric,2) as avg_variance_pct
from budgetvsactual
group by product_line
order by avg_variance_pct ;

---2b