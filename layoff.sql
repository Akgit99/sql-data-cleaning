--DATA CLEANING

USE layoffs;
SELECT DATABASE();

--Creating a new table to work with instead of working on raw data which is in layoffs table
CREATE TABLE layoffs_working 
LIKE layoffs;

INSERT INTO layoffs_working
SELECT * FROM layoffs;

SELECT * FROM layoffs_working;

--Grouping based off of all columns to find duplicates
SELECT *,
ROW_NUMBER() OVER (PARTITION BY `Company`, `Location_HQ`, `Region`, `USState`, `Country`, `Continent`, `Laid_Off`, `Date_layoffs`, `Percentage`, `Company_Size_before_Layoffs`, `Company_Size_after_layoffs`, `Industry`, `Stage`, `Money_Raised_in_mil`, `YEAR`) AS row_num
FROM layoffs_working;

WITH duplicate_CTE AS (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY `Company`, `Location_HQ`, `Region`, `USState`, `Country`, `Continent`, `Laid_Off`, `Date_layoffs`, `Percentage`, `Company_Size_before_Layoffs`, `Company_Size_after_layoffs`, `Industry`, `Stage`, `Money_Raised_in_mil`, `YEAR`) AS row_num
    FROM layoffs_working
)
SELECT * 
FROM duplicate_CTE
WHERE row_num > 1;

SELECT *
FROM layoffs_working
WHERE Company = 'C2FO';

--creating new table with row_num column to delete duplicates
CREATE TABLE layoffs_working_row_num AS
SELECT *,
    ROW_NUMBER() OVER (
        PARTITION BY `Company`, `Location_HQ`, `Region`, `USState`, `Country`, `Continent`, 
                     `Laid_Off`, `Date_layoffs`, `Percentage`, `Company_Size_before_Layoffs`, 
                     `Company_Size_after_layoffs`, `Industry`, `Stage`, `Money_Raised_in_mil`, `YEAR`
    ) AS row_num
FROM layoffs_working;

SELECT * FROM layoffs_working_row_num
WHERE row_num > 1

--Deleting the duplicates
DELETE FROM layoffs_working_row_num
WHERE row_num > 1;

SELECT DISTINCT Industry
From layoffs_working_row_num
ORDER BY 1;

SELECT *
FROM layoffs_working_row_num
WHERE Industry LIKE 'Transpo%';

UPDATE layoffs_working_row_num
SET Industry = 'Transportation'
WHERE Industry LIKE 'Transpo%';

--it has beijing and bejing
SELECT DISTINCT Location_HQ
FROM layoffs_working_row_num
ORDER BY 1;

SELECT *
FROM layoffs_working_row_num
WHERE Location_HQ LIKE 'Bej%';

UPDATE layoffs_working_row_num
SET Location_HQ = 'Beijing'
WHERE Location_HQ LIKE 'Bej%';

--for country
SELECT DISTINCT Country
FROM layoffs_working_row_num ORDER BY 1;

--for Laid_Off and Percentage
Select *
From layoffs_working_row_num
WHERE `Laid_Off` IS NULL AND `Percentage` IS NULL;

--both are null and not needed so delete them
DELETE FROM layoffs_working_row_num
WHERE `Laid_Off` IS NULL AND `Percentage` IS NULL;

ALTER TABLE layoffs_working_row_num
DROP COLUMN row_num;

SELECT * FROM layoffs_working_row_num
ORDER BY Nr;
