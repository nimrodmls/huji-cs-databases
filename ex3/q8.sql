SELECT DISTINCT A1.name
FROM authors A1 NATURAL JOIN conferences C1
WHERE C1.subarea = 'ml'
GROUP BY A1.name
HAVING COUNT(DISTINCT C1.conference) >= 3
INTERSECT
SELECT A1.name
FROM authors A1 NATURAL JOIN conferences C1
WHERE C1.subarea = 'ml' AND A1.year >= 2020
ORDER BY name;