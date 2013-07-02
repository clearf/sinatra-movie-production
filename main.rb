require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'


# Run SQL commands
 def run_sql(sql)
  db = PG.connect(:dbname => 'movies', :host => 'localhost')
  result = db.exec(sql)
  db.close
  result
  end

#see list of all todos
get '/todos' do
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql)
  erb :todos
end

#see individual todo
get '/todos/:id' do
  id = params[:id]
  task_name = params[:task_name]
  description = params[:description]
  movie_id = params[:movie_id]
  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @todo = run_sql(sql).first
  erb :todo
end

#see list of all movies
get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  erb :movies
end

#see individual movie
get '/movies/:id' do
  id = params[:id]
  movie_name = params[:movie_name]
  release = params[:release]
  director = params[:director]
  sql = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql).first
  erb :movie
end

#see list of all people
get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :people
end

