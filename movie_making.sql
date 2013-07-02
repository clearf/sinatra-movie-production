DROP TABLE tasks;
DROP TABLE movies;
DROP TABLE people;


CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(25),
  email VARCHAR(25)
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


INSERT INTO people (name, email) VALUES ('Brad Paisley', 'BGpg@gstale.com');
INSERT INTO people (name, email) VALUES ('Yoshi Kagawa', 'GoAwayMario@leafmib.com');
INSERT INTO people (name, email) VALUES ('Bruce Wayne', 'waitreally@batmail.unknown');

INSERT INTO movies (title, description, director_id) VALUES ('Digital Deep Diving', 'Bioshock meets Pixar in a marine 20s thriller', 1);
INSERT INTO movies (title, description, director_id) VALUES ('LoZ: Echoes of the Future', 'Fallout meets The Legend of Zelda. Another heir capable of heroic courage must save Zelda and the world from Ganondorf as he returns after nuclear fallout', 2);
INSERT INTO movies (title, description ,director_id) VALUES ('Batman vs Superman', 'Two super-heroes meet after both being ditched by Christopher Nolan', 3);

INSERT INTO tasks (task, details, due, person_id, movie_id) VALUES ('Macro Ocean Shore Shot', '30mm prime lens needed for sunrise shot', 'Tomorrow 6am', 1, 1);
INSERT INTO tasks (task, details, due, person_id, movie_id) VALUES ('Copy Release Forms', 'Take the remaining forms from last years film and make 100 copies', '07/5/2013', 3, 2);
INSERT INTO tasks (task, details, due, person_id, movie_id) VALUES ('Set initial budget', 'Meet with Moto over coffee @ Sweetleaf', '7/3/2013 - 7am', 2, 3);
