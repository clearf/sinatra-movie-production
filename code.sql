-DROP TABLE tasks;
-DROP TABLE people;
-DROP TABLE movies;

CREATE TABLE tasks
(
id SERIAL PRIMARY KEY,
name VARCHAR(255),
due VARCHAR(255)
);

CREATE TABLE people
(
id SERIAL PRIMARY KEY,
name VARCHAR(255),
title VARCHAR(255)
);

CREATE TABLE movies
(
id SERIAL PRIMARY KEY,
name VARCHAR(255)
);

INSERT INTO tasks (name, due) VALUES ('Script', '6/15/13');

INSERT INTO people (name, title) VALUES ('Jimmy', 'Screen Writer');

INSERT INTO movies (name) VALUES ('Jaws');
