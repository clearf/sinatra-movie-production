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

#Tasks - People - Movies

#ToDo's take priority. People and movies can be assigned to them.
#Urgency is priority.
get '/todos' do
  sql = "SELECT * FROM TASKS"
  @todos = run_sql(sql)

  erb :todos
end

#Add new tasks
post '/todos' do

  urgent = params[:urgent]
  unless urgent.nil
    urgent = true
  end

  task = params[:task]
  details = params[:details]
  due = params[:due]
  urgent = params[:urgent]
  person_id = params[:person_id]
  movie_id = params[:movie_id]

#pulling todos
  sql = "INSERT INTO tasks (task, details, due, urgent, person_id, movie_id) VALUES ('#{task}', '#{due}', '#{details}', #{urgent}, #{person_id}, #{movie_id})"
  run_sql(sql)

  redirect to('todos')
end
