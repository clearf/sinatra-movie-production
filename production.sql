DROP TABLE tasks;
DROP TABLE movies;
DROP TABLE people;


CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(20)
);

CREATE TABLE movies
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(20),
  person_id INT REFERENCES people(id)
);

CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(20),
  description VARCHAR(100),
  movie_id INT REFERENCES movies(id),
  person_id INT REFERENCES people(id)
);


-- ADD PEOPLE
INSERT INTO people (name) VALUES ('name_1');

-- ADD movie
INSERT INTO movies (name, person_id) VALUES ('Movie_1', 1);

-- ADD tasks
INSERT INTO tasks (name, description, movie_id, person_id) VALUES ('buy camera', 'go to store and buy a camera', 1, 1);