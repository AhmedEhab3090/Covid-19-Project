CREATE VIEW Covid AS
SELECT dth.iso_code, dth.continent, dth.location, dth.date, dth.population, 
	   dth.new_cases,
	   dth.total_cases,
	   CAST(dth.new_deaths as int) AS new_deaths,
	   CAST(dth.total_deaths as int) AS total_deaths,
	   CAST(vac.new_vaccinations as int) AS New_vaccinations,
	   CAST(vac.total_vaccinations as int) AS total_vaccinations
FROM PortfolioProject..CovidDeaths dth
FULL JOIN PortfolioProject..CovidVaccinations vac
	ON dth.iso_code = vac.iso_code
	AND dth.date = vac.date
	AND dth.location = vac.location
	AND dth.continent = vac.continent
WHERE dth.continent IS NOT NULL

--------------------------------------------------------------------------------------
CREATE VIEW CovidContinent2 AS
SELECT continent, SUM(DISTINCT(POPULATION)) AS ContinentPopulation,
MAX(total_cases) AS ContinentTotalCases, MAX(total_deaths) AS ContinentTotalDeaths,
MAX(total_vaccinations) AS ContinentTotalVaccinations
FROM PortfolioProject..Covid
GROUP BY continent,location
-------------------------------------------------
CREATE VIEW Covid_Continent AS
SELECT Continent, SUM(ContinentPopulation) AS ContinentPopulation,
       SUM(ContinentTotalCases) AS ContinentTotalCases,
       SUM(ContinentTotalDeaths) AS ContinentTotalDeaths,
	   SUM(ContinentTotalVaccinations) AS ContinentTotalVaccinations
FROM CovidContinent2
GROUP BY continent

SELECT *
FROM Covid_Continent
