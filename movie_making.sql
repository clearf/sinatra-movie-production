DROP TABLE tasks;
DROP TABLE movies;
DROP TABLE people;


CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(30),
  email VARCHAR(30)
);

CREATE TABLE movies
(
  id SERIAL PRIMARY KEY,
  title VARCHAR(30),
  description TEXT,
  director_id INT REFERENCES people(id)
);

CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  task VARCHAR(30),
  details VARCHAR(160),
  due VARCHAR(15),
  complete BOOLEAN DEFAULT FALSE,
  person_id INT REFERENCES people(id),
  movie_id INT REFERENCES movies(id)
);
