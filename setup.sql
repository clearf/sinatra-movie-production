DROP TABLE tasks;
DROP TABLE people;
DROP TABLE movies;

CREATE TABLE movies
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  releasedate VARCHAR(255),
  director VARCHAR(255),
  image TEXT
);

CREATE TABLE people
(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  image TEXT
);

CREATE TABLE tasks
(
  id SERIAL PRIMARY KEY,
  errand TEXT,
  description TEXT,
  person INT REFERENCES people(id),
  movie INT REFERENCES movies(id)
);

INSERT INTO movies (name, releasedate, director, image) VALUES ('Titanic', 'December 19, 1997', 'James Cameron', 'http://upload.wikimedia.org/wikipedia/en/thumb/2/22/Titanic_poster.jpg/220px-Titanic_poster.jpg');
INSERT INTO movies (name, releasedate, director, image) VALUES ('Kick-Ass', 'April 16, 2010', 'Matthew Vaughn', 'http://upload.wikimedia.org/wikipedia/en/thumb/3/30/Kick-Ass_film_poster.jpg/215px-Kick-Ass_film_poster.jpg');
INSERT INTO movies (name, releasedate, director, image) VALUES ('World War Z', 'June 21, 2013', 'Marc Forster', 'http://www.thesobremesa.com/wp-content/uploads/world-war-z-poster031.jpg');
INSERT INTO movies (name, releasedate, director, image) VALUES ('This is The End', 'June 12, 2013', 'Evan Goldberg', 'http://ia.media-imdb.com/images/M/MV5BMTQxODE3NjM1Ml5BMl5BanBnXkFtZTcwMzkzNjc4OA@@._V1_SX214_.jpg');
INSERT INTO movies (name, releasedate, director, image) VALUES ('Atonement', 'January 4, 2008', 'Joe Wright', 'http://ia.media-imdb.com/images/M/MV5BMTM0ODc2Mzg1Nl5BMl5BanBnXkFtZTcwMTg4MDU1MQ@@._V1_SY317_CR0,0,214,317_.jpg');
INSERT INTO movies (name, releasedate, director, image) VALUES ('Ironman', 'May 3, 2013', 'Shane Black', 'http://ia.media-imdb.com/images/M/MV5BMjIzMzAzMjQyM15BMl5BanBnXkFtZTcwNzM2NjcyOQ@@._V1_SX214_.jpg');


INSERT INTO people (name, image) VALUES ('Ryan Gosling', 'http://cdn.pastemagazine.com/www/blogs/awesome_of_the_day/RyanGosling.jpg?1340108974');
INSERT INTO people (name, image) VALUES ('Ryan Higa', 'http://e27.co/wp-content/uploads/2013/05/RyanHiga.jpg');
INSERT INTO people (name, image) VALUES ('Emma Stone', 'http://www.macsmagazine.com/wp-content/uploads/2013/04/emma_stone-gangster_squad-5.jpg');
INSERT INTO people (name, image) VALUES ('David Beckham', 'http://tendanceus.fr/media/wysiwyg/david-beckham-psg.jpg');
INSERT INTO people (name, image) VALUES ('Joseph Gordon-Levitt', 'https://si0.twimg.com/profile_images/2649571860/910e545d7537be6148b7923aa86d2144.png');
INSERT INTO people (name, image) VALUES ('Kate Beckinsale', 'http://img2.timeinc.net/instyle/images/2010/GalxMonth/08/081910-kate-beckinsale-400.jpg');
INSERT INTO people (name, image) VALUES ('Ryan Reynolds', 'http://www.menshealth.co.uk/cm/menshealthuk/images/mc/ryan-reynolds-full-body-front-2006-mdn.jpg');
INSERT INTO people (name, image) VALUES ('Emma Watson', 'http://images6.fanpop.com/image/photos/33600000/Emma-Icons-x-emma-watson-33646984-788-788.jpg');
INSERT INTO people (name, image) VALUES ('Bradley Cooper', 'http://beards.provocateuse.com/images/photos/bradley_cooper_02.jpg');
INSERT INTO people (name, image) VALUES ('Robert Downey Jr.', 'http://www.cultureblues.com/wp-content/uploads/2010/05/downey-intro.jpg');
INSERT INTO people (name, image) VALUES ('Candice Swanepoel', 'http://cdn.rsvlts.com/wp-content/uploads/2012/12/Candice-Swanepoel-18.jpeg');
INSERT INTO people (name, image) VALUES ('Jessica Alba', 'http://static.comicvine.com/uploads/scale_small/3/38919/2954389-jessica+alba.jpg');

INSERT INTO tasks (errand, description, person, movie) VALUES ('Order food', 'Get Asian food for entire production crew', 1, 1);




-- Active Record

-- (name: 'Ryan Gosling', image: 'http://cdn.pastemagazine.com/www/blogs/awesome_of_the_day/RyanGosling.jpg?1340108974')
-- (name: 'Ryan Higa', image: 'http://e27.co/wp-content/uploads/2013/05/RyanHiga.jpg')
-- (name: 'Emma Stone', image: 'http://www.macsmagazine.com/wp-content/uploads/2013/04/emma_stone-gangster_squad-5.jpg')
-- (name: 'David Beckham', image: 'http://tendanceus.fr/media/wysiwyg/david-beckham-psg.jpg')
-- (name: 'Joseph Gordon-Levitt', image: 'https://si0.twimg.com/profile_images/2649571860/910e545d7537be6148b7923aa86d2144.png')
-- (name: 'Kate Beckinsale', image: 'http://img2.timeinc.net/instyle/images/2010/GalxMonth/08/081910-kate-beckinsale-400.jpg')
-- (name: 'Ryan Reynolds', image: 'http://www.menshealth.co.uk/cm/menshealthuk/images/mc/ryan-reynolds-full-body-front-2006-mdn.jpg')
-- (name: 'Emma Watson', image: 'http://images6.fanpop.com/image/photos/33600000/Emma-Icons-x-emma-watson-33646984-788-788.jpg')
-- (name: 'Bradley Cooper', image: 'http://beards.provocateuse.com/images/photos/bradley_cooper_02.jpg')
-- (name: 'Robert Downey Jr.', image: 'http://www.cultureblues.com/wp-content/uploads/2010/05/downey-intro.jpg')
-- (name: 'Candice Swanepoel', image: 'http://cdn.rsvlts.com/wp-content/uploads/2012/12/Candice-Swanepoel-18.jpeg')
-- (name: 'Jessica Alba', image: 'http://static.comicvine.com/uploads/scale_small/3/38919/2954389-jessica+alba.jpg')
