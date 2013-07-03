require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry' if development?

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

# This displays all of the current tasks in a bulleted list
# 3 tables were created in psql: tasks, people and movies
get '/todos' do
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql)
  erb :todos
end

# Here you are able to add new tasks and add them to a person and a movie
get '/todo/new' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  erb :todo_new
end

# This creates and new task and send it to the DB, then displays it on the todos page
post '/todo/new' do
  task = params[:task]
  description = params[:description]
  person_id = params[:person_id]
  movie_id = params[:movie_id]
  sql = "INSERT INTO tasks (task, description, person_id, movie_id) VALUES ('#{task}', '#{description}', '#{person_id}', '#{movie_id}')"
  run_sql(sql)
  redirect to '/todos'
end

# trying to pull movies by director.  I canl;t get the sql right
get '/director' do
sql = select * from
end

# this pulls the people list from DB
get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :people
end

# Trying to add a new person.  Form is live, but not submitting to DB
get '/people/new' do
  sql = "SELECT id, person_name FROM people"
  @movies = run_sql(sql)
  erb :person_new
end


# Pulling movies from th DB
get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  erb :movies
end






