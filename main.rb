require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'imdb'
require 'sass'
require 'sinatra/activerecord'
require 'pry'


set :database, {
  adapter: 'postgresql',
  database: 'movie_prod',
  host: 'localhost'
}

class Movie < ActiveRecord::Base
  has_many :tasks
end

class Person < ActiveRecord::Base
  has_many :tasks
end

class Task < ActiveRecord::Base
  belongs_to :movie
  belongs_to :person
end

#########################
## Tasks
#########################
# Find all tasks for index page
get '/' do
  @tasks = Task.all
  erb :todos
end

# Select Movie and Person ID and Name for usage in form
get '/new_todo' do
  @movies = Movie.select([:id, :name])
  @people = Person.select([:id, :name])
  erb :new_todo
end

# Send data to db with appropriate params
post '/new_todo' do
  task = Task.create(params)
  redirect to('/')
end

# Extract Movie Name and Person Name to show on Task Page
get '/todo/:id' do
  @task = Task.find(params[:id])
  @movie_name = Movie.find_by_id(@task['movie_id'])
  @person_name = Person.find_by_id(@task['person_id'])
  erb :todo
end

# Extract all stored data to fill in the form
get '/todo/:id/edit' do
  @task = Task.find(params[:id])
  @specific_movie = Movie.find(@task['movie_id'])
  @specific_person = Person.find(@task['person_id'])
  @movies = Movie.select([:id, :name])
  @people = Person.select([:id, :name])
  erb :todo_edit
end

# Update db with new data in form by saving it
post '/todo/:id' do
  todo = Task.find(params[:id])
  todo.errand = params[:errand]
  todo.description = params[:description]
  todo.person_id = params[:person_id]
  todo.movie_id = params[:movie_id]
  todo.save
  redirect to('/')
end

# Destroy task
post '/todo/:id/delete' do
  task = Task.find(params[:id]).destroy
  redirect to('/')
end

#########################
## Movies
#########################
# Create a movie page
get '/new_movie' do
  erb :new_movie
end

# Grab movie name and use IMDB gem to fill in the rest
post '/new_movie' do
  name = params[:name].capitalize
  new_movie = Imdb::Search.new(name).movies.first
  release_date = new_movie.release_date
  director = new_movie.director[0]
  image = new_movie.poster
  movie = Movie.create(name: "#{name}", director: "#{director}",
                       releasedate: "#{release_date}", image: "#{image}")
  redirect to('/movies')
end

# list all movies in db
get '/movies' do
  @movies = Movie.all
  erb :movies
end

# Extract movie info and tasks related to the movie
get '/movie/:id' do
  @movie = Movie.find(params[:id])
  @tasks_of_movie = Task.find_all_by_movie_id(params[:id])
  erb :movie
end

# Display existing data in edit form
get '/movie/:id/edit' do
  @movie = Movie.find(params[:id])
  erb :movie_edit
end

# Update movie with new data in form and save it
post '/movie/:id' do
  movie = Movie.find(params[:id])
  movie.name = params[:name]
  movie.releasedate = params[:releasedate]
  movie.director = params[:director]
  movie.image = params[:image]
  movie.save
  redirect to('/movie/#{id}')
end

# Destroy movie
post '/movie/:id/delete' do
  movie = Movie.find(params[:id]).destroy
  redirect to('/movies')
end

#########################
## People
#########################
# list all people on staff team
get '/people' do
  @people = Person.all
  erb :people
end