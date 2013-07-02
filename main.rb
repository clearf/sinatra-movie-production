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
  redirect to "/movies/#{movie.id}"
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
  redirect to '/movies'
end


get '/todos' do
  @tasks = Tasks.all
  erb :todos
end

get '/todos/new' do
  sql = "SELECT id, movie_name FROM movies"
  @movies = run_sql(sql)
  erb :new_todo
end

post '/todos/new' do
  id = params[:id]
  task_name = params[:task_name]
  description = params[:description]
  movie_id = params[:movie_id]
  sql = "INSERT INTO tasks (task_name, description, movie_id) VALUES ('#{task_name}', '#{description}','#{movie_id}');"
  run_sql(sql)
  redirect to '/todos'
end

get '/todos/:id' do
  id = params[:id]
  task_name = params[:task_name]
  description = params[:description]
  movie_id = params[:movie_id]
  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @todo = run_sql(sql).first
  erb :todo
end

get '/todos/:id/edit' do
  sql = "SELECT id, movie_name FROM movies"
  @movies = run_sql(sql)
  id = params[:id]
  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @todo = run_sql(sql).first
  erb :edit_todo
end

post '/todos/:id' do
  id = params[:id]
  task_name = params[:task_name]
  description = params[:description]
  movie_id = params[:movie_id]
  sql = "UPDATE tasks SET (task_name, description, movie_id) = ('#{task_name}','#{description}','#{movie_id}')  WHERE id = #{id}"
  @todo = run_sql(sql).first
  redirect to '/todos'
end

post '/todos/:id/delete' do
  id = params[:id]
  sql = "DELETE FROM tasks WHERE id = #{id}"
  @todo = run_sql(sql).first
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