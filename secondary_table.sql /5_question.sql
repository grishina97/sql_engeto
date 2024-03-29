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
