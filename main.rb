require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry' if development?
require 'sinatra/activerecord'

set :database, {
  adapter: 'postgresql',
  database: 'movie_production',
  host: 'localhost'
}

class Movies < ActiveRecord::Base
  has_many :tasks
  has_many :people
end

class Tasks < ActiveRecord::Base
  belongs_to :movies
  has_many :tasks
end

class People < ActiveRecord::Base
  belongs_to :movies
  belongs_to :tasks
end



get '/' do
  erb :movies
end

get '/movies' do
  @movies = Movies.all
  erb :movies
end

get '/movies/new' do
  erb :new_movie
end

post '/movies/new' do
  movie = Movies.create(params)
  redirect to "/movies"
end

get '/movies/:id' do
  @movie = Movies.find(params[:id])
  erb :movie
end

get '/movies/:id/edit' do
   @movie = Movies.find(params[:id])
  erb :edit_movie
end

post '/movies/:id' do
  movie = Movies.find(params[:id])
  movie.movie_name = params[:movie_name]
  movie.release = params[:release]
  movie.director = params[:director]
  movie.save

  redirect to '/movies'
end


get '/todos' do
  @todos = Tasks.all
  erb :todos
end

get '/todos/new' do
  @movies = Movies.all
  erb :new_todo
end

post '/todos/new' do
  task = Tasks.create(params)
  redirect to '/todos'
end

get '/todos/:id' do
  @todo = Tasks.find(params[:id])
  erb :todo
end

get '/todos/:id/edit' do
  @movies = Movies.all
  @todo = Tasks.find(params[:id])
  erb :edit_todo
end

post '/todos/:id' do
  task = Tasks.find(params[:id])
  task.task_name = params[:task_name]
  task.description = params[:description]
  task.movie_id = params[:movie_id]
  task.save

  redirect to '/todos'
end

post '/todos/:id/delete' do
  task = Tasks.delete(params[:id])
  redirect to "/todos"
end

get '/people' do
  @people = People.all
  erb :people
end

get '/people/new' do
  @movies = Movies.all
  @todos = Tasks.all
  erb :new_person
end

post '/people/new' do
  person = People.create(params)
  redirect to '/people'
end

get '/people/:id' do
  @person = People.find(params[:id])
  erb :person
end

get '/people/:id/edit' do
  @movies = Movies.all
  @todos = Tasks.all
  @person = People.find(params[:id])
  erb :edit_person
end

post '/people/:id' do
  person = People.find(params[:id])
  person.person = params[:person]
  person.task_id = params[:task_id]
  person.movie_id = params[:movie_id]
  person.save

  redirect to '/people'
end

post '/people/:id/delete' do
  person = Person.delete(params[:id])
  redirect to "/people"
end