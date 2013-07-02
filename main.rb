require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

helpers do
  def run_sql(sql_input)
    db = PG.connect(:dbname => 'movie_production', :host => 'localhost')
    result = db.exec(sql_input)
    db.close
    result
  end
end

get '/' do
  erb :index
end

# This should list movies
get '/movies' do
  sql_input = "SELECT * FROM movies"
  @movies = run_sql(sql_input)
  erb :movies
end

# This should add a new movie
get '/movies/new' do
  erb :new_movie
end

# This should send a post request to this url
post '/movies/new' do
  movie_name = params[:movie_name]
  release_date = params[:release_date]
  sql_input = "INSERT INTO movies (movie_name, release_date) VALUES ('#{movie_name}', '#{release_date}')"
  run_sql(sql_input)
  redirect to('/movies')
end

# This should show details of a single movie
get '/movies/:id' do
  id = params[:id]
  sql_input = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql_input).first
  erb :movie
end

# This should edit a movie
get '/movies/:id/edit' do
  id = params[:id]
  sql_input = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql_input).first
  erb :edit_movie
end

post '/movies/:id/edit' do
  id = params[:id]
  movie_name = params[:movie_name]
  release_date = params[:release_date]
  sql_input = "UPDATE movies SET (movie_name, release_date) = ('#{movie_name}', '#{release_date}') WHERE id = #{id}"
  run_sql(sql_input)
  redirect to('/movies')
end

# This should list people
get '/people' do
  sql_input = "SELECT * FROM people"
  @people = run_sql(sql_input)
  erb :people
end

# This should add a new person. This also makes movie names available to assign a new person to.
get '/people/new' do
  sql_input = "SELECT id, movie_name FROM movies"
  @movies = run_sql(sql_input)
  erb :new_person
end

# This should send a post request to the url
post '/people/new' do
  person_name = params[:person_name]
  director = params[:director]
  if director == "yes"
    director = true
  else
    director = false
  end
  movie_id = params[:movie_id]
  sql_input = "INSERT INTO people (person_name, director, movie_id) VALUES ('#{person_name}', #{director}, #{movie_id})"
  run_sql(sql_input)
  redirect to('/people')
end

# This should show details of a single person
get '/people/:id' do
  id = params[:id]
  sql_input = "SELECT * FROM people WHERE id = #{id}"
  @person = run_sql(sql_input).first
  second_sql_input = "SELECT * FROM movies WHERE id = #{@person['movie_id']}"
  @movie = run_sql(second_sql_input).first
  erb :person
end

# This should edit a person
get '/people/:id/edit' do
  id = params[:id]
  sql_input = "SELECT * FROM people WHERE id = #{id}"
  @person = run_sql(sql_input).first
  second_sql_input = "SELECT id, movie_name FROM movies"
  @movies = run_sql(second_sql_input)
  erb :edit_person
end

# This should send a post request to the url
post '/people/:id/edit' do
  id = params[:id]
  person_name = params[:person_name]
  director = params[:director]
  if director == "yes"
    director = true
  else
    director = false
  end
  movie_id = params[:movie_id]
  sql_input = "UPDATE people SET (person_name, director, movie_id) = ('#{person_name}', #{director}, #{movie_id}) WHERE id = #{id}"
  run_sql(sql_input)
  redirect to('/people')
end

# This should list tasks
get '/tasks' do
  sql_input = "SELECT * FROM tasks"
  @tasks = run_sql(sql_input)
  erb :todos
end

# This should add a new task
get '/tasks/new' do
  sql_input = "SELECT id, person_name FROM people"
  @people = run_sql(sql_input)
  second_sql_input = "SELECT id, movie_name FROM movies"
  @movies = run_sql(second_sql_input)
  erb :new_todo
end

# This should send a post request to the url
post '/tasks/new' do
  task_name = params[:task_name]
  description = params[:description]
  person_id = params[:person_id]
  movie_id = params[:movie_id]
  sql_input = "INSERT INTO tasks (task_name, description, person_id, movie_id) VALUES ('#{task_name}', '#{description}', #{person_id}, #{movie_id})"
  run_sql(sql_input)
  redirect to('/tasks')
end

# This should list a single task
get '/tasks/:id' do
  id = params[:id]
  sql_input = "SELECT * FROM tasks WHERE id = #{id}"
  @task = run_sql(sql_input).first
  second_sql_input = "SELECT * FROM movies WHERE id = #{@task['movie_id']}"
  @movie = run_sql(second_sql_input).first
  third_sql_input = "SELECT * FROM people WHERE id = #{@task['person_id']}"
  @person = run_sql(third_sql_input).first
  erb :todo
end



