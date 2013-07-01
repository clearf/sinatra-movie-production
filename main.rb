require 'pg'
require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?

helpers do
  def sql_query(sql)
    db = PG.connect(:dbname => 'movie_production', :host => 'localhost')
    query_result = db.exec(sql)
    db.close
    query_result
  end
end

get '/' do
  erb :index
end

get '/tasks' do
  sql = "select * from tasks"
  @tasks = sql_query(sql)
  erb :tasks
end

get '/new_task' do
  erb :new_task
end

get '/new_person' do
  erb :new_person
end

post '/new_person' do
  sql = "INSERT INTO people (name) VALUES ('#{params[:name]}')"
  sql_query(sql)
  redirect to '/'
end

get '/new_movie' do
  sql = "SELECT id, name FROM people"
  @people = sql_query(sql)
  erb :new_movie
end

post '/new_movie' do
  sql = "INSERT INTO movies (name, release_date, person_id) VALUES ('#{params[:name]}', '#{params[:release_date]}', #{params[:person_id]})"
  sql_query(sql)
  redirect to '/'
end