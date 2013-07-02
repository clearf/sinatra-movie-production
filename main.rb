require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?

helpers do
  # This helps run sql commands
  def run_sql(sql)
    db = PG.connect(dbname: 'sinatra_movies', host: 'localhost')
    result = db.exec(sql)
    db.close
    result
  end
end


# root
get '/' do
  erb :index
end

get '/todos' do
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql)
  erb :todos
end

get '/todo/new' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  erb :todo_new
end

post '/todo/new' do
  task = params[:task]
  description = params[:description]
  person_id = params[:person_id]
  movie_id = params[:movie_id]
  sql = "INSERT INTO tasks (task, description, person_id, movie_id) VALUES ('#{task}', '#{description}', '#{person_id}', '#{movie_id}')"
  run_sql(sql)
  redirect to '/todos'
end


get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :people
end

get '/people/new' do
  sql = "SELECT id, person_name FROM people"
  @movies = run_sql(sql)
  erb :person_new
end

get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  erb :movies
end






