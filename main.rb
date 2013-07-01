require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'yahoofinance'

#################### DEFINE METHODS ####################

def run_sql(sql)
  db = PG.connect(:dbname => 'movie_todo_hw', :host => 'localhost')
  result = db.exec(sql)
  db.close
  return result
end


#################### MAIN LANDING PAGE ####################
get '/' do

  sql_get_movies = "SELECT * FROM movies"
  @got_movies = run_sql(sql_get_movies)

  sql_get_people = "SELECT * FROM people"
  @got_people = run_sql(sql_get_people)

  sql_get_todos = "SELECT * FROM tasks"
  @got_todos = run_sql(sql_get_todos)

  erb :index
end


#################### MOVIE SECTION ####################
get '/movies' do
  erb :movies
end

# HERE THE USER INPUT A NEW MOVIE
get '/movies/add' do
  erb :movies_add
end


#################### PEOPLE SECTION ####################
# HERE THE USER INPUT A NEW MOVIE
get '/people' do
  sql_get_people = "SELECT * FROM people"
  @got_people = run_sql(sql_get_people)

  erb :people

end


#################### TODO SECTION ####################
get '/todos' do
  erb :todos
end



