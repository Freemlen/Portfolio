--								Exploration of data on the consumption of renewable resources 

-- 1. Find datasets about renewable energy and prices of fossil fuel
-- 2. Import excel files to SQL Server

SELECT * FROM dbo.renewable_energy

-- We display only countries

SELECT * FROM dbo.renewable_energy
WHERE NOT(entity IS NULL OR code IS NULL OR entity LIKE 'World')

-- 3. Looking at renewables energy by country in average

SELECT entity AS country, AVG([Renewables (% sub energy)]) AS AverageRenewable
FROM renewable_energy
WHERE NOT(entity IS NULL OR code IS NULL OR entity LIKE 'World')
GROUP BY entity
ORDER BY AverageRenewable DESC

-- 4. Looking at renewables energy by years all over the world in average

SELECT year, SUM([Renewables (% sub energy)])/COUNT(entity) AS Renewables
FROM renewable_energy
WHERE NOT(entity IS NULL OR code IS NULL OR entity LIKE 'World')
GROUP BY year
ORDER BY year

--5. Looking at renewables energy by kind of generation and years

SELECT year, ROUND(SUM([Wind Generation - TWh]),2) Wind, ROUND(SUM([Solar Generation - TWh]),2) Solar, ROUND(SUM([Geo Biomass Other - TWh]),2) Geo, ROUND(SUM([Hydro Generation - TWh]),2) Hydro
FROM renewable_energy
WHERE NOT(entity IS NULL OR code IS NULL OR entity LIKE 'World')
GROUP BY year
ORDER BY year



