BULK INSERT AMS.Airport
FROM 'F:\DMDD\AMS project\Batch load\load.csv'
WITH 
(
FIRSTROW = 2
)
;