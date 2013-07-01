DROP TABLE tasks;
DROP TABLE people;
DROP TABLE movies;


CREATE TABLE movies
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  release VARCHAR(255),
  director VARCHAR(255)
);

CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  description VARCHAR(255),
  contact INT REFERENCES people(id),
  movie INT REFERENCES movies(id)
);

CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  movie INT REFERENCES movies(id),
  release VARCHAR REFERENCES movies(release),
  director VARCHAR REFERENCES movies(director),
  task INT REFERENCES tasks(id)
);

