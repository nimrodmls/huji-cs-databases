SELECT DISTINCT A1.name
FROM authors A1
WHERE EXISTS (
    SELECT * 
    FROM authors A2 NATURAL JOIN conferences C
    WHERE A1.conference = C.conference AND A1.year = A2.year AND A1.name = 'Omri Abend')
ORDER BY A1.name ASC;