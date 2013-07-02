require 'rubygems'
require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require 'pg'
require 'rainbow'


  # instead of writing this in every get/post. We write it once and store it in a function.
  def run_sql(sql)
    db = PG.connect(:dbname => 'movie_production', :host => 'localhost')
  result = db.exec(sql)
  db.close
  result
  end

  get '/' do
    erb :index
  end
#_______________________________________________________________________________________________
  # list people
  get '/people' do
    sql = "SELECT * FROM people"
    @people = run_sql(sql)
    erb :people
end

  # input form to add a new person
  get'/people/new' do
    erb :add_new_person
  end

  # grab (new person) input from form & send to database
  post '/people/new' do
    name = params[:name]
    sql = "INSERT INTO people (name, title) VALUES ('#{name}', '#{title}')"
    run_sql(sql)
    redirect to('/people')
end

  # single person
  get '/people/:id' do
    @person = params[:id]
    sql = "SELECT * FROM people WHERE id ='#{@person}'"
    @person_details = run_sql(sql).first
    sql = "SELECT * FROM tasks where person_id ='#{@person}'"
    @tasks = run_sql(sql).first
    sql = "SELECT * FROM movies where person_id ='#{@person}'"
    @movies = run_sql(sql).first
    erb :person
  end

  # delete person
  post '/people/:id/delete' do
    @person_id = params[:id]
    sql = "DELETE FROM people where id = '#{@person_id}'"
    run_sql(sql)
    sql = "DELETE FROM movies where person_id = '#{@person_id}'"
    run_sql(sql)
    sql = "DELETE FROM tasks where person_id = '#{@person_id}'"
    run_sql(sql)
    redirect to('/people')
end

  # edit person
    get '/people/:id/edit' do
    @person_id = params[:id]
    sql = "SELECT * FROM people WHERE id='#{@person_id}'"
    @person_details = run_sql(sql).first
    erb :edit_person
end

    # grab (edit person) input from form & send to database
    post '/people/:id' do
    person_id = params[:id]
    name = params[:name]
    sql = "UPDATE people SET (name) = ('#{name}') WHERE id =#{person_id}"
    run_sql(sql)
    redirect to('/people')
end
#___________________________________________________________________________________________

    #list movies
    get '/movies' do
    sql = "SELECT * FROM movies"
    @movies = run_sql(sql)
    erb :movies
end
    # input form to add a new movie
    get '/movies/new' do
    sql = "SELECT * FROM people"
    @people = run_sql(sql)
    erb :add_new_movie
end
    # grab (new movie) input from form & send to database
    post '/movies/new' do
    name = params[:name]
    person_id = params[:person_id]
    sql = "INSERT INTO movies (name, person_id) VALUES ('#{name}', '#{person_id}')"
    run_sql(sql)
    redirect to('/movies')
end

    # single movie
    get '/movies/:id' do
    @movie_id = params[:id]
    sql = "SELECT * FROM movies WHERE id= '#{@movie_id}'"
    @movie_details = run_sql(sql).first
    sql = "SELECT * FROM tasks where movie_id ='#{@movie_id}'"
    @tasks = run_sql(sql).first
    erb :movie
end


    # delete movie
    post '/movies/:id/delete' do
    @movie_id = params[:id]
    sql = "DELETE FROM movies where id = '#{@movie_id}'"
    run_sql(sql)
    redirect to('/movies')
end

    # edit movie
    get '/movies/:id/edit' do
    @movie_id = params[:id]
    sql = "SELECT * FROM movies WHERE id='#{@movie_id}'"
    @movie_details = run_sql(sql).first
    sql = "SELECT * FROM people"
    @people = run_sql(sql)
    erb :edit_movie
end
    # grab (edit movie) input from form & send to database
    post '/movies/:id' do
    movie_id = params[:id]
    name = params[:name]
    person_id = params[:person_id]
    sql = "UPDATE movies SET (name, person_id) = ('#{name}', #{person_id}) WHERE id =#{movie_id}"
    run_sql(sql)
    redirect to('/movies')
end
#___________________________________________________________________________________________

    # list tasks
    get '/tasks' do
    sql = "SELECT * FROM tasks"
    @tasks = run_sql(sql)
    erb :tasks
end

    # input form to add a new task
    get '/tasks/new' do
    sql = "SELECT * FROM movies"
    @movies = run_sql(sql)
    sql = "SELECT * FROM people"
    @people = run_sql(sql)
    erb :add_new_task
end

    # grab (new task) input from form & send to database
    post '/tasks/new' do
    name = params[:name]
    due = params[:due]
    movie_id = params[:movie_id]
    person_id = params[:person_id]
    sql = "INSERT INTO tasks (name, due, movie_id, person_id) VALUES ('#{name}', '#{due}', #{movie_id}, #{person_id}) "
    run_sql(sql)
    redirect to('/tasks')
end

    # single task
    get '/tasks/:id' do
    @task_id = params[:id]
    sql = "SELECT * FROM tasks where id='#{@task_id}'"
    @task_details = run_sql(sql).first
    sql = "Select * FROM movies"
    @movie_details = run_sql(sql)
    erb :task
end
    # delete task
    post '/tasks/:id/delete' do
    @task_id = params[:id]
    sql = "DELETE FROM tasks where id = '#{@task_id}'"
    run_sql(sql)
    redirect to('/tasks')
end

    # edit task
    get '/tasks/:id/edit' do
    @task_id = params[:id]
    sql = "SELECT * FROM tasks WHERE id='#{@task_id}'"
    @task_details = run_sql(sql).first
    sql = "Select * FROM movies"
    @movie_details = run_sql(sql)
    sql = "SELECT * FROM people"
    @people = run_sql(sql)
    erb :edit_task
end

    # grab (edit movie) input from form & send to database
    post '/tasks/:id' do
    task_id = params[:id]
    name = params[:name]
    due = params[:due]
    movie_id = params[:movie_id]
    person_id = params[:person_id]
    sql = "UPDATE tasks SET (name, due, movie_id, person_id) = ('#{name}', '#{due}', #{movie_id}, #{person_id}) WHERE id =#{task_id}"
    run_sql(sql)
    redirect to('/tasks')
end
