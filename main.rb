require 'pg'
require 'imdb'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'

#Begin Homework
#db connection
set :database, {
              :adapter => 'postgresql',
              :database => 'movies',
              :host => 'localhost'
}

#Setting up individual classes and relationships
class Movie < ActiveRecord::Base
  belongs_to :person
  has_many :tasks
end

class Task < ActiveRecord::Base
  belongs_to :person
  belongs_to :movie
end

class Person < ActiveRecord::Base
  belongs_to :movies
  has_many :tasks
end

#Routing
get '/' do
  erb :index
end

get '/home' do
  redirect to('/')
end

#Tasks - People - Movies

#ToDo's take priority. People and movies can be assigned to them.
get '/todos' do
  @todos = Task.all

  erb :todos
end

#form for new tasks (todo)
get '/todos/new' do
  @movies = Movie.all
  @people = Person.all

  erb :new_todo
end

#Add new tasks
post '/todos' do
  Task.create(params)

  redirect to('/todos')
end

#GET individual info on todos
get '/todos/:id' do

@todo = Task.find(params[:id])

@person = @todo.person
@movie = @todo.movie

  erb :todo
end
#Destroying tasks with their ID's
get '/todos/:id/delete' do
  Task.find(params[:id]).destroy

  redirect to('/todos')
end

#Edit todo's
get '/todos/:id/edit' do

  @todo = Task.find(params[:id])
  @people = Person.all
  @movies = Movie.all

  erb :edit_todo
end

post '/todos/:id' do
  todo = Task.find(params[:id])

  todo.task = params[:task]
  todo.details = params[:details]
  todo.due = params[:due]
  todo.complete = params[:complete]
  todo.person_id = params[:person_id]
  todo.movie_id = params[:movie_id]
  todo.save

  redirect to('/todos')
end


#PEEPLE
get '/people' do
  @people = Person.all
  erb :people
end

post '/people' do
  Person.create(params)
  redirect to('/people')
end

get '/people/new' do
  erb :new_person
end

get '/people/:id' do
  @person = Person.find(params[:id])
  erb :person
end

get '/people/:id/edit' do
  @person = Person.find(params[:id])

  erb :edit_person
end

post '/people/:id/edit' do

  @person = Person.find(params[:id])
  @person.name = params[:name]
  @person.email = params[:email]
  @person.save

  redirect to('/people')
end

get '/people/:id/delete' do

  person = Person.find(params[:id])

  Task.find_all_by_person_id(params[:id]).each do |task|
    task.destroy
  end
  person.destroy

  redirect to('/people')
end

#MOVIES
get '/movies' do
  @movies = Movie.all
  erb :movies
end

get '/movies/:id' do
  @movie = Movie.find(params[:id])
  erb :movie
end

post '/movies' do
  Movie.create(params)

  redirect to('/movies')
end

get '/movies/:id/edit' do
  @movie = Movie.find(params[:id])
  @people = Person.all
  erb :edit_movie
end

get '/movies/new' do
  @people = Person.all
  erb :new_movie
end

post '/movies/:id' do
  movie = Movie.find(params[:id])

  movie.title = params[:title]
  movie.description = params[:description]
  movie.save

  redirect to('/movies')
end

get '/movies/:id/delete' do
# Have to remove associated tasks.
  Task.find_all_by_movie_id(params[:id]).each do |task|
    task.destroy
  end
  Movie.find(params[:id]).destroy

  redirect to('/movies')
end

