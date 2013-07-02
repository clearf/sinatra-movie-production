require 'pg'
require 'imdb'
require 'sinatra'
require 'sinatra/reloader' if development?

#Begin Homework
# This helps us run SQL commands
 def run_sql(sql)
  db = PG.connect(:dbname => 'movies', :host => 'localhost')
  result = db.exec(sql)
  db.close
  result
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
  sql = "SELECT * FROM tasks"
  @todos = run_sql(sql)

  erb :todos
end

#form for new tasks (todo)
get '/todos/new' do

  people_sql = "SELECT * FROM people"
  movies_sql = "SELECT * FROM movies"

  @movies = run_sql(movies_sql)
  @people = run_sql(people_sql)

  erb :new_todo
end

#Add new tasks
post '/todos' do

  task = params[:task]
  details = params[:details]
  due = params[:due]
  person_id = params[:person_id]
  movie_id = params[:movie_id]

  sql = "INSERT INTO tasks (task, details, due, person_id, movie_id) VALUES ('#{task}', '#{details}', '#{due}', #{person_id}, #{movie_id})"
  run_sql(sql)

  redirect to('todos')
end

#GET individual info on todos
get '/todos/:id' do

  id = params[:id]
  person_id = [:person_id]
  movie_id = [:movie_id]

  #GET todo info from db
  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @todo = run_sql(sql)[0]

  #GET person for assigned todo
  person_sql = "SELECT * FROM people WHERE id = #{@todo['person_id']}"
  @person = run_sql(person_sql)[0]

  #GET movie for assigned todo
  movie_sql = "SELECT * FROM movies WHERE id = #{@todo['movie_id']}"
  @movie = run_sql(movie_sql)[0]

  erb :todo
end
#Deleting tasks with their ID's
get '/todos/:id/delete' do
  id = params[:id]

  sql = "DELETE FROM tasks WHERE id = #{id}"
  run_sql(sql)

  redirect to('/todos')
end

#Edit todo's
get '/todos/:id/edit' do

  id = params[:id]
  person_id = params[:person_id]
  movie_id = params[:movies_id]


  sql = "SELECT * FROM tasks WHERE id = #{id}"
  people_sql = "SELECT * FROM people"
  movies_sql = "SELECT * FROM movies"

  #Got my instance variables
  @todo = run_sql(sql)[0]
  @people = run_sql(people_sql)
  @movies = run_sql(movies_sql)

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

  sql = "INSERT INTO people (name, email) VALUES ('#{name}','#{email}')"
  run_sql(sql)

  redirect to('/people')
end
