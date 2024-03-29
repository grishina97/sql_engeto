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
