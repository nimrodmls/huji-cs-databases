WITH ProfYearPublish AS (
    SELECT A.name, A.year, SUM(A.totalCount) as totalCount
    FROM authors A NATURAL JOIN conferences C
    WHERE (C.area = 'ai') and A.institution = 'Hebrew University of Jerusalem'
    GROUP BY A.name, A.year),
MaxPublisher AS (
    SELECT * 
    FROM ProfYearPublish P1
    WHERE P1.totalCount = (
        SELECT MAX(P2.totalCount) 
        FROM ProfYearPublish P2 
        WHERE P1.year = P2.year))
SELECT DISTINCT M.year, M.name
FROM MaxPublisher M
WHERE M.year >= 2000 AND M.year <= 2020
ORDER BY M.year, M.name ASC;