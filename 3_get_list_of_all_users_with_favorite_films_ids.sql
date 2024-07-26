USE FilmsDB;

SELECT
    u.id AS ID,
    u.Username,
    JSON_ARRAYAGG(f.movie_id) AS `Favorite movie IDs`
FROM Users u
LEFT JOIN FavoriteMovies f ON u.id = f.user_id
GROUP BY u.id, u.Username;