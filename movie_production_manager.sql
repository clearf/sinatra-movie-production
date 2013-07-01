DROP TABLE TASKS
DROP TABLE MOVIES
DROP TABLE PEOPLE

CREATE TABLE PEOPLE
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(127),
  title VARCHAR(127),
  phone VARCHAR(16)
);

CREATE TABLE MOVIES
(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  director_id REFERENCES movies(id),
  year VARCHAR(7),
  image TEXT
);

CREATE TABLE TASKS
(
  id SERIAL PRIMARY KEY,
  task VARCHAR(127),
  description TEXT,
  person_id INT REFERENCES people(id),
  movie_id INT REFERENCES movies(id),
  completed BOOLEAN
);