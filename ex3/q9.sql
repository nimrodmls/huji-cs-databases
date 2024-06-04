WITH publishcount AS (
    SELECT DISTINCT I.country, I.institution, SUM(A.totalCount) as countryCount
    FROM authors A NATURAL JOIN institutions I
    GROUP BY I.country, I.institution)
SELECT P1.country, P1.institution, P1.countryCount 
FROM publishcount P1
WHERE P1.countryCount = (
    SELECT MAX(P2.countryCount) 
    FROM publishcount P2 
    WHERE P1.country = P2.country)
ORDER BY P1.country, P1.institution ASC;