-- Wiith TRIM we cleaned the spaces insides some columns.

 UPDATE layoffs_staging
 SET company = TRIM(company);

 -- Checked unique values in industry and found same ones but different names. Corrected(3 values), like Crypto and CryptoCurrency .
SELECT DISTINCT industry
FROM layoffs_staging
ORDER BY 1;

 UPDATE layoffs_staging
 SET industry = 'Crypto'
 WHERE industry LIKE 'Crypto%';

 -- Same proces for country. Found one problem United States
UPDATE layoffs_staging
SET country = 'United States'
WHERE country LIKE 'United States%';

SELECT DISTINCT country
FROM layoffs_staging
ORDER BY 1;

