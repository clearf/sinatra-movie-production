DROP TABLE tasks;
DROP TABLE people;
DROP TABLE movies;


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
  -- contact_id INT REFERENCES people(id),
  movie_id INT REFERENCES movies(id)
);

CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  person VARCHAR(255),
  movie_id INT REFERENCES movies(id),
  -- release INT REFERENCES movies(release),
  -- director VARCHAR REFERENCES movies(director),
  task_id INT REFERENCES tasks(id)
);


INSERT INTO movies (movie_name, release, director) VALUES ('Eternal Sunshine of the Spotless Mind', 2004, 'Michel Gondry');

INSERT INTO tasks (task_name, description, movie_id) VALUES ('Rewrite beach scene', 'Add sand is overrated line', 1);

INSERT INTO people (person, movie_id, task_id) VALUES ('Charlie Kaufman', 1, 1);

