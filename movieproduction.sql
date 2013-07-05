-- DROP TABLE tasks;
-- DROP TABLE movies;

CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50)
);

CREATE TABLE movies
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  release_date DATE,
  director VARCHAR(50)
);

CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  name_id INT REFERENCES people(id),
  description VARCHAR(200),
  contact_person INT REFERENCES people(id),
  movie_name_id INT REFERENCES movies(id)
);
-- hi tricia i made some corrections:
-- drop table table_name needs to end witha semic olon
-- no comma on the last line of create a table

-- help producers manage production
-- by allowing them to...
-- assign people tasks,
-- manage specific tasks