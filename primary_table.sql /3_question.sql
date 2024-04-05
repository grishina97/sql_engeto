SELECT 
    a.products, 
    concat ( round( ((b.avg_price_2018 - a.avg_price_2006) / a.avg_price_2006) * 100 ) , '%') AS Price_appreciation
FROM
    (SELECT products, AVG(price) AS avg_price_2006
     FROM t_Anastasiia_Grishina_project_SQL_primary_final  
     WHERE YEAR = 2006
     GROUP BY products) AS a
JOIN
    (SELECT products, AVG(price) AS avg_price_2018
     FROM t_Anastasiia_Grishina_project_SQL_primary_final  
     WHERE YEAR = 2018
     GROUP BY products) AS b 
ON a.products = b.products
ORDER BY Price_appreciation;

SELECT 
    a.products, 
    concat ( round( (b.avg_price_2018 - a.avg_price_2006) * 100 / (b.avg_price_2018 + a.avg_price_2006) ) , '%') AS Rise_in_price
FROM
    (SELECT products, AVG(price) AS avg_price_2006
     FROM t_Anastasiia_Grishina_project_SQL_primary_final  
     WHERE YEAR = 2006
     GROUP BY products) AS a
JOIN
    (SELECT products, AVG(price) AS avg_price_2018
     FROM t_Anastasiia_Grishina_project_SQL_primary_final  
     WHERE YEAR = 2018
     GROUP BY products) AS b 
ON a.products = b.products
ORDER BY Rise_in_price;
