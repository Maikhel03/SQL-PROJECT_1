SELECT * FROM WORKERS
 
-- ASSIGMENTS USING WORKERS DATA --
-- What is the average age of the educational status
SELECT AVG(age) AS Average_age, education
FROM WORKERS
GROUP BY education;


-- Group each of the races by count 
SELECT COUNT(race) AS Population, race
FROM WORKERS
GROUP BY race;


-- Is it true that the Black race has the highest capital loss? If not, Find out who does
WITH MIKKY AS(
SELECT race, SUM(capital_loss) AS Total_capital_loss
FROM WORKERS 
GROUP BY race)
SELECT TOP(1)* FROM MIKKY
ORDER BY Total_capital_loss DESC;

--It is not true that the Black race has the highest capital loss. The White race does with a total of 3,444,637.


-- NeoColonialism is known if Blacks works less hours than whites. Show if there is neocolonialism.
SELECT race, SUM(hours_per_week) AS Total_hours_worked
FROM WORKERS
WHERE race ='white' OR race = 'black'
GROUP BY race
ORDER BY Total_hours_worked DESC;

--There is neocolonialism.

-- Show what gender work the most hours amongst the Black 
SELECT TOP(1) gender, race, SUM(hours_per_week) AS Total_hours_worked
FROM WORKERS
WHERE race = 'black'
GROUP BY gender, race
ORDER BY Total_hours_worked DESC;


-- Show what occupation works the most hours among the whites 
SELECT  occupation, race, SUM(hours_per_week) AS Total_hours_worked
FROM WORKERS
WHERE race = 'White'
GROUP BY occupation, race
ORDER BY Total_hours_worked DESC;

--The Exec-manegerial occupation works the most hours.


-- In the US, does the white work more than the Blacks ? Show with a table
WITH LOVE AS(
SELECT race,native_country, SUM(hours_per_week) AS Total_hours_worked
FROM WORKERS
WHERE native_country = 'United-States'
GROUP BY native_country, race)
SELECT * FROM LOVE
WHERE race = 'black' OR race = 'white'
ORDER BY Total_hours_worked DESC;

--Yes, they do.

-- In Japan, does females earn more capital gains than males ?
SELECT
    gender,
    SUM(capital_gain) AS total_capital_gain,
    SUM(capital_loss) AS total_capital_loss,
    SUM(capital_gain) - SUM(capital_loss) AS net_capital_gain_loss,
	native_country
FROM
    WORKERS
WHERE native_country = 'Japan'
GROUP BY
    gender, native_country;
--  NO;

-- The Income is distributed as Above 50k = 1, and BELOW 50k = 0. Find out what country has most of its female citizen earning above 50k
SELECT native_country, income_50K, COUNT(gender) AS Females
FROM WORKERS
WHERE gender = 'female' AND income_50K = 1
GROUP BY native_country, income_50K, gender
ORDER BY Females DESC;

SELECT native_country, COUNT(gender) AS Females_per_country, income_50K
FROM WORKERS
WHERE gender = 'Female' AND income_50K = 1
GROUP BY native_country, income_50K
ORDER BY Females_per_country DESC;


-- In the US, what marital_status type earns the most capital gain ?
WITH SWISH AS(
    SELECT native_country, marital_status, SUM(capital_gain) AS Total_capital_gain
	FROM WORKERS
	WHERE native_country = 'United-States'
	GROUP BY marital_status, native_country
	)
SELECT TOP(1)* FROM SWISH
ORDER BY Total_capital_gain DESC;


-- In Japan, what Occupation type earns the most capital gain ?
WITH NOTION AS(
   SELECT native_country, occupation, SUM(capital_gain) AS Total_capital_gain
   FROM WORKERS
   WHERE native_country = 'Japan'
   GROUP BY occupation, native_country
   )
   SELECT TOP(1)* FROM NOTION
   ORDER BY Total_capital_gain DESC;