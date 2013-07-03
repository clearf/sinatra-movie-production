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
  belongs_to :tasks
end

class Person < ActiveRecord::Base
  belongs_to :tasks
end

class Task < ActiveRecord::Base
  has_one :movie
  has_one :person
end
# binding.pry
# Tasks Section

get '/' do
  @tasks = Task.all

  erb :todos
end

get '/new_todo' do
  @movies = Movie.select([:id, :name])

  @people = Person.select([:id, :name])

  erb :new_todo
end

post '/new_todo' do
  task = Task.create(params)

  redirect to('/')
end

get '/todo/:id' do
  @task = Task.find(params[:id]).first

  # sql = "SELECT * FROM movies WHERE id = #{@task['movie']};"
  @movie_name = Task.find(params[:id]).movie

  # sql = "SELECT * FROM people WHERE id = #{@task['person']};"
  @person_name = Task.find(params[:id]).person

  erb :todo
end

get '/todo/:id/edit' do
  id = params[:id]
  sql = "SELECT * FROM tasks WHERE id = #{id};"
  @task = run_sql(sql).first

  sql = "SELECT * FROM movies WHERE id = #{@task['movie']};"
  @specific_movie = run_sql(sql).first

  sql = "SELECT * FROM people WHERE id = #{@task['person']};"
  @specific_person = run_sql(sql).first

  sql = "SELECT id, name FROM movies"
  @movies = run_sql(sql)

  sql = "SELECT id, name FROM people"
  @people = run_sql(sql)

  erb :todo_edit
end

post '/todo/:id' do
  id = params[:id]
  errand = params[:errand]
  description = params[:description]
  person = params[:person]
  movie = params[:movie]

  sql = "UPDATE tasks SET (errand, description, person, movie) = ('#{errand}', '#{description}', #{person}, #{movie}) WHERE id = #{id};"
  run_sql(sql)

  redirect to('/')
end

post '/todo/:id/delete' do
  task = Task.find(params[:id]).destroy

  redirect to('/')
end

# Movies Section

get '/new_movie' do
  erb :new_movie
end

post '/new_movie' do
  $name = params[:name].capitalize

  new_movie = Imdb::Search.new($name).movies.first
  $release_date = new_movie.release_date
  $director = new_movie.director[0]
  $image = new_movie.poster

  movie = Movie.create(name: '$name', director: '$director',
                       releasedate: '$release_date', image: '$image')

  redirect to('/movies')
end

get '/movies' do
  @movies = Movie.all

  erb :movies
end

get '/movie/:id' do
  @movie = Movie.find(params[:id])
  @tasks_of_movie = Task.find_all_by_movie_id(params[:id])
  erb :movie
end

get '/movie/:id/edit' do
  id = params[:id]
  sql = "SELECT * FROM movies WHERE id = #{id};"
  @movie = run_sql(sql).first

  erb :movie_edit
end

post '/movie/:id' do
  id = params[:id]
  name = params[:name]
  release_date = params[:releasedate]
  director = params[:director]
  image = params[:image]

  sql = "UPDATE movies SET (name, releasedate, director, image)
  = ('#{name}', '#{release_date}', '#{director}', '#{image}') WHERE id = #{id};"
  run_sql(sql)

  redirect to('/movie/#{id}')
end

post '/movie/:id/delete' do
  movie = Movie.find(params[:id]).destroy

  redirect to('/movies')
end

# People Section

get '/people' do
  @people = Person.all

  erb :people
end