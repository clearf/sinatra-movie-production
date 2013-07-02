
create database movie_production;


 create table people
  (
  id serial primary key,
  name varchar (20),
  occupation varchar(30),
  )


create table movie
  (
  id serial primary key,
  movie_name varchar(40),
  release_date int,
  director varchar(40)
  )

create table todo
 (
  id serial primary key;
  task varchar(15);
  task_description varchar(100);
  person_id int references person(id)
  movie_id int references movie(id)
)


--insert into people

insert into people (name, occupation) values ('Bob', 'PA')
insert into people (name, occupation) values ('Suzy', 'Key Grip')

--insert into movie

insert into movie (movie_name, person_id) values ('Dumb and Dumber', 1996, "Farley Brothers")
insert into movie (movie_name, person_id) values ('Hunt for Red October', "No idea", 1991)

--insert into todo

insert into todo (task, task_description, person_id, movie_id) values ('getting coffee', 'duuuhhh, that is why your still a PA', 1, 1 )
insert into todo (task, task_description, person_id, movie_id) values ('grip things', 'Well... sombody has to do it right?', 2, 2)
