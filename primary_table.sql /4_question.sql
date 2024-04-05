SELECT 
    B.YEAR, 
    concat( round( (A.price - B.price) / B.price * 100), '%') AS Rise_in_price,
    concat( round( (A.payroll - B.payroll) / B.payroll * 100), '%') AS Rise_in_payroll
FROM (
    SELECT avg(price) AS price, YEAR, avg(payroll) AS payroll
    FROM t_Anastasiia_Grishina_project_SQL_primarni_final 
    GROUP BY year
    ) AS A
LEFT JOIN (
    SELECT avg(price) AS price, YEAR, avg(payroll) AS payroll
    FROM t_Anastasiia_Grishina_project_SQL_primarni_final 
    GROUP BY year
    ) AS B 
        ON A.YEAR = B.YEAR + 1
GROUP BY YEAR
ORDER BY YEAR;
