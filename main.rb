 require 'rubygems'
 require 'pry'
 require 'sinatra'
 require 'sinatra/reloader' if development?
 require 'pg'

helpers do
  def run_sql(sql)
    db = PG.connect(:dbname => 'movie_production', :host => 'localhost')
    result = db.exec(sql)
    db.close
    result
  end
end

#root
get '/' do
  erb :index
end

#list all people
get '/people' do
  sql = "SELECT * FROM people"
  @people = run_sql(sql)
  erb :people
end

