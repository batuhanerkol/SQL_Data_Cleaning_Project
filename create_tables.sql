CREATE TABLE public.layoffs_data(
    company TEXT,
    location TEXT,
    industry TEXT,
    total_laid_off NUMERIC,
    percentage_laid_off NUMERIC,
    date DATE,
    stage TEXT,
    country TEXT,
    funds_raised_millions NUMERIC 
);

ALTER TABLE public.layoffs_data OWNER to postgres;

COPY layoffs_data
FROM '/Users/batuhanerkol/Desktop/SQL_Projects/SQL_layoffs_project_data/layoffs_data.csv'
DELIMITER ',' CSV HEADER;

/*
For postgres error
\copy layoffs_data FROM '/Users/batuhanerkol/Desktop/SQL_Projects/SQL_layoffs_project_data/layoffs_data.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
*/
