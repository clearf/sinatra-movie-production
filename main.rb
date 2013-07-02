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
end

class People < ActiveRecord::Base
  belongs_to :movies
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
  sql = "SELECT id, movie_name FROM movies"
  @movies = run_sql(sql)
  sql = "SELECT id, task_name FROM tasks"
  @todos = run_sql(sql)
  erb :new_person
end

post '/people/new' do
  id = params[:id]
  person = params[:person]
  movie_id = params[:movie_id]
  task_id = params[:task_id]
  sql = "INSERT INTO people (person, movie_id, task_id) VALUES ('#{person}', '#{movie_id}','#{task_id}');"
  run_sql(sql)
  redirect to '/people'
end

get '/people/:id/edit' do
  sql = "SELECT id, movie_name FROM movies"
  @movies = run_sql(sql)
  sql = "SELECT id, task_name FROM tasks"
  @todos = run_sql(sql)
  id = params[:id]
  sql = "SELECT * FROM people WHERE id = #{id}"
  @person = run_sql(sql).first
  erb :edit_person
end

post '/people/:id' do
  id = params[:id]
  person = params[:person]
  movie_id = params[:movie_id]
  task_id = params[:task_id]
  sql = "UPDATE people SET (person, movie_id, task_id) = ('#{person}', '#{movie_id}','#{task_id}')  WHERE id = #{id}"
  @person = run_sql(sql).first
  redirect to '/people'
end

post '/people/:id/delete' do
  id = params[:id]
  sql = "DELETE FROM people WHERE id = #{id}"
  @person = run_sql(sql).first
  redirect to "/people"
end