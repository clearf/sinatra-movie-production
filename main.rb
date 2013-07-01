require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

helpers do
  # This helps us run SQL commands
  def run_sql(sql)
    db = PG.connect(dbname: 'movie_production', host: 'localhost')
    result = db.exec(sql)
    db.close
    result
  end
end

get '/' do
  erb :index
end

get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  erb :movies
end

get '/movies/new' do
  erb :new_movie
end

post '/movies/new' do
  id = params[:id]
  movie_name = params[:movie_name]
  release = params[:release]
  director = params[:director]
  sql = "INSERT INTO movies (movie_name, release, director) VALUES ('#{movie_name}',#{release},'#{director}');"
  run_sql(sql)
  redirect to '/movies'
end

get '/movies/:id' do
  id = params[:id]
  movie_name = params[:movie_name]
  release = params[:release]
  director = params[:director]
  sql = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql).first
  erb :movie
end

get '/movies/:id/edit' do
  id = params[:id]
  sql = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql).first
  erb :edit_movie
end

post '/movies/:id' do
  id = params[:id]
  movie_name = params[:movie_name]
  release = params[:release]
  director = params[:director]
  sql = "UPDATE movies SET (movie_name, release, director) = ('#{movie_name}',#{release},'#{director}')  WHERE id = #{id}"
  @movie = run_sql(sql).first
  redirect to '/movies'
end


get '/todos' do
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql)
  erb :todos
end

get '/todos/new' do
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

get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :people
end

get '/people/new' do
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

