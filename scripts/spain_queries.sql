-- Deaths VS cases over time grouped by month

SELECT 
	   EXTRACT(YEAR FROM date) AS year,
	   EXTRACT(MONTH FROM date) AS month,
	   SUM(new_deaths) AS sum_new_deaths_by_month, 
	   MAX(COALESCE(total_deaths, 0)) AS acc_total_deaths_by_month,
	   SUM(new_cases) AS sum_new_cases_by_month, 
	   MAX(COALESCE(total_cases, 0)) AS acc_total_cases_by_month
FROM covid_deaths
WHERE iso_code = 'ESP'
GROUP BY year, month
ORDER BY year, month;

-- Evolution of reproduction_rate VS vaccinations numbers

SELECT vac.iso_code,
	   EXTRACT(YEAR FROM dea.date) AS year,
	   EXTRACT(MONTH FROM dea.date) AS month,
	   AVG(COALESCE(dea.reproduction_rate, 0)) AS avg_reproduction_rate,
	   MAX(COALESCE(vac.new_vaccinations, 0)) AS sum_new_vaccinations,
	   MAX(COALESCE(vac.total_vaccinations, 0)) AS total_vaccinations,
	   MAX(COALESCE(vac.people_vaccinated, 0)) AS people_vaccinated 
FROM covid_vaccinations vac
JOIN covid_deaths dea
ON dea.date = vac.date
WHERE vac.iso_code = 'ESP'
GROUP BY vac.iso_code, year, month
ORDER BY year, month;

-- Number of patients in ICU or hospitalized compared to number of vaccinations by month		   

WITH cte_vaccinations(year, month, cte_new_vaccinations, cte_total_vaccinations, cte_people_vaccinated) AS (
	SELECT EXTRACT(YEAR FROM date) AS year,
		   EXTRACT(MONTH FROM date) AS month,
		   SUM(COALESCE(new_vaccinations, 0)) AS cte_new_vaccinations,
		   MAX(COALESCE(total_vaccinations, 0)) AS cte_total_vaccinations,
		   MAX(COALESCE(people_vaccinated, 0)) AS cte_people_vaccinated
	FROM covid_vaccinations
	WHERE iso_code = 'ESP'
	GROUP BY year, month
	ORDER BY year, month
), cte_patients(year, month, cte_icu_patients, cte_hosp_patients) AS( 
	SELECT EXTRACT(YEAR FROM date) AS year,
		   EXTRACT(MONTH FROM date) AS month,
		   MAX(COALESCE(icu_patients, 0)) AS cte_icu_patients,
		   MAX(COALESCE(hosp_patients, 0)) AS cte_hosp_patients
	FROM covid_deaths
	WHERE iso_code = 'ESP'
	GROUP BY year, month
	ORDER BY year, month
)
SELECT cv.year,
	   cv.month,
	   cv.cte_new_vaccinations,
	   cv.cte_total_vaccinations,
	   cv.cte_people_vaccinated,
	   cp.cte_icu_patients,
	   cp.cte_hosp_patients
FROM cte_vaccinations cv
JOIN cte_patients cp
ON cv.year = cp.year AND cv.month = cp.month
ORDER BY cv.year, cv.month

-- New cases and reproduction rate compared to tests performed

WITH cte_cases(iso_code, year, month, avg_new_cases, avg_reproduction_rate) AS(
	SELECT iso_code,
	   EXTRACT(YEAR FROM date) AS year,
	   EXTRACT(MONTH FROM date) AS month,
	   AVG(COALESCE(new_cases, 0)) AS avg_new_cases,
	   AVG(COALESCE(reproduction_rate, 0)) AS avg_reproduction_rate
	FROM covid_deaths
	WHERE iso_code = 'ESP'
	GROUP BY iso_code, year, month
	ORDER BY year, month
), cte_tests(iso_code, year, month, new_tests, total_tests_per_thousand) AS(
	SELECT iso_code,
		   EXTRACT(YEAR FROM date) AS year,
		   EXTRACT(MONTH FROM date) AS month,
		   MAX(COALESCE(new_tests, 0)) AS new_tests,
		   AVG(COALESCE(total_tests_per_thousand, 0)) AS total_tests_per_thousand
	FROM covid_vaccinations
	WHERE iso_code = 'ESP'
	GROUP BY iso_code, year, month
	ORDER BY year, month
)
SELECT cc.iso_code,
	   cc.year,
	   cc.month,
	   cc.avg_new_cases,
	   cc.avg_reproduction_rate,
	   ct.new_tests,
	   ct.total_tests_per_thousand
FROM cte_cases cc
JOIN cte_tests ct
ON cc.year = ct.year AND cc.month = ct.month
ORDER BY cc.year, cc.month 

-- Stringency index evolution as people gets vaccinated and number of new cases over time

SELECT cv.iso_code,
       EXTRACT(YEAR FROM cv.date) AS year,
	   EXTRACT(MONTH FROM cv.date) AS month,
	   AVG(COALESCE(cv.stringency_index, 0)) AS avg_stringency_index,
	   MAX(COALESCE(cv.people_vaccinated, 0)) AS people_vaccinated,
	   AVG(COALESCE(cd.new_cases, 0)) AS avg_new_cases
FROM covid_vaccinations cv
JOIN covid_deaths cd
ON EXTRACT(YEAR FROM cv.date) = EXTRACT(YEAR FROM cd.date) AND EXTRACT(MONTH FROM cv.date) = EXTRACT(MONTH FROM cd.date)
WHERE cv.iso_code = 'ESP'
GROUP BY cv.iso_code, year, month
ORDER BY year, month

-- vaccinations and deaths in 65_older people
-- gdp per capita, human development and mortality
--illneses in covid death rate