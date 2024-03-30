CREATE TABLE t_Anastasiia_Grishina_project_SQL_secondary_final AS 
SELECT b.YEAR AS Year, round(avg(a.GDP/1000000000)) AS HDP, round(avg(b.price)) AS Price, round(avg(b.payroll)) AS Payroll
FROM economies a
JOIN t_Anastasiia_Grishina_project_SQL_primarni_final b ON a.YEAR = b.year 
GROUP BY YEAR
ORDER BY YEAR;
