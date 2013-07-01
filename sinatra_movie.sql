DROP TABLE tasks;
DROP TABLE people;
DROP TABLE movies;


CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  person_name VARCHAR(255),
  years_exp INT
);

CREATE TABLE movies
(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  image VARCHAR(255),
  release_date VARCHAR(255),
  director_name VARCHAR(255)
);

CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  task VARCHAR(255),
  description VARCHAR(255),
  person_id INT REFERENCES people(id),
  movie_id INT REFERENCES movies(id)
);


INSERT INTO people (person_name, years_exp) VALUES ('john grip', 22),
('david bestboy', 5),
('amanda boom', 12),
('jean loco', 34),
('kevin dude', 16);

INSERT INTO movies (title, image, release_date, director_name) VALUES ('quantum drunk', '', 'July 2013', 'martin scoresez'),
('burning for you', '', 'May 1999', 'peter sonjack'),
('home sweet home', '', 'January 1985', 'allen woody'),
('patience', '', 'May 1976', 'ford coppola'),
('scarred face', '', 'April 1982', 'martin scoresez');


INSERT INTO tasks (task, description, person_id, movie_id) VALUES ('get water', 'run and get water for the stars', 1, 2),
('location', 'finalize love scene local', 2, 3),
('beer', 'run and get beer for the stars', 5, 1),
('tuck in', 'do a bed check', 4, 2),
('wake up', 'get everyone up', 3, 4);






