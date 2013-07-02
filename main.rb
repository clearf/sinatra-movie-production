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
  sql = "select * from tasks"
  @tasks = run_sql(sql)

  sql = "select * from movies"
  @movies = run_sql(sql)


  sql = "select * from people"
  @people = run_sql(sql)

  erb :tasks
end

#shows form to add a new movie
get '/movies/new' do
  erb :new_movie
end

#adds a new movie
post '/movies/new' do
  @name = params[:name]
  @title = params[:title]
  @release_date = params[:release_date]
  @director = params[:director]
  sql = "insert into movies (name,title,release_date,director) values ('#{@name}','#{@title}','#{@release_date}', '#{@director}')"
  run_sql(sql)
  redirect to '/'
end

#shows form to edit movie
get '/movies/:id/edit' do
  @id = params[:id]
  @name = params[:name]
  @title = params[:title]
  @release_date = params[:release_date]
  @director = params[:director]
  sql = "select * from movies where id = #{@id}"
  @movie = run_sql(sql).first
  erb :movie_edit
end

#this edits the movie
post '/movies/:id/edit' do
  @id = params[:id]
  @name = params[:name]
  @title = params[:title]
  @release_date = params[:release_date]
  @director = params[:director]
  sql = "update movies set (name,title,release_date,director) = ('#{@name}', '#{@title}', '#{@release_date}', '#{@director}') where id = #{@id}"
  run_sql(sql)
  redirect to "/"
end

#shows form to add a new person
get '/people/new' do
  erb :new_person
end

#adds a new person
post '/people/new' do
  @name = params[:name]
  @title = params[:title]
  sql = "insert into people (name,title) values ('#{@name}', '#{@title}')"
  run_sql(sql)
  redirect to '/'
end

#shows form to edit person
get '/people/:id/edit' do
  @id = params[:id]
  @name = params[:name]
  @title = params[:title]
  sql = "select * from people where id = #{@id}"
  @person = run_sql(sql).first
  erb :person_edit
end

#this edits the person
post '/people/:id/edit' do
  @id = params[:id]
  @name = params[:name]
  @title = params[:title]
  sql = "update people set (name,title) = ('#{@name}', '#{@title}') where id = #{@id}"
  run_sql(sql)
  redirect to "/"
end

#shows the form to add a new task
get '/tasks/new' do
  sql = "select id, name from people"
  @people = run_sql(sql)
  sql = "select id, name from movies"
  @movies = run_sql(sql)
  erb :new_task
end

#adds a new task
post '/tasks/new' do
  @name = params[:name]
  @description = params[:description]
  @person_id = params[:person_id]
  @movie_id = params[:movie_id]
  sql = "insert into tasks (name,description,person_id,movie_id) values ('#{@name}', '#{@description}','#{@person_id}','#{@movie_id}')"
  @tasks = run_sql(sql)
  redirect to '/'
end

#shows form to edit task
get '/tasks/:id/edit' do
  @id = params[:id]
  @name = params[:name]
  @description = params[:description]
  @person_id = params[:person_id]
  @movie_id = params[:movie_id]
  sql = "select * from tasks where id = #{@id}"
  @task = run_sql(sql).first
  sql = "select * from movies"
  @movies = run_sql(sql)
  sql = "select * from people"
  @people = run_sql(sql)

  erb :task_edit
end

#this edits the task
###########It changes everythign in the database except people and movie id!!!!!!!!!XXXXXXXXXXXXXXXXXX
post '/tasks/:id/edit' do
  @id = params[:id]
  @name = params[:name]
  @description = params[:description]
  @person_id = params[:person_id]
  @movie_id = params[:movie_id]
  sql = "update tasks set (name,description,person_id,movie_id) = ('#{@name}', '#{@description}','#{@person_id}','#{@movie_id}') where id = #{@id}"
  run_sql(sql)
  redirect to "/"
end



#displays all tasks
get '/tasks' do
  sql = "select * from tasks"
  @tasks = run_sql(sql)

  erb :tasks
end

#shows individual task
get '/tasks/:id' do
  @id = params[:id]
  sql = "select * from tasks where id = '#{@id}'"
  @task = run_sql(sql).first
  erb :task
end

#shows all the movies
get '/movies' do
  sql = "select * from movies"
  @movies = run_sql(sql)
  erb :movies
end

#shows individual movie
get '/movies/:id' do
  @id = params[:id]
  sql = "select * from movies where id = '#{@id}'"
  @movie = run_sql(sql).first
  erb :movie
end

#shows all the peoples
get '/people' do
  sql = "select * from people"
  @people = run_sql(sql)
   erb :people
end

#shows individual person
get '/people/:id' do
  @id = params[:id]
  sql = "select * from people where id = '#{@id}'"
  @person = run_sql(sql).first
  erb :person
end

