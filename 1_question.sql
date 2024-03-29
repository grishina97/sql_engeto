-- Otázka 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
-- vytvořila jsem tabulku do které jsem zadala důležité data pro odpoved na otázku 1:
CREATE TABLE t_industry_payroll_years (
Industry varchar(255),
Payroll int,
Years year(4) 
);
INSERT INTO t_industry_payroll_years (Industry, Payroll, Years)
SELECT b.name, round(avg(a.value)), a.payroll_year
FROM czechia_payroll a
JOIN czechia_payroll_industry_branch b ON a.industry_branch_code = b.code
WHERE a.value_type_code = 5958 AND a.unit_code = 200
GROUP BY b.name, a.value, a.payroll_year
ORDER BY b.name, a.payroll_year;
-- unit_code = 200 znamená kč
-- value_type_code = 5958 znamená Průměrná hrubá mzda na zaměstnance
SELECT Industry, Payroll, Years
FROM t_industry_payroll_years
WHERE years = 2000 OR years = 2021
GROUP BY Industry, Years
ORDER BY Industry;
-- pro porovnání jsem vybrala prví a poslední srovnatelné období.
-- Odpověd na 1 otázku: V průběhu let mzdy ve všech odvětvích rostou.
