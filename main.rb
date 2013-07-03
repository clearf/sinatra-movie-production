require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'


set :database, {adapter: "postgresql",
                database: "movie_production2",
                host: "localhost"}


class Todos < ActiveRecord::Base
  belongs_to :movie
  belongs_to :people
end

class Movies < ActiveRecord::Base
  has_many :people
  has_many :todos
end

class People < ActiveRecord::Base
  belongs_to :movie
  has_many :todos
end



# this provides you with the index page that links to each seperate page
get '/' do
  erb :index
end

#       #
# Tasks #
#       #

# gets all the tasks

get '/todos' do
  @todos = Todos.all
erb :todos
end

# gives each individual task

get '/todo/:id' do
  @todo = Todos.find(params[:id])
erb :todo
end

# goes to the edit task
get '/edit_todo/:id/' do
  @todo = Todos.find(params[:id])
erb :edit_todo
end

# posts the update back
post '/edit_todo/:id/' do
  todo = Todos.find(params[:id])
  todo.name = params[:task]
  todo.descriptions = params[:task_description]
  todo.movie_id = params[:movie_id]
  todo.contact_id = params[:contact_id]
  todo.save
  redirect to "/todos/#{todo.id}"
end


# create and assign new todo
get '/create_todo' do
  @people = People.find(params[:id])
  @movies = Movies.find(params[:id])
  erb :create_todo
end

# posts the task back to
post '/create_todo' do
  todo = Todos.create(params)
  redirect to "/todo/#{guitar.id}"
  erb :todos
end



#         #
# People  #
#         #

# get all the people

get'/people' do
  @people = People.all
  erb :people
end

# get each individual person


get '/person/:id' do
  @people = People.find(params[:id])
erb :person
end


 # gives you the person information to edit
 get '/edit_person/:id' do
  @people = People.find(params[:id])
 end

#  posts the edits back to person
post '/edit_person/:id' do
  sql = "update people set (name, occupation) = ('#{name}', '#{occupation}') WHERE id = #{id}"
  @person = run_sql(sql).first
end



# creates an new person and assigns
get '/create_person' do
  erb :create_person
end

# posts the person back to people
post '/create_person' do
  name = params[:name]
  occupation = params[:occupation]
  sql = "insert into people (name, occupation) values ('#{name}', '#{occupation}')"
  run_sql(sql)
  erb :people
end




#        #
# Movies #
#        #

# gets the movie

get '/movies' do
  sql = "select * from movies"
  @movies = run_sql(sql)
  erb :movies
end

# gets single movie with information

get '/movie/:id' do
  id = params[:id]
  sql =  "select * from movies where id = #{id}"
  @movie = run_sql(sql).first
  erb :movie
end

# creates an new person and assigns
get '/create_movie' do
  erb :create_movie
end

# posts the person back to people
post '/create_movie' do
  movie_name = params[:movie_name]
  release_date = params[:release_date]
  director = params[:director]
  sql = "insert into movies (movie_name, release_date, director) values ('#{movie_name}', #{release_date}, '#{director}')"
  run_sql(sql)
end

get '/edit_movie/:id' do

erb :edit_movie
end

post '/edit_movie/:id' do
  id = params[:id]
  @movie_name = params[:movie_name]
  @release_date = params[:release_date]
  @director = params[:director]
  sql = "update movies set (movie_name, release_date, director) values ('#{movie_name}', #{release_date}, '#{director}') WHERE id = #{id}"
  @person = run_sql(sql).first
end



