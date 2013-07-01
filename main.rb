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

get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :people
end

get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  erb :movies
end






