DROP TABLE TASKS;
DROP TABLE MOVIES;
DROP TABLE PEOPLE;

CREATE TABLE PEOPLE
(ID SERIAL PRIMARY KEY,
  name VARCHAR(127),
  title VARCHAR(127),
  phone VARCHAR(15)
  );

CREATE TABLE MOVIES
(ID SERIAL PRIMARY KEY,
  title VARCHAR(255),
  director_id INT references movies(id),
  image TEXT
);

CREATE TABLE TASKS
(ID SERIAL PRIMARY KEY,
  task VARCHAR(127),
  description TEXT,
  person_id INT references people(id),
  movie_id INT references movies(id),
  completed BOOLEAN DEFAULT FALSE
);




