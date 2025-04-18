--Exploratory Data analysis

SELECT * FROM layoffs_working_row_num;

--max layoff and max percentage lay offs
SELECT MAX(Laid_Off), MAX(`Percentage`)
FROM layoffs_working_row_num;

--most money raised
SELECT *
FROM layoffs_working_row_num 
WHERE `Percentage` = 100
ORDER BY `Money_Raised_in_mil` DESC;

--date range from first to last date of layoffs
SELECT MIN(Date_layoffs), MAX(Date_layoffs)
FROM layoffs_working_row_num;

--total lay offs by company
SELECT Company, SUM(`Laid_Off`)
FROM layoffs_working_row_num
GROUP BY Company ORDER BY 2 DESC;

--most layoffs by industry
SELECT Industry, SUM(`Laid_Off`)
FROM layoffs_working_row_num
GROUP BY Industry ORDER BY 2 DESC;

--most layoffs by country
SELECT Country, SUM(`Laid_Off`)
FROM layoffs_working_row_num
GROUP BY Country ORDER BY 2 DESC;

SELECT `Year`, SUM(`Laid_Off`)
FROM layoffs_working_row_num
GROUP BY `Year` ORDER BY 2 DESC;

--layoffs each month every year
SELECT SUBSTRING(Date_layoffs, 1, 7) AS `MONTH`, SUM(`Laid_Off`)
FROM layoffs_working_row_num
GROUP BY `MONTH`
ORDER BY 1;

SELECT `Company`, `Year`, SUM(`Laid_Off`)
FROM layoffs_working_row_num
GROUP BY `Company`, `Year` ORDER BY 3 DESC;

WITH Company_Year AS (
    SELECT `Company`, `Year`, SUM(`Laid_Off`) AS Total_Layoffs
    FROM layoffs_working_row_num
    GROUP BY `Company`, `Year`
)
SELECT *, DENSE_RANK() OVER (PARTITION BY `YEAR` ORDER BY Total_Layoffs DESC) AS Ranking
FROM `Company_Year`;

WITH Company_Year AS (
    SELECT `Company`, `Year`, SUM(`Laid_Off`) AS Total_Layoffs
    FROM layoffs_working_row_num
    GROUP BY `Company`, `Year`
), Company_year_t5 AS (
SELECT *, DENSE_RANK() OVER (PARTITION BY `YEAR` ORDER BY Total_Layoffs DESC) AS Ranking
FROM `Company_Year`)
SELECT * FROM `Company_year_t5`WHERE Ranking <= 5;