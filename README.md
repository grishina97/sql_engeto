# sql_project
Toto je můj první projekt v SQL 🥳 Řešila jsem úkoly z mého kurzu datové analýzy „Engeto“. Můj kód můžete použít pouze v případě, že máte databázi od Engeto Academy. V souboru **primary_table.sql** jsem vytvořila čtyři kódy pro čtyři otázky, v **secondary_table.sql** jsem zahrnula můj pátý kód, a v souboru **view_answers.sql** můžete najít 5 vytvořených pohledů na základě odpovědí na otázky. 

## Výzkumné otázky a odpovědí:
Abych mohla vytvořit primární tabulku, bylo potřeba nejprve vytvořit dvě pomocné a pak je vložit do primární. Co se týče sekundární tabulky, tu jsem vytvořila na konci pomocí své primární a tabulky _economies_ z databáze.
 
 **1.	Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?**
* Vytvořila jsem tabulku _t_industry_payroll_years_, do které jsem vložila data: Industry, Payroll, Years z tabulek _czechia_payroll_ a _czechia_payroll_industry_branch_. Vybrala jsem tyto tabulky, protože otázka se týče mezd. A ještě jsem vybrala unit_code jenom pro Kč a value_type_code pro průměrnou hrubou mzdu na zaměstnance. Poté jsem vybrala roky 2000 a 2021, protože potřebuji vědět o prvním a posledním srovnatelném období.
* Odpověd na 1 otázku: V průběhu let mzdy ve všech odvětvích rostou.

 **2.	Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?**
* Nejdříve jsem zjistila první a poslední srovnatelné období v dostupných datech cen a mezd, což je rok 2006 a 2018. Poté jsem vytvořila tabulku _t_products_price_year_, do které jsem vložila data: Product, Price, Year z tabulek _czechia_price_ a _czechia_price_category_. Tyto tabulky jsem použila, protože otázka se týká cen produktů. Vybrala jsem jen date_from, protože potřebuji jen roky, a ty se shodují s date_to. Nyní mohu své dvě tabulky spojit dohromady a vytvořit finální tabulku, ve které bude možné najít odpovědi na všechny čtyři otázky: _t_Anastasiia_Grishina_project_SQL_primarni_final_. Abych neměla dvakrát sloupec rok, smazala jsem jeden, data by se neměla ztratit, protože roky byly stejné. Poté, abych zjistila, kolik je možné koupit mléka a chleba, jsem rozdělila průměrnou mzdu na průměrnou cenu pro chleb a mléko, a to vše jen v letech 2006 a 2018.
* Odpověd na otázku 2: za první srovnatelné období je možné koupit 1297 kusů Chleba а 1482 litru Mléka. Za poslední srovnatelné období je možné koupit 1357 kusů Chleba a 1629 litrů Mléka.

 **3.	Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?**
* Našla jsem vzorec ze statistiky, jak vypočítat roční tempo růstu cen: (cena za poslední rok – cena za prví rok) / cena za první rok * 100, takže odpověd bude v procentech. Produkty a ceny jsem brala už ze své finální tabulky. Pak jsem vymyslela vzorec pro percentuální meziroční nárůst: (cena za poslední rok – cena za prví rok) * 100 / (cena za poslední rok + cena za prví rok), také v procentech. A u obou jsem použila JOIN kde první SELECT byl pro rok 2006 a druhý pro 2018.
* Odpověd na otázku 3: Nejpomaleji zdražuje cukr krystalový, který má také nejnižší percentuální meziroční nárůst. (Jen nejsem si jistá, je to normální, že mám zápornou hodnotu?)
  
 **4.	Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?**
* Budu porovnávát jenom v období 2006-2018, protože data o mzdách a cenách se začánají schodovat jen od roku 2006. Vzorec meziročního nárůstu cen, který jsem našla ve statistice: (současný rok - předchozí rok) / předchozí rok * 100, odpověd je v procentech.
* Odpověd na otázku 4: Neexistuje žádný rok, ve kterém by byl významný rozdíl, ale maximální rozdíl o 4 % je v roce 2011.

 **5.	Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?**
* Vytvořila jsem sekundární tabulku _t_Anastasiia_Grishina_project_SQL_secondary_final_, a vložila jsem do ní data: HDP (rozdělila jsem GDP na 100 mil. aby data vypadala jednodušeji), Price, Payroll z tabulky _economies_ a připojila jsem primární tabulku, protože ceny a mzdy mám v ní.
* Odpověd na otázku 5: ano, HDP má vliv na změny ve mzdách a cenách potravin, protože HDP rosté od roku 2006 do 2018 a spolu s ni rostou i ceny i mzdy.
