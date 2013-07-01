require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'

helpers do
def run_sql(sql)
  db = PG.connect(dbname: 'production', host:'localhost')
  result = db.exec(sql)
  db.close
  result
end
end

#Show list of tasks
get '/tasks' do
  sql = "SELECT * from tasks"
  @tasks = run_sql(sql)
  erb :tasks
end

#Show list of movies
get '/movies' do
  sql = "SELECT * from movies"
  @movies = run_sql(sql)
  erb :movies
end

#Show list of contacts

#Add new task
#Add new movie
#Add new contact

#Edit task
#Edit movie
#Edit contact