require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'
require 'sinatra/activerecord'

set :database, {adapter: 'postgresql', database: 'production', host: 'localhost'}

class Task < ActiveRecord::Base
end

class Movie < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

#Launch page
get '/' do
  erb :index
end

#Show list of tasks
get '/tasks' do
  @tasks = Task.all
  erb :tasks
end

#Add new task ## DOES NOT WORK ##
get '/tasks/new' do
  erb :new_task
end

post '/tasks/new' do
  task = Task.create(params)
  redirect to "/tasks/#{task.id}"
end

#Show task detail
get '/tasks/:id' do
  @task = Task.find(params[:id])
  erb :task
end

#Edit task ##UPDATE ##
get '/tasks/:id/edit' do
  id = params[:id]
  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @task = run_sql(sql).first
  erb :edittask #fix this
end

#Delete task ##UPDATE##
post '/tasks/:id/delete' do
  id = params[:id]
  sql = "DELETE FROM tasks where id = #{id}"
  run_sql(sql)
  redirect to "/tasks"
end

#Show list of movies
get '/movies' do
  @movies = Movie.all
  erb :movies
end

#Add new movie
get '/movies/new' do
  erb :new_movie
end

post '/movies/new' do
  movie = Movie.create(params)
  redirect to '/movies'
end

#View movie detail
get '/movies/:id' do
  id = params[:id]
  sql = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql).first
  erb :movie
end

#Delete Movie
post '/movies/:id/delete' do
  id = params[:id]
  sql = "DELETE FROM movies WHERE id = #{id}"
  run_sql(sql)
  redirect to '/movies'
end


#Show list of contacts
get '/contacts' do
  sql = "SELECT * from contacts"
  @contacts = run_sql(sql)
  erb :contacts
end

# Add new contact
get '/contacts/new' do
  erb :new_contact
end

post '/contacts/new' do
  name = params[:name]
  sql = "INSERT INTO contacts (name) VALUES ('#{name}')"
  run_sql(sql)
  redirect to '/contacts'
end

# Show contact detail
get '/contacts/:id' do
  id = params[:id]
  sql = "SELECT * FROM contacts where id = #{id}"
  @contact = run_sql(sql).first
  erb :contact
end

# Delete contacts
post '/contacts/:id/delete' do
  id = params[:id]
  sql = "DELETE FROM contacts where id = #{id}"
  run_sql(sql)
  redirect to '/contacts'
end

#Edit task
#Edit movie
#Edit contact