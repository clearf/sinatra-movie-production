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

# index page - immediately redirects to list of movies
get '/' do
  redirect to '/movies'
end

# page with list of movies - basically index page
get '/movies' do
  sql = 'select * from movies'
  @movies = run_sql(sql)
  erb :movies
end

# individual movie page
get '/movies/:id' do
  id = params[:id]
  sql_movie = "select * from movies where id = #{id}"
  @movie = run_sql(sql_movie).first
  sql_tasks = "select * from tasks where movie = #{id}"
  @tasks = run_sql(sql_tasks)
  erb :movie
end

# page for adding a new person to the database
get '/add_movie' do
  erb :add_movie
end

# adds a new movie to the database once form is filled out
post '/add_movie' do
  name = params[:name]
  director = params[:director]
  release_date = params[:release_date]
  sql = "insert into movies (name, director, release_date) values ('#{name}', '#{director}', #{release_date})"
  run_sql(sql)
  redirect to '/movies'
end

# page for editing a specific movie
get '/movies/:id/edit' do
  @id = params[:id]
  sql = "select * from movies where id = #{@id}"
  @movie = run_sql(sql).first
  erb :edit_movie
end

# edits specific movie once form is filled out
post '/movies/:id/edit' do
  name = params[:name]
  director = params[:director]
  release_date = params[:release_date]
  id = params[:id]
  sql = "update movies set name='#{name}', director='#{director}', release_date=#{release_date} where id = #{id}"
  run_sql(sql)
  redirect to "/movies/#{id}"
end

# page for deleting a specific movie
get '/movies/:id/delete' do
  @id = params[:id]
  sql_movie = "select * from movies where id = #{@id}"
  @movie = run_sql(sql_movie).first
  sql_tasks = "select * from tasks where movie = #{@id}"
  @tasks = run_sql(sql_tasks)
  erb :delete_movie
end

# deletes specific movie once form is filled out
post '/movies/:id/delete' do
  id = params[:id]
  sql_tasks = "delete from tasks where movie = #{id}"
  run_sql(sql_tasks)
  sql_movie = "delete from movies where id = #{id}"
  run_sql(sql_movie)
  redirect to "/movies"
end

# page with list of people
get '/people' do
  sql = 'select * from people'
  @people = run_sql(sql)
  erb :people
end

# individual person page
get '/people/:id' do
  id = params[:id]
  sql_person = "select * from people where id = #{id}"
  @person = run_sql(sql_person).first
  sql_tasks = "select * from tasks where person = #{id}"
  @tasks = run_sql(sql_tasks)
  erb :person
end

# page for adding a new person to the database
get '/add_person' do
  erb :add_person
end

# adds a new person to the database once form is filled out
post '/add_person' do
  name = params[:name]
  sql = "insert into people (name) values ('#{name}')"
  run_sql(sql)
  redirect to '/people'
end

# page for editing a specific person
get '/people/:id/edit' do
  @id = params[:id]
  sql = "select * from people where id = #{@id}"
  @person = run_sql(sql).first
  erb :edit_person
end

# edits specific person once form is filled out
post '/people/:id/edit' do
  name = params[:name]
  id = params[:id]
  sql = "update people set name='#{name}' where id = #{id}"
  run_sql(sql)
  redirect to "/people/#{id}"
end

# page for deleting a specific person
get '/people/:id/delete' do
  @id = params[:id]
  sql_person = "select * from people where id = #{@id}"
  @person = run_sql(sql_person).first
  sql_tasks = "select * from tasks where person = #{@id}"
  @tasks = run_sql(sql_tasks)
  erb :delete_person
end

# deletes specific person once form is filled out
post '/people/:id/delete' do
  id = params[:id]
  sql_tasks = "delete from tasks where person = #{id}"
  run_sql(sql_tasks)
  sql_person = "delete from people where id = #{id}"
  run_sql(sql_person)
  redirect to "/people"
end

# page with all tasks
get '/tasks' do
  sql_movies = 'select * from movies'
  @movies = run_sql(sql_movies)
  sql_tasks = 'select * from tasks'
  @tasks = run_sql(sql_tasks)
  erb :todos
end

# individual task page
get '/tasks/:id' do
  id = params[:id]
  sql_task = "select * from tasks where id = #{id}"
  @task = run_sql(sql_task).first
  sql_person = "select * from people where id = #{@task['person']}"
  @person = run_sql(sql_person).first['name']
  sql_movie = "select * from movies where id = #{@task['movie']}"
  @movie = run_sql(sql_movie).first['name']
  erb :todo
end

get '/add_task' do
  sql_movies = 'select * from movies'
  @movies = run_sql(sql_movies)
  sql_people = 'select * from people'
  @people = run_sql(sql_people)
  erb :add_task
end

post '/add_task' do
  name = params[:name]
  description = params[:description]
  done = params[:done]
  movie = params[:movie]
  person = params[:person]
  sql = "insert into tasks (name, description, done, movie, person) values ('#{name}', '#{description}', #{done}, #{movie}, #{person})"
  run_sql(sql)
  redirect to '/tasks'
end

get '/tasks/:id/edit' do
  id = params[:id]
  sql_task = "select * from tasks where id = #{id}"
  @task = run_sql(sql_task).first
  sql_person = "select * from people where id = #{@task['person']}"
  @person = run_sql(sql_person).first['name']
  sql_movie = "select * from movies where id = #{@task['movie']}"
  @movie = run_sql(sql_movie).first['name']
  erb :edit_task
end

post '/tasks/:id/edit' do
end

get '/tasks/:id/delete' do
  id = params[:id]
  sql_task = "select * from tasks where id = #{id}"
  @task = run_sql(sql_task).first
  sql_person = "select * from people where id = #{@task['person']}"
  @person = run_sql(sql_person).first['name']
  sql_movie = "select * from movies where id = #{@task['movie']}"
  @movie = run_sql(sql_movie).first['name']
  erb :delete_task
end

post '/tasks/:id/delete' do
  id = params[:id]
  sql = "delete from tasks where id = #{id}"
  run_sql(sql)
  redirect to "/tasks"
end