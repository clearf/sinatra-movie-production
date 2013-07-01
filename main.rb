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

#Show task detail
get '/tasks/:id' do
  id = params[:id]
  sql = "SELECT * from tasks WHERE id = #{id}"
  @task = run_sql(sql).first
  erb :task
end

#Show list of movies
get '/movies' do
  sql = "SELECT * from movies"
  @movies = run_sql(sql)
  erb :movies
end

#View movie detail
get '/movies/:id' do
  id = params[:id]
  sql = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql).first
  erb :movie
end

#Show list of contacts
get '/contacts' do
  sql = "SELECT * from contacts"
  @contacts = run_sql(sql)
  erb :contacts
end

# Show contact detail
get '/contacts/:id' do
  id = params[:id]
  sql = "SELECT * FROM contacts where id = #{id}"
  @contact = run_sql(sql).first
  erb :contact
end

#Add new task
#Add new movie
#Add new contact

#Edit task
#Edit movie
#Edit contact