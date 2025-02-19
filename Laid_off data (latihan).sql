select *
from layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2 
where percentage_laid_off = 1;

#total karyawan yg di laid off company
select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

SELECT *
FROM layoffs_staging2;

# jumlah karyawan laid off berdasarkan tahun
SELECT YEAR(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y') AS tanggal FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

#industri mana saja yg melakukan laid off
select country, industry, total_laid_off
from layoffs_staging2 
ORDER BY total_laid_off DESC;

SELECT industry, SUM(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

select * from layoffs_staging2;

select company, industry, percentage_laid_off, 'bankruptcy' as label
from layoffs_staging2
where percentage_laid_off > 0.8
union
select company, industry, percentage_laid_off, 'still going' as label
from layoffs_staging2
where percentage_laid_off < 0.8
order by percentage_laid_off desc
