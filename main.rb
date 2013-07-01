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