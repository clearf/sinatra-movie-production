require 'pry'
require 'sinatra'
require 'sinatra/reloader'

helpers do
  def run_sql(sql)
    db = PG.connect(dbname: 'movie_production', host: 'localhost')
    result = db.exec(sql)
    db.close
    result
  end
end

# this provides you with the index page
get '/' do
  erb :index
end
# Todo Tasks

# create and assign new todos

get '/create_todo' do
  erb :create_todo
end

post '/create_todo' do

end


# People



# Movies