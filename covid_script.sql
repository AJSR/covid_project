SELECT location, date, total_cases, new_cases, total_deaths, population
FROM covid_deaths 
ORDER BY 1, 2;

-- Looking at total cases VS total deaths
--Shows lilkelihood of dying if you contract covid in each country
SELECT location, SUM(total_cases) AS total_cases_per_location, 
		SUM(total_deaths) AS total_deaths_per_location, 
		ROUND((1.0*SUM(total_deaths)/SUM(total_cases))*100, 2) AS death_percentage_per_location
FROM covid_deaths
GROUP BY 1
ORDER BY 1;

-- Looking at total cases VS population
-- Shows what percentage of population got Covid per day

SELECT location, date, total_cases, population, ROUND((1.0*total_cases/population)*100, 7) AS population_infected
FROM covid_deaths 
ORDER BY 1, 2;

-- Looking at countries with highest infection rate compared to population

SELECT location, population, MAX(total_cases) AS highest_infection_count, MAX((1.0*total_cases/population)*100) AS max_population_infected
FROM covid_deaths 
WHERE total_cases IS NOT NULL
GROUP BY 1, 2
ORDER BY 4 DESC;

-- Showing the countries with the highest death count per population

SELECT location, MAX(total_deaths) AS total_deaths_count
FROM covid_deaths 
WHERE total_deaths IS NOT NULL AND continent IS NOT NULL -- continet = NULL means it is an entire region
GROUP BY 1
ORDER BY 2 DESC;

-- Break by continent
-- There are some issues like not including Canada data in North America

SELECT continent, MAX(total_deaths) AS total_deaths_count
FROM covid_deaths 
WHERE continent IS NOT NULL -- continet = NULL means it is an entire region
GROUP BY 1
ORDER BY 2 DESC;

-- Same query but including all countries data in its region

SELECT location, MAX(total_deaths) AS total_deaths_count
FROM covid_deaths 
WHERE continent IS NULL AND location NOT IN ('High income', 'Upper middle income', 'Lower middle income', 'European Union', 'Low income') -- continet = NULL means it is an entire region
GROUP BY 1
ORDER BY 2 DESC;

-- Global numbers

SELECT date, SUM(new_cases) AS total_global_cases, SUM(new_deaths) AS total_global_deaths, ROUND((1.0*SUM(new_deaths)/NULLIF(SUM(new_cases), 0)*100), 2) AS global_death_percentage
FROM covid_deaths 
GROUP BY 1
ORDER BY 1, 2;

-- Total population vaccinated

WITH PopvsVac (Continent, Location, Date, Population, New_vaccinations, Sum_vaccinated_per_date)
AS(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as sum_vaccinated_per_date
FROM covid_deaths dea
JOIN covid_vaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3
)
SELECT *, (1.0*Sum_vaccinated_per_date/Population)*100 AS percentage_vaccinated_per_date
FROM PopvsVac;

-- Create view to store data

CREATE VIEW percent_population_vaccinated AS
WITH PopvsVac (Continent, Location, Date, Population, New_vaccinations, Sum_vaccinated_per_date)
AS(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(vac.new_vaccinations) OVER (Partition by dea.location ORDER BY dea.location, dea.date) as sum_vaccinated_per_date
FROM covid_deaths dea
JOIN covid_vaccinations vac
ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
--ORDER BY 2, 3
)
SELECT *, (1.0*Sum_vaccinated_per_date/Population)*100 AS percentage_vaccinated_per_date
FROM PopvsVac;