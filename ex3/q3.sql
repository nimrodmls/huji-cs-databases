SELECT DISTINCT I.institution, A.name
FROM authors A NATURAL JOIN institutions I NATURAL JOIN conferences C
WHERE (I.country = 'il') AND (A.totalcount >= 2) AND (C.conference LIKE 'sig%')
ORDER BY A.name, I.institution ASC;