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
  movie_name = params[:movie_name]
  release = params[:release]
  director = params[:director]
  sql = "INSERT INTO movies (movie_name, release, director) VALUES ('#{movie_name}',#{release},'#{director}');"
  run_sql(sql)
  redirect to '/movies'
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
