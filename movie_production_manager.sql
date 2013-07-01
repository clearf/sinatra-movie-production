-- DROP TABLE TASKS;
-- DROP TABLE MOVIES;
-- DROP TABLE PEOPLE;

-- CREATE TABLE PEOPLE
-- (
--   id SERIAL PRIMARY KEY,
--   name VARCHAR(127),
--   title VARCHAR(127),
--   phone VARCHAR(16)
-- );

-- CREATE TABLE MOVIES
-- (
--   id SERIAL PRIMARY KEY,
--   title VARCHAR(255),
--   director_id INT REFERENCES movies(id),
--   year VARCHAR(7),
--   image TEXT
-- );

-- CREATE TABLE TASKS
-- (
--   id SERIAL PRIMARY KEY,
--   task VARCHAR(127),
--   description TEXT,
--   person_id INT REFERENCES people(id),
--   movie_id INT REFERENCES movies(id),
--   completed BOOLEAN DEFAULT FALSE
-- );

INSERT INTO people (name, title, phone) VALUES ('Asha Greyjoy', 'Director', '201-396-8258');
INSERT INTO people (name, title, phone) VALUES ('Andrei Mendeleev', 'Director', '617-242-3632');

INSERT INTO movies (title, director_id, year, image) VALUES ('The Cat and the Candle', 1, '2014', 'http://andreapaesante.com/wp-content/uploads/2011/02/smat-cat-with-candle.jpg');
INSERT INTO movies (title, director_id, year, image) VALUES ('Psychodrama in the Afternoon', 2, '2013', 'http://www.thebridgepai.com/wp-content/deren-1.jpg');