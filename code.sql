-DROP TABLE people;
-DROP TABLE movies;
-DROP TABLE tasks;

CREATE TABLE people
(
id SERIAL PRIMARY KEY,
name VARCHAR(255),
title VARCHAR(255)
);

CREATE TABLE movies
(
id SERIAL PRIMARY KEY,
name VARCHAR(255),
person_id INT REFERENCES people(id)
);

CREATE TABLE tasks
(
id SERIAL PRIMARY KEY,
name VARCHAR(255),
due VARCHAR(255),
person_id INT REFERENCES people(id),
movie_id INT REFERENCES movies(id)
);

INSERT INTO people (name, title) VALUES ('Jimmy', 'Screen Writer');

INSERT INTO movies (name, person_id) VALUES ('Jaws', 1);

INSERT INTO tasks (name, due, movie_id, person_id) VALUES ('Script', '6/15/13', 1, 1);