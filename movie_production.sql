CREATE TABLE people
(
id SERIAL PRIMARY KEY,
name VARCHAR(250)
);

CREATE TABLE movies
(
id SERIAL PRIMARY KEY,
name VARCHAR(250),
release_date DATE,
person_id INT REFERENCES people(id)
);

CREATE TABLE tasks
(
id SERIAL PRIMARY KEY,
name VARCHAR(250),
description VARCHAR(500),
people_id INT REFERENCES people(id),
movie_id INT REFERENCES movies(id)
);


select task.name, task.description, people.name, movie.name from movie inner join tasks on movie.id=


SELECT tasks.name, tasks.description, people.name, movies.name
FROM (movies
INNER JOIN tasks
ON movies.id=tasks.movie_id)
INNER JOIN people
ON people.id=tasks.people_id
WHERE tasks.movie_id = 2;

