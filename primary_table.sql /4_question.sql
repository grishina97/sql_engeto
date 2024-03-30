SELECT 
	B.YEAR, 
	concat( round( (A.price - B.price) / B.price * 100), '%') AS Rise_in_price,
	concat( round( (A.payroll - B.payroll) / B.payroll * 100), '%') AS Rise_in_payroll
FROM t_Anastasiia_Grishina_project_SQL_primarni_final A
LEFT JOIN t_Anastasiia_Grishina_project_SQL_primarni_final B ON A.YEAR = B.YEAR + 1
GROUP BY YEAR
ORDER BY YEAR;
