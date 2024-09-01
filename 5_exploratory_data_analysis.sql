-- What are the max and min total laid offs
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging;

SELECT *
FROM layoffs_staging
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- What are the top 10 companies that have highest layoffs.
SELECT company, SUM(total_laid_off)
FROM layoffs_staging
WHERE total_laid_off IS NOT NULL
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

-- What is the date range of this table. It is 2020 and 2023.
SELECT MIN(date), MAX(date)
FROM layoffs_staging;

-- What are the top 10 industries that have highest layoffs.
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging
GROUP BY industry
ORDER BY 2 DESC
LIMIT 10;

-- What are the top 10 countries that have highest layoffs.
SELECT country, SUM(total_laid_off)
FROM layoffs_staging
GROUP BY country
ORDER BY 2 DESC
LIMIT 10;

-- What are the total layoff numbers based on year?
SELECT EXTRACT(YEAR FROM date) AS year, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging
WHERE date IS NOT NULL
GROUP BY year
ORDER BY year DESC;

-- What stages have the most layoffs
/*
Series A, B, C, D: These refer to different rounds of financing that a company undergoes to support its growth and expansion goals.
Post-IPO: This refers to the period after a company has gone public and its shares are traded on a stock exchange. This phase often involves the company continuing to grow while being accountable to public shareholders.
Acquired: This term means that the company has been purchased by another company. After acquisition, the acquired company usually becomes a part of the acquiring company, either as a subsidiary or integrated into its operations.
*/
SELECT stage, SUm(total_laid_off)
FROM layoffs_staging
GROUP BY stage
ORDER BY 2 DESC;

-- What is th total nukber of layoff? 324.892
WITH rolling_total AS
(
    SELECT TO_CHAR(date, 'YYYY-MM') AS month, SUM(total_laid_off) AS total_off
    FROM layoffs_staging
    WHERE date IS NOT NULL
    GROUP BY month
    ORDER BY month ASC
)
SELECT month, total_off, SUM(total_off) OVER(ORDER BY month) AS rolling_total
FROM rolling_total;

-- What are the top 5 companies that have highest layoffs each year
WITH company_year(company,years,total_laid_off) AS
(
    SELECT company, EXTRACT(YEAR FROM date) AS year, SUM(total_laid_off) AS total_off
    FROM layoffs_staging
    GROUP BY company, year
    ORDER BY 3 DESC
), company_year_rank AS
(
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM company_year
WHERE years IS NOT NULL
)

SELECT *
FROM company_year_rank
WHERE ranking <= 5

-- What are the top 5 companies that have highest layoffs each year
WITH company_year(industry,years,total_laid_off) AS
(
    SELECT industry, EXTRACT(YEAR FROM date) AS year, SUM(total_laid_off) AS total_off
    FROM layoffs_staging
    GROUP BY industry, year
    ORDER BY 3 DESC
), company_year_rank AS
(
SELECT *, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM company_year
WHERE years IS NOT NULL
)

SELECT *
FROM company_year_rank
WHERE ranking <= 5
