require 'pg'
require 'imdb'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'

#Begin Homework
#db connection
set :database, {
              :adapter => 'postgresql',
              :database => 'movies',
              :host => 'localhost'
}

#Setting up individual classes and relationships
class Movie < ActiveRecord::Base
  belongs_to :person
  has_many :tasks
end

class Task < ActiveRecord::Base
  belongs_to :person
  belongs_to :movie
end

class Person < ActiveRecord::Base
  belongs_to :movies
  has_many :tasks
end

#Routing
get '/' do
  erb :index
end

get '/home' do
  redirect to('/')
end


#Tasks - People - Movies

#ToDo's take priority. People and movies can be assigned to them.
get '/todos' do
  @todos = Task.all

  erb :todos
end

#form for new tasks (todo)
get '/todos/new' do
  @movies = Movie.all
  @people = Person.all

  erb :new_todo
end

#Add new tasks
post '/todos' do
  Task.create(params)
  redirect to('/todos')
end

#GET individual info on todos
get '/todos/:id' do

@todo = Task.find(params[:id])

@person = @todo.person
@movie = @todo.movie

  erb :todo
end
#Deleting tasks with their ID's. Stays the same.
get '/todos/:id/delete' do
  id = params[:id]

  sql = "DELETE FROM tasks WHERE id = #{id}"
  run_sql(sql)

  redirect to('/todos')
end

#Edit todo's
get '/todos/:id/edit' do

  @todo = Task.find(params[:id])
  @people = Person.all
  @movies = Movie.all

  erb :edit_todo
end

#PEEPLE
get '/people' do
  person_id = params[:person_id]

  sql = "SELECT * FROM people"
  @people = run_sql(sql)

  erb :people
end

get '/people/:id' do
  id = params[:id]

  sql = "SELECT * FROM people WHERE id = #{id}"
  @person = run_sql(sql)[0]

  erb :person
end
post '/people' do

  name = params[:name]
  email = params[:email]

  sql = "INSERT INTO people (name, email) VALUES ('#{'name'}','#{'email'}')"
  run_sql(sql)

  redirect to('/people')
end

get '/people/:id/edit' do
  id = params[:id]

  sql = "SELECT * FROM people WHERE id = #{id}"
  @person = run_sql(sql).first

  erb :edit_person
end

post '/people/:id/edit' do

  id = params[:id]
  name = params[:name]
  email = params[:email]

  sql = "SELECT name FROM people WHERE id = #{id}"

end

#MOVIES
