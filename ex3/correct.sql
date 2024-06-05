WITH PrerequisitePairs AS (
    SELECT P2.cid AS cid1, P1.cid AS cid2
    FROM Prerequisites P1 JOIN Prerequisites P2 ON P1.preid = P2.preid AND P1.cid < P2.cid)
SELECT T.cid1, T.cid2
FROM PrerequisitePairs T
GROUP BY T.cid1, T.cid2
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM Course C NATURAL JOIN Prerequisites P
    WHERE C.cid = T.cid1)
ORDER BY T.cid1, T.cid2 ASC;