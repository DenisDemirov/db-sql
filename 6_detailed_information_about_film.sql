USE FilmsDB;

SELECT 
    m.id AS ID,
    m.Title,
    m.Release_date,
    m.Duration,
    m.Description,
    
    JSON_OBJECT(
        'id', p.id,
        'Filename', p.Filename,
        'MIME_type', p.MIME_type,
        'KeyId', p.KeyId,
        'URL', p.URL
    ) AS Poster,
    
    JSON_OBJECT(
        'ID', d.id,
        'Firstname', d.Firstname,
        'Lastname', d.Lastname,
        'Photo', JSON_OBJECT(
            'id', dp.id,
            'Filename', dp.Filename,
            'MIME_type', dp.MIME_type,
            'KeyId', dp.KeyId,
            'URL', dp.URL
        )
    ) AS Director,
    
    (
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'ID', a.id,
                'Firstname', a.Firstname,
                'Lastname', a.Lastname,
                'Photo', JSON_OBJECT(
                    'id', ap.id,
                    'Filename', ap.Filename,
                    'MIME_type', ap.MIME_type,
                    'KeyId', ap.KeyId,
                    'URL', ap.URL
                )
            )
        )
        FROM Persons a
        LEFT JOIN Characters c ON a.id = c.actor_id
        LEFT JOIN Files ap ON a.photo_id = ap.id
        WHERE c.movie_id = m.id
    ) AS Actors,
    
    (
        SELECT JSON_ARRAYAGG(
            JSON_OBJECT(
                'ID', g.id,
                'Name', g.name
            )
        )
        FROM Genres g
        JOIN MovieGenres mg ON g.id = mg.genre_id
        WHERE mg.movie_id = m.id
    ) AS Genres
    
FROM Movies m
LEFT JOIN Files p ON m.poster_id = p.id
LEFT JOIN Persons d ON m.director_id = d.id
LEFT JOIN Files dp ON d.photo_id = dp.id
WHERE m.id = 1;