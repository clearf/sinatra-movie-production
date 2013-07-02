require 'pg'
require 'imdb'
require 'sinatra'
require 'sinatra/reloader' if development?

#Begin Homework
helpers do
  # This helps us run SQL commands
   def run_sql(sql)
    db = PG.connect(:dbname => 'movies', :host => 'localhost')
    result = db.exec(sql)
    db.close
    result
    end
end

#Routing
get '/' do
  erb :index
end

get '/home' do
  redirect to('/')
end

get '/people' do
end
