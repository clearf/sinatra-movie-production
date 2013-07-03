require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'

set :database, {
  adapter: 'postgresql',
  database: 'movie_production',
  host: 'localhost'
}

class Person < ActiveRecord::Base
  has_many :tasks
  has_many :movies
end

class Movie < ActiveRecord::Base
  has_many :tasks
  belongs_to :people
end

class Task < ActiveRecord::Base
  belongs_to :people
  belongs_to :movies
end

# Show the index page
get '/' do
  erb :index
end

# Show all people
get '/people' do
  @people = Person.all
  erb :people
end

# Show the form for creating a new person
get '/new_person' do
  erb :new_person
end

# Add a new person to the database
post '/new_person' do
  person = Person.create(params)
  redirect to "/person/#{person.id}"
end

# Show the details about a person
get '/person/:id' do
  @person = People.find(params[:id])
  erb :person
end

# Show the form to edit a person
get '/edit_person/:id' do
  @person = People.find(params[:id])
  erb :new_person
end

# Edit the person in the database
post '/edit_person/:id' do
  person = Person.find(params[:id])
  person.name = params[:name]
  person.save
  redirect to "/person/#{person.id}"
end

# Delete the person from the database
post '/delete_person/:id' do
  People.destroy(params[:id])
  redirect to '/'
end

# Show all movies
get '/movies' do
  @movies = Movie.all
  erb :movies
end

# Show the details of a movie
get '/movie/:id' do
  @movie = Movie.find(params[:id])
  @director = Person.find(@movie.people_id).name
  erb :movie
end

# Show the form for adding a movie
get '/new_movie' do
  @people = People.all
  erb :new_movie
end

# Add the movie to the database
post '/new_movie' do
  movie = Movie.create(params)
  redirect to "/movie/#{movie.id}"
end

# Show the form form editing a movie
get '/edit_movie/:id' do
  @movie = Movie.find(params[:id])
  @people = Person.all
  erb :new_movie
end

# Edit the movie in the database
post '/edit_movie/:id' do
  movie = Movie.find(params[:id])
  movie.name = params[:name]
  movie.release_date = params[:release_date]
  movie.people_id =params[:people_id]
  movie.save
  redirect to "/movie/#{movie.id}"
end

# Delete the movie from the database
post '/delete_movie/:id' do
  Movie.destroy(params[:id])
  redirect to '/'
end

# Show all tasks
get '/tasks' do
  @tasks = Task.all
  erb :tasks
end

# Show the details of a task
get '/task/:id' do
  @task = Task.find(params[:id])
  @person = Person.find(@task.people_id).name
  @movie = Movie.find(@task.movies_id).name
  erb :task
end

# Show the form for entering a new task
get '/new_task' do
  @people = People.all
  @movies = Movie.all
  erb :new_task
end

# Add the new task to the database
post '/new_task' do
  task = Task.create(params)
  redirect to "/task/#{task.id}"
end

# Show the form for editing a task
get '/edit_task/:id' do
  @task = Task.find(params[:id])
  @movie = Movie.all
  @people = Person.all
  erb :new_task
end

# Edit the task in the database
post '/edit_task/:id' do
  task = Task.find(params[:id])
  task.name = params[:name]
  task.description = params[:description]
  task.people_id =params[:people_id]
  task.movies_id = params[:movie_id]
  task.save
  redirect to "/task/#{task.id}"
end

# Delete the task from the database
post '/delete_task/:id' do
  Task.destroy(params[:id])
  redirect to '/'
end































