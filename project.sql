-- There are 2361 values with 21 duplicates.
-- We ranked duplicate values as 2,3 etc.
WITH duplicate_cte AS
(
    SELECT*,
    ROW_NUMBER() OVER(
        PARTITION BY company, location, industry, total_laid_off, 
        percentage_laid_off, 'date', stage, country, funds_raised_millions) AS row_num
    FROM layoffs_data
)
SELECT*
FROM duplicate_cte
WHERE row_num > 1;

-- Created new table row_num.
CREATE TABLE layoffs_staging(
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off NUMERIC,
    percentage_laid_off NUMERIC,
    date DATE,
    stage TEXT,
    country TEXT,
    funds_raised_millions NUMERIC,
    row_num INT
);
-- Inserted all data to new table.
INSERT INTO layoffs_staging
SELECT*,
ROW_NUMBER() OVER(
        PARTITION BY company, location, industry, total_laid_off, 
        percentage_laid_off, 'date', stage, country, funds_raised_millions) AS row_num
    FROM layoffs_data

-- Deleted all duplicated values 
DELETE
FROM layoffs_staging
WHERE row_num > 1;

-- Remove the row_num column
ALTER TABLE layoffs_staging
DROP COLUMN row_num;

--we have 2340 unique values
SELECT*
FROM layoffs_staging