SELECT A.name, A.year
FROM authors A NATURAL JOIN conferences C1
WHERE C1.subarea = 'ai'
INTERSECT
SELECT A.name, A.year
FROM authors A NATURAL JOIN conferences C2
WHERE (C2.subarea = 'economics') AND (A.institution = 'Hebrew University of Jerusalem')
ORDER BY A.name, A.year ASC;