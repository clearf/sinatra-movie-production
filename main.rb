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
end

# individual movie page
get '/movies/:id' do
end

# page with list of people
get '/people' do
end

# individual person page
get 'people/:id' do
end

# page with all tasks - may be changed once flow is determined
get '/tasks' do
end

# individual task page - may be changed once flow is determined
get '/tasks/:id' do
end