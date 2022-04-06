SELECT * FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 3, 4


--SELECT * FROM PortfolioProject..CovidVaccinations
--ORDER BY 3, 4


SELECT location, date, total_cases, new_cases, total_deaths, population 
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
ORDER BY 1, 2


--Looking at Total Cases vs Total Deaths
--Shows likelihood of dying if you contract covid in your country
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%Russia%'
AND continent is not null
ORDER BY 1, 2


--Looking at Total Cases vs Population
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
WHERE location LIKE '%Russia%'
AND continent is not null
ORDER BY 1, 2


--Looking at Total Cases vs Population
--Shows what percentage of population got Covid

SELECT location, date, Population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
--WHERE location LIKE '%Russia%'
ORDER BY 1, 2


--Looking at Countries with Highest Infection Rate compared to Population

SELECT location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 AS PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%Russia%'
WHERE continent is not null
GROUP BY location, Population
ORDER BY PercentPopulationInfected DESC


--Showing Countries with Highest Death Count per Population

SELECT location, MAX(cast(total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%Russia%'
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC


--Let's break things down by continent





--Showing continents with the highest death count per population

SELECT continent, MAX(cast(total_deaths AS int)) AS TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%Russia%'
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC




--Global numbers

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 AS DeathPercentage
FROM PortfolioProject..CovidDeaths
--WHERE location LIKE '%Russia%'
WHERE continent is not null
--GROUP BY date
ORDER BY 1, 2


--Looking at Total Population vs Vaccinations

--USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccination, RollingPeopleVaccinated)
As 
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 2, 3
)
Select *, (RollingPeopleVaccinated/Population)*100
FROM PopvsVac





--Temp Table

DROP TABLE if exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)


INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
--WHERE dea.continent is not null
--ORDER BY 2, 3


Select *, (RollingPeopleVaccinated/Population)*100
FROM #PercentPopulationVaccinated



--Creating view to store data for later visualizations
DROP View PercentPopulationVaccinated
Create View PercentPopulationVaccinated as 
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, dea.Date) AS RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 2, 3

SELECT * FROM PercentPopulationVaccinated

