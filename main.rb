require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?

# function to run sql commands with less repetition
helpers do
  def run_sql(sql)
    db = PG.connect(dbname: 'production', host: 'localhost')
    result = db.exec(sql)
    db.close
    result
  end
end

# index page - immediately redirects to list of movies
get '/' do
  redirect to '/movies'
end

# page with list of movies - basically index page
get '/movies' do
  sql = 'select * from movies'
  @movies = run_sql(sql)
  erb :movies
end

# individual movie page
get '/movies/:id' do
  id = params[:id]
  sql_movie = "select * from movies where id = #{id}"
  @movie = run_sql(sql_movie).first
  sql_tasks = "select * from tasks where movie = #{id}"
  @tasks = run_sql(sql_tasks)
  erb :movie
end

get '/add_movie' do
  erb :add_movie
end

post '/add_movie' do
  name = params[:name]
  director = params[:director]
  release_date = params[:release_date]
  sql = "insert into movies (name, director, release_date) values ('#{name}', '#{director}', #{release_date})"
  run_sql(sql)
  redirect to '/movies'
end

# page with list of people
get '/people' do
  sql = 'select * from people'
  @people = run_sql(sql)
  erb :people
end

# individual person page
get '/people/:id' do
  id = params[:id]
  sql_person = "select * from people where id = #{id}"
  @person = run_sql(sql_person).first
  sql_tasks = "select * from tasks where person = #{id}"
  @tasks = run_sql(sql_tasks)
  erb :person
end

get '/add_person' do
  erb :add_person
end

post '/add_person' do
  name = params[:name]
  sql = "insert into people (name) values ('#{name}')"
  run_sql(sql)
  redirect to '/people'
end

# page with all tasks - may be changed once flow is determined
get '/tasks' do
  erb :todos
end

# individual task page - may be changed once flow is determined
get '/task/:id' do
  id = params[:id]
  erb :todo
end