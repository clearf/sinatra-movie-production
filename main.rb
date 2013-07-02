require 'pg'
require 'sinatra'
require 'sinatra/reloader'

helpers do
  # This helps us run SQL commands
  def run_sql(sql)
    db = PG.connect(dbname: 'movie_manager', host: 'localhost')
    result = db.exec(sql)
    db.close
    return result
  end
end

get '/' do
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql)

  sql = "SELECT id, name FROM people"
  @people = run_sql(sql)

  sql = "SELECT id, title FROM movies"
  @movies = run_sql(sql)

  erb :tasks
end

get '/tasks/:id' do
  id = params[:id]

  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @task = run_sql(sql).first

  sql = "SELECT name FROM people WHERE id = #{@task['person_id']}"
  @person = run_sql(sql).first

  sql = "SELECT title FROM movies WHERE id = #{@task['movie_id']}"
  @movie = run_sql(sql).first

  erb :task
end

post '/new_task' do
  task = params[:task]
  description = params[:description]
  person_id = params[:person_id]
  movie_id = params[:movie_id]

  sql = "INSERT INTO tasks (task, description, person_id, movie_id) VALUES ('#{task}', '#{description}', #{person_id}, #{movie_id})"
  run_sql(sql)

  redirect to('/')
end

get '/edit_task/:id' do
  id = params[:id]

  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @task = run_sql(sql).first

  sql = "SELECT id, name FROM people"
  @people = run_sql(sql)

  sql = "SELECT id, title FROM movies"
  @movies = run_sql(sql)

  erb :edit_task
end

post '/edit_task/:id' do
  id = params['id']
  task = params['task']
  description = params['description']
  person_id = params['person_id']
  movie_id = params['movie_id']

  completed = false
  if params['completed'].chomp == 'y'
    completed = true
  end

  sql = "UPDATE tasks SET (task, description, person_id, movie_id, completed) = ('#{task}', '#{description}', #{person_id}, #{movie_id}, #{completed}) WHERE id = #{id}"
  run_sql(sql)

  redirect to('/')
end

post '/delete_task/:id' do
  id = params[:id]
  sql = "DELETE FROM tasks WHERE id = #{id}"
  run_sql(sql)

  redirect to('/')
end

get '/movies' do
  sql = "SELECT id, name FROM people"
  @people = run_sql(sql)

  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)

  erb :movies
end

post '/new_movie' do
  title = params[:title]
  director_id = params[:director_id]
  year = params[:year]
  image = params[:image]

  sql = "INSERT INTO movies (title, director_id, year, image) VALUES ('#{title}', '#{director_id}', '#{year}', '#{image}')"
  run_sql(sql)

  redirect to('/movies')
end

get '/movies/:id' do
  id = params[:id]

  sql = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql).first

  sql = "SELECT name FROM people WHERE id = #{@movie['director_id']}"
  @director = run_sql(sql).first

  erb :movie
end

get '/edit_movie/:id' do
  id = params[:id]

  sql = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql).first

  sql = "SELECT id, name FROM people"
  @people = run_sql(sql)

  erb :edit_movie
end

post '/edit_movie/:id' do
  id = params[:id]
  title = params[:title]
  director_id = params['director_id']
  year = params['year']
  image = params['image']

  sql = "UPDATE movies SET (title, director_id, year, image) = ('#{title}', '#{director_id}', '#{year}', '#{image}') WHERE id = #{id}"
  run_sql(sql)

  redirect to('/movies')
end

get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)

  erb :people
end

get '/people/:id' do
  id = params[:id]

  sql = "SELECT * FROM people WHERE id = #{id}"
  @person = run_sql(sql).first

  erb :person
end

post '/new_person' do
  name = params[:name]
  title = params[:title]
  phone = params[:phone]

  sql = "INSERT INTO people (name, title, phone) VALUES ('#{name}', '#{title}', '#{phone}')"
  run_sql(sql)

  redirect to('/people')
end

get '/edit_person/:id' do
  id = params[:id]

  sql = "SELECT * FROM people WHERE id = #{id}"
  @person = run_sql(sql).first

  erb :edit_person
end

post '/edit_person/:id' do
  id = params['id']
  name = params['name']
  title = params['title']
  phone = params['phone']

  sql = "UPDATE people SET (name, title, phone) = ('#{name}', '#{title}', '#{phone}') WHERE id = #{id}"
  run_sql(sql)

  redirect to('/people')
end






