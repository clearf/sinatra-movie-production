require 'pg'
require 'sinatra'
require 'sinatra/reloader'

helpers do
  # This helps us run SQL commands
  def run_sql(sql)
    db = PG.connect(dbname: 'movie_manager', host: 'localhost')
    result = db.exec(sql)
    db.close
    return result
  end
end

get '/' do
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql)

  sql = "SELECT id, name FROM people"
  @people = run_sql(sql)

  sql = "SELECT id, title FROM movies"
  @movies = run_sql(sql)

  erb :tasks
end

post '/new_task' do
  task = params[:task]
  description = params[:description]
  person_id = params[:person_id]
  movie_id = params[:movie_id]

  sql = "INSERT INTO tasks (task, description, person_id, movie_id) VALUES ('#{task}', '#{description}', #{person_id}, #{movie_id})"
  run_sql(sql)

  redirect to('/')
end

get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)

  erb :movies
end

get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)

  erb :people
end

