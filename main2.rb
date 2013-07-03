require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?

set :database, {adapter: "postgresql",
                database: "movie_production",
                host: "localhost"}



# this provides you with the index page that links to each seperate page
get '/' do
  erb :index
end

#       #
# Tasks #
#       #

# gets all the tasks

get '/todos' do
  @todos = ().all
erb :todos
end

# gives each individual task

get '/todo/:id' do
  @todo = .find(params[:id])
erb :todo
end

# goes to the edit task
get '/edit_todo/:id/' do
  sql = "select * from todo where id = #{id}"
@todos = run_sql(sql).first
erb :edit_todo
end

# posts the update back
post '/edit_todo/:id/' do
sql =
@todos
end


# create and assign new todo
get '/create_todo' do
  sql = "select id, name from people"
  @people = run_sql(sql)
  sql = "select id, movie_name from movies"
  @movies = run_sql(sql)
  erb :create_todo
end

# posts the task back to
post '/create_todo' do
  todo = Guitar.create(params)
  redirect to "/todo/#{guitar.id}"

  erb :todos
end


#         #
# People  #
#         #

# get all the people

get'/people' do
  sql = "select * from people"
  @people = run_sql(sql)
  erb :people
end

# get each individual person

get'/person/:id' do
  name = params[:name]
  occupation = params[:occupation]
  sql = "select * from people where id = #{'id'}"
  @person = run_sql(sql).first
  erb :person
end

# # gives you the person information to edit
# get '/edit_person/:id' do
#   sql = "select * from people where id = #{id}"
#   @person = run_sql(sql).first
# end

# # posts the edits back to person
# post '/edit_person/:id' do
#   sql =
#   @person = run_sql(sql).first
# end



# creates an new person and assigns
get '/create_person' do
  erb :create_person
end

# posts the person back to people
post '/create_person' do
  name = params[:name]
  occupation = params[:occupation]
  sql = "insert into person (name, occupation) values ('#{name}', '#{occupation}')"
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

get '/movies/:id' do
  movie = Movie.find(params[:id])
  movie.release_date = params[:release_date]
  movie.director = params[:director]



  movie_name = params[:movie_name]
  release_date = params[:release_date]
  director = params[:director]
  sql =  "select * from movies where id = #{'id'}"
  @movie = run_sql(sql).first
  erb :movie
end

# creates an new person and assigns
get '/create_movie' do
  erb :create_movie
end

# posts the person back to people
post '/create_movie' do
  id = params[:id]
  movie_name = params[:movie_name]
  release_date = params[:release_date]
  director = params[:director]
  sql = "insert into person (movie_name, release_date, director) values ('#{movie_name}', #{release_date}, '#{director}')"
end


