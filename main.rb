 require 'rubygems'
 require 'pry'
 require 'sinatra'
 require 'sinatra/reloader' if development?
 require 'pg'

helpers do
  def run_sql(sql)
    db = PG.connect(:dbname => 'movie_production', :host => 'localhost')
    result = db.exec(sql)
    erb :people
  end
end

#root
get '/' do
  erb :index
end

#show all people
