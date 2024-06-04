SELECT DISTINCT A.name
FROM authors A NATURAL JOIN conferences C
WHERE C.area = 'theory' AND A.year < 1980
EXCEPT
SELECT DISTINCT A.name
FROM authors A NATURAL JOIN conferences C
WHERE C.area <> 'theory'
ORDER BY name ASC;