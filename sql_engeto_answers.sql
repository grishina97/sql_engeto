CREATE VIEW v_odpoved_na_1_otazku AS
SELECT Industry, Payroll, Years
FROM t_anastasiia_grishina_project_sql_primarni_final 
WHERE years = 2000 OR years = 2021
GROUP BY Industry, Years
ORDER BY Industry;

CREATE VIEW v_odpoved_na_2_otazku AS
SELECT products, round( avg(payroll) / avg(price) ) AS amount, year 
FROM t_Anastasiia_Grishina_project_SQL_primarni_final 
WHERE 
	Products IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový') 
	AND Year IN (2006, 2018)
GROUP BY products, YEAR;

CREATE VIEW v_odpoved_na_3_otazku AS
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
ORDER BY Rise_in_price;

CREATE VIEW v_odpoved_na_4_otazku AS
SELECT 
    B.YEAR, 
	concat( round( (A.price - B.price) / B.price * 100), '%') AS Rise_in_price,
	concat( round( (A.payroll - B.payroll) / B.payroll * 100), '%') AS Rise_in_payroll
FROM t_Anastasiia_Grishina_project_SQL_primarni_final A
LEFT JOIN t_Anastasiia_Grishina_project_SQL_primarni_final B ON A.YEAR = B.YEAR + 1
GROUP BY YEAR
ORDER BY YEAR;

CREATE VIEW v_odpoved_na_5_otazku AS
SELECT t_Anastasiia_Grishina_project_SQL_secondary_final;
