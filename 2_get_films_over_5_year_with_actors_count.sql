USE FilmsDB;

SELECT
    m.id AS ID,
    m.Title AS Title,
    COUNT(DISTINCT c.actor_id) AS `Actors count`
FROM Movies m
JOIN Characters c ON m.id = c.movie_id
WHERE m.Release_date >= DATE_SUB(CURDATE(), INTERVAL 5 YEAR)
GROUP BY m.id, m.Title
ORDER BY m.Release_date DESC;