DROP TABLE movies;
DROP TABLE tasks;
DROP TABLE people;


CREATE TABLE movies
(
  id SERIAL PRIMARY KEY,
  movie_name VARCHAR(255),
  release INT,
  director VARCHAR(255)
);

CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  task_name VARCHAR(255),
  description VARCHAR(255),
  movie_id INT REFERENCES movies(id)
);

CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  person VARCHAR(255),
  movie_id INT REFERENCES movies(id),
  task_id INT REFERENCES tasks(id)
);





