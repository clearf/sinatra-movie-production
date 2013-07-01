create table movies (
  id serial primary key,
  name varchar(255),
  director varchar(255),
  release_date int
);

create table people (
  id serial primary key,
  name varchar(255),
  job varchar(255)
);

create table tasks (
  id serial primary key,
  name varchar(255),
  description varchar(255),
  person int references people(id),
  movie int references movies(id)
);