SELECT min(date_from), max(date_to) FROM czechia_price ;

CREATE TABLE t_products_price_year AS (
SELECT 
	cpc.name AS Products,
	round(avg(cp.value)) AS Price, 
	YEAR(cp.date_from) AS Year
FROM czechia_price cp
JOIN czechia_price_category cpc
	ON cpc.code = cp.category_code
GROUP BY Products, YEAR
ORDER BY Products, YEAR);

SELECT * FROM t_products_price_year;

CREATE TABLE t_Anastasiia_Grishina_project_SQL_primarni_final AS (
SELECT * FROM t_industry_payroll_years ag LEFT JOIN t_products_price_year pt ON ag.years = pt.YEAR);

ALTER TABLE t_Anastasiia_Grishina_project_SQL_primarni_final
DROP COLUMN years;

SELECT * FROM t_Anastasiia_Grishina_project_SQL_primarni_final;
SELECT products, round( avg(payroll) / avg(price) ) AS amount, year 
FROM t_Anastasiia_Grishina_project_SQL_primarni_final 
WHERE 
	Products IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový') 
	AND Year IN (2006, 2018)
GROUP BY products, YEAR;
