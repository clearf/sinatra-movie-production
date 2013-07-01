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

# this provides you with the index page and will rever
get '/' do
  erb :index
end

#       #
# Tasks #
#       #

# gets all the tasks

get '/todos' do

erb :todos
end

# gives each individual task

get '/:id/todo' do

erb :todo
end

# create and assign new todos
get '/create_todo' do

  erb :create_todo
end

# posts the task back to
post '/create_todo' do
  task = params[:task]
  task_description = params[:task_description]
  sql = "INSERT INTO todo (task, task_description, person_id, movie_id) VALUES ('#{task}','#{task_description}', #{person_id}, #{movie_id});"
  @todos = run_sql(sql)
  erb :todos
end




#         #
# People  #
#         #

# get all the people

get'/people' do

  erb :people
end

# get each individual person

get'/person' do

  erb :person
end

# creates an new person and assigns
get '/create_person' do

  erb :create_person
end

#posts the person back to people
post '/create_person' do

  erb :people
end

get '/people/:id/edit/' do

end


#        #
# Movies #
#        #


get'/movies/' do

end

