-- Viewing the imported tbi datasets
-- View tbi_age
SELECT * FROM tbi_age
LIMIT 5;

-- View tbi_military
SELECT * FROM tbi_military
LIMIT 5;

-- View tbi_year
SELECT * FROM tbi_year
LIMIT 5;

-- tbi_age

-- The Age Groups with the Highest number estimated
SELECT age_group, MAX(number_est) AS highest_number
FROM tbi_age
GROUP BY age_group
ORDER BY highest_number ASC;

-- Frequent Type of measure 
SELECT type, MAX(number_est) AS frequent_type
FROM tbi_age
WHERE number_est NOT LIKE 'NA'
GROUP BY type; 

-- Injury mechanism for age groups
SELECT age_group, injury_mechanism, MAX(number_est) AS est_number
FROM tbi_age
WHERE age_group NOT LIKE 'Total'
GROUP BY age_group, injury_mechanism;


-- tbi_year

-- The year with the highest number of rates
SELECT year, MAX(rate_est) AS highest_injury_rates
FROM tbi_year
GROUP BY year
ORDER BY highest_injury_rates DESC;

-- Common injury mechanism for tbi in both tbi_age and tbi_year datasets
WITH MeanRates AS (
    SELECT ta.injury_mechanism, ROUND(AVG(ta.rate_est), 1) AS mean_rate
    FROM tbi_age ta
    JOIN tbi_year ty ON ta.injury_mechanism = ty.injury_mechanism
    WHERE ta.rate_est NOT LIKE 'NA'
    GROUP BY ta.injury_mechanism
)

SELECT injury_mechanism, mean_rate
FROM MeanRates
ORDER BY mean_rate DESC;

-- Common type of measure for tbi in both tbi_age and tbi_year datasets
WITH MeanRates AS (
    SELECT ta.type, ROUND(AVG(ta.rate_est), 1) AS mean_rate
    FROM tbi_age ta
    JOIN tbi_year ty ON ta.type = ty.type
    WHERE ta.rate_est NOT LIKE 'NA'
    GROUP BY ta.type
)

SELECT type, mean_rate
FROM MeanRates
ORDER BY mean_rate DESC;


-- tbi_military

-- Number of people diagonised in different military branch
SELECT service, MAX(diagnosed) AS diagnosis_rates
FROM tbi_military
GROUP BY service
ORDER BY diagnosis_rates DESC;

-- Components with the highest diagnosis rates
SELECT component, MAX(diagnosed) AS diagnosis_rates
FROM tbi_military
GROUP BY component
ORDER BY diagnosis_rates DESC;

-- Components in different Military Branch Recording the highest people diagosed
SELECT service, component, MAX(diagnosed) AS diagnosis_rates
FROM tbi_military
GROUP BY service, component
ORDER BY diagnosis_rates DESC;

-- Military Branches with the different types of tbi
SELECT service, severity, MAX(diagnosed) AS diagnosis_rates
FROM tbi_military
GROUP BY service, severity
ORDER BY diagnosis_rates DESC;

-- Number of diagnosed with different types of tbi
SELECT  severity, MAX(diagnosed) AS diagnosis_rates
FROM tbi_military
GROUP BY severity
ORDER BY diagnosis_rates DESC;

-- Components with the different types of tbi
SELECT component, severity, MAX(diagnosed) AS diagnosis_rates
FROM tbi_military
GROUP BY component, severity
ORDER BY diagnosis_rates DESC;

-- Year of observation recording the highest severity in the type of tbi
SELECT year, MAX(diagnosed) AS diagnosis_rates
FROM tbi_military
GROUP BY year, severity
ORDER BY diagnosis_rates DESC
LIMIT 5;