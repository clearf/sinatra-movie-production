require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'rainbow'

helpers do
  def run_sql(sql)
    db = PG.connect(dbname: 'production', host: 'localhost')
    result = db.exec(sql)
    db.close
    result
  end
end

get '/' do
  "Hello"
end

#list people
get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :people
end

get '/people/new' do
  erb :new_person
end

post '/people/new' do
  name = params[:name]
  sql = "INSERT INTO people (name) VALUES ('#{name}')"
  run_sql(sql)
  redirect to('/people')
end



#list movies
get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  erb :movies
end

#list tasks
get '/tasks' do
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql)
  erb :todos
end





