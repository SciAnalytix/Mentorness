SELECT * FROM covid19.`corona virus dataset`;
SELECT * FROM `corona virus dataset` where
'Province' IS NULL
or 'Country/Region' IS NULL
or  'Latitude' IS NULL
or 'Longitude' IS NULL
or  'Dates' IS NULL
or 'Confirmed' IS NULL
or 'Deaths' IS NULL
or 'Recovered' IS NULL;
SELECT COUNT(*) AS total_records
FROM `corona virus dataset`;
SELECT 
    MIN(date) AS start_date,
    MAX(date) AS end_date
FROM 
    covid19.`corona virus dataset`;
SELECT COUNT(DISTINCT DATE_FORMAT(date, '%Y-%m')) AS number_of_months
FROM covid19.`corona virus dataset`;
SELECT 
    DATE_FORMAT(`Date`, '%Y-%m') AS month,
    AVG(`Confirmed`) AS avg_confirmed,
    AVG(`Deaths`) AS avg_deaths,
    AVG(`Recovered`) AS avg_recovered
FROM `corona virus dataset`
GROUP BY month
ORDER BY month;
WITH frequent_values AS (
    SELECT 
        DATE_FORMAT(`Date`, '%Y-%m') AS month,
        `Confirmed`, `Deaths`, `Recovered`,
        ROW_NUMBER() OVER (PARTITION BY DATE_FORMAT(`Date`, '%Y-%m') ORDER BY COUNT(*) DESC) AS rn
    FROM `corona virus dataset`
    GROUP BY month, `Confirmed`, `Deaths`, `Recovered`
)
SELECT 
    month,
    `Confirmed` AS most_frequent_confirmed,
    `Deaths` AS most_frequent_deaths,
    `Recovered` AS most_frequent_recovered
FROM frequent_values
WHERE rn = 1
ORDER BY month;
SELECT 
    YEAR(`Date`) AS year,
    MIN(`Confirmed`) AS min_confirmed,
    MIN(`Deaths`) AS min_deaths,
    MIN(`Recovered`) AS min_recovered
FROM `corona virus dataset`
GROUP BY year
ORDER BY year;
SELECT 
    YEAR(`Date`) AS year,
    MAX(`Confirmed`) AS max_confirmed,
    MAX(`Deaths`) AS max_deaths,
    MAX(`Recovered`) AS max_recovered
FROM `corona virus dataset`
GROUP BY year
ORDER BY year;
SELECT 
    DATE_FORMAT(`Date`, '%Y-%m') AS month,
    SUM(`Confirmed`) AS total_confirmed,
    SUM(`Deaths`) AS total_deaths,
    SUM(`Recovered`) AS total_recovered
FROM `corona virus dataset`
GROUP BY month
ORDER BY month;
SELECT 
    SUM(`Confirmed`) AS total_confirmed,
    AVG(`Confirmed`) AS avg_confirmed,
    VARIANCE(`Confirmed`) AS var_confirmed,
    STDDEV(`Confirmed`) AS stddev_confirmed
FROM `corona virus dataset`;
SELECT 
    DATE_FORMAT(`Date`, '%Y-%m') AS month,
    SUM(`Deaths`) AS total_deaths,
    AVG(`Deaths`) AS avg_deaths,
    VARIANCE(`Deaths`) AS var_deaths,
    STDDEV(`Deaths`) AS stddev_deaths
FROM `corona virus dataset`
GROUP BY month
ORDER BY month;
SELECT 
    SUM(`Recovered`) AS total_recovered,
    AVG(`Recovered`) AS avg_recovered,
    VARIANCE(`Recovered`) AS var_recovered,
    STDDEV(`Recovered`) AS stddev_recovered
FROM `corona virus dataset`;
SELECT 
    `Country/Region`,
    SUM(`Confirmed`) AS total_confirmed
FROM `corona virus dataset`
GROUP BY `Country/Region`
ORDER BY total_confirmed DESC
LIMIT 1;
SELECT 
    `Country/Region`,
    SUM(`Deaths`) AS total_deaths
FROM `corona virus dataset`
GROUP BY `Country/Region`
ORDER BY total_deaths ASC
LIMIT 1;
SELECT 
    `Country/Region`,
    SUM(`Recovered`) AS total_recovered
FROM `corona virus dataset`
GROUP BY `Country/Region`
ORDER BY total_recovered DESC
LIMIT 5;

