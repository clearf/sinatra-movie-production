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