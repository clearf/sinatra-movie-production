require 'sinatra'
require 'sinatra/reloader'
require 'pg'

helpers do
  def run_sql(sql)
    db = PG.connect(:dbname => 'Homework',
                    :host => 'localhost',
                    :user => 'postgres',
                    :password => 'postgres')
    result = db.exec(sql)
    db.close
    result
  end
end

#shows root page
get '/' do
   erb :index
end


#displays all tasks
get '/tasks' do
  sql = "select * from tasks"
  @tasks = run_sql(sql)

  erb :tasks
end

get '/tasks/:id' do
  @id = params[:id]
  erb :task
end

get '/movies' do
  erb :movies

end

get '/movies/:id' do
  @id = params[:id]
  erb :movie
end


get '/people' do
   erb :people
end

get '/people/:id' do
  @id = params[:id]
  erb :person
end

