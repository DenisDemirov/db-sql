USE FilmsDB;

SELECT
    m.id AS ID,
    m.Title AS Title,
    m.Release_date AS `Release date`,
    m.Duration AS Duration,
    m.Description AS Description,
    JSON_OBJECT(
        'Filename', f.Filename,
        'MIME_type', f.MIME_type,
        'KeyId', f.KeyId,
        'URL', f.URL
    ) AS Poster,
    JSON_OBJECT(
        'ID', p.id,
        'First name', p.Firstname,
        'Last name', p.Lastname
    ) AS Director
FROM Movies m
JOIN Persons p ON m.director_id = p.id
JOIN Files f ON m.poster_id = f.id
JOIN MovieGenres mg ON m.id = mg.movie_id
JOIN Genres g ON mg.genre_id = g.id
WHERE
    m.Release_date >= '2022-01-01'
    AND m.Duration > 135  
    AND g.name IN ('Action', 'Drama');