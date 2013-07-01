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

# index page
get '/' do
  redirect to '/movies'
end

get '/movies' do
end

