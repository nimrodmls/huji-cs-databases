WITH mindurations AS (
    SELECT year, min(duration) as duration
    FROM movies m1
    WHERE duration IS NOT NULL
    GROUP BY year
)
SELECT DISTINCT m1.movieId, m1.title, m1.duration
FROM movies m1 NATURAL JOIN mindurations md
ORDER BY m1.movieId, m1.title, m1.duration;