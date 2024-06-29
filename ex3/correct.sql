SELECT
    c1.cid AS cid1,
    c2.cid AS cid2
FROM
    (SELECT cid, STRING_AGG(preid, ',' ORDER BY preid ASC) AS PrereqList
     FROM Prerequisites
     GROUP BY cid) AS c1
JOIN
    (SELECT cid, STRING_AGG(preid, ',' ORDER BY preid ASC) AS PrereqList
     FROM Prerequisites
     GROUP BY cid) AS c2
ON c1.PrereqList = c2.PrereqList AND c1.cid < c2.cid
UNION
SELECT c1.cid AS cid1, 
       c2.cid AS cid2 
FROM 
    (SELECT C.cid
     FROM Course C 
     WHERE C.cid NOT IN (SELECT DISTINCT P.cid FROM Prerequisites P)) AS c1
JOIN
    (SELECT C.cid
     FROM Course C 
     WHERE C.cid NOT IN (SELECT DISTINCT P.cid FROM Prerequisites P)) AS c2
ON c1.cid < c2.cid
ORDER BY cid1, cid2;