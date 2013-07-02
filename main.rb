require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?

helpers do
  def run_sql(sql)
    db = PG.connect(dbname: 'movie_production', host: 'localhost')
    result = db.exec(sql)
    db.close
    result
  end
end

# Tasks Section

get '/' do
  sql = "SELECT * FROM tasks;"
  @tasks = run_sql(sql)

  erb :todos
end

get '/new_todo' do
  sql = "SELECT id, name FROM movies"
  @movies = run_sql(sql)

  sql = "SELECT id, name FROM people"
  @people = run_sql(sql)

  erb :new_todo
end

post '/new_todo' do
  errand = params[:errand]
  description = params[:description]
  person = params[:person]
  movie = params[:movie]

  sql = "INSERT INTO tasks (errand, description, person, movie)
          VALUES ('#{errand}', '#{description}', #{person}, #{movie});"
  run_sql(sql)

  redirect to('/')
end

get '/todo/:id' do
  id = params[:id]
  sql = "SELECT * FROM tasks WHERE id = #{id};"
  @task = run_sql(sql).first

  sql = "SELECT * FROM movies WHERE id = #{@task['movie']};"
  @movie_name = run_sql(sql).first

  sql = "SELECT * FROM people WHERE id = #{@task['person']};"
  @person_name = run_sql(sql).first

  erb :todo
end

# Movies Section

get '/new_movie' do
  erb :new_movie
end

post '/new_movie' do
  name = params[:name]
  release_date = params[:releasedate]
  director = params[:director]

  sql = "INSERT INTO movies (name, releasedate, director)
          VALUES ('#{name}', '#{release_date}', '#{director}');"
  run_sql(sql)

  redirect to('/movies')
end

get '/movies' do
  sql = "SELECT * from movies;"
  @movies = run_sql(sql)

  erb :movies
end

get '/movie/:id' do
  id = params[:id]
  sql = "SELECT * FROM movies WHERE id = #{id};"
  @movie = run_sql(sql)

  sql = "SELECT * FROM tasks WHERE id = #{movie};"
  @tasks_of_movie = run_sql(sql)

  erb :movie
end

# People Section

get '/people' do
  sql = "SELECT * from people;"
  @people = run_sql(sql)

  erb :people
end