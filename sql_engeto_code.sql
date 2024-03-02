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



-- Otázka 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
SELECT min(date_from), max(date_to) FROM czechia_price ;
-- z tohoto selectu jsem dozvěděla první a poslední srovnatelné období: 2006-01-02, 2018-12-10. 
CREATE TABLE t_products_price_year AS (
SELECT 
	cpc.name AS Products,
    round(avg(cp.value)) AS Price, 
    YEAR(cp.date_from) AS Year
FROM czechia_price cp
JOIN czechia_price_category cpc
	ON cpc.code = cp.category_code
GROUP BY Products, YEAR
ORDER BY Products, YEAR 
);
SELECT * FROM t_products_price_year;
-- vytvořila jsem další tabulku s daty z czechia_price, kterou pak spojim s první. 
-- Zkoušela jsem ty data zadat ihned do původní tabulky, ale měla jsem problém spojít data do jednoho řádku. Vyhazelo mě to tak, že tyto data jsem měla uplně nakonci a zprava.
-- vybrala jsem jenom date_from protože potřebuju jenom rok, a roky s date_to se rovnají.
CREATE TABLE t_Anastasiia_Grishina_project_SQL_primarni_final AS (
SELECT * FROM t_industry_payroll_years ag LEFT JOIN t_products_price_year pt ON ag.years = pt.YEAR);
ALTER TABLE t_Anastasiia_Grishina_project_SQL_primarni_final
DROP COLUMN years;
-- abych neměla dva krát sloupec rok, smazala jsem jeden, data by se neměli ztratit. 
SELECT * FROM t_Anastasiia_Grishina_project_SQL_primarni_final;
SELECT products, round( avg(payroll) / avg(price) ) AS amount, year 
FROM t_Anastasiia_Grishina_project_SQL_primarni_final 
WHERE 
	Products IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový') 
	AND Year IN (2006, 2018)
GROUP BY products, YEAR;
-- abych dozvěděla kolik je možné koupit mléka a chleba, rozdělila jsem průmernou mzdu na průměrnou cenu za Chleb a Mléko, 
-- a to vše za rok 2006 a 2018.
-- Odpověd na otázku 2: za první srovnatelné období je možné koupit 1297 kusů Chleba а 1482 litru Mléka. 
-- Za poslední srovnatelné období je možné koupit 1357 kusů Chleba a 1629 litrů Mléka.



-- Otázka 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
-- našla jsem vzorec ze statistiky jak vypočítat roční tempo růstu cen: 
SELECT 
    a.products, 
    concat ( round( ((b.avg_price_2018 - a.avg_price_2006) / a.avg_price_2006) * 100 ) , '%') AS Price_appreciation
FROM
    (SELECT products, AVG(price) AS avg_price_2006
     FROM t_Anastasiia_Grishina_project_SQL_primarni_final  
     WHERE YEAR = 2006
     GROUP BY products) AS a
JOIN
    (SELECT products, AVG(price) AS avg_price_2018
     FROM t_Anastasiia_Grishina_project_SQL_primarni_final  
     WHERE YEAR = 2018
     GROUP BY products) AS b 
ON a.products = b.products
ORDER BY Price_appreciation
;
-- pak jsem vymyslela vzorec pro percentuální meziroční nárůst, a doufám že je správný:
SELECT 
    a.products, 
    concat ( round( (b.avg_price_2018 - a.avg_price_2006) * 100 / (b.avg_price_2018 + a.avg_price_2006) ) , '%') AS Rise_in_price
FROM
    (SELECT products, AVG(price) AS avg_price_2006
     FROM t_Anastasiia_Grishina_project_SQL_primarni_final  
     WHERE YEAR = 2006
     GROUP BY products) AS a
JOIN
    (SELECT products, AVG(price) AS avg_price_2018
     FROM t_Anastasiia_Grishina_project_SQL_primarni_final  
     WHERE YEAR = 2018
     GROUP BY products) AS b 
ON a.products = b.products
ORDER BY Rise_in_price
;
-- Odpověd na otázku 3: Zdražuje se nejpomaleji Cukr krystalový a nejnižší percentuální meziroční nárůst má taký Cukr krystalový.
-- jenom nejsem si jistá, je to normální že mám zápornou hodnotu?



-- Question 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
-- budu porovnávát jenom v období 2006-2018 protože data o mzdách a cenach se začánají spolu jen od 2006. 
-- Vzorec meziročního nárustu cen jsem taký našla ze statistiky.
SELECT 
    B.YEAR, 
	concat( round( (A.price - B.price) / B.price * 100), '%') AS Rise_in_price,
	concat( round( (A.payroll - B.payroll) / B.payroll * 100), '%') AS Rise_in_payroll
FROM t_Anastasiia_Grishina_project_SQL_primarni_final A
LEFT JOIN t_Anastasiia_Grishina_project_SQL_primarni_final B ON A.YEAR = B.YEAR + 1
GROUP BY YEAR
ORDER BY YEAR;
-- bohužel zvládá to velmi pomalu, a kvůli tomu nemohu napsat odpoved (zvlášt to taký nejde).



-- Otázka 5: Má výška HDP vliv na změny ve mzdách a cenách potravin? 
-- Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?
CREATE TABLE t_Anastasiia_Grishina_project_SQL_secondary_final AS 
SELECT b.YEAR AS Year, round(avg(a.GDP/1000000000)) AS HDP, round(avg(b.price)) AS Price, round(avg(b.payroll)) AS Payroll
FROM economies a
JOIN t_Anastasiia_Grishina_project_SQL_primarni_final b ON a.YEAR = b.year 
GROUP BY YEAR
ORDER BY YEAR
;
-- Odpověd na otázku 5: ano, HDP má vliv na změny ve mzdách a cenách potravin, protože HDP rosté od roku 2006 do 2018 a spolu s ni rostou i ceny i mzdy.

  

