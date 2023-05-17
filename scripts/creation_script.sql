DROP TABLE IF EXISTS covid_deaths;
CREATE TABLE covid_deaths
(
	iso_code VARCHAR(50),
	continent VARCHAR(50),
	country VARCHAR(50),
	case_date DATE,
	population BIGINT,
	total_cases INTEGER,
	new_cases INTEGER,
	new_cases_smoothed FLOAT,
	total_deaths INTEGER,
	new_deaths INTEGER,
	new_deaths_smoothed FLOAT,
	total_cases_per_million FLOAT,
	new_cases_per_million FLOAT,
	new_cases_smoothed_per_million FLOAT,
	total_deaths_per_million FLOAT,
	new_deaths_per_million FLOAT,
	new_deaths_smoothed_per_million FLOAT,
	reproduction_rate FLOAT,
	icu_patients INTEGER,
	icu_patients_per_million FLOAT,
	hosp_patients INTEGER,
	hosp_patients_per_million FLOAT,
	weekly_icu_admissions INTEGER,
	weekly_icu_admissions_per_million FLOAT,
	weekly_hosp_admissions INTEGER,
	weekly_hosp_admissions_per_million FLOAT
);

COPY covid_deaths
FROM '/tmp/covid_deaths.csv' -- change this for the folder where your file is
DELIMITER ','
CSV Header;


DROP TABLE IF EXISTS covid_vaccinations;
CREATE TABLE covid_vaccinations
(
	iso_code VARCHAR(50),
	continent VARCHAR(50),
	country VARCHAR(50),
	case_date DATE,
	new_tests INTEGER,
	total_tests_per_thousand FLOAT,
	new_tests_per_thousand FLOAT,
	new_tests_smoothed INTEGER,
	new_tests_smoothed_per_thousand FLOAT,
	positive_rate FLOAT,
	tests_per_case FLOAT,
	tests_units VARCHAR(50),
	total_vaccinations BIGINT,
	people_vaccinated BIGINT,
	people_fully_vaccinated BIGINT,
	total_boosters BIGINT,
	new_vaccinations INTEGER,
	new_vaccinations_smoothed INTEGER,
	total_vaccinations_per_hundred FLOAT,
	people_vaccinated_per_hundred FLOAT,
	people_fully_vaccinated_per_hundred FLOAT,
	total_boosters_per_hundred FLOAT,
	new_vaccinations_smoothed_per_million INTEGER,
	new_people_vaccinated_smoothed INTEGER,
	new_people_vaccinated_smoothed_per_hundred FLOAT,
	stringency_index FLOAT,
	population_density FLOAT,
	median_age FLOAT,
	aged_65_older FLOAT,
	aged_70_older FLOAT,
	gdp_per_capita FLOAT,
	extreme_poverty FLOAT,
	cardiovasc_death_rate FLOAT,
	diabetes_prevalence FLOAT,
	female_smokers FLOAT,
	male_smokers FLOAT,
	handwashing_facilities FLOAT,
	hospital_beds_per_thousand FLOAT,
	life_expectancy FLOAT,
	human_development_index FLOAT,
	population BIGINT,
	excess_mortality_cumulative_absolute FLOAT,
	excess_mortality_cumulative FLOAT,
	excess_mortality FLOAT,
	excess_mortality_cumulative_per_million FLOAT
);

COPY covid_vaccinations
FROM '/tmp/covid_vaccinations.csv' -- change this for the folder where your file is
DELIMITER ','
CSV Header;

