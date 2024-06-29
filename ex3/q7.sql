SELECT DISTINCT I.country, count(*) as institutionCount
FROM institutions I
GROUP BY I.country
ORDER BY I.country ASC;