select date, location, population, total_cases, total_deaths, new_cases
from PortofolioProject..datakorbancovid
order by 1,2

-- mencari presentase kematian perkasus
select coviddate, location, population, total_cases, total_deaths, (total_deaths/total_cases)*100 as presentase_kematian
from PortofolioProject..datakorbancovid
where location like 'indo%'
order by 1,2

-- mencari presentase kasus
select date, location, population, total_cases, total_deaths, (total_cases/population)*100 as presentase_kasus
from PortofolioProject..datakorbancovid
where location like 'indo%'
order by 1,2

--
select location, max(total_deaths) as jumlahtotaldeaths
from PortofolioProject..datakorbancovid
where continent is null
group by location
order by jumlahtotaldeaths desc

select *
from PortofolioProject..datakorbancovid
where location like 'low%'

-- join tabel
--liat total kasus dan vaksinasi
select kor.continent, kor.location, kor.date, kor.population, kas.total_vaccinations, kor.total_deaths
from PortofolioProject..datakorbancovid kor
join PortofolioProject..datakasuscovid kas
	on kor.location = kas.location
	and kor.date = kas.date
where kor.continent is not null
order by 1,2,3

-- mencari total vaksinasi dengan CTE
WITH vaksinasi (continent, location, date, population, new_vaccinations, jumlahorangvaksinasi) AS (
    SELECT 
        kor.continent, 
        kor.location, 
        kor.date, 
        kor.population, 
        kas.new_vaccinations,
        SUM(CAST(REPLACE(kas.new_vaccinations, ',', '.') AS FLOAT)) OVER (
            PARTITION BY kor.location 
            ORDER BY kor.location, kor.date
        ) AS jumlahorangvaksinasi
    FROM 
        PortofolioProject..datakorbancovid kor
    JOIN 
        PortofolioProject..datakasuscovid kas
        ON kor.location = kas.location
        AND kor.date = kas.date
    WHERE 
        kor.continent IS NOT NULL
)
SELECT 
    *, 
    (jumlahorangvaksinasi/population)*100 AS vaccination_percentage
FROM 
    vaksinasi;


-- bikin presentasse populasi yg di vaksin
DROP TABLE IF EXISTS #presentasevaksinasi;
CREATE TABLE #presentasevaksinasi (
    continent NVARCHAR(255),
    location NVARCHAR(255),
    date DATETIME,
    population NUMERIC,
    new_vaccinations NUMERIC,
    jumlahorangvaksinasi NUMERIC
)

INSERT INTO #presentasevaksinasi
SELECT 
    kor.continent, 
    kor.location, 
    kor.date, 
    kor.population, 
    TRY_CAST(REPLACE(kas.new_vaccinations, ',', '.') AS FLOAT) AS new_vaccinations,
    SUM(TRY_CAST(REPLACE(kas.new_vaccinations, ',', '.') AS FLOAT)) OVER (
        PARTITION BY kor.location 
        ORDER BY kor.location, kor.date
    ) AS jumlahorangvaksinasi
FROM 
    PortofolioProject..datakorbancovid kor
JOIN 
    PortofolioProject..datakasuscovid kas
    ON kor.location = kas.location
    AND kor.date = kas.date
WHERE 
    kor.continent IS NOT NULL;

SELECT 
    *, 
    (jumlahorangvaksinasi / population) * 100 AS vaccination_percentage
FROM 
    #presentasevaksinasi;

-- membuat data visualisasi
drop view if exists presentasevaksinasi
CREATE VIEW presentasevaksinasi AS
SELECT 
    kor.continent, 
    kor.location, 
    kor.date, 
    kor.population, 
    TRY_CAST(REPLACE(kas.new_vaccinations, ',', '.') AS FLOAT) AS new_vaccinations,
    SUM(TRY_CAST(REPLACE(kas.new_vaccinations, ',', '.') AS FLOAT)) OVER (
        PARTITION BY kor.location 
        ORDER BY kor.location, kor.date
    ) AS jumlahorangvaksinasi
FROM 
    PortofolioProject..datakorbancovid kor
JOIN 
    PortofolioProject..datakasuscovid kas
    ON kor.location = kas.location
    AND kor.date = kas.date
WHERE 
    kor.continent IS NOT NULL;


SELECT *
FROM PortofolioProject..datakorbancovid
where icu_patients > 0

--ngapus kolom yg g penting
alter table PortofolioProject..datakorbancovid
drop column weekly_icu_admissions_per_million, weekly_icu_admissions, weekly_hosp_admissions, 
weekly_hosp_admissions_per_million;

alter table PortofolioProject..datakorbancovid
drop column reproduction_rate;

UPDATE PortofolioProject..datakorbancovid
SET hosp_patients_per_million = ISNULL(hosp_patients_per_million, 0);

-- mengubah format tanggal
SELECT date, CONVERT(date, date) AS coviddate
from PortofolioProject..datakorbancovid;

UPDATE PortofolioProject..datakorbancovid
SET date = CONVERT(date, date);

ALTER TABLE PortofolioProject..datakorbancovid
ADD coviddate date;

UPDATE PortofolioProject..datakorbancovid
SET coviddate = CONVERT(date, date);

SELECT *
FROM PortofolioProject..datakorbancovid

--menghapus kolom date
alter table PortofolioProject..datakorbancovid
drop column date
