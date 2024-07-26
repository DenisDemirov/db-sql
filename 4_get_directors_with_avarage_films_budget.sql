USE FilmsDB;

SELECT
    p.id AS `Director ID`,
    CONCAT(p.Firstname, ' ', p.Lastname) AS `Director name`,
    AVG(m.Budget) AS `Average budget`
FROM Persons p
JOIN Movies m ON p.id = m.director_id
GROUP BY p.id, `Director name`
ORDER BY `Director name`;