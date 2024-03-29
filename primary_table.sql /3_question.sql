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
