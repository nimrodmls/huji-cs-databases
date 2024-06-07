WITH youngconferences AS (
    SELECT T.conference
    FROM (
        SELECT DISTINCT A.conference, A.year
        FROM authors A
        GROUP BY A.conference, A.year) AS T
    GROUP BY T.conference
    HAVING COUNT(*) <= 15)
SELECT DISTINCT A.name
FROM authors A
WHERE NOT EXISTS (
    SELECT A1.conference
    FROM authors A1
    WHERE A1.name = A.name
    EXCEPT
    SELECT Y.conference
    FROM youngconferences Y);