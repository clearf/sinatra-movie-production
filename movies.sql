drop table tasks;
drop table movies;
drop table people;

create table movies (
  id serial primary key,
  name varchar(255),
  director varchar(255),
  release_date int
);

create table people (
  id serial primary key,
  name varchar(255)
);

create table tasks (
  id serial primary key,
  name varchar(255),
  description varchar(255),
  done boolean default false,
  person int references people(id),
  movie int references movies(id)
);

insert into movies (name, director, release_date) values ('A Scanner Darkly', 'Richard Linklater', 2006);
insert into movies (name, director, release_date) values ('Iron Man', 'Jon Favreau', 2008);


insert into people (name) values ('Richard Linklater');
insert into people (name) values ('Keanu Reeves');
insert into people (name) values ('Jon Favreau');
insert into people (name) values ('Robert Downey Jr');
insert into people (name) values ('Jeff Bridges');
insert into people (name) values ('Joey Bagadonuts');

insert into tasks (name, description, person, movie) values ('Direct', 'Direct scenes for movie', 1, 1);
insert into tasks (name, description, person, movie) values ('Direct', 'Direct scenes for movie', 3, 2);
insert into tasks (name, description, person, movie) values ('Bob Arctor', 'Perform scenes as Bob Arctor', 2, 1);
insert into tasks (name, description, person, movie) values ('James Barris', 'Perform scenes as James Barris', 4, 1);
insert into tasks (name, description, person, movie) values ('Tony Stark', 'Perform scenes as Tony Stark', 4, 2);
insert into tasks (name, description, person, movie) values ('Obadiah Stane', 'Perform scenes as Obadiah Stane', 5, 2);
insert into tasks (name, description, person, movie) values ('Coffee', 'Get coffee for cast', 6, 1);
insert into tasks (name, description, person, movie) values ('Coffee', 'Get coffee for cast', 6, 2);
