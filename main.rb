require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'sinatra/activerecord'

set :database, {adapter: 'postgresql', database: 'movie_production',host:'localhost'}

class People < ActiveRecord::Base
    has_many :movies
    has_many :tasks
end

class Movie < ActiveRecord::Base
    belongs_to :person
    has_many :tasks
end

class Task < ActiveRecord::Base
    belongs_to :person
    belongs_to :movie
end


  get '/' do
    erb :index
  end
#_______________________________________________________________________________________________
  # list people
  get '/people' do
    @people = People.all
    erb :people
end

  # input form to add a new person
  get'/people/new' do
    erb :add_new_person
  end

  # grab (new person) input from form & send to database
  post '/people/new' do
    person = Person.create(params)
    redirect to('/people')
end

  # single person
  get '/people/:id' do
    @person = Person.find(params[:id])
    @person_details = Person.find(params[:id])
    erb :person
  end

  # delete person
  get '/people/:id/delete' do
    People.find(params[:id]).destroy
    redirect to('/people')
end

  # edit person
  get '/people/:id/edit' do
    @person_id = params[:id]
    @person_details = Person.find(params[:id])
    erb :edit_person
end

    # grab (edit person) input from form & send to database
    post '/people/:id' do
    person = Person.find(params[:id])
    person.name = params[:name]
    person.save
    redirect to('/people')
end
#___________________________________________________________________________________________

    #list movies
    get '/movies' do
    @movies = Movie.all
    erb :movies
end
    # input form to add a new movie
    get '/movies/new' do
    @people =Person.all
    erb :add_new_movie
end
    # grab (new movie) input from form & send to database
    post '/movies/new' do
    movie = movie_details.create(params)
    redirect to('/movies')
end

    # single movie
    get '/movies/:id' do
    @movie_details = Movie.find(params[:id])
    erb :movie
end


    # delete movie
    get '/movies/:id/delete' do
    Movie.find(params[:id]).destroy
    redirect to('/movies')
end

    # edit movie
    get '/movies/:id/edit' do
    @movie_id = params[:id]
    @movie_details = Movie.find(params[:id])
    @person = Person.all
    erb :edit_movie
end
    # grab (edit movie) input from form & send to database
    post '/movies/:id' do
    movie = Movie.find(params[:id])
    movie.name = params[:name]
    movie.person_id = params[:person_id]
    movie.save
    redirect to('/movies')
end
#___________________________________________________________________________________________

    # list tasks
    get '/tasks' do
    @tasks =Task.all
    erb :tasks
end

    # input form to add a new task
    get '/tasks/new' do
    @movies = Movie.all
    @people = Person.all
    erb :add_new_task
end

    # grab (new task) input from form & send to database
    post '/tasks/new' do
    task = Task.create(params)
    redirect to('/tasks')
end

    # single task
    get '/tasks/:id' do
    @task = Task.find(params[:id])
    @task_details = Task.find(params[:id])
    @movie_details = Movie.all
    @people = Person.all
    erb :task
end

    # delete task
    get '/tasks/:id/delete' do
    @task_id = params[:id]
    Task.find(params[:id]).destroy
    redirect to('/tasks')
end

    # edit task
    get '/tasks/:id/edit' do
    @task_id = params[:id]
    @task_details = Task.find(params[:id])
    @movie_details = Movie.all
    @people = Person.all
    erb :edit_task
end

    # grab (edit movie) input from form & send to database
    post '/tasks/:id' do
    task = Task.find(params[:id])
    task.name = params[:name]
    task.description = params[:due]
    task.person_id = params[:person_id]
    task.movie_id = params[:movie_id]
    task.save
    redirect to('/tasks')
end
