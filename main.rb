require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'


# Run SQL commands
 def run_sql(sql)
  db = PG.connect(:dbname => 'movies', :host => 'localhost')
  result = db.exec(sql)
  db.close
  result
  end

#see list of all todos
get '/todos' do
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql)
  erb :todos
end

#see individual todo
get '/todos/:id' do
  id = params[:id]
  task_name = params[:task_name]
  description = params[:description]
  movie_id = params[:movie_id]
  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @todo = run_sql(sql).first
  erb :todo
end

#add a new todo
get '/todos/new' do
  sql = "SELECT id, movie_name FROM movies"
  @movies = run_sql(sql)
  erb :new_todo
end

#post new todo to database
post '/todos/new' do
  id = params[:id]
  task_name = params[:task_name]
  description = params[:description]
  movie_id = params[:movie_id]
  sql = "INSERT INTO tasks (task_name, description, movie_id) VALUES ('#{task_name}', '#{description}','#{movie_id}');"
  run_sql(sql)
  redirect to '/todos'
end


#see list of all movies
get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  erb :movies
end

#get/create new movie
get '/movies/new' do
  erb :new_movie
end

#post new movie to the database
post '/movies/new' do
  id = params[:id]
  movie_name = params[:movie_name]
  release = params[:release]
  director = params[:director]
  sql = "INSERT INTO movies (movie_name, release, director) VALUES ('#{movie_name}',#{release},'#{director}')"
  run_sql(sql)
  redirect to '/movies'
end


#see individual movie
get '/movies/:id' do
  id = params[:id]
  movie_name = params[:movie_name]
  release = params[:release]
  director = params[:director]
  sql = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql).first
  erb :movie
end

#see list of all people
get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :people
end

#create new person
get '/people/new' do
  sql = "SELECT id, movie_name FROM movies"
  @movies = run_sql(sql)
  sql = "SELECT id, task_name FROM tasks"
  @todos = run_sql(sql)
  erb :new_person
end

#post new person to database
post '/people/new' do
  id = params[:id]
  person = params[:person]
  movie_id = params[:movie_id]
  task_id = params[:task_id]
  sql = "INSERT INTO people (person, movie_id, task_id) VALUES ('#{person}', '#{movie_id}','#{task_id}');"
  run_sql(sql)
  redirect to '/people'
end

