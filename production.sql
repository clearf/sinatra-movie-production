DROP TABLE movies;
DROP TABLE contacts;
DROP TABLE tasks;

CREATE TABLE movies
(
id SERIAL PRIMARY KEY,
name VARCHAR(255),
release_date DATE,
director VARCHAR(255)
);

CREATE TABLE contacts
(
id SERIAL PRIMARY KEY,
name VARCHAR(255)
);

CREATE TABLE tasks
(
id SERIAL PRIMARY KEY,
name VARCHAR(255),
descriptions VARCHAR(255),
movie_id INT REFERENCES movies(id),
contact_id INT REFERENCES contacts(id)
);

INSERT INTO movies (name, release_date, director) VALUES ('Toy Story 4', '08/05/2014','David Copperfield');
INSERT INTO movies (name, release_date, director) VALUES ('Forrest Gump 2', '09/10/2015', 'Thom Hanks');

INSERT INTO contacts (name) VALUES ('John Scout');
INSERT INTO contacts (name) VALUES ('Bob Camera');

INSERT INTO tasks (name, descriptions, movie_id, contact_id) VALUES ('Urgent','Buy camera',1,1);
INSERT INTO tasks (name, descriptions, movie_id, contact_id) VALUES ('Task 2','Clean camera',2,2);