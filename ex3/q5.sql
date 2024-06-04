SELECT DISTINCT A.name
FROM authors A NATURAL JOIN conferences C
WHERE C.area = 'theory'
EXCEPT
SELECT DISTINCT A.name
FROM authors A NATURAL JOIN conferences C
WHERE C.area <> 'theory'
ORDER BY name ASC;