# ETL + Visualization Project: COVID Data

## Introduction
This project is based on the content creator "Alex The Analyst's" project and aims to demonstrate knowledge and skills in performing the ETL process and subsequent visualization of a COVID dataset. The project videos from which it was derived are available at the following links: [Video 1](https://www.youtube.com/watch?v=qfyynHBFOsM), [Video 2](https://www.youtube.com/watch?v=qfyynHBFOsM), and [Video 3](https://www.youtube.com/watch?v=8rO7ztF4NtU).

This project consists of two parts:
1. ETL + Visualization of global COVID data.
2. ETL of COVID data in Spain.

Part 2 is a personal extension of the project proposed by Alex The Analyst and will be continuously updated by adding new information tables and visualizations.

## ETL
### 1. Data Acquisition
The main dataset was obtained from the website [Our World in Data](https://ourworldindata.org/coronavirus) and can be found in the "datasets" directory of this repository. However, this is not the dataset we will be working with directly. From this dataset, we obtained two smaller and specific datasets: one related to COVID deaths and the other related to vaccinations. 

These three datasets are provided in CSV format, and any necessary manipulations (such as inserting and deleting columns) have been performed in Excel due to their simplicity.

### 2. Data Loading into the Database
Next, we need to load the two obtained datasets into our database as tables.

For the simplicity and size of the database, we opted for a local database. It is implemented using PostgreSQL with PgAdmin4 as the management tool within a Linux environment. Although not the focus of this project, you can find information on installing PostgreSQL in our environment at [postgresql.org](https://www.postgresql.org/), and help on installing, configuring, and using PgAdmin can be obtained at [pgadmin.org/faq](https://www.pgadmin.org/faq/#1).

The script for creating the database and tables can be found in the "scripts" directory.

Once the tables are loaded into the database (using the COPY method to import CSVs into PostgreSQL databases), we can perform any desired queries using the "Query tool" in pgAdmin.

In the first part of the project, four queries are performed to visualize:
1. Global numbers: total cases, total deaths, and death percentage.
2. Total deaths by continent.
3. Percentage of infected population in a subset of countries.
4. Percentage of infected population by country.

The last two visualizations are obtained from the same query. These queries can also be stored as VIEWS to have them stored in the database for future reference. However, in this case, we are copying the query results to an Excel file (.xlsx) to load them into Tableau Public. Tableau Public does not support direct data loading from a database, so we need to export the results separately. Each query result should be stored in a separate .xlsx file. These files can be found in the "Tableau Files" directory.

In the second part of the project, we will obtain visualizations in Tableau Public, the free version of Tableau. Although more limited than the full version, it is sufficient for our purposes. The obtained charts can be viewed on the public dashboard at [CovidDashboardv1](https://public.tableau.com/views/CovidDashboardv1_16838267650260/Dashboard1?:language=es-ES&:display_count=n&:origin=viz_share_link).

## Extension: Spain Data
In the extension I have made to this project, I have decided to gather more interesting and in-depth data specifically for Spain. Currently, the Tableau dashboards are not available, but I have obtained a series of more complex and interesting queries compared to the previous global data.

These queries can be found in the "spain_queries.sql" file in the "scripts" directory and provide data such as:
- Evolution of reproduction rate versus vaccination numbers.
- Number of patients in ICU or hospitalized compared to the number of vaccinations by month.
- New cases and reproduction rate compared to tests performed.
- Stringency index evolution as people get vaccinated and the number of new cases over time.

More queries will be added in the future.

These data have been cleaned and transformed using SQL. However, there are significant periods in which we do not have data. In such cases, decisions must be made regarding the analysis.

## Credits and Links
- Alex The Analyst's Data Portfolio Projects Playlist: [YouTube Playlist](https://www.youtube.com/playlist?list=PLUaB-1hjhk8H48Pj32z4GZgGWyylqv85f)
- Alex The Analyst's Data Portfolio Projects GitHub Repository: [GitHub Repository](https://github.com/AlexTheAnalyst/PortfolioProjects)
- Our World in Data COVID Data: [Our World in Data](https://ourworldindata.org/coronavirus)

## Contact
Feel free to reach out to me for any questions, suggestions, or offers via my Gmail account: ajsr922@gmail.com or through my LinkedIn profile: [LinkedIn](https://www.linkedin.com/in/antonio-jes%C3%BAs-salido-ranea-90831a177/).

Thank you for following this project, and I hope it proves helpful!
