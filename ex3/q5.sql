SELECT DISTINCT A.name
FROM authors A NATURAL JOIN conferences C
WHERE C.area = 'theory' AND A.year < 1980
EXCEPT
SELECT DISTINCT A.name
FROM authors A NATURAL JOIN conferences C
WHERE C.area <> 'theory' OR A.year >= 1980
ORDER BY name ASC;