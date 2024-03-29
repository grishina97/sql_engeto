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
