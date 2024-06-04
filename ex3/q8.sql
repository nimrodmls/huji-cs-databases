SELECT A1.name
FROM authors A1 NATURAL JOIN conferences C1
WHERE C1.subarea = 'ml' AND EXISTS (
    SELECT *
    FROM authors A2 NATURAL JOIN conferences C2
    WHERE (C2.subarea = 'ml') AND (A1.year >= 2020))
GROUP BY A1.name
HAVING COUNT(*) >= 3
ORDER BY A1.name;