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


get '/todos' do
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql)
  erb :todos
end


get '/' do
  erb :movies
end


get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :people
end

