SELECT DISTINCT A.name
FROM authors A
WHERE NOT EXISTS (
    SELECT DISTINCT A1.year, A1.conference
    FROM authors A1
    WHERE A1.name = 'Omri Abend'
    EXCEPT
    SELECT DISTINCT A2.year, A2.conference
    FROM authors A2
    WHERE A2.name = A.name)
ORDER BY A.name ASC;