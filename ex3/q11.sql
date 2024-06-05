WITH youngconferences AS (
    SELECT T.conference
    FROM (
        SELECT DISTINCT A.conference, A.year
        FROM authors A
        GROUP BY A.conference, A.year
    ) AS T
    GROUP BY T.conference
    HAVING COUNT(*) <= 15)
SELECT DISTINCT A.name
FROM authors A
WHERE A.conference IN (
    SELECT Y.conference
    FROM youngconferences Y);