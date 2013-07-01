require 'pg'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry'

helpers do
  def run_sql(sql)
    db = PG.connect(dbname: 'production', host:'localhost')
    result = db.exec(sql)
    db.close
    result
  end
end

#Show list of tasks
get '/tasks' do
  sql = "SELECT * from tasks"
  @tasks = run_sql(sql)
  erb :tasks
end

#Add new task
get '/tasks/new' do
  sql = "SELECT id, name FROM movies"
  @movies = run_sql(sql)
  sql2 = "SELECT id, name FROM contacts"
  @contacts = run_sql(sql2)
  erb :new_task
end

post '/tasks/new' do
  name = params[:name]
  descriptions = params[:descriptions]
  movie_id = params[:movie_id]
  contact_id = params[:contact_id]
  sql = "INSERT INTO tasks (name, descriptions, movie_id, contact_id) VALUES ('#{name}', '#{descriptions}',#{movie_id}, #{contact_id});"
  run_sql(sql)
  redirect to '/tasks'
end

#Show task detail
get '/tasks/:id' do
  id = params[:id]
  sql = "SELECT * from tasks WHERE id = #{id}"
  @task = run_sql(sql).first
  erb :task
end

#Edit task
get '/tasks/:id/edit' do
  id = params[:id]
  sql = "SELECT * FROM tasks WHERE id = #{id}"
  @task = run_sql(sql).first
  erb :edittask #fix this
end

#Delete task
post '/tasks/:id/delete' do
  id = params[:id]
  sql = "DELETE FROM tasks where id = #{id}"
  run_sql(sql)
  redirect to "/tasks"
end

#Show list of movies
get '/movies' do
  sql = "SELECT * from movies"
  @movies = run_sql(sql)
  erb :movies
end

#Add new movie
get '/movies/new' do
  erb :new_movie
end

post '/movies/new' do
  name = params[:name]
  release_date = params[:release_date]
  director = params[:director]
  sql = "INSERT INTO movies (name, release_date, director) VALUES ('#{name}', '#{release_date}', '#{director}');"
  run_sql(sql)
  redirect to '/movies'
end

#View movie detail
get '/movies/:id' do
  id = params[:id]
  sql = "SELECT * FROM movies WHERE id = #{id}"
  @movie = run_sql(sql).first
  erb :movie
end

#Delete Movie
post '/movies/:id/delete' do
  id = params[:id]
  sql = "DELETE FROM movies WHERE id = #{id}"
  run_sql(sql)
  redirect to '/movies'
end


#Show list of contacts
get '/contacts' do
  sql = "SELECT * from contacts"
  @contacts = run_sql(sql)
  erb :contacts
end

# Add new contact
get '/contacts/new' do
  erb :new_contact
end

post '/contacts/new' do
  name = params[:name]
  sql = "INSERT INTO contacts (name) VALUES ('#{name}')"
  run_sql(sql)
  redirect to '/contacts'
end

# Show contact detail
get '/contacts/:id' do
  id = params[:id]
  sql = "SELECT * FROM contacts where id = #{id}"
  @contact = run_sql(sql).first
  erb :contact
end

# Delete contacts
post '/contacts/:id/delete' do
  id = params[:id]
  sql = "DELETE FROM contacts where id = #{id}"
  run_sql(sql)
  redirect to '/contacts'
end

#Edit task
#Edit movie
#Edit contact