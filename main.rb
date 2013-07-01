require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'

helpers do
  def run_sql(sql)
    db = PG.connect(dbname: 'movies', host: 'localhost')
    result = db.exec(sql)
    db.close
    result
  end
end

get '/' do
  erb :index
end

get '/movies' do
  sql = "SELECT * FROM movies"
  @movies = run_sql(sql)
  erb :movies
end

get '/movies/:id' do
  id = params[:id]
  sql = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql)
  erb :movie
end

get '/new_movie' do
  erb :new_movie
end

post '/new_movie' do
  title = params[:title]
  release_date = params[:release_date]
  sql = "INSERT INTO movies (title, release_date) VALUES ('#{title}', #{release_date});"
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
  @person = run_sql(sql)
  erb :person
end

get '/new_person' do
  erb :new_person
end

post '/new_person' do
  name = params[:name]
  description = params[:description]
  sql = "INSERT INTO people (name) VALUES ('#{name}');"
  run_sql(sql)
  redirect to('/people')
end

get '/todos' do
  sql = "SELECT * FROM tasks"
  @tasks = run_sql(sql)
  erb :todos
end

get '/todos/:id' do
  id = params[:id]
  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @task = run_sql(sql)
  erb :todo
end

get '/new_todo' do
  erb :new_todo
end

post '/new_todo' do
  name = params[:name]
  description = params[:description]
  sql = "INSERT INTO tasks (name, description) VALUES ('#{name}', '#{description}');"
  run_sql(sql)
  redirect to('/todos')
end