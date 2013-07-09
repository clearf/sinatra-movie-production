require 'pry'
require 'sinatra'
require 'pg'
require 'sinatra/reloader' if development?

helpers do
  def run_sql(sql)
    db = PG.connect(:dbname => 'movie_production', :host => 'localhost')
    result = db.exec(sql)
    db.close
    result
  end
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
  sql = "select * from todo"
  @todos = run_sql(sql)
erb :todos
end

# gives each individual task

get '/todo/:id' do
  id = params[:id]
  sql = "select * from todo where id = #{id}"
  @todo = run_sql(sql).first
erb :todo
end

# goes to the edit task
get '/todo/:id/edit' do
  id = params[:id]
  sql = "select * from todo where id = #{id}"
  @todo = run_sql(sql).first
  sql1 = "select * from people where id = #{id}"
  @people = run_sql(sql1).first
  sql2 = "select * from movies where id = #{id}"
  @movies = run_sql(sql2).first


erb :edit_todo
end

# posts the update back
post '/todo/:id/' do
  sql = "update people set (task, task_description, person_id, movie_id) = ('#{task}', '#{task_description}', #{person_id}, #{movie_id}) WHERE id = #{id}"
  @todos =run_sql(sql)
end


# create and assign new todo
get '/create_todo' do
  sql = "select id, name from people"
  @people = run_sql(sql)
  sql = "select id, movie_name from movies"
  @movies = run_sql(sql)
  redirect to '/todos'
  erb :create_todo
end

# posts the task back to
post '/create_todo' do
  task = params[:task]
  task_description = params[:task_description]
  sql = "INSERT INTO todo (task, task_description, person_id, movie_id) VALUES ('#{task}','#{task_description}', #{person_id}, #{movie_id});"
  @todos = run_sql(sql)
  redirect to '/'
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


get '/person/:id' do
  id = params[:id]
  sql = "select * from people where id = #{id}"
  @person = run_sql(sql).first
erb :person
end


 # gives you the person information to edit
 get '/person/:id/edit' do
  sql = "select * from people where id = #{id}"
  @person = run_sql(sql).first
 end

#  posts the edits back to person
post '/person/:id' do
  sql = "update people set (name, occupation) = ('#{name}', '#{occupation}') WHERE id = #{id}"
  @person = run_sql(sql).first
end



# creates an new person and assigns
get '/create_person' do
  redirect to '/people'
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
  redirect to '/movie'
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

get '/movie/:id/edit' do

erb :edit_movie
end
#updates movie entry and redirects back
post '/movie/:id' do
  id = params[:id]
  @movie_name = params[:movie_name]
  @release_date = params[:release_date]
  @director = params[:director]
  sql = "update movies set (movie_name, release_date, director) values ('#{movie_name}', #{release_date}, '#{director}') WHERE id = #{id}"
  @person = run_sql(sql).first
end



