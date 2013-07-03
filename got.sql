DROP TABLE movies;
DROP TABLE tasks;
DROP TABLE people;


CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  task_name VARCHAR(255),
  description VARCHAR(255),
  movie_id INT REFERENCES movies(id)
);


CREATE TABLE movies
(
  id SERIAL PRIMARY KEY,
  movie_name VARCHAR(255),
  release INT,
  director VARCHAR(255)
);


CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  person VARCHAR(255),
  movie_id INT REFERENCES movies(id),
  task_id INT REFERENCES tasks(id)
);

#starting off with a 1 movie/task/person in each table

INSERT INTO tasks (task_name, description, movie_id) VALUES ('cut film', 'cut the film', 1);

INSERT INTO movies (movie_name, release, director) VALUES ('Blow', 2001, 'Ted Demme');




