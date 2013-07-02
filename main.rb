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
get '/movie/:id' do
  id = params[:id]
  sql = "select * from movies where id = #{id}"
  @movie = run_sql(sql).first
  erb :movie
end

# page with list of people
get '/people' do
  sql = 'select * from people'
  @people = run_sql(sql)
  erb :people
end

# individual person page
get '/person/:id' do
  id = params[:id]
  sql = "select * from people where id = #{id}"
  @person = run_sql(sql).first
  erb :person
end

# page with all tasks - may be changed once flow is determined
get '/tasks' do
  erb :todos
end

# individual task page - may be changed once flow is determined
get '/tasks/:id' do
  erb :todo
end