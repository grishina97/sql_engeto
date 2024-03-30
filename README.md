# sql_project
This is my first project in sql :partying_face:. I was answering assignments from my data analytics course "Engeto". You can use my code only if you have a database from Engeto Academy. In code_with_comments.sql you can find the whole code with my comments in Czech. In view_answers.sql you can find 5 created views based on the answers to the questions. And in primary_table.sql I created four codes for the four questions, they are structured one by one, so in secondary_table.sql I included my fifth code.

## Výzkumné otázky a odpovědí:
Abych mohla vytvořit primární tabulku, bylo potřeba nejprve vytvořit dvě pomocné a pak je vložit do primární. Co se týče sekundární tabulky, tu jsem vytvořila na konci pomocí své primární a tabulky "economies" z databáze.
  1.	Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
* Vytvořila jsem tabulku "t_industry_payroll_years", do které jsem vložila data: Industry, Payroll, Years z tabulek czechia_payroll a czechia_payroll_industry_branch. Vybrala jsem tyto tabulky, protože otázka se týče mezd. A ještě jsem vybrala unit_code jenom pro Kč a value_type_code pro průměrnou hrubou mzdu na zaměstnance. Poté jsem vybrala roky 2000 a 2021, protože potřebuji vědět o prvním a posledním srovnatelném období.
* Odpověd na 1 otázku: V průběhu let mzdy ve všech odvětvích rostou.
