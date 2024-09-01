-- Check for blank or null values for indusrty.(4 null or blank values)
SELECT *
FROM layoffs_staging
WHERE industry IS NULL OR
    industry = '';

--Check for are there any other values that we can reach industry information
SELECT t1.company, t1.industry, t2.industry
FROM layoffs_staging AS t1
JOIN layoffs_staging AS t2 ON
    t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '') AND
    t2.industry IS NOT NULL

-- Correct null values
UPDATE layoffs_staging
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_staging AS t1
SET industry = t2.industry
FROM layoffs_staging AS t2
WHERE t1.company = t2.company
  AND t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- Delete null values which are numeric. 1147 row deleted. We have 1193 unique and non null values.
DELETE 
FROM layoffs_staging
WHERE total_laid_off IS NULL
OR percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging