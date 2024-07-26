USE FilmsDB;

SELECT
    p.id AS ID,
    p.Firstname AS `First name`,
    p.Lastname AS `Last name`,
    SUM(m.Budget) AS `Total movies budget`
FROM Persons p
JOIN Characters c ON p.id = c.actor_id
JOIN Movies m ON c.movie_id = m.id
GROUP BY p.id, p.Firstname, p.Lastname
ORDER BY p.Lastname, p.Firstname;