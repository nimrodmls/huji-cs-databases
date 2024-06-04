SELECT DISTINCT A.name, I.institution
FROM authors A NATURAL JOIN institutions I
WHERE (A.institution = I.institution) AND (I.region = 'africa')
ORDER BY I.institution, A.name ASC;