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

# displays input form to add new people
get '/people/new' do
  erb :new_person
end

# posts form info to database
post '/people/new' do
  name = params[:name]
  sql = "INSERT INTO people (name) VALUES ('#{name}')"
  run_sql(sql)
  redirect to('/people')